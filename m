Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8246CD3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjC2Hro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjC2Hrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:47:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E46421E;
        Wed, 29 Mar 2023 00:47:26 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T62q1H026836;
        Wed, 29 Mar 2023 07:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=zl6Aev0GuHxXwgicjeSDL0BKmzlXRcvwn/SV8yruS8Q=;
 b=e53eDvg7Zi1muAdmZmaSp45vTMK+aEKmZS4QNNm+1QGvZOSArM8S6y36hDSB0snVyvz/
 7JY6Oj56d6l68H+5uDI2jS8GQsjoWzvDhUZXa9tws7ljxPzLqaAhQJIKRifkGauCwlLh
 +Njp/3qAR4q+swiHZJZ7C3AKHhS/ZS7Rg+bAMMjU6LNqH5LDJsbjrColHjBEUENVmPx3
 BpTflPs8A5IemjiCFczOljMvBulVfYmJJQDf3ru9o5HLh2/fRjzF3jMb7ERiwWI5k55x
 dmjV8n9oa9KLQb694UprwpF8SSxLWBeRXv9HvnfZDW9kl7jFFo7ndq5i9tFmCJbRgKgc 3Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmbs88nc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 07:47:23 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T7lLp8013636
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 07:47:21 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 29 Mar 2023 00:47:18 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v6 5/5] firmware: qcom_scm: Add multiple download mode support
Date:   Wed, 29 Mar 2023 13:16:52 +0530
Message-ID: <1680076012-10785-6-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1680076012-10785-1-git-send-email-quic_mojha@quicinc.com>
References: <1680076012-10785-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IB1Q3HGCzdX9VDJmtj0myzZ2XtxGpxLJ
X-Proofpoint-GUID: IB1Q3HGCzdX9VDJmtj0myzZ2XtxGpxLJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_02,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290063
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
 drivers/firmware/qcom_scm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index fa6502a..780e50a 100644
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
 
@@ -1437,8 +1442,12 @@ static int set_download_mode(const char *val, const struct kernel_param *kp)
 {
 	u32 old = download_mode;
 
-	if (sysfs_streq(val, "full")) {
+	if (sysfs_streq(val, "full,mini") || sysfs_streq(val, "mini,full")) {
+		download_mode = QCOM_DOWNLOAD_BOTHDUMP;
+	} else if (sysfs_streq(val, "full")) {
 		download_mode = QCOM_DOWNLOAD_FULLDUMP;
+	} else if (sysfs_streq(val, "mini")) {
+		download_mode = QCOM_DOWNLOAD_MINIDUMP;
 	} else if (sysfs_streq(val, "off")) {
 		download_mode = QCOM_DOWNLOAD_NODUMP;
 	} else if (kstrtouint(val, 0, &download_mode) ||
@@ -1461,7 +1470,7 @@ static const struct kernel_param_ops download_mode_param_ops = {
 
 module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
 MODULE_PARM_DESC(download_mode,
-		 "Download mode: off/full or 0/1 for existing users");
+		"download mode: off/full/mini/full,mini or mini,full and 0/1 for existing users");
 
 static int qcom_scm_probe(struct platform_device *pdev)
 {
-- 
2.7.4

