Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3BC612A24
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJ3KfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3KfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:35:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0878C2D8;
        Sun, 30 Oct 2022 03:35:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t25so22927168ejb.8;
        Sun, 30 Oct 2022 03:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HA/TsoWyYCiHqbEQKGIfjnR3yiWyLtF/oSx7LE7r7rE=;
        b=DyfPL81gT9sRKhQCto4HVM/9Ec9iRKezFR98pTitKrkIL+YuNPm7cmM0is9FDbzvJY
         80notpMeTjixUrtS3YZH7O31gCF+inhmcoGbZzc8Oe9T/NHVCcCmgY4JEClB9AvF157a
         a4RwfPXZ9eVHMOdtDyjK0VTSGmz4eJ9aOWJGcXEPo7WbO2e9FIgadVhaSvZG9cT7XhEy
         2B5om0Mox9vBzoqumPWd6htED1x142QxgdGqt2GSQ4uKgg1tGlSTiPspTix2BdNl+pdQ
         Ym2VwByAQOruSYExxB/TkSJcWYc1lQk4w7dt2kfAqle8f/d63OmOHFTUPDDTerQHBKnS
         /Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HA/TsoWyYCiHqbEQKGIfjnR3yiWyLtF/oSx7LE7r7rE=;
        b=LDuky4Dbu+ODFCVfi1wJMiMT9aTFkM8ppoJDXvnwTllUwgXTWoron00Dy4QPBDWgib
         6/UIZPWjDfko9gomu6ZdQvLmXc6Ck9bUE389ysxi078BqbiWnZItWdiUexQwCu+1cEYx
         uBSeYbrLuI2t/Yac95hKxYliwLOjqh+rxEXuGKaeRgePIqzA235BLzTzKnszFRuY71wq
         4xvGEsLCUoKnKIIadAFLqiZ54yaNeTSt+17dlUVDSBXUt8rUXLj/FcAD6BwEvrsH2B0s
         UhwmP/neEpWNUnva2WMHv2c4bvGn9noD/7QplD+qQ7Z9upLl2vbiJR13JwejxKGS7HhE
         qUWw==
X-Gm-Message-State: ACrzQf2rUVQxcZnOsGZfBPQ92c1GIpFSBfzDYz/rjmtRlrYGdco/FaTU
        nigQA269F4W/XIM4pxD0u5HOsv4xxS4U5eKnksQbgj8Q6Zx+yw==
X-Google-Smtp-Source: AMsMyM7aAsT7bTPpeukUaT9c6Q6CCksPZ2bYH2NEZX6yrJndIzBbWv8z2+x+2tTeur+MPxYYYq+B453QznyhMn40eHM=
X-Received: by 2002:a17:907:c208:b0:7ad:a0df:d4c7 with SMTP id
 ti8-20020a170907c20800b007ada0dfd4c7mr7499593ejc.312.1667126111351; Sun, 30
 Oct 2022 03:35:11 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 18:34:35 +0800
Message-ID: <CAO4mrfffEyq9JzT=GJxzf7fUzXa0Pmx4J40qVDUepasnZ2QDgw@mail.gmail.com>
Subject: INFO: rcu detected stall in blk_mq_requeue_work
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: gcc 8.0.1
console output:
https://drive.google.com/file/d/1KgH89-sBhQbB2t-kx_ChpMM1F-7leKuo/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
(detected by 1, t=18410 jiffies, g=171261, q=4)
rcu: All QSes seen, last rcu_preempt kthread activity 17890
(4295068194-4295050304), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 17890 jiffies! g171261 f0x2
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM is now
expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task     stack:13832 pid:   16 ppid:     2 flags:0x00004000
Call Trace:
 __schedule+0x4a1/0x1720
 schedule+0x36/0xe0
 schedule_timeout+0x2d7/0x4d0
 rcu_gp_fqs_loop+0x299/0x410
 rcu_gp_kthread+0xd0/0x160
 kthread+0x1a6/0x1e0
 ret_from_fork+0x1f/0x30
rcu: Stack dump where RCU GP kthread last ran:
NMI backtrace for cpu 1
CPU: 1 PID: 160 Comm: kworker/1:1H Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
Workqueue: kblockd blk_mq_requeue_work

Call Trace:
 <IRQ>
 dump_stack_lvl+0xcd/0x134
 nmi_cpu_backtrace.cold.8+0xf3/0x118
 nmi_trigger_cpumask_backtrace+0x18f/0x1c0
 rcu_check_gp_kthread_starvation.cold.103+0xb6/0x1a5
 rcu_sched_clock_irq+0xb1d/0x1020
 update_process_times+0xcf/0x130
 tick_sched_handle.isra.20+0x47/0xa0
 tick_sched_timer+0xa2/0xc0
 __hrtimer_run_queues+0x2ea/0x810
 hrtimer_interrupt+0x12b/0x2c0
 __sysvec_apic_timer_interrupt+0x9c/0x2c0
 sysvec_apic_timer_interrupt+0x99/0xc0
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x60
Code: 74 24 10 e8 8a a3 70 fc 48 89 ef e8 e2 d4 70 fc 81 e3 00 02 00
00 75 25 9c 58 f6 c4 02 75 2c 48 85 db 74 01 fb bf 01 00 00 00 <e8> e3
69 6c fc 65 8b 05 4c 17 42 7b 85 c0 74 0a 5b 5d c3 e8 70 e3
RSP: 0018:ffffc90000f47b60 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000200 RCX: 0000000000000006
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffff88800e23cc00 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000005 R11: 0000000000000000 R12: ffff8881043a2780
R13: 0000000000000246 R14: ffff88800e1ab000 R15: ffff88800e146e00
 ata_scsi_queuecmd+0x5e/0x90
 scsi_queue_rq+0x678/0x13e0
 blk_mq_dispatch_rq_list+0x209/0xd10
 __blk_mq_sched_dispatch_requests+0xf1/0x1f0
 blk_mq_sched_dispatch_requests+0x5e/0xb0
 __blk_mq_run_hw_queue+0x70/0xd0
 __blk_mq_delay_run_hw_queue+0x315/0x370
 blk_mq_run_hw_queue+0xb5/0x140
 blk_mq_run_hw_queues+0x7d/0x150
 blk_mq_requeue_work+0x1fe/0x230
 process_one_work+0x3fa/0x9f0
 worker_thread+0x42/0x5c0
 kthread+0x1a6/0x1e0
 ret_from_fork+0x1f/0x30
----------------
Code disassembly (best guess):
   0: 74 24                je     0x26
   2: 10 e8                adc    %ch,%al
   4: 8a a3 70 fc 48 89    mov    -0x76b70390(%rbx),%ah
   a: ef                    out    %eax,(%dx)
   b: e8 e2 d4 70 fc        callq  0xfc70d4f2
  10: 81 e3 00 02 00 00    and    $0x200,%ebx
  16: 75 25                jne    0x3d
  18: 9c                    pushfq
  19: 58                    pop    %rax
  1a: f6 c4 02              test   $0x2,%ah
  1d: 75 2c                jne    0x4b
  1f: 48 85 db              test   %rbx,%rbx
  22: 74 01                je     0x25
  24: fb                    sti
  25: bf 01 00 00 00        mov    $0x1,%edi
* 2a: e8 e3 69 6c fc        callq  0xfc6c6a12 <-- trapping instruction
  2f: 65 8b 05 4c 17 42 7b mov    %gs:0x7b42174c(%rip),%eax        # 0x7b421782
  36: 85 c0                test   %eax,%eax
  38: 74 0a                je     0x44
  3a: 5b                    pop    %rbx
  3b: 5d                    pop    %rbp
  3c: c3                    retq
  3d: e8                    .byte 0xe8
  3e: 70 e3                jo     0x23

Best,
Wei
