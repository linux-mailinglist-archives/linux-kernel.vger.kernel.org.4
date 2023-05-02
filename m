Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5726F3DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjEBGtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjEBGtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:49:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD7FE
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:49:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4efea87c578so1012e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683010181; x=1685602181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcwqORhs3tyDWF48bL9fAbbUN7pV9jcTVJGJFepysVM=;
        b=pfWDPNCCjFcIfahJv/gbAFwSjqPq4bPSOJ0Rgi6oneMqGErIlSNUyMfDm0/C8hzV0S
         GIyDV+DgcM9jHhps4PYCq+dUMbaxfC7rVGzXkYsxnicvji0jPmLVkweAVQ+B2vNIQbY4
         yTYj7UErqqbEiT0tUIh56+LlQNFoEzxZa5+v/rOm6z4FZF+KInhnC6UZB1Qg3zZQo3Eh
         1D5cMet62k76jg88Nm+zjskkf2cDBu22RiojS5Te13sMYrxXFUdfIvpSVzwhbvkwMT8l
         IM0tXoqcY4PNT3beheAb8HPqbIj9yBaP1g3Szo4qQ+R7dfzoRFvHDbGKl50uqhMt3nW6
         I9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683010181; x=1685602181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcwqORhs3tyDWF48bL9fAbbUN7pV9jcTVJGJFepysVM=;
        b=TcNnEpM8/kr2ffLatiRWnru7+Cfs8zOEN8/o7xla7wTl5W5rJU4Z3tCuiTb9w2VNKl
         HNLFOQH+AoPoxxnFGp2mvivY5tG0h19hJvy9urml9BEx7M9rg4eKycL1yLVPugoDfwas
         okpIIq+CY9lnhx+q7w5W/ZQ1GASL8dI9M2UqT1/kVVSwqNafyqzJzGm863OclOAVh3C/
         Y6cta+HVASRIwINAouUosWB+7+Rrm1l5F9xBQxQYj1YKhxFUbCWu8riWv/PTrmpfBED5
         AhL0AQc5WTq/iwQOBAkpTTxQmIjGPcRGhKWOn1ocDAD+hjppgq40o1HP1KEmlRIfAgWd
         uK8A==
X-Gm-Message-State: AC+VfDyKfn+rvpy/oxJwQwPrhpB28jiKYHKdoTRBHkOImWizronw1vWP
        mPgcaSk6EGyzRC1bJM04T8n8TkgoA6b8InHxBY1QVg==
X-Google-Smtp-Source: ACHHUZ4PdMBmZ55IKlcXYQt35Fct44ayM6Qpkype+JiCkjyt9JFocQKJgENsm9Ai41S+OozjI+fL9FTdDQwO6D8lq+8=
X-Received: by 2002:a05:6512:3f03:b0:4e8:3f1e:de43 with SMTP id
 y3-20020a0565123f0300b004e83f1ede43mr99368lfa.7.1683010180732; Mon, 01 May
 2023 23:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000025a04405fa6c69a0@google.com>
In-Reply-To: <00000000000025a04405fa6c69a0@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 May 2023 08:49:27 +0200
Message-ID: <CACT4Y+Z8UdWZprJt7pRUf0PRipcEYMrDhFeSKQvKpAbT6jGaVw@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: Internal error in corrupted
To:     syzbot <syzbot+b94704ab726aaea4a3a3@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
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

On Fri, 28 Apr 2023 at 23:46, syzbot
<syzbot+b94704ab726aaea4a3a3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6e98b09da931 Merge tag 'net-next-6.4' of git://git.kernel=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1305324028000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5d0e7ab221001=
b97
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db94704ab726aaea=
4a3a3
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, =
GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+b94704ab726aaea4a3a3@syzkaller.appspotmail.com

+arm mailing list

Kernel started falling apart on arm during boot in various strange ways.

#syz set subsystems: arm

> Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
> percpu: Embedded 18 pages/cpu s44168 r8192 d21368 u73728
> Built 1 zonelists, mobility grouping on.  Total pages: 520868
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
> allocated 2097152 bytes of page_ext
> mem auto-init: stack:off, heap alloc:on, heap free:off
> software IO TLB: area num 2.
> software IO TLB: mapped [mem 0x00000000d9a49000-0x00000000dda49000] (64MB=
)
> Memory: 1954376K/2097152K available (22528K kernel code, 2360K rwdata, 83=
80K rodata, 2048K init, 868K bss, 126392K reserved, 16384K cma-reserved, 52=
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
> Insufficient stack space to handle exception!
> Task stack:     [0xdf85c000..0xdf85e000]
> IRQ stack:      [0xdf804000..0xdf806000]
> Overflow stack: [0x82a14000..0x82a15000]
> Internal error: kernel stack overflow: 0 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at 0x0
> LR is at debug_smp_processor_id+0x20/0x24 lib/smp_processor_id.c:60
> pc : [<00000000>]    lr : [<817ec4c8>]    psr: 20000193
> sp : 00000000  ip : df805f80  fp : 00000000
> r10: 825e0afd  r9 : 828fb980  r8 : 00000000
> r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000000
> r3 : 00000001  r2 : 817eb958  r1 : 81d982d4  r0 : 00000001
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 30c5387d  Table: 80003000  DAC: 00000000
> Register r0 information: non-paged memory
> Register r1 information: non-slab/vmalloc memory
> Register r2 information: non-slab/vmalloc memory
> Register r3 information: non-paged memory
> Register r4 information: NULL pointer
> Register r5 information: NULL pointer
> Register r6 information: NULL pointer
> Register r7 information: NULL pointer
> Register r8 information: NULL pointer
> Register r9 information:
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 0 at mm/slub.c:4650 __kmem_obj_info+0x1c4/0x21c mm/s=
lub.c:4650
> Modules linked in:
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
d/syzkaller-bugs/00000000000025a04405fa6c69a0%40google.com.
