Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728B573FC95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjF0NL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjF0NLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:11:04 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EED82951
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:11:00 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6a0d91e80so34560301fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687871458; x=1690463458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiG/GZ5uQDlr9SguQOqtiNny/kRUjio8i95/1np9ohQ=;
        b=4aQZFZ1dO9vcoiBcyQ8Y6duIoeGJLqswxzDbpDqu2ALW9r2EqcIHFjyxy//onsxsGQ
         VKV2vSz3FphT5Jo6wS7dWUqWgoCrBPV5o3vUaA+5NxzxBRQY3dl3DW+yNOMX/gLO6AXp
         iAmt1xt4Za/GgwAuZt1dMMjxaCntQJdVvgc1thlK9N1W0ChqsAOG5EnDUU6YSh1EzbOy
         mF4XhFZs/pKyb4p2f7yM8W80g7T+1jlrwcnd78y1zRKPhiiCoMoHCrJ6KGSzZtA24JBc
         mZ2YNJlvxEGgBqwaq4Qlja1CsxSr+0YV2DqjuQ8wfmTUU3Xv9dtWteMs78MflZcK+wVI
         53ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687871458; x=1690463458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiG/GZ5uQDlr9SguQOqtiNny/kRUjio8i95/1np9ohQ=;
        b=hFL+IKt4OvM/XFZ8ovxIuaed5+tV8dorKNmy+NOOwuSEEB+uXV9cQEGq/siJ5c2R25
         CXCehlTbwbaGhAn76111LRX4+G0BNQ02TfuXo5jWZSQEe0oX9+1q6R/1aruo/W/cT/HW
         nLju+eNSTbVvpAfzFjlpSpz4VKyklKib9Gqg9SQpzE6PpgGs18/M0NN/lkSVU4TB7iwx
         bdSxLQBPrr4ttrcy6JY3JcGUDcDDSOoe/+WI12LucelMm+OjwM25wxVOjuno05crujaU
         RMmFIeoC72Cz9cJHBH2OIHaHz3dZt/IdO0Rs2ERVXD3oimvsExkyXl6ATXzhbcG3tbLq
         rVJg==
X-Gm-Message-State: AC+VfDxozfoaAX5kWhkndHDuHTLiDgIMRs3cCpF1gJkc+Z+Bjf8vd40G
        mHAyZ+sFPUrCvsWvyGC5Ml8CAw==
X-Google-Smtp-Source: ACHHUZ7cwevS0KdJdb6ZvecNxHvDA6rxL6++7svE6BZyqrlSEnISVJkkifrhH+nu0J3+hlbIWibXWA==
X-Received: by 2002:a05:6512:401b:b0:4fb:7592:7e03 with SMTP id br27-20020a056512401b00b004fb75927e03mr4492768lfb.20.1687871458533;
        Tue, 27 Jun 2023 06:10:58 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id z26-20020a1c4c1a000000b003f91e32b1ebsm1403196wmf.17.2023.06.27.06.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:10:58 -0700 (PDT)
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
Subject: [PATCH v6 7/8] soc: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap
Date:   Tue, 27 Jun 2023 15:10:39 +0200
Message-Id: <20230627131040.3418538-8-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627131040.3418538-1-msp@baylibre.com>
References: <20230627131040.3418538-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/soc/mediatek/mtk-pm-domains.h |  3 ++-
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 608b5eab8146..632285bf0d44 100644
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
index 17c033217704..aaba5e6b0536 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -12,6 +12,7 @@
 #define MTK_SCPD_ALWAYS_ON		BIT(5)
 #define MTK_SCPD_EXT_BUCK_ISO		BIT(6)
 #define MTK_SCPD_HAS_INFRA_NAO		BIT(7)
+#define MTK_SCPD_STRICT_BUS_PROTECTION	BIT(8)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -107,7 +108,7 @@ struct scpsys_domain_data {
 	u32 sram_pdn_ack_bits;
 	int ext_buck_iso_offs;
 	u32 ext_buck_iso_mask;
-	u8 caps;
+	u16 caps;
 	const struct scpsys_bus_prot_data bp_cfg[SPM_MAX_BUS_PROT_DATA];
 	int pwr_sta_offs;
 	int pwr_sta2nd_offs;
-- 
2.40.1

