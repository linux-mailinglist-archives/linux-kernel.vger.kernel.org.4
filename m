Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA976CC6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjC1Pl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjC1PlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:41:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C9B11E83;
        Tue, 28 Mar 2023 08:40:21 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SBFPsC004224;
        Tue, 28 Mar 2023 15:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=H71WGrCAYklp17zVh4ajvpjqsuADx7LOIFaxdrwlAcY=;
 b=AJGk/WcC9ul2rEStiegDS428RGal32SuykKfYpsecG6SZy/Jhwtodj9vFOosHPXa5g7Q
 IJjF+wo/M+gcKBZGUkqxpuLb1umWkx/gI6xgxJle8CUrcdHhoGKedhs9nKy2BG2ZXQX8
 JAFgiQmAlu28mNytQuDL5cZpfRHqbjV7qDYo18m36OEnboy5cF8FQ34v5yZZC0ev+LaQ
 NNI3XSIA6Tk9REFE11nNX1AuNlBaQXLtKELFD4kXXOVYPHA7mDbK2MGs89QVlF92wpfi
 VNVo3z2UvDbm1p0OYiPMMHqV9l2yMecK4AGsPA9ZNR3v1OmxfNv1022RanJw3sDG6FhU SQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pky700t4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 15:40:01 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32SFe0n5007189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 15:40:00 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 28 Mar 2023 08:39:58 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v5 5/5] firmware: qcom_scm: Add multiple download mode support
Date:   Tue, 28 Mar 2023 21:07:49 +0530
Message-ID: <1680017869-22421-6-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1680017869-22421-1-git-send-email-quic_mojha@quicinc.com>
References: <1680017869-22421-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xixtT1NBlc3owZrXSEZIypWg2um47GbE
X-Proofpoint-GUID: xixtT1NBlc3owZrXSEZIypWg2um47GbE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280121
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, scm driver only supports full dump when download
mode is selected. Add support to enable minidump as well as
enable it along with fulldump.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/qcom_scm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 53ee301..2a16431 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -32,6 +32,8 @@ static u32 download_mode;
 
 #define QCOM_DOWNLOAD_MODE_MASK 0x30
 #define QCOM_DOWNLOAD_FULLDUMP	0x1
+#define QCOM_DOWNLOAD_MINIDUMP  0x2
+#define QCOM_DOWNLOAD_BOTHDUMP	(QCOM_DOWNLOAD_FULLDUMP | QCOM_DOWNLOAD_MINIDUMP)
 #define QCOM_DOWNLOAD_NODUMP	0x0
 
 struct qcom_scm {
@@ -1420,13 +1422,16 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-
 static int get_download_mode(char *buffer, const struct kernel_param *kp)
 {
 	int len = 0;
 
 	if (download_mode == QCOM_DOWNLOAD_FULLDUMP)
 		len = sysfs_emit(buffer, "full\n");
+	else if (download_mode == QCOM_DOWNLOAD_MINIDUMP)
+		len = sysfs_emit(buffer, "mini\n");
+	else if (download_mode == QCOM_DOWNLOAD_BOTHDUMP)
+		len = sysfs_emit(buffer, "full,mini\n");
 	else if (download_mode == QCOM_DOWNLOAD_NODUMP)
 		len = sysfs_emit(buffer, "off\n");
 
@@ -1437,8 +1442,13 @@ static int set_download_mode(const char *val, const struct kernel_param *kp)
 {
 	u32 old = download_mode;
 
-	if (!strncmp(val, "full", strlen("full"))) {
+	if (!strncmp(val, "full,mini", strlen("full,mini")) ||
+	    !strncmp(val, "mini,full", strlen("mini,full"))) {
+		download_mode = QCOM_DOWNLOAD_BOTHDUMP;
+	} else if (!strncmp(val, "full", strlen("full"))) {
 		download_mode = QCOM_DOWNLOAD_FULLDUMP;
+	} else if (!strncmp(val, "mini", strlen("mini"))) {
+		download_mode = QCOM_DOWNLOAD_MINIDUMP;
 	} else if (!strncmp(val, "off", strlen("off"))) {
 		download_mode = QCOM_DOWNLOAD_NODUMP;
 	} else if (kstrtouint(val, 0, &download_mode) ||
@@ -1461,7 +1471,7 @@ static const struct kernel_param_ops download_mode_param_ops = {
 
 module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
 MODULE_PARM_DESC(download_mode,
-		 "Download mode: off/full or 0/1 for existing users");
+		"download mode: off/full/mini/full,mini or mini,full and 0/1 for existing users");
 
 static int qcom_scm_probe(struct platform_device *pdev)
 {
-- 
2.7.4

