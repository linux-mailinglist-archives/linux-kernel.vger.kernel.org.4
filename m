Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B582472FAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbjFNKX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbjFNKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:23:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BAB1FC8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b344476595so6676891fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738162; x=1689330162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlqYpjuSg3Kq2NwTKyv6stGdQ/pys1z7oXzpwBh52Xg=;
        b=IlAJceLx5pmPfOXHMNzQD2QQc0QAtAq8C8nqv8qD6OCQ+Mir6B4k1NCBG+a09cV2zJ
         3ndFLyjFvP506NnaDT5DvkwdUkdScVaZgug9NcZ4Kw8j8ftOE2mqr+f+wmESavODSqjc
         SfpMfIbv/bNGQ995whI4/KimW56ZvBQ7TDwsC8QZElGXG2ifrf9awqXQEKO4uvm3RAtU
         xAEg4FgQA/F8JjF7mYRVrYEZpW57CCI0YFZIOACPvJpEoD+9sstQgTcX2AszvBLTefkr
         mDaUmI89k5rueM2y1It0X9NPZu4aUOZK2QaYu95FoC4NJvPKlcOLCVRcaImLPbocYHgi
         AzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738162; x=1689330162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlqYpjuSg3Kq2NwTKyv6stGdQ/pys1z7oXzpwBh52Xg=;
        b=l/9l2/Q7cYiGX8xp5BKsTbqkBaPBXDpqIL71TN8kqU5k6svO7U0Iqvi2bq9BjSkpGb
         fjUzayCE1ikp2ZLyuO0c6mUr0yWV1DPJVb/IPnotY3+LfOL8dzhVq8BgSYw2IK04zB2H
         dkg2aA3win3FerxFS7tRUAvBzHFvhaweVJNzd1obO9ObXmwoJlIrmByZNUQGoZdmLsnO
         IXCqLgJaMqIYpnpZLvE+IxSLgTbXkWNZaNiJv2nLvdFVsvYMNLNgTWmRFX2OlMF1SdDW
         ArRrC31DgIUOXubNode26oz4niPnGJ67hN14Jsewhl39Gu77jcKVMFKTKUoxCfdEGNkQ
         EmMQ==
X-Gm-Message-State: AC+VfDx/edQpdnn9rHFKyS3krcB3SGLr3VJ2cvCvT9yGfjGC/8JIY7QX
        fL5+VhJHcSokhlE8vede09qxyw==
X-Google-Smtp-Source: ACHHUZ6Ijvy3R2Rb3Ggedk7FY68bdWTxRyX3+uwjmOvAIFldwR8Z4aTVyptcFmB0vo/3TBkWoeBZIQ==
X-Received: by 2002:a2e:9c8d:0:b0:2a8:e480:a3c8 with SMTP id x13-20020a2e9c8d000000b002a8e480a3c8mr6070272lji.44.1686738160853;
        Wed, 14 Jun 2023 03:22:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 12:22:28 +0200
Subject: [PATCH v5 17/22] interconnect: qcom: icc-rpm: Control bus rpmcc
 from icc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v5-17-eeaa09d0082e@linaro.org>
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=10442;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lKeOSeafhV3w7jjktoClyQf0ndU61YZBX70/SMVHcs4=;
 b=x1UX2rXAXWsI1DTMsCuZhBb7xOoPZP7VcUL6CL9y1kbGT7cq1fYRsTUkBHaOSXsdBz7ZHo6Xu
 qhU6+eYbvhLBUc23JiWb0W80d/GOob49/HwvvtgSQQprgrPhg/ltsUG
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
abusing bus clock handles or wrongly using the qcom,icc.h binding,
but that's a mistake in and of itself).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 121 ++++++++++++++++++++----------------
 drivers/interconnect/qcom/icc-rpm.h |  13 ++--
 drivers/interconnect/qcom/msm8996.c |   1 -
 drivers/interconnect/qcom/sdm660.c  |   1 -
 4 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index b8ecf9538ab9..858880a97d2a 100644
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
@@ -364,49 +363,61 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
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
+	if (qp->bus_clk) {
+		active_rate = max_t(u64, active_rate, sleep_rate);
+		/* ARM32 caps clk_set_rate arg to u32.. Nothing we can do about that! */
+		active_rate = min_t(u64, 1000ULL * active_rate, ULONG_MAX);
+		return clk_set_rate(qp->bus_clk, active_rate);
+	}
+
+	/* RPM only accepts <=INT_MAX rates */
+	active_rate = min_t(u64, active_rate, INT_MAX);
+	sleep_rate = min_t(u64, sleep_rate, INT_MAX);
+
+	if (active_rate != qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]) {
+		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc, QCOM_SMD_RPM_ACTIVE_STATE,
+						active_rate);
+		if (ret)
 			return ret;
-		}
-		qp->bus_clk_rate[i] = rate;
+
+		/* Cache the rate after we've successfully commited it to RPM */
+		qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE] = active_rate;
+	}
+
+	if (sleep_rate != qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE]) {
+		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc, QCOM_SMD_RPM_SLEEP_STATE,
+						sleep_rate);
+		if (ret)
+			return ret;
+
+		/* Cache the rate after we've successfully commited it to RPM */
+		qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE] = sleep_rate;
 	}
 
 	return 0;
 }
 
-static const char * const bus_clocks[] = {
-	"bus", "bus_a",
-};
-
 int qnoc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -448,6 +459,20 @@ int qnoc_probe(struct platform_device *pdev)
 	if (!qp->intf_clks)
 		return -ENOMEM;
 
+	if (desc->bus_clk_desc) {
+		qp->bus_clk_desc = devm_kzalloc(dev, sizeof(*qp->bus_clk_desc),
+						GFP_KERNEL);
+		if (!qp->bus_clk_desc)
+			return -ENOMEM;
+
+		qp->bus_clk_desc = desc->bus_clk_desc;
+	} else {
+		/* Some older SoCs may have a single non-RPM-owned bus clock. */
+		qp->bus_clk = devm_clk_get_optional(dev, "bus");
+		if (IS_ERR(qp->bus_clk))
+			return PTR_ERR(qp->bus_clk);
+	}
+
 	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
 			    GFP_KERNEL);
 	if (!data)
@@ -457,10 +482,6 @@ int qnoc_probe(struct platform_device *pdev)
 	for (i = 0; i < cd_num; i++)
 		qp->intf_clks[i].id = cds[i];
 
-	qp->num_bus_clks = desc->no_clk_scaling ? 0 : NUM_BUS_CLKS;
-	for (i = 0; i < qp->num_bus_clks; i++)
-		qp->bus_clks[i].id = bus_clocks[i];
-
 	qp->keep_alive = desc->keep_alive;
 	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
@@ -490,11 +511,7 @@ int qnoc_probe(struct platform_device *pdev)
 	}
 
 regmap_done:
-	ret = devm_clk_bulk_get(dev, qp->num_bus_clks, qp->bus_clks);
-	if (ret)
-		return ret;
-
-	ret = clk_bulk_prepare_enable(qp->num_bus_clks, qp->bus_clks);
+	ret = clk_prepare_enable(qp->bus_clk);
 	if (ret)
 		return ret;
 
@@ -566,7 +583,7 @@ int qnoc_probe(struct platform_device *pdev)
 	icc_provider_deregister(provider);
 err_remove_nodes:
 	icc_nodes_remove(provider);
-	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
+	clk_disable_unprepare(qp->bus_clk);
 
 	return ret;
 }
@@ -578,7 +595,7 @@ int qnoc_remove(struct platform_device *pdev)
 
 	icc_provider_deregister(&qp->provider);
 	icc_nodes_remove(&qp->provider);
-	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
+	clk_disable_unprepare(qp->bus_clk);
 
 	return 0;
 }
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 692d91c248d9..d5da24495d14 100644
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
  * @qos_offset: offset to QoS registers
  * @bus_clk_rate: bus clock rate in Hz
- * @bus_clks: the clk_bulk_data table of bus clocks
+ * @bus_clk_desc: a pointer to a rpm_clk_resource description of bus clocks
+ * @bus_clk: a pointer to a HLOS-owned bus clock
  * @intf_clks: a clk_bulk_data array of interface clocks
  * @keep_alive: whether to always keep a minimum vote on the bus clocks
  * @is_on: whether the bus is powered on
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
-	int num_bus_clks;
 	int num_intf_clks;
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	unsigned int qos_offset;
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
 	unsigned int qos_offset;
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

