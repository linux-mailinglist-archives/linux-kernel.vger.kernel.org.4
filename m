Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247EA722665
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjFEMxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjFEMxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:53:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618ABDB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:53:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30af159b433so4811968f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685969585; x=1688561585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XPyqgMjhtaeTJwO3ElYWGhUyN9nDJ0IyOHMrhcL0ADA=;
        b=vWSePFvXUdh4wd62uuTGsxHWNdTuoPIsZ+S+73WqxWKosGjwD9ULn9hVkhxZfkMlup
         Ll1kFQw2FdTnujfyPaAH5gm4n6uTsPAgmnkmgyNL/5PdofRVQKqFmB8vHpJFp+k8VWOO
         VK5izkQ6DdbM2cbx3o8ziAGvv0CPRIyFfjAGMbGhQj8D+8saAEKMct1z23YHbc9JGt05
         45aXFO6dfcJ3RQCQ3dzrdJvDYkOkppl2v1iYGw6aXy3MvdXTzqpnWGLQAFJzThs7OcXD
         wWov3wZmPoTG85eBooFprBpDkADzSG2ZW49X+VDxTfQW5DFU0T79upECf8Szj5zVfpyF
         irtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685969585; x=1688561585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPyqgMjhtaeTJwO3ElYWGhUyN9nDJ0IyOHMrhcL0ADA=;
        b=IEseMLZ0OKmTlcxma4G59s0vBEBBKiOvlavKeh1bD6tDLrgoTfNo7C3KijvdmT9MBp
         WZA3uJSfmsMiSqymrDZvWMwjk3NsdJSKI/0nUWe9tLKERCnfjHU0dWrPB/0Ucfe8xhhK
         E//cI6vm8b2FNy7bhCKCoc96OVM1sTTsemIh3a5cm2vfaoFbgFzC7Hal5pxMntXGCuPI
         3AEC3Y7xCnqaabsZaar+VFOaRy6ZGY4kyl0squKbiugPyvLit9cZDZDf20EgOArBngoi
         KuORlLBLz8N0VZZkrbY7LsTnSuKVuAZUGqOF8/qZl3E6J0XaXI28UJefs8Yqr0KPQwEf
         4Rbw==
X-Gm-Message-State: AC+VfDyJY45XPrH9NkbtQdqt9PtwnmBUfTwjU9LpnCsfX0zHcPdtJOXL
        ipzGh9FsvpcqjY/YUZV6/Six8RFQjrxzHWuRCLc=
X-Google-Smtp-Source: ACHHUZ4sxQ43NnTMNOrI+9A99Zw1EFcrGnWgXoD4coDyXUsiBSDwhgLMGnbIgxrEeGuPDLVCerh14w==
X-Received: by 2002:a5d:5488:0:b0:306:2de6:6f9b with SMTP id h8-20020a5d5488000000b003062de66f9bmr6433627wrv.58.1685969584788;
        Mon, 05 Jun 2023 05:53:04 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b467:b060:6671:840c])
        by smtp.gmail.com with ESMTPSA id q22-20020a056000137600b0030aee3da084sm9740286wrz.49.2023.06.05.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:53:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: demote the hogging log messages to debug
Date:   Mon,  5 Jun 2023 14:52:48 +0200
Message-Id: <20230605125248.279921-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Drivers should be silent when they work correctly. There's no reason to
emit info messages when GPIO lines are hogged. Demote the message to
debug.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Suggested-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib.c |  2 +-
 drivers/of/unittest.c  | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a7220e04a93e..e4515bda8915 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4243,7 +4243,7 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 	/* Mark GPIO as hogged so it can be identified and removed later */
 	set_bit(FLAG_IS_HOGGED, &desc->flags);
 
-	gpiod_info(desc, "hogged as %s%s\n",
+	gpiod_dbg(desc, "hogged as %s%s\n",
 		(dflags & GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input",
 		(dflags & GPIOD_FLAGS_BIT_DIR_OUT) ?
 		  (dflags & GPIOD_FLAGS_BIT_DIR_VAL) ? "/high" : "/low" : "");
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 2191c0136531..0060334a98a7 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1849,19 +1849,19 @@ static void __init of_unittest_overlay_gpio(void)
 	 * driver is registered
 	 */
 
-	EXPECT_BEGIN(KERN_INFO,
+	EXPECT_BEGIN(KERN_DEBUG,
 		     "gpio-<<int>> (line-B-input): hogged as input\n");
 
-	EXPECT_BEGIN(KERN_INFO,
+	EXPECT_BEGIN(KERN_DEBUG,
 		     "gpio-<<int>> (line-A-input): hogged as input\n");
 
 	ret = platform_driver_register(&unittest_gpio_driver);
 	if (unittest(ret == 0, "could not register unittest gpio driver\n"))
 		return;
 
-	EXPECT_END(KERN_INFO,
+	EXPECT_END(KERN_DEBUG,
 		   "gpio-<<int>> (line-A-input): hogged as input\n");
-	EXPECT_END(KERN_INFO,
+	EXPECT_END(KERN_DEBUG,
 		   "gpio-<<int>> (line-B-input): hogged as input\n");
 
 	unittest(probe_pass_count + 2 == unittest_gpio_probe_pass_count,
@@ -1888,7 +1888,7 @@ static void __init of_unittest_overlay_gpio(void)
 	probe_pass_count = unittest_gpio_probe_pass_count;
 	chip_request_count = unittest_gpio_chip_request_count;
 
-	EXPECT_BEGIN(KERN_INFO,
+	EXPECT_BEGIN(KERN_DEBUG,
 		     "gpio-<<int>> (line-D-input): hogged as input\n");
 
 	/* overlay_gpio_03 contains gpio node and child gpio hog node */
@@ -1896,7 +1896,7 @@ static void __init of_unittest_overlay_gpio(void)
 	unittest(overlay_data_apply("overlay_gpio_03", NULL),
 		 "Adding overlay 'overlay_gpio_03' failed\n");
 
-	EXPECT_END(KERN_INFO,
+	EXPECT_END(KERN_DEBUG,
 		   "gpio-<<int>> (line-D-input): hogged as input\n");
 
 	unittest(probe_pass_count + 1 == unittest_gpio_probe_pass_count,
@@ -1935,7 +1935,7 @@ static void __init of_unittest_overlay_gpio(void)
 	 *   - processing gpio for overlay_gpio_04b
 	 */
 
-	EXPECT_BEGIN(KERN_INFO,
+	EXPECT_BEGIN(KERN_DEBUG,
 		     "gpio-<<int>> (line-C-input): hogged as input\n");
 
 	/* overlay_gpio_04b contains child gpio hog node */
@@ -1943,7 +1943,7 @@ static void __init of_unittest_overlay_gpio(void)
 	unittest(overlay_data_apply("overlay_gpio_04b", NULL),
 		 "Adding overlay 'overlay_gpio_04b' failed\n");
 
-	EXPECT_END(KERN_INFO,
+	EXPECT_END(KERN_DEBUG,
 		   "gpio-<<int>> (line-C-input): hogged as input\n");
 
 	unittest(chip_request_count + 1 == unittest_gpio_chip_request_count,
-- 
2.39.2

