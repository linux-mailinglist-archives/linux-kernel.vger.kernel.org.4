Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6C06FD623
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjEJFZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbjEJFZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:25:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752FEE53;
        Tue,  9 May 2023 22:25:47 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A2iO8h025142;
        Wed, 10 May 2023 05:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=uEG9NCAeHkYxw7zM+ehn1ThstYlWo7xMCJyDEpC9A+Y=;
 b=NsFUKqnVyhOiKXNvp0oG3HEgrK/Jr+6hZ4wbToVcMQlkKsAdaVqBuS5QxqPKnmaMIK0P
 h9iTgt54YktyVOuFpo00lQDgwerTQJGSCQdaDYGhN4p8D6VZl6eDD1lxyQqZCSbV4+Z8
 eKUBiCR2gP1mfkPglvLx4BTWFSOwZBpD8v3FfR52OOPpwa1Gfu0kd6yBOLWEyvon1oyl
 CoShXggWR/LM6sEVFlEvwIXevMLDoE1aPKjHSn3I2B0Ga/ugGJyB1zc4fA9mQPT+8th5
 WdZvNgqIKQPgSCRaqJlMvmF7JP7cBVojHcORo6J86gu7ahjdCBM4+od5sYiC+evqc7/U qA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfsxj95sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 05:25:33 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34A5PWtQ021630
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 05:25:32 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 22:25:31 -0700
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
        Eric Biggers <ebiggers@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/7] ufs: core: Combine 32-bit command_desc_base_addr_lo/hi
Date:   Tue, 9 May 2023 22:24:22 -0700
Message-ID: <c05c3df353d18800cde800bd629f7dc4983c1402.1683688692.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1683688692.git.quic_nguyenb@quicinc.com>
References: <cover.1683688692.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BFCH8wCEvVB0KzW8emNXLg_P8Jw3Rva1
X-Proofpoint-GUID: BFCH8wCEvVB0KzW8emNXLg_P8Jw3Rva1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100042
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The utp command descriptor base address is a 57-bit field in the utp
utp transfer request descriptor. Combine the two 32-bit
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

