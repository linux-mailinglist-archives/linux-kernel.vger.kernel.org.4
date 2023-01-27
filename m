Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35C867DCC9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 05:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjA0EM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 23:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0EM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 23:12:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C806C16F;
        Thu, 26 Jan 2023 20:12:55 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R3QSEG015951;
        Fri, 27 Jan 2023 04:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=8piCRJQO7eiW1P5sI8B5HFXQqLL7QTZjzhjBvPQyIug=;
 b=MG/AnhLZLBVANfC0t95CeWXxQ6n3s7r5kPxO2c9QPvJjmzvdW69VizbV27flsv9zRB80
 BhBQth0ROKhif94u+3Zsz93mvi6iGsN5e8atz30HaDb2ljSNISInoxqEp7DwoywEk03q
 rFEJShQpj7xA3Hyv9Jo578Yav/I9b5vndg3zJbnAib895nsyB4lpp5LL1pZxpcileaNW
 2jLR0wJ7AL2CjCAawEQsnSVWWG0toWCidiwNHKAOvoci/fu3n1qDp1APH+NvlSxLHvRs
 6uGwIokDspRkYPvLPPr3Jvn8pTJ1+SSv0s3uMKuCRL0Uqlxqyb7mSs3Ma0ua4G864b+9 Mg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nbyma0p4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 04:12:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30R4CkU9001353
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 04:12:46 GMT
Received: from hu-namajain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 26 Jan 2023 20:12:42 -0800
From:   Naman Jain <quic_namajain@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Trilok Soni <quic_tsoni@quicinc.com>
CC:     Naman Jain <quic_namajain@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2] soc: qcom: socinfo: Add support for new field in revision 17
Date:   Fri, 27 Jan 2023 09:42:00 +0530
Message-ID: <20230127041200.29094-1-quic_namajain@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cg7ewD5qn2JaxQEPhiwiIkBb0I0kM6et
X-Proofpoint-GUID: cg7ewD5qn2JaxQEPhiwiIkBb0I0kM6et
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301270037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for new field coming with socinfo structure under v17 to get
hardware platform's oem variant id. This is to enable OEMs to have minor
changes in the board, but to use the same platform subtype as the one
supported by Qualcomm. The new field is to be used in platform overlay
file. Default value is 0, reserved for Qualcomm platforms. Also, add
debugfs support to read this field for a device.

Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
---
v1 -> v2: Removed change-id, included SOB line
 
 drivers/soc/qcom/socinfo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 10efdbcfdf05..10cdd32ce74d 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -174,6 +174,8 @@ struct socinfo {
 	__le32  pcode;
 	__le32  npartnamemap_offset;
 	__le32  nnum_partname_mapping;
+	/* Version 17 */
+	__le32 oem_variant;
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -196,6 +198,7 @@ struct socinfo_params {
 	u32 nmodem_supported;
 	u32 feature_code;
 	u32 pcode;
+	u32 oem_variant;
 };
 
 struct smem_image_version {
@@ -519,6 +522,11 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 			   &qcom_socinfo->info.fmt);
 
 	switch (qcom_socinfo->info.fmt) {
+	case SOCINFO_VERSION(0, 17):
+		qcom_socinfo->info.oem_variant = __le32_to_cpu(info->oem_variant);
+		debugfs_create_u32("oem_variant", 0444, qcom_socinfo->dbg_root,
+				   &qcom_socinfo->info.oem_variant);
+		fallthrough;
 	case SOCINFO_VERSION(0, 16):
 		qcom_socinfo->info.feature_code = __le32_to_cpu(info->feature_code);
 		qcom_socinfo->info.pcode = __le32_to_cpu(info->pcode);
-- 
2.17.1

