Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF206E6A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjDRQo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjDRQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:44:17 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885FB46B9;
        Tue, 18 Apr 2023 09:44:15 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C2B92CA700;
        Tue, 18 Apr 2023 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681836224; bh=EZNvsJaGqI15hVmiKHgA/+7Bi1oXLhHkx00K1B0Jbu0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=x7CkWvNLVXqQP/qw7aGXRR6b5DyDgEIMGnw3chQf9kh2PBNObaGg6WwPfdTbuNNDQ
         DqwfyjR3JawYPHmu2WfV3qxRKF+QzvA8IHWzA6Xa11vNCkJdJA3uyKxJ4gYlJOvZRC
         8vVXMBgKmOCU6hBrdkDFEU61Jk9VSiICDJzZ+a7o=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 18 Apr 2023 18:43:20 +0200
Subject: [PATCH v2 4/8] leds: qcom-lpg: Add support for PMI632 LPG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v2-4-98bafa909c36@z3ntu.xyz>
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=EZNvsJaGqI15hVmiKHgA/+7Bi1oXLhHkx00K1B0Jbu0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkPsi5PovavgvOe36uGVHJ9jKT8cH/ZKTKo1/kQ
 pVLfgx/5H2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZD7IuQAKCRBy2EO4nU3X
 Vvn4EADV1UQr1t6ADhJU+xkF790x06twg+ISisFYA5kPrZRT+cArRKWl80LMlxLpYJurJ6ZqmN0
 bZ82Ej7RgNGhdQPCxzHrnQkMo1GCAnUuxfjPJOnf+AkHeQyRR/yThzvOLkW2btT3KEGPkihhvVA
 yvl6VmSGpkNiwLKAnws5Niqnq1I1wL7jGo+QRuOhSk7FlCgUAckdP4aeFqX3u3qx3zNj7BAkqp/
 DcjgJx0cu/m3emNy+JKrZbZNuVwOZ5EIsYpy0niCtcjho5kyoiYIqCQfWR11K1Wm+urPbGSm9G2
 tq/TrNJSgUUK3fawqte11AQWUqBpKWocITGCofrOS15kxwVnniMWYPZ45cNTd5M8o1SBaR+KqV/
 wJ7WdfgABIRpqco6zTMr5yLzQW4Ka7S/ywNKoOjIv962gZv6YZC4JohqO0b06LjyEuCeHkYiLWd
 s0fMmvXY7CyafClWWmKltPnrJlpbBwMLd/HBpmgdag2+OYN8iDtu3cOjQ27ubMeeHCIUgbqr4ia
 HqdVbb6ANHlIysbGik39Qr2kP0aVUlYbEcG9/ChLV4SHe2bbq5l/RMQnjZnTKHS7+nYVXesqDQc
 L1r7pVT0CdmgVL7YEheQdm9L9c8AecXHL+YMvkjFCGfWe2+hvmfShf3ZiYdqQVPWb+FqXbUTHX7
 ZaFEBx5Wg/UIetg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMI632 PMIC contains 5 PWM channels, 3 of which can be used for
LEDs.

For the LED pattern it doesn't have LUT like other PMICs but uses SDAM
instead. This is not currently implemented in the driver but since LPG
works fine without it, add support for the PMIC now.

Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 67f48f222109..51763ecb8c1e 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1353,6 +1353,20 @@ static const struct lpg_data pm8994_lpg_data = {
 	},
 };
 
+/* PMI632 uses SDAM instead of LUT for pattern */
+static const struct lpg_data pmi632_lpg_data = {
+	.triled_base = 0xd000,
+
+	.num_channels = 5,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xb300, .triled_mask = BIT(7) },
+		{ .base = 0xb400, .triled_mask = BIT(6) },
+		{ .base = 0xb500, .triled_mask = BIT(5) },
+		{ .base = 0xb600 },
+		{ .base = 0xb700 },
+	},
+};
+
 static const struct lpg_data pmi8994_lpg_data = {
 	.lut_base = 0xb000,
 	.lut_size = 24,
@@ -1436,6 +1450,7 @@ static const struct of_device_id lpg_of_table[] = {
 	{ .compatible = "qcom,pm8916-pwm", .data = &pm8916_pwm_data },
 	{ .compatible = "qcom,pm8941-lpg", .data = &pm8941_lpg_data },
 	{ .compatible = "qcom,pm8994-lpg", .data = &pm8994_lpg_data },
+	{ .compatible = "qcom,pmi632-lpg", .data = &pmi632_lpg_data },
 	{ .compatible = "qcom,pmi8994-lpg", .data = &pmi8994_lpg_data },
 	{ .compatible = "qcom,pmi8998-lpg", .data = &pmi8998_lpg_data },
 	{ .compatible = "qcom,pmc8180c-lpg", .data = &pm8150l_lpg_data },

-- 
2.40.0

