Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1519C6E1805
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjDMXST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDMXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:18:17 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C908BE1;
        Thu, 13 Apr 2023 16:18:15 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 24979D0C50;
        Thu, 13 Apr 2023 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681427894; bh=4Q57cOxz+lYlEwmm+I38ufedAPx45aCnfTXWfnz7tmk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=f7MmPelu/Wcs3poFCFUUu097g5/9nFwaDFVTgboDcju6vZdRrKVGG9m9gJnjgvbeZ
         uJPFt2bPIJd4j9eMdhzrZT+ic2amVkoK8G73P9taVa3Ltab9jLJaNKlZE2YNa/esEe
         JUxPDoOyOYgox8zDypDP7fbzGlTENRL9DdA+Cx90=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 14 Apr 2023 01:17:48 +0200
Subject: [PATCH 4/8] leds: qcom-lpg: Add support for PMI632 LPG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v1-4-fe94dc414832@z3ntu.xyz>
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
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
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=4Q57cOxz+lYlEwmm+I38ufedAPx45aCnfTXWfnz7tmk=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkOI2w4ji/JSdN8pwMAx9rdvdxYBMkGFfcSN6T+
 RbXbb6fs16JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZDiNsAAKCRBy2EO4nU3X
 Vu5xEACAExu0wzlBGq2iCUgTIGmn2DnQNk7ea59TuiJ2A0KhXIDascR0hbVtdKLJbEV1YNR813D
 FcuEOBioCmY+yMNpnm0RvBnbM1GMQH98Q4vCyxc79RD5itEFQAMmezyjlrohgBRXctoZxFrc9K4
 FxWyf267gY2rOYEmplFo6bUD+qNfnzDySEV1K0a/6Y/RLHzt8vh7YwS7I7R/6O5xY6m+eiYDxSE
 VGsNAfd965WGdmXhCrrAI/VmrC6A7gwgKs01Xm7f4qulWROck+O6UwIi/AqD8DnO6AYvD9bYoGV
 rnf3J7ZvymqNX2ab21zlEZFNAoB18i4Ni57gV28Wijfaif1CFTeLM2NCX3zYYImtnlzGxwZkBKB
 ZTaclMDPVEgYHAkMVVHPwm0skb5Wu8r6yd4gaRhPbqJnwO31CKqyp5K36tONqEcKKgo1E9TofiE
 +FsHqY4QhoF1hw6OoPW9UguFDekvst6yR55tpGhfShND4HHTGgQqKtUr/MuD2x8sYUYq3+TCPxa
 rDNXprHv9j9gvem0nggjUiMcq6fidHdXdE6ReBdk6AwK+hn3MMWQgBT3k1tXN2uIS637eCWwv8n
 1S8rlmTTXLn/C7qilIcv9VNkEHSgiQr73X3s5vXgxyjc1kxUU8RRttmujZuH1UqPOlxdNa2Tbzf
 EJPEzySAQu1fyQQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

