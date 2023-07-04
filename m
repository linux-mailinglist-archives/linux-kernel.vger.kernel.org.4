Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EDB746FCE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGDLWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjGDLWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:22:38 -0400
X-Greylist: delayed 95 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 04:22:35 PDT
Received: from ssh249.corpemail.net (ssh249.corpemail.net [210.51.61.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3728E52;
        Tue,  4 Jul 2023 04:22:35 -0700 (PDT)
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id AKU00022;
        Tue, 04 Jul 2023 19:15:22 +0800
Received: from lihongweizz00.home.langchao.com (10.180.207.169) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2507.27; Tue, 4 Jul 2023 19:15:23 +0800
From:   lihongweizz <lihongweizz@inspur.com>
To:     <lduncan@suse.com>, <cleech@redhat.com>,
        <michael.christie@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rock Li <lihongweizz@inspur.com>
Subject: [PATCH] scsi: iscsi: fix stop connection cocurrency issue
Date:   Tue, 4 Jul 2023 19:15:21 +0800
Message-ID: <20230704111521.580-1-lihongweizz@inspur.com>
X-Mailer: git-send-email 2.40.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.180.207.169]
tUid:   202370419152203b1c0b4d45a67b0f0900ca94abe91e9
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rock Li <lihongweizz@inspur.com>

We met a crash issue when iscsi connection was not stable:
[ 5581.778976]  connection929:0: detected conn error (1020)
[ 5592.539182] scsi host17: iSCSI Initiator over TCP/IP
[ 5592.548847]  connection930:0: detected conn error (1020)
[ 5592.548890] BUG: unable to handle kernel NULL pointer dereference at 0000000000000020
[ 5592.548935] PGD 0
[ 5592.548947] Oops: 0000 [#1] SNP NOPTI
[ 5592.548966] CPU: 51 PID: 912890 Comm: kworker/u161:2 Kdump: loaded Tainted: G OE - xxxxxx #1
[ 5592.549022] Hardware name: xxxxxx
[ 5592.549053] Workqueue: iscsi_conn_cleanup scsi_cleanup_conn_work_fn[scsi_transport_iscsi]
[ 5592.549098] RIP: 0010:iscsi_sw_tcp_release_conn+0x54/0x110[iscsi_tcp]
[ 5592.549130] Code: fb be 02 00 00 00 48 89 0f e8 88 65 8b c9 48 8b 45 20 f0 ff 80 80 00 00 00 0f 88 e3 06 00 00 48 8b 43 08 4c 8b 70 08 49 8b 06 <48> 8b 58 20 4c 8d bb 30 02 00 00 4c 89 ff e8 49 75 as c9 4c 89 ff
[ 5592.549209] RSP: 0018:ff6937f4283e7e00 EFLAGS: 00010202
[ 5592.549233] RAX: 0000000000000000 RBX: ff347b03a4a4b478 RCX: 0000000000000000
[ 5592.549265] RDX: 0000000000000000 RSI: 00000000fffffe0l RDI: ffffffff8a2bc977
[ 5592.549296] RBP: ff347b063d49d600 R08: ff347b20bffeb878 R09: 00000000000003e8
[ 5592.549327] R10: 0000000000000000 R11: ff347b20bffe9b44 R12: ff347b03a4a4b7a8
[ 5592.549358] R13: ff347b03a4a4e610 R14: ff347b03a4a4b7a8 R15: ff347b03a4a4b068
[ 5592.549389] FS: 0000000000000000(0000) Gs:ff347b20bffc0000(0000) knlGs:0000000000000000
[ 5592.549424] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5592.549446] CR2: 0000000000000020 CR3: 0000003a22610005 CR4: 0000000000773ee0
[ 5592.549469] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5592.549491] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 5592.549510] PKRU: 55555554
[ 5592.549518] Call Trace:
[ 5592.549528]  iscsi_sw_tcp_conn_stop+0x5d/0x80 [iscsi_tcp]
[ 5592.549546]  iscsi_stop_conn+0x66/0xc0 [scsi_transport_iscsi]
[ 5592.549568]  iscsi_cleanup_conn_workin+0x6e/0xbe [scsi_transport_iscsi]

After digging the vmcore file, a concurrency scenario was found:
<netlink recv msg>          <sk_state_change triggered>    <kworker>
iscsi_if_rx                 iscsi_sw_tcp_state_change
  iscsi_if_recv_msg           iscsi_sw_sk_state_check
    iscsi_if_stop_conn          iscsi_conn_failure
      cancel_work_sync(            iscsi_conn_error_event
        &conn->cleanup_work)
                                     queue_work(
                                       &conn->cleanup_work)
      iscsi_stop_conn        <- Excute cocurrenty -->      iscsi_stop_conn

iscsi_stop_conn will be excuted cocurrently in different paths.
Fix this issue by leveraging ep_mutex to protect iscsi_stop_conn.

Signed-off-by: Rock Li <lihongweizz@inspur.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index b9b97300e3b3..1da1083509b6 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2307,7 +2307,16 @@ static int iscsi_if_stop_conn(struct iscsi_cls_conn *conn, int flag)
 	 */
 	if (flag == STOP_CONN_TERM) {
 		cancel_work_sync(&conn->cleanup_work);
+
+		/* There is a race window between cancel clean_work and
+		 * connection stopped. Socket down event may queue clean up
+		 * work again before connection stopped which will result
+		 * stop connection cocurrency issue. Avoid this issue
+		 * by leveraging ep_mutex
+		 */
+		mutex_lock(&conn->ep_mutex);
 		iscsi_stop_conn(conn, flag);
+		mutex_unlock(&conn->ep_mutex);
 	} else {
 		/*
 		 * Figure out if it was the kernel or userspace initiating this.
-- 
2.27.0

