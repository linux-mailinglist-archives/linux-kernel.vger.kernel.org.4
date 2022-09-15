Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D015B919A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIOAXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIOAXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:23:01 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5212F80B68
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:23:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id cj27so311259qtb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=eRiMKscQqGLWHiLc+7+i9xWjQkO+eAs1NiZ4jOvGS0U=;
        b=DDKycVVoBoWbCM3nQMDQEe8g1JNrOsjXVyfZHCebseS4+afsgAkQYMIPCaGK1izdDM
         jObnH0Dtsq8TtMdYHeoe8jd1zKZZhyuyg1q9B5mKnPFlbJJRuorQ+GIhMZ0dQtXWu7TW
         j9Ta3r8XkKQ5zPasxQulLbgCtgRgUSGETaydY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eRiMKscQqGLWHiLc+7+i9xWjQkO+eAs1NiZ4jOvGS0U=;
        b=rmkxKMRG8MEwVwXCThEuecPD12nNk4X+zkgoFvn8B4qvt9xkmCiDfi6msmeYLQkj/V
         6Myya4vn3D0psucJwZa/UEli7boNVMimfg39Rf42lxxsQNU7bXay//3SdLQbJhB9UvGH
         q6jhbTclgBVyHo+FFZvJkfkpQ+bnY/xg3vvjCBnBC1zmnC7fhZkQ4LnjzVplg8nSqhG6
         J+q6FLQ5tzRRyzHdUut4xkcqhIdnb7rOt651A5OBtRKysHdnywi5WuCkYBuu2tPbsPwt
         RenLF7y/oR26+zy4SXNePSIZutKp+sWIgz2V4/pD2AbNJFOGTk0Uamy8zqozVPskgv1i
         WYdw==
X-Gm-Message-State: ACgBeo1SbfynDguNn0LWg4TRaXCVLY35q1z19cqUcXDJtDvGWeAZVnpn
        SUCpNZCwUO//8bmGwr0vuPBrCvK+97gV3g==
X-Google-Smtp-Source: AA6agR5n0qg3MJMUDrj6cUWrw4bfwjRO+f7dxAy+UMb7nJNVnhtqjMVgK7ybK2zcEHxqmw36epXNPg==
X-Received: by 2002:a05:622a:38f:b0:35b:b8e7:82ef with SMTP id j15-20020a05622a038f00b0035bb8e782efmr13021242qtx.647.1663201379203;
        Wed, 14 Sep 2022 17:22:59 -0700 (PDT)
Received: from trappist.c.googlers.com.com (128.174.85.34.bc.googleusercontent.com. [34.85.174.128])
        by smtp.gmail.com with ESMTPSA id m5-20020ac86885000000b0034367ec57ecsm2377611qtq.9.2022.09.14.17.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:22:58 -0700 (PDT)
From:   Sven van Ashbrook <svenva@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Olivia Mackall <olivia@selenic.com>
Cc:     Alex Levin <levinale@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Rajat Jain <rajatja@google.com>,
        Sven van Ashbrook <svenva@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>, linux-crypto@vger.kernel.org
Subject: [PATCH v2 1/2] random: move add_hwgenerator_randomness()'s wait outside function
Date:   Thu, 15 Sep 2022 00:22:53 +0000
Message-Id: <20220915002235.v2.1.I7c0a79e9b3c52584f5b637fde5f1d6f807605806@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add_hwgenerator_randomness() currently blocks until more entropy
is needed. Move the blocking wait out of the function to the caller,
by letting the function return the number of jiffies needed to block.

This is done to prepare the function's sole kernel caller from a
kthread to self-rearming delayed_work.

Signed-off-by: Sven van Ashbrook <svenva@chromium.org>
---

Changes in v2:
- justify patch as a preparation for next patch

 drivers/char/hw_random/core.c |  7 +++++--
 drivers/char/random.c         | 13 ++++++-------
 include/linux/random.h        |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 16f227b995e8..3675122c6cce 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -491,6 +491,7 @@ static int __init register_miscdev(void)
 static int hwrng_fillfn(void *unused)
 {
 	size_t entropy, entropy_credit = 0; /* in 1/1024 of a bit */
+	unsigned long delay;
 	long rc;
 
 	while (!kthread_should_stop()) {
@@ -526,8 +527,10 @@ static int hwrng_fillfn(void *unused)
 			entropy_credit = entropy;
 
 		/* Outside lock, sure, but y'know: randomness. */
-		add_hwgenerator_randomness((void *)rng_fillbuf, rc,
-					   entropy >> 10);
+		delay = add_hwgenerator_randomness((void *)rng_fillbuf, rc,
+						   entropy >> 10);
+		if (delay > 0)
+			schedule_timeout_interruptible(delay);
 	}
 	hwrng_fill = NULL;
 	return 0;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 79d7d4e4e582..5dc949298f92 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -686,7 +686,7 @@ static void __cold _credit_init_bits(size_t bits)
  * the above entropy accumulation routines:
  *
  *	void add_device_randomness(const void *buf, size_t len);
- *	void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy);
+ *	unsigned long add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy);
  *	void add_bootloader_randomness(const void *buf, size_t len);
  *	void add_vmfork_randomness(const void *unique_vm_id, size_t len);
  *	void add_interrupt_randomness(int irq);
@@ -702,8 +702,8 @@ static void __cold _credit_init_bits(size_t bits)
  * available to them (particularly common in the embedded world).
  *
  * add_hwgenerator_randomness() is for true hardware RNGs, and will credit
- * entropy as specified by the caller. If the entropy pool is full it will
- * block until more entropy is needed.
+ * entropy as specified by the caller. Returns time delay in jiffies until
+ * more entropy is needed.
  *
  * add_bootloader_randomness() is called by bootloader drivers, such as EFI
  * and device tree, and credits its input depending on whether or not the
@@ -857,10 +857,10 @@ EXPORT_SYMBOL(add_device_randomness);
 
 /*
  * Interface for in-kernel drivers of true hardware RNGs.
- * Those devices may produce endless random bits and will be throttled
+ * Those devices may produce endless random bits and should be throttled
  * when our pool is full.
  */
-void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
+unsigned long add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
 {
 	mix_pool_bytes(buf, len);
 	credit_init_bits(entropy);
@@ -869,8 +869,7 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
 	 * Throttle writing to once every CRNG_RESEED_INTERVAL, unless
 	 * we're not yet initialized.
 	 */
-	if (!kthread_should_stop() && crng_ready())
-		schedule_timeout_interruptible(CRNG_RESEED_INTERVAL);
+	return crng_ready() ? CRNG_RESEED_INTERVAL : 0;
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
 
diff --git a/include/linux/random.h b/include/linux/random.h
index 3fec206487f6..6608b0fb4402 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -17,7 +17,7 @@ void __init add_bootloader_randomness(const void *buf, size_t len);
 void add_input_randomness(unsigned int type, unsigned int code,
 			  unsigned int value) __latent_entropy;
 void add_interrupt_randomness(int irq) __latent_entropy;
-void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy);
+unsigned long add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy);
 
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 static inline void add_latent_entropy(void)
-- 
2.37.2.789.g6183377224-goog

