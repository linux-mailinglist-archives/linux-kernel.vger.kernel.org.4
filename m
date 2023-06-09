Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DDC72A4B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjFIUVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjFIUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:21:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73FB421A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:20:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f62b552751so2733483e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341984; x=1688933984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gseMZqiQentYyRaHcHEHjEO4uvoAd0TikjxuZU3oPHc=;
        b=lOsTID+U5Hfbj3U97uR6HDXz5WxN0aXxTydWG0SfmWCDY4hRs9MC3OOD05luTpoFwA
         Lx6mTr881vNwuhAfjuYKenvHFshoUXNmRWx0b43/oK/ffqzmIm4KXBza4hCZhqu5uN1Z
         T87/6a93Y40OqulKH8nCWcAJ0ruSsf/4GwXDus5oklG1hTYKX6AOTbrfte2EwVJKCZCy
         BANzpZuEpApNrgxMPZ3rD2cSlt4oZrI4RnejbiMRk/ybZbeiJ8syS61bTYtNADLOcnE0
         lk6/dUFriCAYPerG1KuPHKQWD9yrmzrmndAKzIkKqUXuY46luIgPi+NDON6HLXPxc8lm
         myRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341984; x=1688933984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gseMZqiQentYyRaHcHEHjEO4uvoAd0TikjxuZU3oPHc=;
        b=W1vRhnSYQyOPT9JpIHIYTCyeQAuApsSEE28Xoa7ivxDO+H7nZb+J96/85d3pLNLJ7D
         KHwZ5sRksAlCx//cnflkBR9Xq5whxeWL7L5exQmAYF29C+aQBENJnND8Oc/lUdTxN5Lf
         VtjIxjiA2ivuGg/VkEnkK0UaaXDy5fUBFRcUwZMFUEqnE1OjbGhTP7+LO8kfHm58A7Ee
         pTO2m8UMhn3C8h/nHTn1U51VScAieb8rUeIq9CvFcpzvpfWUQSqs0L4S9RN7sSD58nZw
         enryootzok/bb/F3iak0i4Tvci6nkpIUVPK3OGigp7O02VqcPVN/ZgH9Qm3ALx+3Po+2
         T7Sg==
X-Gm-Message-State: AC+VfDyIlROPbVCe5eeMu9DW54v7YXyO1ZeZM0B8Xz3QdE8utKt0s6V3
        +6ZBX6DuvA5DfynI06AsWj2R+2tOGnNGo3S1yXg=
X-Google-Smtp-Source: ACHHUZ4tVmuUiVo+jQcB8cq/Jdhj6B3J+7IdTt4y3MXNwGWde9Oz0MqtxrBavvqqQTElst0GQDPVQw==
X-Received: by 2002:a19:9115:0:b0:4f6:10e9:c507 with SMTP id t21-20020a199115000000b004f610e9c507mr1445654lfd.23.1686341984248;
        Fri, 09 Jun 2023 13:19:44 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:27 +0200
Subject: [PATCH v2 22/22] interconnect: qcom: icc-rpm: Fix bandwidth
 calculations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-22-e5934b07d813@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341954; l=4975;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=T/6tws0nrW+rpOcnKnwLBuObiHFQRWQ5v+dHRcZBGwI=;
 b=vc+ZslG3iL81K4cl4YIvChfumOGREIWbFrTNU35OBSyYpVixdi0d53TBbCYxVphUGLTezSqTH
 cqNBeV7/oqvDiWxvPjVlEMUcVl+6ozJg4C3uc4ngJXEFgPfOm2QfhWt
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 59 ++++++++++++-------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 1508233632f6..d177a76abe2a 100644
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

