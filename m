Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429626BA9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjCOHqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjCOHqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:46:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CD114E93;
        Wed, 15 Mar 2023 00:46:01 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F4pwqU005693;
        Wed, 15 Mar 2023 07:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=AJYsQZ0FLOCikvAnnI11GMMUIAhEsvxRaRKOF41W4UM=;
 b=HW/0nJda9mZzs1IcrAYi1h9HuLJEZUSEChdpKtRy4V99YD9yy7JmzqodWNywsGkqDLkB
 RChrOIQgiUpYNGDNLJWEFzUjQahlOJyx0ugHTMLyeTzIaTxankga2rpIeXMSB9Ukj640
 9X8ZxoHr/CmWIzLx84+HXOonjWx9m1jt8gSGfSKHzLQ02NGsbJvaWdyBH1kYrFwaq8DK
 WUAhcv7kK6NqtI3jnZbIgCqZIQaRChJoMHRVdFuXcJAS0KkGHt9jAAifpEF8E+XVSTmY
 xLwy8r3/CSCAJa30cvhaH19f+tdMtBUc9V4N5avKzV9Ij5wFBlo7qy+NopyhVt0wIu3W UA== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2c98vqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 07:44:37 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32F7iZeR017552;
        Wed, 15 Mar 2023 07:44:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3p8jqmjam9-1;
        Wed, 15 Mar 2023 07:44:35 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32F7iZ8g017547;
        Wed, 15 Mar 2023 07:44:35 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 32F7iYqN017543;
        Wed, 15 Mar 2023 07:44:35 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id D9E53455E; Wed, 15 Mar 2023 15:44:33 +0800 (CST)
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, quic_ziqichen@quicinc.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH v7] scsi: ufs: core: Add trace event for MCQ
Date:   Wed, 15 Mar 2023 15:44:25 +0800
Message-Id: <1678866271-49601-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MWBWMsQ2yBUp1nqbQAeaHN8KC79GQfDS
X-Proofpoint-GUID: MWBWMsQ2yBUp1nqbQAeaHN8KC79GQfDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_04,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2302240000 definitions=main-2303150064
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MCQ hardware queue ID in the existing trace event
ufshcd_command().

Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>

---
Changes to v6:
- Corrected the alignment of the TP_printk() arguments.

Changes to v5:
- Changed hwq_id type from u32 to int.
- Changed printing string of hwq id from "hqid" to "hwq_id".
- Moved the assignment statement of hwq into the MCQ if-statement.

Changes to v4:
- Merged MCQ and SDB trace event as one.

Changes to v3:
- Free trace_ufshcd_command_mcq() from dependency on trace_ufshcd_command().

Changes to v2:
- Shorten printing strings.

Changes to v1:
- Adjust the order of fields to keep them aligned.
---
 drivers/ufs/core/ufshcd.c  | 15 ++++++++++++---
 include/trace/events/ufs.h | 22 ++++++++++++----------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3b3cf78..1d58cb2 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -422,7 +422,9 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 {
 	u64 lba = 0;
 	u8 opcode = 0, group_id = 0;
-	u32 intr, doorbell;
+	u32 doorbell = 0;
+	u32 intr;
+	int hwq_id = -1;
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	struct scsi_cmnd *cmd = lrbp->cmd;
 	struct request *rq = scsi_cmd_to_rq(cmd);
@@ -456,9 +458,16 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 	}
 
 	intr = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
-	doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
+
+	if (is_mcq_enabled(hba)) {
+		struct ufs_hw_queue *hwq = ufshcd_mcq_req_to_hwq(hba, rq);
+
+		hwq_id = hwq->id;
+	} else {
+		doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
+	}
 	trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
-			doorbell, transfer_len, intr, lba, opcode, group_id);
+			doorbell, hwq_id, transfer_len, intr, lba, opcode, group_id);
 }
 
 static void ufshcd_print_clk_freqs(struct ufs_hba *hba)
diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
index 599739e..992517ac 100644
--- a/include/trace/events/ufs.h
+++ b/include/trace/events/ufs.h
@@ -268,20 +268,21 @@ DEFINE_EVENT(ufshcd_template, ufshcd_wl_runtime_resume,
 
 TRACE_EVENT(ufshcd_command,
 	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t,
-		 unsigned int tag, u32 doorbell, int transfer_len, u32 intr,
-		 u64 lba, u8 opcode, u8 group_id),
+		 unsigned int tag, u32 doorbell, u32 hwq_id, int transfer_len,
+		 u32 intr, u64 lba, u8 opcode, u8 group_id),
 
-	TP_ARGS(dev_name, str_t, tag, doorbell, transfer_len,
-				intr, lba, opcode, group_id),
+	TP_ARGS(dev_name, str_t, tag, doorbell, hwq_id, transfer_len,
+			intr, lba, opcode, group_id),
 
 	TP_STRUCT__entry(
 		__string(dev_name, dev_name)
 		__field(enum ufs_trace_str_t, str_t)
 		__field(unsigned int, tag)
 		__field(u32, doorbell)
-		__field(int, transfer_len)
+		__field(u32, hwq_id)
 		__field(u32, intr)
 		__field(u64, lba)
+		__field(int, transfer_len)
 		__field(u8, opcode)
 		__field(u8, group_id)
 	),
@@ -291,19 +292,20 @@ TRACE_EVENT(ufshcd_command,
 		__entry->str_t = str_t;
 		__entry->tag = tag;
 		__entry->doorbell = doorbell;
-		__entry->transfer_len = transfer_len;
+		__entry->hwq_id = hwq_id;
 		__entry->intr = intr;
 		__entry->lba = lba;
+		__entry->transfer_len = transfer_len;
 		__entry->opcode = opcode;
 		__entry->group_id = group_id;
 	),
 
 	TP_printk(
-		"%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x",
+		"%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x, hwq_id: %d",
 		show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
-		__entry->tag, __entry->doorbell, __entry->transfer_len,
-		__entry->intr, __entry->lba, (u32)__entry->opcode,
-		str_opcode(__entry->opcode), (u32)__entry->group_id
+		__entry->tag, __entry->doorbell, __entry->transfer_len, __entry->intr,
+		__entry->lba, (u32)__entry->opcode, str_opcode(__entry->opcode),
+		(u32)__entry->group_id, __entry->hwq_id
 	)
 );
 
-- 
2.7.4

