Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA8E60606B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJTMks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiJTMkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:40:45 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E01AFE903
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:40:44 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i21-20020a056e021d1500b002f9e4f8eab7so19793451ila.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwGYY0QPmnxlAVVvL0co5D9B4tE8s5P1HVCnF6SqBMc=;
        b=Ed14pxn6YAM4Qi/k3UK15DnBiwVA3fidfyjZY5aqK4Oostf9FkOd/CdZmsnQVK2ajv
         /o9awv6gQIAkCdg5pdPN5KID7kqQeWTjkEnC7YGbu50iqd5nxOZkqGAeF3k4sIDOlVy7
         dwBRrdpjPZHJ3PMIswNpwbdxPa+anrZ/I+4PLqUyGEJ7xoEWXdjxpYO6YyYr7QJREF/8
         jM1H1aS7C9nHOnXfoPQYlwndoeZWPxWsVVznQ3ChtRxrpArld+MECbckqySoKfawzlwB
         IP0aZQUJSh3Qj9A23PQkwC7CcbbMcS/BcxyxQHR8P0Gy54hVHRpZ1LQ6rEZIskQmImC6
         2pmw==
X-Gm-Message-State: ACrzQf2SwBMBfrXdBTV3pEyl0VCHHtnDQS2GtgWhSNtj2PI8dIGbbXxI
        r0VOc4q3LuIgDgixRv2+brTtUpqAAiwJnNkkBoVgh6LNwYcO
X-Google-Smtp-Source: AMsMyM7DqrYf6EYcjDMYUCPq3+5y/Z5mSW2/jYyqbypXJT7zLKQCIZAEc+v05C3WJKXxBZDmNGniuUVEXj4+iziO3DZCYBFoVB/i
MIME-Version: 1.0
X-Received: by 2002:a92:cd89:0:b0:2fa:dba1:2b6a with SMTP id
 r9-20020a92cd89000000b002fadba12b6amr10127960ilb.29.1666269643384; Thu, 20
 Oct 2022 05:40:43 -0700 (PDT)
Date:   Thu, 20 Oct 2022 05:40:43 -0700
In-Reply-To: <0000000000009fa63105eb7648d8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031aec805eb76a2d4@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in vm_area_dup
From:   syzbot <syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        bpf@vger.kernel.org, brauner@kernel.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    acee3e83b493 Add linux-next specific files for 20221020
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=170a8016880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c82245cfb913f766
dashboard link: https://syzkaller.appspot.com/bug?extid=b910411d3d253dab25d8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109e0372880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1770d752880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98cc5896cded/disk-acee3e83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b3d3eb3aa10a/vmlinux-acee3e83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3602, name: syz-executor107
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 3602 Comm: syz-executor107 Not tainted 6.1.0-rc1-next-20221020-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9890
 might_alloc include/linux/sched/mm.h:274 [inline]
 slab_pre_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3323 [inline]
 slab_alloc mm/slub.c:3411 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3418 [inline]
 kmem_cache_alloc+0x2e6/0x3c0 mm/slub.c:3427
 vm_area_dup+0x81/0x380 kernel/fork.c:466
 copy_vma+0x376/0x8d0 mm/mmap.c:3216
 move_vma+0x449/0xf60 mm/mremap.c:626
 __do_sys_mremap+0x487/0x16b0 mm/mremap.c:1075
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd090fa5b29
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc2e90bd38 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd090fa5b29
RDX: 0000000000001000 RSI: 0000000000004000 RDI: 00000000201c4000
RBP: 00007fd090f69cd0 R08: 00000000202ef000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00007fd090f69d60
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

