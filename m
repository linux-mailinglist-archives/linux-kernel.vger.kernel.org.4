Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B56065AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJTQVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiJTQVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:21:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733EB1C8413
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:21:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y10so274496wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI9uwBLCvWR3OgOlMBN6oypd3UQ7AbJ0Dp0NjT4lxFo=;
        b=4bkGk7hJ3/gLjKzcyaaVY4WHvFfZ/PYLiPSr23645Oe+YIeu5MQtu87/06UUV74DWt
         vjeIeuy545c3YWmN4F5u890dHccN6tX0FuXbuDRL9cN1BosH/MLEXrQVnPJ7sTq1mEt5
         Jaf0j8dfM6H7PxYZg8D8HKbagf/tVdLiR5KQBL5GtdIn7nlluYg1aDQgbb2JtKgUNgyA
         DULRMrKHxIgtNKU2wEaDALPuviN4CW0AwCoQ0X9GL4ampRj5nmJ5JRR9aP6xMM34qlXp
         zVXfOmzw7VSRV4Be3wXQVUr2J6tEvrKnKmPavpnipA1l8olLWTgjbM0e2J+AD5+hyZPk
         rMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI9uwBLCvWR3OgOlMBN6oypd3UQ7AbJ0Dp0NjT4lxFo=;
        b=BhqJVOjj+ssViDOuFBrqJae+Q9Ufp4sSi8P/3lvImLCKQ4il3rmLL1iEOckX29/Cvh
         PW7C6IIAL/NbJnwqRxWuTyhsgEMZB7z34jOSw24ygjyG2/LAW7K6coIXicht/UjzKhSL
         YbzonDQST02kuxhh+lWzj+1MlN8P63NzerUdN9ixL1epiK3M4o2mhumJ5YKwuxAbSVdL
         bWCFUKJaWSsnXvijgx9HhOaLQqw92yiU0hx3Dx9cPBvtv7yyAfqxQKUnZ/atTYekuwPu
         q/P3qmmH2+XM7ia2ueV53UCClr/TXBU49m+OyYK612UEFScDmhDwvh3iUAQoYObl5iNp
         xFqg==
X-Gm-Message-State: ACrzQf0yy+sTUwTbHZA7pUW+asVXGvhoRAVZL5kKvUutLLlyf76RZDoW
        GcZOj5ZZ5n9ze8yXl+WF22JE6Q==
X-Google-Smtp-Source: AMsMyM59O1Ens9WgNUevB39v9v24YyNwkvj33JjcvXYrs8vAqoPeTDo86MUcxITGL1VMMe8AHK3heA==
X-Received: by 2002:a05:600c:3511:b0:3b4:bb85:f1dd with SMTP id h17-20020a05600c351100b003b4bb85f1ddmr10229689wmq.42.1666282875631;
        Thu, 20 Oct 2022 09:21:15 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id m14-20020a05600c3b0e00b003b4fe03c881sm208028wms.48.2022.10.20.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:21:15 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 20 Oct 2022 18:20:49 +0200
Subject: [PATCH v3 5/5] Input: mtk-pmic-keys: add MT6357 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v3-5-7e0bd7c315b2@baylibre.com>
References: <20221005-mt6357-support-v3-0-7e0bd7c315b2@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v3-0-7e0bd7c315b2@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=K2/LktiwnSqpYUY/NYDB7cyyBwW4Kzl5Gx1VcVhpHIg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjUXV0iDb1YAXNizgwzlkkfM7Ta8EZ8gn6PwGStpFi
 gLELkyKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY1F1dAAKCRArRkmdfjHURU8oD/
 sFWNRnMZfn2cJP8Xi92PmsQjtSjIQBMJiweHO3Y1WhAVltQpeURhm1QH/EAUnhtesmXThIsZzpigI9
 tJA52SFGLbNp65c0YFxO4jon2VvX31XVtRMGEsM1L4YdJjuL32G38ScQqaKK4hGIFD9sxF5mIAyie+
 WjPr47ZocNTBhczo2Dc07VZcu/oTWsBZPthKx2oHGglsHgJTBQ3pcAsxseJGTv9Y/dXaaI/owDEa7Y
 89Or5TTOiaFHJpNx971Lw9eng+JI0FiQoH+RHGdw510zXFiINtsYdvRsm1Ee/NCiEvprOY9QdzEbiy
 Jw4lais2ggy7LkEEAjbVN8ovn4BSNhido0KzySqEqtnJFlPpcdV4f45tSF552VOFX8j8I0SH9wDekw
 TKQNf63p9fs1ptK7FUFMgrgWUYrxPfZPYIKxiEnS+0fAm4VY+7RXh1V6rRJzXY1HCllSmN5bcajER0
 uofbc+30YUOjtWZ+/22yPcLYOsW5kRh8G1sMo3OFBHFdew2qo2Y3m8s6qYbgqYKBaN14pyxpCQNisn
 R7/KpEG3f6sxUEfqBOWhbcY9kLp7M49mUZ56YFFgmPYKWq2nqwwh+f1pes+A9df7/pKmspkyDZnnwO
 aYWoIe3nLI1owUIr3N9CcN9MTXLgQm9Ko9lvNljcOvdfwtZ01c4BcCwZN1Zw==
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
