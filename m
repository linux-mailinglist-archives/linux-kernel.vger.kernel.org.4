Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC86B7258
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCMJSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCMJST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:18:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41772113D1;
        Mon, 13 Mar 2023 02:18:15 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D7SK8Y029779;
        Mon, 13 Mar 2023 09:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=0H7NGg+no3R1jEB+A9Rmw3VAqYB+CcMABuXkv6FUM3M=;
 b=IJGkpibQB0zxFhT75OVyywJa+YjNJ9yQIucR44IntJHC5EvhyGKhuXJtHbErgH2Dn9Vk
 9ubwtOJ0Rq6F/EJjXekaiXq3VAtiuHfc1ERZhpcsk7I8G+oXSF1d5MjsQskhFjZagYDj
 CGvE2cSCuet71H6w32qjYnY07j4R9Z2ucsP5jv/2aHtzEaVG7zdUsS+/4QhYSztfZPXj
 ewDgbdzdx51zBYZtwbrLfZ6AuHgSzpPLSnUwzDHXCSp0bRcCEzHt/0xcu1Vyl3A57dPM
 IHIWfxPLuwAowPdzxJk9IXXUVM/hoNxPdqMCQkyFGezOVHeX7G0dV9aRDUobu6JzzGum RQ== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p9yew08hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 09:17:50 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32D9HlAc009088;
        Mon, 13 Mar 2023 09:17:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3p8jqm9tbk-1;
        Mon, 13 Mar 2023 09:17:47 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32D9HlVU009083;
        Mon, 13 Mar 2023 09:17:47 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 32D9HkiP009082;
        Mon, 13 Mar 2023 09:17:47 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id 97CFD452E; Mon, 13 Mar 2023 17:17:45 +0800 (CST)
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
Subject: [PATCH v5] scsi: ufs: core: Add trace event for MCQ
Date:   Mon, 13 Mar 2023 17:16:05 +0800
Message-Id: <1678699023-6645-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zMmCpXuZLgWsQLgS0pZELvB1skl3au7W
X-Proofpoint-ORIG-GUID: zMmCpXuZLgWsQLgS0pZELvB1skl3au7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130075
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
Changes to v4:
- Merged MCQ and SDB trace event as one.

Changes to v3:
- Free trace_ufshcd_command_mcq() from dependency on trace_ufshcd_command().

Changes to v2:
- Shorten printing strings.

Changes to v1:
- Adjust the order of fileds to keep them aligned.
---
 drivers/ufs/core/ufshcd.c  | 15 ++++++++++++---
 include/trace/events/ufs.h | 24 +++++++++++++-----------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3b3cf78..53a7287 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -422,10 +422,12 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 {
 	u64 lba = 0;
 	u8 opcode = 0, group_id = 0;
-	u32 intr, doorbell;
+	u32 doorbell = 0, hwq_id = 0;
+	u32 intr;
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	struct scsi_cmnd *cmd = lrbp->cmd;
 	struct request *rq = scsi_cmd_to_rq(cmd);
+	struct ufs_hw_queue *hwq = NULL;
 	int transfer_len = -1;
 
 	if (!cmd)
@@ -456,9 +458,16 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 	}
 
 	intr = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
-	doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
+
+	if (is_mcq_enabled(hba)) {
+		hwq = ufshcd_mcq_req_to_hwq(hba, rq);
+		hwq_id = hwq->id;
+	} else {
+		doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		hwq_id = -1;
+	}
 	trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
-			doorbell, transfer_len, intr, lba, opcode, group_id);
+			doorbell, hwq_id, transfer_len, intr, lba, opcode, group_id);
 }
 
 static void ufshcd_print_clk_freqs(struct ufs_hba *hba)
diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
index 599739e..37637ff 100644
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
+		"%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x, hqid: %d",
+		 show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
+		 __entry->tag, __entry->doorbell, __entry->transfer_len, __entry->intr,
+		 __entry->lba, (u32)__entry->opcode, str_opcode(__entry->opcode),
+		 (u32)__entry->group_id, __entry->hwq_id
 	)
 );
 
-- 
2.7.4

