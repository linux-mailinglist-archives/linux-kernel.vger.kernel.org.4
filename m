Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8334698AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 04:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBPDBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 22:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPDBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 22:01:15 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017A61CF7C;
        Wed, 15 Feb 2023 19:01:14 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FLMUTC018392;
        Thu, 16 Feb 2023 03:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=ULN4r01zpruCnC+43nrnkcWfsi615pZRfGp/0Uk2Mt0=;
 b=DRheqwq5xgPj796/zfaOWLrXi9x1Y6eWVspsQawKj2S7em/HdTQhykhm74p5oUrZvRpd
 239VAEI9iSqj1loD1NC/28OfoMtbDwcxp6H9Y1Txed3CI8JGfjXeJYw0HG+gHagqlldS
 4yFlm3mRw+OeE+JSrkydkge/lfUWkhyhvSkR01yu4ZuiT1t96dVbYp7uRBs7ZN52acjB
 2VgLc5EyKKfMrgUFTkXpQwvvY9Nz0GZbQ3XC6ajMbcl4tUeCsU+YWkQnYvnqwAAwp1fD
 auD8uBk1Gkna6hZySC3aEH2hIGifxLAop68QUqwk/hEXN97c2HnE4raIgsFJBaW77DoR CA== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ns0hkhr4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 03:00:34 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31G30W5w006835;
        Thu, 16 Feb 2023 03:00:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 3np43mdfep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 16 Feb 2023 03:00:32 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31G30VhU006830;
        Thu, 16 Feb 2023 03:00:31 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 31G30VHk006828;
        Thu, 16 Feb 2023 03:00:31 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id C0B3C431D; Thu, 16 Feb 2023 10:47:17 +0800 (CST)
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Ziqi Chen <quic_ziqichen@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH v1] scsi: ufs: core: Add trace event for MCQ
Date:   Thu, 16 Feb 2023 10:45:55 +0800
Message-Id: <1676515562-55805-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QcZ1EmstP2vnMem962zRADFaiz9BY6BJ
X-Proofpoint-GUID: QcZ1EmstP2vnMem962zRADFaiz9BY6BJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_15,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=991
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160023
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/ufs/core/ufshcd.c  | 15 ++++++++++++---
 include/trace/events/ufs.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3b3cf78..0037f4f 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -426,6 +426,8 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	struct scsi_cmnd *cmd = lrbp->cmd;
 	struct request *rq = scsi_cmd_to_rq(cmd);
+	struct ufs_hw_queue *hwq;
+
 	int transfer_len = -1;
 
 	if (!cmd)
@@ -456,9 +458,16 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
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
index 599739e..a406404e 100644
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
+		__field(int, transfer_len)
+		__field(u32, intr)
+		__field(u64, lba)
+		__field(u8, opcode)
+		__field(u8, group_id)
+		__field(u32, sq_tail)
+		__field(u32, cq_head)
+		__field(u32, cq_tail)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name);
+		__entry->str_t = str_t;
+		__entry->tag = tag;
+		__entry->hwq_id = hwq->id;
+		__entry->transfer_len = transfer_len;
+		__entry->intr = intr;
+		__entry->lba = lba;
+		__entry->opcode = opcode;
+		__entry->group_id = group_id;
+		__entry->sq_tail = hwq->sq_tail_slot;
+		__entry->cq_head = hwq->cq_head_slot;
+		__entry->cq_tail = hwq->cq_tail_slot;
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

