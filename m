Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3086A943E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCCJgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCCJgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:36:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5232298F3;
        Fri,  3 Mar 2023 01:36:29 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3238mH8R007788;
        Fri, 3 Mar 2023 09:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=2gfBagHlN6y2kv5zAc1v1JPCBcPDYueOGdtNMXXB0ug=;
 b=CtjFhs9utJpwI+nn1i8J+zbPtVeTg/WNYGWETZCiQLWJl+R/zC9akKxzbEHWlt/qoofS
 Y/3Cd8+oPy4xcJBdqoDslsXYyhPi8G6uzKSp3nQQdOxcOEbxT1A91+nLE2Y2XkYC4LZv
 c4vgktp8eU7VuYC/IpZPnK/zgmnaFUDp6sSMjkzPIYI+WutmKa4WZISpFop2hpmeoFhy
 q0enqQJZYRay6ktOGB1YWDTeuuhXMQdOW8jgCXL2XMzKGj0j+MCrOkjVAgeVCeaijQUg
 3V6Qe9mVdi1IFzwS7jD+IJnWIbs01Co1pxG77CH/D7Qk9JQvDznYsjqjjiZVF6N9f+Ng aQ== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3dpxg477-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 09:36:13 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3239aA7X032015;
        Fri, 3 Mar 2023 09:36:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 3nybdkt0k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 03 Mar 2023 09:36:10 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3239a9uV032010;
        Fri, 3 Mar 2023 09:36:09 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3239a8qg032007;
        Fri, 03 Mar 2023 09:36:09 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id D2EF54197; Fri,  3 Mar 2023 17:36:06 +0800 (CST)
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
Subject: [PATCH v4] scsi: ufs: core: Add trace event for MCQ
Date:   Fri,  3 Mar 2023 17:35:37 +0800
Message-Id: <1677836154-29192-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1CXZXXP8FDtrVwtSbbzsna0jMAnQjrEv
X-Proofpoint-GUID: 1CXZXXP8FDtrVwtSbbzsna0jMAnQjrEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=988 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030084
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
Changes to v3:
- Free trace_ufshcd_command_mcq() from dependency on trace_ufshcd_command().

Changes to v2:
- Shorten printing strings.

Changes to v1:
- Adjust the order of fileds to keep them aligned.
---
 drivers/ufs/core/ufshcd.c  | 17 ++++++++++++----
 include/trace/events/ufs.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3b3cf78..e43aee1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -426,6 +426,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	struct scsi_cmnd *cmd = lrbp->cmd;
 	struct request *rq = scsi_cmd_to_rq(cmd);
+	struct ufs_hw_queue *hwq;
 	int transfer_len = -1;
 
 	if (!cmd)
@@ -433,7 +434,8 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 
 	/* trace UPIU also */
 	ufshcd_add_cmd_upiu_trace(hba, tag, str_t);
-	if (!trace_ufshcd_command_enabled())
+	if (!trace_ufshcd_command_enabled() &&
+		!trace_ufshcd_command_mcq_enabled())
 		return;
 
 	opcode = cmd->cmnd[0];
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
index 599739e..604b2cd 100644
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
+		"%s: %s: tag: %u, hqid: %d, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x, sqt: %d, cqh: %d, cqt: %d",
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

