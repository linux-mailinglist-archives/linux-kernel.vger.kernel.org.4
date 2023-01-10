Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A52B66419B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbjAJNWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbjAJNW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:22:29 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEC91CB3D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:20 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id v25so18343223lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbsNDQtZ9l7uJSVCRyxo87P1UT/WhMtVwdfHPYYORrw=;
        b=sKf3e0UeeBng/1d21s7RTRw8mBmXV2NKacMFyvzp2v71rA+HlyCQ6NPbZf6KuXmCSO
         539TCln6LXH9QiainL0y1oeNUvsesTQJ7MugRkSAQjb9HT2D/m4R7k1U2AW1QBZsTwbJ
         BCQaSPLKN/8If7H1D/WdknyNBECfBTgJWqMDQjLG2hE5nb3ZBaMyGKLC3pWrhD/muf4l
         H1gwJCyl0fj+a+Qc+tUKQF2G2SHzhn2cUS6jFbBB1knInMdxdrYtHiKn9PoOEXyndpso
         qP/66RH9kPUaeByZQ6Ihc/+wVA2v09CH0ixjrSKMMQft7RYQlGWTC50Wj2Ajt43CVgSj
         SB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbsNDQtZ9l7uJSVCRyxo87P1UT/WhMtVwdfHPYYORrw=;
        b=e1nEycskoZzYRFY2wwVxT2miuqUU4+rFQNYsa6wwZngDwmz0XQQq58LPg0/IAWVOd8
         F5orZMAtrlA+1jwEYwtRVobF+7flv7k4Weh3r2GtPE0MwqhZfEx4tEIM/dOgToK1wSIy
         g9q6to4IS/LpoM144YWXj0+gMDj7jnCb6o0OICkkjC3o53crrd7cCStMqOGxwVUQwUBu
         rP6nlV3mFiWMQTBTI5xTW3la7feCvvPmFsFs0f7audV/ld2ky/4BEW1Df+wN2F3eeHz1
         jWH4YfaECyQhiNUYKmvQbHLcpnfiFdPcTxvgEC+QhlipSOJOpkyBfhpQsmXRydKy6unJ
         bZ0w==
X-Gm-Message-State: AFqh2kq40R+yccfFDCmZJ21IMVTtnvE7jmv2I1a/DGL2Mw4pzJyPXVkg
        k2uT5OkddTw2MYtpKWb/2oZipg==
X-Google-Smtp-Source: AMrXdXtu3Iktn9Cz4MoFL4yfd5vhTptO6qsPBOo93yB0yg8qUKRJSNxeEnzXNdXvpxN9DLYwRKaeNA==
X-Received: by 2002:a05:6512:2349:b0:4a4:68b9:66cd with SMTP id p9-20020a056512234900b004a468b966cdmr19134901lfu.24.1673356940384;
        Tue, 10 Jan 2023 05:22:20 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004b5812207dbsm2183000lfe.201.2023.01.10.05.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:22:19 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] interconnect: qcom: rpm: Handle interface clocks
Date:   Tue, 10 Jan 2023 14:22:00 +0100
Message-Id: <20230110132202.956619-9-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132202.956619-1-konrad.dybcio@linaro.org>
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some (but not all) providers (or their specific nodes) require
specific clocks to be turned on before they can be accessed. Failure
to ensure that results in a seemingly random system crash (which
would usually happen at boot with the interconnect driver built-in),
resulting in the platform not booting up properly.

Limit the number of bus_clocks to 2 (which is the maximum that SMD
RPM interconnect supports anyway) and handle non-scaling clocks
separately. Update MSM8996 and SDM660 drivers to make sure they do
not regress with this change.

This unfortunately has to be done in one patch to prevent either
compile errors or broken bisect.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 48 ++++++++++++++++++++++-------
 drivers/interconnect/qcom/icc-rpm.h | 10 ++++--
 drivers/interconnect/qcom/msm8996.c | 22 ++++++-------
 drivers/interconnect/qcom/sdm660.c  | 16 ++++------
 4 files changed, 60 insertions(+), 36 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 150ae89e0a1a..12c58f9237e8 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -460,28 +460,43 @@ int qnoc_probe(struct platform_device *pdev)
 	qnodes = desc->nodes;
 	num_nodes = desc->num_nodes;
 
-	if (desc->num_bus_clocks) {
-		cds = desc->bus_clocks;
-		cd_num = desc->num_bus_clocks;
+	if (desc->num_intf_clocks) {
+		cds = desc->intf_clocks;
+		cd_num = desc->num_intf_clocks;
 	} else {
-		cds = bus_clocks;
-		cd_num = ARRAY_SIZE(bus_clocks);
+		/* 0 intf clocks is perfectly fine */
+		cd_num = 0;
 	}
 
-	qp = devm_kzalloc(dev, struct_size(qp, bus_clks, cd_num), GFP_KERNEL);
+	qp = devm_kzalloc(dev, struct_size(qp, intf_clks, cd_num), GFP_KERNEL);
 	if (!qp)
 		return -ENOMEM;
 
-	qp->bus_clk_rate = devm_kcalloc(dev, cd_num, sizeof(*qp->bus_clk_rate),
-					GFP_KERNEL);
-	if (!qp->bus_clk_rate)
-		return -ENOMEM;
-
 	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	for (i = 0; i < cd_num; i++)
+		qp->intf_clks[i].id = cds[i];
+	qp->num_intf_clks = cd_num;
+
+	if (desc->num_bus_clocks) {
+		cds = desc->bus_clocks;
+		cd_num = desc->num_bus_clocks;
+	} else {
+		cds = bus_clocks;
+		cd_num = ARRAY_SIZE(bus_clocks);
+	}
+
+	/*
+	 * This is not realistic, scaling is only possible with an
+	 * always-active and an active-only clock, or at least one
+	 * of them in some very bizzare cases.
+	 */
+	if (WARN_ON(cd_num > 2))
+		cd_num = 2;
+
 	for (i = 0; i < cd_num; i++)
 		qp->bus_clks[i].id = cds[i];
 	qp->num_bus_clks = cd_num;
@@ -522,6 +537,14 @@ int qnoc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_clk_bulk_get(dev, qp->num_intf_clks, qp->intf_clks);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(qp->num_intf_clks, qp->intf_clks);
+	if (ret)
+		return ret;
+
 	if (desc->has_bus_pd) {
 		ret = dev_pm_domain_attach(dev, true);
 		if (ret)
@@ -540,6 +563,7 @@ int qnoc_probe(struct platform_device *pdev)
 	ret = icc_provider_add(provider);
 	if (ret) {
 		dev_err(dev, "error adding interconnect provider: %d\n", ret);
+		clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
 		clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 		return ret;
 	}
@@ -573,6 +597,7 @@ int qnoc_probe(struct platform_device *pdev)
 	return 0;
 err:
 	icc_nodes_remove(provider);
+	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
 	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(provider);
 
@@ -585,6 +610,7 @@ int qnoc_remove(struct platform_device *pdev)
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
 	icc_nodes_remove(&qp->provider);
+	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
 	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(&qp->provider);
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index d55d2bd44b7d..b4888e4cb74a 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -24,20 +24,24 @@ enum qcom_icc_type {
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
  * @num_bus_clks: the total number of bus_clks clk_bulk_data entries
+ * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
  * @qos_offset: offset to QoS registers
  * @bus_clk_rate: bus clock rate in Hz
  * @bus_clks: the clk_bulk_data table of bus clocks
+ * @intf_clks: the clk_bulk_data table of interface clocks
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
 	int num_bus_clks;
+	int num_intf_clks;
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	int qos_offset;
-	u64 *bus_clk_rate;
-	struct clk_bulk_data bus_clks[];
+	u64 bus_clk_rate[2];
+	struct clk_bulk_data bus_clks[2];
+	struct clk_bulk_data intf_clks[];
 };
 
 /**
@@ -93,6 +97,8 @@ struct qcom_icc_desc {
 	size_t num_nodes;
 	const char * const *bus_clocks;
 	size_t num_bus_clocks;
+	const char * const *intf_clocks;
+	size_t num_intf_clocks;
 	bool has_bus_pd;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 69fc50a6fa5c..1a5e0ad36cc4 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -21,21 +21,17 @@
 #include "smd-rpm.h"
 #include "msm8996.h"
 
-static const char * const bus_mm_clocks[] = {
-	"bus",
-	"bus_a",
+static const char * const mm_intf_clocks[] = {
 	"iface"
 };
 
-static const char * const bus_a0noc_clocks[] = {
+static const char * const a0noc_intf_clocks[] = {
 	"aggre0_snoc_axi",
 	"aggre0_cnoc_ahb",
 	"aggre0_noc_mpu_cfg"
 };
 
-static const char * const bus_a2noc_clocks[] = {
-	"bus",
-	"bus_a",
+static const char * const a2noc_intf_clocks[] = {
 	"aggre2_ufs_axi",
 	"ufs_axi"
 };
@@ -1821,8 +1817,8 @@ static const struct qcom_icc_desc msm8996_a0noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a0noc_nodes,
 	.num_nodes = ARRAY_SIZE(a0noc_nodes),
-	.bus_clocks = bus_a0noc_clocks,
-	.num_bus_clocks = ARRAY_SIZE(bus_a0noc_clocks),
+	.intf_clocks = a0noc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
 	.has_bus_pd = true,
 	.regmap_cfg = &msm8996_a0noc_regmap_config
 };
@@ -1866,8 +1862,8 @@ static const struct qcom_icc_desc msm8996_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(a2noc_nodes),
-	.bus_clocks = bus_a2noc_clocks,
-	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
+	.intf_clocks = a2noc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &msm8996_a2noc_regmap_config
 };
 
@@ -2005,8 +2001,8 @@ static const struct qcom_icc_desc msm8996_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(mnoc_nodes),
-	.bus_clocks = bus_mm_clocks,
-	.num_bus_clocks = ARRAY_SIZE(bus_mm_clocks),
+	.intf_clocks = mm_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &msm8996_mnoc_regmap_config
 };
 
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index a22ba821efbf..0e8a96f4ce90 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -127,15 +127,11 @@ enum {
 	SDM660_SNOC,
 };
 
-static const char * const bus_mm_clocks[] = {
-	"bus",
-	"bus_a",
+static const char * const mm_intf_clocks[] = {
 	"iface",
 };
 
-static const char * const bus_a2noc_clocks[] = {
-	"bus",
-	"bus_a",
+static const char * const a2noc_intf_clocks[] = {
 	"ipa",
 	"ufs_axi",
 	"aggre2_ufs_axi",
@@ -1516,8 +1512,8 @@ static const struct qcom_icc_desc sdm660_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_a2noc_nodes),
-	.bus_clocks = bus_a2noc_clocks,
-	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
+	.intf_clocks = a2noc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &sdm660_a2noc_regmap_config,
 };
 
@@ -1659,8 +1655,8 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
-	.bus_clocks = bus_mm_clocks,
-	.num_bus_clocks = ARRAY_SIZE(bus_mm_clocks),
+	.intf_clocks = mm_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
 };
 
-- 
2.39.0

