Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF43694FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBMSxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjBMSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:53:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C031EBFF;
        Mon, 13 Feb 2023 10:53:22 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DIltT2021786;
        Mon, 13 Feb 2023 18:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=bioW/gDMtzyPy8t6XnD7ivoEwoVwagFU1ZBUDiMg2Ro=;
 b=Z/98U/9WJZmasoQrcGKWXZ6xFCY+E3v+dqfLIrvOy6s1MWGHOzgZ+7UF6hk6o7gutA5u
 WIcP/GNrXb7jSkWvAZrxda5+x7lTh9cwmmVfr5GFG6WNC0A2yEvzuPs8J4Z1G3csWaoQ
 N4hWRJ49JMo56iBjoqpGpecBo0B5EcX3Wq/EqjMlcLtavspxncSDGqBQauTsY/MBw2bQ
 WaQE5JCVcTvproapgdCgaRFKxwgYVSR6m7jpmUiN9ThY2uVtc1hRVoHkidlA9NFGFbh0
 QIbu3Nu4hkbN+YnmvsVUI2CcstMwc9TZ5LVtc/x60Ep/n1Zzoioj4hZdMQB8fX36deCR yQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqts7r0db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 18:53:18 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DIrHs2019233
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 18:53:17 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 10:53:17 -0800
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
Subject: [PATCH 7/9] remoteproc: qcom: q6v5: Add support for q6 rmb registers
Date:   Mon, 13 Feb 2023 10:52:16 -0800
Message-ID: <20230213185218.166520-8-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213185218.166520-1-quic_molvera@quicinc.com>
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hm-7rxIxscEyNfcbnpxQv4YFuCGUCuhy
X-Proofpoint-ORIG-GUID: hm-7rxIxscEyNfcbnpxQv4YFuCGUCuhy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=814 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

