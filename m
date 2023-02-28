Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F786A5A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjB1Noz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjB1Noe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:44:34 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B103028E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:31 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id x6so4659537ljq.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677591869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kl3xPTTugH2HWda/hWqIzHrROzcubvJx2Ov9R1VPGqc=;
        b=koV3jmLcWcxD8IIKOkQ5Gn2dZDpg0IntmFe7H3tGLTtq9E/dwhK1Ul/mxPDjrKLZrX
         v+5++haHNT5Nsz0+jzP+eP5FfjobpOBnMB4ieXL6OeuqMnMxC5V02NlwpZuVWgx6eiyh
         ZLGN7I9y6O+Xb9moeYfT85hpmxSB+lA0OFhP4wJcQ6LLPvKcOYk/Db63n5xFtRwFH8EF
         w5JKdCx2QQSFvqJIiThp3aoT26stTp7a8Ptbt7cMysqYTwzgFipH3FceXESJ96Wz4pl7
         KNYtSP6tuw8RchidQSEbPVoNWCaFTbM5uM/LXDi4gs36938IPaLfpTumazrncbjT9nvx
         2ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677591869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kl3xPTTugH2HWda/hWqIzHrROzcubvJx2Ov9R1VPGqc=;
        b=zDiC71r8oABuG/P3jRbdsDnOWP5SVAWmp6YcWGZUeIXJKuZorDFWp5j/miOTOzcyPs
         8UkFnUd7FuFTUT1IIcqwH2NOWqYmaU0EMFtt8tzXiuqoBeG2goqhav1AQ2dNo5g1j2lN
         9exPgkWYW4kfNQY7GEJ/vOLBO1cMXtfTXA7zXHvotpX7J5R6o1cHlVXqoIBHO8RisnWm
         o0h3fEAazh7P0ecW/vSJQqgUoPKu3ijoi4m9ypdi6Etv038MYdERKGcFavM6xvAriIvn
         Fd3rtmOqVMDmQ31Ii2Y9G5Rbx15f59ne5RjZVtPvmk9IvMvLkaCJTcpmItiaXxsu6MXZ
         RhBg==
X-Gm-Message-State: AO0yUKVQ7cIAo6T0lTdVxVjpuBgPc/9broKmREWMQgzr4p3ZeErUUkx5
        FBqLARWWow4IAOduYZNVcs7B9Q==
X-Google-Smtp-Source: AK7set+DKx+TKJKhv5jF7Dv5E5s2GPKKBd40YaCixxJ3Gb7zDJKLUuTWpG4HL6wKhbrVjeRir2UoDA==
X-Received: by 2002:a2e:860f:0:b0:295:bb53:b744 with SMTP id a15-20020a2e860f000000b00295bb53b744mr980704lji.9.1677591869451;
        Tue, 28 Feb 2023 05:44:29 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e3c14000000b00295a583a20bsm1203975lja.74.2023.02.28.05.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 05:44:29 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 14:44:03 +0100
Subject: [PATCH v6 6/9] interconnect: qcom: rpm: Handle interface clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v6-6-3c37a349656f@linaro.org>
References: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
In-Reply-To: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677591861; l=8925;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=L4u+hFUnCjmxDTWKQ4WhN9CYhHCxEeDAU+yitlO2+xI=;
 b=b9N8698oXVrxUCTyMYJJbSjljny25hxwRHQIjwuyXCWhv7rInGbdzNq1sRMeTIQRWBR5joOhIEN0
 c6uKuAT6DY8xqgYxsKS1pwUdk4WmvP1qSWxmC4+XuGwjTQl7/dty
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index f78c13e6c5ce..446f6df9bc98 100644
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
 		if (ret)
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

