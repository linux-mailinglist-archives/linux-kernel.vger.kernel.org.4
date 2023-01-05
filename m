Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B1365F259
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjAERP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbjAERO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:14:26 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198C467BEC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:08:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso1854930wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sncxYiJ19EBEMYozwgCXbGEKSdQ2+11yxAIRrAVvyso=;
        b=L8GGi7ni7dl6wFN8IW77qB70367v8PhZ3Sd7+oJtMLY5Ej9cNvDNLQSAsDm09a+xsP
         wK3c5FXsCw2fAI8nS6woEXI0BA5uhEXQAs1+yNidpxEMs39ztajNLQMH9bjXgBm615vp
         3UTrsw/syO8Q2MNa9PtePGoMM7ezHfYurfTCo5Ds8UGYdF/+rmD+F7wd79Y8dZwU7VSn
         B14ErNIeK6oq02bUfQPt0ZEJNesP1wNbvDsX2THshhyp5+nW2Par/RJXvy52WSR2YMq1
         ZFJUeYixlF/HoXntuGwSv4jBB+damvcCP4cq//5M4DNqUB6jD+nSsg5nryz18+5IskYw
         fWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sncxYiJ19EBEMYozwgCXbGEKSdQ2+11yxAIRrAVvyso=;
        b=S53kgJI4ZQN1rqqNK4n/YdV5FlaWc/V9yH3w91msucvsRJ73rohba/7c5NMfkIHysz
         TqwKjE1bGBU4XBbTasnuCXNszyfozmyYsaV8x6rXeTrHUbpqVPA3nZ/xY76zRQTlpi+s
         1Nl4/1szHUtn/LvqtFtGjTqR2soM6rSDCS4tVokJgOTdiwC7tr4VgBxrrsvZC+4yaLvm
         gUef+R2jr1K3h/h54S6p7D8UD8dx0IWMsu5bfOFVk/3tiTKcnHKpkpjmet+YysVHRQuK
         YsiRZIMoC5ahngFGD3nRmvkx4KeaQJxXcP+OCRph71EtT1w9TAWtfvbbz8PzUHssM5Er
         ZdiA==
X-Gm-Message-State: AFqh2koxOxe6yqilv9c4aB7KH9FGhKqZCUD1ojzqSVppxLKhYaq8fcID
        BlrScrXJlsigkg64of5V3GH8hA==
X-Google-Smtp-Source: AMrXdXsa25aMnGI1cayPOWzrjuYzyQhetcgmL1o5YukwOgaRADsQ2/BrQNcacZ4JwiA8kuPZNNtW5g==
X-Received: by 2002:a1c:770b:0:b0:3cf:a18d:399c with SMTP id t11-20020a1c770b000000b003cfa18d399cmr39048182wmi.1.1672938474085;
        Thu, 05 Jan 2023 09:07:54 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:9cf4:fdb8:bb61:5f4e])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b002365730eae8sm37164853wrm.55.2023.01.05.09.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:07:53 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 7/8] soc: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap
Date:   Thu,  5 Jan 2023 18:07:34 +0100
Message-Id: <20230105170735.1637416-8-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105170735.1637416-1-msp@baylibre.com>
References: <20230105170735.1637416-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Notes:
    Changes in v4:
    - Change name in title and commit message
    
    Changes in v3:
    - Rename MTK_SCPD_STRICT_BUSP to MTK_SCPD_STRICT_BUS_PROTECTION
    - Remove extra bool variable reflecting the capability
    
    Changes in v2:
    - Fixup error handling path.

 drivers/soc/mediatek/mtk-pm-domains.c | 27 +++++++++++++++++++++++----
 drivers/soc/mediatek/mtk-pm-domains.h |  1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index d53309f050ee..29a9028dd9b3 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -265,9 +265,17 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
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
@@ -277,12 +285,23 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
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
index 1fa634509db1..e5aa2348a9db 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -11,6 +11,7 @@
 /* can't set MTK_SCPD_KEEP_DEFAULT_OFF at the same time */
 #define MTK_SCPD_ALWAYS_ON		BIT(5)
 #define MTK_SCPD_HAS_WAY_EN		BIT(6)
+#define MTK_SCPD_STRICT_BUS_PROTECTION	BIT(7)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
-- 
2.39.0

