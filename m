Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED10C6CD64F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjC2JY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC2JYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:24:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB70211D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2AFZRsvHurvK7J8T5nxjzsB48UuQApENM6LGQRgbzck=; b=UzZFYlk2Yz391/yrjHv+ArgARg
        4FfDjCHx/oYovCA1kiC72ptnZpHBJlawn718aFvilwid8nK4sNXnVJxMw7stkPjp3skl85Hjhokta
        WBwkptvbIMMccWpgLhfAJiWUJwm1lDiExyySU7qvJkeJsV2dTAzhRtRqiniT58pJ9oR44vGo2qf1D
        Kg5ooaZbbFtLW+RLdUdB3Bgd51FK/YkHsb8dxZiWlsNX5NHB1RuMY4Uew3A7De1ugM75/njJHUA3S
        YYZDMrpq7jSej4vvqsZYzT91FkHy0twWh549Nw2ijR4Vd4V1BRjkjbyol95F10HdusXx2XVadIm2s
        AiLE68kQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phS2l-006ob9-2n;
        Wed, 29 Mar 2023 09:24:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B76E73000E6;
        Wed, 29 Mar 2023 11:24:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E57F201D9955; Wed, 29 Mar 2023 11:24:33 +0200 (CEST)
Date:   Wed, 29 Mar 2023 11:24:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     tglx@linutronix.de, songliubraving@fb.com,
        linux-kernel@vger.kernel.org, frederic@kernel.org,
        heng.su@intel.com, lkp@intel.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [Syzkaller & bisect] There is "soft lockup in
 sys_perf_event_open" BUG in v6.3-rc4 kernel
Message-ID: <20230329092433.GA83892@hirez.programming.kicks-ass.net>
References: <ZCP8vkW6xeQJIMLs@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCP8vkW6xeQJIMLs@xpf.sh.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 04:54:22PM +0800, Pengfei Xu wrote:

> "
> 79df45731da68772d2285265864a52c900b8c65f
> perf/core: Allow ftrace for functions in kernel/event/core.c
> "
> After reverted above commit on top of tip tag perf-core-2021-10-31, this issue
> was gone.

Glorious recursion... Song, I'm tempted to indeed revert that patch
again.

> [   24.618533] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=330 'systemd'
> [   56.504281] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [repro:516]
> [   56.507013] Modules linked in:
> [   56.507699] irq event stamp: 684720
> [   56.508318] hardirqs last  enabled at (684719): [<ffffffff8107247c>] __text_poke+0x2ec/0x4e0
> [   56.509577] hardirqs last disabled at (684720): [<ffffffff82f937a3>] sysvec_apic_timer_interrupt+0x13/0xe0
> [   56.510993] softirqs last  enabled at (472178): [<ffffffff82fb71a9>] __do_softirq+0x2d9/0x3c3
> [   56.512283] softirqs last disabled at (472151): [<ffffffff811266f4>] irq_exit_rcu+0xc4/0x100
> [   56.513543] CPU: 0 PID: 516 Comm: repro Not tainted 6.3.0-rc4-197b6b60ae7b+ #1
> [   56.514647] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   56.516213] RIP: 0010:debug_lockdep_rcu_enabled+0x0/0x40
> [   56.517098] Code: c7 c7 a3 d6 96 83 e8 4f 0e 00 00 65 c7 05 e4 c3 08 7d 00 00 00 00 eb ba 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 8b 05 be 65 0d 01 85 c0 74 2b 8b 05 4c cd 0d 01 85 c0
> [   56.519522] RSP: 0018:ffffc90000fbb260 EFLAGS: 00000246
> [   56.520439] RAX: 0000000000000000 RBX: ffff888014599aa8 RCX: ffffffff81353c4d
> [   56.521513] RDX: 0000000000000000 RSI: ffff888013bc4680 RDI: 0000000000000002
> [   56.522585] RBP: ffffc90000fbb2a8 R08: ffffc90000fbb820 R09: ffffc90000fbb818
> [   56.523683] R10: ffffc90000fbb7f0 R11: 0000000000000000 R12: ffffc90000fbb2b8
> [   56.524766] R13: fffffffffffffdff R14: 0000000000000000 R15: ffffffff81353960
> [   56.525841] FS:  00007fe17f501740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [   56.527044] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   56.527977] CR2: 00007ffd57376000 CR3: 000000000af0a003 CR4: 0000000000770ef0
> [   56.529038] PKRU: 55555554
> [   56.529543] Call Trace:
> [   56.530040]  <TASK>
> [   56.530496]  ? arch_ftrace_ops_list_func+0x1b6/0x360
> [   56.531339]  ? perf_trace_buf_alloc+0x41/0x110
> [   56.532148]  ? perf_swevent_get_recursion_context+0x4/0xe0
> [   56.533132]  ? perf_tp_event+0x164/0x880
> [   56.533853]  ftrace_call+0x5/0x44
> [   56.534612]  ? write_comp_data+0x2f/0x90
> [   56.535444]  ? perf_trace_buf_alloc+0x2a/0x110
> [   56.536301]  ? perf_swevent_get_recursion_context+0x9/0xe0
> [   56.537201]  ? write_comp_data+0x2f/0x90
> [   56.537958]  perf_swevent_get_recursion_context+0x9/0xe0
> [   56.538848]  perf_trace_buf_alloc+0x41/0x110
> [   56.539644]  ? perf_swevent_get_recursion_context+0x9/0xe0
> [   56.540564]  ? perf_trace_buf_alloc+0x41/0x110
> [   56.541415]  ? __pfx_perf_swevent_event+0x10/0x10
> [   56.542233]  perf_ftrace_function_call+0x28f/0x340
> [   56.543070]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [   56.544273]  ? arch_ftrace_ops_list_func+0x2c6/0x360
> [   56.545328]  ? __pfx_perf_ftrace_function_call+0x10/0x10
> [   56.546221]  arch_ftrace_ops_list_func+0x2c6/0x360
> [   56.547029]  ? perf_tp_event+0x164/0x880
> [   56.547774]  ? __pfx_perf_swevent_event+0x10/0x10
> [   56.548730]  ftrace_call+0x5/0x44
> [   56.549407]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [   56.550239]  ? write_comp_data+0x2f/0x90
> [   56.551228]  ? perf_swevent_event+0x5/0x170
> [   56.552001]  ? write_comp_data+0x2f/0x90
> [   56.552767]  perf_swevent_event+0x5/0x170
> [   56.553500]  perf_tp_event+0x164/0x880
> [   56.554219]  ? perf_swevent_event+0x5/0x170
> [   56.554959]  ? perf_tp_event+0x164/0x880
> [   56.555959]  ? arch_ftrace_ops_list_func+0x2c6/0x360
> [   56.556843]  ? write_comp_data+0x2f/0x90
> [   56.557646]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [   56.558541]  ? arch_ftrace_ops_list_func+0x207/0x360
> [   56.559393]  ? perf_ftrace_function_call+0x2d2/0x340
> [   56.560256]  ? perf_tp_event+0x4/0x880
> [   56.561026]  ? _raw_spin_lock+0x4/0x50
> [   56.561723]  ? __get_locked_pte+0x96/0xe0
> [   56.562493]  ? ftrace_call+0x5/0x44
> [   56.563335]  ? write_comp_data+0x2f/0x90
> [   56.564308]  ? _raw_spin_lock+0x4/0x50
> [   56.564988]  ? __get_locked_pte+0x96/0xe0
> [   56.565708]  perf_ftrace_function_call+0x2d2/0x340
> [   56.566516]  ? perf_tp_event+0x9/0x880
> [   56.567223]  ? perf_ftrace_function_call+0x2d2/0x340
> [   56.568079]  ? perf_tp_event+0x9/0x880
> [   56.568741]  ? perf_ftrace_function_call+0x2d2/0x340
> [   56.570049]  ? 0xffffffffa02010b1
> [   56.570919]  0xffffffffa02010b1
> [   56.571678]  ? ftrace_call+0x5/0x44
> [   56.572420]  ? pmd_page_vaddr+0x2b/0x80
> [   56.573193]  ? _raw_spin_lock+0x9/0x50
> [   56.573987]  _raw_spin_lock+0x9/0x50
> [   56.574672]  __get_locked_pte+0x96/0xe0
> [   56.575411]  ? _raw_spin_lock+0x9/0x50
> [   56.576100]  ? __get_locked_pte+0x96/0xe0
> [   56.576924]  ? __pfx__regmap_raw_write_impl+0x10/0x10
> [   56.577816]  __text_poke+0xf4/0x4e0
> [   56.578489]  ? __pfx__regmap_raw_write_impl+0x10/0x10
> [   56.579399]  ? __pfx_text_poke_memcpy+0x10/0x10
> [   56.580134]  ? lock_is_held_type+0xe6/0x140
> [   56.580902]  ? __pfx__regmap_raw_write_impl+0x10/0x10
> [   56.581822]  text_poke+0x3a/0x60
> [   56.582538]  text_poke_bp_batch+0x94/0x310
> [   56.583263]  ? text_poke_bp_batch+0x5/0x310
> [   56.584081]  ? __pfx_virtblk_update_cache_mode+0x10/0x10
> [   56.585069]  text_poke_queue+0x93/0xb0
> [   56.585874]  ftrace_replace_code+0x12a/0x1b0
> [   56.586789]  ftrace_modify_all_code+0x1b9/0x2a0
> [   56.587701]  arch_ftrace_update_code+0xd/0x20
> [   56.588468]  ftrace_startup_enable+0x67/0xa0
> [   56.589291]  ftrace_startup+0x124/0x200
> [   56.590082]  register_ftrace_function_nolock+0x43/0x90
> [   56.590991]  register_ftrace_function+0x1eb/0x280
> [   56.591873]  ? __sanitizer_cov_trace_switch+0x57/0xa0
> [   56.592835]  perf_ftrace_event_register+0xcd/0xf0
> [   56.593735]  perf_trace_event_init+0x98/0x4b0
> [   56.594639]  perf_trace_init+0xde/0x170
> [   56.595449]  perf_tp_event_init+0x60/0xa0
> [   56.596216]  perf_try_init_event+0x88/0x280
> [   56.597094]  perf_event_alloc+0xe25/0x1c00
> [   56.597900]  ? perf_event_alloc+0x5/0x1c00
> [   56.598846]  __do_sys_perf_event_open+0x3b6/0x1910
> [   56.600490]  __x64_sys_perf_event_open+0x2f/0x40
> [   56.601330]  do_syscall_64+0x3b/0x90
> [   56.602067]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   56.602902] RIP: 0033:0x7fe17f62659d
> [   56.603610] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48
> [   56.606099] RSP: 002b:00007ffd572b7f58 EFLAGS: 00000206 ORIG_RAX: 000000000000012a
> [   56.607348] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe17f62659d
> [   56.608429] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000020000100
> [   56.609512] RBP: 00007ffd572b7f70 R08: 0000000000000000 R09: 00007ffd572b7f70
> [   56.610604] R10: 00000000ffffffff R11: 0000000000000206 R12: 0000000000401180
> [   56.611719] R13: 00007ffd572b8090 R14: 0000000000000000 R15: 0000000000000000
> [   56.613326]  </TASK>
