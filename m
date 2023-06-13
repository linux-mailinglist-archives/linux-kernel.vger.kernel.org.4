Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D372E524
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbjFMOFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242858AbjFMOEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:04:37 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015481FD7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:04:05 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b203360d93so68736081fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686665028; x=1689257028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SidqPf9NQY6x2xLu9IyIJVCioqNGhkSoSI52875QK24=;
        b=X4eQdpn9990DO2s35oVmGkd4tubKnDsKR05lNj9c55WjpfGMM3rFqAHneVa1/QBu6Y
         T+gZpVLbU2CNg7OGNyNUahVD1xWXdR/HI0N13O4f4fyHQHibEiHftN4Vsaeq0ktBUcea
         VIDZcaecajbAxbsCRtX0kyFYkJZiiPhNmgdGTMb4HB/aURW+/VPwTYOEzqz7yy67wffI
         XYborORNzXziCfKejgUD5QMS3r8dbc80/r0C558a1Pk1rFRAIytHqgLmA/lC1O9a0iTi
         O+XCgi2JqMmIYJ6Spi8svKtS50cqsHWP/N9emV+LMGIdfH4Ih1yc9X5YdENzj3dbh9Ab
         q95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665028; x=1689257028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SidqPf9NQY6x2xLu9IyIJVCioqNGhkSoSI52875QK24=;
        b=ONxY7eX8ohWsM1J/k4lqkBRad1Up+Sp7xA/ER3I//GoE4JT1uHHXB27NlonXn9YMM0
         BwRUBrXXIWsSj6AY5jLz00Xnvqy8iACDS53/vyBedpjEAk35yshWLt8H7cep1OdshPyo
         YQ7bks0PpPJPa9OZtZ1d3kFBh2Zp7r7qt8DSl8ycmil7v5OmKid1A8D/ISd7x7Ocr+jr
         Vf0/6HJlRMCbDxTbp9pAYXTur7p38taoY+MYY7VDTkWD87rqo7seGA45qdHHzvdmFhUJ
         MzRj238nQqBwuqK5hmHIOXPAQmevFkFqzdxIf7PDdp2ohcD5mZMurkfU9N4ccJweSfer
         FSkA==
X-Gm-Message-State: AC+VfDy7+eqhf5zsxdLLefr4cKZR+U/VIiTwQmLM8i8+RMlxZskeiG6i
        p4pYP29njPcvugGbUnYM2VAaSA==
X-Google-Smtp-Source: ACHHUZ4bssDdEUnNx/l6zZRL+TKWvdjyIjNtwHCcBM2wbF5n6TAqrOgLlwZ7sbqj/X1iPE8SWgwugA==
X-Received: by 2002:a2e:9344:0:b0:2b3:4210:cd88 with SMTP id m4-20020a2e9344000000b002b34210cd88mr295926ljh.34.1686665028410;
        Tue, 13 Jun 2023 07:03:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b32af2e9c6sm901490ljb.116.2023.06.13.07.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:03:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 16:03:20 +0200
Subject: [PATCH v4 20/22] interconnect: qcom: icc-rpm: Set bandwidth on
 both contexts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v4-20-5ba82b6fbba2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686664985; l=3364;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DGBHbh4j2dvuGrRTBqVPBfSRaxCDokJyGaF7qa4G2q8=;
 b=2YcmraBtaA26B2DGAJ4MzwdCYr8oj5eLIElYA6X9GFZHDwKCcMqdlc16xv0QtY5I6H33gXIt2
 Kva+QpJOnueBn/lu3R6UyBmDwUwujIRNmt5HMsJwLiqE4NB+TutIP5t
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

Up until now, for some reason we've only been setting bandwidth values
on the active-only context. That pretty much meant that RPM could lift
all votes when entering sleep mode. Or never sleep at all.

That in turn could potentially break things like USB wakeup, as the
connection between APSS and SNoC/PNoC would simply be dead.

Set the values appropriately.

Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 54 +++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 01e14b8ced64..4dd53777dbaf 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -205,34 +205,39 @@ static int qcom_icc_qos_set(struct icc_node *node)
 	}
 }
 
-static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 sum_bw)
+static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw)
 {
-	int ret = 0;
+	int ret, rpm_ctx = 0;
+	u64 bw_bps;
 
 	if (qn->qos.ap_owned)
 		return 0;
 
-	if (qn->mas_rpm_id != -1) {
-		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
-					    RPM_BUS_MASTER_REQ,
-					    qn->mas_rpm_id,
-					    sum_bw);
-		if (ret) {
-			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
-			       qn->mas_rpm_id, ret);
-			return ret;
+	for (rpm_ctx = 0; rpm_ctx < QCOM_SMD_RPM_STATE_NUM; rpm_ctx++) {
+		bw_bps = icc_units_to_bps(bw[rpm_ctx]);
+
+		if (qn->mas_rpm_id != -1) {
+			ret = qcom_icc_rpm_smd_send(rpm_ctx,
+						    RPM_BUS_MASTER_REQ,
+						    qn->mas_rpm_id,
+						    bw_bps);
+			if (ret) {
+				pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
+				qn->mas_rpm_id, ret);
+				return ret;
+			}
 		}
-	}
 
-	if (qn->slv_rpm_id != -1) {
-		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
-					    RPM_BUS_SLAVE_REQ,
-					    qn->slv_rpm_id,
-					    sum_bw);
-		if (ret) {
-			pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
-			       qn->slv_rpm_id, ret);
-			return ret;
+		if (qn->slv_rpm_id != -1) {
+			ret = qcom_icc_rpm_smd_send(rpm_ctx,
+						    RPM_BUS_SLAVE_REQ,
+						    qn->slv_rpm_id,
+						    bw_bps);
+			if (ret) {
+				pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
+				qn->slv_rpm_id, ret);
+				return ret;
+			}
 		}
 	}
 
@@ -337,7 +342,6 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
 	struct icc_provider *provider;
-	u64 sum_bw;
 	u64 active_rate, sleep_rate;
 	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
 	u64 max_agg_avg;
@@ -351,14 +355,12 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 
 	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
 
-	sum_bw = icc_units_to_bps(max_agg_avg);
-
-	ret = qcom_icc_rpm_set(src_qn, sum_bw);
+	ret = qcom_icc_rpm_set(src_qn, agg_avg);
 	if (ret)
 		return ret;
 
 	if (dst_qn) {
-		ret = qcom_icc_rpm_set(dst_qn, sum_bw);
+		ret = qcom_icc_rpm_set(dst_qn, agg_avg);
 		if (ret)
 			return ret;
 	}

-- 
2.41.0

