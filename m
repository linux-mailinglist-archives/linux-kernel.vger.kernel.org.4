Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD22165F25F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbjAERQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjAERPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:15:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F8F69531
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:09:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay40so28532539wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPJV1qfI65vcb6ofJWhCMHNO2xRqa9GjQ0e1B9CiTNQ=;
        b=yNsOPbDTM0efU9dE//dgz3rHOrXf/sZWUnEGrQcLupD9McKI9FV03L2Spct4MXfF4S
         TU8AU8AzjfBeTcB7tDXILCKm7rE+WjqBJRRHF70S2hg6kLrq5B224CgNH004pnKtNOvh
         ew6qC7fSouMuSq+iVPPF3Ri49sGNgZqzNd/IOE5JOh8gV+GtaIJc5dUqr82tYrNwfI7X
         W7zBiIgay+TkR62pupN0EEF2sIp+F4GYUnogdRMqpgMGCCTUtyOAKDchHCrh3spQPPKY
         5Zy3Mo4lrNThLPbZgiLumzbTI+GdZsyVnjzkT5v6zijPPW+7WqTu7cC8e536cUunBMZA
         3bCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPJV1qfI65vcb6ofJWhCMHNO2xRqa9GjQ0e1B9CiTNQ=;
        b=vY1UJI2B9U6QSdMBCupE5UpFpq37z/yziQV6TYAbW3Ym2SmMDgMRIVO2IsPo6hDP4h
         4T77mcvWWIEn76betsVNVZ5rj5M3vyAnqVnercru7RGhLF7/lmnR53m5caceEcT9dqKX
         Kckp4ZoF3H3pqY/0KfOGcicvFCDzna8DOt/IPfuOh5g/N4LDrrgUZ07L0NglBoLbHIYj
         j5INbm8LjDbuOKRFk4JjYTs2n8Qzw60FTL4Y+rVsO/ZvoSjouM2YNWgvfoRtZrI7JUx9
         UTISf2W8pZpqPcnVl7cPqpQPnWgWhh2EP9CXie34+2ZXRJYX7V/fHCb+I0hrqKm5qRcp
         OLTw==
X-Gm-Message-State: AFqh2kqM6EQHSNna5+KIIrQXzI24fr/Kg/2a7KDGfzdhrOIb1gZc9bF8
        PAM7hJMiLIVvrB0HmGsTVQDsBg==
X-Google-Smtp-Source: AMrXdXuIXDpOZkm4ix/uQdGbtjWGymqzEfazAjrzvDtgZc3mURrErZ0nErcrf/OQqJfWoIsPn55TIw==
X-Received: by 2002:a05:600c:687:b0:3cf:e7c8:494 with SMTP id a7-20020a05600c068700b003cfe7c80494mr37142812wmn.29.1672938472975;
        Thu, 05 Jan 2023 09:07:52 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:9cf4:fdb8:bb61:5f4e])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b002365730eae8sm37164853wrm.55.2023.01.05.09.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:07:52 -0800 (PST)
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
Subject: [PATCH 6/8] soc: mediatek: Add support for WAY_EN operations
Date:   Thu,  5 Jan 2023 18:07:33 +0100
Message-Id: <20230105170735.1637416-7-msp@baylibre.com>
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

This updates the power domain to support WAY_EN operations. These
operations enable a path between different units of the chip and are
labeled as 'way_en' in the register descriptions.

This operation is required by the mt8365 for the MM power domain.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---

Notes:
    Changes in v4:
    - Redesigned the patch to be better to understand and have less code
      duplication
    
    Changes in v3:
    - Separated the way_en functions for clarity
    - Added some checks for infracfg_nao
    
    Changes in v2:
    - some minor style fixes.
    - Renamed 'wayen' to 'way_en' to clarify the meaning
    - Updated commit message

 drivers/soc/mediatek/mtk-pm-domains.c | 57 ++++++++++++++++++++-------
 drivers/soc/mediatek/mtk-pm-domains.h | 16 ++++++--
 2 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 999e1f6c86b0..d53309f050ee 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -43,6 +43,7 @@ struct scpsys_domain {
 	struct clk_bulk_data *clks;
 	int num_subsys_clks;
 	struct clk_bulk_data *subsys_clks;
+	struct regmap *infracfg_nao;
 	struct regmap *infracfg;
 	struct regmap *smi;
 	struct regulator *supply;
@@ -118,10 +119,13 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 }
 
 static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
-				    struct regmap *regmap)
+				    struct regmap *regmap,
+				    struct regmap *sta_regmap)
 {
 	u32 val;
 	u32 sta_mask = bpd->bus_prot_sta_mask;
+	/* way_en acknowledges successful clear with the bit being set */
+	u32 expected_ack = (bpd->way_en ? sta_mask : 0);
 
 	if (bpd->bus_prot_reg_update)
 		regmap_clear_bits(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
@@ -131,13 +135,14 @@ static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
 	if (bpd->ignore_clr_ack)
 		return 0;
 
-	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
-					val, !(val & sta_mask),
+	return regmap_read_poll_timeout(sta_regmap, bpd->bus_prot_sta,
+					val, (val & sta_mask) == expected_ack,
 					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
 static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
-				  struct regmap *regmap)
+				  struct regmap *regmap,
+				  struct regmap *sta_regmap)
 {
 	u32 val;
 	u32 sta_mask = bpd->bus_prot_sta_mask;
@@ -147,12 +152,13 @@ static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
 	else
 		regmap_write(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
 
-	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
+	return regmap_read_poll_timeout(sta_regmap, bpd->bus_prot_sta,
 					val, (val & sta_mask) == sta_mask,
 					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
-static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
+static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd,
+				      struct regmap *regmap, struct regmap *infracfg_nao)
 {
 	int i, ret;
 
@@ -160,9 +166,14 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
 		if (!bpd[i].bus_prot_set_clr_mask)
 			break;
 
-		ret = scpsys_bus_protect_set(&bpd[i], regmap);
-		if (ret)
+		if (bpd[i].way_en)
+			ret = scpsys_bus_protect_clear(&bpd[i], regmap, infracfg_nao);
+		else
+			ret = scpsys_bus_protect_set(&bpd[i], regmap, regmap);
+		if (ret) {
+			pr_err("%s %d %d\n", __PRETTY_FUNCTION__, __LINE__, ret);
 			return ret;
+		}
 	}
 
 	return 0;
@@ -172,15 +183,17 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 {
 	int ret;
 
-	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
+	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg,
+					 pd->infracfg, pd->infracfg_nao);
 	if (ret)
 		return ret;
 
-	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
+	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi, NULL);
 }
 
 static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
-				       struct regmap *regmap)
+				       struct regmap *regmap,
+				       struct regmap *infracfg_nao)
 {
 	int i, ret;
 
@@ -188,9 +201,14 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 		if (!bpd[i].bus_prot_set_clr_mask)
 			continue;
 
-		ret = scpsys_bus_protect_clear(&bpd[i], regmap);
-		if (ret)
+		if (bpd[i].way_en)
+			ret = scpsys_bus_protect_set(&bpd[i], regmap, infracfg_nao);
+		else
+			ret = scpsys_bus_protect_clear(&bpd[i], regmap, regmap);
+		if (ret) {
+			pr_err("%s %d %d\n", __PRETTY_FUNCTION__, __LINE__, ret);
 			return ret;
+		}
 	}
 
 	return 0;
@@ -200,11 +218,12 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 {
 	int ret;
 
-	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi);
+	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi, NULL);
 	if (ret)
 		return ret;
 
-	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
+	return _scpsys_bus_protect_disable(pd->data->bp_infracfg,
+			pd->infracfg, pd->infracfg_nao);
 }
 
 static int scpsys_regulator_enable(struct regulator *supply)
@@ -378,6 +397,14 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 			return ERR_CAST(pd->smi);
 	}
 
+	pd->infracfg_nao = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
+	if (IS_ERR(pd->infracfg_nao)) {
+		if (MTK_SCPD_CAPS(pd, MTK_SCPD_HAS_WAY_EN))
+			return ERR_CAST(pd->infracfg_nao);
+
+		pd->infracfg_nao = NULL;
+	}
+
 	num_clks = of_clk_get_parent_count(node);
 	if (num_clks > 0) {
 		/* Calculate number of subsys_clks */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 34642a279213..1fa634509db1 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -10,6 +10,7 @@
 #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
 /* can't set MTK_SCPD_KEEP_DEFAULT_OFF at the same time */
 #define MTK_SCPD_ALWAYS_ON		BIT(5)
+#define MTK_SCPD_HAS_WAY_EN		BIT(6)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -41,7 +42,7 @@
 
 #define SPM_MAX_BUS_PROT_DATA		6
 
-#define _BUS_PROT(_set_clr_mask, _set, _clr, _sta_mask, _sta, _update, _ignore) {	\
+#define _BUS_PROT(_set_clr_mask, _set, _clr, _sta_mask, _sta, _update, _ignore, _way_en) {	\
 		.bus_prot_set_clr_mask = (_set_clr_mask),	\
 		.bus_prot_set = _set,				\
 		.bus_prot_clr = _clr,				\
@@ -49,16 +50,20 @@
 		.bus_prot_sta = _sta,				\
 		.bus_prot_reg_update = _update,			\
 		.ignore_clr_ack = _ignore,			\
+		.way_en = _way_en,				\
 	}
 
 #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
-		_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, false)
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, false, false)
 
 #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true)
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true, false)
 
 #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _mask, _sta, true, false)
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, true, false, false)
+
+#define BUS_PROT_WAY_EN(_set_mask, _set, _sta_mask, _sta)	\
+		_BUS_PROT(_set_mask, _set, _set, _sta_mask, _sta, true, false, true)
 
 #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
 		BUS_PROT_UPDATE(_mask,				\
@@ -77,6 +82,8 @@
  *			 write the whole register.
  * @ignore_clk_ack: Ignore the result in the status register for clear
  *		    operations.
+ * @way_en: Enable a way in the SoC. For this type the status bit to acknowledge
+ *	    the change is always 1 on successful change.
  */
 struct scpsys_bus_prot_data {
 	u32 bus_prot_set_clr_mask;
@@ -86,6 +93,7 @@ struct scpsys_bus_prot_data {
 	u32 bus_prot_sta;
 	bool bus_prot_reg_update;
 	bool ignore_clr_ack;
+	bool way_en;
 };
 
 /**
-- 
2.39.0

