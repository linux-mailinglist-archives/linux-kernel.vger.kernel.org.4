Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780B869E289
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjBUOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjBUOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:40:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968A02B2B7;
        Tue, 21 Feb 2023 06:40:09 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LEblQP003378;
        Tue, 21 Feb 2023 14:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=XwI+g78iar6iebOl3PnrPCN4WLZBQYovSpKT7M6IcVo=;
 b=cxZfoHOU5eTqktVjj+Trwp+BCj8bk13rEX2eutRkbFEZI/SymafRhKuffjlIo9BxsYBr
 276spCF88y3DFzyuGhONbdv5dM4v9hn7pYDRIl2hGOQxoAjCR18KGdrVbkY3OHFe/On3
 EWX+azFrdh4VoCePe0ajNMSTUdFScvSsrKm6GRHel5Et0+DNhW3TV4LQBSztFqjmgfBP
 +35skW6U/AvK3ykFvqI0V0o2GFrdsQ92t8ANdv7c25k+pOB/mi07p+leNVqneu0mhdDA
 Z0C0+LY9alHRHa3loounat7y23As0tIOiOJNS+VmmdEwyoUD3Aoz/hbq2NqcAfrf9n/N 9A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntpw9qqua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 14:40:06 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LEe6Dv021590
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 14:40:06 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Feb 2023 06:40:03 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH 4/4] firmware: qcom_scm: Add multiple download mode support
Date:   Tue, 21 Feb 2023 20:09:41 +0530
Message-ID: <1676990381-18184-5-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1676990381-18184-1-git-send-email-quic_mojha@quicinc.com>
References: <1676990381-18184-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Iwy2OPJc8TMGisDZc_QrE2t_76SlJUMR
X-Proofpoint-GUID: Iwy2OPJc8TMGisDZc_QrE2t_76SlJUMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210122
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/firmware/qcom_scm.c | 5 ++++-
 include/linux/qcom_scm.h    | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 4975d3c..b7a2715 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -34,6 +34,8 @@ static int set_dload_mode(const char *val, const struct kernel_param *kp)
 
 	switch(download_mode) {
 	case QCOM_DOWNLOAD_FULLDUMP:
+	case QCOM_DOWNLOAD_MINIDUMP:
+	case QCOM_DOWNLOAD_BOTHDUMP:
 		if (__scm)
 			qcom_scm_set_download_mode(true);
 		break;
@@ -56,7 +58,8 @@ static const struct kernel_param_ops dload_mode_param_ops = {
 };
 module_param_cb(download_mode, &dload_mode_param_ops, &download_mode, 0644);
 MODULE_PARM_DESC(download_mode,
-		 "Download mode: 0x0=no dump mode (default), 0x10=full dump mode");
+		 "Download mode: 0x0=no dump mode (default), 0x10=full dump mode, "
+		 "0x20=mini dump mode 0x30=both(full + mini)dump mode");
 
 #define SCM_HAS_CORE_CLK	BIT(0)
 #define SCM_HAS_IFACE_CLK	BIT(1)
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index dd6aced..8304c73c 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -17,6 +17,8 @@
 #define QCOM_DOWNLOAD_MODE_MASK 0x30
 #define QCOM_DOWNLOAD_NODUMP	0x0
 #define QCOM_DOWNLOAD_FULLDUMP	0x10
+#define QCOM_DOWNLOAD_MINIDUMP	0x20
+#define QCOM_DOWNLOAD_BOTHDUMP	(QCOM_DOWNLOAD_FULLDUMP | QCOM_DOWNLOAD_MINIDUMP)
 
 struct qcom_scm_hdcp_req {
 	u32 addr;
-- 
2.7.4

