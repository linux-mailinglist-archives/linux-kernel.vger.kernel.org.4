Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140A2619076
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiKDFuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiKDFsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E86B28E00;
        Thu,  3 Nov 2022 22:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EBBF620D9;
        Fri,  4 Nov 2022 05:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B239C433C1;
        Fri,  4 Nov 2022 05:48:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oqpZs-0071Bq-22;
        Fri, 04 Nov 2022 01:49:16 -0400
Message-ID: <20221104054916.464295277@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 04 Nov 2022 01:41:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [RFC][PATCH v3 25/33] timers: scsi: Use timer_shutdown_sync() and timer_shutdown() before
 freeing timer
References: <20221104054053.431922658@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Before a timer is freed, timer_shutdown_sync() must be called, or
timer_shutdown() if it's already known that the timer is disabled.

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc: Nilesh Javali <njavali@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/scsi/qla2xxx/qla_edif.c | 4 ++--
 drivers/scsi/scsi_lib.c         | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index 00ccc41cef14..7f3a3c8673b5 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -416,7 +416,7 @@ static void __qla2x00_release_all_sadb(struct scsi_qla_host *vha,
 				 */
 				if (edif_entry->delete_sa_index !=
 						INVALID_EDIF_SA_INDEX) {
-					del_timer(&edif_entry->timer);
+					timer_shutdown_sync(&edif_entry->timer);
 
 					/* build and send the aen */
 					fcport->edif.rx_sa_set = 1;
@@ -2799,7 +2799,7 @@ qla28xx_sa_update_iocb_entry(scsi_qla_host_t *v, struct req_que *req,
 			    "%s: removing edif_entry %p, new sa_index: 0x%x\n",
 			    __func__, edif_entry, pkt->sa_index);
 			qla_edif_list_delete_sa_index(sp->fcport, edif_entry);
-			del_timer(&edif_entry->timer);
+			timer_shutdown_sync(&edif_entry->timer);
 
 			ql_dbg(ql_dbg_edif, vha, 0x5033,
 			    "%s: releasing edif_entry %p, new sa_index: 0x%x\n",
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 8b89fab7c420..e6cd1efb9eca 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -558,6 +558,7 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 	 */
 	destroy_rcu_head(&cmd->rcu);
 
+	timer_shutdown(&cmd->abort_work.timer);
 	/*
 	 * In the MQ case the command gets freed by __blk_mq_end_request,
 	 * so we have to do all cleanup that depends on it earlier.
-- 
2.35.1
