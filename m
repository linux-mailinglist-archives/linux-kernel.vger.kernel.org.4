Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC9A5BE8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiITOX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiITOW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9107114F;
        Tue, 20 Sep 2022 07:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E0A6204E;
        Tue, 20 Sep 2022 14:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A589C433C1;
        Tue, 20 Sep 2022 14:22:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FZM0OIwl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663683728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+ZVLXNwMQLj98jQUIy8vNDdNdZFn00bcgnHSwsb/0A=;
        b=FZM0OIwlLNOpOWCFt8h0wMk0xFYePotuoisp2SoxMPJhe14nbCy4FgGKzoF8fHKp9YaURK
        g22ePrwkHHF9lDg1DnOelZuqDLmo0p+WcDBTfSPp1QVVdNphx2VLbnERR8mBGKTdRJN0Qv
        2uNfrTLRJakVfP/84urCaGSXL067rIM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f3392bc0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 20 Sep 2022 14:22:07 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v2] hw_random: core: start hwrng kthread also for untrusted sources
Date:   Tue, 20 Sep 2022 16:21:59 +0200
Message-Id: <20220920142159.2789273-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9oVKzJtAaBmtrrUT1n2f0_41wu2VF295ONKV3WUotbYxw@mail.gmail.com>
References: <CAHmME9oVKzJtAaBmtrrUT1n2f0_41wu2VF295ONKV3WUotbYxw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Brodowski <linux@dominikbrodowski.net>

Start the hwrng kthread even if the hwrng source has a quality setting
of zero. Then, every CRNG_RESEED_INTERVAL, one batch of data from this
zero-quality hwrng source will be mixed into the CRNG pool.

However, to avoid that an untrusted device assists in initializing the
CRNG, go to sleep in add_hwgenerator_randomness() in case the entropy
parameter passed to that function is zero.

This patch is based on the assumption that data from a hwrng source
will not actively harm the CRNG state, but that many hwrng sources
(such as TPM devices), even though they are assigend a quality level of
zero, actually provide some entropy, which is good to mix into the CRNG
pool every once in a while.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
This is Dominik's v1, verbatim, with the random.c changes split out, per
Herbert's request.

(It'd be nice if this would land soon, as there are other nice things
that could be layered on top of this change later.)

 drivers/char/hw_random/core.c | 36 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

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
-- 
2.37.3

