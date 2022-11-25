Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140B363879D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKYKgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKYKf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:35:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E61303CB;
        Fri, 25 Nov 2022 02:35:58 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AP8tcrq013196;
        Fri, 25 Nov 2022 10:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9/JwlFdZxR/Av60fuDgGOCsKJSidvpa774Rv0zzgIVk=;
 b=T3F94jKoEZsd6FVOLYLB34v1S0x/Ffnbi2EV4oaqKViueP+ktjwGEmORCmwGO1ZcUUSv
 2QutnVixNC+s/T/U0VL1uvKBhH4nJgp1pJ1m1J2NxDw7UNrhGCEGIo6e+V+lTTdK12of
 Wkid9Pg07sa3kYfgy+5ssNvLXxjBG2wWoZ0c9n3k2WrZXe5hu5Vp3UKV/KnPu8g9VNck
 71vC/eyo49JCQdse73DOgMPAHzZSYB2h/MiN305mxU18GWTzdQ94HkWJzkct4C7EKFHx
 sHo0Kn/noFJMrnocDXE6lymdsB2AB25RiNiTmMhifeVQVcy5rR4GRhHrVArAhnxU3Usx gw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m1gxeqa93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 10:35:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2APAZnew001693
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 10:35:49 GMT
Received: from hu-namajain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 25 Nov 2022 02:35:46 -0800
From:   Naman Jain <quic_namajain@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Naman Jain <quic_namajain@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_mojha@quicinc.com>,
        <quic_shashim@quicinc.com>
Subject: [PATCH] soc: qcom: socinfo: Add support for new fields in revision 16
Date:   Fri, 25 Nov 2022 16:05:33 +0530
Message-ID: <20221125103533.2960-1-quic_namajain@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yXJKhxTPkfvEkdGKFSBKVbFznjSK3hLK
X-Proofpoint-ORIG-GUID: yXJKhxTPkfvEkdGKFSBKVbFznjSK3hLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211250083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for new fields coming with socinfo structure under v16 to get
SKU information, product code and name and type of different parts present
in the SoC. Also, add debugfs nodes to read feature and product codes to
allow user to get SKU and other SoC details. Support for SoC parts name
and type parsing will be added separately. Details of fields added:
* feature_code: mapped to qcom internal and external SKU IDs
* pcode: product code
* npartnamemap_offset: parts name map array offset from socinfo base ptr
* nnum_partname_mapping: number of part mappings

Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 545934aead43..0464e79a3c91 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -169,6 +169,11 @@ struct socinfo {
 	__le32 ndefective_parts_array_offset;
 	/* Version 15 */
 	__le32 nmodem_supported;
+	/* Version 16 */
+	__le32  feature_code;
+	__le32  pcode;
+	__le32  npartnamemap_offset;
+	__le32  nnum_partname_mapping;
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -189,6 +194,8 @@ struct socinfo_params {
 	u32 num_defective_parts;
 	u32 ndefective_parts_array_offset;
 	u32 nmodem_supported;
+	u32 feature_code;
+	u32 pcode;
 };
 
 struct smem_image_version {
@@ -503,6 +510,15 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 			   &qcom_socinfo->info.fmt);
 
 	switch (qcom_socinfo->info.fmt) {
+	case SOCINFO_VERSION(0, 16):
+		qcom_socinfo->info.feature_code = __le32_to_cpu(info->feature_code);
+		qcom_socinfo->info.pcode = __le32_to_cpu(info->pcode);
+
+		debugfs_create_u32("feature_code", 0444, qcom_socinfo->dbg_root,
+				   &qcom_socinfo->info.feature_code);
+		debugfs_create_u32("pcode", 0444, qcom_socinfo->dbg_root,
+				   &qcom_socinfo->info.pcode);
+		fallthrough;
 	case SOCINFO_VERSION(0, 15):
 		qcom_socinfo->info.nmodem_supported = __le32_to_cpu(info->nmodem_supported);
 
-- 
2.17.1

