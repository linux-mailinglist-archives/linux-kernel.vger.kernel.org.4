Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B2B68EB6B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBHJbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjBHJbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:31:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1D2976F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EE42B81C0C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EEDC433D2;
        Wed,  8 Feb 2023 09:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675848605;
        bh=3G4yI0XA8XoQJ4Zhg0OrD1fNpDD2XBca/h3vm/AoJ20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NvzUIwMw+glChC9d4CXY1YVuFCsPBoiwX8P6aF7tREnqLs9k2ePygkXxaL9RdM98W
         AyM5WUwKe81jJ3OMaKGCTVtzzgi5SB8hNwSSrNL5V40Id8JdgLJIRQFz1cnsJXI1AS
         aICR904w+Xbh9cHMOaAh03mWVItOWVBLKQhPP4tg=
Date:   Wed, 8 Feb 2023 10:30:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, heng.su@intel.com
Subject: Re: [Syzkaller & bisect] There is " __disarm_kprobe_ftrace" WARNING
 in v6.2-rc7 kernel
Message-ID: <Y+Nrmal67Fbg2fUM@kroah.com>
References: <Y+NleHouvZwDBiKY@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+NleHouvZwDBiKY@xpf.sh.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:03:52PM +0800, Pengfei Xu wrote:
> Hi Greg KH and kernel expert,
> 
> Greeting!
> 
> There is " __disarm_kprobe_ftrace" WARNING in v6.2-rc7 kernel in fault
> injection test by syzkaller:
> [   30.404796] FAULT_INJECTION: forcing a failure.

So you forced a fault and something crashed.  What were you expecting?

> [   30.404796] name failslab, interval 1, probability 0, space 0, times 1
> [   30.405595] CPU: 1 PID: 510 Comm: repro Not tainted 6.2.0-rc7-4ec5183ec486 #1
> [   30.406044] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   30.406724] Call Trace:
> [   30.406890]  <TASK>
> [   30.407032]  dump_stack_lvl+0xa7/0xdb
> [   30.407310]  dump_stack+0x19/0x1f
> [   30.407532]  should_fail_ex.cold.5+0x5/0xa
> [   30.407820]  __should_failslab+0xca/0x120
> [   30.408091]  should_failslab+0x12/0x30
> [   30.408341]  __kmem_cache_alloc_node+0x62/0x280
> [   30.408636]  ? alloc_ftrace_hash+0x4f/0x170
> [   30.408916]  kmalloc_trace+0x2e/0x120
> [   30.409161]  alloc_ftrace_hash+0x4f/0x170
> [   30.409426]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310
> [   30.409804]  ? write_comp_data+0x2f/0x90
> [   30.410078]  ftrace_set_hash+0x445/0x590
> [   30.410350]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [   30.410671]  ftrace_set_filter_ip+0xcd/0x1a0
> [   30.410967]  ? __pfx_ftrace_set_filter_ip+0x10/0x10
> [   30.411295]  ? match_dev_by_uuid+0x4/0x100
> [   30.411574]  ? unregister_ftrace_function+0x83/0x3c0
> [   30.411906]  ? __this_cpu_preempt_check+0x20/0x30
> [   30.412228]  ? write_comp_data+0x2f/0x90
> [   30.412507]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250
> [   30.412851]  disarm_kprobe+0x24a/0x2d0
> [   30.413112]  __disable_kprobe+0x2de/0x4b0
> [   30.413390]  disable_kprobe+0x31/0x80
> [   30.413643]  __disable_trace_kprobe+0xfb/0x1c0
> [   30.413965]  disable_trace_kprobe+0x1f0/0x300
> [   30.414266]  kprobe_register+0x4e/0xf0
> [   30.414528]  perf_trace_event_unreg.isra.3+0xb6/0x1f0
> [   30.414870]  perf_kprobe_destroy+0xcb/0x200
> [   30.415156]  ? __pfx_perf_kprobe_destroy+0x10/0x10
> [   30.415482]  _free_event+0x220/0x11c0
> [   30.415754]  put_event+0x4d/0x60
> [   30.415993]  perf_event_release_kernel+0x5d9/0x860
> [   30.416330]  ? __pfx_perf_event_release_kernel+0x10/0x10
> [   30.416680]  ? write_comp_data+0x2f/0x90
> [   30.416950]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [   30.417292]  ? __pfx_perf_release+0x10/0x10
> [   30.417579]  perf_release+0x40/0x50
> [   30.417830]  __fput+0x26d/0xa40
> [   30.418080]  ____fput+0x1e/0x30
> [   30.418303]  task_work_run+0x1a4/0x2d0
> [   30.418565]  ? write_comp_data+0x2f/0x90
> [   30.418836]  ? __pfx_task_work_run+0x10/0x10
> [   30.419138]  ? __this_cpu_preempt_check+0x20/0x30
> [   30.419463]  ? lockdep_hardirqs_on+0x8a/0x110
> [   30.419751]  ? exit_to_user_mode_prepare+0x100/0x210
> [   30.420080]  exit_to_user_mode_prepare+0x200/0x210
> [   30.420392]  syscall_exit_to_user_mode+0x2d/0x60
> [   30.420698]  do_syscall_64+0x4a/0x90
> [   30.420944]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   30.421282] RIP: 0033:0x7f3840f1059d
> [   30.421537] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
> [   30.422690] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> [   30.423179] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f1059d
> [   30.423630] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 0000000000000003
> [   30.424081] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19fb73c0
> [   30.424531] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401180
> [   30.424984] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 0000000000000000
> [   30.425459]  </TASK>
> [   30.425891] ------------[ cut here ]------------
> [   30.426223] Failed to disarm kprobe-ftrace at match_dev_by_uuid+0x4/0x100 (error -12)
> [   30.426785] WARNING: CPU: 1 PID: 510 at kernel/kprobes.c:1130 __disarm_kprobe_ftrace.isra.24+0x1ed/0x250
> [   30.427381] Modules linked in:
> [   30.427595] CPU: 1 PID: 510 Comm: repro Not tainted 6.2.0-rc7-4ec5183ec486 #1
> [   30.428052] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   30.428759] RIP: 0010:__disarm_kprobe_ftrace.isra.24+0x1ed/0x250
> [   30.429156] Code: 37 f5 05 01 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 64 49 8b 75 00 89 da 48 c7 c7 80 67 6f 85 e8 12 72 bf 03 <0f> 0b e9 03 a
> [   30.430300] RSP: 0018:ffff88800c387a90 EFLAGS: 00010282
> [   30.430642] RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: ffffffff813dde2e
> [   30.431124] RDX: 0000000000000000 RSI: ffff8880125e0000 RDI: 0000000000000002
> [   30.431575] RBP: ffff88800c387ab0 R08: ffffed1001870f0b R09: ffffed1001870f0b
> [   30.432028] R10: ffff88800c387857 R11: ffffed1001870f0a R12: 0000000000000000
> [   30.432483] R13: ffff88800a4a9040 R14: ffffffff875a0ea0 R15: ffff88800a4a9090
> [   30.432940] FS:  00007f3840deb740(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
> [   30.433467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   30.433847] CR2: 00007f3840e4d700 CR3: 0000000011a84001 CR4: 0000000000770ee0
> [   30.434301] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   30.434782] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> [   30.435234] PKRU: 55555554
> [   30.435418] Call Trace:
> [   30.435588]  <TASK>
> [   30.435743]  disarm_kprobe+0x24a/0x2d0
> [   30.436011]  __disable_kprobe+0x2de/0x4b0
> [   30.436295]  disable_kprobe+0x31/0x80
> [   30.436552]  __disable_trace_kprobe+0xfb/0x1c0
> [   30.436862]  disable_trace_kprobe+0x1f0/0x300
> [   30.437165]  kprobe_register+0x4e/0xf0
> [   30.437429]  perf_trace_event_unreg.isra.3+0xb6/0x1f0
> [   30.437778]  perf_kprobe_destroy+0xcb/0x200
> [   30.438077]  ? __pfx_perf_kprobe_destroy+0x10/0x10
> [   30.438407]  _free_event+0x220/0x11c0
> [   30.438707]  put_event+0x4d/0x60
> [   30.438938]  perf_event_release_kernel+0x5d9/0x860
> [   30.439275]  ? __pfx_perf_event_release_kernel+0x10/0x10
> [   30.439633]  ? write_comp_data+0x2f/0x90
> [   30.439913]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [   30.440245]  ? __pfx_perf_release+0x10/0x10
> [   30.440533]  perf_release+0x40/0x50
> [   30.440780]  __fput+0x26d/0xa40
> [   30.441020]  ____fput+0x1e/0x30
> [   30.441246]  task_work_run+0x1a4/0x2d0
> [   30.441509]  ? write_comp_data+0x2f/0x90
> [   30.441794]  ? __pfx_task_work_run+0x10/0x10
> [   30.442090]  ? __this_cpu_preempt_check+0x20/0x30
> [   30.442389]  ? lockdep_hardirqs_on+0x8a/0x110
> [   30.442705]  ? exit_to_user_mode_prepare+0x100/0x210
> [   30.443042]  exit_to_user_mode_prepare+0x200/0x210
> [   30.443366]  syscall_exit_to_user_mode+0x2d/0x60
> [   30.443683]  do_syscall_64+0x4a/0x90
> [   30.443937]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   30.444281] RIP: 0033:0x7f3840f1059d
> [   30.444530] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
> [   30.445701] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> [   30.446211] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f1059d
> [   30.446716] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 0000000000000003
> [   30.447193] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19fb73c0
> [   30.447661] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401180
> [   30.448128] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 0000000000000000
> [   30.448618]  </TASK>
> [   30.448787] irq event stamp: 2017
> [   30.449020] hardirqs last  enabled at (2025): [<ffffffff813dd0a1>] __up_console_sem+0x91/0xb0
> [   30.449594] hardirqs last disabled at (2032): [<ffffffff813dd086>] __up_console_sem+0x76/0xb0
> [   30.450803] softirqs last  enabled at (1974): [<ffffffff8536af3f>] __do_softirq+0x53f/0x836
> [   30.452095] softirqs last disabled at (1965): [<ffffffff812498b0>] irq_exit_rcu+0x100/0x140
> [   30.453375] ---[ end trace 0000000000000000 ]---
> 
> Bisected and found the first bad commit is:
> 71a7507afbc3f27c346898f13ab9bfd918613c34
> Merge tag 'driver-core-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core

A merge point is usually not a problem, unless the merge point actually
has changed code?  Are you sure your bisection is correct?

But again, you are injecting faults, and a fault happened, what are you
trying to actually test here?

thanks,

greg k-h
