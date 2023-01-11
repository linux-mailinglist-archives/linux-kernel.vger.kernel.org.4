Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3E0665A76
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbjAKLk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjAKLjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FBA19C06;
        Wed, 11 Jan 2023 03:38:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7D9C74741;
        Wed, 11 Jan 2023 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673437128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UwPyPIetNY3DBB0fSVp3q4vAm/+Fo0XhsHWOsHHGIUI=;
        b=YY0V/kE2OIgigKX91FgSqFdKg1MvTPPtnW+FU7rFyf9gBrBmitP+fmgRZrVbi0waj6TG2e
        6nD/o5PaB+ipjykGZ5pK7x0m6Qo+Dgo6IkCwZZWSmTTttvikXVb0/U9c2kpM1vUNb35L+M
        lYUiuOhw6CqV+dLakwbaOyPia6GL0Nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673437128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UwPyPIetNY3DBB0fSVp3q4vAm/+Fo0XhsHWOsHHGIUI=;
        b=J2Cr3bxyA6vSXDDHYjJWLmQKMnj36Cssv1mwlSS9oTAr/yA1bznUNLMdhW49WszAmc0kBh
        aRL/p95Lm84tWwAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 761A52C141;
        Wed, 11 Jan 2023 11:38:48 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 6AC7E51B7ABB; Wed, 11 Jan 2023 12:38:48 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] lpfc: Handle gracefully failed FLOGI attempts in devloss callback
Date:   Wed, 11 Jan 2023 12:38:41 +0100
Message-Id: <20230111113841.108588-1-dwagner@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When FLOGI attempts fail, the vport can be released via
lpfc_nlp_release() function. This function will set the pointer to NULL
and the node state to NLP_STE_FREED_NODE. Though it wont stop the
devloss timer in the upper SCSI layer.

Hence when the devloss timer eventually fires,
lpfc_dev_loss_tmo_callbk() is called and it tries to operate on vport
NULL pointer.

Just do nothing in this case. To be extra cautions also check for the
state and issue a warning if we have an inconsistency.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
changes:
v2:
  - this time with code (/me fights with evil-mode)

v1:
  - initial version


lpfc 0000:65:00.1: 94: [20252.520693] 7:0357 ELS CQE error: status=x3: CQE: 116b0300 00000000 31420002 90010000
lpfc 0000:65:00.1: 95: [20252.520707] 7:0321 Rsp Ring 2 error: IOCB Data: x116b0300 x0 x31420002 x90010000
lpfc 0000:65:00.1: 7:(0):2858 FLOGI failure Status:x3/x31420002 TMO:x14 Data x11140820 x0
 rport-18:0-1: blocked FC remote port time out: removing rport
**** lpfc_rport_invalid: Null vport on ndlp xffff88828bd82e00, DID xfffffe rport xffff8884f936e000 SID xffffffff
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 14 PID: 86204 Comm: kworker/14:0 Tainted: G           OE  X    5.14.21-150400.24.18-default #1 SLE15-SP4 695ab7a8fc20f5ddb345280570966cd1eb06d469
Hardware name: XXXX
Workqueue: fc_wq_18 fc_rport_final_delete [scsi_transport_fc]
RIP: e030:lpfc_dev_loss_tmo_callbk+0x50/0x4d0 [lpfc]
Code: 00 00 00 0f b7 8b ac 00 00 00 48 c7 c2 e0 d1 c6 c0 44 8b 83 98 00 00 00 44 8b 8b 94 00 00 00 48 89 fd be 80 00 00 00 4c 89 e7 <4d> 8b 2c 24 e8 37 9e 04 00 4c 8b 83 f8 00 00 00 41 8b 90 e0 02 00
RSP: e02b:ffffc9004d853e38 EFLAGS: 00010286
RAX: ffff8884f936e510 RBX: ffff88828bd82e00 RCX: 000000000000ffff
RDX: ffffffffc0c6d1e0 RSI: 0000000000000080 RDI: 0000000000000000
RBP: ffff8884f936e000 R08: 0000000000fffffe R09: 0000000000000000
R10: ffffc900401fbd98 R11: ffffc9004d853c80 R12: 0000000000000000
R13: ffff8884f936e000 R14: ffff88810b705000 R15: ffff888126973080
FS:  0000000000000000(0000) GS:ffff88888e980000(0000) knlGS:0000000000000000
CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000103f50000 CR4: 0000000000050660
Call Trace:
 <TASK>
 fc_rport_final_delete+0xec/0x1c0 [scsi_transport_fc e9142b03c2f4a15da538eb15a15c5b37fc11a87f]
 process_one_work+0x264/0x440
 ? process_one_work+0x440/0x440
 worker_thread+0x2d/0x3d0
 ? process_one_work+0x440/0x440
 kthread+0x154/0x180
 ? set_kthread_struct+0x50/0x50
 ret_from_fork+0x1f/0x30
 </TASK>



 drivers/scsi/lpfc/lpfc_hbadisc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 83d2b29ee2a6..e7dd5f90d6c4 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -160,6 +160,19 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 	if (!ndlp)
 		return;
 
+	if (!ndlp->vport) {
+		/*
+		 * dev loss timer from the scsi layer might time out after
+		 * failed FLOGI attempts. In this case the node will alreay be
+		 * freed via lpfc_nlp_release(), which frees the vport pointer
+		 * and sets the state to NLP_STE_FREED_NODE.
+		 */
+		WARN_ONCE(ndlp->nlp_state != NLP_STE_FREED_NODE,
+			  "**** %s, vport NULL but ntp_state is not in freed state",
+			  __func__);
+		return;
+	}
+
 	vport = ndlp->vport;
 	phba  = vport->phba;
 
-- 
2.35.3

