Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00E60D01B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiJYPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiJYPQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:16:29 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0500CA7A96
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:16:26 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b25so8246702qkk.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=mime-version:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FhnbE95QJj/nNzNkYcZWRp5WvlJd4Pqe+TdqU0ir/SA=;
        b=YsGweY3OuZga08+h8M+tbGzhBOenMStG6bm5WXJsBSLJgQTaPob5v9A+P2vLY3U/TY
         gAlKOoiA/uejPGFbpE6OtDWN9rv7DB5yYxlXm/PbmKrEEI/Gvt0RsvadtOKAj3LX38PB
         oOlR3aWrAI3FTGOTh0WpGvtktTL4dLAzajr3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhnbE95QJj/nNzNkYcZWRp5WvlJd4Pqe+TdqU0ir/SA=;
        b=Qtz95kFjQRFOmfSL+GzzKaEo7sKgJhpSap67NgDJn33QMO2bElxEFsYKhkZIBp/aVd
         Fpr8hVaK00EwByB5rFM7NzMIa/1PIvAmWE6v5jrZaocZvY0flQTyOfMi7eVgCk2YtWNR
         FrZojhrfLTPHfyR3oZC3WvxH2V4w11uFlkqEgopYRBvjZTclqU5zBXztrQfD83kbY/5g
         W0XyRbmwtpeGZnRBBKd62sesl14u7FvghuLWw5C1WqO6TJegGvQgb5n0QI4VZ5y0fbAR
         Z58pcunO4CYdKTM50NAsZ+PsgeeBW0y8IKWj4aDdtC7Od8rJN6IH/sRNiVFRsEysI1JU
         t1Mg==
X-Gm-Message-State: ACrzQf3IK/Y/FJgzOLat+qWVD4/GtUS7SOdZfaWKv+6vOqSXATdqMuVv
        3t56RjOZ6+snNgGDHxPoxiHFMZ8Izo/0Wg==
X-Google-Smtp-Source: AMsMyM6TmcHNVTiVXwflCOZh86XqachFgcloVglHSIc9AxjEM4RYC0Lat56FjHDtBsGyrPZ/yI+VNw==
X-Received: by 2002:a05:620a:410f:b0:6cf:c34b:3c64 with SMTP id j15-20020a05620a410f00b006cfc34b3c64mr26938661qko.52.1666710939535;
        Tue, 25 Oct 2022 08:15:39 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a0f0e00b006cfc1d827cbsm2280766qkl.9.2022.10.25.08.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:15:38 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 25 Oct 2022 11:15:37 -0400 (EDT)
To:     linux-kernel@vger.kernel.org
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: perf: WARNING circular locking with __perf_event_read
Message-ID: <c02c1f56-da95-b48a-f155-692f9ff4208d@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

just got this while fuzzing 6.1.0-rc1 with the perf_fuzzer on a Haswell 
machine.

I don't know if this is interesting or not.  This CPU has the 
"perfevents: irq loop stuck!" bug, and I think sometimes warnings get
triggered because the related "core: clearing PMU state on CPU#4"
message gets printk'd at unlucky times.

Vince



[467358.750879] ======================================================
[467358.750880] WARNING: possible circular locking dependency detected
[467358.750882] 6.1.0-rc1 #176 Tainted: G        W         
[467358.750884] ------------------------------------------------------
[467358.750885] swapper/6/0 is trying to acquire lock:
[467358.750887] ffffffff82f8fa78 ((console_sem).lock){-.-.}-{2:2}, at: 
down_trylock+0x11/0x50
[467358.750900] 
                but task is already holding lock:
[467358.750901] ffffe8ffffd07de0 (&cpuctx_lock){-.-.}-{2:2}, at: __perf_event_read+0xcb/0x3d0
[467358.750910] 
                which lock already depends on the new lock.

[467358.750911] 
                the existing dependency chain (in reverse order) is:
[467358.750912] 
                -> #3 (&cpuctx_lock){-.-.}-{2:2}:
[467358.750916]        _raw_spin_lock+0x2f/0x40
[467358.750920]        __perf_pmu_sched_task+0x61/0x1a0
[467358.750924]        perf_pmu_sched_task.part.0+0xb0/0xc0
[467358.750927]        __perf_event_task_sched_out+0x97/0xf80
[467358.750931]        __schedule+0x1183/0x2400
[467358.750934]        schedule_idle+0x2f/0x60
[467358.750936]        do_idle+0x266/0x3e0
[467358.750941]        cpu_startup_entry+0x19/0x20
[467358.750944]        rest_init+0x10c/0x190
[467358.750947]        arch_call_rest_init+0xf/0x19
[467358.750950]        start_kernel+0x3f6/0x418
[467358.750952]        secondary_startup_64_no_verify+0xce/0xdb
[467358.750957] 
                -> #2 (&rq->__lock){-.-.}-{2:2}:
[467358.750961]        _raw_spin_lock_nested+0x32/0x40
[467358.750965]        raw_spin_rq_lock_nested+0x26/0xb0
[467358.750969]        task_fork_fair+0x53/0x290
[467358.750971]        sched_cgroup_fork+0x224/0x290
[467358.750975]        copy_process+0x235e/0x3360
[467358.750978]        kernel_clone+0xfb/0x4e0
[467358.750980]        user_mode_thread+0xa6/0xe0
[467358.750983]        rest_init+0x1e/0x190
[467358.750985]        arch_call_rest_init+0xf/0x19
[467358.750987]        start_kernel+0x3f6/0x418
[467358.750990]        secondary_startup_64_no_verify+0xce/0xdb
[467358.750993] 
                -> #1 (&p->pi_lock){-.-.}-{2:2}:
[467358.750996]        _raw_spin_lock_irqsave+0x47/0x70
[467358.751000]        try_to_wake_up+0xa7/0x7a0
[467358.751003]        up+0x4e/0x60
[467358.751006]        __up_console_sem+0x54/0x70
[467358.751010]        console_unlock+0x2d4/0x2e0
[467358.751013]        vprintk_emit+0x17a/0x3b0
[467358.751016]        devkmsg_emit.constprop.0+0xab/0xde
[467358.751019]        devkmsg_write.cold+0x2d/0x57
[467358.751022]        do_iter_readv_writev+0x161/0x210
[467358.751026]        do_iter_write+0xd8/0x300
[467358.751029]        vfs_writev+0x172/0x3b0
[467358.751032]        do_writev+0xd4/0x200
[467358.751034]        do_syscall_64+0x3a/0xc0
[467358.751038]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[467358.751042] 
                -> #0 ((console_sem).lock){-.-.}-{2:2}:
[467358.751046]        __lock_acquire+0x1a46/0x2d90
[467358.751050]        lock_acquire+0x16a/0x410
[467358.751053]        _raw_spin_lock_irqsave+0x47/0x70
[467358.751056]        down_trylock+0x11/0x50
[467358.751059]        __down_trylock_console_sem+0x2f/0xa0
[467358.751062]        vprintk_emit+0x153/0x3b0
[467358.751065]        _printk+0xb2/0xe5
[467358.751067]        lockdep_rcu_suspicious+0x38/0x109
[467358.751071]        get_callchain_entry+0x128/0x180
[467358.751075]        get_perf_callchain+0x9f/0x2d0
[467358.751077]        perf_callchain+0xc3/0xe0
[467358.751081]        setup_pebs_fixed_sample_data+0x64f/0x7f0
[467358.751085]        intel_pmu_drain_pebs_nhm+0x77e/0xa00
[467358.751088]        intel_pmu_drain_pebs_buffer+0x8e/0xd0
[467358.751090]        intel_pmu_auto_reload_read+0x3f/0x60
[467358.751093]        __perf_event_read+0x19c/0x3d0
[467358.751096]        __flush_smp_call_function_queue+0x108/0x2e0
[467358.751102]        flush_smp_call_function_queue+0x9f/0xf0
[467358.751105]        do_idle+0x261/0x3e0
[467358.751108]        cpu_startup_entry+0x19/0x20
[467358.751111]        start_secondary+0x15d/0x160
[467358.751115]        secondary_startup_64_no_verify+0xce/0xdb
[467358.751118] 
                other info that might help us debug this:

[467358.751119] Chain exists of:
                  (console_sem).lock --> &rq->__lock --> &cpuctx_lock

[467358.751124]  Possible unsafe locking scenario:

[467358.751125]        CPU0                    CPU1
[467358.751125]        ----                    ----
[467358.751126]   lock(&cpuctx_lock);
[467358.751128]                                lock(&rq->__lock);
[467358.751130]                                lock(&cpuctx_lock);
[467358.751132]   lock((console_sem).lock);
[467358.751134] 
                 *** DEADLOCK ***

[467358.751134] 1 lock held by swapper/6/0:
[467358.751136]  #0: ffffe8ffffd07de0 (&cpuctx_lock){-.-.}-{2:2}, at: __perf_event_read+0xcb/0x3d0
[467358.751143] 
                stack backtrace:
[467358.751145] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W          6.1.0-rc1 #176
[467358.751148] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
[467358.751150] Call Trace:
[467358.751152]  <TASK>
[467358.751154]  dump_stack_lvl+0x5b/0x77
[467358.751158]  check_noncircular+0x1ed/0x230
[467358.751163]  ? print_circular_bug+0x110/0x110
[467358.751166]  ? format_decode+0xb2/0x6b0
[467358.751171]  ? simple_strtoul+0x10/0x10
[467358.751176]  ? lockdep_lock+0xb3/0x170
[467358.751179]  ? usage_skip+0xa0/0xa0
[467358.751182]  ? vsnprintf+0x204/0x850
[467358.751187]  __lock_acquire+0x1a46/0x2d90
[467358.751195]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[467358.751199]  ? prb_final_commit+0x47/0x60
[467358.751203]  ? vprintk_store+0x556/0x610
[467358.751209]  lock_acquire+0x16a/0x410
[467358.751213]  ? down_trylock+0x11/0x50
[467358.751217]  ? lock_downgrade+0x3c0/0x3c0
[467358.751220]  ? lock_chain_count+0x20/0x20
[467358.751225]  ? lock_chain_count+0x20/0x20
[467358.751229]  ? mark_lock+0x107/0xd00
[467358.751234]  _raw_spin_lock_irqsave+0x47/0x70
[467358.751238]  ? down_trylock+0x11/0x50
[467358.751241]  down_trylock+0x11/0x50
[467358.751245]  ? _printk+0xb2/0xe5
[467358.751247]  __down_trylock_console_sem+0x2f/0xa0
[467358.751251]  vprintk_emit+0x153/0x3b0
[467358.751257]  _printk+0xb2/0xe5
[467358.751260]  ? em_dev_register_perf_domain.cold+0xe3/0xe3
[467358.751267]  ? lockdep_rcu_suspicious+0x25/0x109
[467358.751272]  lockdep_rcu_suspicious+0x38/0x109
[467358.751277]  get_callchain_entry+0x128/0x180
[467358.751282]  get_perf_callchain+0x9f/0x2d0
[467358.751286]  ? put_callchain_entry+0x50/0x50
[467358.751289]  ? perf_output_begin+0x305/0x610
[467358.751293]  ? lock_is_held_type+0xe3/0x140
[467358.751299]  ? perf_event_update_userpage+0x2a1/0x420
[467358.751305]  perf_callchain+0xc3/0xe0
[467358.751310]  setup_pebs_fixed_sample_data+0x64f/0x7f0
[467358.751316]  intel_pmu_drain_pebs_nhm+0x77e/0xa00
[467358.751325]  ? intel_pmu_pebs_event_update_no_drain+0x80/0x80
[467358.751329]  ? perf_trace_run_bpf_submit+0x100/0x100
[467358.751335]  ? mark_lock+0x107/0xd00
[467358.751338]  ? mark_lock+0x107/0xd00
[467358.751342]  ? mark_lock+0x107/0xd00
[467358.751345]  ? mark_lock+0x107/0xd00
[467358.751350]  ? lock_chain_count+0x20/0x20
[467358.751355]  ? mark_lock+0x107/0xd00
[467358.751357]  ? lock_chain_count+0x20/0x20
[467358.751365]  ? lock_chain_count+0x20/0x20
[467358.751375]  intel_pmu_drain_pebs_buffer+0x8e/0xd0
[467358.751379]  ? intel_bts_interrupt+0x1c0/0x1c0
[467358.751384]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[467358.751396]  ? find_held_lock+0x83/0xa0
[467358.751402]  ? lock_acquire+0x16a/0x410
[467358.751405]  ? lock_acquire+0x17a/0x410
[467358.751409]  ? sched_clock_cpu+0x63/0x1d0
[467358.751414]  ? sugov_start+0x270/0x270
[467358.751417]  ? do_raw_spin_lock+0x119/0x1b0
[467358.751421]  ? lock_is_held_type+0xe3/0x140
[467358.751425]  ? intel_pmu_lbr_disable_all+0x3c/0xe0
[467358.751429]  intel_pmu_auto_reload_read+0x3f/0x60
[467358.751432]  __perf_event_read+0x19c/0x3d0
[467358.751437]  __flush_smp_call_function_queue+0x108/0x2e0
[467358.751441]  ? __perf_read_group_add+0x4d0/0x4d0
[467358.751445]  flush_smp_call_function_queue+0x9f/0xf0
[467358.751448]  do_idle+0x261/0x3e0
[467358.751452]  ? arch_cpu_idle_exit+0x40/0x40
[467358.751459]  cpu_startup_entry+0x19/0x20
[467358.751462]  start_secondary+0x15d/0x160
[467358.751466]  secondary_startup_64_no_verify+0xce/0xdb
[467358.751473]  </TASK>
[467359.511229] =============================
[467359.515337] WARNING: suspicious RCU usage
[467359.519445] 6.1.0-rc1 #176 Tainted: G        W         
[467359.524779] -----------------------------
[467359.528892] kernel/events/callchain.c:161 suspicious 
rcu_dereference_check() usage!
[467359.536653] 
                other info that might help us debug this:

[467359.544922] 
                rcu_scheduler_active = 2, debug_locks = 1
[467359.551639] 1 lock held by swapper/6/0:
[467359.555577]  #0: ffffe8ffffd07de0 (&cpuctx_lock){-.-.}-{2:2}, at: 
__perf_event_read+0xcb/0x3d0
[467359.564303] 
                stack backtrace:
[467359.568848] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W          
6.1.0-rc1 #176
[467359.576779] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 
01/26/2014
[467359.584277] Call Trace:
[467359.586829]  <TASK>
[467359.589037]  dump_stack_lvl+0x5b/0x77
[467359.592800]  get_callchain_entry+0x128/0x180
[467359.597179]  get_perf_callchain+0x9f/0x2d0
[467359.601382]  ? put_callchain_entry+0x50/0x50
[467359.605749]  ? perf_output_begin+0x305/0x610
[467359.610119]  ? lock_is_held_type+0xe3/0x140
[467359.614408]  ? perf_event_update_userpage+0x2a1/0x420
[467359.619564]  perf_callchain+0xc3/0xe0
[467359.623325]  setup_pebs_fixed_sample_data+0x64f/0x7f0
[467359.628488]  intel_pmu_drain_pebs_nhm+0x77e/0xa00
[467359.633296]  ? intel_pmu_pebs_event_update_no_drain+0x80/0x80
[467359.639145]  ? perf_trace_run_bpf_submit+0x100/0x100
[467359.644214]  ? mark_lock+0x107/0xd00
[467359.647893]  ? mark_lock+0x107/0xd00
[467359.651572]  ? mark_lock+0x107/0xd00
[467359.655252]  ? mark_lock+0x107/0xd00
[467359.658936]  ? lock_chain_count+0x20/0x20
[467359.663052]  ? mark_lock+0x107/0xd00
[467359.666736]  ? lock_chain_count+0x20/0x20
[467359.670855]  ? lock_chain_count+0x20/0x20
[467359.674974]  intel_pmu_drain_pebs_buffer+0x8e/0xd0
[467359.679869]  ? intel_bts_interrupt+0x1c0/0x1c0
[467359.684420]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[467359.689663]  ? find_held_lock+0x83/0xa0
[467359.693604]  ? lock_acquire+0x16a/0x410
[467359.697547]  ? lock_acquire+0x17a/0x410
[467359.701489]  ? sched_clock_cpu+0x63/0x1d0
[467359.705608]  ? sugov_start+0x270/0x270
[467359.709464]  ? do_raw_spin_lock+0x119/0x1b0
[467359.713753]  ? lock_is_held_type+0xe3/0x140
[467359.718044]  ? intel_pmu_lbr_disable_all+0x3c/0xe0
[467359.722941]  intel_pmu_auto_reload_read+0x3f/0x60
[467359.727749]  __perf_event_read+0x19c/0x3d0
[467359.731954]  __flush_smp_call_function_queue+0x108/0x2e0
[467359.737371]  ? __perf_read_group_add+0x4d0/0x4d0
[467359.742095]  flush_smp_call_function_queue+0x9f/0xf0
[467359.747158]  do_idle+0x261/0x3e0
[467359.750493]  ? arch_cpu_idle_exit+0x40/0x40
[467359.754787]  cpu_startup_entry+0x19/0x20
[467359.758820]  start_secondary+0x15d/0x160
[467359.762851]  secondary_startup_64_no_verify+0xce/0xdb
[467359.768011]  </TASK>

