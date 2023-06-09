Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A654572A49E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjFIUUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjFIUT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:19:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFEB423B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:19:39 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f642a24568so2743974e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341977; x=1688933977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cb9xdecodEODemYoEb87K9ta+9ODW7Umb800Ol1DryA=;
        b=qZRNYb4Bo+/7cX6qEu86m/QHxZHvVR/0NZm30urPlNSm24dYvyXnS3Dm0k5ss+CtH2
         ZYRbC9OxtnjwATPKbmYakjcQt3BD94YxgXvJ8iM9vtPBuTtoxsBS9Y3xTVFds9U5DNFp
         qJD0gvH3mz9Gb9/A8ToPZDyY+qYBLPza4uWyvHLUkE2ZvaEmuZEIbtv6XFWsnYaJuED/
         gkrirlE3RtWQJblrsb38EngqHelDl4U+6fFAIZwJ5Dpzi3GzzYqr44LTEIAM2wLbQ2YL
         6Ba2QpHUXo9NcFbaSI2XgX3cdbJyxXkLV6p+E2ajHMjXwHGgY9RaCWIN+P3mtdDT1kto
         Wr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341977; x=1688933977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb9xdecodEODemYoEb87K9ta+9ODW7Umb800Ol1DryA=;
        b=fkURAowc6q6x/vk2pfas9bSnCvEwX5raOpgUViubURYel0+5mfXJVpTJDqhfR9Uexy
         Pt/GGyQ10wl894FSYw4HdzYzMlMzz3TLSserSi4bYFk4I7IzwBpfg/J7sM0+Rbp/VQEC
         0vOsIdgWMGb7gP519uIYxE2DZcyYPctC/c0rKPzhwbURayu7VvagOSaLBxWk68oeWx/8
         kbKgaQ1lCsM+o+DmCcJfuRlZaThSZ49Dg0XAihzq6f8Emz7okY5umqr9cKtgH3xSytsv
         wxtWKgGUyYZEn9qcLRxaAxbRCMlcBeLBF37GbBBHjjlhs3rYoEWoePw5E2bzGfivD90J
         EIaw==
X-Gm-Message-State: AC+VfDyUQdAB16YUDrxAbbsqMm8EaBIhNMuNyOtV7rrEJKMasVfW6WsG
        HTF57wJZWMI/2b/u3+Kp6fAJZA==
X-Google-Smtp-Source: ACHHUZ4YbNI5DZk/qm+mBfW2Hdo2GPMEcmv2dEjacvj4xekfSBsXfb/fZdpAWD1xsrLzuuVQz3v/sA==
X-Received: by 2002:a19:9101:0:b0:4f6:1863:6b47 with SMTP id t1-20020a199101000000b004f618636b47mr1507408lfd.42.1686341977119;
        Fri, 09 Jun 2023 13:19:37 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:36 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:22 +0200
Subject: [PATCH v2 17/22] interconnect: qcom: icc-rpm: Control bus rpmcc
 from icc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-17-e5934b07d813@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=10137;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fOhhClfVLnFquoGaJCo3CMfLNuorMvSsi2R+II9EBuU=;
 b=fHRtogQIJJdopGqOJNns6sC5uWJPr8lNn6DAAokpNgextWTESGxxMmRkIyfX2mWOG95pqvQiQ
 VBKrChq5Wl5BG9z+nBbwilCEsDivc38bXt/0UHKwgHVXMFOttIdVce1
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
index b8ecf9538ab9..6d40815c5401 100644
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
+	if (!qp->bus_clk_desc && !qp->bus_clk)
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
index 99e34f684c85..11e7d503e4d0 100644
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
2.41.0

