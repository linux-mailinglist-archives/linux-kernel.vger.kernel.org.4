Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF02621C55
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiKHSpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiKHSog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:44:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C698657B5C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:44:22 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j15so22435480wrq.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI9uwBLCvWR3OgOlMBN6oypd3UQ7AbJ0Dp0NjT4lxFo=;
        b=CSaRg0vVxgyiuQdj1V2NLEHd+kgqNGHBjnC1u8uCR2W7T481ZG/kZIfgoVhmQLlYEF
         6J/KC7qQV7QCDYlIRuQkOhYj/KMijcmRzvJI3uXtzz/ngcbKL/WZcXcSBSRvGuEJy+p7
         yEczZPIJAhRc0cavap7ToXuK8Lna+hB1Lg//Ur8QtvRddpm0gSIrJ1Fs1Suh7AuaOK8e
         H6eKTxuxCb2sm7h5vDdPZ6EQMdFKfgByDDWd4zA3jOjVQLROGmQQQuGWG6qj/m94UoO+
         xpIU7SZJxazP1KbJZwl5okcMTvKytdLvfXyNP+cFnwNazPE77DrR6en0oN+yEQetowbe
         HVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI9uwBLCvWR3OgOlMBN6oypd3UQ7AbJ0Dp0NjT4lxFo=;
        b=iWk0jScRQiDc3eNv+bM5+FbaxG7GKWr16F41fojrBnvHqoXlcL6EX7qpL8oO/2Mz8a
         VtDmhEe6pigDsRD0W8eNr6faGdE2T8qNDEgXtbQqfkJqx0Kb/YJEtlihGqPj36L5z9IL
         rYtIPUSBKfoKfJio22DpmI9jarMzsnsBCZpA6FhqCIE4sXT/nYUeHTdMD48XoUfswMfU
         Jc66pjju33ppwRAjQoNsLxF1VVrPA8dlPlPPYZXRaimiiqQa/Wre7Oa8QV3z0kSNGLvd
         /RCNu1e8FZsEMrdJ15DsNroVMRzNWfCJffkubLanZqmUeFnYglTyphTg18vtfmnzSB77
         DyhQ==
X-Gm-Message-State: ACrzQf3yA0ToGVESHYTxv9M2EwPLGnpebaD94UsekcH7yoW2FcV3NWPw
        T+oQS4FU0I7YyGo+1nYRZq+pHw==
X-Google-Smtp-Source: AMsMyM7PehcaLkAoUAc3dPM7Y52qFOR2kd/xLIXGq22VchBYZHffeDZSGlR2caGZ5P2CQM/ybjtD1A==
X-Received: by 2002:a5d:6288:0:b0:236:dc84:1f70 with SMTP id k8-20020a5d6288000000b00236dc841f70mr29115404wru.549.1667933062291;
        Tue, 08 Nov 2022 10:44:22 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id m6-20020a05600c3b0600b003cf6c2f9513sm13564009wms.2.2022.11.08.10.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:44:21 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 08 Nov 2022 19:43:44 +0100
Subject: [PATCH v4 9/9] Input: mtk-pmic-keys: add MT6357 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v4-9-5d2bb58e6087@baylibre.com>
References: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
To:     Fabien Parent <fabien.parent@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-leds@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=K2/LktiwnSqpYUY/NYDB7cyyBwW4Kzl5Gx1VcVhpHIg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjaqN7eeGCzCyUi5InMw3eWnWYtPkXU1MgBrUAnShd
 78BDjCeJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY2qjewAKCRArRkmdfjHURaYKEA
 Cr96MTTnXWtAIdf1TCkrHAL1LG6agzmHMlIDSss+hvEZXVgjdLetUSRXM2rPKGZajgqVMORqAqsKnF
 1zKMvuG+4pSsS7v444elbnii1vzA51182pjRD2F0jkV4J92rP8zXvNi0RXD2Ml+LNGbkPz2ABTuJ+u
 MxxQ90HxFlzuMLoKZEbGOs7cPyOWbCXbPy5Gsf7McL+XUqAI7S79qvwts1qJCFM5gWrFLJZYYVpFVZ
 e0SBFefj/9iJTSUSh5VcLbY3W6k/Sp2EhShMB53fpmDn83gnHGr7dsJdOUHP+wChZxGyK2BllJ++vo
 U++aDKvTaRKpeBLgeJPEOF86OY3cTPjgqbJ4nGX7WFSvXfp/PecG6gNkIO6WUbBkLrUQpejlPyWaUe
 tZi3mXPjgOVm6I0U7VgK4TIjdUr/a+Apq+KpiGRERxsNkgue6sUTTqM/lgJ1az2r4EwXYnnm6paGvm
 xTV0HB/MOV88WbwM5aULpl1BUJ/5gxVt+ffAOlUe0eif1zjQatHreV/mEUMAofklktPfLm8EtnEOKF
 1XMKXrUOgE7n3sHs33yNiRQ6qBBM2gh1F2FxT2TGfJrqPbxlagIKSgKnxrlNMWRaStJBHGE6gnEp4o
 ypEnkkZnfXiVLKTqgLA5KkpBIY7Jiioh2ocdw+dYFHt3jewLHNsPMtIJf3Mw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
