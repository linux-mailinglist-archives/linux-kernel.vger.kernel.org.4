Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D495B734EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjFSIzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjFSIzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:55:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C071710D8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:54:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98377c5d53eso455742066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687164859; x=1689756859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjL7PyODR4xjZUQH06VhkEHWT7Au/HHZMcOL+cz1CHs=;
        b=Ahov2+FBRKJ2DJvXO0m6d3KytOULMc30murjslT7irsJzedit/iAHdiYZSzFHi7lFy
         O/yaBumy4uUCCt3NByTZ5WLyJ/4Vd6VXBASsxD26DZqvTxeB/QOBefmdkwEAgE36tWkB
         HPx+oDCcPFpemRB3VS4Z4tTxBvZtlhOE3kfGoSLrbc8nza3Em+sANYrYpthsKgh7sApO
         yD52bEkJDsdv0Zo7bm1AKmDJJiSyzGbAriMXpDuMJZ+RPHfCjGbsKx3z8/H2qrusAEX8
         hvZWGVqwbBp1GtkpYnXT1SzNVdSx9QzG/Hi7x8Jbt622QImZluU+TUviunpPeK3ou+PR
         z7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687164859; x=1689756859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjL7PyODR4xjZUQH06VhkEHWT7Au/HHZMcOL+cz1CHs=;
        b=OUmaoa+eZk/+io7YZ5/ocpb4Alqt7hMNIeA/Sqrpbzp3w/O56sU+PEvmH10wjnlp9/
         YSD93dvEqGZJ6ecWjW5mbbD5JXToxl7QUIBstp/Jw0ed2Xy5vZxTeoaijhqTCEpyxaFH
         suy3pYl8xZC/x/kmVFZuctWqc47V3bSJBYavrs1iBE/KUMUSiebPvbNagtXJ0y/i5uxB
         l+mxCa895N2nCclxvCPEZyH4zhYPlY4fVkZXi4V6LX4aLcDh1y+62MLAZ1+e0hygjGIO
         z26Mz75sAuyJANRd520Y1Glv2D+6EXtyFyL6u+PASrbf81E1cSdZQe7JPdF2WtxdZ8b4
         Wh4w==
X-Gm-Message-State: AC+VfDyJ+XWe0uRtLYNC1wxFhjgNrfjMdHRWiXGvJfOO+jy0ekmEwLIX
        OO9RQI9eqTikQEoZfmZcMZFC1w==
X-Google-Smtp-Source: ACHHUZ6TBWtOL6n5gc1QsERCHmzUiwZnS+yZqx93epyd2jzBHk/bzem7VwEo8M2ghyOjaKw8MiFw4g==
X-Received: by 2002:a17:907:e87:b0:96f:6c70:c012 with SMTP id ho7-20020a1709070e8700b0096f6c70c012mr8522591ejc.45.1687164859332;
        Mon, 19 Jun 2023 01:54:19 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a245:802c:bc2b:8db8:9210:41eb])
        by smtp.gmail.com with ESMTPSA id h27-20020a17090619db00b00987a6e01e94sm2994339ejd.214.2023.06.19.01.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:54:18 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v5 7/8] soc: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap
Date:   Mon, 19 Jun 2023 10:53:43 +0200
Message-Id: <20230619085344.2885311-8-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619085344.2885311-1-msp@baylibre.com>
References: <20230619085344.2885311-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Bailon <abailon@baylibre.com>

This adds support for MTK_SCPD_STRICT_BUS_PROTECTION capability. It is a
strict bus protection policy that requires the bus protection to be
disabled before accessing the bus.
This is required by the mt8365, for the MM power domain.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 27 +++++++++++++++++++++++----
 drivers/soc/mediatek/mtk-pm-domains.h |  1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 4659f0a0aa08..5c458aa2ddbe 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -262,9 +262,17 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
 
-	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
-	if (ret)
-		goto err_pwr_ack;
+	/*
+	 * In few Mediatek platforms(e.g. MT6779), the bus protect policy is
+	 * stricter, which leads to bus protect release must be prior to bus
+	 * access.
+	 */
+	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {
+		ret = clk_bulk_prepare_enable(pd->num_subsys_clks,
+					      pd->subsys_clks);
+		if (ret)
+			goto err_pwr_ack;
+	}
 
 	ret = scpsys_sram_enable(pd);
 	if (ret < 0)
@@ -274,12 +282,23 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto err_disable_sram;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {
+		ret = clk_bulk_prepare_enable(pd->num_subsys_clks,
+					      pd->subsys_clks);
+		if (ret)
+			goto err_enable_bus_protect;
+	}
+
 	return 0;
 
+err_enable_bus_protect:
+	scpsys_bus_protect_enable(pd);
 err_disable_sram:
 	scpsys_sram_disable(pd);
 err_disable_subsys_clks:
-	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION))
+		clk_bulk_disable_unprepare(pd->num_subsys_clks,
+					   pd->subsys_clks);
 err_pwr_ack:
 	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 err_reg:
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 562d4e92ce16..116c7875f74c 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -12,6 +12,7 @@
 #define MTK_SCPD_ALWAYS_ON		BIT(5)
 #define MTK_SCPD_EXT_BUCK_ISO		BIT(6)
 #define MTK_SCPD_HAS_INFRA_NAO		BIT(7)
+#define MTK_SCPD_STRICT_BUS_PROTECTION	BIT(8)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
-- 
2.40.1

