Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52FB672218
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjARPvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjARPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:50:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DBF37560
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:48:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIAfp-0000BQ-6x; Wed, 18 Jan 2023 16:48:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIAfn-006wQA-IB; Wed, 18 Jan 2023 16:48:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIAfm-00Du2j-QY; Wed, 18 Jan 2023 16:48:22 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pwm: ab8500: Implement .get_state()
Date:   Wed, 18 Jan 2023 16:48:17 +0100
Message-Id: <20230118154817.97364-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118154817.97364-1-u.kleine-koenig@pengutronix.de>
References: <20230118154817.97364-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zxnIw4Yr3zcVxG9RWWa5ye05fAxtUhJvHGVcr9cfwwE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjyBS7Ta3fjxux5RkOIIOD6BE/M7M4YWrdVu8d/qYB gK2Y1M6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY8gUuwAKCRDB/BR4rcrsCTHHB/ 0ebCu6vDEVcGWsOdh8fFzAiw+CzOjfIodzvI2DTa+fd+2DnlO467h4KJQacMusdY8RV/X/TFskJS/0 XEACMzMQibuf0+hM7Fid92inJ0fyoAj6mLLhCuJ0TLRZB1s2JTUBPHUf4tki+S4FRCAV0uGc8nGlwy 84Nz+TNbdiCc4GQI1nFVOG8evM+6P3f3sb5CqWAkAZqzd4rQy8A5Z3RJf9HSAQy9mspFxPaexGuMn5 Tvl/pmF/jCltqA4rC1hetm5Qlv4YOz9/wEmrnDJmt5RH8PRQUXlJvSMbhDbpZg0SxBZRn/pUM8rOC2 QarfjzrkYntwtRzLIVAHX8l0pJXL99
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The registers are readable, so it's possible to implement the
.get_state() callback for this PWM.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index c5239eef3b8f..507ff0d5f7bd 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -136,8 +136,51 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
+static int ab8500_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	u8 ctrl7, lower_val, higher_val;
+	int ret;
+	struct ab8500_pwm_chip *ab8500 = ab8500_pwm_from_chip(chip);
+	unsigned int div, duty_steps;
+
+	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+						AB8500_PWM_OUT_CTRL7_REG,
+						&ctrl7);
+	if (ret)
+		return ret;
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	if (!(ctrl7 & 1 << ab8500->hwid)) {
+		state->enabled = false;
+		return 0;
+	}
+
+	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+						AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2),
+						&lower_val);
+	if (ret)
+		return ret;
+
+	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+						AB8500_PWM_OUT_CTRL2_REG + (ab8500->hwid * 2),
+						&higher_val);
+	if (ret)
+		return ret;
+
+	div = 32 - ((higher_val & 0xf0) >> 4);
+	duty_steps = ((higher_val & 3) << 8 | lower_val) + 1;
+
+	state->period = DIV64_U64_ROUND_UP((u64)div << 10, AB8500_PWM_CLKRATE);
+	state->duty_cycle = DIV64_U64_ROUND_UP((u64)div * duty_steps, AB8500_PWM_CLKRATE);
+
+	return 0;
+}
+
 static const struct pwm_ops ab8500_pwm_ops = {
 	.apply = ab8500_pwm_apply,
+	.get_state = ab8500_pwm_get_state,
 	.owner = THIS_MODULE,
 };
 
-- 
2.39.0

