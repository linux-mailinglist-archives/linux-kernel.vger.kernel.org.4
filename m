Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE095FA19B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJJQMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJJQMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:12:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D35D183BA;
        Mon, 10 Oct 2022 09:12:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d26so18770758eje.10;
        Mon, 10 Oct 2022 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=06YPU7ggBln/wZcgryqzM4AGHEXt2ZDt7Fv32u04GYA=;
        b=hO9jmumfqQwp743uSG1lIMLx97RYcAcEeO+TJm3ml3BYhHbTLncLTszFcOImH821B8
         ICtBJPXXJodACD5X+I8NIKDZiBONQ7CNxXifMUJLXxgiU9oCYx/B0waMetzOmgrgABMU
         lZRfJaMj+nyevUABhYcAFng85tle76YOA1wfewT6oqn+gPsCoAWorpYnfscAUbxXjrLm
         MZm9gRS42P865+Z2fK51ATfsFuVm5am4lPCWLVqyNKfp0nldbI2U7N2IykT8+kcGUAVG
         d1R6DAH1XaWV7ijb9MIuNCaZgtvcqgozAdmqNwpeokUM/rJYPZAqMoRmW71BcOkTj0jN
         kZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06YPU7ggBln/wZcgryqzM4AGHEXt2ZDt7Fv32u04GYA=;
        b=nZs8YfB/F35iZTUq3v+LVQHs0J0n8FBvdY5546uc1KpG4R9eroTrhbDyXitl9BFfo8
         /TbzzU2OthWD9Ann2I25wWo7R17yl7q8YJAuwjIOZSNVHBTKujU5O6UlL9UtTNu2gh1R
         E6PgEovfNjITVRQcEyQGGscxSR8nk1tHAS5Ad6/5rX7swnQRu6VCBlmi+baAAJcsBN0j
         0XYa8jgIJIxb7g/hjAMUIH4U2F8//q2Dgjv+/ExJgoZhfVIFczupTxYxecPYFAtqWkc1
         14KN617pBvL1FKJgOz5Boer5YzBv9KFBkYI1La9hv1y4ljkPahApoJwBE38d7aO2Zc+2
         vjzA==
X-Gm-Message-State: ACrzQf0dnQBKgR3RjQvE79Bu9dqpJCbpox2QwYjYUQVxbeiuof4rLNyp
        WySsSEAfbglvKSAgiQISd0wysL1QX8XXSzDWYco=
X-Google-Smtp-Source: AMsMyM6p45xDzmbwRXzsXOSY0Npo5cVslI6LDiHI+0A0EnR8aAFsrTIh1haKlZze1xIlK+2vBjrg4LhH2qODR5iWA5M=
X-Received: by 2002:a17:907:97c2:b0:78d:accc:c0a9 with SMTP id
 js2-20020a17090797c200b0078dacccc0a9mr6236985ejc.312.1665418335550; Mon, 10
 Oct 2022 09:12:15 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Tue, 11 Oct 2022 00:11:39 +0800
Message-ID: <CAO4mrff==O4pbJc+OjnrLz3so1D6spp_YvOkSiu-cFp3z8ZbHQ@mail.gmail.com>
Subject: INFO: rcu detected stall in hwrng_fillfn
To:     mpm@selenic.com, herbert@gondor.apana.org.au,
        linux@dominikbrodowski.net, ebiggers@google.com, Jason@zx2c4.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: c5eb0a61238d Linux 5.18-rc6
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1JHFwMk9CWxcUbREbJehKSd98-AvyT3DA/view?usp=sharing
kernel config: https://drive.google.com/file/d/12fNP5UArsFqTi2jjGomWuCk5evtgU0Gu/view?usp=sharing

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: Tasks blocked on level-0 rcu_node (CPUs 0-0): P6559/1:b..l
(detected by 0, t=24003 jiffies, g=61277, q=132)
task:sshd            state:R  running task     stack:22448 pid: 6559
ppid:  6396 flags:0x00004002
Call Trace:
 <TASK>
 __schedule+0xb8e/0x1140
 preempt_schedule+0x12b/0x180
 preempt_schedule_thunk+0x16/0x18
 __local_bh_enable_ip+0x14b/0x1c0
 ip_finish_output2+0xdb2/0x19b0
 __ip_queue_xmit+0x11bb/0x1c20
 __tcp_transmit_skb+0x1e33/0x3410
 tcp_write_xmit+0x1b6e/0x77a0
 __tcp_push_pending_frames+0x8e/0x260
 tcp_sendmsg_locked+0x390e/0x4740
 tcp_sendmsg+0x2c/0x40
 sock_write_iter+0x398/0x520
 vfs_write+0xa02/0xd20
 ksys_write+0x16b/0x2a0
 do_syscall_64+0x3d/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f59438db970
RSP: 002b:00007ffcf76d77b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000034 RCX: 00007f59438db970
RDX: 0000000000000034 RSI: 000056378c676f48 RDI: 0000000000000003
RBP: 000056378c65dfa0 R08: 00007ffcf77cd080 R09: 0000000000000070
R10: 00007ffcf77cd118 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcf76d784f R14: 000056378b47bbe7 R15: 0000000000000003
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 20549 jiffies!
g61277 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: Possible timer handling issue on cpu=0 timer-softirq=24406
rcu: rcu_preempt kthread starved for 20550 jiffies! g61277 f0x0
RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM is now
expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27792 pid:   16 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 __schedule+0xb8e/0x1140
 schedule+0xeb/0x1b0
 schedule_timeout+0x1aa/0x2f0
 rcu_gp_fqs_loop+0x1fd/0x770
 rcu_gp_kthread+0xa5/0x340
 kthread+0x266/0x300
 ret_from_fork+0x1f/0x30
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
NMI backtrace for cpu 0
CPU: 0 PID: 735 Comm: hwrng Not tainted 5.18.0-rc6 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0x1b1/0x28e
 nmi_cpu_backtrace+0x40e/0x440
 nmi_trigger_cpumask_backtrace+0x16a/0x280
 rcu_check_gp_kthread_starvation+0x1f9/0x270
 rcu_sched_clock_irq+0x255f/0x2d60
 update_process_times+0x197/0x200
 tick_sched_timer+0x376/0x540
 __hrtimer_run_queues+0x4cb/0xa60
 hrtimer_interrupt+0x3b3/0x1040
 __sysvec_apic_timer_interrupt+0xf9/0x280
 sysvec_apic_timer_interrupt+0x8c/0xb0
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:iowrite16+0x1d/0x80
Code: 80 61 fd 5b 5d c3 0f 1f 80 00 00 00 00 55 53 48 89 f3 89 fd e8
c4 80 61 fd 48 81 fb 00 00 04 00 72 0a e8 b6 80 61 fd 66 89 2b <eb> 58
48 81 fb 01 00 01 00 72 0e e8 a3 80 61 fd 0f b7 d3 89 e8 66
RSP: 0018:ffffc900036dfd08 EFLAGS: 00000293
RAX: ffffffff8422337a RBX: ffffc90000093000 RCX: ffff888019864880
RDX: 0000000000000000 RSI: ffffc90000093000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8492ecd7 R09: ffff888105b34540
R10: fffff520006dbfc0 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888105bedc00
 vp_notify+0x52/0x70
 virtqueue_kick+0x3bf/0x5e0
 copy_data+0x24a/0x390
 virtio_read+0xc5/0x200
 hwrng_fillfn+0x14a/0x470
 kthread+0x266/0x300
 ret_from_fork+0x1f/0x30
 </TASK>
----------------
Code disassembly (best guess):
   0: 80 61 fd 5b          andb   $0x5b,-0x3(%rcx)
   4: 5d                    pop    %rbp
   5: c3                    retq
   6: 0f 1f 80 00 00 00 00 nopl   0x0(%rax)
   d: 55                    push   %rbp
   e: 53                    push   %rbx
   f: 48 89 f3              mov    %rsi,%rbx
  12: 89 fd                mov    %edi,%ebp
  14: e8 c4 80 61 fd        callq  0xfd6180dd
  19: 48 81 fb 00 00 04 00 cmp    $0x40000,%rbx
  20: 72 0a                jb     0x2c
  22: e8 b6 80 61 fd        callq  0xfd6180dd
  27: 66 89 2b              mov    %bp,(%rbx)
* 2a: eb 58                jmp    0x84 <-- trapping instruction
  2c: 48 81 fb 01 00 01 00 cmp    $0x10001,%rbx
  33: 72 0e                jb     0x43
  35: e8 a3 80 61 fd        callq  0xfd6180dd
  3a: 0f b7 d3              movzwl %bx,%edx
  3d: 89 e8                mov    %ebp,%eax
  3f: 66                    data16

Best,
Wei
