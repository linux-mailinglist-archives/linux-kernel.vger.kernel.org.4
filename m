Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1763E7244C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbjFFNru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbjFFNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:47:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA55A83;
        Tue,  6 Jun 2023 06:47:43 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356DJgkN008180;
        Tue, 6 Jun 2023 13:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=avrggG40nwQhnErT5DdvyUXpaUeGxO4SczspNOUrwMU=;
 b=kj4ZEhydqwKOicJP7iVQd+qlBXqMpmMw+iaoSBZgilrKCxJASPgnLnrsg4PxFi0w1ODd
 +du3ywntbso4gcbQHsD2AaS0+rREGKrboXckfrd+MNf+PDBBWRe4MoCHO3cj0I97ye+D
 9wEsrXI4ENhpskDrjWlnu1A6i8PtGSNp/boW8zlO0lPcYr84rzvsV6Th5uI1TbJs4zFO
 TXgmSxtmk2MZZ4qy5M3wfG65Gui3JBW0+qRemtTo+mBnU98IOCYwYTV+Pc0EFe6G3CC1
 FXHqbSPN5eCT1xIy1GwHlJ8c933js1pt5ZXN4oSUd6y6UJ9IPXPef2lh8YI8WBaSpwVz Eg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r23bmgb8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 13:47:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 356DlY0Z003524
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 13:47:34 GMT
Received: from hu-namajain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 6 Jun 2023 06:47:01 -0700
From:   Naman Jain <quic_namajain@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Naman Jain <quic_namajain@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_kaushalk@quicinc.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 1/2] soc: qcom: socinfo: Add support for new fields in revision 18
Date:   Tue, 6 Jun 2023 19:16:25 +0530
Message-ID: <20230606134626.18790-2-quic_namajain@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230606134626.18790-1-quic_namajain@quicinc.com>
References: <20230606134626.18790-1-quic_namajain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4ew2YmNRFqbLbDqKefgLkrFBeKvbHtXx
X-Proofpoint-ORIG-GUID: 4ew2YmNRFqbLbDqKefgLkrFBeKvbHtXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_10,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060115
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
 drivers/soc/qcom/socinfo.c       | 1 +
 include/linux/soc/qcom/socinfo.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index dfd4330daef5..cb70f8439cfa 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -565,6 +565,7 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 			   &qcom_socinfo->info.fmt);
 
 	switch (qcom_socinfo->info.fmt) {
+	case SOCINFO_VERSION(0, 18):
 	case SOCINFO_VERSION(0, 17):
 		qcom_socinfo->info.oem_variant = __le32_to_cpu(info->oem_variant);
 		debugfs_create_u32("oem_variant", 0444, qcom_socinfo->dbg_root,
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
index d1cbc49a2a2d..3cc266d8a8b4 100644
--- a/include/linux/soc/qcom/socinfo.h
+++ b/include/linux/soc/qcom/socinfo.h
@@ -65,6 +65,9 @@ struct socinfo {
 	__le32  nnum_partname_mapping;
 	/* Version 17 */
 	__le32 oem_variant;
+	/* Version 18 */
+	__le32 num_kvps;
+	__le32 kvps_offset;
 };
 
 #endif
-- 
2.17.1

