Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CC272F867
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbjFNIwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243819AbjFNIwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:52:40 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489CB2940;
        Wed, 14 Jun 2023 01:52:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qgzh02r9hz4f3w0K;
        Wed, 14 Jun 2023 16:52:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbG7f4lks7u0Lg--.65484S6;
        Wed, 14 Jun 2023 16:52:14 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 2/3] md/raid10: get rdev/replacemenet from r10bio for normal write
Date:   Wed, 14 Jun 2023 16:47:39 +0800
Message-Id: <20230614084740.1493969-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614084740.1493969-1-linan666@huaweicloud.com>
References: <20230614084740.1493969-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbG7f4lks7u0Lg--.65484S6
X-Coremail-Antispam: 1UD129KBjvJXoWxKr48uFyrAF17Kr18uF17ZFb_yoWDXryUp3
        98KaySyrWUJ34DWF4DtayUWF9YvanxtrWfCr1fW34fWa4YvrW7Ja10gry5Zrs8uFWfua4U
        XFn8JrWDW3WDJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU89L05UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

After commit 4ca40c2ce099 ("md/raid10: Allow replacement device to be
replace old drive.") mirrors->replacement can replace rdev during repl_io
pending. Replacement which write io issued to may have already become rdev
when io completes, in this case, there are the following issues if we get
rdev/replacement from mirror.
  1. When replacement becomes rdev, target device of io is mirror->rdev,
     but bio is still r10bio->repl_bio. Changing 'repl' to 0 in
     raid10_end_write_request() will cause repl_bio to be put but not
     set to IO_MADE_GOOD, UAF will occur. The stack is shown at the end
     of patch.
  2. After replacement replaces rdev, a new replacement is added. The
     replacement when issued io and the replacement when io ended are not
     the same, which can lead to some bugs, such as bad blocks set,
     nr_pending accounting, md_error rdev, and so on.

In the previous patch, we recorded rdev/replacement in r10bio, directly
getting target device of io from r10bio to fix these bugs.

  ==================================================================
  BUG: KASAN: use-after-free in bio_flagged include/linux/bio.h:238 [inline]
  BUG: KASAN: use-after-free in bio_put+0x78/0x80 block/bio.c:650
  Read of size 2 at addr ffff888116524dd4 by task md0_raid10/2618

  CPU: 0 PID: 2618 Comm: md0_raid10 Not tainted 5.10.0+ #3
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
  sd 0:0:0:0: rejecting I/O to offline device
  Call Trace:
   __dump_stack lib/dump_stack.c:77 [inline]
   dump_stack+0x107/0x167 lib/dump_stack.c:118
   print_address_description.constprop.0+0x1c/0x270 mm/kasan/report.c:390
   __kasan_report mm/kasan/report.c:550 [inline]
   kasan_report.cold+0x22/0x3a mm/kasan/report.c:567
   bio_flagged include/linux/bio.h:238 [inline]
   bio_put+0x78/0x80 block/bio.c:650
   put_all_bios drivers/md/raid10.c:248 [inline]
   free_r10bio drivers/md/raid10.c:257 [inline]
   raid_end_bio_io+0x3b5/0x590 drivers/md/raid10.c:309
   handle_write_completed drivers/md/raid10.c:2699 [inline]
   raid10d+0x2f85/0x5af0 drivers/md/raid10.c:2759
   md_thread+0x444/0x4b0 drivers/md/md.c:7932
   kthread+0x38c/0x470 kernel/kthread.c:313
   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:299

  Allocated by task 1400:
   kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
   kasan_set_track mm/kasan/common.c:56 [inline]
   set_alloc_info mm/kasan/common.c:498 [inline]
   __kasan_kmalloc.constprop.0+0xb5/0xe0 mm/kasan/common.c:530
   slab_post_alloc_hook mm/slab.h:512 [inline]
   slab_alloc_node mm/slub.c:2923 [inline]
   slab_alloc mm/slub.c:2931 [inline]
   kmem_cache_alloc+0x144/0x360 mm/slub.c:2936
   mempool_alloc+0x146/0x360 mm/mempool.c:391
   bio_alloc_bioset+0x375/0x610 block/bio.c:486
   bio_clone_fast+0x20/0x50 block/bio.c:711
   raid10_write_one_disk+0x166/0xd30 drivers/md/raid10.c:1240
   raid10_write_request+0x1600/0x2c90 drivers/md/raid10.c:1484
   __make_request drivers/md/raid10.c:1508 [inline]
   raid10_make_request+0x376/0x620 drivers/md/raid10.c:1537
   md_handle_request+0x699/0x970 drivers/md/md.c:451
   md_submit_bio+0x204/0x400 drivers/md/md.c:489
   __submit_bio block/blk-core.c:959 [inline]
   __submit_bio_noacct block/blk-core.c:1007 [inline]
   submit_bio_noacct+0x2e3/0xcf0 block/blk-core.c:1086
   submit_bio+0x1a0/0x3a0 block/blk-core.c:1146
   submit_bh_wbc+0x685/0x8e0 fs/buffer.c:3053
   ext4_commit_super+0x37e/0x6c0 fs/ext4/super.c:5696
   flush_stashed_error_work+0x28b/0x400 fs/ext4/super.c:791
   process_one_work+0x9a6/0x1590 kernel/workqueue.c:2280
   worker_thread+0x61d/0x1310 kernel/workqueue.c:2426
   kthread+0x38c/0x470 kernel/kthread.c:313
   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:299

  Freed by task 2618:
   kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
   kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
   kasan_set_free_info+0x20/0x40 mm/kasan/generic.c:361
   __kasan_slab_free+0x151/0x180 mm/kasan/common.c:482
   slab_free_hook mm/slub.c:1569 [inline]
   slab_free_freelist_hook+0xa9/0x180 mm/slub.c:1608
   slab_free mm/slub.c:3179 [inline]
   kmem_cache_free+0xcd/0x3d0 mm/slub.c:3196
   mempool_free+0xe3/0x3b0 mm/mempool.c:500
   bio_free+0xe2/0x140 block/bio.c:266
   bio_put+0x58/0x80 block/bio.c:651
   raid10_end_write_request+0x885/0xb60 drivers/md/raid10.c:516
   bio_endio+0x376/0x6a0 block/bio.c:1465
   req_bio_endio block/blk-core.c:289 [inline]
   blk_update_request+0x5f5/0xf40 block/blk-core.c:1525
   blk_mq_end_request+0x4c/0x510 block/blk-mq.c:654
   blk_flush_complete_seq+0x835/0xd80 block/blk-flush.c:204
   flush_end_io+0x7b7/0xb90 block/blk-flush.c:261
   __blk_mq_end_request+0x282/0x4c0 block/blk-mq.c:645
   scsi_end_request+0x3a8/0x850 drivers/scsi/scsi_lib.c:607
   scsi_io_completion+0x3f5/0x1320 drivers/scsi/scsi_lib.c:970
   scsi_softirq_done+0x11b/0x490 drivers/scsi/scsi_lib.c:1448
   blk_mq_complete_request block/blk-mq.c:788 [inline]
   blk_mq_complete_request+0x84/0xb0 block/blk-mq.c:785
   scsi_mq_done+0x155/0x360 drivers/scsi/scsi_lib.c:1603
   virtscsi_vq_done drivers/scsi/virtio_scsi.c:184 [inline]
   virtscsi_req_done+0x14c/0x220 drivers/scsi/virtio_scsi.c:199
   vring_interrupt drivers/virtio/virtio_ring.c:2061 [inline]
   vring_interrupt+0x27a/0x300 drivers/virtio/virtio_ring.c:2047
   __handle_irq_event_percpu+0x2f8/0x830 kernel/irq/handle.c:156
   handle_irq_event_percpu kernel/irq/handle.c:196 [inline]
   handle_irq_event+0x105/0x280 kernel/irq/handle.c:213
   handle_edge_irq+0x258/0xd20 kernel/irq/chip.c:828
   asm_call_irq_on_stack+0xf/0x20
   __run_irq_on_irqstack arch/x86/include/asm/irq_stack.h:48 [inline]
   run_irq_on_irqstack_cond arch/x86/include/asm/irq_stack.h:101 [inline]
   handle_irq arch/x86/kernel/irq.c:230 [inline]
   __common_interrupt arch/x86/kernel/irq.c:249 [inline]
   common_interrupt+0xe2/0x190 arch/x86/kernel/irq.c:239
   asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:626

Fixes: 4ca40c2ce099 ("md/raid10: Allow replacement device to be replace old drive.")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 4fcfcb350d2b..56206cbd169d 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -468,17 +468,15 @@ static void raid10_end_write_request(struct bio *bio)
 	dev = find_bio_disk(conf, r10_bio, bio, &slot, &repl);
 
 	if (repl)
-		rdev = conf->mirrors[dev].replacement;
-	if (!rdev) {
-		smp_rmb();
-		repl = 0;
-		rdev = conf->mirrors[dev].rdev;
-	}
+		rdev = r10_bio->devs[slot].replacement;
+	else
+		rdev = r10_bio->devs[slot].rdev;
 	/*
 	 * this branch is our 'one mirror IO has finished' event handler:
 	 */
 	if (bio->bi_status && !discard_error) {
-		if (repl)
+		/* replacement may have replaced rdev */
+		if (repl && rdev == conf->mirrors[dev].replacement)
 			/* Never record new bad blocks to replacement,
 			 * just fail it.
 			 */
@@ -504,7 +502,10 @@ static void raid10_end_write_request(struct bio *bio)
 			else {
 				/* Fail the request */
 				set_bit(R10BIO_Degraded, &r10_bio->state);
-				r10_bio->devs[slot].bio = NULL;
+				if (repl)
+					r10_bio->devs[slot].repl_bio = NULL;
+				else
+					r10_bio->devs[slot].bio = NULL;
 				to_put = bio;
 				dec_rdev = 1;
 			}
@@ -1289,15 +1290,10 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	int devnum = r10_bio->devs[n_copy].devnum;
 	struct bio *mbio;
 
-	if (replacement) {
-		rdev = conf->mirrors[devnum].replacement;
-		if (rdev == NULL) {
-			/* Replacement just got moved to main 'rdev' */
-			smp_mb();
-			rdev = conf->mirrors[devnum].rdev;
-		}
-	} else
-		rdev = conf->mirrors[devnum].rdev;
+	if (replacement)
+		rdev = r10_bio->devs[n_copy].replacement;
+	else
+		rdev = r10_bio->devs[n_copy].rdev;
 
 	mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO, &mddev->bio_set);
 	if (replacement)
@@ -1309,8 +1305,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 				   choose_data_offset(r10_bio, rdev));
 	mbio->bi_end_io	= raid10_end_write_request;
 	mbio->bi_opf = op | do_sync | do_fua;
-	if (!replacement && test_bit(FailFast,
-				     &conf->mirrors[devnum].rdev->flags)
+	if (!replacement && test_bit(FailFast, &rdev->flags)
 			 && enough(conf, devnum))
 		mbio->bi_opf |= MD_FAILFAST;
 	mbio->bi_private = r10_bio;
@@ -1530,10 +1525,12 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		}
 		if (rdev) {
 			r10_bio->devs[i].bio = bio;
+			r10_bio->devs[i].rdev = rdev;
 			atomic_inc(&rdev->nr_pending);
 		}
 		if (rrdev) {
 			r10_bio->devs[i].repl_bio = bio;
+			r10_bio->devs[i].replacement = rrdev;
 			atomic_inc(&rrdev->nr_pending);
 		}
 	}
@@ -3051,9 +3048,8 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 	} else {
 		bool fail = false;
 		for (m = 0; m < conf->copies; m++) {
-			int dev = r10_bio->devs[m].devnum;
 			struct bio *bio = r10_bio->devs[m].bio;
-			rdev = conf->mirrors[dev].rdev;
+			rdev = r10_bio->devs[m].rdev;
 			if (bio == IO_MADE_GOOD) {
 				rdev_clear_badblocks(
 					rdev,
@@ -3070,7 +3066,7 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			bio = r10_bio->devs[m].repl_bio;
-			rdev = conf->mirrors[dev].replacement;
+			rdev = r10_bio->devs[m].replacement;
 			if (rdev && bio == IO_MADE_GOOD) {
 				rdev_clear_badblocks(
 					rdev,
-- 
2.39.2

