Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C670265CE62
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjADIeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjADIeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:34:25 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCDC5FF7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:34:23 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Nn2sz4l2Wz16MP2;
        Wed,  4 Jan 2023 16:32:55 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 16:34:20 +0800
Message-ID: <f2e121f3-2bb7-5389-79e3-91edbebe60b8@huawei.com>
Date:   Wed, 4 Jan 2023 16:34:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/9] Add OPTPROBES feature on RISCV
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <87y1qkvmpf.fsf@all.your.base.are.belong.to.us>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <87y1qkvmpf.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi，Björn，appreciate for your review and testing about this feature.

在 2023/1/3 2:02, Björn Töpel 写道:
> Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:
> 
>> Add jump optimization support for RISC-V.
> 
> Thank you for continuing to work on the series! I took the series for a
> spin, and ran into a number of issues that makes me wonder how you test
> the series, and how the testing is different from my runs.

I have pick some kernel functions to test this series, which means all optprobe
are install at entry of function, i guess the instruction pattern is not versatile
enough for my testcases leads to some bugs are not discovered.

Do you think it is good idea to test this feature via binary ftracetest and the
kprobe related tc scripts in tools/testing/ftrace directory?

Thanks.

> 
> I'll outline the general/big issues here, and leave the specifics per-patch.
> 
> I've done simple testing, using "Kprobe-based Event Tracing"
> (CONFIG_KPROBE_EVENTS=y) via tracefs.
> 
> All the tests were run on commit 88603b6dc419 ("Linux 6.2-rc2") with the
> series applied. All the bugs were trigged by setting different probes to
> do_sys_openat2. Code:
> 
> do_sys_openat2:
> ...snip...
> ffffffff802d138c:       89aa                    c.mv    s3,a0    // +44
> ffffffff802d138e:       892e                    c.mv    s2,a1    // +46
> ffffffff802d1390:       8532                    c.mv    a0,a2
> ffffffff802d1392:       fa040593                addi    a1,s0,-96
> ffffffff802d1396:       84b2                    c.mv    s1,a2
> ffffffff802d1398:       fa043023                sd      zero,-96(s0)
> ffffffff802d139c:       fa043423                sd      zero,-88(s0)
> ffffffff802d13a0:       fa042823                sw      zero,-80(s0)
> ffffffff802d13a4:       00000097                auipc   ra,0x0
> ...snip...
> 
> 
> 1. Fail to register kprobe to c.mv
> 
> Add a kprobe:
>   echo 'p do_sys_openat2+44' > /sys/kernel/debug/tracing/kprobe_events
> 
> register_kprobe returns -22 (EINVAL). This is due to a bug in the
> instruction decoder. I've sent to fix upstream [1].
> 
> 2. (with [1] applied) Oops when register a probe
> 
> Add a kprobe:
>   echo 'p do_sys_openat2+44' > /sys/kernel/debug/tracing/kprobe_events
> 
> You get a splat:
>   Unable to handle kernel access to user memory without uaccess routines at virtual address 0000000000000008
>   Oops [#1]
>   Modules linked in:
>   CPU: 1 PID: 242 Comm: bash Tainted: G        W          6.2.0-rc2-00010-g09ff1aa7b1f9-dirty #14
>   Hardware name: riscv-virtio,qemu (DT)
>   epc : riscv_probe_decode_insn+0x16a/0x192
>    ra : riscv_probe_decode_insn+0x32/0x192
>   epc : ffffffff8127b2bc ra : ffffffff8127b184 sp : ff2000000173bac0
>    gp : ffffffff82533f70 tp : ff60000086ab2b40 t0 : 0000000000000000
>    t1 : 0000000000000850 t2 : 65646f6365642054 s0 : ff2000000173bae0
>    s1 : 0000000000000017 a0 : 000000000000e001 a1 : 000000000000003f
>    a2 : 0000000000009002 a3 : 0000000000000017 a4 : 000000000000c001
>    a5 : ffffffff8127b38a a6 : ff6000047d666000 a7 : 0000000000040000
>    s2 : 0000000000000000 s3 : 0000000000000006 s4 : ff6000008558f718
>    s5 : ff6000008558f718 s6 : 0000000000000001 s7 : ff6000008558f768
>    s8 : 0000000000000007 s9 : 0000000000000003 s10: 0000000000000002
>    s11: 00aaaaaad62baf78 t3 : 0000000000000000 t4 : 8dd70b0100000000
>    t5 : ffffffffffffe000 t6 : ff2000000173b8c8
>   status: 0000000200000120 badaddr: 0000000000000008 cause: 000000000000000f
>   [<ffffffff81257e48>] arch_prepare_optimized_kprobe+0xc2/0x4ec
>   [<ffffffff8125b420>] alloc_aggr_kprobe+0x5c/0x6a
>   [<ffffffff8125ba0a>] register_kprobe+0x5dc/0x6a2
>   [<ffffffff8016f266>] __register_trace_kprobe.part.0+0x98/0xbc
>   [<ffffffff80170544>] __trace_kprobe_create+0x6ea/0xbcc
>   [<ffffffff80176cee>] trace_probe_create+0x6c/0x7c
>   [<ffffffff8016f1a2>] create_or_delete_trace_kprobe+0x24/0x50
>   [<ffffffff80150642>] trace_parse_run_command+0x9e/0x12a
>   [<ffffffff8016f176>] probes_write+0x18/0x20
>   [<ffffffff802d494a>] vfs_write+0xca/0x41e
>   [<ffffffff802d4f96>] ksys_write+0x70/0xee
>   [<ffffffff802d5036>] sys_write+0x22/0x2a
>   [<ffffffff80004196>] ret_from_syscall+0x0/0x2
> 
> This is because a call to riscv_probe_decode_insn(probe_opcode_t *addr,
> struct arch_probe_insn *api), where api is NULL (and tripping over
> auipc). Should be a common scenario...
> 
> 3. No bound check for instructions
> 
> Add a probe to a non-valid instruction (in the middle of addi):
>   echo 'p 0xffffffff802d1394' > /sys/kernel/debug/tracing/kprobe_events
> 
> You get the same splat as above from the auipc NULL-pointer, but the
> "half" addi-instruction is parsed as a correct instruction.
> 
> 4. Lockdep splat
> 
> Might be false positive; When enabling a probe, e.g.
>   echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enable
> 
> 
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   
>   ------------------------------------------------------
>   bash/244 is trying to acquire lock:                                                     
>   ffffffff8223ee90 (cpu_hotplug_lock){++++}-{0:0}, at: stop_machine+0x2c/0x54
>                                                                                           
>   but task is already holding lock:                                                       
>   ffffffff82249f70 (text_mutex){+.+.}-{3:3}, at: ftrace_arch_code_modify_prepare+0x1a/0x22
>                                                                                           
>   which lock already depends on the new lock. 
>                                                                                           
>                                                                                           
>   the existing dependency chain (in reverse order) is:         
>                                                                                           
>   -> #1 (text_mutex){+.+.}-{3:3}:                                                         
>          lock_acquire+0x10a/0x328                                                         
>          __mutex_lock+0xa8/0x770                                                          
>          mutex_lock_nested+0x28/0x30                                                      
>          register_kprobe+0x3ae/0x5ea
>          __register_trace_kprobe.part.0+0x98/0xbc
>          __trace_kprobe_create+0x6ea/0xbcc
>          trace_probe_create+0x6c/0x7c
>          create_or_delete_trace_kprobe+0x24/0x50
>          trace_parse_run_command+0x9e/0x12a
>          probes_write+0x18/0x20
>          vfs_write+0xca/0x41e
>          ksys_write+0x70/0xee
>          sys_write+0x22/0x2a
>          ret_from_syscall+0x0/0x2
>   
>   -> #0 (cpu_hotplug_lock){++++}-{0:0}:
>          check_noncircular+0x122/0x13a
>          __lock_acquire+0x1058/0x20e4
>          lock_acquire+0x10a/0x328
>          cpus_read_lock+0x4c/0x11c
>          stop_machine+0x2c/0x54
>          arch_ftrace_update_code+0x2e/0x4c
>          ftrace_startup+0xd0/0x15e
>          register_ftrace_function+0x32/0x7c
>          arm_kprobe+0x132/0x198
>          enable_kprobe+0x9c/0xc0
>          enable_trace_kprobe+0x6e/0xea
>          kprobe_register+0x64/0x6c
>          __ftrace_event_enable_disable+0x72/0x246
>          event_enable_write+0x94/0xe4
>          vfs_write+0xca/0x41e
>          ksys_write+0x70/0xee
>          sys_write+0x22/0x2a
>          ret_from_syscall+0x0/0x2
>   
>   other info that might help us debug this:

Need to study this backtrace further, but at first glance, i guess CONFIG_DYNAMIC_FTRACE is enabled on your kernel, right?
If so, all krpobe is installed via ftrace stub, then kprobe optimiztion occur in the ftrace trampoline code, and it also
a corner case to current optprobe implementation.

>   
>    Possible unsafe locking scenario:
>   
>          CPU0                    CPU1
>          ----                    ----
>     lock(text_mutex);
>                                  lock(cpu_hotplug_lock);
>                                  lock(text_mutex);
>     lock(cpu_hotplug_lock);
>   
>    *** DEADLOCK ***
>   
>   5 locks held by bash/244:
>    #0: ff60000080f49438 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x70/0xee
>    #1: ffffffff822d9468 (event_mutex){+.+.}-{3:3}, at: event_enable_write+0x7c/0xe4
>    #2: ffffffff822d3fa8 (kprobe_mutex){+.+.}-{3:3}, at: enable_kprobe+0x32/0xc0
>    #3: ffffffff822d56d8 (ftrace_lock){+.+.}-{3:3}, at: register_ftrace_function+0x26/0x7c
>    #4: ffffffff82249f70 (text_mutex){+.+.}-{3:3}, at: ftrace_arch_code_modify_prepare+0x1a/0x22
>   
>   stack backtrace:
>   CPU: 2 PID: 244 Comm: bash Not tainted 6.2.0-rc1-00008-g544b2c59fd81 #1
>   Hardware name: riscv-virtio,qemu (DT)
>   Call Trace:
>   [<ffffffff80006e80>] dump_backtrace+0x30/0x38
>   [<ffffffff81256e82>] show_stack+0x40/0x4c
>   [<ffffffff8126e054>] dump_stack_lvl+0x62/0x84
>   [<ffffffff8126e08e>] dump_stack+0x18/0x20
>   [<ffffffff8009b37e>] print_circular_bug+0x2ac/0x318
>   [<ffffffff8009b50c>] check_noncircular+0x122/0x13a
>   [<ffffffff8009e020>] __lock_acquire+0x1058/0x20e4
>   [<ffffffff8009f90c>] lock_acquire+0x10a/0x328
>   [<ffffffff8002fb8a>] cpus_read_lock+0x4c/0x11c
>   [<ffffffff8011ed60>] stop_machine+0x2c/0x54
>   [<ffffffff8013aec6>] arch_ftrace_update_code+0x2e/0x4c
>   [<ffffffff8013e796>] ftrace_startup+0xd0/0x15e
>   [<ffffffff8013e856>] register_ftrace_function+0x32/0x7c
>   [<ffffffff8012f928>] arm_kprobe+0x132/0x198
>   [<ffffffff8012fa2a>] enable_kprobe+0x9c/0xc0
>   [<ffffffff8016ff62>] enable_trace_kprobe+0x6e/0xea
>   [<ffffffff801700da>] kprobe_register+0x64/0x6c
>   [<ffffffff8015eba6>] __ftrace_event_enable_disable+0x72/0x246
>   [<ffffffff8015eeea>] event_enable_write+0x94/0xe4
>   [<ffffffff802d5e1a>] vfs_write+0xca/0x41e
>   [<ffffffff802d6466>] ksys_write+0x70/0xee
>   [<ffffffff802d6506>] sys_write+0x22/0x2a
>   [<ffffffff80004196>] ret_from_syscall+0x0/0x2
> 

My comment is same as the last one.

> 
> 5. 32b support?
> 
> I've noticed that there code supports rv32. Is this tested? Does regular
> kprobes work on 32b?

Not yet, i will test on rv32.

>
> 
> Thanks,
> Björn
> 
> 
> [1] https://lore.kernel.org/linux-riscv/20230102160748.1307289-1-bjorn@kernel.org/
> 
> 

-- 
BR,
Liao, Chang
