Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47B72A499
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjFIUVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjFIUUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:20:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC9F449B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:19:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f62b512fe2so2863982e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341980; x=1688933980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNVTZz3WTBfWKZBHPF3Oslb4sUjJScI7Q5ztGX7opzk=;
        b=L2R9riUeeO/Yss39VGvHVtUuYPrVl2y1BihEDs0SsJfw/tEYoHaQTn1rl2+LnoND3y
         SDE3NGyjfYOX/Cnk8gUrtW+G1M7w/EvG5o11ACgBocL2/vLBe1+cTpjYrkLifvzLtlbO
         xd9GUOhqG6OrX9jLBvxMUE34RHEu/voTCpvxIwigC7K5kBBScoIu/qs7SfFE9FB3RYQw
         i0TSrl7oDOd6/MjLabqcMX2ZBJr0KjyD9PaWU9bR1lI16zldDPJAWByAZvFTyBd790I3
         4IFCuXjEs7rV7iolQ5oTS8Dq51iI6m73D7KHoP/0WKrDUItqHfGALx9VDe6u8jNny053
         UWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341980; x=1688933980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNVTZz3WTBfWKZBHPF3Oslb4sUjJScI7Q5ztGX7opzk=;
        b=YyS5BU4eovAVYVXwE6TaDWp9+9e4I5+98wIAbseCa3WzWIVFb+wkmDgUcUreT596aq
         AGCvKbjTrEdVo9QHHrgrLT0hKI+DJfx7xnKmWcBiiOAXI+erpTo+cYQ3LslWxUB1FPFs
         sepkMSrOU2eYLyX+Fn+sJ4ZBXirOam4iwCraXuII0LC0E2leD4UxJProQYR8k+6E0W3c
         57rY9TgjMm/XQ5m+/vzDQE+1ratROV+0ygWnTfpJBvF6z/Hbr2VGvGSIoKCn77L21mBe
         +RJO8svIHKEbyVzUaOqFppEQ1n0fB9Izm1lcdMfZrk+hEENQzkdCskth5SrMY34RLM9t
         hzFw==
X-Gm-Message-State: AC+VfDy7S25YjPduUI/OarOOLUyp2BZgcU1aeDKntv4NjVvn7BqbwV+l
        PWrSVuONKuLfHLzkoQdCCZteJg==
X-Google-Smtp-Source: ACHHUZ72ygXiCj6CN43npAR5Gx7loouXtypJhZyjy/y+oxmGwjpHbFng9HQr5yU5f4db1gNB+4NjEg==
X-Received: by 2002:a19:690d:0:b0:4f6:b34:a02d with SMTP id e13-20020a19690d000000b004f60b34a02dmr1441549lfc.54.1686341980601;
        Fri, 09 Jun 2023 13:19:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:24 +0200
Subject: [PATCH v2 19/22] interconnect: qcom: icc-rpm: Fix bucket number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-19-e5934b07d813@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=2765;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=68iL3R2729auKAyf2+h3a84NzNeWWMBj11PjnFNq6B4=;
 b=Za+Lukgzr/6HNrFC3q9wOKV2sPdI2aYKVDy3vv5Cv5pDz+TH/Tw72Fl9KwIADc+IM4l8HnmWH
 Q9f5zDjOIxyC0h+zQicDTwpZTIfhNSK2WpUPORV770o0OXewdkGt1t2
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

SMD RPM only provides two buckets, one each for the active-only and
active-sleep RPM contexts. Use the correct constant to allocate and
operate on them.

Fixes: dcbce7b0a79c ("interconnect: qcom: icc-rpm: Support multiple buckets")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 6d40815c5401..3ac47b818afe 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -249,7 +249,7 @@ static void qcom_icc_pre_bw_aggregate(struct icc_node *node)
 	size_t i;
 
 	qn = node->data;
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
 		qn->sum_avg[i] = 0;
 		qn->max_peak[i] = 0;
 	}
@@ -275,7 +275,7 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 	if (!tag)
 		tag = QCOM_ICC_TAG_ALWAYS;
 
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
 		if (tag & BIT(i)) {
 			qn->sum_avg[i] += avg_bw;
 			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
@@ -300,11 +300,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 {
 	struct icc_node *node;
 	struct qcom_icc_node *qn;
-	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
+	u64 sum_avg[QCOM_SMD_RPM_STATE_NUM];
 	int i;
 
 	/* Initialise aggregate values */
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
 		agg_avg[i] = 0;
 		agg_peak[i] = 0;
 	}
@@ -317,7 +317,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 	 */
 	list_for_each_entry(node, &provider->nodes, node_list) {
 		qn = node->data;
-		for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
 			if (qn->channels)
 				sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
 			else
@@ -328,7 +328,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 	}
 
 	/* Find maximum values across all buckets */
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++)
+	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++)
 		*max_agg_avg = max_t(u64, *max_agg_avg, agg_avg[i]);
 }
 
@@ -339,7 +339,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	struct icc_provider *provider;
 	u64 sum_bw;
 	u64 active_rate, sleep_rate;
-	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
+	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
 	u64 max_agg_avg;
 	int ret;
 

-- 
2.41.0

