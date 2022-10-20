Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F406057B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJTGyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJTGyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:54:43 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F157B11C07
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:54:37 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 101-20020a9d0bee000000b00661b54d945fso10872978oth.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b0wm2NtVfhrsgLTdtmnY9qcuKY/ycj5YNMFLjfrfST0=;
        b=pI9ayWrBWaqa0MlmTf/lcAkAAD9NGC3eezq/4DmxFz2oYBlDuUSmchzkDZLOa0yvBK
         HnmXfm8yiHmX0yp+SeV5iLMXSYjEqxauqme4fXR5zxavQFV0wKO8WZ6IchgUhrfHuhaW
         HMNaEMonK5Vj3BNdC5wm8dEwv8YO5DirJzzC8/Iuhh8td/8/a5RXa9qu7P6iQxt0Jxw9
         FUu600AtLy+M7GFZPx/ObiONVw6HhjxYrBym5zk8JGs5DMA7z/1BWSpqeetNkNdomAV+
         6WxF99ZKkZ2L/4wCu9nd8TnGhWv9R4kheL96j9zVI6lwX/9RK8MD5pzZrmAGmg9IA5fs
         gugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0wm2NtVfhrsgLTdtmnY9qcuKY/ycj5YNMFLjfrfST0=;
        b=XXjnfI9sh70ZaK0bJGh5wHt1vQvvIvBVBPvC0IJs7O8OQJbiks9O59nOvLsYNj7ccK
         UosEHZjWeOBJCL8GSKEgCDXDFWnQUnyGtz//rLC+nsA61RVrqEWf2oRy+3uCMapj0Iu/
         eTLbIFcdZsLkcF7lz3vRExF1XL9rKx+0uVvChRZCZd/BCmDlxx4+3Y6i+TX+RjS01QZL
         UuXdTuTslDue2vq4D3gt44FoBp2bUeW0xRJg/ZOwh8L7nt0fqNGIrASd/jYiAFaTLlOs
         uOozYNGBLwVDud0ghVJkR3tFGM5UXFHGQ98QQgUx5vppBZp6rlTrOPx46UNX6ql0efqa
         ElgA==
X-Gm-Message-State: ACrzQf01rbZpYwmOy6Em21D5mHPX8TGybwamI++roHemQNgPxlejPSUO
        KgFmFIpNqeg88VN0DcYiYWSyc0Xg81TRSE2g1L1wQw==
X-Google-Smtp-Source: AMsMyM7gZ+9fKG1sZy9BX3vOoLnLfbDALtO/Y8WntgO9IpvohQodhggChGUgD6gryvUv0yFORV+iOxVDOZWks0E6o2M=
X-Received: by 2002:a05:6830:2044:b0:661:8f8f:ffa2 with SMTP id
 f4-20020a056830204400b006618f8fffa2mr6092538otp.142.1666248876598; Wed, 19
 Oct 2022 23:54:36 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Oct 2022 12:24:25 +0530
Message-ID: <CA+G9fYtOP-spGS7gYyBB-8wpUDiKxd5e_Nk05J9gzWR_DLBeFA@mail.gmail.com>
Subject: Perf: BUG: kernel NULL pointer dereference, address: 0000000000000198
To:     linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel BUG noticed while running perf testing on qemu-x86-64.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--- start ---
test child forked, pid 528
Using CPUID AuthenticAMD-23-1-2
/usr/libexec/perf-core/tests/attr.py:142: DeprecationWarning: The
SafeConfigParser class has been renamed to ConfigParser in Python 3.2.
This alias will be removed in Python 3.12. Use ConfigParser directly
instead.
  parser = configparser.SafeConfigParser()
running '/usr/libexec/perf-core/tests/attr/test-record-graph-default-aarch64'
test limitation 'aarch64'
/usr/libexec/perf-core/tests/attr.py:201: DeprecationWarning: The
SafeConfigParser class has been renamed to ConfigParser in Python 3.2.
This alias will be removed in Python 3.12. Use ConfigParser directly
instead.
  parser_event = configparser.SafeConfigParser()
/usr/libexec/perf-core/tests/attr.py:215: DeprecationWarning: The
SafeConfigParser class has been renamed to ConfigParser in Python 3.2.
This alias will be removed in Python 3.12. Use ConfigParser directly
instead.
  parser_base = configparser.SafeConfigParser()
skipped [x86_64]
'/usr/libexec/perf-core/tests/attr/test-record-graph-default-aarch64'
running '/usr/libexec/perf-core/tests/attr/test-record-group2'
running '/usr/libexec/perf-core/tests/attr/test-record-C0'
running '/usr/libexec/perf-core/tests/attr/test-record-spe-period'
test limitation 'aarch64'
skipped [x86_64] '/usr/libexec/perf-core/tests/attr/test-record-spe-period'
running '/usr/libexec/perf-core/tests/attr/test-record-period'
[  198.864607] perf: interrupt took too long (11296 > 11195), lowering
kernel.perf_event_max_sample_rate to 17000
[  198.867588] perf: interrupt took too long (14200 > 14120), lowering
kernel.perf_event_max_sample_rate to 14000
[  198.871230] perf: interrupt took too long (17803 > 17750), lowering
kernel.perf_event_max_sample_rate to 11000
[  198.878141] perf: interrupt took too long (22268 > 22253), lowering
kernel.perf_event_max_sample_rate to 8000
running '/usr/libexec/perf-core/tests/attr/test-record-branch-any'
unsupp  '/usr/libexec/perf-core/tests/attr/test-record-branch-any'
running '/usr/libexec/perf-core/tests/attr/test-record-branch-filter-any_call'
unsupp  '/usr/libexec/perf-core/tests/attr/test-record-branch-filter-any_call'
running '/usr/libexec/perf-core/tests/attr/test-stat-C0'
running '/usr/libexec/perf-core/tests/attr/test-record-no-samples'
running '/usr/libexec/perf-core/tests/attr/test-record-spe-period-term'
test limitation 'aarch64'
skipped [x86_64] '/usr/libexec/perf-core/tests/attr/test-record-spe-period-term'
running '/usr/libexec/perf-core/tests/attr/test-stat-no-inherit'
running '/usr/libexec/perf-core/tests/attr/test-stat-detailed-1'
running '/usr/libexec/perf-core/tests/attr/test-record-count'
running '/usr/libexec/perf-core/tests/attr/test-record-data'
running '/usr/libexec/perf-core/tests/attr/test-record-raw'
running '/usr/libexec/perf-core/tests/attr/test-stat-default'
running '/usr/libexec/perf-core/tests/attr/test-record-branch-filter-ind_call'
unsupp  '/usr/libexec/perf-core/tests/attr/test-record-branch-filter-ind_call'
running '/usr/libexec/perf-core/tests/attr/test-record-group'
[  204.124863] BUG: kernel NULL pointer dereference, address: 0000000000000198
[  204.125878] #PF: supervisor read access in kernel mode
[  204.126482] #PF: error_code(0x0000) - not-present page
[  204.127127] PGD 0 P4D 0
[  204.127435] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  204.127939] CPU: 3 PID: 574 Comm: perf-exec Not tainted 6.0.3-rc1 #1
[  204.128711] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  204.129619] RIP: 0010:x86_pmu_enable_event+0x43/0x130
[  204.130246] Code: af e8 51 78 0e 01 65 8b 05 6a fe 40 52 85 c0 75
0d 5b 41 5c 41 5d 41 5e 5d e9 69 dc 3f 01 48 c7 c7 6b b4 76 af e8 2d
78 0e 01 <8b> 8b 98 01 00 00 65 4c 8b 25 47 0f 41 52 85 c9 0f 85 ab 00
00 00
[  204.132695] RSP: 0018:ffff9cc040857be8 EFLAGS: 00010092
[  204.133418] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00000000c0010200
[  204.134401] RDX: 0000000000000000 RSI: ffffffffaf76b46b RDI: ffffffffaf6bbc6f
[  204.135398] RBP: ffff9cc040857c08 R08: 0000002f86b5dc60 R09: ffff9cc040857a38
[  204.136413] R10: 0000000000000002 R11: ffffffffaff970a0 R12: ffff8f663bd95c20
[  204.137385] R13: ffff8f663bd95e20 R14: 0000000000000002 R15: 00000000c0010201
[  204.138235] FS:  00007fe3226d77c0(0000) GS:ffff8f663bd80000(0000)
knlGS:0000000000000000
[  204.139133] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  204.139842] CR2: 0000000000000198 CR3: 00000001056a2000 CR4: 00000000003506e0
[  204.140801] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  204.141744] DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
[  204.142731] Call Trace:
[  204.143082]  <TASK>
[  204.143406]  amd_pmu_enable_all+0x4b/0x70
[  204.143974]  x86_pmu_enable+0x17c/0x320
[  204.144530]  ctx_resched+0xcb/0x110
[  204.145016]  perf_event_exec+0x384/0x460
[  204.145575]  begin_new_exec+0x5f7/0xb90
[  204.146471]  load_elf_binary+0xa82/0x17a0
[  204.147042]  ? __kernel_read+0x15a/0x250
[  204.147661]  ? __kernel_read+0x15a/0x250
[  204.148196]  ? trace_preempt_off+0x29/0xc0
[  204.148764]  ? trace_preempt_on+0x29/0xc0
[  204.149206]  ? load_misc_binary+0x215/0x290
[  204.149656]  bprm_execve+0x283/0x680
[  204.150054]  do_execveat_common.isra.0+0x19f/0x220
[  204.150671]  __x64_sys_execve+0x37/0x50
[  204.151204]  do_syscall_64+0x3b/0x90
[  204.151703]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  204.152450] RIP: 0033:0x7fe321cd925b
[  204.152988] Code: Unable to access opcode bytes at RIP 0x7fe321cd9231.
[  204.153870] RSP: 002b:00007ffc5a199828 EFLAGS: 00000202 ORIG_RAX:
000000000000003b
[  204.154865] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fe321cd925b
[  204.155828] RDX: 0000000002809980 RSI: 00007ffc5a19f100 RDI: 00007ffc5a199830
[  204.156765] RBP: 00007ffc5a199940 R08: 0000000000000fff R09: 00000000027c9bff
[  204.157768] R10: 00007fe321c14680 R11: 0000000000000202 R12: 00007ffc5a19f100
[  204.158671] R13: 0000000002809980 R14: 00007ffc5a1a0d59 R15: 00000000027c9bfb
[  204.159451]  </TASK>
[  204.159749] Modules linked in:
[  204.160204] CR2: 0000000000000198
[  204.160696] ---[ end trace 0000000000000000 ]---
[  204.161347] RIP: 0010:x86_pmu_enable_event+0x43/0x130
[  204.162056] Code: af e8 51 78 0e 01 65 8b 05 6a fe 40 52 85 c0 75
0d 5b 41 5c 41 5d 41 5e 5d e9 69 dc 3f 01 48 c7 c7 6b b4 76 af e8 2d
78 0e 01 <8b> 8b 98 01 00 00 65 4c 8b 25 47 0f 41 52 85 c9 0f 85 ab 00
00 00
[  204.164521] RSP: 0018:ffff9cc040857be8 EFLAGS: 00010092
[  204.165287] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00000000c0010200
[  204.166284] RDX: 0000000000000000 RSI: ffffffffaf76b46b RDI: ffffffffaf6bbc6f
[  204.167167] RBP: ffff9cc040857c08 R08: 0000002f86b5dc60 R09: ffff9cc040857a38
[  204.167958] R10: 0000000000000002 R11: ffffffffaff970a0 R12: ffff8f663bd95c20
[  204.168957] R13: ffff8f663bd95e20 R14: 0000000000000002 R15: 00000000c0010201
[  204.170005] FS:  00007fe3226d77c0(0000) GS:ffff8f663bd80000(0000)
knlGS:0000000000000000
[  204.171106] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  204.171924] CR2: 00007fe321cd9231 CR3: 00000001056a2000 CR4: 00000000003506e0
[  204.172942] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  204.173924] DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
[  204.174986] note: perf-exec[574] exited with preempt_count 2
[  225.122265] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  225.123795] rcu: 3-...0: (2 ticks this GP)
idle=0cfc/1/0x4000000000000000 softirq=4348/4348 fqs=5211
[  225.125479] (detected by 2, t=21004 jiffies, g=9861, q=182 ncpus=4)
[  225.126647] Sending NMI from CPU 2 to CPUs 3:
[  225.127690] NMI backtrace for cpu 3
[  225.127728] CPU: 3 PID: 574 Comm: perf-exec Tainted: G      D
     6.0.3-rc1 #1
[  225.127748] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  225.127769] RIP: 0010:queued_spin_lock_slowpath+0x3b/0x2f0
[  225.127883] Code: fc 53 66 90 ba 01 00 00 00 41 8b 04 24 85 c0 75
17 f0 41 0f b1 14 24 85 c0 75 ee 5b 41 5c 41 5d 41 5e 5d e9 c7 7f 1c
01 f3 90 <eb> dd 81 fe 00 01 00 00 74 57 40 30 f6 85 f6 75 7b f0 41 0f
ba 2c
[  225.127887] RSP: 0018:ffff9cc040130dd8 EFLAGS: 00000002
[  225.127901] RAX: 0000000000000001 RBX: ffff8f660089b400 RCX: ffff8f663bda6ac0
[  225.127905] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff8f660089b408
[  225.127908] RBP: ffff9cc040130df8 R08: ffff8f66027f1900 R09: 000000000000010b
[  225.127910] R10: 0000000000000033 R11: 0000000000000227 R12: ffff8f660089b408
[  225.127913] R13: ffff8f663bda6a90 R14: 0000000000026ac0 R15: ffff8f660089b408
[  225.127920] FS:  00007fe3226d77c0(0000) GS:ffff8f663bd80000(0000)
knlGS:0000000000000000
[  225.127927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  225.127931] CR2: 00007fe321cd9231 CR3: 00000001056a2000 CR4: 00000000003506e0
[  225.127933] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  225.127935] DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
[  225.127947] Call Trace:
[  225.127952]  <IRQ>
[  225.127969]  _raw_spin_lock+0x3b/0x50
[  225.128018]  perf_event_task_tick+0xa2/0x3d0
[  225.128059]  ? task_tick_fair+0x76/0x2d0
[  225.128073]  scheduler_tick+0xda/0x280
[  225.128082]  update_process_times+0x95/0xb0
[  225.128116]  tick_sched_handle+0x38/0x50
[  225.128138]  tick_sched_timer+0x7b/0xa0
[  225.128144]  ? tick_sched_do_timer+0xa0/0xa0
[  225.128149]  __hrtimer_run_queues+0xa7/0x300
[  225.128157]  hrtimer_interrupt+0x110/0x230
[  225.128163]  __sysvec_apic_timer_interrupt+0x84/0x170
[  225.128187]  sysvec_apic_timer_interrupt+0xab/0xd0
[  225.128210]  </IRQ>
[  225.128213]  <TASK>
[  225.128216]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  225.128222] RIP: 0010:_raw_spin_unlock_irq+0x17/0x40
[  225.128230] Code: e9 be b8 30 00 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 00 0f 1f 44 00 00 55 48 89 e5 c6 07 00 e8 df 9d 1f ff fb bf 01
00 00 00 <e8> 34 45 11 ff 65 8b 05 4d 29 32 51 85 c0 74 06 5d e9 83 b8
30 00
[  225.128235] RSP: 0018:ffff9cc040857ec8 EFLAGS: 00000246
[  225.128239] RAX: 0000000000000000 RBX: ffff8f66021c2080 RCX: 0000000080000000
[  225.128254] RDX: 0000000000000001 RSI: ffffffffaddd9a56 RDI: 0000000000000001
[  225.128257] RBP: ffff9cc040857ec8 R08: ffffffffafb60cc8 R09: 00000000ffffdfff
[  225.128270] R10: ffffffffafa80ce0 R11: ffffffffafb30ce0 R12: 0000000000000000
[  225.128275] R13: 0000000000000009 R14: ffff9cc040857b38 R15: 0000000000000046
[  225.128283]  ? do_exit+0x66/0xae0
[  225.128331]  ? _raw_spin_unlock_irq+0x11/0x40
[  225.128338]  do_exit+0x66/0xae0
[  225.128347]  make_task_dead+0x5a/0x60
[  225.128355]  rewind_stack_and_make_dead+0x17/0x20
[  225.128384] RIP: 0033:0x7fe321cd925b
[  225.128461] Code: Unable to access opcode bytes at RIP 0x7fe321cd9231.
[  225.128463] RSP: 002b:00007ffc5a199828 EFLAGS: 00000202 ORIG_RAX:
000000000000003b
[  225.128469] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fe321cd925b
[  225.128472] RDX: 0000000002809980 RSI: 00007ffc5a19f100 RDI: 00007ffc5a199830
[  225.128475] RBP: 00007ffc5a199940 R08: 0000000000000fff R09: 00000000027c9bff
[  225.128477] R10: 00007fe321c14680 R11: 0000000000000202 R12: 00007ffc5a19f100
[  225.128479] R13: 0000000002809980 R14: 00007ffc5a1a0d59 R15: 00000000027c9bfb
[  225.128487]  </TASK>
[  288.133586] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  288.137745] rcu: 3-...0: (2 ticks this GP)
idle=0cfc/1/0x4000000000000000 softirq=4348/4348 fqs=20510
[  288.138774] (detected by 1, t=84019 jiffies, g=9861, q=349 ncpus=4)
[  288.139441] Sending NMI from CPU 1 to CPUs 3:
[  288.140110] NMI backtrace for cpu 3
[  288.140118] CPU: 3 PID: 574 Comm: perf-exec Tainted: G      D
     6.0.3-rc1 #1
[  288.140124] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  288.140129] RIP: 0010:queued_spin_lock_slowpath+0x3b/0x2f0
[  288.140140] Code: fc 53 66 90 ba 01 00 00 00 41 8b 04 24 85 c0 75
17 f0 41 0f b1 14 24 85 c0 75 ee 5b 41 5c 41 5d 41 5e 5d e9 c7 7f 1c
01 f3 90 <eb> dd 81 fe 00 01 00 00 74 57 40 30 f6 85 f6 75 7b f0 41 0f
ba 2c
[  288.140143] RSP: 0018:ffff9cc040130dd8 EFLAGS: 00000002
[  288.140146] RAX: 0000000000000001 RBX: ffff8f660089b400 RCX: ffff8f663bda6ac0
[  288.140148] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff8f660089b408
[  288.140148] RBP: ffff9cc040130df8 R08: ffff8f66027f1900 R09: 000000000000010b
[  288.140149] R10: 0000000000000033 R11: 0000000000000227 R12: ffff8f660089b408
[  288.140150] R13: ffff8f663bda6a90 R14: 0000000000026ac0 R15: ffff8f660089b408
[  288.140154] FS:  00007fe3226d77c0(0000) GS:ffff8f663bd80000(0000)
knlGS:0000000000000000
[  288.140157] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  288.140158] CR2: 00007fe321cd9231 CR3: 00000001056a2000 CR4: 00000000003506e0
[  288.140159] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  288.140160] DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
[  288.140161] Call Trace:
[  288.140165]  <IRQ>
[  288.140170]  _raw_spin_lock+0x3b/0x50
[  288.140174]  perf_event_task_tick+0xa2/0x3d0
[  288.140179]  ? task_tick_fair+0x76/0x2d0
[  288.140182]  scheduler_tick+0xda/0x280
[  288.140185]  update_process_times+0x95/0xb0
[  288.140189]  tick_sched_handle+0x38/0x50
[  288.140197]  tick_sched_timer+0x7b/0xa0
[  288.140199]  ? tick_sched_do_timer+0xa0/0xa0
[  288.140202]  __hrtimer_run_queues+0xa7/0x300
[  288.140204]  hrtimer_interrupt+0x110/0x230
[  288.140206]  __sysvec_apic_timer_interrupt+0x84/0x170
[  288.140211]  sysvec_apic_timer_interrupt+0xab/0xd0
[  288.140224]  </IRQ>
[  288.140224]  <TASK>
[  288.140225]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  288.140227] RIP: 0010:_raw_spin_unlock_irq+0x17/0x40
[  288.140229] Code: e9 be b8 30 00 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 00 0f 1f 44 00 00 55 48 89 e5 c6 07 00 e8 df 9d 1f ff fb bf 01
00 00 00 <e8> 34 45 11 ff 65 8b 05 4d 29 32 51 85 c0 74 06 5d e9 83 b8
30 00
[  288.140231] RSP: 0018:ffff9cc040857ec8 EFLAGS: 00000246
[  288.140232] RAX: 0000000000000000 RBX: ffff8f66021c2080 RCX: 0000000080000000
[  288.140233] RDX: 0000000000000001 RSI: ffffffffaddd9a56 RDI: 0000000000000001
[  288.140234] RBP: ffff9cc040857ec8 R08: ffffffffafb60cc8 R09: 00000000ffffdfff
[  288.140235] R10: ffffffffafa80ce0 R11: ffffffffafb30ce0 R12: 0000000000000000
[  288.140236] R13: 0000000000000009 R14: ffff9cc040857b38 R15: 0000000000000046
[  288.140238]  ? do_exit+0x66/0xae0
[  288.140242]  ? _raw_spin_unlock_irq+0x11/0x40
[  288.140248]  do_exit+0x66/0xae0
[  288.140251]  make_task_dead+0x5a/0x60
[  288.140253]  rewind_stack_and_make_dead+0x17/0x20
[  288.140256] RIP: 0033:0x7fe321cd925b
[  288.140270] Code: Unable to access opcode bytes at RIP 0x7fe321cd9231.
[  288.140271] RSP: 002b:00007ffc5a199828 EFLAGS: 00000202 ORIG_RAX:
000000000000003b
[  288.140273] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fe321cd925b
[  288.140274] RDX: 0000000002809980 RSI: 00007ffc5a19f100 RDI: 00007ffc5a199830
[  288.140275] RBP: 00007ffc5a199940 R08: 0000000000000fff R09: 00000000027c9bff
[  288.140276] R10: 00007fe321c14680 R11: 0000000000000202 R12: 00007ffc5a19f100
[  288.140277] R13: 0000000002809980 R14: 00007ffc5a1a0d59 R15: 00000000027c9bfb
[  288.140279]  </TASK>
[  351.145086] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  351.147106] rcu: 3-...0: (2 ticks this GP)
idle=0cfc/1/0x4000000000000000 softirq=4348/4348 fqs=35304
[  351.149375] (detected by 0, t=147026 jiffies, g=9861, q=650 ncpus=4)
[  351.150955] Sending NMI from CPU 0 to CPUs 3:
[  351.152253] NMI backtrace for cpu 3
[  351.152273] CPU: 3 PID: 574 Comm: perf-exec Tainted: G      D
     6.0.3-rc1 #1
[  351.152282] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  351.152296] RIP: 0010:queued_spin_lock_slowpath+0x3b/0x2f0
[  351.152356] Code: fc 53 66 90 ba 01 00 00 00 41 8b 04 24 85 c0 75
17 f0 41 0f b1 14 24 85 c0 75 ee 5b 41 5c 41 5d 41 5e 5d e9 c7 7f 1c
01 f3 90 <eb> dd 81 fe 00 01 00 00 74 57 40 30 f6 85 f6 75 7b f0 41 0f
ba 2c
[  351.152359] RSP: 0018:ffff9cc040130dd8 EFLAGS: 00000002
[  351.152365] RAX: 0000000000000001 RBX: ffff8f660089b400 RCX: ffff8f663bda6ac0
[  351.152367] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff8f660089b408
[  351.152369] RBP: ffff9cc040130df8 R08: ffff8f66027f1900 R09: 000000000000010b
[  351.152370] R10: 0000000000000033 R11: 0000000000000227 R12: ffff8f660089b408
[  351.152371] R13: ffff8f663bda6a90 R14: 0000000000026ac0 R15: ffff8f660089b408
[  351.152375] FS:  00007fe3226d77c0(0000) GS:ffff8f663bd80000(0000)
knlGS:0000000000000000
[  351.152381] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  351.152382] CR2: 00007fe321cd9231 CR3: 00000001056a2000 CR4: 00000000003506e0
[  351.152384] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  351.152384] DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
[  351.152388] Call Trace:
[  351.152392]  <IRQ>
[  351.152399]  _raw_spin_lock+0x3b/0x50
[  351.152421]  perf_event_task_tick+0xa2/0x3d0
[  351.152439]  ? task_tick_fair+0x76/0x2d0
[  351.152446]  scheduler_tick+0xda/0x280
[  351.152451]  update_process_times+0x95/0xb0
[  351.152463]  tick_sched_handle+0x38/0x50
[  351.152471]  tick_sched_timer+0x7b/0xa0
[  351.152473]  ? tick_sched_do_timer+0xa0/0xa0
[  351.152475]  __hrtimer_run_queues+0xa7/0x300
[  351.152478]  hrtimer_interrupt+0x110/0x230
[  351.152480]  __sysvec_apic_timer_interrupt+0x84/0x170
[  351.152490]  sysvec_apic_timer_interrupt+0xab/0xd0
[  351.152494]  </IRQ>
[  351.152495]  <TASK>
[  351.152496]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  351.152498] RIP: 0010:_raw_spin_unlock_irq+0x17/0x40
[  351.152500] Code: e9 be b8 30 00 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 00 0f 1f 44 00 00 55 48 89 e5 c6 07 00 e8 df 9d 1f ff fb bf 01
00 00 00 <e8> 34 45 11 ff 65 8b 05 4d 29 32 51 85 c0 74 06 5d e9 83 b8
30 00
[  351.152501] RSP: 0018:ffff9cc040857ec8 EFLAGS: 00000246
[  351.152503] RAX: 0000000000000000 RBX: ffff8f66021c2080 RCX: 0000000080000000
[  351.152504] RDX: 0000000000000001 RSI: ffffffffaddd9a56 RDI: 0000000000000001
[  351.152505] RBP: ffff9cc040857ec8 R08: ffffffffafb60cc8 R09: 00000000ffffdfff
[  351.152506] R10: ffffffffafa80ce0 R11: ffffffffafb30ce0 R12: 0000000000000000
[  351.152507] R13: 0000000000000009 R14: ffff9cc040857b38 R15: 0000000000000046
[  351.152509]  ? do_exit+0x66/0xae0
[  351.152524]  ? _raw_spin_unlock_irq+0x11/0x40
[  351.152525]  do_exit+0x66/0xae0
[  351.152528]  make_task_dead+0x5a/0x60
[  351.152531]  rewind_stack_and_make_dead+0x17/0x20
[  351.152540] RIP: 0033:0x7fe321cd925b
[  351.152576] Code: Unable to access opcode bytes at RIP 0x7fe321cd9231.
[  351.152581] RSP: 002b:00007ffc5a199828 EFLAGS: 00000202 ORIG_RAX:
000000000000003b
[  351.152583] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fe321cd925b
[  351.152584] RDX: 0000000002809980 RSI: 00007ffc5a19f100 RDI: 00007ffc5a199830
[  351.152585] RBP: 00007ffc5a199940 R08: 0000000000000fff R09: 00000000027c9bff
[  351.152586] R10: 00007fe321c14680 R11: 0000000000000202 R12: 00007ffc5a19f100
[  351.152586] R13: 0000000002809980 R14: 00007ffc5a1a0d59 R15: 00000000027c9bfb
[  351.152589]  </TASK>
[  414.154511] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  414.156284] rcu: 3-...0: (2 ticks this GP)
idle=0cfc/1/0x4000000000000000 softirq=4348/4348 fqs=51040
[  414.166067] (detected by 0, t=210046 jiffies, g=9861, q=959 ncpus=4)
[  414.167261] Sending NMI from CPU 0 to CPUs 3:
[  414.168168] NMI backtrace for cpu 3
[  414.168180] CPU: 3 PID: 574 Comm: perf-exec Tainted: G      D
     6.0.3-rc1 #1
[  414.168192] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  414.168196] RIP: 0010:queued_spin_lock_slowpath+0x3b/0x2f0
[  414.168219] Code: fc 53 66 90 ba 01 00 00 00 41 8b 04 24 85 c0 75
17 f0 41 0f b1 14 24 85 c0 75 ee 5b 41 5c 41 5d 41 5e 5d e9 c7 7f 1c
01 f3 90 <eb> dd 81 fe 00 01 00 00 74 57 40 30 f6 85 f6 75 7b f0 41 0f
ba 2c
[  414.168222] RSP: 0018:ffff9cc040130dd8 EFLAGS: 00000002
[  414.168225] RAX: 0000000000000001 RBX: ffff8f660089b400 RCX: ffff8f663bda6ac0
[  414.168227] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff8f660089b408
[  414.168228] RBP: ffff9cc040130df8 R08: ffff8f66027f1900 R09: 000000000000010b
[  414.168230] R10: 0000000000000033 R11: 0000000000000227 R12: ffff8f660089b408
[  414.168231] R13: ffff8f663bda6a90 R14: 0000000000026ac0 R15: ffff8f660089b408
[  414.168234] FS:  00007fe3226d77c0(0000) GS:ffff8f663bd80000(0000)
knlGS:0000000000000000
[  414.168237] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  414.168238] CR2: 00007fe321cd9231 CR3: 00000001056a2000 CR4: 00000000003506e0
[  414.168239] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  414.168241] DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
[  414.168242] Call Trace:
[  414.168244]  <IRQ>
[  414.168251]  _raw_spin_lock+0x3b/0x50
[  414.168259]  perf_event_task_tick+0xa2/0x3d0
[  414.168265]  ? task_tick_fair+0x76/0x2d0
[  414.168270]  scheduler_tick+0xda/0x280
[  414.168275]  update_process_times+0x95/0xb0
[  414.168288]  tick_sched_handle+0x38/0x50
[  414.168292]  tick_sched_timer+0x7b/0xa0
[  414.168294]  ? tick_sched_do_timer+0xa0/0xa0
[  414.168297]  __hrtimer_run_queues+0xa7/0x300
[  414.168299]  hrtimer_interrupt+0x110/0x230
[  414.168301]  __sysvec_apic_timer_interrupt+0x84/0x170
[  414.168315]  sysvec_apic_timer_interrupt+0xab/0xd0
[  414.168392]  </IRQ>
[  414.168392]  <TASK>
[  414.168393]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  414.168396] RIP: 0010:_raw_spin_unlock_irq+0x17/0x40

[1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.0.y/build/v6.0-916-g844297340351/testrun/12536939/suite/log-parser-test/test/check-kernel-bug/log
[2] https://lkft.validation.linaro.org/scheduler/job/5708609#L18779

metadata:
  git_ref: linux-6.0.y
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
  git_sha: 84429734035197a6ab8e79c852d5e4e6ed744703
  git_describe: v6.0-916-g844297340351
  kernel_version: 6.0.3-rc1
  kernel-config: https://builds.tuxbuild.com/2GMZJJEvy18jDgLO4utw6cOelj3/config
  build-url: https://gitlab.com/mrchapp/linux/-/pipelines/671394419
  artifact-location: https://builds.tuxbuild.com/2GMZJJEvy18jDgLO4utw6cOelj3
  toolchain: gcc-11

--
Linaro LKFT
https://lkft.linaro.org
