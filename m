Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BD260DBA8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJZG7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiJZG7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:59:44 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B76A1C108
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:59:43 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id w6-20020a6bd606000000b006bcd951c261so9708957ioa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgA8wVXtaAqvqN1Bpn2B16FsEHYpcRrh8pBk9jEsgBM=;
        b=KTG5+vCTAuumEJQ4v33DHbck17cHFkDHJvyOGCdOofLBrlxH7D38Ty2DTCQh7yJZya
         DBLKxMJvwpvfhq9WoPdeYX29OcC3T18xkTXZKC/VgWxeFPFxgT11StiI7XNQbLIexn8R
         Mk/IJO7ZsNWW4/+i2e28qe9Ic46EE/hOuBgaf3rYvazHImp8EVsQHWcSCLPs7PsFusfw
         SH3fxWT8IfirSOzjVJdYjJj3E20uBy96AzIlqgudRjejsjtcrVacGLDhqfaR//jsHdy3
         FbWU+/yfaJ19Y3bw6nmdN4mVjmlwZvefR/eVTlRSJwfO7CnDW3pXRM5RMhhSyVKTpqVT
         /tqQ==
X-Gm-Message-State: ACrzQf0ZrG9V6q3WFtX/LB4ucXu2aVsKIXDsht17e95xlh9eyaJm4LNK
        u6yb3oUWSn84fq4MI94J6OUb+xr6pD04jQI0nBHgJNFWMTQ2
X-Google-Smtp-Source: AMsMyM5dbmcqAPxlAnr9t449nYUmo/KShV4jDUGOxT8aCHAwnQt4YD3/RrH7rgudQ65SsPAP3nnNxkLWFSoM2V5Hmm5h+mBCA5ey
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1545:b0:2ff:6ab3:dab1 with SMTP id
 j5-20020a056e02154500b002ff6ab3dab1mr15880137ilu.285.1666767582274; Tue, 25
 Oct 2022 23:59:42 -0700 (PDT)
Date:   Tue, 25 Oct 2022 23:59:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa2b2805ebea9137@google.com>
Subject: [syzbot] WARNING in __split_huge_page_tail
From:   syzbot <syzbot+273b547b15eb58ea35e8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4da34b7d175d Merge tag 'thermal-6.1-rc2' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=113bd8bc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4789759e8a6d5f57
dashboard link: https://syzkaller.appspot.com/bug?extid=273b547b15eb58ea35e8
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161e1f62880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dd4fe6880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a61ddb36c296/disk-4da34b7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ceee41246252/vmlinux-4da34b7d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+273b547b15eb58ea35e8@syzkaller.appspotmail.com

 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:363
 exit_mmap+0x2b1/0x670 mm/mmap.c:3098
 __mmput+0x114/0x3b0 kernel/fork.c:1185
 exit_mm+0x217/0x2f0 kernel/exit.c:516
 do_exit+0x5e7/0x2070 kernel/exit.c:807
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3908 at mm/huge_memory.c:2465 __split_huge_page_tail+0x81c/0x1080 mm/huge_memory.c:2465
Modules linked in:
CPU: 0 PID: 3908 Comm: syz-executor315 Not tainted 6.1.0-rc1-syzkaller-00249-g4da34b7d175d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:__split_huge_page_tail+0x81c/0x1080 mm/huge_memory.c:2465
Code: ff ff e8 57 a7 a6 ff 48 ff cb e9 1a fd ff ff e8 4a a7 a6 ff 4c 89 ef 48 c7 c6 80 5d bb 8a e8 6b f0 e3 ff c6 05 2f 20 30 0c 01 <0f> 0b e9 cb fb ff ff 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 29 f8 ff
RSP: 0018:ffffc900044b6ba8 EFLAGS: 00010046
RAX: beb4e3f6a4108300 RBX: 1ffffd400031ed85 RCX: ffffffff8169255b
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8e277d28
RBP: ffffea00018f0008 R08: dffffc0000000000 R09: fffffbfff1c4efa6
R10: fffffbfff1c4efa6 R11: 1ffffffff1c4efa5 R12: ffffea00018f6c00
R13: ffffea00018f0000 R14: 1ffffd400031e001 R15: ffffea00018f6c28
FS:  00005555567b0300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001304 CR3: 000000001d5c1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __split_huge_page+0x403/0x1df0 mm/huge_memory.c:2527
 split_huge_page_to_list+0x101d/0x1c90 mm/huge_memory.c:2756
 split_huge_page include/linux/huge_mm.h:188 [inline]
 deferred_split_scan+0x683/0x8b0 mm/huge_memory.c:2882
 do_shrink_slab+0x4e1/0xa00 mm/vmscan.c:842
 shrink_slab_memcg+0x2ec/0x630 mm/vmscan.c:911
 shrink_slab+0xbe/0x340 mm/vmscan.c:990
 shrink_node_memcgs+0x3c3/0x770 mm/vmscan.c:6076
 shrink_node+0x299/0x1050 mm/vmscan.c:6105
 shrink_zones+0x4fb/0xc40 mm/vmscan.c:6343
 do_try_to_free_pages+0x215/0xcd0 mm/vmscan.c:6405
 try_to_free_mem_cgroup_pages+0x3cb/0x6d0 mm/vmscan.c:6720
 try_charge_memcg+0x6a1/0x11f0 mm/memcontrol.c:2681
 try_charge mm/memcontrol.c:2823 [inline]
 mem_cgroup_charge_skmem+0xa7/0x370 mm/memcontrol.c:7209
 sock_reserve_memory+0x105/0x640 net/core/sock.c:1018
 sk_setsockopt+0x16bf/0x32c0 net/core/sock.c:1518
 __sys_setsockopt+0x6ba/0xa00 net/socket.c:2248
 __do_sys_setsockopt net/socket.c:2263 [inline]
 __se_sys_setsockopt net/socket.c:2260 [inline]
 __x64_sys_setsockopt+0xb1/0xc0 net/socket.c:2260
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff3a2ea8ee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd09efcd08 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ff3a2ea8ee9
RDX: 0000000000000049 RSI: 0000000000000001 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000010 R09: 00007ffd09efcd30
R10: 0000000020000040 R11: 0000000000000246 R12: 00007ffd09efcd2c
R13: 00007ffd09efcd40 R14: 00007ffd09efcd80 R15: 0000000000000130
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
