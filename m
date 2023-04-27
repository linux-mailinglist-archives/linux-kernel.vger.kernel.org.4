Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077AC6F0D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbjD0Ufs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344222AbjD0Ufp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:35:45 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2ED4EE2;
        Thu, 27 Apr 2023 13:35:24 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 89EF7CEB9B;
        Thu, 27 Apr 2023 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682627692; bh=6GdnfYGYIClKnqTCFJOePAiIDqCEBDJIJs44RnWeNMI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=BM38CsTAC+YX33G+87YR05wbDvYb23JPCjo0lqbtV17DCJDM8X8RZLaIMtxKcs9Rw
         WRz3Ta2BpFF5xlIpY/fivSlPJsRFxPyvvRMlIaqeZ5Mh0XCI7iApbWZ7JZlvbpicsy
         /nYoorwoxCBHxFAVGCQVCsuFY/Tz8r3PtF6uX3q4=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Thu, 27 Apr 2023 22:34:28 +0200
Subject: [PATCH 3/4] Input: pwm-vibra - add support for enable GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230427-hammerhead-vibra-v1-3-e87eeb94da51@z3ntu.xyz>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
In-Reply-To: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=6GdnfYGYIClKnqTCFJOePAiIDqCEBDJIJs44RnWeNMI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkStxqKLWCk5HSYfAn/q5yapUULHi+KQnW6QcqU
 51pZNACtoaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZErcagAKCRBy2EO4nU3X
 VkdDD/4/kj0m621vJLriUUkQ56LQdegmfkofZe7OHLc+QWGt81G53U5PdRd7p49dS0TDhooBOYM
 tNeg4wWAjcySxYfn7mIAVLLON9JPCdlO6s3SaG1ERe+T6JfmnjLWTnCN+vqP6kHZFM72KJCqjNC
 THlLjjVEC3QqBqiZyU7MDo9EDZ5ci0Dra8daI/7rGfJYhfK4Io3SU6nHpfQgSfGkjtZ2NelrWRQ
 qki789fAy4F7LTfNdGDwPixoaVSto3ILUAZisMl3+FnAhgTYOBbU/kZDc91A5sx1Qs/B4+AKryg
 7LJJLXhj+qxm/TaQH6Jt8XIG7Ci6u6oRCqZauWJbcF5aNlsbvYdzqUB2LWBS/brzmDAgvB1TyM0
 matK94MSkmy9RMwaTSLBTXwKoRMqF5/hDnAKuJkt/NkfSzcJHcY79sPGB8oP4XVRSAq+NEq6wPx
 AdbIAhQSo9IMtN8IL53gRMhFmez3YJK1dMpaNmWvHNDNQ5gbSQvFqc8MWo0XtaI4sP6/d1qsEzf
 X4Fx047lSEK0vcUQ7I9nrhMLXJNqTwx5XoQ/v83jE+DHhz+bjqZUyNMUEAr4e00KP9SP90G/+sP
 ilXtQZ3xVlSQ+/fpcuuSV8AMERYnuRXsPODnO9xwgy0uMenqby57VD3GOfxx0STzUd6klW8VLFV
 8zKb7kSFmESLnuA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pwm vibrators have a dedicated enable GPIO that needs to be set
high so that the vibrator works. Add support for that optionally.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/input/misc/pwm-vibra.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index c08971c97ad6..2ba035299db8 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -11,6 +11,7 @@
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/gpio/consumer.h>
 #include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -23,6 +24,7 @@
 
 struct pwm_vibrator {
 	struct input_dev *input;
+	struct gpio_desc *enable_gpio;
 	struct pwm_device *pwm;
 	struct pwm_device *pwm_dir;
 	struct regulator *vcc;
@@ -48,6 +50,8 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 		vibrator->vcc_on = true;
 	}
 
+	gpiod_set_value_cansleep(vibrator->enable_gpio, 1);
+
 	pwm_get_state(vibrator->pwm, &state);
 	pwm_set_relative_duty_cycle(&state, vibrator->level, 0xffff);
 	state.enabled = true;
@@ -80,6 +84,8 @@ static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
 		pwm_disable(vibrator->pwm_dir);
 	pwm_disable(vibrator->pwm);
 
+	gpiod_set_value_cansleep(vibrator->enable_gpio, 0);
+
 	if (vibrator->vcc_on) {
 		regulator_disable(vibrator->vcc);
 		vibrator->vcc_on = false;
@@ -142,6 +148,16 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	vibrator->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
+							GPIOD_OUT_LOW);
+	err = PTR_ERR_OR_ZERO(vibrator->enable_gpio);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to request enable gpio: %d\n",
+				err);
+		return err;
+	}
+
 	vibrator->pwm = devm_pwm_get(&pdev->dev, "enable");
 	err = PTR_ERR_OR_ZERO(vibrator->pwm);
 	if (err) {

-- 
2.40.0

