Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110906E4F89
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjDQRpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjDQRoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:44:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139C2B471;
        Mon, 17 Apr 2023 10:44:35 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HHiQKp028769;
        Mon, 17 Apr 2023 17:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=yyKDxYHek/Rl4utUpR2KFwaTSV5+eUhiQxAdIvOG9Fo=;
 b=LZefgHMUE94LUUzFXwhKjw7qBT3j1By8lhil87WarLRoRYZ323c8Htsm2TcHWCaqE7bj
 tOcwrjTo/pGIamNaeGmwE6yJNvkmJDjIJPB6tNqO/IoNv1qzmIS12/YAClQ55fF5fh7B
 K6hXSMOj0kVP7Q4pUf7hokrIJkNTqWA6b4HxPqo/of5D5PcGTyg97qfAbRqB3rgK65o0
 BjHOPaKgEhHmHO4kQyiaCCng/KZoKuj1QhMLdmWc1wb1tjllO/H4hcsD9c3wjEcfS26l
 dH3lw/CGJtj4kFmbY5U6FqOPz87RxdKyMhX/3NL+U0FoCBg0y1m4JRKr9ocqAhSNw7Xm cw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q17yhrhwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 17:44:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HHiPDp023065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 17:44:25 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 17 Apr 2023 10:44:25 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v3 2/2] firmware: arm_scmi: Augment SMC/HVC to allow optional parameter
Date:   Mon, 17 Apr 2023 10:44:01 -0700
Message-ID: <20230417174401.19563-3-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230417174401.19563-1-quic_nkela@quicinc.com>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230417174401.19563-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UeGa0hdIGULXbpgb_RwmpPAi-ttTSLct
X-Proofpoint-GUID: UeGa0hdIGULXbpgb_RwmpPAi-ttTSLct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_11,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for passing shmem channel address as parameter
in smc/hvc call. This patch is useful when multiple scmi instances are
using same smc-id and firmware needs to distiguish among the instances.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 drivers/firmware/arm_scmi/driver.c |  1 +
 drivers/firmware/arm_scmi/smc.c    | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index e7d97b59963b..b5957cc12fee 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2914,6 +2914,7 @@ static const struct of_device_id scmi_of_match[] = {
 #endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
 	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
+	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
 #endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 93272e4bbd12..e28387346d33 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -20,6 +20,9 @@
 
 #include "common.h"
 
+#define lower32(x)	((u32)((x) & 0xffffffff))
+#define upper32(x)	((u32)(((u64)(x) >> 32) & 0xffffffff))
+
 /**
  * struct scmi_smc - Structure representing a SCMI smc transport
  *
@@ -30,6 +33,8 @@
  * @inflight: Atomic flag to protect access to Tx/Rx shared memory area.
  *	      Used when operating in atomic mode.
  * @func_id: smc/hvc call function id
+ * @is_smc64: smc/hvc calling convention type 64 vs 32
+ * @param: physical address of the shmem channel
  */
 
 struct scmi_smc {
@@ -40,6 +45,8 @@ struct scmi_smc {
 #define INFLIGHT_NONE	MSG_TOKEN_MAX
 	atomic_t inflight;
 	u32 func_id;
+	bool is_smc64;
+	phys_addr_t param;
 };
 
 static irqreturn_t smc_msg_done_isr(int irq, void *data)
@@ -137,6 +144,8 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param"))
+		scmi_info->param = res.start;
 	/*
 	 * If there is an interrupt named "a2p", then the service and
 	 * completion of a message is signaled by an interrupt rather than by
@@ -156,6 +165,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	}
 
 	scmi_info->func_id = func_id;
+	scmi_info->is_smc64 = ARM_SMCCC_IS_64(func_id);
 	scmi_info->cinfo = cinfo;
 	smc_channel_lock_init(scmi_info);
 	cinfo->transport_info = scmi_info;
@@ -188,7 +198,20 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 
 	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
 
-	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
+#ifdef CONFIG_ARM64
+	/*
+	 * if SMC32 convention is used, pass 64 bit address in
+	 * two parameters
+	 */
+	if (!scmi_info->is_smc64)
+		arm_smccc_1_1_invoke(scmi_info->func_id,
+				     lower32(scmi_info->param),
+				     upper32(scmi_info->param),
+				     0, 0, 0, 0, 0, &res);
+	else
+#endif
+		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->param,
+				     0, 0, 0, 0, 0, 0, &res);
 
 	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
 	if (res.a0) {
-- 
2.17.1

