Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18F269DA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjBUGIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjBUGIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:08:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552B82448B;
        Mon, 20 Feb 2023 22:08:01 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L5c3Sw003300;
        Tue, 21 Feb 2023 06:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=0fFkCeiQE3NtRJ37wyGYIMTx7LwAVKeGkLPpmlGDk7E=;
 b=OCC9e2uwrZ1vidrcyT5wyXDW1Wmp9eMYFhHVHn9XNttvI0H8SgVr1cnGJzgZry6zvNsJ
 RYwpa4l4AZGakXCe6fPa+b2ybhg3b1CFMD+rmdONWpBw8DOKxNgA6GBF/vkd+pgkb3Sd
 C2Q466lIQsKVF0E1Ne57xC4al5xEJkoYErgUQTyyMPPWfFceghtuGUz+AYUKfSjlqGUm
 4kL5sHdgGQ/zI0IIjV9XvNgkGm7TBqTHd9+0oN/tHhD/Dan5cBQ+fiewbbiloQIg0Vrf
 RJEViW5olZv0bBOjEBIFsegRXD+G1vXUH9LMpwsU/+RdbUWNLoG7Ys4hjcsFRL9lEd8j wQ== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntp98f2ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 06:07:30 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31L67QqH004211;
        Tue, 21 Feb 2023 06:07:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3ntqrm5a51-1;
        Tue, 21 Feb 2023 06:07:26 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31L67QXB004206;
        Tue, 21 Feb 2023 06:07:26 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 31L67Qaj004204;
        Tue, 21 Feb 2023 06:07:26 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id 6C1E5436F; Tue, 21 Feb 2023 14:07:25 +0800 (CST)
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        quic_ziqichen@quicinc.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH v2] scsi: ufs: core: Add trace event for MCQ
Date:   Tue, 21 Feb 2023 14:07:02 +0800
Message-Id: <1676959630-35504-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ciYzh-2hecphyOh1JnfwTKerMZf-qCUz
X-Proofpoint-ORIG-GUID: ciYzh-2hecphyOh1JnfwTKerMZf-qCUz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_02,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=963 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210053
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a new trace event to record MCQ relevant information
for each request in MCQ mode, include hardware queue ID,
SQ tail slot, CQ head slot and CQ tail slot.

Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
---
 drivers/ufs/core/ufshcd.c  | 14 +++++++++++---
 include/trace/events/ufs.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3b3cf78..67cb90d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -426,6 +426,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	struct scsi_cmnd *cmd = lrbp->cmd;
 	struct request *rq = scsi_cmd_to_rq(cmd);
+	struct ufs_hw_queue *hwq;
 	int transfer_len = -1;
 
 	if (!cmd)
@@ -456,9 +457,16 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 	}
 
 	intr = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
-	doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
-			doorbell, transfer_len, intr, lba, opcode, group_id);
+
+	if (is_mcq_enabled(hba)) {
+		hwq = ufshcd_mcq_req_to_hwq(hba, rq);
+		trace_ufshcd_command_mcq(dev_name(hba->dev), str_t, tag,
+				hwq, transfer_len, intr, lba, opcode, group_id);
+	} else {
+		doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
+				doorbell, transfer_len, intr, lba, opcode, group_id);
+	}
 }
 
 static void ufshcd_print_clk_freqs(struct ufs_hba *hba)
diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
index 599739e..4fccc34 100644
--- a/include/trace/events/ufs.h
+++ b/include/trace/events/ufs.h
@@ -10,6 +10,7 @@
 #define _TRACE_UFS_H
 
 #include <linux/tracepoint.h>
+#include <ufs/ufshcd.h>
 
 #define str_opcode(opcode)						\
 	__print_symbolic(opcode,					\
@@ -307,6 +308,53 @@ TRACE_EVENT(ufshcd_command,
 	)
 );
 
+TRACE_EVENT(ufshcd_command_mcq,
+	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t,
+		unsigned int tag, struct ufs_hw_queue *hwq, int transfer_len,
+		u32 intr, u64 lba, u8 opcode, u8 group_id),
+
+	TP_ARGS(dev_name, str_t, tag, hwq, transfer_len, intr, lba, opcode, group_id),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name)
+		__field(enum ufs_trace_str_t, str_t)
+		__field(unsigned int, tag)
+		__field(u32, hwq_id)
+		__field(u32, sq_tail)
+		__field(u32, cq_head)
+		__field(u32, cq_tail)
+		__field(int, transfer_len)
+		__field(u32, intr)
+		__field(u64, lba)
+		__field(u8, opcode)
+		__field(u8, group_id)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name);
+		__entry->str_t = str_t;
+		__entry->tag = tag;
+		__entry->hwq_id = hwq->id;
+		__entry->sq_tail = hwq->sq_tail_slot;
+		__entry->cq_head = hwq->cq_head_slot;
+		__entry->cq_tail = hwq->cq_tail_slot;
+		__entry->transfer_len = transfer_len;
+		__entry->intr = intr;
+		__entry->lba = lba;
+		__entry->opcode = opcode;
+		__entry->group_id = group_id;
+	),
+
+	TP_printk(
+		"%s: %s: tag: %u, hwq_id: %d, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x, sq_tail_slot: %d, cq_head_slot: %d, cq_tail_slot: %d",
+		show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
+		__entry->tag, __entry->hwq_id, __entry->transfer_len,
+		__entry->intr, __entry->lba, (u32)__entry->opcode,
+		str_opcode(__entry->opcode), (u32)__entry->group_id,
+		__entry->sq_tail, __entry->cq_head,  __entry->cq_tail
+	)
+);
+
 TRACE_EVENT(ufshcd_uic_command,
 	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t, u32 cmd,
 		 u32 arg1, u32 arg2, u32 arg3),
-- 
2.7.4

