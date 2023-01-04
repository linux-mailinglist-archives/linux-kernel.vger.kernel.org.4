Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2029365CE72
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjADIjW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Jan 2023 03:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjADIjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:39:17 -0500
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 00:39:15 PST
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 309F1B2B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:39:14 -0800 (PST)
Received: from smtpclient.apple (unknown [8.9.5.116])
        by APP-01 (Coremail) with SMTP id qwCowAA3P1szObVjSEXeCg--.24575S2;
        Wed, 04 Jan 2023 16:30:52 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v5 0/9] Add OPTPROBES feature on RISCV
From:   Xim <chenguokai17@mails.ucas.ac.cn>
In-Reply-To: <87y1qkvmpf.fsf@all.your.base.are.belong.to.us>
Date:   Wed, 4 Jan 2023 16:30:41 +0800
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "liaochang (A)" <liaochang1@huawei.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <A8ECFC78-661F-405D-8222-F8D1A73EA732@mails.ucas.ac.cn>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <87y1qkvmpf.fsf@all.your.base.are.belong.to.us>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-CM-TRANSID: qwCowAA3P1szObVjSEXeCg--.24575S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JryfWr1DuF4kJF47Cw4kZwb_yoWfXF1UpF
        98K3y3Kr48tryUXrWUXa15Kry8Gw45Ca47ArykJr1rZF1UCr1UJF1xtF40gryDCr98Aa47
        J3s8JayjgryDJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
        0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
        Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
        FIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x07b52NNUUUUU=
X-Originating-IP: [8.9.5.116]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiBwEBE2O05PrQ+gAAs3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Björn,

Thanks for your detailed review! I made tests mainly on some syscall/timer related
functions where these issues were not triggered. I will check all these issues as well
as comments that spread per-patch before a new version of patch set is sent.

FYI the 32b support is included and was tested with mostly same cases as the 64b one.

Regards,
Guokai Chen

> 2023年1月3日 02:02，Björn Töpel <bjorn@kernel.org> 写道：
> 
> Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:
> 
>> Add jump optimization support for RISC-V.
> 
> Thank you for continuing to work on the series! I took the series for a
> spin, and ran into a number of issues that makes me wonder how you test
> the series, and how the testing is different from my runs.
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
>  echo 'p do_sys_openat2+44' > /sys/kernel/debug/tracing/kprobe_events
> 
> register_kprobe returns -22 (EINVAL). This is due to a bug in the
> instruction decoder. I've sent to fix upstream [1].
> 
> 2. (with [1] applied) Oops when register a probe
> 
> Add a kprobe:
>  echo 'p do_sys_openat2+44' > /sys/kernel/debug/tracing/kprobe_events
> 
> You get a splat:
>  Unable to handle kernel access to user memory without uaccess routines at virtual address 0000000000000008
>  Oops [#1]
>  Modules linked in:
>  CPU: 1 PID: 242 Comm: bash Tainted: G        W          6.2.0-rc2-00010-g09ff1aa7b1f9-dirty #14
>  Hardware name: riscv-virtio,qemu (DT)
>  epc : riscv_probe_decode_insn+0x16a/0x192
>   ra : riscv_probe_decode_insn+0x32/0x192
>  epc : ffffffff8127b2bc ra : ffffffff8127b184 sp : ff2000000173bac0
>   gp : ffffffff82533f70 tp : ff60000086ab2b40 t0 : 0000000000000000
>   t1 : 0000000000000850 t2 : 65646f6365642054 s0 : ff2000000173bae0
>   s1 : 0000000000000017 a0 : 000000000000e001 a1 : 000000000000003f
>   a2 : 0000000000009002 a3 : 0000000000000017 a4 : 000000000000c001
>   a5 : ffffffff8127b38a a6 : ff6000047d666000 a7 : 0000000000040000
>   s2 : 0000000000000000 s3 : 0000000000000006 s4 : ff6000008558f718
>   s5 : ff6000008558f718 s6 : 0000000000000001 s7 : ff6000008558f768
>   s8 : 0000000000000007 s9 : 0000000000000003 s10: 0000000000000002
>   s11: 00aaaaaad62baf78 t3 : 0000000000000000 t4 : 8dd70b0100000000
>   t5 : ffffffffffffe000 t6 : ff2000000173b8c8
>  status: 0000000200000120 badaddr: 0000000000000008 cause: 000000000000000f
>  [<ffffffff81257e48>] arch_prepare_optimized_kprobe+0xc2/0x4ec
>  [<ffffffff8125b420>] alloc_aggr_kprobe+0x5c/0x6a
>  [<ffffffff8125ba0a>] register_kprobe+0x5dc/0x6a2
>  [<ffffffff8016f266>] __register_trace_kprobe.part.0+0x98/0xbc
>  [<ffffffff80170544>] __trace_kprobe_create+0x6ea/0xbcc
>  [<ffffffff80176cee>] trace_probe_create+0x6c/0x7c
>  [<ffffffff8016f1a2>] create_or_delete_trace_kprobe+0x24/0x50
>  [<ffffffff80150642>] trace_parse_run_command+0x9e/0x12a
>  [<ffffffff8016f176>] probes_write+0x18/0x20
>  [<ffffffff802d494a>] vfs_write+0xca/0x41e
>  [<ffffffff802d4f96>] ksys_write+0x70/0xee
>  [<ffffffff802d5036>] sys_write+0x22/0x2a
>  [<ffffffff80004196>] ret_from_syscall+0x0/0x2
> 
> This is because a call to riscv_probe_decode_insn(probe_opcode_t *addr,
> struct arch_probe_insn *api), where api is NULL (and tripping over
> auipc). Should be a common scenario...
> 
> 3. No bound check for instructions
> 
> Add a probe to a non-valid instruction (in the middle of addi):
>  echo 'p 0xffffffff802d1394' > /sys/kernel/debug/tracing/kprobe_events
> 
> You get the same splat as above from the auipc NULL-pointer, but the
> "half" addi-instruction is parsed as a correct instruction.
> 
> 4. Lockdep splat
> 
> Might be false positive; When enabling a probe, e.g.
>  echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enable
> 
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
> 
>  ------------------------------------------------------
>  bash/244 is trying to acquire lock:                                                     
>  ffffffff8223ee90 (cpu_hotplug_lock){++++}-{0:0}, at: stop_machine+0x2c/0x54
> 
>  but task is already holding lock:                                                       
>  ffffffff82249f70 (text_mutex){+.+.}-{3:3}, at: ftrace_arch_code_modify_prepare+0x1a/0x22
> 
>  which lock already depends on the new lock. 
> 
> 
>  the existing dependency chain (in reverse order) is:         
> 
>  -> #1 (text_mutex){+.+.}-{3:3}:                                                         
>         lock_acquire+0x10a/0x328                                                         
>         __mutex_lock+0xa8/0x770                                                          
>         mutex_lock_nested+0x28/0x30                                                      
>         register_kprobe+0x3ae/0x5ea
>         __register_trace_kprobe.part.0+0x98/0xbc
>         __trace_kprobe_create+0x6ea/0xbcc
>         trace_probe_create+0x6c/0x7c
>         create_or_delete_trace_kprobe+0x24/0x50
>         trace_parse_run_command+0x9e/0x12a
>         probes_write+0x18/0x20
>         vfs_write+0xca/0x41e
>         ksys_write+0x70/0xee
>         sys_write+0x22/0x2a
>         ret_from_syscall+0x0/0x2
> 
>  -> #0 (cpu_hotplug_lock){++++}-{0:0}:
>         check_noncircular+0x122/0x13a
>         __lock_acquire+0x1058/0x20e4
>         lock_acquire+0x10a/0x328
>         cpus_read_lock+0x4c/0x11c
>         stop_machine+0x2c/0x54
>         arch_ftrace_update_code+0x2e/0x4c
>         ftrace_startup+0xd0/0x15e
>         register_ftrace_function+0x32/0x7c
>         arm_kprobe+0x132/0x198
>         enable_kprobe+0x9c/0xc0
>         enable_trace_kprobe+0x6e/0xea
>         kprobe_register+0x64/0x6c
>         __ftrace_event_enable_disable+0x72/0x246
>         event_enable_write+0x94/0xe4
>         vfs_write+0xca/0x41e
>         ksys_write+0x70/0xee
>         sys_write+0x22/0x2a
>         ret_from_syscall+0x0/0x2
> 
>  other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(text_mutex);
>                                 lock(cpu_hotplug_lock);
>                                 lock(text_mutex);
>    lock(cpu_hotplug_lock);
> 
>   *** DEADLOCK ***
> 
>  5 locks held by bash/244:
>   #0: ff60000080f49438 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x70/0xee
>   #1: ffffffff822d9468 (event_mutex){+.+.}-{3:3}, at: event_enable_write+0x7c/0xe4
>   #2: ffffffff822d3fa8 (kprobe_mutex){+.+.}-{3:3}, at: enable_kprobe+0x32/0xc0
>   #3: ffffffff822d56d8 (ftrace_lock){+.+.}-{3:3}, at: register_ftrace_function+0x26/0x7c
>   #4: ffffffff82249f70 (text_mutex){+.+.}-{3:3}, at: ftrace_arch_code_modify_prepare+0x1a/0x22
> 
>  stack backtrace:
>  CPU: 2 PID: 244 Comm: bash Not tainted 6.2.0-rc1-00008-g544b2c59fd81 #1
>  Hardware name: riscv-virtio,qemu (DT)
>  Call Trace:
>  [<ffffffff80006e80>] dump_backtrace+0x30/0x38
>  [<ffffffff81256e82>] show_stack+0x40/0x4c
>  [<ffffffff8126e054>] dump_stack_lvl+0x62/0x84
>  [<ffffffff8126e08e>] dump_stack+0x18/0x20
>  [<ffffffff8009b37e>] print_circular_bug+0x2ac/0x318
>  [<ffffffff8009b50c>] check_noncircular+0x122/0x13a
>  [<ffffffff8009e020>] __lock_acquire+0x1058/0x20e4
>  [<ffffffff8009f90c>] lock_acquire+0x10a/0x328
>  [<ffffffff8002fb8a>] cpus_read_lock+0x4c/0x11c
>  [<ffffffff8011ed60>] stop_machine+0x2c/0x54
>  [<ffffffff8013aec6>] arch_ftrace_update_code+0x2e/0x4c
>  [<ffffffff8013e796>] ftrace_startup+0xd0/0x15e
>  [<ffffffff8013e856>] register_ftrace_function+0x32/0x7c
>  [<ffffffff8012f928>] arm_kprobe+0x132/0x198
>  [<ffffffff8012fa2a>] enable_kprobe+0x9c/0xc0
>  [<ffffffff8016ff62>] enable_trace_kprobe+0x6e/0xea
>  [<ffffffff801700da>] kprobe_register+0x64/0x6c
>  [<ffffffff8015eba6>] __ftrace_event_enable_disable+0x72/0x246
>  [<ffffffff8015eeea>] event_enable_write+0x94/0xe4
>  [<ffffffff802d5e1a>] vfs_write+0xca/0x41e
>  [<ffffffff802d6466>] ksys_write+0x70/0xee
>  [<ffffffff802d6506>] sys_write+0x22/0x2a
>  [<ffffffff80004196>] ret_from_syscall+0x0/0x2
> 
> 
> 5. 32b support?
> 
> I've noticed that there code supports rv32. Is this tested? Does regular
> kprobes work on 32b?
> 
> 
> Thanks,
> Björn
> 
> 
> [1] https://lore.kernel.org/linux-riscv/20230102160748.1307289-1-bjorn@kernel.org/
> 

