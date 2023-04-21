Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF51E6EB0CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjDURmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjDURmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:42:09 -0400
Received: from out-18.mta1.migadu.com (out-18.mta1.migadu.com [95.215.58.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DE615A35
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:41:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682098890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8lsVSCZFASjGj882L2SUq8X57TGcITsPyPXAfEkTLgs=;
        b=PFr/EZaro7ssLUyyiZMxEP8YjsXfPwxeIaTBtv49tB58yI+pA+FCiq9xPo1wG91VUqogAG
        FyfKBvQ9Z2R68a2BgzhattI724YLKBAbj5PronSuPVAPPPW8Z0PtgStuMgWLu5uwlluwGl
        HlqkPYGxLE4udEvViO3aTzpvtlubx/U=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] mm: kmem: fix a NULL pointer dereference in obj_stock_flush_required()
Date:   Fri, 21 Apr 2023 10:40:54 -0700
Message-Id: <20230421174054.3434533-1-roman.gushchin@linux.dev>
In-Reply-To: <00000000000058b63f05f9d98811@google.com>
References: <00000000000058b63f05f9d98811@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCSAN found an issue in obj_stock_flush_required():
stock->cached_objcg can be reset between the check and dereference:

==================================================================
BUG: KCSAN: data-race in drain_all_stock / drain_obj_stock

write to 0xffff888237c2a2f8 of 8 bytes by task 19625 on cpu 0:
 drain_obj_stock+0x408/0x4e0 mm/memcontrol.c:3306
 refill_obj_stock+0x9c/0x1e0 mm/memcontrol.c:3340
 obj_cgroup_uncharge+0xe/0x10 mm/memcontrol.c:3408
 memcg_slab_free_hook mm/slab.h:587 [inline]
 __cache_free mm/slab.c:3373 [inline]
 __do_kmem_cache_free mm/slab.c:3577 [inline]
 kmem_cache_free+0x105/0x280 mm/slab.c:3602
 __d_free fs/dcache.c:298 [inline]
 dentry_free fs/dcache.c:375 [inline]
 __dentry_kill+0x422/0x4a0 fs/dcache.c:621
 dentry_kill+0x8d/0x1e0
 dput+0x118/0x1f0 fs/dcache.c:913
 __fput+0x3bf/0x570 fs/file_table.c:329
 ____fput+0x15/0x20 fs/file_table.c:349
 task_work_run+0x123/0x160 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xcf/0xe0 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888237c2a2f8 of 8 bytes by task 19632 on cpu 1:
 obj_stock_flush_required mm/memcontrol.c:3319 [inline]
 drain_all_stock+0x174/0x2a0 mm/memcontrol.c:2361
 try_charge_memcg+0x6d0/0xd10 mm/memcontrol.c:2703
 try_charge mm/memcontrol.c:2837 [inline]
 mem_cgroup_charge_skmem+0x51/0x140 mm/memcontrol.c:7290
 sock_reserve_memory+0xb1/0x390 net/core/sock.c:1025
 sk_setsockopt+0x800/0x1e70 net/core/sock.c:1525
 udp_lib_setsockopt+0x99/0x6c0 net/ipv4/udp.c:2692
 udp_setsockopt+0x73/0xa0 net/ipv4/udp.c:2817
 sock_common_setsockopt+0x61/0x70 net/core/sock.c:3668
 __sys_setsockopt+0x1c3/0x230 net/socket.c:2271
 __do_sys_setsockopt net/socket.c:2282 [inline]
 __se_sys_setsockopt net/socket.c:2279 [inline]
 __x64_sys_setsockopt+0x66/0x80 net/socket.c:2279
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0xffff8881382d52c0 -> 0xffff888138893740

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 19632 Comm: syz-executor.0 Not tainted 6.3.0-rc2-syzkaller-00387-g534293368afa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023

Fix it by reading the cached_objcg with READ_ONCE().

Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Reported-by: syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/linux-mm/CACT4Y+ZfucZhM60YPphWiCLJr6+SGFhT+jjm8k1P-a_8Kkxsjg@mail.gmail.com/T/#t
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..9426a1ddc190 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3314,10 +3314,11 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg)
 {
+	struct obj_cgroup *objcg = READ_ONCE(stock->cached_objcg);
 	struct mem_cgroup *memcg;
 
-	if (stock->cached_objcg) {
-		memcg = obj_cgroup_memcg(stock->cached_objcg);
+	if (objcg) {
+		memcg = obj_cgroup_memcg(objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
 	}
-- 
2.40.0

