Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675B86060CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJTM7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiJTM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:59:48 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAD3BAE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:59:42 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id x6-20020a056e021bc600b002fc96f780e7so20125511ilv.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4hi8rEJq2YX1jSHUhJLl2Vtr/5VvQ8mSGRcQz0nCmo4=;
        b=u4A5GZNB0sdU/Ffu0fU9fEOqE02kgiF5/WhycoYpnM1Be9Es5dPRAvjV6WRsfMcAEN
         asUVf4MXpkpno8fXw/ua+WHZ43rCAoO+lJqyZb8LsfC6FlhM+gk9v2YH8i50bKuyWLXM
         CK0Bi+m38pr1lj26ouybNer0pA4Fgd8Od7+xdReExSKgUQ2n5zp4n+IhZg827Z1CDf0A
         ZlozHHwgQc+iH2h0QnIdWl2m9sdLB5N1bmZhqfWbfUq+d/qjdeYbJRGT1naiHwXLJJ0F
         Tb2UF1OemPG7I706H7Wp3Ws7tMh8yHnSHUfe79r6n7sViKaH07yo705QXFdjHlorUSyL
         b71A==
X-Gm-Message-State: ACrzQf0kT74fEPNnpiaLrjRGDc+KH+Zk+hWmhvlZP61Abq9HaaWr4vT0
        QeQLmT3UG69+i/QfAbgwDSRr9duD9p0jv0Lq2XuP0I1g0Ioz
X-Google-Smtp-Source: AMsMyM5GC6iijSslBJ5Vnh4I4n+l4Nuk9X0UMEuoC/LcrNCyEA2I8Ko2vIXOSi8ksKxGFSK4zaQPTkmNsDpv8H8dj71ud5By+kyr
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c05:b0:2fc:2f37:75c3 with SMTP id
 l5-20020a056e021c0500b002fc2f3775c3mr10363032ilh.149.1666270781978; Thu, 20
 Oct 2022 05:59:41 -0700 (PDT)
Date:   Thu, 20 Oct 2022 05:59:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f3fec05eb76e68f@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in break_ksm
From:   syzbot <syzbot+78a0878b3076f71313b3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL_A autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    acee3e83b493 Add linux-next specific files for 20221020
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15961f62880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c82245cfb913f766
dashboard link: https://syzkaller.appspot.com/bug?extid=78a0878b3076f71313b3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1255612c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a1bed2880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98cc5896cded/disk-acee3e83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b3d3eb3aa10a/vmlinux-acee3e83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78a0878b3076f71313b3@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/ksm.c:500
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3610, name: syz-executor212
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 3610 Comm: syz-executor212 Not tainted 6.1.0-rc1-next-20221020-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9890
 break_ksm.part.0+0xbe/0x160 mm/ksm.c:500
 break_ksm mm/ksm.c:875 [inline]
 unmerge_ksm_pages+0x1a0/0x240 mm/ksm.c:881
 unmerge_and_remove_all_rmap_items mm/ksm.c:1021 [inline]
 run_store+0x3cf/0xa30 mm/ksm.c:2983
 kobj_attr_store+0x50/0x80 lib/kobject.c:824
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:330
 call_write_iter include/linux/fs.h:2191 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:584
 ksys_write+0x127/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc23ce26b39
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3f50c3a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc23ce26b39
RDX: 0000000000000002 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007fc23cdeace0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc23cdead70
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
