Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A116F9396
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 20:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjEFSZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 14:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjEFSZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 14:25:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB3A1A48B;
        Sat,  6 May 2023 11:25:10 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 346IOpiV032020;
        Sat, 6 May 2023 18:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Uyb35H/kbF9QkDeVzNYPkHik27rYom42LURQicdJjyk=;
 b=ExQYlPUa5RD/ebD/zcbeNtLJcUZfJ3n1ZFV7FEpRc8AYVoKRvPxUPnih+7bB2TFzUEoJ
 +TDtM0pEfFYjORVFKyAGAssbtLytUnHabZzPN5XMuPOBMc24Az+3ShUzhwLIM3J2P/0U
 fcLCO3cbQuoHTfY/Ll5BqoEtpQtOe1HWnKiN99Ayw7+gEpi46s0YxrXZTHZTFSiA5pJU
 Lk7BvmEh1pCbuf6v+TvrVx+VDWp57jaNpuGt0iNc/G+j22emREFnyJxdp7moSrHxKSqG
 q+EjOsyhIsTJGIih4dcir2kJBVsI4VYNcGA8p6D/ATrrdiJF1Z7Dzrc3qyCvV28Pn/8/ zw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qddwhguyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 May 2023 18:24:51 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 346IOoMK003563
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 6 May 2023 18:24:50 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sat, 6 May 2023 11:24:49 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v5 2/2] firmware: arm_scmi: Augment SMC/HVC to allow optional parameters
Date:   Sat, 6 May 2023 11:24:28 -0700
Message-ID: <20230506182428.25343-3-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230506182428.25343-1-quic_nkela@quicinc.com>
References: <20230506182428.25343-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mKG5RoTp8pg9SE_OEdyBYHivLJM-4x4A
X-Proofpoint-ORIG-GUID: mKG5RoTp8pg9SE_OEdyBYHivLJM-4x4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-06_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305060144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds support for passing shmem channel address as parameters
in smc/hvc call. The address is split into 4KB-page and offset.
This is useful when multiple scmi instances are using same smc-id
and firmware needs to distinguish among the instances.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 drivers/firmware/arm_scmi/driver.c |  1 +
 drivers/firmware/arm_scmi/smc.c    | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

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
index 93272e4bbd12..621c37efe3ec 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -20,6 +20,23 @@
 
 #include "common.h"
 
+/*
+ * The shmem address is split into 4K page and offset.
+ * This is to make sure the parameters fit in 32bit arguments of the
+ * smc/hvc call to keep it uniform across smc32/smc64 conventions.
+ * This however limits the shmem address to 44 bit.
+ *
+ * These optional parameters can be used to distinguish among multiple
+ * scmi instances that are using the same smc-id.
+ * The page parameter is passed in r1/x1/w1 register and the offset parameter
+ * is passed in r2/x2/w2 register.
+ */
+
+#define SHMEM_SIZE (SZ_4K)
+#define SHMEM_SHIFT 12
+#define SHMEM_PAGE(x) (_UL((x) >> SHMEM_SHIFT))
+#define SHMEM_OFFSET(x) ((x) & (SHMEM_SIZE - 1))
+
 /**
  * struct scmi_smc - Structure representing a SCMI smc transport
  *
@@ -30,6 +47,8 @@
  * @inflight: Atomic flag to protect access to Tx/Rx shared memory area.
  *	      Used when operating in atomic mode.
  * @func_id: smc/hvc call function id
+ * @param_page: 4K page number of the shmem channel
+ * @param_offset: Offset within the 4K page of the shmem channel
  */
 
 struct scmi_smc {
@@ -40,6 +59,8 @@ struct scmi_smc {
 #define INFLIGHT_NONE	MSG_TOKEN_MAX
 	atomic_t inflight;
 	u32 func_id;
+	u32 param_page;
+	u32 param_offset;
 };
 
 static irqreturn_t smc_msg_done_isr(int irq, void *data)
@@ -137,6 +158,10 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param")) {
+		scmi_info->param_page = SHMEM_PAGE(res.start);
+		scmi_info->param_offset = SHMEM_OFFSET(res.start);
+	}
 	/*
 	 * If there is an interrupt named "a2p", then the service and
 	 * completion of a message is signaled by an interrupt rather than by
@@ -179,6 +204,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 {
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 	struct arm_smccc_res res;
+	unsigned long page = scmi_info->param_page;
+	unsigned long offset = scmi_info->param_offset;
 
 	/*
 	 * Channel will be released only once response has been
@@ -188,7 +215,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 
 	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
 
-	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
+	arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0, 0, 0,
+			     &res);
 
 	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
 	if (res.a0) {
-- 
2.17.1

