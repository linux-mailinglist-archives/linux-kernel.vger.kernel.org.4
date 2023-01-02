Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E5B65B624
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjABSDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjABSC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:02:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4216246
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:02:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E5ACB80D9F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CBCC433D2;
        Mon,  2 Jan 2023 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672682574;
        bh=UBXwv1DmiqwAleiJR3jULFzXbMLH87vNz+LZL8mChzQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YOIJqrOp0B30zp4FjY4CiHKsedVI6JVILxYKJo7tz4H6E2JWnPS9U/DTVc0rbGfcp
         76lzQixSQ15fkP5qq3Ju5wunijxWdDJTzBN9rP/NU6uazoyJIsKqkJNVmlOKaXvSUL
         6b/Hja+o2Factje5N/6H97I/HBb0Q4bgvRhGLJnCSNj3YyWqb/L8viUHaqzc06I4IF
         e2D7jSL0T11ZTDv6xlJ0fAjGRwivzjA70KO+MV3WjiGsR6Sxr9iE3vVH/ZWllR1CZL
         c/l12OcmVL3yp1CwAsFtmiFeArhTcRC80VNurp4fmutk2NpsJbwtLpa4Q+d6Oh+ET4
         fNNHtUMVGUreQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v5 0/9] Add OPTPROBES feature on RISCV
In-Reply-To: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
Date:   Mon, 02 Jan 2023 19:02:52 +0100
Message-ID: <87y1qkvmpf.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> Add jump optimization support for RISC-V.

Thank you for continuing to work on the series! I took the series for a
spin, and ran into a number of issues that makes me wonder how you test
the series, and how the testing is different from my runs.

I'll outline the general/big issues here, and leave the specifics per-patch.

I've done simple testing, using "Kprobe-based Event Tracing"
(CONFIG_KPROBE_EVENTS=3Dy) via tracefs.

All the tests were run on commit 88603b6dc419 ("Linux 6.2-rc2") with the
series applied. All the bugs were trigged by setting different probes to
do_sys_openat2. Code:

do_sys_openat2:
...snip...
ffffffff802d138c:       89aa                    c.mv    s3,a0    // +44
ffffffff802d138e:       892e                    c.mv    s2,a1    // +46
ffffffff802d1390:       8532                    c.mv    a0,a2
ffffffff802d1392:       fa040593                addi    a1,s0,-96
ffffffff802d1396:       84b2                    c.mv    s1,a2
ffffffff802d1398:       fa043023                sd      zero,-96(s0)
ffffffff802d139c:       fa043423                sd      zero,-88(s0)
ffffffff802d13a0:       fa042823                sw      zero,-80(s0)
ffffffff802d13a4:       00000097                auipc   ra,0x0
...snip...


1. Fail to register kprobe to c.mv

Add a kprobe:
  echo 'p do_sys_openat2+44' > /sys/kernel/debug/tracing/kprobe_events

register_kprobe returns -22 (EINVAL). This is due to a bug in the
instruction decoder. I've sent to fix upstream [1].

2. (with [1] applied) Oops when register a probe

Add a kprobe:
  echo 'p do_sys_openat2+44' > /sys/kernel/debug/tracing/kprobe_events

You get a splat:
  Unable to handle kernel access to user memory without uaccess routines at=
 virtual address 0000000000000008
  Oops [#1]
  Modules linked in:
  CPU: 1 PID: 242 Comm: bash Tainted: G        W          6.2.0-rc2-00010-g=
09ff1aa7b1f9-dirty #14
  Hardware name: riscv-virtio,qemu (DT)
  epc : riscv_probe_decode_insn+0x16a/0x192
   ra : riscv_probe_decode_insn+0x32/0x192
  epc : ffffffff8127b2bc ra : ffffffff8127b184 sp : ff2000000173bac0
   gp : ffffffff82533f70 tp : ff60000086ab2b40 t0 : 0000000000000000
   t1 : 0000000000000850 t2 : 65646f6365642054 s0 : ff2000000173bae0
   s1 : 0000000000000017 a0 : 000000000000e001 a1 : 000000000000003f
   a2 : 0000000000009002 a3 : 0000000000000017 a4 : 000000000000c001
   a5 : ffffffff8127b38a a6 : ff6000047d666000 a7 : 0000000000040000
   s2 : 0000000000000000 s3 : 0000000000000006 s4 : ff6000008558f718
   s5 : ff6000008558f718 s6 : 0000000000000001 s7 : ff6000008558f768
   s8 : 0000000000000007 s9 : 0000000000000003 s10: 0000000000000002
   s11: 00aaaaaad62baf78 t3 : 0000000000000000 t4 : 8dd70b0100000000
   t5 : ffffffffffffe000 t6 : ff2000000173b8c8
  status: 0000000200000120 badaddr: 0000000000000008 cause: 000000000000000f
  [<ffffffff81257e48>] arch_prepare_optimized_kprobe+0xc2/0x4ec
  [<ffffffff8125b420>] alloc_aggr_kprobe+0x5c/0x6a
  [<ffffffff8125ba0a>] register_kprobe+0x5dc/0x6a2
  [<ffffffff8016f266>] __register_trace_kprobe.part.0+0x98/0xbc
  [<ffffffff80170544>] __trace_kprobe_create+0x6ea/0xbcc
  [<ffffffff80176cee>] trace_probe_create+0x6c/0x7c
  [<ffffffff8016f1a2>] create_or_delete_trace_kprobe+0x24/0x50
  [<ffffffff80150642>] trace_parse_run_command+0x9e/0x12a
  [<ffffffff8016f176>] probes_write+0x18/0x20
  [<ffffffff802d494a>] vfs_write+0xca/0x41e
  [<ffffffff802d4f96>] ksys_write+0x70/0xee
  [<ffffffff802d5036>] sys_write+0x22/0x2a
  [<ffffffff80004196>] ret_from_syscall+0x0/0x2

This is because a call to riscv_probe_decode_insn(probe_opcode_t *addr,
struct arch_probe_insn *api), where api is NULL (and tripping over
auipc). Should be a common scenario...

3. No bound check for instructions

Add a probe to a non-valid instruction (in the middle of addi):
  echo 'p 0xffffffff802d1394' > /sys/kernel/debug/tracing/kprobe_events

You get the same splat as above from the auipc NULL-pointer, but the
"half" addi-instruction is parsed as a correct instruction.

4. Lockdep splat

Might be false positive; When enabling a probe, e.g.
  echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enable


  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
  WARNING: possible circular locking dependency detected
=20=20
  ------------------------------------------------------
  bash/244 is trying to acquire lock:=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  ffffffff8223ee90 (cpu_hotplug_lock){++++}-{0:0}, at: stop_machine+0x2c/0x=
54
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  but task is already holding lock:=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  ffffffff82249f70 (text_mutex){+.+.}-{3:3}, at: ftrace_arch_code_modify_pr=
epare+0x1a/0x22
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  which lock already depends on the new lock.=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  the existing dependency chain (in reverse order) is:=20=20=20=20=20=20=20=
=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  -> #1 (text_mutex){+.+.}-{3:3}:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
         lock_acquire+0x10a/0x328=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
         __mutex_lock+0xa8/0x770=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
         mutex_lock_nested+0x28/0x30=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
         register_kprobe+0x3ae/0x5ea
         __register_trace_kprobe.part.0+0x98/0xbc
         __trace_kprobe_create+0x6ea/0xbcc
         trace_probe_create+0x6c/0x7c
         create_or_delete_trace_kprobe+0x24/0x50
         trace_parse_run_command+0x9e/0x12a
         probes_write+0x18/0x20
         vfs_write+0xca/0x41e
         ksys_write+0x70/0xee
         sys_write+0x22/0x2a
         ret_from_syscall+0x0/0x2
=20=20
  -> #0 (cpu_hotplug_lock){++++}-{0:0}:
         check_noncircular+0x122/0x13a
         __lock_acquire+0x1058/0x20e4
         lock_acquire+0x10a/0x328
         cpus_read_lock+0x4c/0x11c
         stop_machine+0x2c/0x54
         arch_ftrace_update_code+0x2e/0x4c
         ftrace_startup+0xd0/0x15e
         register_ftrace_function+0x32/0x7c
         arm_kprobe+0x132/0x198
         enable_kprobe+0x9c/0xc0
         enable_trace_kprobe+0x6e/0xea
         kprobe_register+0x64/0x6c
         __ftrace_event_enable_disable+0x72/0x246
         event_enable_write+0x94/0xe4
         vfs_write+0xca/0x41e
         ksys_write+0x70/0xee
         sys_write+0x22/0x2a
         ret_from_syscall+0x0/0x2
=20=20
  other info that might help us debug this:
=20=20
   Possible unsafe locking scenario:
=20=20
         CPU0                    CPU1
         ----                    ----
    lock(text_mutex);
                                 lock(cpu_hotplug_lock);
                                 lock(text_mutex);
    lock(cpu_hotplug_lock);
=20=20
   *** DEADLOCK ***
=20=20
  5 locks held by bash/244:
   #0: ff60000080f49438 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x70/0x=
ee
   #1: ffffffff822d9468 (event_mutex){+.+.}-{3:3}, at: event_enable_write+0=
x7c/0xe4
   #2: ffffffff822d3fa8 (kprobe_mutex){+.+.}-{3:3}, at: enable_kprobe+0x32/=
0xc0
   #3: ffffffff822d56d8 (ftrace_lock){+.+.}-{3:3}, at: register_ftrace_func=
tion+0x26/0x7c
   #4: ffffffff82249f70 (text_mutex){+.+.}-{3:3}, at: ftrace_arch_code_modi=
fy_prepare+0x1a/0x22
=20=20
  stack backtrace:
  CPU: 2 PID: 244 Comm: bash Not tainted 6.2.0-rc1-00008-g544b2c59fd81 #1
  Hardware name: riscv-virtio,qemu (DT)
  Call Trace:
  [<ffffffff80006e80>] dump_backtrace+0x30/0x38
  [<ffffffff81256e82>] show_stack+0x40/0x4c
  [<ffffffff8126e054>] dump_stack_lvl+0x62/0x84
  [<ffffffff8126e08e>] dump_stack+0x18/0x20
  [<ffffffff8009b37e>] print_circular_bug+0x2ac/0x318
  [<ffffffff8009b50c>] check_noncircular+0x122/0x13a
  [<ffffffff8009e020>] __lock_acquire+0x1058/0x20e4
  [<ffffffff8009f90c>] lock_acquire+0x10a/0x328
  [<ffffffff8002fb8a>] cpus_read_lock+0x4c/0x11c
  [<ffffffff8011ed60>] stop_machine+0x2c/0x54
  [<ffffffff8013aec6>] arch_ftrace_update_code+0x2e/0x4c
  [<ffffffff8013e796>] ftrace_startup+0xd0/0x15e
  [<ffffffff8013e856>] register_ftrace_function+0x32/0x7c
  [<ffffffff8012f928>] arm_kprobe+0x132/0x198
  [<ffffffff8012fa2a>] enable_kprobe+0x9c/0xc0
  [<ffffffff8016ff62>] enable_trace_kprobe+0x6e/0xea
  [<ffffffff801700da>] kprobe_register+0x64/0x6c
  [<ffffffff8015eba6>] __ftrace_event_enable_disable+0x72/0x246
  [<ffffffff8015eeea>] event_enable_write+0x94/0xe4
  [<ffffffff802d5e1a>] vfs_write+0xca/0x41e
  [<ffffffff802d6466>] ksys_write+0x70/0xee
  [<ffffffff802d6506>] sys_write+0x22/0x2a
  [<ffffffff80004196>] ret_from_syscall+0x0/0x2


5. 32b support?

I've noticed that there code supports rv32. Is this tested? Does regular
kprobes work on 32b?


Thanks,
Bj=C3=B6rn


[1] https://lore.kernel.org/linux-riscv/20230102160748.1307289-1-bjorn@kern=
el.org/


