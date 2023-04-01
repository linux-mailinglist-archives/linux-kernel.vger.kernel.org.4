Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7C6D34D0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 00:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjDAWT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 18:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDAWT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 18:19:27 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BCDFF0D;
        Sat,  1 Apr 2023 15:19:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vf6Rq6N_1680387561;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0Vf6Rq6N_1680387561)
          by smtp.aliyun-inc.com;
          Sun, 02 Apr 2023 06:19:22 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-stable@vger.kernel.org
Subject: [PATCH] mm/swap: fix swap_info_struct race between swapoff and get_swap_pages()
Date:   Sun,  2 Apr 2023 06:19:20 +0800
Message-Id: <20230401221920.57986-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this modification, a core will wait (mostly)
'swap_info_struct->lock' when completing
'del_from_avail_list(p)'. Immediately, other cores
soon calling 'add_to_avail_list()' to add the same
object again when acquiring the lock that released
by former. It's not the desired result but exists
indeed. This case can be described as below:

core 0                       core 1
swapoff

del_from_avail_list(p)       waiting

try lock p->lock             acquire swap_avail_lock and
                             add p into swap_avail_head again

acquire p->lock but
missing p already be
added again, and continuing
to clear SWP_WRITEOK, etc.

It can be easily found a massive warning messages can
be triggered inside get_swap_pages() by some special
cases, for example, we call madvise(MADV_PAGEOUT) on
blocks of touched memory concurrently, meanwhile, run
much swapon-swapoff operations (e.g. stress-ng-swap).

But, a worse consequence, panic also can be caused by
the above scene. In swapoff(), p, refers to one
swap_info_struct variable, maybe reinsert swap_avail_head
by 'reinsert_swap_info', or as we wanted, turns off this
swap block successfully. the worse case is that swapoff()
run the last code of function but the p still linked in
swap_avail_head[]. It has very bad effects, such as the
memory used by p could be kept in swap_info[], this means
reuse it will destroy the data. A panic message caused:

(with CONFIG_PLIST_DEBUG enabled)

------------[ cut here ]------------
top: ffff001800875c00, n: ffff001800fdc6e0, p: ffff001800fdc6e0
prev: ffff001800875c00, n: ffff001800fdc6e0, p: ffff001800fdc6e0
next: ffff001800fdc6e0, n: ffff001800fdc6e0, p: ffff001800fdc6e0
WARNING: CPU: 21 PID: 1843 at lib/plist.c:60 plist_check_prev_next_node+0x50/0x70
Modules linked in: rfkill(E) crct10dif_ce(E)...
CPU: 21 PID: 1843 Comm: stress-ng Kdump: ... 5.10.134+
Hardware name: Alibaba Cloud ECS, BIOS 0.0.0 02/06/2015
pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=--)
pc : plist_check_prev_next_node+0x50/0x70
lr : plist_check_prev_next_node+0x50/0x70
sp : ffff0018009d3c30
x29: ffff0018009d3c40 x28: ffff800011b32a98
x27: 0000000000000000 x26: ffff001803908000
x25: ffff8000128ea088 x24: ffff800011b32a48
x23: 0000000000000028 x22: ffff001800875c00
x21: ffff800010f9e520 x20: ffff001800875c00
x19: ffff001800fdc6e0 x18: 0000000000000030
x17: 0000000000000000 x16: 0000000000000000
x15: 0736076307640766 x14: 0730073007380731
x13: 0736076307640766 x12: 0730073007380731
x11: 000000000004058d x10: 0000000085a85b76
x9 : ffff8000101436e4 x8 : ffff800011c8ce08
x7 : 0000000000000000 x6 : 0000000000000001
x5 : ffff0017df9ed338 x4 : 0000000000000001
x3 : ffff8017ce62a000 x2 : ffff0017df9ed340
x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 plist_check_prev_next_node+0x50/0x70
 plist_check_head+0x80/0xf0
 plist_add+0x28/0x140
 add_to_avail_list+0x9c/0xf0
 _enable_swap_info+0x78/0xb4
 __do_sys_swapon+0x918/0xa10
 __arm64_sys_swapon+0x20/0x30
 el0_svc_common+0x8c/0x220
 do_el0_svc+0x2c/0x90
 el0_svc+0x1c/0x30
 el0_sync_handler+0xa8/0xb0
 el0_sync+0x148/0x180
irq event stamp: 2082270

In this patch, we lock p->lock before calling
'del_from_avail_list()' to make sure other thread
see the swap_info_struct object had been deleted
and SWP_WRITEOK cleared together, will not reinsert
again.

We also find this problem exists in stable 5.10.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 mm/swapfile.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5af6b0f770de..4df77fef50b5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2610,8 +2610,12 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		spin_unlock(&swap_lock);
 		goto out_dput;
 	}
-	del_from_avail_list(p);
+	/*
+	 * Here lock is used to protect deleting and SWP_WRITEOK clearing
+	 * can be seen concurrently.
+	 */
 	spin_lock(&p->lock);
+	del_from_avail_list(p);
 	if (p->prio < 0) {
 		struct swap_info_struct *si = p;
 		int nid;
-- 
2.27.0

