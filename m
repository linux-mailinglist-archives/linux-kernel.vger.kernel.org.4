Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021B46561E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 11:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiLZKdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 05:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLZKdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 05:33:23 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34CF6160
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 02:33:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NgYyz6skQz4f3l1t
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:33:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rFreKlj6SMxAg--.54373S5;
        Mon, 26 Dec 2022 18:33:18 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     linux-cachefs@redhat.com
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>, houtao1@huawei.com
Subject: [PATCH v2 1/2] fscache: Use wait_on_bit() to wait for the freeing of relinquished volume
Date:   Mon, 26 Dec 2022 18:33:08 +0800
Message-Id: <20221226103309.953112-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221226103309.953112-1-houtao@huaweicloud.com>
References: <20221226103309.953112-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rFreKlj6SMxAg--.54373S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45KrWftrWxXrWxury7trb_yoW5KFWkp3
        9I9343trW8X3sFyw4kJw47Z34SgFykJan7CrWvkry7Aa1rtF15tF10k3s8uay7A3yDJrW2
        va1jq3sIgw1UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUzl1vUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

The freeing of relinquished volume will wake up the pending volume
acquisition by using wake_up_bit(), however it is mismatched with
wait_var_event() used in fscache_wait_on_volume_collision() and it will
never wake up the waiter in the wait-queue because these two functions
operate on different wait-queues.

According to the implementation in fscache_wait_on_volume_collision(),
if the wake-up of pending acquisition is delayed longer than 20 seconds
(e.g., due to the delay of on-demand fd closing), the first
wait_var_event_timeout() will timeout and the following wait_var_event()
will hang forever as shown below:

 FS-Cache: Potential volume collision new=00000024 old=00000022
 ......
 INFO: task mount:1148 blocked for more than 122 seconds.
       Not tainted 6.1.0-rc6+ #1
 task:mount           state:D stack:0     pid:1148  ppid:1
 Call Trace:
  <TASK>
  __schedule+0x2f6/0xb80
  schedule+0x67/0xe0
  fscache_wait_on_volume_collision.cold+0x80/0x82
  __fscache_acquire_volume+0x40d/0x4e0
  erofs_fscache_register_volume+0x51/0xe0 [erofs]
  erofs_fscache_register_fs+0x19c/0x240 [erofs]
  erofs_fc_fill_super+0x746/0xaf0 [erofs]
  vfs_get_super+0x7d/0x100
  get_tree_nodev+0x16/0x20
  erofs_fc_get_tree+0x20/0x30 [erofs]
  vfs_get_tree+0x24/0xb0
  path_mount+0x2fa/0xa90
  do_mount+0x7c/0xa0
  __x64_sys_mount+0x8b/0xe0
  do_syscall_64+0x30/0x60
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Considering that wake_up_bit() is more selective, so fixing it by using
wait_on_bit() instead of wait_var_event() to wait for the freeing of
relinquished volume. In addition because waitqueue_active() is used in
wake_up_bit() and clear_bit() doesn't imply any memory barrier, so also
adding smp_mb__after_atomic() before wake_up_bit().

Fixes: 62ab63352350 ("fscache: Implement volume registration")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fscache/volume.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index ab8ceddf9efa..fc3dd3bc851d 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -141,13 +141,14 @@ static bool fscache_is_acquire_pending(struct fscache_volume *volume)
 static void fscache_wait_on_volume_collision(struct fscache_volume *candidate,
 					     unsigned int collidee_debug_id)
 {
-	wait_var_event_timeout(&candidate->flags,
-			       !fscache_is_acquire_pending(candidate), 20 * HZ);
+	wait_on_bit_timeout(&candidate->flags, FSCACHE_VOLUME_ACQUIRE_PENDING,
+			    TASK_UNINTERRUPTIBLE, 20 * HZ);
 	if (fscache_is_acquire_pending(candidate)) {
 		pr_notice("Potential volume collision new=%08x old=%08x",
 			  candidate->debug_id, collidee_debug_id);
 		fscache_stat(&fscache_n_volumes_collision);
-		wait_var_event(&candidate->flags, !fscache_is_acquire_pending(candidate));
+		wait_on_bit(&candidate->flags, FSCACHE_VOLUME_ACQUIRE_PENDING,
+			    TASK_UNINTERRUPTIBLE);
 	}
 }
 
@@ -348,6 +349,11 @@ static void fscache_wake_pending_volume(struct fscache_volume *volume,
 		if (fscache_volume_same(cursor, volume)) {
 			fscache_see_volume(cursor, fscache_volume_see_hash_wake);
 			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
+			/*
+			 * Paired with barrier in wait_on_bit(). Check
+			 * wake_up_bit() and waitqueue_active() for details.
+			 */
+			smp_mb__after_atomic();
 			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
 			return;
 		}
-- 
2.29.2

