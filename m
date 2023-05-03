Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86056F5CF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjECRVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjECRV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:21:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05452D69;
        Wed,  3 May 2023 10:21:27 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343F8jFY029276;
        Wed, 3 May 2023 17:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qbH7MY6GGBgS0pDOVGPhqlpYiVtd0OBI+s2aNgE53Hg=;
 b=ZsLgDONGInc7bLVlS4UT6DtybDKv1nq2gwI2A7Vxdqwwl7X3noaGIh2Nj4zsmbx6jdPS
 xGp4MDFmP277tytp0wXKtKuOJTvhvEJesSiT+lYnm38S2PuPWNMuh6syzQdSaaUrh8eQ
 zytEQdd23I1GxRCcSpw+EqDNUMFBUj4imkbNz4yQ/aj0Ppsjkz13Rvb+G8X5sfmsqjUz
 ceMtEjrG9jcO2eKuuG5WlJRL+3IYxRi99vL0x/CDR5wAS042V8Z2Uuv478c8U+dS0A86
 f8M0DgAlvJl+PqLGUmp0KVpb0l+8S4DUwGMKaSGwSVLBTmBcD6Dm8S3YMwnFhAecpMgg jQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbmy48xym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 17:04:42 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343H4fEb005094
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 17:04:41 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 10:04:35 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v3 18/18] firmware: qcom_scm: Add multiple download mode support
Date:   Wed, 3 May 2023 22:32:32 +0530
Message-ID: <1683133352-10046-19-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VbcRgKWOMRSE0qF1RQWPhjN5R6oFkcI2
X-Proofpoint-GUID: VbcRgKWOMRSE0qF1RQWPhjN5R6oFkcI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_12,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 4e8fd4e..be7adc6 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -32,6 +32,8 @@ static u32 download_mode;
 
 #define QCOM_DOWNLOAD_MODE_MASK 0x30
 #define QCOM_DOWNLOAD_FULLDUMP	0x1
+#define QCOM_DOWNLOAD_MINIDUMP  0x2
+#define QCOM_DOWNLOAD_BOTHDUMP	(QCOM_DOWNLOAD_FULLDUMP | QCOM_DOWNLOAD_MINIDUMP)
 #define QCOM_DOWNLOAD_NODUMP	0x0
 
 struct qcom_scm {
@@ -1422,13 +1424,16 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
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
 
@@ -1439,8 +1444,12 @@ static int set_download_mode(const char *val, const struct kernel_param *kp)
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
@@ -1463,7 +1472,7 @@ static const struct kernel_param_ops download_mode_param_ops = {
 
 module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
 MODULE_PARM_DESC(download_mode,
-		 "Download mode: off/full or 0/1 for existing users");
+		"download mode: off/full/mini/full,mini or mini,full and 0/1 for existing users");
 
 static int qcom_scm_probe(struct platform_device *pdev)
 {
-- 
2.7.4

