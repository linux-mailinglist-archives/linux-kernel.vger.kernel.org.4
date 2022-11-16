Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941BD62BE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiKPMeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbiKPMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:33:58 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9495643F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so29651784wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI9uwBLCvWR3OgOlMBN6oypd3UQ7AbJ0Dp0NjT4lxFo=;
        b=sHnFd/lL5A2cdE7y7gKxWrquE3RvjTfCr4XesYiSwsj5MC9VoE5vwMCKnLLM62elD1
         zkoE+HytAtoh8YJ2xe8EZpRuVkDhsHgBGY5CLiFBnE2p+ug5GaKgSfnSBHQaHWJSwUrA
         nusGcFS9EHdF97Ph0NXAeltWw0N9DbQWJLp3F/L2A39KeBvmHpbkxPsY1oyy2folnkqC
         nQxqlq8v8g8SeJMqiXidepB6RbqCAeah+1Zn975Cs48REyEtmOZjwW4hr0PEfh+itx5q
         6GbqXuuWWTxK0cy+Y2G4TFZtogXoPDCrQevYEdHMzh48AXsF0hUakW/etOfA162NwUsj
         uALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI9uwBLCvWR3OgOlMBN6oypd3UQ7AbJ0Dp0NjT4lxFo=;
        b=bTF74D7plrtwXaLUbIPb+Femahc1pIGVJnMuRuzUmQD3c4GxQrPxYklC7lcvptafFA
         Kgxu249kB1lN+PFjYA9SVU91QPckmputN4/75HN96DeWbGtRbVC5LfSxiSpVbiBd0GYH
         dT76AP6VmXvh6frzgkp6K50F8di+2mD01SuMqVtHK2F+anzlVgLV49sF/i/uk46K9x4w
         dMdEGNo6yiZLYsohzggJTJvEfK1bEm2W8f8ULRhZ1Lbx5BcHCd3BV8UJL4AK/uTOcYuI
         LP8DGJSqU9mdwTnlQX6AxqZ9/ecvsCf79MNAgW8e5XsNVWePORoqvt3u+mqnLa+qrWJu
         pBrQ==
X-Gm-Message-State: ANoB5pmnThPKR4vegN6450ssQ2qNtpKQfaRjw5WDhmiKdcCXOtcdvQaQ
        chsLhCL3xoPBkNxO3MxCNtLYmw==
X-Google-Smtp-Source: AA0mqf43ZwqZX4qqGAkOOFpwMHLviKqBuca3ZNbsWFwMMrmY69hMHTVzUqv7KpJe+cRxk8lUEa65xQ==
X-Received: by 2002:adf:ec83:0:b0:236:86f2:b3fa with SMTP id z3-20020adfec83000000b0023686f2b3famr13712940wrn.457.1668602027406;
        Wed, 16 Nov 2022 04:33:47 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id z13-20020adff1cd000000b0024166413a4fsm15051607wro.37.2022.11.16.04.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:33:47 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 16 Nov 2022 13:33:04 +0100
Subject: [PATCH v5 10/10] Input: mtk-pmic-keys: add MT6357 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v5-10-8210d955dd3d@baylibre.com>
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
To:     Flora Fu <flora.fu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=K2/LktiwnSqpYUY/NYDB7cyyBwW4Kzl5Gx1VcVhpHIg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjdNieZ404YpNtkYSivYSn+3ZAsowD7kjt8AT8H7pn
 1beN5/KJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY3TYngAKCRArRkmdfjHURQ/jEA
 CjBs9hecD71EXvrtGB0GD+Pt3BUK+ISJbtY85IJFzSjCQQeJQ7I3fcY1PGIP3Zl3t6PZJHJAM007AR
 t++htXH/6Q9LEi4UVPwNwVS6x4lE78IPBY8V8g3HBFkx0jPKyh7z937yYSuFvy//jyAJqt4+rN8mGR
 VZJSS7DXwvhG/Nsk2CFUg878ENFvdAgex9eoz+L0SIPoshxX/l++CvPi6TR4jFYlEeMdK14zFXNWSM
 fhRuiz16EqdTJB+yDHMK6GrkpF9ljnr1dqxLIQnD/OHO5/U2XeCtLZ5iiuMmS0ZNwyu+sRffNyemUi
 cNBiSl16AQgUJ3XFq+7coWbMzvvfWjIUa7eqUkVmOCDyYlohpQajGq+H6y50a3ty+CrYc5L9LcGEMv
 qterhaqxmNGaTE31evhakhFX+zZYMh3UAUsj1vV2913t/dHV/QH+wY0C7RowJloevAwZ80Mbt22UWT
 qnCLCzKa0KaDA6Wu01NkgyQlZhQSRshKy94rb1SDCxCQ1Tum8gto6nFxqaOoU5sVpMRiRWOY9fIl0C
 BiaNwxN0VmQZKpPrKtSvNSM1YjRo3tkjM5k4CN2V82s+DmAlDZ2GTto8hqmfoWINgGK1FCKzgEvctF
 VvxlByeamx6OXAnReeR5WsKIcykLMA9EEO3ruMlZtVxS3LNlQBR0zKPuao2Q==
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
