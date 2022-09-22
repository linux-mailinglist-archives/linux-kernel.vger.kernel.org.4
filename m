Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B985E6499
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiIVOCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiIVOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:01:57 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624B352464;
        Thu, 22 Sep 2022 07:01:55 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 40AC0201349;
        Thu, 22 Sep 2022 14:01:53 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id DF826806F2; Thu, 22 Sep 2022 15:59:31 +0200 (CEST)
Date:   Thu, 22 Sep 2022 15:59:31 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] hw_random: core: start hwrng kthread also for untrusted
 sources
Message-ID: <YyxqQwsnIab/eunL@owl.dominikbrodowski.net>
References: <CAHmME9oVKzJtAaBmtrrUT1n2f0_41wu2VF295ONKV3WUotbYxw@mail.gmail.com>
 <20220920142159.2789273-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920142159.2789273-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start the hwrng kthread even if the hwrng source has a quality setting
of zero. Then, every crng reseed interval, one batch of data from this
zero-quality hwrng source will be mixed into the CRNG pool.

This patch is based on the assumption that data from a hwrng source
will not actively harm the CRNG state. Instead, many hwrng sources
(such as TPM devices), even though they are assigend a quality level of
zero, actually provide some entropy, which is good enough to mix into
the CRNG pool every once in a while.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
Thanks to Jason for splitting my v1 into two parts, as per Herbert's
request. In comparison to v2, I've updated (and shortened) the commit
message.

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 16f227b995e8..edb86c0cccda 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -52,7 +52,7 @@ MODULE_PARM_DESC(default_quality,
 
 static void drop_current_rng(void);
 static int hwrng_init(struct hwrng *rng);
-static void hwrng_manage_rngd(struct hwrng *rng);
+static int hwrng_fillfn(void *unused);
 
 static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 			       int wait);
@@ -96,6 +96,15 @@ static int set_current_rng(struct hwrng *rng)
 	drop_current_rng();
 	current_rng = rng;
 
+	/* if necessary, start hwrng thread */
+	if (!hwrng_fill) {
+		hwrng_fill = kthread_run(hwrng_fillfn, NULL, "hwrng");
+		if (IS_ERR(hwrng_fill)) {
+			pr_err("hwrng_fill thread creation failed\n");
+			hwrng_fill = NULL;
+		}
+	}
+
 	return 0;
 }
 
@@ -167,8 +176,6 @@ static int hwrng_init(struct hwrng *rng)
 		rng->quality = 1024;
 	current_quality = rng->quality; /* obsolete */
 
-	hwrng_manage_rngd(rng);
-
 	return 0;
 }
 
@@ -454,10 +461,6 @@ static ssize_t rng_quality_store(struct device *dev,
 	/* the best available RNG may have changed */
 	ret = enable_best_rng();
 
-	/* start/stop rngd if necessary */
-	if (current_rng)
-		hwrng_manage_rngd(current_rng);
-
 out:
 	mutex_unlock(&rng_mutex);
 	return ret ? ret : len;
@@ -509,9 +512,6 @@ static int hwrng_fillfn(void *unused)
 		mutex_unlock(&reading_mutex);
 		put_rng(rng);
 
-		if (!quality)
-			break;
-
 		if (rc <= 0) {
 			pr_warn("hwrng: no data available\n");
 			msleep_interruptible(10000);
@@ -533,22 +533,6 @@ static int hwrng_fillfn(void *unused)
 	return 0;
 }
 
-static void hwrng_manage_rngd(struct hwrng *rng)
-{
-	if (WARN_ON(!mutex_is_locked(&rng_mutex)))
-		return;
-
-	if (rng->quality == 0 && hwrng_fill)
-		kthread_stop(hwrng_fill);
-	if (rng->quality > 0 && !hwrng_fill) {
-		hwrng_fill = kthread_run(hwrng_fillfn, NULL, "hwrng");
-		if (IS_ERR(hwrng_fill)) {
-			pr_err("hwrng_fill thread creation failed\n");
-			hwrng_fill = NULL;
-		}
-	}
-}
-
 int hwrng_register(struct hwrng *rng)
 {
 	int err = -EINVAL;
