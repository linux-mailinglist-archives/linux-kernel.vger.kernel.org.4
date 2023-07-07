Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F2D74ADBD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjGGJYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGGJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:24:32 -0400
Received: from out-49.mta0.migadu.com (out-49.mta0.migadu.com [IPv6:2001:41d0:1004:224b::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785D31FED
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 02:24:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688721869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BWQjQK1KZqpkZnvRZ3gH1lF/rXG15m9KUMnDnbTYq94=;
        b=DFnfVNgGMU08x/2kSWK/hg2UpGh+7t+WKegT+KkkdjS40ELGM5Uj0ego8bjMVcoaTonu9w
        dlHjioxh/SEiBClGsh/DpwDrvDuOV9hfo7EzCms7e6ELyeEccYJ9f4XvWNlNEvt0Ur+vYa
        QpFWFYRGA80+7hW8RGtexlrxuHrKIgE=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [bug report] concurrent blk_mq_complete_request() when blktests nvme/040
Date:   Fri,  7 Jul 2023 17:24:00 +0800
Message-ID: <20230707092400.1336803-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Hello,

I encounter below problems when do blktests nvme/040 on a qemu vm,
there are two kinds of bug traces, but the cause should be the same.

CPU0					CPU1
nvme_cancel_tagset()
  blk_mq_tagset_busy_iter()
    bt_tags_iter()
      rq = blk_mq_find_and_get_req()

      // ref = 1 + 1 = 2
      nvme_cancel_request()
        // rq->state == MQ_RQ_IN_FLIGHT
        blk_mq_complete_request(rq)
          blk_mq_free_request(rq)
            req_ref_put_and_test()
            // ref = 2 - 1 = 1

      blk_mq_put_rq_ref()
        // ref = 0
        __blk_mq_free_request()
					blk_mq_complete_request_remote(rq)
					  rq->mq_hctx->nr_ctx
					  // rq->mq_hctx == 0
					  // nr_ctx offset is 0x136

I change the rq->state setting in blk_mq_complete_request_remote() to
use cmpxchg() to make sure one request complete only once. Then run
blktests nvme/040 for a long time, no problem happened again.

But I'm not familiar with these nvme driver code, maybe this is a bug
in the nvme driver code that nvme_cancel_tagset() should forbid
inflight request from concurrent completing ?

Bug1:
=====
 BUG: kernel NULL pointer dereference, address: 0000000000000136
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 13 PID: 95 Comm: ksoftirqd/13 Tainted: G            E      6.4.0-rc7-next-20230623+ #134
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
 RIP: 0010:blk_mq_complete_request_remote+0x1c/0x140
 Code: 88 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 0f 1f 44 00 00 55 53 48 8b 47 10 48 89 fb c7 87 94 00 00 00 02 00 00 00 <66> 83 b8 36 01 00 00 01 0f 84 bc 00 00 00 f6 43 1a 40 74 05 31 c0
 RSP: 0018:ffffad1a403abd88 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff999d891b2d00 RCX: 0000000000000000
 RDX: 000000000000006b RSI: 000000000000000c RDI: ffff999d891b2d00
 RBP: ffff999d89a4ce78 R08: 000000000000000a R09: 000000000000005f
 R10: ffffffffbc0060c0 R11: 0000000000000000 R12: ffff999d89a4ce70
 R13: ffff999d891b2e78 R14: 0000000000001000 R15: 0000000000001000
 FS:  0000000000000000(0000) GS:ffff99a0afd40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000136 CR3: 0000000108528002 CR4: 0000000000370ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __die+0x23/0x70
  ? page_fault_oops+0x159/0x440
  ? check_preempt_wakeup+0x13a/0x2c0
  ? exc_page_fault+0x77/0x170
  ? asm_exc_page_fault+0x26/0x30
  ? blk_mq_complete_request_remote+0x1c/0x140
  ? psi_group_change+0x168/0x400
  nvme_loop_queue_response+0xe6/0x1a0
  __nvmet_req_complete+0x55/0x200
  nvmet_req_complete+0x16/0x50
  nvmet_bio_done+0x2b/0x50
  blk_update_request+0x15c/0x4c0
  ? __schedule+0x3d4/0x1440
  ? sbitmap_queue_clear+0x3b/0x60
  blk_mq_end_request+0x1e/0xd0
  blk_complete_reqs+0x3a/0x50
  __do_softirq+0xcf/0x2b6
  ? sort_range+0x20/0x20
  run_ksoftirqd+0x28/0x40
  smpboot_thread_fn+0xcb/0x1b0
  kthread+0xe5/0x120
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

Bug2:
=====
 WARNING: CPU: 1 PID: 158 at block/blk.h:505 blk_mq_put_rq_ref+0x51/0x60
 Modules linked in: loop(E) edac_core(E) intel_rapl_msr(E) intel_rapl_common(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) sha512_ssse3(E) sha512_generic(E) sr_mod(E) psmouse(E) cdrom(E) aesni_intel(E) ata_generic(E) nd_pmem(E) crypto_simd(E) cryptd(E) nd_btt(E) dax_pmem(E) evdev(E) serio_raw(E) pcspkr(E) floppy(E) ata_piix(E) nfit(E) libata(E) libnvdimm(E) virtio_blk(E) i2c_piix4(E) button(E)
 CPU: 1 PID: 158 Comm: kworker/u32:3 Tainted: G            E      6.4.0+ #137
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
 Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work
 RIP: 0010:blk_mq_put_rq_ref+0x51/0x60
 Code: c3 8b 83 98 00 00 00 83 c0 7f 83 f8 7f 76 1b f0 ff 8b 98 00 00 00 75 e7 48 89 df 5b e9 48 d4 ff ff 48 89 df 5b e9 2f d5 ff ff <0f> 0b eb e1 66 66 2e 0f 1f 84 00 00 00 00 00 66 0f 1f 00 0f 1f 44
 RSP: 0018:ffffbd0a00593d88 EFLAGS: 00010246
 RAX: 000000000000007f RBX: ffff9990ca066800 RCX: 0000000000000001
 RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff9990ca066800
 RBP: ffff9990ca066800 R08: 0000000000004f53 R09: 00000000003d0900
 R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
 R13: 0000000000000010 R14: ffffbd0a00593df0 R15: 0000000000000005
 FS:  0000000000000000(0000) GS:ffff9993efa40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055bb72eaed08 CR3: 000000010a2ce001 CR4: 0000000000370ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? blk_mq_put_rq_ref+0x51/0x60
  ? __warn+0x81/0x130
  ? blk_mq_put_rq_ref+0x51/0x60
  ? report_bug+0x16d/0x1a0
  ? handle_bug+0x41/0x70
  ? exc_invalid_op+0x17/0x60
  ? asm_exc_invalid_op+0x1a/0x20
  ? blk_mq_put_rq_ref+0x51/0x60
  ? blk_mq_put_rq_ref+0x12/0x60
  bt_tags_iter+0x79/0xb0
  blk_mq_tagset_busy_iter+0x1b5/0x330
  ? nvme_try_sched_reset+0x40/0x40
  ? nvme_try_sched_reset+0x40/0x40
  nvme_cancel_tagset+0x25/0x40
  nvme_loop_shutdown_ctrl+0x2a/0x90
  nvme_loop_reset_ctrl_work+0x2e/0x120
  process_one_work+0x1dc/0x3d0
  worker_thread+0x1af/0x380
  ? rescuer_thread+0x3b0/0x3b0
  kthread+0xe5/0x120
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5504719b970d..a83aed2bc964 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1169,7 +1169,8 @@ static void blk_mq_raise_softirq(struct request *rq)
 
 bool blk_mq_complete_request_remote(struct request *rq)
 {
-	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+	if (cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) != MQ_RQ_IN_FLIGHT)
+		return true;
 
 	/*
 	 * For request which hctx has only one ctx mapping,
-- 
2.41.0

