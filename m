Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800426B916B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjCNLSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCNLRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:17:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D541F5E0;
        Tue, 14 Mar 2023 04:17:16 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EASWMV029423;
        Tue, 14 Mar 2023 11:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=NHEwW0FJdB+IyvXB3jHI0NlsCA9qEE+Vm/1I/vSAtCk=;
 b=FLGcdWCJ7PD1VtvAS7O20YrvP+P7qZm6+6P3tF5Xe6bn06l56urvZ292xB/F1MLbKEEJ
 0767tW5wm9P1NowvBUXMOdGL3bX694fFbiDr7IVNnd2VdyZ6Lnl5nU+W7VHs+A3Sm0Li
 it2eK0UiTHLGQkyWvZQMTKh+fnVebOzCTvXyJOCyM2rr+0WAWEhNOuksVgKCOw65rabY
 ufndmoGrbQejJPJwMwcU9JbO4FblxVPPOIuFe9WcJrfySr1aXcb6uIHhhG//rtcG1+gd
 ORtv2HrcXB5pccXzzQjUVorOnhjdDwrZ6/vRTcFb0B8ltYKfNnrojA78dw41GdzQo1tB iQ== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa9gfj6f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 11:16:27 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32EBGP2E011929;
        Tue, 14 Mar 2023 11:16:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3p8jqmemwe-1;
        Tue, 14 Mar 2023 11:16:25 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EBGO8U011923;
        Tue, 14 Mar 2023 11:16:24 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 32EBGOwK011921;
        Tue, 14 Mar 2023 11:16:24 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id 1E349452D; Tue, 14 Mar 2023 19:16:23 +0800 (CST)
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
Subject: [PATCH v6] scsi: ufs: core: Add trace event for MCQ
Date:   Tue, 14 Mar 2023 19:15:58 +0800
Message-Id: <1678792580-3178-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vi6ZInAyowe2xIiuO1IhoESH2taEogDK
X-Proofpoint-ORIG-GUID: vi6ZInAyowe2xIiuO1IhoESH2taEogDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_04,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140096
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MCQ hardware queue ID in the existing trace event
ufshcd_command().

Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>

---
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
 include/trace/events/ufs.h | 24 +++++++++++++-----------
 2 files changed, 25 insertions(+), 14 deletions(-)

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
index 599739e..f467472 100644
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
-		show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
-		__entry->tag, __entry->doorbell, __entry->transfer_len,
-		__entry->intr, __entry->lba, (u32)__entry->opcode,
-		str_opcode(__entry->opcode), (u32)__entry->group_id
+		"%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x, hwq_id: %d",
+		 show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
+		 __entry->tag, __entry->doorbell, __entry->transfer_len, __entry->intr,
+		 __entry->lba, (u32)__entry->opcode, str_opcode(__entry->opcode),
+		 (u32)__entry->group_id, __entry->hwq_id
 	)
 );
 
-- 
2.7.4

