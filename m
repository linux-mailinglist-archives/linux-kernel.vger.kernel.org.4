Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFDF70D4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjEWH3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjEWH3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:29:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB79118F;
        Tue, 23 May 2023 00:28:53 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N4wJAJ015740;
        Tue, 23 May 2023 07:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=es6eYtFN4TvEiHU9fqntjiDXORLk7kyO352msyDkqo4=;
 b=fm7nJQqLMFi8MfHO53lUz5Fl5/1VtNyBxgZDRdGL+GrR/ZnKOtn8G+ODsqV1LOCyWPuo
 8Oma+VMM5szkYXkN7uavWEYCnzeuF+MgMryecn7MzqDDf2OkYASCyKurB9a0ijrMSpES
 JSckzCHhphbI958LJdBGWbkOC9lrJ+YcAA5n6KRXa8d3UJRjYrwuvDlZ+o3wbnQSW8r5
 CFgDd1TYuAzpmFVtnoiAavL/ZLqr0y1cYf56FTME/3W398ohBeMDFGAj6SGBBbdJHKv2
 gvZDwDvnBaa3vasTiE21QTmy7gSGXf9zMu96zSHm/zsG2j78dJqO9Iu4QojKeAaift1+ LQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qracshphb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:28:38 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N7SbGp018375
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:28:37 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 23 May 2023 00:28:37 -0700
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
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Eric Biggers <ebiggers@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/7] ufs: core: Combine 32-bit command_desc_base_addr_lo/hi
Date:   Tue, 23 May 2023 00:28:09 -0700
Message-ID: <0972259fefe5c3c4e223e9d2406eaa673220ff41.1684825500.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1684825500.git.quic_nguyenb@quicinc.com>
References: <cover.1684825500.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q0iAlsDUXy8DeSjzPAg1sMnv-HPUsc2c
X-Proofpoint-ORIG-GUID: Q0iAlsDUXy8DeSjzPAg1sMnv-HPUsc2c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

