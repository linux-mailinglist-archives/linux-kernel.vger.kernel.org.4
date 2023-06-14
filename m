Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C44F730713
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbjFNSHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbjFNSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:05:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BA9212C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:05:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f7677a94d1so1411273e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686765907; x=1689357907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bcXIhURMNb0zAXxfMHWv0nL5TXiAv91yaE+1dFMG5E=;
        b=pq6bw0cXSTpklMxV25UMxnMsLsxx5Tc6Eb25fYs9CmWrd2LzuH3L4ZZ25tXXfMT1/4
         WNNhfNlCuK/D/kdKixzZ67I7IuhdLNqZ9D4+d8r7palyPCiN0jICzuHr84vnyI9hyPxO
         OmZ91ZiVkIIhbV55nZQsuusIoyOOjwBHtxImi0cXmgPiAGCgPX+0ry0xsPilIY4E+Ujn
         Yh4pAnuW4m2+pJItNnFDWqytf997MXtz/dVHra2yFqaN5u3jXaIcJvj5yIwdwTJaP9Jt
         931pdLVcYWp8ISnjcQpuA+wXcyEi1g7Stbpu5nRs9/s7xNw96IYtBr6CvFOfFInPip6p
         oxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765907; x=1689357907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bcXIhURMNb0zAXxfMHWv0nL5TXiAv91yaE+1dFMG5E=;
        b=R+fTziXDFbD/YbxwP3XxkDRU6TbqgCrHQF2r4tS3VlT4XcMRJ0Cw/0K2Q0ogekZ69e
         3gh3IORui8UYPmUXffJ6xQ7OBIrZ2OBWfr6UrJ707OFqHDdvf9domYLV15U/sDMf18+8
         rFpRqqooLM0fKQqNbcyd1QKq96Q00m3V0xCTDsWzdoRsOP+cv6wESQXV2Uav4xMdQWSH
         9/oWnU+Sjyu9R7CvPv7TqjpEy8Ej2uyQIM9B5sqMgSMSgfWSvARfZs55qVNPuurAAGhh
         455rohiczrn6SmCacgsfSKk+uKqCLFQpNzgb5U5PERJEdfNghS5pMrGGRVS1emWRZE4K
         ruqA==
X-Gm-Message-State: AC+VfDypYnXhwbn8vhwcuiIJ9SlPCLGIEeXzR1cw+9mu9x/c5cTwIFWM
        EIYfRwkSfUjLK7hi0fpOsuHVnw==
X-Google-Smtp-Source: ACHHUZ59EqaQR9FEQh7SMWnWu8T8pAgLDrueO2T6NI16i4qWW5o4JwYn3TPNcW7TliHXfCYk/FLYDg==
X-Received: by 2002:a19:7104:0:b0:4f6:3000:4d5a with SMTP id m4-20020a197104000000b004f630004d5amr7266979lfc.38.1686765907332;
        Wed, 14 Jun 2023 11:05:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l18-20020a19c212000000b004eff1f7f206sm2224053lfc.9.2023.06.14.11.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:05:07 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 20:04:41 +0200
Subject: [PATCH v6 22/22] interconnect: qcom: icc-rpm: Fix bandwidth
 calculations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v6-22-263283111e66@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686765873; l=5027;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tAzLN6zVkcV/6YKzpXaiTCXmJB8hBKbRsR3dIrek/EQ=;
 b=D2ggQXMuXsAaYFYORH7Xn4ImPyMS+lByHb8dqBMR8ngA5C+oEBTIgqB7mUrwAVgCNTKEwy5WK
 u2MZ94OJ/w4DnpOSuSecmyweXzoWS7dkBRw/6ssKhL+fzq1RcAfqkLo
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
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 59 ++++++++++++-------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 5733261d9407..3209d8de709b 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -292,58 +292,44 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
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
@@ -352,7 +338,9 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	provider = src->provider;
 	qp = to_qcom_provider(provider);
 
-	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
+	qcom_icc_bus_aggregate(provider, agg_clk_rate);
+	active_rate = agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE];
+	sleep_rate = agg_clk_rate[QCOM_SMD_RPM_SLEEP_STATE];
 
 	ret = qcom_icc_rpm_set(src_qn, src_qn->sum_avg);
 	if (ret)
@@ -368,15 +356,6 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
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

