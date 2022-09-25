Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5B5E94C6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiIYRTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiIYRTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:19:39 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C82DA1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:19:35 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id h9-20020a056e021b8900b002f19c2a1836so3701784ili.23
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=PsXujgeal9wQJe4mJZK5lU6/DKbFJBuwezONBEQonpI=;
        b=JVRtMREvc1M9PgNaIuDmwlDHP/NpWNhX6OuJxP5IBI8oh+QoK0Mh2cpzgIfFdYBlBD
         KSO7n88twkC9xPD0XNu+1EcHYrWzhm0c6+DIhOtK/4HG12n6U7k32jXmVnyIIIGBj1G4
         tiRyzKi963PigfRxTI0bWOrcRZiUlr372sO8hmXAQ6996wSBmBf0cMc0PJ4f5VCf79or
         I4VKD94ZtbW1DWpArwqLXJRXUJNSLtYXHXYv+3xsTbM78bZ0WxqHbccwVnapV6LAsOfO
         a1HFGW/GaXFdHoHWt7+BVBXrr2THWjeLWYs+Z+bEl3h//0uCEpxXY7MokUByPSry4jjB
         PL/w==
X-Gm-Message-State: ACrzQf1GSsnE4EjlegxTFVb3YlbmnsoGE3wh1iM02zrev2xo1ET5xjnn
        gkkPM09nJv1Xy+QSFimd3rqv7IsJ85i7dP/1c5wh8dyIWoR/
X-Google-Smtp-Source: AMsMyM7069qTVbupernHxdT4XXjI4Q8RUU1QVOflKJDDM3SGa18vFDi2+V8otOAakax0XDDeOF+24cOX4QLZfjqbwh3/mLY2WFu7
MIME-Version: 1.0
X-Received: by 2002:a05:6638:388a:b0:35a:e02d:ca1e with SMTP id
 b10-20020a056638388a00b0035ae02dca1emr9750526jav.133.1664126374463; Sun, 25
 Sep 2022 10:19:34 -0700 (PDT)
Date:   Sun, 25 Sep 2022 10:19:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000694eea05e9839d2d@google.com>
Subject: [syzbot] KASAN: null-ptr-deref Write in alloc_buddy_huge_page
From:   syzbot <syzbot+db491b09f5907cdb5984@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    aaa11ce2ffc8 Add linux-next specific files for 20220923
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16ea4288880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=db491b09f5907cdb5984
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134606ef080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c83cff080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db491b09f5907cdb5984@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:102 [inline]
BUG: KASAN: null-ptr-deref in atomic_cmpxchg include/linux/atomic/atomic-instrumented.h:503 [inline]
BUG: KASAN: null-ptr-deref in page_ref_freeze include/linux/page_ref.h:318 [inline]
BUG: KASAN: null-ptr-deref in alloc_buddy_huge_page.isra.0+0x103/0x230 mm/hugetlb.c:1960
Write of size 4 at addr 0000000000000034 by task syz-executor107/3608

CPU: 0 PID: 3608 Comm: syz-executor107 Not tainted 6.0.0-rc6-next-20220923-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:102 [inline]
 atomic_cmpxchg include/linux/atomic/atomic-instrumented.h:503 [inline]
 page_ref_freeze include/linux/page_ref.h:318 [inline]
 alloc_buddy_huge_page.isra.0+0x103/0x230 mm/hugetlb.c:1960
 alloc_fresh_huge_page+0x395/0x530 mm/hugetlb.c:2013
 alloc_surplus_huge_page+0x139/0x2f0 mm/hugetlb.c:2227
 alloc_buddy_huge_page_with_mpol mm/hugetlb.c:2304 [inline]
 alloc_huge_page+0xbf6/0x1180 mm/hugetlb.c:2919
 hugetlb_no_page mm/hugetlb.c:5571 [inline]
 hugetlb_fault+0x1056/0x1e60 mm/hugetlb.c:5796
 follow_hugetlb_page+0x3f3/0x1850 mm/hugetlb.c:6291
 __get_user_pages+0x2cb/0xf10 mm/gup.c:1146
 __get_user_pages_locked mm/gup.c:1378 [inline]
 __get_user_pages_remote+0x18f/0x830 mm/gup.c:2131
 pin_user_pages_remote+0x6c/0xb0 mm/gup.c:3189
 process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
 process_vm_rw_core.constprop.0+0x43b/0x980 mm/process_vm_access.c:215
 process_vm_rw+0x29c/0x300 mm/process_vm_access.c:283
 __do_sys_process_vm_writev mm/process_vm_access.c:303 [inline]
 __se_sys_process_vm_writev mm/process_vm_access.c:298 [inline]
 __x64_sys_process_vm_writev+0xdf/0x1b0 mm/process_vm_access.c:298
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff4166016c9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff99de70c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000137
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff4166016c9
RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000e18
RBP: 00007fff99de70e0 R08: 000000000000023a R09: 0000000000000000
R10: 0000000020121000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
