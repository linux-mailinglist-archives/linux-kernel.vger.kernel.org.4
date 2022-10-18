Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B02060208C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJRBlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJRBlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:41:24 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABF96FA2F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:41:23 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n14-20020a056e02100e00b002f9e283e850so11099946ilj.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugyZshLi8QdA9euaTqZrcA6bT+Lo/FEJadr8bWEKL1o=;
        b=IP2slVtBQUBegllpYnmLbuOfBdmfVSUtigWic9lAM8mK5A18r9COGRVO5DnjuLdmYF
         1TWR4DIug3V+d+w7D6YTg4fX+UtzW65ztVr1BMs1Kx1hwQ+HfmV4WFlziRq2clQd5ANf
         hTJETeuZnRpDn+Isl9EJbpvCBmtnCKUqPfNZ0MBs9x17ItZBq0L2KVkfLiBkQvKIDjJD
         yC+jbd1yAOuTCWQVqJ057979X9BDHU1NgHLQZJOEiCsSqwcqmBMWQc6y13RxcH/1FiQe
         RHNeWDPcIEulFGBZXepo7fp/sBoZQFzGy5DfYwBswXPIZn4fKNfEfZmO4Q4DKev8gQkP
         g4TQ==
X-Gm-Message-State: ACrzQf2W4QuvgrV4b+dCQW0oAlL0XmVSL+u6nyHLBd+7ZwyDhDDR9rAp
        1lkBZ02BVETXJRwtfTYI4//07+10CfQLuIQ4G69vwc9JWuCj
X-Google-Smtp-Source: AMsMyM65mR6JCybl0H4BWkKHQOdpfDX3/UOlv+GO+W9YHpu2Ua5EHfq3D9sApYJpulcTJkY83AueBkfX7fc0S9IbmbMIUj1nPIfU
MIME-Version: 1.0
X-Received: by 2002:a05:6638:134a:b0:363:a76b:5afb with SMTP id
 u10-20020a056638134a00b00363a76b5afbmr741513jad.23.1666057282482; Mon, 17 Oct
 2022 18:41:22 -0700 (PDT)
Date:   Mon, 17 Oct 2022 18:41:22 -0700
In-Reply-To: <20221017114136.796-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f759e05eb4530c1@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in batadv_nc_worker (3)
From:   syzbot <syzbot+69904c3b4a09e8fa2e1b@syzkaller.appspotmail.com>
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
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (10500 ticks this GP) idle=1a74/1/0x4000000000000000 softirq=7901/7901 fqs=0
	(t=10500 jiffies g=7625 q=3882 ncpus=2)
rcu: rcu_preempt kthread starved for 10500 jiffies! g7625 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:29320 pid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5178 [inline]
 __schedule+0xadf/0x5270 kernel/sched/core.c:6490
 schedule+0xda/0x1b0 kernel/sched/core.c:6566
 schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1935
 rcu_gp_fqs_loop+0x190/0x910 kernel/rcu/tree.c:1658
 rcu_gp_kthread+0x236/0x360 kernel/rcu/tree.c:1857
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:write_comp_data+0x7/0x90 kernel/kcov.c:223
Code: ff 00 75 10 65 48 8b 04 25 80 6f 02 00 48 8b 80 b0 15 00 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 65 8b 05 89 29 87 7e <49> 89 f1 89 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25
RSP: 0018:ffffc90000157b30 EFLAGS: 00000246
RAX: 0000000000000101 RBX: ffff888066e69060 RCX: ffffffff878c48ee
RDX: 0000000000000000 RSI: 0019999999999998 RDI: 0000000000000007
RBP: 0000000225c17d04 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000b1b78399 R12: 00000015798ee228
R13: ffff8880690a7b00 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f801f5b0000 CR3: 0000000020ffc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pie_calculate_probability+0x1ee/0x7c0 net/sched/sch_pie.c:340
 fq_pie_timer+0x1b3/0x360 net/sched/sch_fq_pie.c:382
 call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x1d0/0x9c8 kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:934 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:926
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:write_comp_data+0x7/0x90 kernel/kcov.c:223
Code: ff 00 75 10 65 48 8b 04 25 80 6f 02 00 48 8b 80 b0 15 00 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 65 8b 05 89 29 87 7e <49> 89 f1 89 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25
RSP: 0018:ffffc90000157b30 EFLAGS: 00000246
RAX: 0000000000000101 RBX: ffff888066e69060 RCX: ffffffff878c48ee
RDX: 0000000000000000 RSI: 0019999999999998 RDI: 0000000000000007
RBP: 0000000225c17d04 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000b1b78399 R12: 00000015798ee228
R13: ffff8880690a7b00 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f801f5b0000 CR3: 0000000020ffc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pie_calculate_probability+0x1ee/0x7c0 net/sched/sch_pie.c:340
 fq_pie_timer+0x1b3/0x360 net/sched/sch_fq_pie.c:382
 call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x1d0/0x9c8 kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:934 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:926
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 16 at net/sched/sch_fq_pie.c:390 fq_pie_timer+0x2ba/0x360 net/sched/sch_fq_pie.c:390
Modules linked in:
CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:fq_pie_timer+0x2ba/0x360 net/sched/sch_fq_pie.c:390
Code: 48 c1 ea 03 80 3c 02 00 0f 85 a9 00 00 00 48 8b 35 eb 5f 34 04 48 89 ef 48 01 de e8 e0 70 de f9 e9 62 ff ff ff e8 16 b8 ee f9 <0f> 0b eb a9 48 89 cf e8 0a 1f 3c fa e9 3d fe ff ff e8 00 1f 3c fa
RSP: 0018:ffffc90000157bb8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffffffffb7 RCX: 0000000000000100
RDX: ffff888011a7d880 RSI: ffffffff878c922a RDI: 0000000000000007
RBP: ffff8880690a7b50 R08: 0000000000000007 R09: 0000000000000000
R10: ffffffffffffffb7 R11: 00000000b1b78399 R12: dffffc0000000000
R13: 0000000000000007 R14: 0000000000000400 R15: ffff8880690a7b00
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f801f5b0000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x1d0/0x9c8 kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:934 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:926
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


Tested on:

commit:         55be6084 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14d888aa880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1503ca3c880000

