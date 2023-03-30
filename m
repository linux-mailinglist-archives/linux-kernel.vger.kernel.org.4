Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2A6D10F4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjC3VjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjC3VjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:39:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF9D336;
        Thu, 30 Mar 2023 14:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B264FB82A36;
        Thu, 30 Mar 2023 21:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C7EDC433EF;
        Thu, 30 Mar 2023 21:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680212354;
        bh=4ub0RYNrvI4aTyW05tgLlOy+GD7K6F9mlaY0KO0r0WY=;
        h=Reply-To:From:To:Subject:Date:From;
        b=l88VCQ825JVpojRaOJtm9MiLkWe5yyMTGv+nyC3Jay3UbvQroPM9Cg8L50t+Oy2Ou
         BgCGcxDRgXRR4DI6xXzzzvUVAN3/NhSoKvr/wmKcNGdrzbxJQRlSJRSnvQXx5+yfhG
         kboIHZ+wCgygkadpofQ8K8+ojgJmo4yugYEwaReCPJ0wPVcDam0SUU1reHgmMaeIFc
         Fwmzh+F9joCp90HUdlxJ3/a+LS3OCeFKJUTfDlvt0ofSakWUcD+GlCgRsL5vPxxsRh
         gdwgAVTZ5qk0G8k1yZU+VkinrfFSOI72MH529LnVTVL/gqWLvaGuxqub4JbEX33b4a
         9d1OleRP4aV1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D76CE2A03F;
        Thu, 30 Mar 2023 21:39:14 +0000 (UTC)
Reply-To: pengfei.xu@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, pengfei.xu@intel.com, bugs@lists.linux.dev,
        linux-kernel@vger.kernel.org, mricon@kernel.org, mingo@redhat.com
Message-ID: <20230330-b217267c0-15b9c837ad2e@bugzilla.kernel.org>
Subject: [Syzkaller & bisect] There is "soft lockup in sys_perf_event_open"
 BUG in v6.3-rc4 kernel
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Thu, 30 Mar 2023 21:39:14 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pengfei.xu@intel.com writes via Kernel.org Bugzilla:

It's one special BUG and found on ADL-N intel x86 platform.
This issue manifests differently on ADL-S platform.

So do follow narrow down job on ADL-N.
ADL-N cpu info: Intel(R) Core(TM) i3-N305
"
cpu family      : 6
model           : 190
model name      : Intel(R) Core(TM) i3-N305
stepping        : 0
microcode       : 0xc
"

There is "soft lockup in sys_perf_event_open" BUG in v6.3-rc4 kernel in guest
on ADL-N platform.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230329_020715_sys_perf_event_open
VM machine info: https://github.com/xupengfe/syzkaller_logs/blob/main/230329_020715_sys_perf_event_open/machineInfo0
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230329_020715_sys_perf_event_open/repro.c
Syzkaller analysis repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/230329_020715_sys_perf_event_open/repro.report
Syzkaller analysis repro.stats: https://raw.githubusercontent.com/xupengfe/syzkaller_logs/main/230329_020715_sys_perf_event_open/repro.stats
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230329_020715_sys_perf_event_open/kconfig_origin
v6.3-rc4 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230329_020715_sys_perf_event_open/197b6b60ae7bc51dd0814953c562833143b292aa_dmesg.log
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230329_020715_sys_perf_event_open/bisect_info.log

It could be reproduced in 180s.
Bisected and found the first bad commit:
"
91e1c99e175ae6bb6be765c6fcd40e869f8f6aee
Merge tag 'perf-core-2021-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
"


It's from tip kernel, so do the advanced bisect between tip repo tag
"perf-core-2021-10-31" and "perf-core-2021-08-30".
All tip bisect info: https://github.com/xupengfe/syzkaller_logs/tree/main/dev_branch/230329_140445_sys_perf_event_open
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/dev_branch/230329_140445_sys_perf_event_open/bisect_info.log

And bisected found that the first bad commit in tip repo was:
"
79df45731da68772d2285265864a52c900b8c65f
perf/core: Allow ftrace for functions in kernel/event/core.c
"
After reverted above commit on top of tip tag perf-core-2021-10-31, this issue
was gone.

I hope all the info is helpful.

v6.3-rc4 issue dmesg info is as follow:
"
[   24.618533] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=330 'systemd'
[   56.504281] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [repro:516]
[   56.507013] Modules linked in:
[   56.507699] irq event stamp: 684720
[   56.508318] hardirqs last  enabled at (684719): [<ffffffff8107247c>] __text_poke+0x2ec/0x4e0
[   56.509577] hardirqs last disabled at (684720): [<ffffffff82f937a3>] sysvec_apic_timer_interrupt+0x13/0xe0
[   56.510993] softirqs last  enabled at (472178): [<ffffffff82fb71a9>] __do_softirq+0x2d9/0x3c3
[   56.512283] softirqs last disabled at (472151): [<ffffffff811266f4>] irq_exit_rcu+0xc4/0x100
[   56.513543] CPU: 0 PID: 516 Comm: repro Not tainted 6.3.0-rc4-197b6b60ae7b+ #1
[   56.514647] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   56.516213] RIP: 0010:debug_lockdep_rcu_enabled+0x0/0x40
[   56.517098] Code: c7 c7 a3 d6 96 83 e8 4f 0e 00 00 65 c7 05 e4 c3 08 7d 00 00 00 00 eb ba 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 8b 05 be 65 0d 01 85 c0 74 2b 8b 05 4c cd 0d 01 85 c0
[   56.519522] RSP: 0018:ffffc90000fbb260 EFLAGS: 00000246
[   56.520439] RAX: 0000000000000000 RBX: ffff888014599aa8 RCX: ffffffff81353c4d
[   56.521513] RDX: 0000000000000000 RSI: ffff888013bc4680 RDI: 0000000000000002
[   56.522585] RBP: ffffc90000fbb2a8 R08: ffffc90000fbb820 R09: ffffc90000fbb818
[   56.523683] R10: ffffc90000fbb7f0 R11: 0000000000000000 R12: ffffc90000fbb2b8
[   56.524766] R13: fffffffffffffdff R14: 0000000000000000 R15: ffffffff81353960
[   56.525841] FS:  00007fe17f501740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   56.527044] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.527977] CR2: 00007ffd57376000 CR3: 000000000af0a003 CR4: 0000000000770ef0
[   56.529038] PKRU: 55555554
[   56.529543] Call Trace:
[   56.530040]  <TASK>
[   56.530496]  ? arch_ftrace_ops_list_func+0x1b6/0x360
[   56.531339]  ? perf_trace_buf_alloc+0x41/0x110
[   56.532148]  ? perf_swevent_get_recursion_context+0x4/0xe0
[   56.533132]  ? perf_tp_event+0x164/0x880
[   56.533853]  ftrace_call+0x5/0x44
[   56.534612]  ? write_comp_data+0x2f/0x90
[   56.535444]  ? perf_trace_buf_alloc+0x2a/0x110
[   56.536301]  ? perf_swevent_get_recursion_context+0x9/0xe0
[   56.537201]  ? write_comp_data+0x2f/0x90
[   56.537958]  perf_swevent_get_recursion_context+0x9/0xe0
[   56.538848]  perf_trace_buf_alloc+0x41/0x110
[   56.539644]  ? perf_swevent_get_recursion_context+0x9/0xe0
[   56.540564]  ? perf_trace_buf_alloc+0x41/0x110
[   56.541415]  ? __pfx_perf_swevent_event+0x10/0x10
[   56.542233]  perf_ftrace_function_call+0x28f/0x340
[   56.543070]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   56.544273]  ? arch_ftrace_ops_list_func+0x2c6/0x360
[   56.545328]  ? __pfx_perf_ftrace_function_call+0x10/0x10
[   56.546221]  arch_ftrace_ops_list_func+0x2c6/0x360
[   56.547029]  ? perf_tp_event+0x164/0x880
[   56.547774]  ? __pfx_perf_swevent_event+0x10/0x10
[   56.548730]  ftrace_call+0x5/0x44
[   56.549407]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   56.550239]  ? write_comp_data+0x2f/0x90
[   56.551228]  ? perf_swevent_event+0x5/0x170
[   56.552001]  ? write_comp_data+0x2f/0x90
[   56.552767]  perf_swevent_event+0x5/0x170
[   56.553500]  perf_tp_event+0x164/0x880
[   56.554219]  ? perf_swevent_event+0x5/0x170
[   56.554959]  ? perf_tp_event+0x164/0x880
[   56.555959]  ? arch_ftrace_ops_list_func+0x2c6/0x360
[   56.556843]  ? write_comp_data+0x2f/0x90
[   56.557646]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   56.558541]  ? arch_ftrace_ops_list_func+0x207/0x360
[   56.559393]  ? perf_ftrace_function_call+0x2d2/0x340
[   56.560256]  ? perf_tp_event+0x4/0x880
[   56.561026]  ? _raw_spin_lock+0x4/0x50
[   56.561723]  ? __get_locked_pte+0x96/0xe0
[   56.562493]  ? ftrace_call+0x5/0x44
[   56.563335]  ? write_comp_data+0x2f/0x90
[   56.564308]  ? _raw_spin_lock+0x4/0x50
[   56.564988]  ? __get_locked_pte+0x96/0xe0
[   56.565708]  perf_ftrace_function_call+0x2d2/0x340
[   56.566516]  ? perf_tp_event+0x9/0x880
[   56.567223]  ? perf_ftrace_function_call+0x2d2/0x340
[   56.568079]  ? perf_tp_event+0x9/0x880
[   56.568741]  ? perf_ftrace_function_call+0x2d2/0x340
[   56.570049]  ? 0xffffffffa02010b1
[   56.570919]  0xffffffffa02010b1
[   56.571678]  ? ftrace_call+0x5/0x44
[   56.572420]  ? pmd_page_vaddr+0x2b/0x80
[   56.573193]  ? _raw_spin_lock+0x9/0x50
[   56.573987]  _raw_spin_lock+0x9/0x50
[   56.574672]  __get_locked_pte+0x96/0xe0
[   56.575411]  ? _raw_spin_lock+0x9/0x50
[   56.576100]  ? __get_locked_pte+0x96/0xe0
[   56.576924]  ? __pfx__regmap_raw_write_impl+0x10/0x10
[   56.577816]  __text_poke+0xf4/0x4e0
[   56.578489]  ? __pfx__regmap_raw_write_impl+0x10/0x10
[   56.579399]  ? __pfx_text_poke_memcpy+0x10/0x10
[   56.580134]  ? lock_is_held_type+0xe6/0x140
[   56.580902]  ? __pfx__regmap_raw_write_impl+0x10/0x10
[   56.581822]  text_poke+0x3a/0x60
[   56.582538]  text_poke_bp_batch+0x94/0x310
[   56.583263]  ? text_poke_bp_batch+0x5/0x310
[   56.584081]  ? __pfx_virtblk_update_cache_mode+0x10/0x10
[   56.585069]  text_poke_queue+0x93/0xb0
[   56.585874]  ftrace_replace_code+0x12a/0x1b0
[   56.586789]  ftrace_modify_all_code+0x1b9/0x2a0
[   56.587701]  arch_ftrace_update_code+0xd/0x20
[   56.588468]  ftrace_startup_enable+0x67/0xa0
[   56.589291]  ftrace_startup+0x124/0x200
[   56.590082]  register_ftrace_function_nolock+0x43/0x90
[   56.590991]  register_ftrace_function+0x1eb/0x280
[   56.591873]  ? __sanitizer_cov_trace_switch+0x57/0xa0
[   56.592835]  perf_ftrace_event_register+0xcd/0xf0
[   56.593735]  perf_trace_event_init+0x98/0x4b0
[   56.594639]  perf_trace_init+0xde/0x170
[   56.595449]  perf_tp_event_init+0x60/0xa0
[   56.596216]  perf_try_init_event+0x88/0x280
[   56.597094]  perf_event_alloc+0xe25/0x1c00
[   56.597900]  ? perf_event_alloc+0x5/0x1c00
[   56.598846]  __do_sys_perf_event_open+0x3b6/0x1910
[   56.600490]  __x64_sys_perf_event_open+0x2f/0x40
[   56.601330]  do_syscall_64+0x3b/0x90
[   56.602067]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   56.602902] RIP: 0033:0x7fe17f62659d
[   56.603610] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48
[   56.606099] RSP: 002b:00007ffd572b7f58 EFLAGS: 00000206 ORIG_RAX: 000000000000012a
[   56.607348] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe17f62659d
[   56.608429] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000020000100
[   56.609512] RBP: 00007ffd572b7f70 R08: 0000000000000000 R09: 00007ffd572b7f70
[   56.610604] R10: 00000000ffffffff R11: 0000000000000206 R12: 0000000000401180
[   56.611719] R13: 00007ffd572b8090 R14: 0000000000000000 R15: 0000000000000000
[   56.613326]  </TASK>
[   56.613804] Kernel panic - not syncing: softlockup: hung tasks
[   56.614714] CPU: 0 PID: 516 Comm: repro Tainted: G             L     6.3.0-rc4-197b6b60ae7b+ #1
[   56.616000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   56.617629] Call Trace:
[   56.618142]  <IRQ>
[   56.618614]  dump_stack_lvl+0xa9/0x110
[   56.619442]  dump_stack+0x19/0x20
[   56.620120]  panic+0x4fd/0x520
[   56.620904]  ? watchdog_timer_fn+0x31e/0x390
[   56.621845]  watchdog_timer_fn+0x337/0x390
[   56.622694]  ? __pfx_watchdog_timer_fn+0x10/0x10
[   56.623512]  __hrtimer_run_queues+0x2ed/0x5d0
[   56.624636]  hrtimer_interrupt+0x134/0x2d0
[   56.625643]  __sysvec_apic_timer_interrupt+0x9c/0x1d0
[   56.626550]  sysvec_apic_timer_interrupt+0xab/0xe0
[   56.627400]  </IRQ>
[   56.627866]  <TASK>
[   56.628392]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[   56.629248] RIP: 0010:debug_lockdep_rcu_enabled+0x0/0x40
[   56.630109] Code: c7 c7 a3 d6 96 83 e8 4f 0e 00 00 65 c7 05 e4 c3 08 7d 00 00 00 00 eb ba 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 8b 05 be 65 0d 01 85 c0 74 2b 8b 05 4c cd 0d 01 85 c0
[   56.632509] RSP: 0018:ffffc90000fbb260 EFLAGS: 00000246
[   56.633423] RAX: 0000000000000000 RBX: ffff888014599aa8 RCX: ffffffff81353c4d
[   56.634486] RDX: 0000000000000000 RSI: ffff888013bc4680 RDI: 0000000000000002
[   56.635563] RBP: ffffc90000fbb2a8 R08: ffffc90000fbb820 R09: ffffc90000fbb818
[   56.636613] R10: ffffc90000fbb7f0 R11: 0000000000000000 R12: ffffc90000fbb2b8
[   56.637633] R13: fffffffffffffdff R14: 0000000000000000 R15: ffffffff81353960
[   56.638668]  ? __pfx_perf_ftrace_function_call+0x10/0x10
[   56.639765]  ? perf_ftrace_function_call+0x2ed/0x340
[   56.640788]  ? arch_ftrace_ops_list_func+0x1b6/0x360
[   56.641593]  ? perf_trace_buf_alloc+0x41/0x110
[   56.642383]  ? perf_swevent_get_recursion_context+0x4/0xe0
[   56.643378]  ? perf_tp_event+0x164/0x880
[   56.644134]  ftrace_call+0x5/0x44
[   56.644938]  ? write_comp_data+0x2f/0x90
[   56.645777]  ? perf_trace_buf_alloc+0x2a/0x110
[   56.646658]  ? perf_swevent_get_recursion_context+0x9/0xe0
[   56.647599]  ? write_comp_data+0x2f/0x90
[   56.648412]  perf_swevent_get_recursion_context+0x9/0xe0
[   56.649291]  perf_trace_buf_alloc+0x41/0x110
[   56.650080]  ? perf_swevent_get_recursion_context+0x9/0xe0
[   56.650960]  ? perf_trace_buf_alloc+0x41/0x110
[   56.651792]  ? __pfx_perf_swevent_event+0x10/0x10
[   56.652589]  perf_ftrace_function_call+0x28f/0x340
[   56.653430]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   56.654585]  ? arch_ftrace_ops_list_func+0x2c6/0x360
[   56.655609]  ? __pfx_perf_ftrace_function_call+0x10/0x10
[   56.656506]  arch_ftrace_ops_list_func+0x2c6/0x360
[   56.657304]  ? perf_tp_event+0x164/0x880
[   56.658034]  ? __pfx_perf_swevent_event+0x10/0x10
[   56.658973]  ftrace_call+0x5/0x44
[   56.659637]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   56.660535]  ? write_comp_data+0x2f/0x90
[   56.661489]  ? perf_swevent_event+0x5/0x170
[   56.662242]  ? write_comp_data+0x2f/0x90
[   56.662981]  perf_swevent_event+0x5/0x170
[   56.663723]  perf_tp_event+0x164/0x880
[   56.664440]  ? perf_swevent_event+0x5/0x170
[   56.665136]  ? perf_tp_event+0x164/0x880
[   56.666067]  ? arch_ftrace_ops_list_func+0x2c6/0x360
[   56.666911]  ? write_comp_data+0x2f/0x90
[   56.667709]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   56.668575]  ? arch_ftrace_ops_list_func+0x207/0x360
[   56.669367]  ? perf_ftrace_function_call+0x2d2/0x340
[   56.670190]  ? perf_tp_event+0x4/0x880
[   56.670928]  ? _raw_spin_lock+0x4/0x50
[   56.671607]  ? __get_locked_pte+0x96/0xe0
[   56.672320]  ? ftrace_call+0x5/0x44
[   56.673117]  ? write_comp_data+0x2f/0x90
[   56.674022]  ? _raw_spin_lock+0x4/0x50
[   56.674679]  ? __get_locked_pte+0x96/0xe0
[   56.675416]  perf_ftrace_function_call+0x2d2/0x340
[   56.676199]  ? perf_tp_event+0x9/0x880
[   56.676894]  ? perf_ftrace_function_call+0x2d2/0x340
[   56.677706]  ? perf_tp_event+0x9/0x880
[   56.678367]  ? perf_ftrace_function_call+0x2d2/0x340
[   56.679685]  ? 0xffffffffa02010b1
[   56.680585]  0xffffffffa02010b1
[   56.681346]  ? ftrace_call+0x5/0x44
[   56.682076]  ? pmd_page_vaddr+0x2b/0x80
[   56.682839]  ? _raw_spin_lock+0x9/0x50
[   56.683633]  _raw_spin_lock+0x9/0x50
[   56.684306]  __get_locked_pte+0x96/0xe0
[   56.684996]  ? _raw_spin_lock+0x9/0x50
[   56.685658]  ? __get_locked_pte+0x96/0xe0
[   56.686425]  ? __pfx__regmap_raw_write_impl+0x10/0x10
[   56.687307]  __text_poke+0xf4/0x4e0
[   56.688004]  ? __pfx__regmap_raw_write_impl+0x10/0x10
[   56.688907]  ? __pfx_text_poke_memcpy+0x10/0x10
[   56.689682]  ? lock_is_held_type+0xe6/0x140
[   56.690451]  ? __pfx__regmap_raw_write_impl+0x10/0x10
[   56.691405]  text_poke+0x3a/0x60
[   56.692123]  text_poke_bp_batch+0x94/0x310
[   56.692847]  ? text_poke_bp_batch+0x5/0x310
[   56.693658]  ? __pfx_virtblk_update_cache_mode+0x10/0x10
[   56.694652]  text_poke_queue+0x93/0xb0
[   56.695469]  ftrace_replace_code+0x12a/0x1b0
[   56.696419]  ftrace_modify_all_code+0x1b9/0x2a0
[   56.697311]  arch_ftrace_update_code+0xd/0x20
[   56.698106]  ftrace_startup_enable+0x67/0xa0
[   56.698937]  ftrace_startup+0x124/0x200
[   56.699752]  register_ftrace_function_nolock+0x43/0x90
[   56.700664]  register_ftrace_function+0x1eb/0x280
[   56.701540]  ? __sanitizer_cov_trace_switch+0x57/0xa0
[   56.702553]  perf_ftrace_event_register+0xcd/0xf0
[   56.703427]  perf_trace_event_init+0x98/0x4b0
"

Thanks!
BR.
-Pengfei

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
   // You could change the bzImage_xxx as you want
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
make
make install

Thanks!

View: https://bugzilla.kernel.org/show_bug.cgi?id=217267#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

