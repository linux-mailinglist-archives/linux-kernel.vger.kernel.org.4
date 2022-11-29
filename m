Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7181263C461
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiK2P6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbiK2P5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:57:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC82554DC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m19so2115834wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI9uwBLCvWR3OgOlMBN6oypd3UQ7AbJ0Dp0NjT4lxFo=;
        b=q5AMfXNq+uEIyJlBR4JMMkREhMsydwCzKt+PI6ZOWnuCDxDC46sM+LhYOuqjwz3EnD
         MvIvJWH0uX5OqoygLr59MVBrhBGn4zxNvOBAmGOxJCWtvSlfFyAbKjzocozW2irPiXj6
         R137SUWyTFtJnCd79bN+9OmhsWSWnsZ6V3zvd4pHkctIuP/JE3QjpnroKOi/jLUBKLWE
         TlK7K35lzOrtnX9XMPQ4vA2AWzPUfT0sgc4WuV/SBrB/XQ5eHfuyi2B2If8p7yqJHTwY
         qwIRtHF1onChLN7ImTbtjmWCDrVMyCzrh4sRT368ZeiOC2wxS7ftcqYQQ8VoEisKtkOL
         6EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI9uwBLCvWR3OgOlMBN6oypd3UQ7AbJ0Dp0NjT4lxFo=;
        b=VDUk1M/piM9wEVWTGeqUZ05J9EMu61qxfQgVUmdLjAYG2OmCWrGE1AEB4SkTPPkUQH
         ai2Ipz18OKAOqmTvSIAYQSllJ5ESvgwnWTvrFJdmGigTsC5BERd1EotLWo/gFXj5EVZx
         RJpOjNCUAFLo2edBKszCCdwj/3NQ+cgGx2VU5Al+2C2psBlFb1e6UZgXfm7VhqMikTfX
         dZ/iOetRRwRVeC4a0oSereV1W089j+j44plNL0lbNm4D/zEBbwxLDziyjTB9QMelKWmf
         8Yf8MK3nC7kpcZYf4zDMzMxhwlZKAx5H42JrmUeq+df9r5QtUGKACITziFMZiQhWuNmb
         MFHw==
X-Gm-Message-State: ANoB5pnHa6ylphR6LwvFE/Y5Agu5OVCzBbUs3EwD5s3QmUxCm6AkUVBp
        GXE6VfL+OrRHJ0dkBDJWyStksQ==
X-Google-Smtp-Source: AA0mqf7sdZ4IIewi7If1cBDpEQXvuDOrlh8xL7AZnFA8/lhkuWPov7WbfLsNIp8x1bWjFHnFCxtv5A==
X-Received: by 2002:a05:600c:554d:b0:3cf:af66:e5b9 with SMTP id iz13-20020a05600c554d00b003cfaf66e5b9mr28316339wmb.107.1669737434173;
        Tue, 29 Nov 2022 07:57:14 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f2-20020a7bc8c2000000b003cfb7c02542sm2601550wml.11.2022.11.29.07.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:57:13 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 29 Nov 2022 16:57:07 +0100
Subject: [PATCH v7 8/8] Input: mtk-pmic-keys: add MT6357 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v7-8-477e60126749@baylibre.com>
References: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fabien.parent@linaro.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-leds@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=K2/LktiwnSqpYUY/NYDB7cyyBwW4Kzl5Gx1VcVhpHIg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjhivPU87+tCEsv9wKvjsTZ/yHirCJ7tdj091I6KFc
 cLYo/HOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4YrzwAKCRArRkmdfjHURcWdD/
 48EXWvZZB8DrLR5D/bQxn+KzLEixITXwKeF9W7VwgXTaLu/tau7GP4Ufn0nxnCLdAsDrpdsvzJq0QK
 /v65pGhFyzpnPLEYjjeTH3EOPNut6s/b3hrBjy6ifTG+FPpGc2Kw5An18Yu3zeyyE/ZNOZ+cRtjzWZ
 mIRgdaQ1A1RBphVGCo/V85j69rx5o4bpiO0lG5/824rP0PL0tIY3fEczhcRMdRkjoZh2N3jifZ8bjo
 ydip/Z9ZRBnxUo60n4aBEOPDt4MyyICRaPZxeJPEJMEazM+Lx6uab+GsJfyPsqcVVSoGxfbJh26cL2
 k1qUigspT56CISzWQLajPdY8qfP3Sq7sdXNh7Dn0RirWU4S2sIR6RYqOUyv3+rUL7scCWnyLNyGDM0
 mvNQcd9sJZUS7YDR1Dv5KvUYicEY85mEQkSrXZgWesitz774zn9kJHwY1hnjoojtNbdWzClYFyTOIE
 ptNZy/QSdq7si5NhnoF8R8KxsjuCvjAfCLKVWrTtbmePCfCF2S6z8aH8DkwN+QUH/IJoG0zBlVwJCs
 poPK2zFmYYl7K2/fDUi1GS92cg+3jyLgNC07KZ/vJV1ucdGnfrVt6ZJDziMbBV8Wygk4aOiidIVOSp
 K1AbxZ1piDeC7nz4xEQxNl09oM/hvoJJvFOpjN1OjWNHEouWgkGFmXtLb2IQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add PMIC Keys support on MT6357 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 9b34da0ec260..2a63e0718eb6 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/mt6323/registers.h>
 #include <linux/mfd/mt6331/registers.h>
+#include <linux/mfd/mt6357/registers.h>
 #include <linux/mfd/mt6358/registers.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/registers.h>
@@ -90,6 +91,19 @@ static const struct mtk_pmic_regs mt6331_regs = {
 	.rst_lprst_mask = MTK_PMIC_MT6331_RST_DU_MASK,
 };
 
+static const struct mtk_pmic_regs mt6357_regs = {
+	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6357_TOPSTATUS,
+				   0x2, MT6357_PSC_TOP_INT_CON0, 0x5,
+				   MTK_PMIC_PWRKEY_RST),
+	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6357_TOPSTATUS,
+				   0x8, MT6357_PSC_TOP_INT_CON0, 0xa,
+				   MTK_PMIC_HOMEKEY_INDEX),
+	.pmic_rst_reg = MT6357_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
+};
+
 static const struct mtk_pmic_regs mt6358_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
@@ -276,6 +290,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt6331-keys",
 		.data = &mt6331_regs,
+	}, {
+		.compatible = "mediatek,mt6357-keys",
+		.data = &mt6357_regs,
 	}, {
 		.compatible = "mediatek,mt6358-keys",
 		.data = &mt6358_regs,

-- 
b4 0.10.1
