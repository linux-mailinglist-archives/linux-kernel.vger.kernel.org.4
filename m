Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99BD639FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiK1Cx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1Cx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:53:56 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D32539F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 18:53:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NL95n2mDvz4f3p17
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:53:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCXu9i+IoRjnd0cBQ--.33892S4;
        Mon, 28 Nov 2022 10:53:52 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     linux-cachefs@redhat.com
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, houtao1@huawei.com
Subject: [PATCH] fscache: Use wake_up_var() to wake up pending volume acquisition
Date:   Mon, 28 Nov 2022 11:19:29 +0800
Message-Id: <20221128031929.3918348-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXu9i+IoRjnd0cBQ--.33892S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45KrWftrWxXrWxury7trb_yoW5Xr1xp3
        9I9FWft3ykX342yw4rXw47Z34S9FykGFs7Cr4vkryUAF47Jr1ktF1Ika95uFW7C39rJrWa
        q3WYk345Ww4UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
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

Fixing it by using wake_up_var() instead of wake_up_bit(). In addition
because waitqueue_active() is used in wake_up_var() and clear_bit()
doesn't imply any memory barrier, so do smp_mb__after_atomic() before
invoking wake_up_var().

Fixes: 62ab63352350 ("fscache: Implement volume registration")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fscache/volume.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index ab8ceddf9efa..cf8293bb1aca 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -348,7 +348,12 @@ static void fscache_wake_pending_volume(struct fscache_volume *volume,
 		if (fscache_volume_same(cursor, volume)) {
 			fscache_see_volume(cursor, fscache_volume_see_hash_wake);
 			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
-			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
+			/*
+			 * Paired with barrier in wait_var_event(). Check
+			 * waitqueue_active() and wake_up_var() for details.
+			 */
+			smp_mb__after_atomic();
+			wake_up_var(&cursor->flags);
 			return;
 		}
 	}
-- 
2.29.2

