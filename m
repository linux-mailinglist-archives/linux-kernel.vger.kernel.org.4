Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A162B5FC712
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJLOOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJLOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:14:41 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34080B07
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:14:36 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id a8-20020a92c548000000b002f6440ff96bso13641655ilj.22
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrmGZuurtH4qr3acd7W728yjI//st1S/10KutRp1D0o=;
        b=sfV/d1JydUrSbq9Naa7Mp4z57MDm4gj/CS0rxnQhk1ot/LN4S7cu2nYD8HgWMuPPU4
         ZS0uLmGMihUlMSEU0xkQw+1V1Qx8LzYgJhEtE7wIwD1oKLGln4Rn2oG+abhE0h/j6qhG
         VsDK6lEqciy547s7nirUkBjw04GVGHIq10JtARglR+Ecr3FCXrrbaxUYlssGJlyXyvn7
         yjK0QFF3H2tfSqBD7mkg2zgF5pOpVJUnkzjaLgNKfJjJn2ofamjT84EZ7u/hsnY4DDPz
         gB7Dg7eJfoaX4HgC6FI7IWXChEprbuRKOSuwY3X7wX+tNSrdDsD7NyjfCl/h0EqyIz+8
         YW+g==
X-Gm-Message-State: ACrzQf1WF4NlNna4UHNb6txjeFs+tmyVCndcmzXOQUkHrgTg+RjB5Emi
        MbxgfCUlBXFi/xI22C/nDEvyVceDOjk2Wu52jnnHtgboy65Y
X-Google-Smtp-Source: AMsMyM63GTtH6fEccQOD10auS037N/H6pJ1lcjZYE6axmliVCDneNDdBFDEGK2CKPDZ4zk3pmcxLXaSiSLY/FZgYMV9l+dHLQrLZ
MIME-Version: 1.0
X-Received: by 2002:a92:c74d:0:b0:2f8:dcf1:2797 with SMTP id
 y13-20020a92c74d000000b002f8dcf12797mr14502501ilp.199.1665584075604; Wed, 12
 Oct 2022 07:14:35 -0700 (PDT)
Date:   Wed, 12 Oct 2022 07:14:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b89b205ead703ff@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in kernfs_walk_and_get_ns
From:   syzbot <syzbot+9baaae5fc5795e2e6acf@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    282342f2dc97 Add linux-next specific files for 20220830
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14b47c63080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7b70bd555c649f4
dashboard link: https://syzkaller.appspot.com/bug?extid=9baaae5fc5795e2e6acf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12acb375080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1718658b080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9baaae5fc5795e2e6acf@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1498
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 3603, name: syz-executor323
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffff814710e0>] copy_process+0x20f0/0x7120 kernel/fork.c:2199
softirqs last  enabled at (0): [<ffffffff81471128>] copy_process+0x2138/0x7120 kernel/fork.c:2203
softirqs last disabled at (0): [<0000000000000000>] 0x0
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 3603 Comm: syz-executor323 Not tainted 6.0.0-rc3-next-20220830-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9896
 down_read+0x71/0x450 kernel/locking/rwsem.c:1498
 kernfs_walk_and_get_ns+0xcc/0x3a0 fs/kernfs/dir.c:897
 kernfs_walk_and_get include/linux/kernfs.h:600 [inline]
 cgroup_get_from_path+0x61/0x610 kernel/cgroup/cgroup.c:6647
 cgroup_mt_check_v1+0x19a/0x2f0 net/netfilter/xt_cgroup.c:56
 xt_check_match+0x275/0x9f0 net/netfilter/x_tables.c:523
 check_match net/ipv6/netfilter/ip6_tables.c:490 [inline]
 find_check_match net/ipv6/netfilter/ip6_tables.c:507 [inline]
 find_check_entry.constprop.0+0x342/0x9e0 net/ipv6/netfilter/ip6_tables.c:558
 translate_table+0xc8b/0x1750 net/ipv6/netfilter/ip6_tables.c:735
 do_replace net/ipv6/netfilter/ip6_tables.c:1153 [inline]
 do_ip6t_set_ctl+0x56e/0xb90 net/ipv6/netfilter/ip6_tables.c:1639
 nf_setsockopt+0x83/0xe0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x127/0x190 net/ipv6/ipv6_sockglue.c:1026
 udpv6_setsockopt+0x76/0xc0 net/ipv6/udp.c:1652
 __sys_setsockopt+0x2d6/0x690 net/socket.c:2252
 __do_sys_setsockopt net/socket.c:2263 [inline]
 __se_sys_setsockopt net/socket.c:2260 [inline]
 __x64_sys_setsockopt+0xba/0x150 net/socket.c:2260
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbfdc6eeb09
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffed2b8f58 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbfdc6eeb09
RDX: 0000000000000040 RSI: 0000000000000029 RDI: 0000000000000003
RBP: 00007fbfdc6b2cb0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000020000300 R11: 0000000000000246 R12: 00007fbfdc6b2d40
R13: 000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
