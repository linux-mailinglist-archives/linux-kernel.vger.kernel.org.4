Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000E06E6C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjDRS5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjDRS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:57:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ED55597;
        Tue, 18 Apr 2023 11:57:34 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IFWj7P000537;
        Tue, 18 Apr 2023 18:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=z1BWlAn4LRvm6qqsRsFneV1IuZD0KXxFnNUH5JgDFko=;
 b=iU6ZIs7xIOx4AgEgGKPTeHBwHLhzqC3kNgl0bgtgb/2HV8sv9mT3Ie/LqvVf4t9e2bEK
 boFyatPS1LTS9xvZL01qB7I28qlu1UXOd5lroHlrqKpWA0+OjoEVbuezdF5eoUSeL+li
 qadIuwtkARoHPiH1vNPe5jLDvR62n2KHrl5rZnHqeD/EuwN6SUtRI9lnax2XLuqq0ilZ
 I8gK+h8Gzzba5Cqu6q+wFhuEhBDEJkwETzdxkO+Sy65fHcETBHti7ZfwP6VXD00lUP0N
 oKgMBz1imH2IjYbaLGa0PXoCmPZh3Axda01vcIgGjykqM6Aok/fJ7PBUSEQHdQ+nnIMT og== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1wxk0nrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 18:57:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33IIvPXq025114
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 18:57:25 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 18 Apr 2023 11:57:25 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v4 2/2] firmware: arm_scmi: Augment SMC/HVC to allow optional parameters
Date:   Tue, 18 Apr 2023 11:56:59 -0700
Message-ID: <20230418185659.29745-3-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418185659.29745-1-quic_nkela@quicinc.com>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230418185659.29745-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yBMu5k7_7NnielXXhtZrzofLbbRojqgj
X-Proofpoint-ORIG-GUID: yBMu5k7_7NnielXXhtZrzofLbbRojqgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for passing shmem channel address as parameters
in smc/hvc call. The address is split into 4KB-page and offset.
This patch is useful when multiple scmi instances are using same smc-id
and firmware needs to distinguish among the instances.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 drivers/firmware/arm_scmi/driver.c |  1 +
 drivers/firmware/arm_scmi/smc.c    | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

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
index 93272e4bbd12..71e080b70df5 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -20,6 +20,11 @@
 
 #include "common.h"
 
+#define SHMEM_SHIFT 12
+#define SHMEM_SIZE (_AC(1, UL) << SHMEM_SHIFT)
+#define SHMEM_PAGE(x) ((unsigned long)((x) >> SHMEM_SHIFT))
+#define SHMEM_OFFSET(x) ((x) & (SHMEM_SIZE - 1))
+
 /**
  * struct scmi_smc - Structure representing a SCMI smc transport
  *
@@ -30,6 +35,7 @@
  * @inflight: Atomic flag to protect access to Tx/Rx shared memory area.
  *	      Used when operating in atomic mode.
  * @func_id: smc/hvc call function id
+ * @param: physical address of the shmem channel
  */
 
 struct scmi_smc {
@@ -40,6 +46,7 @@ struct scmi_smc {
 #define INFLIGHT_NONE	MSG_TOKEN_MAX
 	atomic_t inflight;
 	u32 func_id;
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
@@ -179,6 +188,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 {
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 	struct arm_smccc_res res;
+	unsigned long page = SHMEM_PAGE(scmi_info->param);
+	unsigned long offset = SHMEM_OFFSET(scmi_info->param);
 
 	/*
 	 * Channel will be released only once response has been
@@ -188,7 +199,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 
 	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
 
-	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
+	arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0, 0, 0,
+			     &res);
 
 	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
 	if (res.a0) {
-- 
2.17.1

