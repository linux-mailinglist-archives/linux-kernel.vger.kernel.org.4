Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D946A8277
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCBMk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCBMkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:40:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0F8497C0;
        Thu,  2 Mar 2023 04:40:52 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s11so3034057edy.8;
        Thu, 02 Mar 2023 04:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677760851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDLWBsaXf+EBRK3loI+aJuSsf0blQx7K7EQNqTkpYHQ=;
        b=Zn60fe0foaPBdbdW+KOWbitV44Eb5w5/+zFbZZXAX9mc/cDPXLg8q2hMKw9d4Ahg6M
         BE3jauOKS5qegUeCtDgbKMlz7dZB384zEr8qqDkerc6DHPVGdA7+70gLMFA7dbl2oj/1
         mqTmB3qqV4x6qjYGnat9ILzryi6QeqtWJWk8qtJG+C2vxAqoVEhNIB3hpHyKs8vjX98P
         1Iyr25oDpYuzBYIw99i1PEq2EwPr3BeF6cXIMNnNZLU0utk66SMfiup3xH5+WPE8eMk5
         B2fmOsxjFU3NJ+C+rTzkk+kb/tcdqYmdzKcOooDuKfyP+XE4tC9AK/gLHg3BAHaqb/iA
         JzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677760851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDLWBsaXf+EBRK3loI+aJuSsf0blQx7K7EQNqTkpYHQ=;
        b=KuozgAM3e3t7/CR4r/P/Vezo1wLO5acAXBz5QsRh/fDLJvKR7prG+DieHVriXALybE
         +VaHLWW1XN1BFO+Onzq4qRcf8u/soXZyic7NYO+cBfyn7yBTQ6YZQs/dgl/SgVQtL2Ki
         5qvY2L3auURg4q64WMb36WUoFu1qGxjgste7lcrbMwLT5HtPRuNnSsBaETACnph2DrWh
         uer/IFAty+6sA1j0nT64uRe10C2GJxH+9Bj5TwGyrHCd5IkuInbgFXj7znJnSSUPz+n1
         6OZlv6QY38DPoguf3gWP5MJkkTILduMytK8Q9Q0tAaYdGcEUP4WHz3Jwq/45S2wPHjFn
         SVkg==
X-Gm-Message-State: AO0yUKU8DCrd1FaiNCF4Se2hCqQ4Pift8ohVR5xDlV46q2WqvuAgLcgJ
        jqBJlq4W97T8jQMvVK8yfyY=
X-Google-Smtp-Source: AK7set/t8XAsr9Hi4ReBLtU67ox5Cdan44QFcsS8HLnRsJuCcXvGoWLFaEzy7eE3jU/NZkB2LGhYqA==
X-Received: by 2002:a05:6402:2d8:b0:4bd:6b93:128c with SMTP id b24-20020a05640202d800b004bd6b93128cmr4444479edx.25.1677760850927;
        Thu, 02 Mar 2023 04:40:50 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id c22-20020a50f616000000b004c07b11deb8sm599036edn.64.2023.03.02.04.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:40:50 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] watchdog: mtk_wdt: Add support for MT6735 WDT
Date:   Thu,  2 Mar 2023 15:40:15 +0300
Message-Id: <20230302124015.75546-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302124015.75546-1-y.oudjana@protonmail.com>
References: <20230302124015.75546-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add support for the watchdog timer/top reset generation unit found on MT6735.
Disable WDT_MODE_IRQ_EN in mtk_wdt_restart in order to make TOPRGU assert
the SYSRST pin instead of issuing an IRQ. This change may be needed in other
SoCs as well.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/watchdog/mtk_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index a9c437598e7e..5a7a7b2b3727 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/reset/mt2712-resets.h>
+#include <dt-bindings/reset/mediatek,mt6735-wdt.h>
 #include <dt-bindings/reset/mediatek,mt6795-resets.h>
 #include <dt-bindings/reset/mt7986-resets.h>
 #include <dt-bindings/reset/mt8183-resets.h>
@@ -82,6 +83,10 @@ static const struct mtk_wdt_data mt2712_data = {
 	.toprgu_sw_rst_num = MT2712_TOPRGU_SW_RST_NUM,
 };
 
+static const struct mtk_wdt_data mt6735_data = {
+	.toprgu_sw_rst_num = MT6735_TOPRGU_RST_NUM,
+};
+
 static const struct mtk_wdt_data mt6795_data = {
 	.toprgu_sw_rst_num = MT6795_TOPRGU_SW_RST_NUM,
 };
@@ -187,9 +192,15 @@ static int mtk_wdt_restart(struct watchdog_device *wdt_dev,
 {
 	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
 	void __iomem *wdt_base;
+	u32 reg;
 
 	wdt_base = mtk_wdt->wdt_base;
 
+	/* Enable reset in order to issue a system reset instead of an IRQ */
+	reg = readl(wdt_base + WDT_MODE);
+	reg &= ~WDT_MODE_IRQ_EN;
+	writel(reg | WDT_MODE_KEY, wdt_base + WDT_MODE);
+
 	while (1) {
 		writel(WDT_SWRST_KEY, wdt_base + WDT_SWRST);
 		mdelay(5);
@@ -443,6 +454,7 @@ static int mtk_wdt_resume(struct device *dev)
 static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
 	{ .compatible = "mediatek,mt6589-wdt" },
+	{ .compatible = "mediatek,mt6735-wdt", .data = &mt6735_data },
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
 	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
-- 
2.39.2

