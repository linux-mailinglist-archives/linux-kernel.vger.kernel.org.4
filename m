Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACA870B1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjEUWax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjEUWat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:30:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED71B106;
        Sun, 21 May 2023 15:30:33 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LMMJ4m023140;
        Sun, 21 May 2023 22:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=wnTfdqfN1wkN74stgMXwZ2w/Xvja+10t8dNRWHknvn0=;
 b=CVSZusGKaLFonT6LLR2tno/ytWxeJKAEgsZWtEP5GbttIQ5R0w1tKdzCwwk0G/dyXhOG
 eJFnGh+U7AlQ9LZRZwtB83lgecx88VU7Jusu6IQupmeDflFkjuYLFYzm/qerUMmktF4S
 xJxTddcEgaag4JxL71oRZf0L0U3zRaoKz+LKZ83FxGYIVfLBliTTTKKvzcLSYRrpcgT2
 Mm9ct/z6X43RB+JsoJ2OUN0wsUcjg1qxCc8FutXvhZgrEC0CmVp3mgIghhaZPKbpZ7JE
 ejv4xYPI+P1ATlrM48p9X0QZzac9x/nVtHtWs9aKZXtAlVizyxPkblv0x7VqsFca4IeA ng== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpqgf26f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:30:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LMUFOA000953
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:30:15 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 21 May 2023 15:30:07 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <quic_mmanikan@quicinc.com>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V2 08/13] firmware: qcom_scm: ipq5018: Add WCSS AHB pd support
Date:   Mon, 22 May 2023 03:58:47 +0530
Message-ID: <20230521222852.5740-9-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _Y6t_qYZjboKxdPhmdHXt2gNOWXIidGy
X-Proofpoint-GUID: _Y6t_qYZjboKxdPhmdHXt2gNOWXIidGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_17,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210203
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to power up, down & load userpd firmware.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V2:
	- This patch is generated by Strip off SCM code changes from here
	  https://lore.kernel.org/linux-arm-msm/1678164097-13247-9-git-send-email-quic_mmanikan@quicinc.com/

 drivers/firmware/qcom_scm.c            | 114 +++++++++++++++++++++++++
 drivers/firmware/qcom_scm.h            |   6 ++
 include/linux/firmware/qcom/qcom_scm.h |   3 +
 3 files changed, 123 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index fde33acd46b7..c617e9e671ec 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -643,6 +643,120 @@ int qcom_scm_pas_shutdown(u32 peripheral)
 }
 EXPORT_SYMBOL(qcom_scm_pas_shutdown);

+/**
+ * qti_scm_int_radio_powerup - Bring up WCSS AHB userpd
+ *
+ * @peripheral:	peripheral id
+ *
+ * Return 0 on success.
+ */
+int qti_scm_int_radio_powerup(u32 peripheral)
+{
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_PD_LOAD_SVC_ID,
+		.cmd = QCOM_SCM_INT_RAD_PWR_UP_CMD_ID,
+		.arginfo = QCOM_SCM_ARGS(1),
+		.args[0] = peripheral,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+
+	ret = qcom_scm_clk_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	qcom_scm_bw_disable();
+	qcom_scm_clk_disable();
+
+	return ret ? : res.result[0];
+}
+EXPORT_SYMBOL(qti_scm_int_radio_powerup);
+
+/**
+ * qti_scm_int_radio_powerdown() - Shut down WCSS AHB userpd
+ *
+ * @peripheral: peripheral id
+ *
+ * Returns 0 on success.
+ */
+int qti_scm_int_radio_powerdown(u32 peripheral)
+{
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_PD_LOAD_SVC_ID,
+		.cmd = QCOM_SCM_INT_RAD_PWR_DN_CMD_ID,
+		.arginfo = QCOM_SCM_ARGS(1),
+		.args[0] = peripheral,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+
+	ret = qcom_scm_clk_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	qcom_scm_bw_disable();
+	qcom_scm_clk_disable();
+
+	return ret ? : res.result[0];
+}
+EXPORT_SYMBOL(qti_scm_int_radio_powerdown);
+
+/**
+ * qti_scm_pdseg_memcpy_v2() - copy userpd PIL segments data to dma blocks
+ *
+ * @peripheral:		peripheral id
+ * @phno:		program header no
+ * @dma:		handle of dma region
+ * @seg_cnt:		no of dma blocks
+ *
+ * Returns 0 if trustzone successfully loads userpd PIL segments from dma
+ * blocks to DDR
+ */
+int qti_scm_pdseg_memcpy_v2(u32 peripheral, int phno, dma_addr_t dma,
+			    int seg_cnt)
+{
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_PD_LOAD_SVC_ID,
+		.cmd = QCOM_SCM_PD_LOAD_V2_CMD_ID,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_VAL, QCOM_SCM_VAL,
+						QCOM_SCM_RW, QCOM_SCM_VAL),
+		.args[0] = peripheral,
+		.args[1] = phno,
+		.args[2] = dma,
+		.args[3] = seg_cnt,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+
+	ret = qcom_scm_clk_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	qcom_scm_bw_disable();
+	qcom_scm_clk_disable();
+
+	return ret ? : res.result[0];
+}
+EXPORT_SYMBOL(qti_scm_pdseg_memcpy_v2);
+
 /**
  * qcom_scm_pas_supported() - Check if the peripheral authentication service is
  *			      available for the given peripherial
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index e6e512bd57d1..99e3ab2f1986 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -132,6 +132,12 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_SMMU_CONFIG_ERRATA1		0x03
 #define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL	0x02

+#define QCOM_SCM_PD_LOAD_SVC_ID			0x2
+#define QCOM_SCM_PD_LOAD_CMD_ID			0x16
+#define QCOM_SCM_PD_LOAD_V2_CMD_ID		0x19
+#define QCOM_SCM_INT_RAD_PWR_UP_CMD_ID		0x17
+#define QCOM_SCM_INT_RAD_PWR_DN_CMD_ID		0x18
+
 #define QCOM_SCM_SVC_WAITQ			0x24
 #define QCOM_SCM_WAITQ_RESUME			0x02
 #define QCOM_SCM_WAITQ_GET_WQ_CTX		0x03
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 250ea4efb7cb..488d6eccb5a4 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -81,6 +81,9 @@ extern int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,
 extern int qcom_scm_pas_auth_and_reset(u32 peripheral);
 extern int qcom_scm_pas_shutdown(u32 peripheral);
 extern bool qcom_scm_pas_supported(u32 peripheral);
+int qti_scm_int_radio_powerup(u32 peripheral);
+int qti_scm_int_radio_powerdown(u32 peripheral);
+int qti_scm_pdseg_memcpy_v2(u32 peripheral, int phno, dma_addr_t dma, int seg_cnt);

 extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
--
2.17.1

