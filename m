Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A656F2A43
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjD3SVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 14:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjD3SVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 14:21:35 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9171735;
        Sun, 30 Apr 2023 11:21:34 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 941D2CEC7B;
        Sun, 30 Apr 2023 18:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682878892; bh=EZ5Rl1sRU/1EQS0k2DDIMWm8qZwGVK/duzJDHMh9kC0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=WADf2dd18dVdmfXoeHoeYASPOfcjoNL2GBf3mbQUfOU6BIZ/kmc/M8kK9eLNy3CLx
         UrCklO1iH3o8nHiD2xJ3WRG0rbwfsr8ewLdjiEe6ztucoMkjpM6bZx3YAKUn6s4aXN
         c8ZkDtbsw6q6tAZ3Vw37jitXWwig+OciR7oNxMJk=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 30 Apr 2023 20:20:56 +0200
Subject: [PATCH 4/5] Input: drv260x - fix magnitude handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230430-drv260x-improvements-v1-4-1fb28b4cc698@z3ntu.xyz>
References: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
In-Reply-To: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3279; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=EZ5Rl1sRU/1EQS0k2DDIMWm8qZwGVK/duzJDHMh9kC0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkTrGpFTH1r2XTDSQoOggy0k37nDYdgmhMHY8io
 +kbTgYBwjWJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZE6xqQAKCRBy2EO4nU3X
 Vp7uD/wP8XraDh/XqKDzUTo1JaxFCo/o8Q3S3iSlvep48xHb2HU2/AHSnJNlT/6osYanqta5V4P
 fRJR3QKt2BzYtBPwyBvaJxyrlG0lG5b4Kzpm3TY/PPzVVcWYj+uF1GauyAB2OJOLL/UU9I4/HjF
 g0FCNKtEUL2oQkGazD323lcD9gRwhijP6625vM3Xrqan/MihHkH/k22gt2rRfsk9iTctXTNfxH2
 Q/i9gJwayvQUVD1uIfMw0glbEwjpcxVOpn1w9/rqeE2OstoS96cwkxkQUeOenFRbO1H0wmYRR2m
 ruTlRgNZwViC4fNKPfqJqcI5WounrCo3V5BGJOY3Xdv1FIXuuoZeImdCimK5Hr9uZTNDvcFeK66
 VnNDGzyZ/41cklfT4S8h56w4OTOsPG7sScUwI+WAF9sZbemdigPBtf1/LwArRxgM7l/vbOo5O5f
 fCeKFK8MWlIliML/I/xqiFpAoA6pZ8QZ5cCOpsYHvfrK6gKNsrkAIKC4fyHVlBS+4wjZDBSs6Mz
 DvmWTb+3mYuAmm0Y9WVFUI5vPMXizhJjGgeMlzXAayzxt/c751kTME6seR/0oLc/yeLJAjLGwt0
 uOQwoHptjTivwZX3b/IIylq1MDPzYLS5zJNLygRurNoIZ1Vj5oKPhmPmw6x/r9WovWGKWBe5UNG
 TdilpRwndiil81w==
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

First of all, previously the 16-bit magnitude was written as-is to the
device which actually discarded the upper 8 bits since the device has
8-bit registers only. This meant that a strong_magnitude of 0xFF00 would
result in 0. To correct this shift the strong_magnitude / weak_magnitude
input values so we discard the lower 8 bits and keep the upper bits
instead.

Secondly the RTP mode that is used by default interprets the values as
signed (2s complement), so 0x81 = 0%, 0x00 = 50%, 0x7F = 100%. This
doesn't match the FF_RUMBLE interface at all, so let's tell the device
to interpret the data as unsigned instead which gets us 0x00 = 0% and
0xFF = 100%.

As last change switch ERM to using "Closed-Loop Mode, Unidirectional"
instead of "Open-Loop Mode" since it's recommended by the datasheet
compared to open loop and better matches our use case of 0% - 100%
vibration.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/input/misc/drv260x.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index a7e3120bdc13..f5e96b36acda 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -186,7 +186,7 @@ struct drv260x_data {
 	struct work_struct work;
 	struct gpio_desc *enable_gpio;
 	struct regulator *regulator;
-	u32 magnitude;
+	u8 magnitude;
 	u32 mode;
 	u32 library;
 	int rated_voltage;
@@ -237,10 +237,11 @@ static int drv260x_haptics_play(struct input_dev *input, void *data,
 
 	haptics->mode = DRV260X_LRA_NO_CAL_MODE;
 
+	/* Scale u16 magnitude into u8 register value */
 	if (effect->u.rumble.strong_magnitude > 0)
-		haptics->magnitude = effect->u.rumble.strong_magnitude;
+		haptics->magnitude = effect->u.rumble.strong_magnitude >> 8;
 	else if (effect->u.rumble.weak_magnitude > 0)
-		haptics->magnitude = effect->u.rumble.weak_magnitude;
+		haptics->magnitude = effect->u.rumble.weak_magnitude >> 8;
 	else
 		haptics->magnitude = 0;
 
@@ -266,7 +267,7 @@ static void drv260x_close(struct input_dev *input)
 
 static const struct reg_sequence drv260x_lra_cal_regs[] = {
 	{ DRV260X_MODE, DRV260X_AUTO_CAL },
-	{ DRV260X_CTRL3, DRV260X_NG_THRESH_2 },
+	{ DRV260X_CTRL3, DRV260X_NG_THRESH_2 | DRV260X_RTP_UNSIGNED_DATA },
 	{ DRV260X_FEEDBACK_CTRL, DRV260X_FB_REG_LRA_MODE |
 		DRV260X_BRAKE_FACTOR_4X | DRV260X_LOOP_GAIN_HIGH },
 };
@@ -284,7 +285,7 @@ static const struct reg_sequence drv260x_lra_init_regs[] = {
 		DRV260X_BEMF_GAIN_3 },
 	{ DRV260X_CTRL1, DRV260X_STARTUP_BOOST },
 	{ DRV260X_CTRL2, DRV260X_SAMP_TIME_250 },
-	{ DRV260X_CTRL3, DRV260X_NG_THRESH_2 | DRV260X_ANALOG_IN },
+	{ DRV260X_CTRL3, DRV260X_NG_THRESH_2 | DRV260X_RTP_UNSIGNED_DATA | DRV260X_ANALOG_IN },
 	{ DRV260X_CTRL4, DRV260X_AUTOCAL_TIME_500MS },
 };
 
@@ -299,7 +300,7 @@ static const struct reg_sequence drv260x_erm_cal_regs[] = {
 	{ DRV260X_CTRL1, DRV260X_STARTUP_BOOST },
 	{ DRV260X_CTRL2, DRV260X_SAMP_TIME_250 | DRV260X_BLANK_TIME_75 |
 		DRV260X_IDISS_TIME_75 },
-	{ DRV260X_CTRL3, DRV260X_NG_THRESH_2 | DRV260X_ERM_OPEN_LOOP },
+	{ DRV260X_CTRL3, DRV260X_NG_THRESH_2 | DRV260X_RTP_UNSIGNED_DATA },
 	{ DRV260X_CTRL4, DRV260X_AUTOCAL_TIME_500MS },
 };
 

-- 
2.40.1

