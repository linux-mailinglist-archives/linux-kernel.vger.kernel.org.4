Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18DF6DB506
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDGUPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDGUOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:14:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A107BBA1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:14:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q16so55678128lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 13:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680898490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQRr7zYgAeFKXDVLGLXAENjwQ4hSXd3swVXxXJxBC68=;
        b=KaOAS9kKCQiM8FtlqY9qHaT7Gc5Dzk3LtG19NMEVjJCnPeW2hiQjaKlEoKd7ILim/z
         1iStbcDmcF7jdB2uuMzQFBJHiWLc3y1tjErHYm22moLq019b1vy27B31rYCESGNIfdOP
         nysoEplT9B8KoAlF4gFS4QQs3xZy43HKSlsuVKUWhAbR5YMnb5ikSIz9/6HOqGCIDMc4
         ZAwS6pNNdxmaf6IEmxxJ+A0zdDK52OfNV0g5WXeUf/hNNJOohQDXWbYUIYPRNcqm1RM0
         hIZG2Ehys8RVjSHsS80INrC27e40FdtFcvpUA1snKCLMVa75MX5S8YdNAvDO/pcv4sxb
         f32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680898490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQRr7zYgAeFKXDVLGLXAENjwQ4hSXd3swVXxXJxBC68=;
        b=dOx6BypyYjwDMYDT2MqPykTRG7KEgL1ltXQyZsVZfgeDfpQ8AFWLfwPre86MDLIZ8q
         2wvqoO22Ap9fC4cu4vhQEcjsX1Jf6d3dvrKqAnaX5bBmsd6B9FYAeVlykSoRlctNu4R1
         nFMOSbwlBadXYQSMfwk6y/P6EDxG27HwZDFHab80VVTwZsxBQ3eXdH9qzvumMWdM7Uxd
         qTsoHyaaf6skjnWqdVjlNJhjFoXzOgXIcSnIXCT1lT5QyJ7/3OzI/2SUCqaI4AaU6+na
         HelVp1QtUL+w4t4XbuTwtLM75xM2OCkkr1Un0xNCQa5FjON9zTFKBJ7VCWsVLQLstsVs
         D+Ig==
X-Gm-Message-State: AAQBX9c8CRgP0JOuYTV474K22DTQIVxGEz9hoo87+1LsM+mi2BkoXmM0
        KYd2Hx1gNRm3mUQTYnh5UROe0g==
X-Google-Smtp-Source: AKy350ZNbYIP6G3TdV4ZnW7a5/jEH7iMFGOuNoFHCQo82Dit+nTlfr9rBFYZY8gaEa9Dr0eGbYbFLg==
X-Received: by 2002:a19:f70f:0:b0:4eb:4fb2:7b6d with SMTP id z15-20020a19f70f000000b004eb4fb27b6dmr1144444lfe.2.1680898490604;
        Fri, 07 Apr 2023 13:14:50 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u3-20020ac243c3000000b004eaf6181a32sm842436lfl.75.2023.04.07.13.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 13:14:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 22:14:46 +0200
Subject: [PATCH v8 4/8] interconnect: qcom: rpm: Set QoS registers only
 once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v8-4-ee696a2c15a9@linaro.org>
References: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
In-Reply-To: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680898484; l=3314;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Fj8QPV8qCcpTJILNUkCb2YoMLaTcvnAVgncrQ7lWCjs=;
 b=AoVoA52TYCXmyQ7GwtfPUjP8q7pzXHkgKdOsIrcJcNMPogE1cbqb2bEyIyBd81AN9Q/V25NkVs7h
 VVjyr9qyCRkiYVemWPjMKarVPN7xagN3fmZT3SVek5BN7GLRe+6M
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QoS registers are (or according to Qualcomm folks, on most
platforms) persistent until a full chip reboot. Move the QoS-setting
functions to the probe function so that we don't needlessly do it over
and over again.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 50 ++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 7d62c0bf2722..d79e508cb717 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -204,30 +204,33 @@ static int qcom_icc_qos_set(struct icc_node *node)
 	}
 }
 
-static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
+static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 sum_bw)
 {
 	int ret = 0;
 
-	if (mas_rpm_id != -1) {
+	if (qn->qos.ap_owned)
+		return 0;
+
+	if (qn->mas_rpm_id != -1) {
 		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
 					    RPM_BUS_MASTER_REQ,
-					    mas_rpm_id,
+					    qn->mas_rpm_id,
 					    sum_bw);
 		if (ret) {
 			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
-			       mas_rpm_id, ret);
+			       qn->mas_rpm_id, ret);
 			return ret;
 		}
 	}
 
-	if (slv_rpm_id != -1) {
+	if (qn->slv_rpm_id != -1) {
 		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
 					    RPM_BUS_SLAVE_REQ,
-					    slv_rpm_id,
+					    qn->slv_rpm_id,
 					    sum_bw);
 		if (ret) {
 			pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
-			       slv_rpm_id, ret);
+			       qn->slv_rpm_id, ret);
 			return ret;
 		}
 	}
@@ -235,26 +238,6 @@ static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
 	return ret;
 }
 
-static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
-			  u64 sum_bw)
-{
-	int ret;
-
-	if (!qn->qos.ap_owned) {
-		/* send bandwidth request message to the RPM processor */
-		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
-		if (ret)
-			return ret;
-	} else if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
-		/* set bandwidth directly from the AP */
-		ret = qcom_icc_qos_set(n, sum_bw);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 /**
  * qcom_icc_pre_bw_aggregate - cleans up values before re-aggregate requests
  * @node: icc node to operate on
@@ -370,11 +353,12 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 
 	sum_bw = icc_units_to_bps(max_agg_avg);
 
-	ret = __qcom_icc_set(src, src_qn, sum_bw);
+	ret = qcom_icc_rpm_set(src_qn, sum_bw);
 	if (ret)
 		return ret;
+
 	if (dst_qn) {
-		ret = __qcom_icc_set(dst, dst_qn, sum_bw);
+		ret = qcom_icc_rpm_set(dst_qn, sum_bw);
 		if (ret)
 			return ret;
 	}
@@ -528,6 +512,14 @@ int qnoc_probe(struct platform_device *pdev)
 		for (j = 0; j < qnodes[i]->num_links; j++)
 			icc_link_create(node, qnodes[i]->links[j]);
 
+		/* Set QoS registers (we only need to do it once, generally) */
+		if (qnodes[i]->qos.ap_owned &&
+		    qnodes[i]->qos.qos_mode != NOC_QOS_MODE_INVALID) {
+			ret = qcom_icc_qos_set(node);
+			if (ret)
+				return ret;
+		}
+
 		data->nodes[i] = node;
 	}
 	data->num_nodes = num_nodes;

-- 
2.40.0

