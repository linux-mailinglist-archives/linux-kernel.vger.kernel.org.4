Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A388C6DB507
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDGUPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjDGUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:14:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A4CBDEE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:14:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h11so48737592lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680898492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5L4qO6sptV54f0r3fZ5sm9NYcIKr5uU7vIOhE3jPUY=;
        b=KRoccwvY9iA69vsgL79vikKueXuzVk2lCUlkshcNGY5+Zi1d5GQRf+phP6tWX7Ze7b
         zTh1DJcGfMaBgEBzRk5W56N8al/CLfA288RgU4heVycb1VFk8fZ8BdD5z3I2dHYugweh
         KRoasZ6/8T5AxXSgYqL81mA2qHmvgkS3TvhTEuDfK7VaADT0qNP5GWtLM96qQMSKhBzu
         tK2rXyd45yu25D4/eb7zN6bYWDilWSgZ9H8yq77Lv/z4mZ2IdAizZ5MKgkKuTQWzk8o8
         CSfNRdwSE5Xsrz61vfyThEMShPXiZEBcRbeq8IJisVwzBZyaDJ/IYHhQN2EtdqKQN+gN
         7Rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680898492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5L4qO6sptV54f0r3fZ5sm9NYcIKr5uU7vIOhE3jPUY=;
        b=FaNrsFnOXYYDNN9Gjb0zOsSpo2Qg0pxdTHh+0gZb0ngp9AqZv7TlOksNaQyAy5nEfA
         toLzYzGQk7DAY4xSxqaeDNzeKt0psckdc0OLvM4UjaG5SYQ0aeN0hTZVE1S0sKDHvwXZ
         ikPqVUACS18uToSp1uRMd/m3e/sgQi2+B7aJdar33Kau0TTTq2mzgFpzUXxOUe4x9Coe
         t9RkIImJk+HA8kcTS+0iCjX2h1IcS6eXS6gAyVKwjcA4b+KesIDmvuy9kIWFATexUi0H
         JYuAtp8+qUL3GPmpiVuKNtmfIy7wHUBZrPFLNGBIWVDsix+vpRDDk7b5VmUJ6eIdvHn9
         pbQw==
X-Gm-Message-State: AAQBX9fwwmxJUHLsKGrTkYT8EAR5CbpqWP8Ev0FGhgEFRRdOVk0CDx+p
        bjcIcK39jPWcM9o9o54p6eTB3A==
X-Google-Smtp-Source: AKy350ZHvjOGZdykbEN99fX0cqIHIHR69XFmwVpsgMiQfL5C3ew4xTOWmEnn6s0F2ii6fHw4bn+yyg==
X-Received: by 2002:ac2:5509:0:b0:4eb:18d:91df with SMTP id j9-20020ac25509000000b004eb018d91dfmr966362lfk.27.1680898492250;
        Fri, 07 Apr 2023 13:14:52 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u3-20020ac243c3000000b004eaf6181a32sm842436lfl.75.2023.04.07.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 13:14:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 22:14:47 +0200
Subject: [PATCH v8 5/8] interconnect: qcom: rpm: Handle interface clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v8-5-ee696a2c15a9@linaro.org>
References: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
In-Reply-To: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680898484; l=8428;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VP8quBVKpEptQIgT3Ham+bzqxwEHAFZBRJ/Y+InEks8=;
 b=lWQndPNnQQD6egbXgG0eBagLWLx9sNHAvZCstcObDRRoSN28CBrIgoU1iUYFq9MVNnJpRWGFEOH+
 RUxiX3SuDbg3lXbZXrMFVdAqQZ51QW6Ioh7vsmKr6PnTaBfEA1EG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/interconnect/qcom/icc-rpm.c | 40 ++++++++++++++++++++++++++++---------
 drivers/interconnect/qcom/icc-rpm.h | 14 +++++++++++--
 drivers/interconnect/qcom/msm8996.c | 22 +++++++++-----------
 drivers/interconnect/qcom/sdm660.c  | 16 ++++++---------
 4 files changed, 58 insertions(+), 34 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index d79e508cb717..419b2122bebd 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -424,21 +424,20 @@ int qnoc_probe(struct platform_device *pdev)
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
@@ -446,6 +445,18 @@ int qnoc_probe(struct platform_device *pdev)
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
@@ -486,6 +497,10 @@ int qnoc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_clk_bulk_get(dev, qp->num_intf_clks, qp->intf_clks);
+	if (ret)
+		return ret;
+
 	provider = &qp->provider;
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
@@ -496,6 +511,11 @@ int qnoc_probe(struct platform_device *pdev)
 
 	icc_provider_init(provider);
 
+	/* If this fails, bus accesses will crash the platform! */
+	ret = clk_bulk_prepare_enable(qp->num_intf_clks, qp->intf_clks);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < num_nodes; i++) {
 		size_t j;
 
@@ -524,6 +544,8 @@ int qnoc_probe(struct platform_device *pdev)
 	}
 	data->num_nodes = num_nodes;
 
+	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
+
 	ret = icc_provider_register(provider);
 	if (ret)
 		goto err_remove_nodes;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 2436777820a4..b9b63860042f 100644
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
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
 	unsigned int qos_offset;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 21f998cd19f0..9aedfc8de4bf 100644
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
 	.regmap_cfg = &msm8996_a0noc_regmap_config
 };
 
@@ -1865,8 +1861,8 @@ static const struct qcom_icc_desc msm8996_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(a2noc_nodes),
-	.bus_clocks = bus_a2noc_clocks,
-	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
+	.intf_clocks = a2noc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &msm8996_a2noc_regmap_config
 };
 
@@ -2004,8 +2000,8 @@ static const struct qcom_icc_desc msm8996_mnoc = {
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
2.40.0

