Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3C96F2737
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 02:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjD3AMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 20:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjD3AM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 20:12:28 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FAEE61
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 17:12:25 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-32b51da14a9so6278055ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 17:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682813545; x=1685405545;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5mtUzpWO+O1fpipFdagymHRTnrAYBITiup+HED65PQ=;
        b=AFY7g8GUmLv1R71XDECdC78G+2NqUNUJPlWz6zeMcjL7QAnz8O8SAT41qHjc+EjdEY
         MzK5JYC+OlQfP0cZwHJFhyZjFQWIn+SPTzQ/pZqEsw/EJmpKdE8HmJLu3AkfX0fsRV4V
         pIsbsPw8vLqqEpzK0Ro8TuhXXie7g+9xYZZZvtAceNVab4sCCNnbUBVr7Ph9UZ/9kyIZ
         Gtn7HmcULcBBZ8G4v//WC5VEpm7VQGgOzdlyPzUwvcQTXs+NinLmOMcmmu8tdMIJyQJA
         8Ar+EdYkU720t7+7ERwrL6aOsINl1XasicpCC9FbSteHfyxk0LqkoVCjAvaQRg9+EB9Q
         SBHQ==
X-Gm-Message-State: AC+VfDymh4M73hQD4ivRNLGGgFSfMKx3L4VNOE5LJCL+Ay+ZLSAtkRU/
        mZzd87Yrz0ZPkPvOHvu8sjlOzeeBgYi+KgVL58pm3y1KWFDW
X-Google-Smtp-Source: ACHHUZ6DQsqCS/NHWh7nutLrBg10H1LLlz70ODa2prv79x3/z/TFeG2P+qrYtkCS/BTH7/A0RaRych7eAYFv27CB5LEHhBBU7Vdd
MIME-Version: 1.0
X-Received: by 2002:a92:4b02:0:b0:328:49a0:76b8 with SMTP id
 m2-20020a924b02000000b0032849a076b8mr5083846ilg.0.1682813544840; Sat, 29 Apr
 2023 17:12:24 -0700 (PDT)
Date:   Sat, 29 Apr 2023 17:12:24 -0700
In-Reply-To: <20230429235443.2838-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009046e805fa828f56@google.com>
Subject: Re: [syzbot] [net?] WARNING in print_bfs_bug (2)
From:   syzbot <syzbot+630f83b42d801d922b8b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in print_bfs_bug

------------[ cut here ]------------
lockdep bfs error:-1
WARNING: CPU: 0 PID: 13238 at kernel/locking/lockdep.c:2077 print_bfs_bug+0x22/0x30 kernel/locking/lockdep.c:2077
Modules linked in:
CPU: 0 PID: 13238 Comm: syz-executor.0 Not tainted 6.3.0-syzkaller-07921-g042334a8d424-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:print_bfs_bug+0x22/0x30 kernel/locking/lockdep.c:2077
Code: 84 00 00 00 00 00 66 90 55 89 fd 53 e8 b7 34 a9 02 89 c3 e8 60 fd ff ff 85 db 74 10 89 ee 48 c7 c7 20 68 4c 8a e8 0e bb e7 ff <0f> 0b 5b 5d c3 66 0f 1f 84 00 00 00 00 00 53 31 c9 31 d2 31 f6 48
RSP: 0018:ffffc9000348efd8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888028e08000 RSI: ffffffff814bef47 RDI: 0000000000000001
RBP: 00000000ffffffff R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888028e08b40
R13: 0000000000000000 R14: ffffc9000348f100 R15: 0000000000000000
FS:  00007f198cdc8700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f198c1a8000 CR3: 000000004534e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 check_irq_usage+0x56c/0x1a40 kernel/locking/lockdep.c:2845
 check_prev_add kernel/locking/lockdep.c:3112 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain kernel/locking/lockdep.c:3842 [inline]
 __lock_acquire+0x2f39/0x5df0 kernel/locking/lockdep.c:5074
 lock_acquire kernel/locking/lockdep.c:5691 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 alloc_object lib/debugobjects.c:233 [inline]
 lookup_object_or_alloc.part.0+0x392/0xa30 lib/debugobjects.c:578
 lookup_object_or_alloc lib/debugobjects.c:558 [inline]
 debug_object_activate+0x1ca/0x3f0 lib/debugobjects.c:692
 debug_rcu_head_queue kernel/rcu/rcu.h:226 [inline]
 __call_rcu_common.constprop.0+0x2c/0x7e0 kernel/rcu/tree.c:2612
 dentry_free+0xc3/0x160 fs/dcache.c:377
 __dentry_kill+0x4cb/0x640 fs/dcache.c:621
 shrink_dentry_list+0x12c/0x4f0 fs/dcache.c:1201
 prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
 super_cache_scan+0x33a/0x590 fs/super.c:104
 do_shrink_slab+0x428/0xaa0 mm/vmscan.c:853
 shrink_slab_memcg mm/vmscan.c:922 [inline]
 shrink_slab+0x388/0x660 mm/vmscan.c:1001
 shrink_node_memcgs mm/vmscan.c:6439 [inline]
 shrink_node+0x7fb/0x35f0 mm/vmscan.c:6473
 shrink_zones mm/vmscan.c:6711 [inline]
 do_try_to_free_pages+0x3b4/0x17b0 mm/vmscan.c:6773
 try_to_free_mem_cgroup_pages+0x368/0x840 mm/vmscan.c:7088
 reclaim_high.constprop.0+0x182/0x230 mm/memcontrol.c:2403
 mem_cgroup_handle_over_high+0x190/0x520 mm/memcontrol.c:2588
 resume_user_mode_work include/linux/resume_user_mode.h:58 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x14c/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f198c08c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f198cdc8168 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
RAX: 0000000000000005 RBX: 00007f198c1abf80 RCX: 00007f198c08c169
RDX: 0000000000000010 RSI: 0000000000000003 RDI: 0000000000000010
RBP: 00007f198c0e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdb5d8bedf R14: 00007f198cdc8300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         042334a8 atlantic:hw_atl2:hw_atl2_utils_fw: Remove unn..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=130c556fc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7205cdba522fe4bc
dashboard link: https://syzkaller.appspot.com/bug?extid=630f83b42d801d922b8b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13398e2c280000

