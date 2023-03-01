Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7715E6A6ACC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCAK3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjCAK3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:29:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946E22A6F3;
        Wed,  1 Mar 2023 02:29:47 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3212wTt7022351;
        Wed, 1 Mar 2023 09:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ISrDjq0Ha+uMnwpC23DHqi+F/2UqrQtb9WTbLZDU0/U=;
 b=eygTnG7ELDW+Nze3h2K5GDlvOzaBBR9mr2l8Lo/9Xb1kLVdrdxALUvsKlHNdKcxEbr/5
 TQriZ/I3JZX+/a5bIIEe2ZcF+pCykqJhbA851wHdnIIXBLdINtQZwMKXhnMRkJuIR7MM
 HORnBDmRfOD+Wp3L3i1r4wh27hYZNKb2A1WBtQDGWHUw0IuWDD73B8xVra9UPWSr5G9a
 4A5d/PdNJGZ0FNvlYAtAc1NeQZNoGD6450Eyxmgx38IO/A615T4hZU2en1g+mlxKJ42t
 g37Z9ZL8dBDN1rwFwgN/du3q8BAIC2ubf0PN3valcpVk9N4tp82H6rPqHuKxrx18FGyf ug== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1p8h29qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 09:57:07 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3219v6Pp021308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 09:57:06 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 1 Mar 2023 01:57:04 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v2 4/4] firmware: qcom_scm: Add multiple download mode support
Date:   Wed, 1 Mar 2023 15:25:55 +0530
Message-ID: <1677664555-30191-5-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1677664555-30191-1-git-send-email-quic_mojha@quicinc.com>
References: <1677664555-30191-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JY9-77q6ci4Ji-_D774m5f-k1B8-gaVk
X-Proofpoint-GUID: JY9-77q6ci4Ji-_D774m5f-k1B8-gaVk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, scm driver only supports full dump when download
mode is selected. Add support to enable minidump as well both
dump(full dump + minidump).

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Changes in v2:
  - Accept mini/both as acceptable output.

 drivers/firmware/qcom_scm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index ca07208..39e071a 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -27,6 +27,8 @@
 
 #define QCOM_DOWNLOAD_MODE_MASK 0x30
 #define QCOM_DOWNLOAD_FULLDUMP	0x10
+#define QCOM_DOWNLOAD_MINIDUMP	0x20
+#define QCOM_DOWNLOAD_BOTHDUMP	(QCOM_DOWNLOAD_FULLDUMP | QCOM_DOWNLOAD_MINIDUMP)
 #define QCOM_DOWNLOAD_NODUMP	0x0
 
 #define MAX_DLOAD_LEN	8
@@ -1350,6 +1352,10 @@ static int set_dload_mode(const char *val, const struct kernel_param *kp)
 
 	if (!strncmp(val, "full", strlen("full"))) {
 		dload_mode = QCOM_DOWNLOAD_FULLDUMP;
+	} else if (!strncmp(val, "mini", strlen("mini"))) {
+		dload_mode = QCOM_DOWNLOAD_MINIDUMP;
+	} else if (!strncmp(val, "both", strlen("both"))) {
+		dload_mode = QCOM_DOWNLOAD_BOTHDUMP;
 	} else if (!strncmp(val, "off", strlen("off"))) {
 		dload_mode = QCOM_DOWNLOAD_NODUMP;
 	} else {
@@ -1383,7 +1389,7 @@ static struct kparam_string dload_mode_param = {
 
 module_param_cb(download_mode, &dload_mode_param_ops, &dload_mode_param, 0644);
 MODULE_PARM_DESC(download_mode,
-		 "Download mode: off/full or 0/1/off/on for existing users");
+		 "download mode: off/full/mini/both(full+mini) or 0/1/off/on for existing users");
 
 static int qcom_scm_probe(struct platform_device *pdev)
 {
-- 
2.7.4

