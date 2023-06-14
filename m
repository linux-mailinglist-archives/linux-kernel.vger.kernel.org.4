Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9927972FAB7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243987AbjFNKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243854AbjFNKXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:23:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E5226AD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b344476313so6715971fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738167; x=1689330167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veLz5A1i1wdbEZwh7DP/XHxTSWS7AwHgX3VHj1ZonVA=;
        b=Vew4HSMfu+xafJn5obicEMi9i6UqABoLV5C6mkVGKnvOxUphMt2tLluSHJEu+DZOVc
         5Q96/nK8JAWLEIvdy0qZXiuQMiUfo6KTYKPx7OmVgRUf67O5gVsUqKv0kMydtX4FRiEI
         ph4jPfcWCw1sY7S1cn3y+HpLUO23cFtp0xM26c5nzE0Yiqez6iKrHIL7JXAjL0VGIDkw
         Ei7k8OwD3z7fqEPnJ/0rcIq9Ocv1YpKT5o2inBMbcOH96G5DELtE20EGmftCkmUlfutp
         i6c5F/jRr1oMojvTZ+SnzvpOvhkCWTu/r6tNyISvWVdGAlRIB55HEMQ27aFRNtrlxK3s
         DfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738167; x=1689330167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veLz5A1i1wdbEZwh7DP/XHxTSWS7AwHgX3VHj1ZonVA=;
        b=Nq2AEs7bOHuOLTB+0b/8KQo20t/CcSn/PjxP0H0DKPMAOMQaT+8CQGwqA9ACjLKNAn
         tEsgtYqin8agWdbMl7ZmH3QrYfYBbyPPxcrmtGu5vhwR1a1r/P3PYJ9XJv55vW6HlkhD
         cApTOcABARet9m3z0O1Fg769BI3AshWdoIZd9bls8zSGzfD9tsldrf+tvaD+zqkQZjSD
         IxTrW8lVJDlFdxjO5HV4QZ9NOfUNw2rxGK7STKQ+E0zT5GiMhMQQwnpG7B/TPcj/8Tp1
         mKz/KHZVy/atGU7ya2SmcK5hGqfs3hAfuhiwGGrpFODI3K4JtTKJajqJp6WLX71ENRab
         4gJA==
X-Gm-Message-State: AC+VfDyPt5w/ZwOdecw0D+0Zh/7zeIl9ilLmNbOqKoGg6/5Ckrw0E/SN
        CZ/Y13LsEhTHuDe2MLXwFYZaVA==
X-Google-Smtp-Source: ACHHUZ7AC7zThAXv8R+ZbEGQa7PVc/pWh1q8VxD6HfCrblDsvp9LYYtOVPBsJDfMHjuNf8FI3k0SDw==
X-Received: by 2002:a2e:9ed4:0:b0:2b3:2f9b:7c99 with SMTP id h20-20020a2e9ed4000000b002b32f9b7c99mr4731903ljk.14.1686738166645;
        Wed, 14 Jun 2023 03:22:46 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 12:22:31 +0200
Subject: [PATCH v5 20/22] interconnect: qcom: icc-rpm: Set bandwidth on
 both contexts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v5-20-eeaa09d0082e@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=3364;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9kP/iaUhZf3U3lfbCEW0MMZ5Yx9Q4Ewh24pZxbnYFCI=;
 b=G3C36fK0PvmUADA2Ioc5+Dn0D5wZvuvVotsaig8AlqwGM/Ls8h7qjoShdfGZCdO7Us9Qq8QjK
 5ti3o5/Gq16ASrGMj/0vkUPSe5Wt8m/TJFU8qAZGuEvMrc/B7t9ms3g
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
index 47d034284e0d..ac84fe0bc852 100644
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

