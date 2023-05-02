Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA046F3D96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjEBGhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjEBGhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:37:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189ED94
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:37:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4edc63e066fso956e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 23:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683009448; x=1685601448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsfCYuZZPC54OsZXPrRnLspwP5RMfgCIUloYMrT+kuM=;
        b=BQaLK/z5JfVgdTirnXg9/4S6EwGmnv1fa//aCgkgeXQOMSnlxRjUHvEHlvBybArZd7
         nuD4iN+QA9JfwsaAHOwkAyFdZukRZrNinq1+mBYVR4pD9viuPwBMEDxHHGN25Kpq9jbM
         62C/zFf8CWH9sHWRBXdd5EoqEHUIq/X8+NpO4y2kVOu6cHAnblZdVXznNwIkmcxnbpVc
         3yHo3xJA1eWgaOOB3/YO5Gy/AlDH3K/eQih0r8Yu0C6z8WaScE3PvO29V461Jh5UTjVG
         vLFeYZVfAL24ngNl0OO9XOom5sr9xWDpD5/uBR/4ozrjF036oP6IZivom5vp7iqEeFDG
         uRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683009448; x=1685601448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsfCYuZZPC54OsZXPrRnLspwP5RMfgCIUloYMrT+kuM=;
        b=EzNM2jIOcpS17AfNde/3jWmbeR77eAI1oEonyQJV44p0PFZZRxehbDk6Wo/P/y/O96
         icA9RkzqV3J82M8ug+B+qx6WmH9cRqCYYoykLFVwR4FZggIUxneyUcTKV12p7XU4IiRn
         rfIpDddZNMwP4nhX8klctDvhOyYGaJncZQnFWcaX63U4B140crdrw6turL6T05RJuhlx
         GC8Mujant3ig7dk8O0UZ4jf9j6jc4OxXCEqrsLSkph8/WvLckwMPkSRMvk1q4LImQGO8
         /fGvZu5hx1tLkYHY34ZJWGlLhJqAMv+Ye5YDm/XKZ7UPjgOs1O1IoAsMAF5Qfa/zX7/m
         PKfw==
X-Gm-Message-State: AC+VfDzH6myrrzkWVOk46vAHbOZ3DaSW/OeJENc+W11In+jnIhyVuPA1
        MZ3rdCzg+NdzYAdPJNqpLTxuc2uoY8By1KzkSnHoPJB6PAbPYcdQGy0U2A==
X-Google-Smtp-Source: ACHHUZ6bvz+BiWvA3JFujb1NbYl51yskIPHN/1FORWi9YymcdEHFJ73QihTx1NW6cYcdmWjWuPI5Doe1nJhwuEzZweE=
X-Received: by 2002:a05:6512:239a:b0:4ed:b131:3449 with SMTP id
 c26-20020a056512239a00b004edb1313449mr103527lfv.7.1683009448131; Mon, 01 May
 2023 23:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000281ae805faa4844e@google.com>
In-Reply-To: <000000000000281ae805faa4844e@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 May 2023 08:37:15 +0200
Message-ID: <CACT4Y+Z+N9P6H8ZmF=TGfrC26r1LhHW7OT__UWKTh5VJOWnjEg@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in psi_task_switch
To:     syzbot <syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com>
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hannes@cmpxchg.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, surenb@google.com,
        syzkaller-bugs@googlegroups.com, vincent.guittot@linaro.org,
        vschneid@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 May 2023 at 18:43, syzbot
<syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    89d77f71f493 Merge tag 'riscv-for-linus-6.4-mw1' of git:/=
/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1113550c28000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4cc65ccad523b=
604
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0827f43974813b7=
4e6db
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, =
GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com

+arm mailing list

Kernel started falling apart on arm during boot in various strange ways.

#syz set subsystems: arm

> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000080000000-0x00000000ffffffff]
> Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
> percpu: Embedded 19 pages/cpu s47048 r8192 d22584 u77824
> Kernel command line: root=3D/dev/vda console=3DttyAMA0  earlyprintk=3Dser=
ial net.ifnames=3D0 sysctl.kernel.hung_task_all_cpu_backtrace=3D1 ima_polic=
y=3Dtcb nf-conntrack-ftp.ports=3D20000 nf-conntrack-tftp.ports=3D20000 nf-c=
onntrack-sip.ports=3D20000 nf-conntrack-irc.ports=3D20000 nf-conntrack-sane=
.ports=3D20000 binder.debug_mask=3D0 rcupdate.rcu_expedited=3D1 rcupdate.rc=
u_cpu_stall_cputime=3D1 no_hash_pointers page_owner=3Don sysctl.vm.nr_hugep=
ages=3D4 sysctl.vm.nr_overcommit_hugepages=3D4 secretmem.enable=3D1 sysctl.=
max_rcu_stall_to_panic=3D1 msr.allow_writes=3Doff coredump_filter=3D0xffff =
root=3D/dev/vda console=3DttyAMA0 vmalloc=3D512M smp.csd_lock_timeout=3D300=
000 watchdog_thresh=3D165 workqueue.watchdog_thresh=3D420 sysctl.net.core.n=
etdev_unregister_timeout_secs=3D420 dummy_hcd.num=3D2 panic_on_warn=3D1
> Unknown kernel command line parameters "earlyprintk=3Dserial page_owner=
=3Don", will be passed to user space.
> Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes, linear)
> Inode-cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
> Built 1 zonelists, mobility grouping on.  Total pages: 520868
> allocated 2097152 bytes of page_ext
> mem auto-init: stack:off, heap alloc:on, heap free:off
> software IO TLB: area num 2.
> software IO TLB: mapped [mem 0x00000000d9a47000-0x00000000dda47000] (64MB=
)
> Memory: 1952320K/2097152K available (24576K kernel code, 2362K rwdata, 84=
00K rodata, 2048K init, 867K bss, 128448K reserved, 16384K cma-reserved, 52=
4288K highmem)
> SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D1
> trace event string verifier disabled
> rcu: Preemptible hierarchical RCU implementation.
> rcu:    RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_ids=3D2.
> rcu:    RCU callback double-/use-after-free debug is enabled.
>         All grace periods are expedited (rcu_expedited).
>         Trampoline variant of Tasks RCU enabled.
>         Tracing variant of Tasks RCU enabled.
> rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D2
> NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> GIC physical location is 0x2c001000
> rcu: srcu_init: Setting srcu_struct sizes based on contention.
> sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
> clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle=
_ns: 1911260446275 ns
> arch_timer: cp15 timer(s) running at 62.50MHz (virt).
> clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd4=
2e208c, max_idle_ns: 881590405314 ns
> sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 4398046511096=
ns
> Switching to timer-based delay loop, resolution 16ns
> Console: colour dummy device 80x30
> Calibrating delay loop (skipped), value calculated using timer frequency.=
. 125.00 BogoMIPS (lpj=3D625000)
> pid_max: default: 32768 minimum: 301
> LSM: initializing lsm=3Dlockdown,capability,landlock,yama,safesetid,tomoy=
o,selinux,bpf,integrity
> landlock: Up and running.
> Yama: becoming mindful.
> TOMOYO Linux initialized
> SELinux:  Initializing.
> LSM support for eBPF active
> stackdepot: allocating hash table of 131072 entries via kvcalloc
> Mount-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
> Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
> CPU: Testing write buffer coherency: ok
> CPU0: Spectre BHB: enabling loop workaround for all CPUs
> CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
01c when read
> [0000001c] *pgd=3D80000080004003, *pmd=3D00000000
> Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at psi_task_switch+0x1e0/0x204 kernel/sched/psi.c:940
> LR is at psi_task_switch+0x190/0x204 kernel/sched/psi.c:932
> pc : [<802a3c58>]    lr : [<802a3c08>]    psr: a0000193
> sp : 82601e70  ip : 5b923000  fp : 82601ebc
> r10: 8261ae40  r9 : 00000001  r8 : 00000002
> r7 : 1b5aa6f1  r6 : 00000000  r5 : 8260c964  r4 : 00000000
> r3 : 826f6748  r2 : 8309d13c  r1 : 00000000  r0 : 00000000
> Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: 80003000  DAC: fffffffd
> Register r0 information:
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address 00802158 when r=
ead
> [00802158] *pgd=3D80000080004003, *pmd=3D00000000
> Internal error: Oops: 206 [#2] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
> PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
> PC is at find_vm_area mm/vmalloc.c:2623 [inline]
> PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4221
> LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
> LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
> pc : [<80479e58>]    lr : [<81800154>]    psr: 20000193
> sp : 82601cd8  ip : 82601cc0  fp : 82601cec
> r10: 8261ae40  r9 : 8261c9a4  r8 : 8284f41c
> r7 : 60000193  r6 : 00000001  r5 : 00000000  r4 : 00802160
> r3 : f0830b42  r2 : 00001ef5  r1 : 00000000  r0 : 00000001
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: 80003000  DAC: fffffffd
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000281ae805faa4844e%40google.com.
