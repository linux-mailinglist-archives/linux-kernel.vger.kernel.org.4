Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05366B26A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjAOQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjAOQHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:07:13 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C53CC01
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 08:04:17 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so19561001ilb.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 08:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mw93qCzE+7GmsQ0KFuQB0ae+zxKrtgzeZvCf3LWL9Hw=;
        b=Gj2PGhNXhorNkSJC8zXCjqTZ/u9nqQ7iUJBc7l8TMLOmdUsFBTC9kRs778G8ugFiUr
         A6Kcp9MZxy4W4asIFWQJC3hdVIvoSwfCVitcDw/LCPKXxr0bI/oaX+ZEp/AcVB00KOQi
         UDFlsWYInfqld6fF5hLsH9hB6QZJ0l4yMfX89SB7V82z+QOg5F93tZxj6vRePDhTLNk7
         rqZRJk4rgHtHQQfMdKEx8O+7tP5Oz1W3n1lCacUOK8i0hH+BTVfSDmChLuZHpTokyWod
         BZZkLbeu9zmm2O1HicKe9vU7bFUOq7QnDEZ2AAHCyQrCN9ktSnrLG15d93h3VgOdlicX
         viMQ==
X-Gm-Message-State: AFqh2kriuKiXoJpq8CqVULy52PVbQoJyh7K2QUwHpiDxwkUHJbE6T8nA
        6fYzcqWs/PnE8J8n4G/mSMIR0OMk2bv0NUndX8MwwOWHoSqb
X-Google-Smtp-Source: AMrXdXsDr+ycrcn336OmlQ+YyPdoiU5+D2UKSzREBK03dFditnLO0ymrUrONBxd8aTVTStpCoPnhJ0edttu8OMPF4b5dlehocYq1
MIME-Version: 1.0
X-Received: by 2002:a92:d1c4:0:b0:30c:2649:4e9a with SMTP id
 u4-20020a92d1c4000000b0030c26494e9amr6698291ilg.198.1673798656657; Sun, 15
 Jan 2023 08:04:16 -0800 (PST)
Date:   Sun, 15 Jan 2023 08:04:16 -0800
In-Reply-To: <20230115122106.1614-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b0e7205f24f9eb5@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_pcm_post_stop
From:   syzbot <syzbot+e29d28728f38190cecfc@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __io_req_task_work_add

------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at io_uring/refs.h:31 req_ref_get io_uring/refs.h:31 [inline]
WARNING: CPU: 1 PID: 0 at io_uring/refs.h:31 __io_req_task_work_add+0x763/0x850 io_uring/io_uring.c:1310
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:req_ref_get io_uring/refs.h:31 [inline]
RIP: 0010:__io_req_task_work_add+0x763/0x850 io_uring/io_uring.c:1310
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e6 00 00 00 49 8b 7c 24 18 be 01 00 00 00 e8 e7 28 57 fd e9 00 fe ff ff e8 cd 73 80 fd <0f> 0b e9 fd f9 ff ff e8 c1 73 80 fd 0f 0b e9 56 fa ff ff e8 b5 73
RSP: 0018:ffffc900001e0a48 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8880711ba8c0 RCX: 0000000000000100
RDX: ffff88813feb9d40 RSI: ffffffff84014913 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000005 R12: ffff88807e836000
R13: ffff8880711ba920 R14: ffff88801cfd4c00 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f00038cf5a8 CR3: 0000000027f59000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 io_req_task_work_add io_uring/io_uring.h:95 [inline]
 __io_poll_execute io_uring/poll.c:366 [inline]
 io_poll_wake+0x243/0x600 io_uring/poll.c:441
 __wake_up_common+0x147/0x650 kernel/sched/wait.c:107
 __wake_up_common_lock+0xd4/0x140 kernel/sched/wait.c:138
 snd_pcm_update_state+0x445/0x510 sound/core/pcm_lib.c:204
 snd_pcm_update_hw_ptr0+0xada/0x1af0 sound/core/pcm_lib.c:465
 snd_pcm_period_elapsed_under_stream_lock+0x156/0x220 sound/core/pcm_lib.c:1817
 snd_pcm_period_elapsed+0x2c/0x50 sound/core/pcm_lib.c:1849
 dummy_hrtimer_callback+0x98/0x1b0 sound/drivers/dummy.c:385
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x600/0xcf0 kernel/time/hrtimer.c:1749
 hrtimer_run_softirq+0x17f/0x360 kernel/time/hrtimer.c:1766
 __do_softirq+0x1fb/0xaf6 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1107
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:113 [inline]
RIP: 0010:acpi_idle_do_entry+0x1fd/0x2a0 drivers/acpi/processor_idle.c:570
Code: 89 de e8 36 39 7b f7 84 db 75 ac e8 bd 3c 7b f7 e8 38 bd 81 f7 66 90 e8 b1 3c 7b f7 0f 00 2d 2a 44 ab 00 e8 a5 3c 7b f7 fb f4 <9c> 5b 81 e3 00 02 00 00 fa 31 ff 48 89 de e8 60 39 7b f7 48 85 db
RSP: 0018:ffffc90000177d10 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88813feb9d40 RSI: ffffffff8a06803b RDI: 0000000000000000
RBP: ffff888012684864 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffff888012684800 R14: ffff888012684864 R15: ffff88801c228004
 acpi_idle_enter+0x368/0x510 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x1af/0xd40 drivers/cpuidle/cpuidle.c:239
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:356
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3f7/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:400
 start_secondary+0x256/0x300 arch/x86/kernel/smpboot.c:264
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 de                	mov    %ebx,%esi
   2:	e8 36 39 7b f7       	callq  0xf77b393d
   7:	84 db                	test   %bl,%bl
   9:	75 ac                	jne    0xffffffb7
   b:	e8 bd 3c 7b f7       	callq  0xf77b3ccd
  10:	e8 38 bd 81 f7       	callq  0xf781bd4d
  15:	66 90                	xchg   %ax,%ax
  17:	e8 b1 3c 7b f7       	callq  0xf77b3ccd
  1c:	0f 00 2d 2a 44 ab 00 	verw   0xab442a(%rip)        # 0xab444d
  23:	e8 a5 3c 7b f7       	callq  0xf77b3ccd
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	9c                   	pushfq <-- trapping instruction
  2b:	5b                   	pop    %rbx
  2c:	81 e3 00 02 00 00    	and    $0x200,%ebx
  32:	fa                   	cli
  33:	31 ff                	xor    %edi,%edi
  35:	48 89 de             	mov    %rbx,%rsi
  38:	e8 60 39 7b f7       	callq  0xf77b399d
  3d:	48 85 db             	test   %rbx,%rbx


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17d091ee480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1100ada1480000

