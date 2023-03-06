Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8276AD2AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCFXMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCFXM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:12:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E7F6BDED;
        Mon,  6 Mar 2023 15:12:28 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326M0Q1U011331;
        Mon, 6 Mar 2023 23:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=bioW/gDMtzyPy8t6XnD7ivoEwoVwagFU1ZBUDiMg2Ro=;
 b=hGds6MkTmanbJJ1UZhjFQ115VuuCYmR+scqeuNcWC+KHiBZNyH/YpCKU5tUErgSMjghf
 7+l8kBn/Hzq5rwG/2uXa+6RDE+4BqnL5wAkHVc583uo7kPyowWMKI7xC41pvmEtXWIpM
 R+FjkjfBz1emA1zo2loohjL0zcCZzpNnvKprXcFB8ADgCFtyUrjqx4IcD4veklOdHmTe
 a7HaPN3wIBbgl3XMhpEuaxZYpGKLX4iLtSb3rIKHbYhazRbG+6jwZp09PTN9m3ql5HOo
 FlNr/28F2oC5CJR26ZrWowyaoO1IJPvE4MSlhxRxH8S4O2EJz2Ox3D7e0GjSyNbcv2Qm Qw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p419169fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 23:12:24 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326NCN4j016431
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 23:12:23 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 15:12:23 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
Subject: [PATCH v2 5/7] remoteproc: qcom: q6v5: Add support for q6 rmb registers
Date:   Mon, 6 Mar 2023 15:12:00 -0800
Message-ID: <20230306231202.12223-6-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306231202.12223-1-quic_molvera@quicinc.com>
References: <20230306231202.12223-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: axJPqk7BDoTW6-HvcF44iy4QkJD40j5s
X-Proofpoint-GUID: axJPqk7BDoTW6-HvcF44iy4QkJD40j5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=791
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attaching a running Q6, the remoteproc driver needs a way
to communicate with the Q6 using rmb registers, so allow the
rmb register to be gotten from the device tree if present.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5.c | 9 +++++++++
 drivers/remoteproc/qcom_q6v5.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 192c7aa0e39e..e8c6be70ebfd 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -254,6 +254,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 		   void (*handover)(struct qcom_q6v5 *q6v5))
 {
 	int ret;
+	struct resource *res;
 
 	q6v5->rproc = rproc;
 	q6v5->dev = &pdev->dev;
@@ -263,6 +264,14 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	init_completion(&q6v5->start_done);
 	init_completion(&q6v5->stop_done);
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res) {
+		q6v5->rmb_base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(q6v5->rmb_base))
+			q6v5->rmb_base = NULL;
+	} else
+		q6v5->rmb_base = NULL;
+
 	q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
 	if (q6v5->wdog_irq < 0)
 		return q6v5->wdog_irq;
diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
index 5a859c41896e..95824d5b64ce 100644
--- a/drivers/remoteproc/qcom_q6v5.h
+++ b/drivers/remoteproc/qcom_q6v5.h
@@ -7,6 +7,12 @@
 #include <linux/completion.h>
 #include <linux/soc/qcom/qcom_aoss.h>
 
+#define RMB_BOOT_WAIT_REG 0x8
+#define RMB_BOOT_CONT_REG 0xC
+#define RMB_Q6_BOOT_STATUS_REG 0x10
+
+#define RMB_POLL_MAX_TIMES 250
+
 struct icc_path;
 struct rproc;
 struct qcom_smem_state;
@@ -16,6 +22,8 @@ struct qcom_q6v5 {
 	struct device *dev;
 	struct rproc *rproc;
 
+	void __iomem *rmb_base;
+
 	struct qcom_smem_state *state;
 	struct qmp *qmp;
 
-- 
2.25.1

