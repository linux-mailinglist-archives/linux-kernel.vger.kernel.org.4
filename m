Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82776DCAA4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjDJSVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDJSVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:21:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282A52136;
        Mon, 10 Apr 2023 11:21:44 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AHjC2A002159;
        Mon, 10 Apr 2023 18:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UTfBHR4o7qOdeLqIQF2mVUdqvGtnPPbpMmp3J3EEHYU=;
 b=DNq5MgJtHOb4OOcju4SEVhS+o98gwDrd8hZQ1ViKOR5o2m8yoBLT8n1UbVs2fUr/Zb8L
 WVLMH5XOvVrNaVWz6Nld9Fd3IfEWqqzTFuwViA5InqRCTBUt3lkLg/ZmrHUZjC2PpslU
 z5OgNRXo+x67W70oWPUOSfjVmHdv2NLIal5pvwo/GPlxy8tzOL8dsU3qvPd5WrgdS3ul
 hJsp//ZYZ0JH15KQwdR38gebt0CfnWNm9t3oKZcur2BlCqtmW7n+kCaCQR506+Xx2nSC
 oaCZwaD26wKW+0s8wTDRmuuUxn33UaT9e1RVEEQKUFjt7mVaE4D8/FkpIfk5JfuGymZD cA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvq4dg2e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 18:21:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AILSjD030585
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 18:21:28 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Apr 2023 11:21:28 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>, Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v2 2/2] firmware: arm_scmi: Augment SMC/HVC to allow optional parameters
Date:   Mon, 10 Apr 2023 11:20:58 -0700
Message-ID: <20230410182058.8949-3-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410182058.8949-1-quic_nkela@quicinc.com>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230410182058.8949-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YZUolred9wys3Zpo7i4Z59F7R6P2zY55
X-Proofpoint-GUID: YZUolred9wys3Zpo7i4Z59F7R6P2zY55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100157
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for passing parameters to smc/hvc calls.
This patch is useful when multiple scmi instances are using same
smc-id and firmware needs to distiguish among the instances.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 drivers/firmware/arm_scmi/smc.c | 72 ++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 93272e4bbd12..c57d2f3fab87 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -20,6 +20,16 @@
 
 #include "common.h"
 
+#define MAX_PARAM_COUNT 6
+
+/**
+ * scmi_smc_param_t - parameter type for SCMI smc/hvc call
+ */
+typedef union {
+	u64 x;
+	u32 w;
+} scmi_smc_param_t;
+
 /**
  * struct scmi_smc - Structure representing a SCMI smc transport
  *
@@ -30,6 +40,8 @@
  * @inflight: Atomic flag to protect access to Tx/Rx shared memory area.
  *	      Used when operating in atomic mode.
  * @func_id: smc/hvc call function id
+ * @is_smc64: A flag, indicating smc64 calling convention.
+ * @params: Optional, smc/hvc call parameters.
  */
 
 struct scmi_smc {
@@ -40,8 +52,55 @@ struct scmi_smc {
 #define INFLIGHT_NONE	MSG_TOKEN_MAX
 	atomic_t inflight;
 	u32 func_id;
+	bool is_smc64;
+	scmi_smc_param_t params[MAX_PARAM_COUNT];
 };
 
+static void populate_smc_params(struct device *dev, struct scmi_smc *scmi_info)
+{
+	struct device_node *np = dev->of_node;
+	u64 params64[MAX_PARAM_COUNT] = { 0 };
+	u32 params32[MAX_PARAM_COUNT] = { 0 };
+	int i, count;
+
+#ifdef CONFIG_ARM64
+	if (scmi_info->is_smc64) {
+		count = of_property_read_variable_u64_array(np,
+							    "arm,smc64-params",
+							    &params64[0], 1,
+							    MAX_PARAM_COUNT);
+		if (count == -EINVAL)  /* if property is not defined */
+			return;
+
+		if (count > 0)	/* populate the parameters */
+			for (i = 0; i < count; i++)
+				scmi_info->params[i].x = params64[i];
+		else
+			goto param_err;
+	} else {
+#else
+	{
+#endif
+		count = of_property_read_variable_u32_array(np,
+							    "arm,smc32-params",
+							    &params32[0], 1,
+							    MAX_PARAM_COUNT);
+		if (count == -EINVAL)  /* if property is not defined */
+			return;
+
+		if (count > 0)	/* populate the parameters */
+			for (i = 0; i < count; i++)
+				scmi_info->params[i].w = params32[i];
+		else
+			goto param_err;
+	}
+
+	return;
+
+param_err:
+	dev_warn(dev, "failed to read smc/hvc call parameters\n");
+}
+
 static irqreturn_t smc_msg_done_isr(int irq, void *data)
 {
 	struct scmi_smc *scmi_info = data;
@@ -156,6 +215,8 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	}
 
 	scmi_info->func_id = func_id;
+	scmi_info->is_smc64 = ARM_SMCCC_IS_64(func_id);
+	populate_smc_params(dev, scmi_info);
 	scmi_info->cinfo = cinfo;
 	smc_channel_lock_init(scmi_info);
 	cinfo->transport_info = scmi_info;
@@ -179,6 +240,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 {
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 	struct arm_smccc_res res;
+	scmi_smc_param_t *p = scmi_info->params;
 
 	/*
 	 * Channel will be released only once response has been
@@ -188,7 +250,15 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 
 	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
 
-	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
+#ifdef CONFIG_ARM64
+	if (scmi_info->is_smc64)
+		arm_smccc_1_1_invoke(scmi_info->func_id, p[0].x, p[1].x, p[2].x,
+				     p[3].x, p[4].x, p[5].x, 0, &res);
+	else
+#endif
+		arm_smccc_1_1_invoke(scmi_info->func_id, p[0].w, p[1].w, p[2].w,
+				     p[3].w, p[4].w, p[5].w, 0, &res);
+
 
 	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
 	if (res.a0) {
-- 
2.17.1

