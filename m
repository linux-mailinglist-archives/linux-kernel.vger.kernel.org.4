Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8856568D1BF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjBGIur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjBGIup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:50:45 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDD82118;
        Tue,  7 Feb 2023 00:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675759824; bh=B7+XU58Vdy+7zysi7rf3Yltj56drELfwj3YGbEd4EzQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=ByCcUdcB0g86LJV5uQjJbWOUPk8xfhyvcegs2S+Zd6/MNP2InuD3LmfV4SnIfa7jc
         y2XX9rtYI/Rl1IlzExNVr1a8QdAHQrr/mEfhHliXAFrVMSz2iZg21ystOs4vbOW2n5
         DL247+MbGEqVVvEgjxGuprOw/c3dpl81Cs0vfxwU=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  7 Feb 2023 09:50:24 +0100 (CET)
X-EA-Auth: 4FHT8v+T0Ze566ABFYclIUMLeLA86AQNEXPEEoDAVwbtmxvtBYvcm6cfyNLQcFu6cet4LfUTqZZYead07NF/FRrtCMIS4R6p
Date:   Tue, 7 Feb 2023 14:19:36 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dc395x@twibble.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: dc395x: Replace arithmetic addition by bitwise OR
Message-ID: <Y+IQoG3aYdTfMStu@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding two bit-field mask values, an OR operation offers higher
performance over an arithmetic operation.
Also, while at it, resolve the checkpatch incorrectly split line
warning.
Issue identified using orplus.cocci semantic patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/dc395x.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 670a836a6ba1..e2adf8e84277 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -760,8 +760,7 @@ static void waiting_process_next(struct AdapterCtlBlk *acb)
 	struct ScsiReqBlk *srb;
 	struct list_head *dcb_list_head = &acb->dcb_list;
 
-	if (acb->active_dcb
-	    || (acb->acb_flag & (RESET_DETECT + RESET_DONE + RESET_DEV)))
+	if (acb->active_dcb || (acb->acb_flag & (RESET_DETECT | RESET_DONE | RESET_DEV)))
 		return;
 
 	if (timer_pending(&acb->waiting_timer))
@@ -844,7 +843,7 @@ static void send_srb(struct AdapterCtlBlk *acb, struct ScsiReqBlk *srb)
 
 	if (dcb->max_command <= list_size(&dcb->srb_going_list) ||
 	    acb->active_dcb ||
-	    (acb->acb_flag & (RESET_DETECT + RESET_DONE + RESET_DEV))) {
+	    (acb->acb_flag & (RESET_DETECT | RESET_DONE | RESET_DEV))) {
 		list_add_tail(&srb->list, &dcb->srb_waiting_list);
 		waiting_process_next(acb);
 		return;
@@ -1125,7 +1124,7 @@ static void reset_dev_param(struct AdapterCtlBlk *acb)
 	list_for_each_entry(dcb, &acb->dcb_list, list) {
 		u8 period_index;
 
-		dcb->sync_mode &= ~(SYNC_NEGO_DONE + WIDE_NEGO_DONE);
+		dcb->sync_mode &= ~(SYNC_NEGO_DONE | WIDE_NEGO_DONE);
 		dcb->sync_period = 0;
 		dcb->sync_offset = 0;
 
@@ -1683,7 +1682,7 @@ static void msgout_phase0(struct AdapterCtlBlk *acb, struct ScsiReqBlk *srb,
 		u16 *pscsi_status)
 {
 	dprintkdbg(DBG_0, "msgout_phase0: (0x%p)\n", srb->cmd);
-	if (srb->state & (SRB_UNEXPECT_RESEL + SRB_ABORT_SENT))
+	if (srb->state & (SRB_UNEXPECT_RESEL | SRB_ABORT_SENT))
 		*pscsi_status = PH_BUS_FREE;	/*.. initial phase */
 
 	DC395x_write16(acb, TRM_S1040_SCSI_CONTROL, DO_DATALATCH);	/* it's important for atn stop */
@@ -2899,7 +2898,7 @@ static void disconnect(struct AdapterCtlBlk *acb)
 		doing_srb_done(acb, DID_ABORT, srb->cmd, 1);
 		waiting_process_next(acb);
 	} else {
-		if ((srb->state & (SRB_START_ + SRB_MSGOUT))
+		if ((srb->state & (SRB_START_ | SRB_MSGOUT))
 		    || !(srb->
 			 state & (SRB_DISCONNECT | SRB_COMPLETED))) {
 			/*
-- 
2.34.1



