Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307D3651ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiLTGdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiLTGdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:33:00 -0500
Received: from smtp.cecloud.com (unknown [106.39.185.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D295D615C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:32:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp.cecloud.com (Postfix) with ESMTP id 8ED8417E0207;
        Tue, 20 Dec 2022 14:32:51 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.48.58.13])
        by smtp.cecloud.com (postfix) whith ESMTP id P2473742T281457142133104S1671517970621458_;
        Tue, 20 Dec 2022 14:32:51 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3cad95c469ae8f2eea65a6d463006468>
X-RL-SENDER: zhangyanjun@cestc.cn
X-SENDER: zhangyanjun@cestc.cn
X-LOGIN-NAME: zhangyanjun@cestc.cn
X-FST-TO: sagi@grimberg.me
X-RCPT-COUNT: 9
X-SENDER-IP: 111.48.58.13
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   zhangyanjun@cestc.cn
To:     sagi@grimberg.me, axboe@kernel.dk, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Yanjun Zhang <zhangyanjun@cestc.cn>
Subject: [PATCH v2] nvme: fix multipath crash caused by flush request when blktrace is enabled
Date:   Tue, 20 Dec 2022 14:32:33 +0800
Message-Id: <20221220063233.43932-1-zhangyanjun@cestc.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanjun Zhang <zhangyanjun@cestc.cn>

The flush request initialized by blk_kick_flush has NULL bio,
and it may be dealt with nvme_end_req during io completion.
When blktrace is enabled, nvme_trace_bio_complete with multipath
activated trying to access NULL pointer bio from flush request
results in the following crash:

[ 2517.831677] BUG: kernel NULL pointer dereference, address: 000000000000001a
[ 2517.835213] #PF: supervisor read access in kernel mode
[ 2517.838724] #PF: error_code(0x0000) - not-present page
[ 2517.842222] PGD 7b2d51067 P4D 0
[ 2517.845684] Oops: 0000 [#1] SMP NOPTI
[ 2517.849125] CPU: 2 PID: 732 Comm: kworker/2:1H Kdump: loaded Tainted: G S                5.15.67-0.el9.x86_64 #1
[ 2517.852723] Hardware name: XFUSION 2288H V6/BC13MBSBC, BIOS 1.13 07/27/2022
[ 2517.856358] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
[ 2517.859993] RIP: 0010:blk_add_trace_bio_complete+0x6/0x30
[ 2517.863628] Code: 1f 44 00 00 48 8b 46 08 31 c9 ba 04 00 10 00 48 8b 80 50 03 00 00 48 8b 78 50 e9 e5 fe ff ff 0f 1f 44 00 00 41 54 49 89 f4 55 <0f> b6 7a 1a 48 89 d5 e8 3e 1c 2b 00 48 89 ee 4c 89 e7 5d 89 c1 ba
[ 2517.871269] RSP: 0018:ff7f6a008d9dbcd0 EFLAGS: 00010286
[ 2517.875081] RAX: ff3d5b4be00b1d50 RBX: 0000000002040002 RCX: ff3d5b0a270f2000
[ 2517.878966] RDX: 0000000000000000 RSI: ff3d5b0b021fb9f8 RDI: 0000000000000000
[ 2517.882849] RBP: ff3d5b0b96a6fa00 R08: 0000000000000001 R09: 0000000000000000
[ 2517.886718] R10: 000000000000000c R11: 000000000000000c R12: ff3d5b0b021fb9f8
[ 2517.890575] R13: 0000000002000000 R14: ff3d5b0b021fb1b0 R15: 0000000000000018
[ 2517.894434] FS:  0000000000000000(0000) GS:ff3d5b42bfc80000(0000) knlGS:0000000000000000
[ 2517.898299] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2517.902157] CR2: 000000000000001a CR3: 00000004f023e005 CR4: 0000000000771ee0
[ 2517.906053] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2517.909930] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2517.913761] PKRU: 55555554
[ 2517.917558] Call Trace:
[ 2517.921294]  <TASK>
[ 2517.924982]  nvme_complete_rq+0x1c3/0x1e0 [nvme_core]
[ 2517.928715]  nvme_tcp_recv_pdu+0x4d7/0x540 [nvme_tcp]
[ 2517.932442]  nvme_tcp_recv_skb+0x4f/0x240 [nvme_tcp]
[ 2517.936137]  ? nvme_tcp_recv_pdu+0x540/0x540 [nvme_tcp]
[ 2517.939830]  tcp_read_sock+0x9c/0x260
[ 2517.943486]  nvme_tcp_try_recv+0x65/0xa0 [nvme_tcp]
[ 2517.947173]  nvme_tcp_io_work+0x64/0x90 [nvme_tcp]
[ 2517.950834]  process_one_work+0x1e8/0x390
[ 2517.954473]  worker_thread+0x53/0x3c0
[ 2517.958069]  ? process_one_work+0x390/0x390
[ 2517.961655]  kthread+0x10c/0x130
[ 2517.965211]  ? set_kthread_struct+0x40/0x40
[ 2517.968760]  ret_from_fork+0x1f/0x30
[ 2517.972285]  </TASK>

To avoid this situation, add one more check with is_flush_rq before
calling trace_block_bio_complete.

Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
---
 block/blk-flush.c        | 1 +
 drivers/nvme/host/nvme.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53202eff5..4504321ed 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -276,6 +276,7 @@ bool is_flush_rq(struct request *rq)
 {
 	return rq->end_io == flush_end_io;
 }
+EXPORT_SYMBOL(is_flush_rq);
 
 /**
  * blk_kick_flush - consider issuing flush request
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a29877217..1f1bd375f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -884,11 +884,12 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
 
+extern bool is_flush_rq(struct request *rq);
 static inline void nvme_trace_bio_complete(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 
-	if (req->cmd_flags & REQ_NVME_MPATH)
+	if (req->cmd_flags & REQ_NVME_MPATH && !is_flush_rq(req))
 		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }
 
-- 
2.31.1



