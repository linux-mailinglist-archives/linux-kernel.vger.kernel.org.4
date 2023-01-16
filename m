Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA466BFB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjAPNWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjAPNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:22:21 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573971969A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:09 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o20so10731583lfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEgLdu9MBr5gHEyywHfCPlxu1SSAFMcXzGeB6TYQjOY=;
        b=sv/MiCcegjMVGmNJoieYkPeFvcWeYPUEoO5o5MeA92zqwe3jay2mboEWMrBtL8A1s4
         BoYIFDdxSPoX1QOxp9AAo8fZ0oYgk6v0V/fSmSvGWCgq2/0Vys7fIO5Spn0r18jr98ES
         0ZayDKMNd/uaR2hy3ZeSssSjisjpxrQ4Oj4nVMIH76b83+QnvFxJTFUFR/Xq8Q8qU0C6
         CGu9fgs9SV7P61AepFqq+YvO7gWvfi4QHK9sgSrHLkIjsAShHnoGfSLWuKdsH6yjMF2K
         BGfXcqX2bvBil2icX3rfzKn1cR8ob614j13VF2nbxs7YBJ+Fs+PTIHMqwIoYOMuibFBI
         205g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEgLdu9MBr5gHEyywHfCPlxu1SSAFMcXzGeB6TYQjOY=;
        b=jO+CiX7WuFyL8a1KuZU2NR8h2HsIbWRNXMYJNzqw4Du98mnKNu5FMZNO3/Sg1jgvec
         0oLS99ksRZipbkcsiEPhY5eASeCUcuB1V1kIoloZLhhKa5eYt8hZgDmbKK5oJRZDb8wd
         dKxquj/B5kGWVrRtN8CgM8PJxQwfvNObCRij6M72qm91DriNko1h8v+qNo7EijSh1HKY
         7mKAu+aLhDl1cWPkcswOlFfc6tSvSzuv3wpeGpEJFUvOvtx2XZYUUUWJGJfgRzpJPnpA
         vLm2Leteqo3DYOvqLmnx2TxuJk9h4BcZaiYPLoSzUTpco/yE993iDsPcjgkikmHzWbpZ
         jlng==
X-Gm-Message-State: AFqh2kpiGlZ4nfu2+3W40Swtqtt76rTZsUwOcAB+LXzNhzelLFt9r5rf
        Cw+OQCLat28ft0RZ7xGp+LTzgA==
X-Google-Smtp-Source: AMrXdXuSzfyp3y4Ri1oExdUC2zPF7pJRuDiIL9FmFjR6sfQAD0oQaxVKPbUFI/g7vzo/HwWXSVF8bw==
X-Received: by 2002:a05:6512:3b99:b0:4a4:68b9:608c with SMTP id g25-20020a0565123b9900b004a468b9608cmr32382673lfv.23.1673875328874;
        Mon, 16 Jan 2023 05:22:08 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id p9-20020a05651212c900b004cc58b91177sm5016653lfg.239.2023.01.16.05.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 05:22:08 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/9] interconnect: qcom: rpm: Handle interface clocks
Date:   Mon, 16 Jan 2023 14:21:50 +0100
Message-Id: <20230116132152.405535-8-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116132152.405535-1-konrad.dybcio@linaro.org>
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
index 5888241c0477..509cadf398e9 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -453,28 +453,43 @@ int qnoc_probe(struct platform_device *pdev)
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
@@ -515,6 +530,14 @@ int qnoc_probe(struct platform_device *pdev)
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
@@ -533,6 +556,7 @@ int qnoc_probe(struct platform_device *pdev)
 	ret = icc_provider_add(provider);
 	if (ret) {
 		dev_err(dev, "error adding interconnect provider: %d\n", ret);
+		clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
 		clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 		return ret;
 	}
@@ -566,6 +590,7 @@ int qnoc_probe(struct platform_device *pdev)
 	return 0;
 err:
 	icc_nodes_remove(provider);
+	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
 	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(provider);
 
@@ -578,6 +603,7 @@ int qnoc_remove(struct platform_device *pdev)
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
 	icc_nodes_remove(&qp->provider);
+	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
 	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(&qp->provider);
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index d4401f35f6d2..729573f0d9fe 100644
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
 	unsigned int qos_offset;
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

