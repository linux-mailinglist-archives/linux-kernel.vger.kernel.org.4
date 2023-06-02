Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33E271F8EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjFBD0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjFBD0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:26:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C0B107;
        Thu,  1 Jun 2023 20:26:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3523EfqN010425;
        Fri, 2 Jun 2023 03:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=IVWQ6B1dnBh46dUgPAtcBsGR0yHFyij6jXcRhvErMQU=;
 b=DwW+QvD/ZnUhZ1utW9z6c3WA4hd3dzY8kg58O8walQmIJOPUYSzBHNXIKhT4/lmFsY77
 YP+J74cD+j14dxXslxYCywRvIRjuyZg+0YE/2NmBDw/JrpgCf57/q3jqz3QxnCe+hjyg
 5Lt11RWgIGEy9GWuH4IpjDcgYIEx8C+3eTwol8wfdZ5SRXu5JzeQZVkNu1mhThIxetoc
 JN+opPTigONlNuwUCx7AXnaxQBGGHS9pbZVPIm7/12Df/7wWXKseEiBpFG3CW/IP/71Z
 XTFTyoBMbzkDNds2GchcppH1VnXYbDywG0N0xYpDFXlwFwflBKq+Lb1QSTNtnGgTBLAA jw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qy83901cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 03:26:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3523QMe0017133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 03:26:22 GMT
Received: from hu-namajain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 20:26:20 -0700
From:   Naman Jain <quic_namajain@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Naman Jain <quic_namajain@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_kaushalk@quicinc.com>
Subject: [PATCH 1/2] soc: qcom: socinfo: Add support for new fields in revision 18
Date:   Fri, 2 Jun 2023 08:55:59 +0530
Message-ID: <20230602032600.14790-1-quic_namajain@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -wwoUWJtM3RK2OHlqimOnS_ot3rK1XmB
X-Proofpoint-ORIG-GUID: -wwoUWJtM3RK2OHlqimOnS_ot3rK1XmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_01,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for below fields coming in socinfo structure under v18:
* num_kvps: number of key value pairs (KVP)
* kvps_offset: the offset of the KVP table from the base address of
  socinfo structure in SMEM
KVP table has boolean values for certain feature flags, used to determine
hardware configuration.

Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index c2e4a57dd666..a76006ea8a37 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -181,6 +181,9 @@ struct socinfo {
 	__le32  nnum_partname_mapping;
 	/* Version 17 */
 	__le32 oem_variant;
+	/* Version 18 */
+	__le32 num_kvps;
+	__le32 kvps_offset;
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -620,6 +623,7 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 			   &qcom_socinfo->info.fmt);
 
 	switch (qcom_socinfo->info.fmt) {
+	case SOCINFO_VERSION(0, 18):
 	case SOCINFO_VERSION(0, 17):
 		qcom_socinfo->info.oem_variant = __le32_to_cpu(info->oem_variant);
 		debugfs_create_u32("oem_variant", 0444, qcom_socinfo->dbg_root,
-- 
2.17.1

