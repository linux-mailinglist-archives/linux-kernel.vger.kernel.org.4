Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261D96F276D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 05:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjD3DLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 23:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjD3DLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 23:11:23 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EDE1704
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 20:11:21 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-763997ab8cdso191219739f.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 20:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682824281; x=1685416281;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYwT1YUxS4Sf+gsskbByexgEIydtjr4K90s9JkWJh+I=;
        b=jWKI3t0QetVol1d1uvczu7KZqx6p2zCgAP0+X1iNIfBNSj/Az2Wlan6SEQrYztOi/u
         xhTYEaCk0psIcjrZZ5yY4InYnWM+ZoCp0wvgXIpy7ETepl6kCpuuBD9h71cx7v3CD/5E
         oashNAjemDdYJBmVOfvO0a+QI3QEqxMuq74mfDQ7QEmOe3SvSF/b/K7ebSk3Fyj43F/2
         EFt037nkxnaHU8y2X+XigwPgsJHQR+JlUBC+VWFnuUqld4lvRAN72vWFdOgRbc9MVS7t
         CC86tbuJOt8NQiI6VlteLqaTSSoiBm+6iFD+lZkkZRJJwLzJHp1BhYEi9xQ4KsidBwu0
         ZVMA==
X-Gm-Message-State: AC+VfDzLl0ch9b8E3PBBNI4NFOVhyGvBVrumjv4Hg1o/aOsNDCS91YXb
        r0q4HHe8J35SbxoBux2sdsZADJyLBfkYTMkn8HpjG/WopCsH
X-Google-Smtp-Source: ACHHUZ6uaj6u4uzb7/wlxM84J9hn+1hT2YhMwPE1NQtPcyf1Qw0572O45s23wDSdSLG6CT5MS4jO3GycFIboxPI7034FtdQXQX6j
MIME-Version: 1.0
X-Received: by 2002:a02:9388:0:b0:40f:77a4:7e17 with SMTP id
 z8-20020a029388000000b0040f77a47e17mr4165279jah.0.1682824280858; Sat, 29 Apr
 2023 20:11:20 -0700 (PDT)
Date:   Sat, 29 Apr 2023 20:11:20 -0700
In-Reply-To: <20230430022358.3082-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007aeb4505fa850faf@google.com>
Subject: Re: [syzbot] [net?] WARNING in print_bfs_bug (2)
From:   syzbot <syzbot+630f83b42d801d922b8b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
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
WARNING: CPU: 1 PID: 13240 at kernel/locking/lockdep.c:2077 print_bfs_bug+0x22/0x30 kernel/locking/lockdep.c:2077
Modules linked in:
CPU: 1 PID: 13240 Comm: syz-executor.0 Not tainted 6.3.0-syzkaller-07921-g042334a8d424-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:print_bfs_bug+0x22/0x30 kernel/locking/lockdep.c:2077
Code: 84 00 00 00 00 00 66 90 55 89 fd 53 e8 b7 34 a9 02 89 c3 e8 60 fd ff ff 85 db 74 10 89 ee 48 c7 c7 20 68 4c 8a e8 0e bb e7 ff <0f> 0b 5b 5d c3 66 0f 1f 84 00 00 00 00 00 53 31 c9 31 d2 31 f6 48
RSP: 0018:ffffc900036cefb8 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888069b48000 RSI: ffffffff814bef47 RDI: 0000000000000001
RBP: 00000000ffffffff R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888069b48b40
R13: 0000000000000000 R14: ffffc900036cf0e0 R15: 0000000000000000
FS:  00007f007ee4d700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f007e1a8000 CR3: 000000004af80000 CR4: 00000000003506e0
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
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 alloc_object lib/debugobjects.c:234 [inline]
 lookup_object_or_alloc.part.0+0x392/0xa40 lib/debugobjects.c:579
 lookup_object_or_alloc lib/debugobjects.c:559 [inline]
 debug_object_activate+0x1ca/0x3f0 lib/debugobjects.c:693
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
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 exc_page_fault+0xc0/0x170 arch/x86/mm/fault.c:1557
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f007e03e171
Code: 3d 00 f0 ff ff 77 72 c3 90 55 48 83 ec 30 44 89 4c 24 2c 4c 89 44 24 20 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 89 4c 24 28 <e8> fa fa ff ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28
RSP: 002b:00007f007ee4c000 EFLAGS: 00010206
RAX: 0000000000000001 RBX: 00007f007ee4c0f0 RCX: 0000000000000000
RDX: 0000000000000020 RSI: 00007f007ee4c140 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f007ee4c054 R09: 000000000000000c
R10: 0000000000000000 R11: 00000000200003cf R12: 00007f007ee4c0a8
R13: 00007f007ee4c140 R14: 0000000000000003 R15: 0000000000000000
 </TASK>


Tested on:

commit:         042334a8 atlantic:hw_atl2:hw_atl2_utils_fw: Remove unn..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=117d6ffc280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7205cdba522fe4bc
dashboard link: https://syzkaller.appspot.com/bug?extid=630f83b42d801d922b8b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10b3bf0c280000

