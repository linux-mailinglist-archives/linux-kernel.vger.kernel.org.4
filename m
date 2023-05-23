Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778B270E514
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbjEWTEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjEWTEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:04:14 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A72791;
        Tue, 23 May 2023 12:04:11 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-ba80dc46972so79018276.2;
        Tue, 23 May 2023 12:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684868651; x=1687460651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4W28a48SDMi1QUsmpPavFVHSFTXlIc71K5bxCuD8AU=;
        b=ZRJ/zAT62lvPAsJ7OfmHx5mI+/0OAeVa0HDys5AOeWMY47xppArpln+pBLFrDOBw4z
         U6PoPXN1NmiwiQwpTszlr8XAnfL4bGQA8SC7bDJ8GVzpkOa/DwbU1gFuClX9P1wokDX/
         F+pFUSnId7mVTo1E41O3q9BdiiVZy7qrcg0fm+dzxUcxtWGXlyiRGRE6vUOt6I2S8gPe
         d4Hz7NlMdu4BNGcaQh1KubUgaUXyh6ufU7Q7mzmLWVJGd7g0bLmkW0T65gE2Ca44Ij/p
         MVry52F6FmUG926OLTHZ1vX++8fut6NZc4FgG/0k6cm5Ac0QHU/nr0h1s+aEADCwAyKv
         iFjw==
X-Gm-Message-State: AC+VfDxL9/Qc8IxHogF99/FxVq7zq0bIf1gCrZZcc78h2nJZXPgc88vd
        jF3PCO68q214fQA/8NVz/j1ZEJ8tuZY=
X-Google-Smtp-Source: ACHHUZ7q4JW7+x8k8wobTkNcopVEP1XKn8W2OeuB9TqTyMXF1cqswqQ6280FVBRRuKDNccBJcJmtng==
X-Received: by 2002:a25:4d8:0:b0:bac:7294:4fb6 with SMTP id 207-20020a2504d8000000b00bac72944fb6mr2254036ybe.30.1684868650601;
        Tue, 23 May 2023 12:04:10 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id x3-20020a2584c3000000b00ba88763e5b5sm2226962ybm.2.2023.05.23.12.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:04:10 -0700 (PDT)
From:   Sungwoo Kim <iam@sung-woo.kim>
Cc:     wuruoyu@me.com, benquike@gmail.com, daveti@purdue.edu,
        Sungwoo Kim <iam@sung-woo.kim>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix use-after-free in bt_accept_unlink
Date:   Tue, 23 May 2023 15:03:48 -0400
Message-Id: <20230523190347.2584368-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

==================================================================
BUG: KASAN: use-after-free in bt_accept_unlink+0x77/0x1f0 net/bluetooth/af_bluetooth.c:189
Write of size 8 at addr ffff888104d59300 by task kworker/0:3/128

CPU: 0 PID: 128 Comm: kworker/0:3 Not tainted 6.2.0-00001-gef397bd4d5fb-dirty #58
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events l2cap_chan_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x72/0x95 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x175/0x478 mm/kasan/report.c:417
 kasan_report+0xb1/0x130 mm/kasan/report.c:517
 __list_del include/linux/list.h:114 [inline]
 __list_del_entry include/linux/list.h:137 [inline]
 list_del_init include/linux/list.h:206 [inline]
 bt_accept_unlink+0x77/0x1f0 net/bluetooth/af_bluetooth.c:189
 l2cap_sock_teardown_cb+0x1c6/0x4c0 net/bluetooth/l2cap_sock.c:1586
 l2cap_chan_del+0x108/0x5e0 net/bluetooth/l2cap_core.c:651
 l2cap_chan_close+0x159/0x830 net/bluetooth/l2cap_core.c:859
 l2cap_chan_timeout+0x14f/0x240 net/bluetooth/l2cap_core.c:452
 process_one_work+0x4ea/0x8e0 kernel/workqueue.c:2289
 worker_thread+0x364/0x8e0 kernel/workqueue.c:2436
 kthread+0x1b9/0x200 kernel/kthread.c:376
 ret_from_fork+0x2c/0x50 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 285:
 kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x82/0x90 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:968 [inline]
 __kmalloc+0x5a/0x140 mm/slab_common.c:981
 kmalloc include/linux/slab.h:584 [inline]
 sk_prot_alloc+0x113/0x1f0 net/core/sock.c:2040
 sk_alloc+0x36/0x3c0 net/core/sock.c:2093
 l2cap_sock_alloc.constprop.0+0x39/0x1c0 net/bluetooth/l2cap_sock.c:1851
 l2cap_sock_create+0x10d/0x220 net/bluetooth/l2cap_sock.c:1897
 bt_sock_create+0x183/0x290 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x226/0x380 net/socket.c:1518
 sock_create net/socket.c:1569 [inline]
 __sys_socket_create net/socket.c:1606 [inline]
 __sys_socket_create net/socket.c:1591 [inline]
 __sys_socket+0x112/0x200 net/socket.c:1639
 __do_sys_socket net/socket.c:1652 [inline]
 __se_sys_socket net/socket.c:1650 [inline]
 __x64_sys_socket+0x40/0x50 net/socket.c:1650
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3f/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

Freed by task 285:
 kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x50 mm/kasan/generic.c:523
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free mm/kasan/common.c:200 [inline]
 __kasan_slab_free+0x10a/0x190 mm/kasan/common.c:244
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0x88/0x1f0 mm/slub.c:3800
 sk_prot_free net/core/sock.c:2076 [inline]
 __sk_destruct+0x347/0x430 net/core/sock.c:2168
 sk_destruct+0x9c/0xb0 net/core/sock.c:2183
 __sk_free+0x82/0x220 net/core/sock.c:2194
 sk_free+0x7c/0xa0 net/core/sock.c:2205
 sock_put include/net/sock.h:1991 [inline]
 l2cap_sock_kill+0x256/0x2b0 net/bluetooth/l2cap_sock.c:1257
 l2cap_sock_release+0x169/0x1c0 net/bluetooth/l2cap_sock.c:1427
 __sock_release+0x80/0x150 net/socket.c:650
 sock_close+0x19/0x30 net/socket.c:1368
 __fput+0x17a/0x5c0 fs/file_table.c:320
 task_work_run+0x132/0x1c0 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x113/0x120 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x21/0x50 kernel/entry/common.c:296
 do_syscall_64+0x4c/0x90 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

Last potentially related work creation:
 kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x97/0xb0 mm/kasan/generic.c:493
 insert_work+0x33/0x180 kernel/workqueue.c:1358
 __queue_work+0x410/0x960 kernel/workqueue.c:1517
 rcu_work_rcufn+0x2e/0x40 kernel/workqueue.c:1754
 rcu_do_batch kernel/rcu/tree.c:2246 [inline]
 rcu_core+0x43b/0xe70 kernel/rcu/tree.c:2506
 __do_softirq+0x124/0x3f9 kernel/softirq.c:571

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x97/0xb0 mm/kasan/generic.c:493
 __call_rcu_common.constprop.0+0x41/0x550 kernel/rcu/tree.c:2755
 call_rcu_hurry include/linux/rcupdate.h:116 [inline]
 queue_rcu_work+0x79/0x90 kernel/workqueue.c:1774
 process_one_work+0x4ea/0x8e0 kernel/workqueue.c:2289
 worker_thread+0x364/0x8e0 kernel/workqueue.c:2436
 kthread+0x1b9/0x200 kernel/kthread.c:376
 ret_from_fork+0x2c/0x50 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff888104d59000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 768 bytes inside of
 1024-byte region [ffff888104d59000, ffff888104d59400)

The buggy address belongs to the physical page:
page:0000000067fcb39f refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x104d58
head:0000000067fcb39f order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
anon flags: 0x200000000010200(slab|head|node=0|zone=2)
raw: 0200000000010200 ffff888100041dc0 ffffea00041fa600 dead000000000003
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888104d59200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888104d59280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888104d59300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888104d59380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888104d59400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

l2cap_chan_timeout() tries to write on (struck sock*)chan->data that
points to already free'd address by l2cap_sock_release().
This patch prevents this by clearing the timers in l2cap_sock_release()
as l2cap_sock_cleanup_listen() does.

Ack: This bug is found by FuzzBT with a modified Syzkaller. Other
contributors are Ruoyu Wu and Hui Peng.
Fixes: 1bff51ea59a9 (Bluetooth: fix use-after-free error in
lock_sock_nested())
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/l2cap_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index eebe25610..cb274ee1c 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1423,6 +1423,7 @@ static int l2cap_sock_release(struct socket *sock)
 	l2cap_chan_hold(chan);
 	l2cap_chan_lock(chan);
 
+	__clear_chan_timer(chan);
 	sock_orphan(sk);
 	l2cap_sock_kill(sk);
 
-- 
2.34.1

