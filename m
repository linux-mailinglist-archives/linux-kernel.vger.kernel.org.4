Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A63715BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjE3KWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjE3KVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:21:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28366E52
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4f3ac389eso3272954e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442026; x=1688034026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE9KmIznItqWnCSTnUqicH57PGCaUmqYc5HUve0PMes=;
        b=YLw+Xz+2KXouJOvh/BOcNzeY5BGzOvHkTk53JlVG3CMzRVKsfO1CjsJQGwp/juD7wa
         GDQ6W8m7ppaGBS+94cfGuGOCUHvszlcr+0Rycv901OY3XhZR9J9M7Pb/sfCKsQ2cKaM4
         6mg87LtD2iTWi7qwVsBa9tJWuiuhtzEf+qq/WICQqNGacXJPuQXqzjwzA+4csHtSkyAf
         SQElYKuVmKGTB8U/mOjQs21OnCtEU1RjSQaUHeFC61CMXWVCqtfIOSHdT2MASfVoK7tB
         p54z7Wl5360EkhWaNhmYJQeZF9yekFHuJNUgT5ewenplHcBEDwM0GNTvmXLQgdFAPNBc
         jsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442026; x=1688034026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE9KmIznItqWnCSTnUqicH57PGCaUmqYc5HUve0PMes=;
        b=Zv053wRBsyEgqqauCrAjHuNc9yJsdPPT3OVxclriQUrTpA6EC/TkPcSZwYwl1mMDhc
         Zq/0u/IDSPGY/WYBOQM1mCTKApCPtAdRhS4e1oxgz2e+juI6zB1UYDCUJcfjOb8dk3OO
         Haojgs7OKm2LmjsLk5eoHb22hpe5vrhTmY5t/ZuUR8vxThrEnI+Na0131/5Q50Yf8lfD
         mz16YNrmtvuUs6jyO56ouPAg+qoCQnv0ylHQsBQtc5pmIMlZwuDJg14FiBh10BAB2K0W
         9yH/YUuqiK3zffSIBPJ6ndbYWOuoueS0j5ZfK+Nf0hov1zwRp5CPIJYfcv0tKFA1Taco
         ghpg==
X-Gm-Message-State: AC+VfDxaTvXRGhgtVd4cp1Mx9IL4xJjD/+bGSYsrLuahmq/sNLEVWCbP
        0hB42Iqc8hIYLmDXSpuUFgqrUg==
X-Google-Smtp-Source: ACHHUZ7SyRULsDyA+6dznZlKkX8+dg6bD1dSczFk4Sb8SLAPiIbq14WerviK2BmBzgViZkNoPkre4A==
X-Received: by 2002:ac2:5e9d:0:b0:4f4:aea9:2a2f with SMTP id b29-20020ac25e9d000000b004f4aea92a2fmr538180lfq.57.1685442026316;
        Tue, 30 May 2023 03:20:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:16 +0200
Subject: [PATCH 17/20] interconnect: qcom: icc-rpm: Control bus rpmcc from
 icc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-17-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=10121;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=aP8J4AdQjIOY3Lruog99oSFWs3dB/beHPwMsHaT8NM0=;
 b=BTicK7c8Y8zFMTWNrtDt1ThVN8wH/NLxl58tobKhIX3ziqJowswFL+toUM8ZIZZR71yAlIL1r
 EVeUhpglyf6D4uELpdM9VZLXYhvlpkDWw+JOSMRakLnMAH72qz+zz6w
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sole purpose of bus clocks that were previously registered with
rpmcc was to convey the aggregated bandwidth to RPM. There's no good
reason to keep them outside the interconnect framework, as it only
adds to the plentiful complexity.

Add the required code to handle these clocks from within SMD RPM ICC.

RPM-owned bus clocks are no longer considered a thing, but sadly we
have to allow for the existence of HLOS-owned bus clocks, as some
(mostly older) SoCs (ab)use these for bus scaling (e.g. MSM8998 and
&mmcc AHB_CLK_SRC).

This in turn is trivially solved with a single *clk, which is filled
and used iff qp.bus_clk_desc is absent and we have a "bus" clock-names
entry in the DT node.

This change should(tm) be fully compatible with all sorts of old
Device Trees as far as the interconnect functionality goes (modulo
abusing bus clock handles, but that's a mistake in and of itself).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 116 +++++++++++++++++++-----------------
 drivers/interconnect/qcom/icc-rpm.h |  13 ++--
 drivers/interconnect/qcom/msm8996.c |   1 -
 drivers/interconnect/qcom/sdm660.c  |   1 -
 4 files changed, 66 insertions(+), 65 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index b8ecf9538ab9..d08eefd963f4 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -49,7 +49,7 @@
 #define NOC_QOS_MODE_FIXED_VAL		0x0
 #define NOC_QOS_MODE_BYPASS_VAL		0x2
 
-#define ICC_BUS_CLK_MIN_RATE		19200000ULL
+#define ICC_BUS_CLK_MIN_RATE		19200ULL /* kHz */
 
 static int qcom_icc_set_qnoc_qos(struct icc_node *src)
 {
@@ -338,11 +338,10 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
 	struct icc_provider *provider;
 	u64 sum_bw;
-	u64 rate;
+	u64 active_rate, sleep_rate;
 	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
 	u64 max_agg_avg;
-	int ret, i;
-	int bucket;
+	int ret;
 
 	src_qn = src->data;
 	if (dst)
@@ -364,49 +363,50 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 			return ret;
 	}
 
-	for (i = 0; i < qp->num_bus_clks; i++) {
-		/*
-		 * Use WAKE bucket for active clock, otherwise, use SLEEP bucket
-		 * for other clocks.  If a platform doesn't set interconnect
-		 * path tags, by default use sleep bucket for all clocks.
-		 *
-		 * Note, AMC bucket is not supported yet.
-		 */
-		if (!strcmp(qp->bus_clks[i].id, "bus_a"))
-			bucket = QCOM_ICC_BUCKET_WAKE;
-		else
-			bucket = QCOM_ICC_BUCKET_SLEEP;
-
-		rate = icc_units_to_bps(max(agg_avg[bucket], agg_peak[bucket]));
-		do_div(rate, src_qn->buswidth);
-		rate = min_t(u64, rate, LONG_MAX);
-
-		/*
-		 * Downstream checks whether the requested rate is zero, but it makes little sense
-		 * to vote for a value that's below the lower threshold, so let's not do so.
-		 */
-		if (bucket == QCOM_ICC_BUCKET_WAKE && qp->keep_alive)
-			rate = max(ICC_BUS_CLK_MIN_RATE, rate);
-
-		if (qp->bus_clk_rate[i] == rate)
-			continue;
-
-		ret = clk_set_rate(qp->bus_clks[i].clk, rate);
-		if (ret) {
-			pr_err("%s clk_set_rate error: %d\n",
-			       qp->bus_clks[i].id, ret);
+	/* Some providers don't have a bus clock to scale */
+	if (!qp->bus_clk_desc)
+		return 0;
+
+	/* Intentionally keep the rates in kHz as that's what RPM accepts */
+	active_rate = max(agg_avg[QCOM_SMD_RPM_ACTIVE_STATE],
+			  agg_peak[QCOM_SMD_RPM_ACTIVE_STATE]);
+	do_div(active_rate, src_qn->buswidth);
+
+	sleep_rate = max(agg_avg[QCOM_SMD_RPM_SLEEP_STATE],
+			 agg_peak[QCOM_SMD_RPM_SLEEP_STATE]);
+	do_div(sleep_rate, src_qn->buswidth);
+
+	/*
+	 * Downstream checks whether the requested rate is zero, but it makes little sense
+	 * to vote for a value that's below the lower threshold, so let's not do so.
+	 */
+	if (qp->keep_alive)
+		active_rate = max(ICC_BUS_CLK_MIN_RATE, active_rate);
+
+	/* Some providers have a non-RPM-owned bus clock - convert kHz->Hz for the CCF */
+	if (qp->bus_clk)
+		return clk_set_rate(qp->bus_clk, 1000ULL * max(active_rate, sleep_rate));
+
+	/* RPM only accepts <=INT_MAX rates */
+	active_rate = min_t(u32, active_rate, INT_MAX);
+	sleep_rate = min_t(u32, sleep_rate, INT_MAX);
+
+	if ((active_rate != qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]) ||
+	    (sleep_rate != qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE])) {
+		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc,
+						active_rate,
+						sleep_rate);
+		if (ret)
 			return ret;
-		}
-		qp->bus_clk_rate[i] = rate;
 	}
 
+	/* Cache the rate after we've successfully commited it to RPM */
+	qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE] = active_rate;
+	qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE] = sleep_rate;
+
 	return 0;
 }
 
-static const char * const bus_clocks[] = {
-	"bus", "bus_a",
-};
-
 int qnoc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -448,6 +448,18 @@ int qnoc_probe(struct platform_device *pdev)
 	if (!qp->intf_clks)
 		return -ENOMEM;
 
+	if (desc->bus_clk_desc) {
+		qp->bus_clk_desc = devm_kzalloc(dev, sizeof(*qp->bus_clk_desc),
+						GFP_KERNEL);
+		if (!qp->bus_clk_desc)
+			return -ENOMEM;
+
+		qp->bus_clk_desc = desc->bus_clk_desc;
+	} else if (!IS_ERR(devm_clk_get(dev, "bus"))) {
+		/* Some older SoCs may have a single non-RPM-owned bus clock. */
+		qp->bus_clk = devm_clk_get(dev, "bus");
+	}
+
 	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
 			    GFP_KERNEL);
 	if (!data)
@@ -457,10 +469,6 @@ int qnoc_probe(struct platform_device *pdev)
 	for (i = 0; i < cd_num; i++)
 		qp->intf_clks[i].id = cds[i];
 
-	qp->num_bus_clks = desc->no_clk_scaling ? 0 : NUM_BUS_CLKS;
-	for (i = 0; i < qp->num_bus_clks; i++)
-		qp->bus_clks[i].id = bus_clocks[i];
-
 	qp->keep_alive = desc->keep_alive;
 	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
@@ -490,13 +498,11 @@ int qnoc_probe(struct platform_device *pdev)
 	}
 
 regmap_done:
-	ret = devm_clk_bulk_get(dev, qp->num_bus_clks, qp->bus_clks);
-	if (ret)
-		return ret;
-
-	ret = clk_bulk_prepare_enable(qp->num_bus_clks, qp->bus_clks);
-	if (ret)
-		return ret;
+	if (qp->bus_clk) {
+		ret = clk_prepare_enable(qp->bus_clk);
+		if (ret)
+			return ret;
+	}
 
 	ret = devm_clk_bulk_get(dev, qp->num_intf_clks, qp->intf_clks);
 	if (ret)
@@ -566,7 +572,8 @@ int qnoc_probe(struct platform_device *pdev)
 	icc_provider_deregister(provider);
 err_remove_nodes:
 	icc_nodes_remove(provider);
-	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
+	if (qp->bus_clk)
+		clk_disable_unprepare(qp->bus_clk);
 
 	return ret;
 }
@@ -578,7 +585,8 @@ int qnoc_remove(struct platform_device *pdev)
 
 	icc_provider_deregister(&qp->provider);
 	icc_nodes_remove(&qp->provider);
-	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
+	if (qp->bus_clk)
+		clk_disable_unprepare(qp->bus_clk);
 
 	return 0;
 }
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index e3df066fd94e..2c8c0399378b 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -36,32 +36,29 @@ struct rpm_clk_resource {
 	bool branch;
 };
 
-#define NUM_BUS_CLKS	2
-
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
- * @num_bus_clks: the total number of bus_clks clk_bulk_data entries (0 or 2)
  * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
  * @bus_clk_rate: bus clock rate in Hz
- * @bus_clks: the clk_bulk_data table of bus clocks
+ * @bus_clk_desc: a pointer to a rpm_clk_resource description of bus clocks
  * @intf_clks: a clk_bulk_data array of interface clocks
+ * @bus_clk: a pointer to a HLOS-owned bus clock
  * @qos_offset: offset to QoS registers
  * @keep_alive: whether to always keep a minimum vote on the bus clocks
  * @is_on: whether the bus is powered on
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
-	int num_bus_clks;
 	int num_intf_clks;
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	int qos_offset;
-	u64 bus_clk_rate[NUM_BUS_CLKS];
-	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
+	u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
 	const struct rpm_clk_resource *bus_clk_desc;
+	struct clk *bus_clk;
 	struct clk_bulk_data *intf_clks;
 	bool keep_alive;
 	bool is_on;
@@ -118,12 +115,10 @@ struct qcom_icc_node {
 struct qcom_icc_desc {
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
-	const char * const *bus_clocks;
 	const struct rpm_clk_resource *bus_clk_desc;
 	const char * const *intf_clocks;
 	size_t num_intf_clocks;
 	bool keep_alive;
-	bool no_clk_scaling;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
 	int qos_offset;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index a596f4035d2e..8081b3cb1025 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -1818,7 +1818,6 @@ static const struct qcom_icc_desc msm8996_a0noc = {
 	.num_nodes = ARRAY_SIZE(a0noc_nodes),
 	.intf_clocks = a0noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
-	.no_clk_scaling = true,
 	.regmap_cfg = &msm8996_a0noc_regmap_config
 };
 
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 5743ed680e8e..211fa1fa569c 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1618,7 +1618,6 @@ static const struct qcom_icc_desc sdm660_gnoc = {
 	.nodes = sdm660_gnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_gnoc_nodes),
 	.regmap_cfg = &sdm660_gnoc_regmap_config,
-	.no_clk_scaling = true,
 };
 
 static struct qcom_icc_node * const sdm660_mnoc_nodes[] = {

-- 
2.40.1

