Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD086B1460
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCHVlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCHVl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:41:29 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E79168A3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:41:04 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b10so18094155ljr.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAhLMOlOq8f0+6Y4C/vkVQURcQ846rkCvSSk/ic0CAg=;
        b=jL/mRilnQ9nv8751BSDNu2kFNMErSUfny2/2iqo0F1pGYomUWK0shx2uILI4zc3LVt
         vIjLymxwCnx4vUSAs+yTkzZePGfPV3VmKkvDCacFcBJoMO5XdeSm1CnaF49JAeeWuk1S
         yYm0dV+UBUusQ5D7Xlj2b05skOrMWNM8b3PO2Wp+CWsOzKziD06T14TdWW5EpS3DZnUw
         H8d7JdmsLBDAMJX+6tebKerKL7JnVHlDBLBKcEdUSeCcjCsOn4c3GpW9XNnvYzvagVxa
         8Oo17X7M4l7ptEgHVpsTOHL2+rUD7WKKIs4orjAvNXV6bS0FJo/cdmPJzULEuBR3mTyl
         qhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAhLMOlOq8f0+6Y4C/vkVQURcQ846rkCvSSk/ic0CAg=;
        b=nACo0e1xFEb91GjpPSeRGHzCQYi+jdvUYOpo5n938eDGqFq+mlUVPq4C810Gj68zg8
         aj04pevPZJ75TOwaVj1Tpmpg8gsnQgH3e7Q7B9L1YtWP8TxU/je5sWGxRiHGrd1NNqkn
         45rhsc/TDrRuuQNux4c/Gsp4Mnhr5FF8zbjqVnY4EbUs5XU0mjeLeuCKM7kyizdfNyoi
         TGlEBoYIC/xsf7anXHUZfy1SdAopwyYfIHZzWrxkrMmeHAe6rhCcu8f9tYP4D++JIIhm
         EJUtyFud/MxFSd+DJexaqoH13WfVJAaiXOfa4xXHJu/FPQzGAAS6hlsTPaJDT/nWr0Ty
         wwCw==
X-Gm-Message-State: AO0yUKV6eaLmyXhV74ipfUCQdTQtXbV5z7zD7gMcfIRA3lCgptndtwO1
        S0GqLJAwgqv5CrmS8APjCHguakCb61pN3cystAU=
X-Google-Smtp-Source: AK7set9B0VQ2MJtkj5oqVSETdtCb4lQiH9K7x8lFn4qjDv4wxwnd0vY8025p1wwb7ZmSwEsuhW0aDg==
X-Received: by 2002:a2e:b014:0:b0:295:ab17:c98e with SMTP id y20-20020a2eb014000000b00295ab17c98emr5756631ljk.20.1678311632848;
        Wed, 08 Mar 2023 13:40:32 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a6-20020a2e8606000000b00295a2a608e9sm2688844lji.111.2023.03.08.13.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:40:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:40:12 +0100
Subject: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v7-6-815606092fff@linaro.org>
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
In-Reply-To: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311609; l=8939;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=zxoyRaDjRCEGCD17MC1LW/4OmB7mruBwQv24D0PVHh0=;
 b=j9B0Ya0yuP6y3htkWsWdiIW21nuhIgBqFbFetRb1sh37wKwgJmnooiCqm2QoH1ZMKFv2I9AqLMpR
 kpeMkiZYDHrgZ1ZqYApiPh+tjgqXPHTrHmGkDUUIQd2yxQmTLJhO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 drivers/interconnect/qcom/icc-rpm.c | 52 ++++++++++++++++++++++++++++++-------
 drivers/interconnect/qcom/icc-rpm.h | 14 ++++++++--
 drivers/interconnect/qcom/msm8996.c | 22 +++++++---------
 drivers/interconnect/qcom/sdm660.c  | 16 +++++-------
 4 files changed, 70 insertions(+), 34 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index b52f788d8f3d..ca932ed720fb 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -369,6 +369,17 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 
 	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
 
+	/* If we're powering on the bus, ensure the necessary clocks are on */
+	if (unlikely(!qp->is_on)) {
+		if (agg_peak[0] || agg_peak[1] || max_agg_avg) {
+			/* If this fails, bus accesses will crash the platform! */
+			ret = clk_bulk_prepare_enable(qp->num_intf_clks, qp->intf_clks);
+			if (ret)
+				return ret;
+			qp->is_on = true;
+		}
+	}
+
 	sum_bw = icc_units_to_bps(max_agg_avg);
 
 	ret = __qcom_icc_set(src, src_qn, sum_bw);
@@ -409,6 +420,14 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		qp->bus_clk_rate[i] = rate;
 	}
 
+	/* Turn off the interface clocks if the bus was shut down so as not to leak power */
+	if (!qp->bus_clk_rate[0] && !qp->bus_clk_rate[1]) {
+		if (!agg_peak[0] && !agg_peak[1] && !max_agg_avg) {
+			clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
+			qp->is_on = false;
+		}
+	}
+
 	return 0;
 }
 
@@ -441,21 +460,20 @@ int qnoc_probe(struct platform_device *pdev)
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
+	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
 	if (!qp)
 		return -ENOMEM;
 
-	qp->bus_clk_rate = devm_kcalloc(dev, cd_num, sizeof(*qp->bus_clk_rate),
-					GFP_KERNEL);
-	if (!qp->bus_clk_rate)
+	qp->intf_clks = devm_kzalloc(dev, sizeof(qp->intf_clks), GFP_KERNEL);
+	if (!qp->intf_clks)
 		return -ENOMEM;
 
 	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
@@ -463,6 +481,18 @@ int qnoc_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	qp->num_intf_clks = cd_num;
+	for (i = 0; i < cd_num; i++)
+		qp->intf_clks[i].id = cds[i];
+
+	if (desc->num_bus_clocks) {
+		cds = desc->bus_clocks;
+		cd_num = desc->num_bus_clocks;
+	} else {
+		cds = bus_clocks;
+		cd_num = ARRAY_SIZE(bus_clocks);
+	}
+
 	for (i = 0; i < cd_num; i++)
 		qp->bus_clks[i].id = cds[i];
 	qp->num_bus_clks = cd_num;
@@ -503,6 +533,10 @@ int qnoc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_clk_bulk_get(dev, qp->num_intf_clks, qp->intf_clks);
+	if (ret)
+		return ret;
+
 	if (desc->has_bus_pd) {
 		ret = dev_pm_domain_attach(dev, true);
 		goto err_disable_clks;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index d4401f35f6d2..a4ef45b4a9e0 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -20,24 +20,32 @@ enum qcom_icc_type {
 	QCOM_ICC_QNOC,
 };
 
+#define NUM_BUS_CLKS	2
+
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
  * @num_bus_clks: the total number of bus_clks clk_bulk_data entries
+ * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
  * @qos_offset: offset to QoS registers
  * @bus_clk_rate: bus clock rate in Hz
  * @bus_clks: the clk_bulk_data table of bus clocks
+ * @intf_clks: a clk_bulk_data array of interface clocks
+ * @is_on: whether the bus is powered on
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
 	int num_bus_clks;
+	int num_intf_clks;
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	unsigned int qos_offset;
-	u64 *bus_clk_rate;
-	struct clk_bulk_data bus_clks[];
+	u64 bus_clk_rate[NUM_BUS_CLKS];
+	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
+	struct clk_bulk_data *intf_clks;
+	bool is_on;
 };
 
 /**
@@ -93,6 +101,8 @@ struct qcom_icc_desc {
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
2.39.2

