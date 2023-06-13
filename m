Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36FF72E509
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242869AbjFMOFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242777AbjFMOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:04:46 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC92100
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:04:11 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1b3836392so69549561fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686665032; x=1689257032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1FjnpanoZZQYmYBJ9Wrc8mHuIYA1a8hnLTmlpwTtJE=;
        b=oFLLktPzbwY7C7RCQmbNSyR2M4hsG/WFad9GdBmbEu5hesxXbRxMV/tGrPtpenNXnJ
         vgKzSd6p7qlepW7WsWChvtg7y8XVQ6DHXAuJTPTL+q704oJe5B3JLa3P7kHAsjixMxWz
         kfNBnnzmfOtPpNxs4JCpae37bhziJkc1qc+XjDArG/Ws+CMLJEZSSnUrLGaBK8UL2AZq
         aP72kfLBis6c0Lcy7xkNrUIyiTFLOo5Jtea6UQF8RryPooK2q8GzucjB1FxXSZJcp4+R
         sTLW1I3PYZshDKlWnmKlkiITD+hP1BVWfvpTov/uXJC/XK8H2IeUIUvNXM0as/apVC5R
         vbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665032; x=1689257032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1FjnpanoZZQYmYBJ9Wrc8mHuIYA1a8hnLTmlpwTtJE=;
        b=Qcnd8ULnhDNP9DYJuMprTlOZxy9SKwO2Ew4w9wfnBgDnzUXWI2JXqH3G1F9V+bdmQL
         3vxeQ2SOcrfkjNe6nnb9ZVGoEnGATjgTzil1wT37xoul5m7/w999Tvn3ql7Luf/4OyJ6
         dpXfcAXiXl+1dMHKvAAbAjeC6rBn5bnW4Vw+SCrJgjnNDatg4CG3vvRf2St8OwNOJmcg
         FB6sBeFk+1Bo/cxjVVhsXDwTZEVmpNGr+HCLM0caMnposQyIA5TjBZ6LpPK12DNzTOcT
         HzWvLyKyVcjk4NvTVmCUoJ2FmogpzsdfsRPM2+EUP/yxs1BMxzqVWD2PCBfZUmMebipm
         qhQg==
X-Gm-Message-State: AC+VfDz1M7VchP01PpY+k3UCrjhiFPPafQgwDshQ6v4oFg5xPxHs3hA1
        qPy+KyDoyIUO0gt3zL3rmjd19Q==
X-Google-Smtp-Source: ACHHUZ6N/U0C87YgPHcLzLcVAnChDKey9edfXXYvhMP50LkxnBkbygbyVwMThPY0O3gqyVU5jfIhvQ==
X-Received: by 2002:a2e:9bc5:0:b0:2ac:8283:b67d with SMTP id w5-20020a2e9bc5000000b002ac8283b67dmr4608092ljj.25.1686665032406;
        Tue, 13 Jun 2023 07:03:52 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b32af2e9c6sm901490ljb.116.2023.06.13.07.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:03:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 16:03:22 +0200
Subject: [PATCH v4 22/22] interconnect: qcom: icc-rpm: Fix bandwidth
 calculations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v4-22-5ba82b6fbba2@linaro.org>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686664985; l=5027;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JelHWTtx6PCRAaZAaxwLHk7R0OVR9xy/H6t4bwRWePw=;
 b=JOms4nzspnmeKtzorZ7Ae7IFrfW3nClpj6OA68B0j6VkXkvovn++SpPrFWEIH6h5ptmCmWQtb
 cS5Yco93htfCCXVbO45PFVxVn9ktrK4Z8pGDpXnh+7NRxxiakC+EEYK
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

Up until now, we've been aggregating the bandwidth values and only
dividing them by the bus width of the source node. This was completely
wrong, as different nodes on a given path may (and usually do) have
varying bus widths.  That in turn, resulted in the calculated clock rates
being completely bogus - usually they ended up being much higher, as
NoC_A<->NoC_B links are very wide.

Since we're not using the aggregate bandwidth value for anything other
than clock rate calculations, remodel qcom_icc_bus_aggregate() to
calculate the per-context clock rate for a given provider, taking into
account the bus width of every individual node.

Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 59 ++++++++++++-------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 34e0580f1ffe..f48701a74da1 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -293,58 +293,44 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 }
 
 /**
- * qcom_icc_bus_aggregate - aggregate bandwidth by traversing all nodes
+ * qcom_icc_bus_aggregate - calculate bus clock rates by traversing all nodes
  * @provider: generic interconnect provider
- * @agg_avg: an array for aggregated average bandwidth of buckets
- * @agg_peak: an array for aggregated peak bandwidth of buckets
- * @max_agg_avg: pointer to max value of aggregated average bandwidth
+ * @agg_clk_rate: array containing the aggregated clock rates in kHz
  */
-static void qcom_icc_bus_aggregate(struct icc_provider *provider,
-				   u64 *agg_avg, u64 *agg_peak,
-				   u64 *max_agg_avg)
+static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_rate)
 {
-	struct icc_node *node;
+	u64 agg_avg_rate, agg_rate;
 	struct qcom_icc_node *qn;
-	u64 sum_avg[QCOM_SMD_RPM_STATE_NUM];
+	struct icc_node *node;
 	int i;
 
-	/* Initialise aggregate values */
-	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
-		agg_avg[i] = 0;
-		agg_peak[i] = 0;
-	}
-
-	*max_agg_avg = 0;
-
 	/*
-	 * Iterate nodes on the interconnect and aggregate bandwidth
-	 * requests for every bucket.
+	 * Iterate nodes on the provider, aggregate bandwidth requests for
+	 * every bucket and convert them into bus clock rates.
 	 */
 	list_for_each_entry(node, &provider->nodes, node_list) {
 		qn = node->data;
 		for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
 			if (qn->channels)
-				sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
+				agg_avg_rate = div_u64(qn->sum_avg[i], qn->channels);
 			else
-				sum_avg[i] = qn->sum_avg[i];
-			agg_avg[i] += sum_avg[i];
-			agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
+				agg_avg_rate = qn->sum_avg[i];
+
+			agg_rate = max_t(u64, agg_avg_rate, qn->max_peak[i]);
+			do_div(agg_rate, qn->buswidth);
+
+			agg_clk_rate[i] = max_t(u64, agg_clk_rate[i], agg_rate);
 		}
 	}
-
-	/* Find maximum values across all buckets */
-	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++)
-		*max_agg_avg = max_t(u64, *max_agg_avg, agg_avg[i]);
 }
 
 static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
-	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
+	u64 agg_clk_rate[QCOM_SMD_RPM_STATE_NUM] = { 0 };
 	struct icc_provider *provider;
+	struct qcom_icc_provider *qp;
 	u64 active_rate, sleep_rate;
-	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
-	u64 max_agg_avg;
 	int ret;
 
 	src_qn = src->data;
@@ -353,7 +339,9 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	provider = src->provider;
 	qp = to_qcom_provider(provider);
 
-	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
+	qcom_icc_bus_aggregate(provider, agg_clk_rate);
+	active_rate = agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE];
+	sleep_rate = agg_clk_rate[QCOM_SMD_RPM_SLEEP_STATE];
 
 	ret = qcom_icc_rpm_set(src_qn, src_qn->sum_avg);
 	if (ret)
@@ -369,15 +357,6 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	if (!qp->bus_clk_desc && !qp->bus_clk)
 		return 0;
 
-	/* Intentionally keep the rates in kHz as that's what RPM accepts */
-	active_rate = max(agg_avg[QCOM_SMD_RPM_ACTIVE_STATE],
-			  agg_peak[QCOM_SMD_RPM_ACTIVE_STATE]);
-	do_div(active_rate, src_qn->buswidth);
-
-	sleep_rate = max(agg_avg[QCOM_SMD_RPM_SLEEP_STATE],
-			 agg_peak[QCOM_SMD_RPM_SLEEP_STATE]);
-	do_div(sleep_rate, src_qn->buswidth);
-
 	/*
 	 * Downstream checks whether the requested rate is zero, but it makes little sense
 	 * to vote for a value that's below the lower threshold, so let's not do so.

-- 
2.41.0

