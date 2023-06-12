Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6545572CE14
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjFLSZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbjFLSZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:25:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4998DE78
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:25:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f6454a21a9so5514730e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594305; x=1689186305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mn+beXrwy2rPvtKCwVV286nxF9lnxFFy0NVFWPVQv9o=;
        b=Pt4xpM9f3Qyc33kGH77l8LRYN4vUs7uRVgooyKzVrLk78tpiXun9l3IGfrtR7R4c39
         V7sJiqJjpcPi/zHXuvcGbs6l4Pc+jMiqo636edIcCRHSblafFZMkXZ1oElc0XfvPexqi
         WX/ls61YdvgVTtr48P+04GBaVEOwRVnhZwoDEfhXo0TSL07ZawIB6hNIsIRX6qAz1f6v
         0Gvl8DryQf1kTTZjjXnoMlXM4N9gogKQYrKACFSMEkHzXLSQSs0xHP+8CWqsuNlW4aqK
         0lhFOwSSsUST6FeD1mg3dhMCvIkEicARUuDOQmLl9orT5HABcp1d3DOknoh14TgOkQ0T
         iGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594305; x=1689186305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mn+beXrwy2rPvtKCwVV286nxF9lnxFFy0NVFWPVQv9o=;
        b=f0qgtPsyCiWqG9vLvVTiETZl7Y/lu9j6Dhh5p2u/XK/vtleyXekoEY0ZF20EoLSz9O
         1q9IrOD/jg6bivjVS2bPGtIB79gulEWXmPPdaPic1EgkadZx/gIwH7qmFqzRzgTSYBhU
         RsWJ9Me8UJf6d8xj8cNEhjWMtD9f4OiXBfwO1ExXb9CGmdWx/zeY6Hw+bql6RbD6AqRb
         jwb3DxLTf9mS3GWwUwqD1H6kxEdCMhVXO0fkErj3DPToUNaUtSQQQicAbCi6jHI/jL3j
         O1uIuzfyrXRuXeAjrZhl40sn7K/7beUEyH1QjGqtQJfUCSHiGzbEENa6DOecUhkFLBjL
         XYbQ==
X-Gm-Message-State: AC+VfDyTWM+zflAeAvShr1UYnWAW9Va5nrPzmlXdHX1cw025uu0H+Mme
        T+kfe3cI9e02Lsy4d4QGFm8SNg==
X-Google-Smtp-Source: ACHHUZ5q7kxWghwt/1foU7tiyA2G41lgwL2RyfSHYwQ5i9O7mgczU3sgHZ3fn7nxua5Njz4SPzsWVw==
X-Received: by 2002:a05:6512:44b:b0:4f3:a44d:6982 with SMTP id y11-20020a056512044b00b004f3a44d6982mr3863592lfk.45.1686594305636;
        Mon, 12 Jun 2023 11:25:05 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:25:05 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 12 Jun 2023 20:24:37 +0200
Subject: [PATCH v3 20/23] interconnect: qcom: icc-rpm: Fix bucket number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v3-20-5fb7d39b874f@linaro.org>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=3689;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=r8IJnX3qpOJzlF+OYLs0u953pZXLOvcuUdYv13KgtFg=;
 b=k3gf+FAYDkzQT+/HlLdEN/dP9KKfMwgVvu2qiQ5y7XDAmEwPVCr2EbXClt4BpWPSmnhKxLvtH
 3UzXiUR9axaDNroi6Lref/Ck9F+NIasdpuRYYu+uN0omrXoBfG6kDPZ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMD RPM only provides two buckets, one each for the active-only and
active-sleep RPM contexts. Use the correct constant to allocate and
operate on them.

This will make the qcom,icc.h header no longer work with this driver,
mostly because.. it was never meant to! The commit that introduced
bucket support to SMD RPM was trying to shove a square into a round
hole and it did not work out very well. That said, there are no
active users of SMD RPM ICC + qcom,icc.h, so that doesn't hurt.

Fixes: dcbce7b0a79c ("interconnect: qcom: icc-rpm: Support multiple buckets")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 14 +++++++-------
 drivers/interconnect/qcom/icc-rpm.h |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 5ffcf5ca8914..54a9999fe55d 100644
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
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 11e7d503e4d0..ccc5541605ac 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -105,8 +105,8 @@ struct qcom_icc_node {
 	u16 num_links;
 	u16 channels;
 	u16 buswidth;
-	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
-	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
+	u64 sum_avg[QCOM_SMD_RPM_STATE_NUM];
+	u64 max_peak[QCOM_SMD_RPM_STATE_NUM];
 	int mas_rpm_id;
 	int slv_rpm_id;
 	struct qcom_icc_qos qos;

-- 
2.41.0

