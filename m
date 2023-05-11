Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F766FFC24
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbjEKVzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbjEKVzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:55:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22CD59F4;
        Thu, 11 May 2023 14:55:34 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BLDXgr023843;
        Thu, 11 May 2023 21:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=es6eYtFN4TvEiHU9fqntjiDXORLk7kyO352msyDkqo4=;
 b=IihAqs/bsDQPszPk7AKXOB9prS42I4pVllLNMDMlDiOLGKGPC3p9IxL3JP8CRSVduCDo
 ZJE2Jvc5RFrb+VthffbT5J7SSBhf7XqINCoYquif5YRExpZ7tqnR7O94EEHaN2VNmoCi
 F5A/FBwYJDsZklb4RUw0gM4hPwm4O9NwqK5HeS1EgxKcdodvOhB/Q0W8N3qEphEKmiXo
 zIme5ge1E5j7CjDs5QE+C5+tRNjLq02AK7rIg3CjWBRTNeiyJfNS7G7Da03wIXilioG7
 +hAttHj05mXu0ja7oA3YaPj1aYKmahA7cpUFkGVphlHXiuSH0Y97zWTc5Kyf/2Cj1jeS Rw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qh1k9h1d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 21:55:21 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34BLtKLu031953
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 21:55:20 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 11 May 2023 14:55:19 -0700
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
To:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Eric Biggers <ebiggers@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/7] ufs: core: Combine 32-bit command_desc_base_addr_lo/hi
Date:   Thu, 11 May 2023 14:54:38 -0700
Message-ID: <7dec3a486501d9e30dfb5a70eed7c7661187b8c9.1683841772.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1683841772.git.quic_nguyenb@quicinc.com>
References: <cover.1683841772.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ILlZBjB-9ydt-NuZoqjHo74fFDFqZjr1
X-Proofpoint-GUID: ILlZBjB-9ydt-NuZoqjHo74fFDFqZjr1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110186
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UTP command descriptor base address is a 57-bit field in the
UTP transfer request descriptor. Combine the two 32-bit
command_desc_base_addr_lo/hi fields into a 64-bit for better handling
of this field.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 6 ++----
 include/ufs/ufshci.h      | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9434328..5527d45 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3875,10 +3875,8 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
 		/* Configure UTRD with command descriptor base address */
 		cmd_desc_element_addr =
 				(cmd_desc_dma_addr + (cmd_desc_size * i));
-		utrdlp[i].command_desc_base_addr_lo =
-				cpu_to_le32(lower_32_bits(cmd_desc_element_addr));
-		utrdlp[i].command_desc_base_addr_hi =
-				cpu_to_le32(upper_32_bits(cmd_desc_element_addr));
+		utrdlp[i].command_desc_base_addr =
+				cpu_to_le64(cmd_desc_element_addr);
 
 		/* Response upiu and prdt offset should be in double words */
 		if (hba->quirks & UFSHCD_QUIRK_PRDT_BYTE_GRAN) {
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 11424bb..7c5a76b 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -503,8 +503,7 @@ struct request_desc_header {
 /**
  * struct utp_transfer_req_desc - UTP Transfer Request Descriptor (UTRD)
  * @header: UTRD header DW-0 to DW-3
- * @command_desc_base_addr_lo: UCD base address low DW-4
- * @command_desc_base_addr_hi: UCD base address high DW-5
+ * @command_desc_base_addr: UCD base address DW 4-5
  * @response_upiu_length: response UPIU length DW-6
  * @response_upiu_offset: response UPIU offset DW-6
  * @prd_table_length: Physical region descriptor length DW-7
@@ -516,8 +515,7 @@ struct utp_transfer_req_desc {
 	struct request_desc_header header;
 
 	/* DW 4-5*/
-	__le32  command_desc_base_addr_lo;
-	__le32  command_desc_base_addr_hi;
+	__le64  command_desc_base_addr;
 
 	/* DW 6 */
 	__le16  response_upiu_length;
-- 
2.7.4

