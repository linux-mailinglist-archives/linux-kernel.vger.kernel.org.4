Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D3A6F9FCB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjEHGXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHGXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:23:46 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EC211B71
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:23:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f1217f16e9so23108e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683527023; x=1686119023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYF+7S23EIlDJ6efe/Xv2rIwanEzud3H2WimH8iJcdA=;
        b=gH9jvkrBME17c9PvF+JhI/S2hr1rCMDicbVbDGNoik8EBmyk5gQZxC0ODlzvmvNrus
         TJyl3q11nfVpR1ZdgfUpw7wQUeaxkkVpe+SUmYj3QnFlU86AgD/pDB/wzy9FMRy3bQy2
         Xz7cAcavrZpqr20xdYPsS4NYOcuoJFzW9KxCKMfWz8E7XUpnE4EQE/vkp4DEeliUrA7a
         8aM6IIOX6q/Cn1X1h+1xPaxMhbyA3oum+5AgSU8LFkU61ufLI8oayvWcMYW7BvPc6fx4
         icrfbPGw4ePgytUDIMNLkNB+c4Vo/0xiGiPhdroRMWcuFcy6wkAXn3wa6DtDXa4X4KNn
         1LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683527023; x=1686119023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYF+7S23EIlDJ6efe/Xv2rIwanEzud3H2WimH8iJcdA=;
        b=P01ZevDHQ1ePDTg3g4/jiqo6ztBAbI30bEv2RuNe5/1CQzwwWfDzaxBu+nxhkn970x
         RerhuS3gtZpgbIZt8erH18T73IVcPOz0fRiIrQ+MRhCDNg0xiF5DsTvJ8jfOJLG0Jkyf
         d+X3VbrHxyoCuIEaB3uQbiXjg8ntYGo3Q2oriHRtmlCO3nltTEKcUkK+kwKQiW2dHKWs
         s3duIlFnv4uYq7j9f+1nZuLLdPz3LWeg8lOkxFwz83zNwRQ8xGvTP0ra57Oc01twK9H2
         saHAc6YSgykY2zH7NTrVCeeVHTjyJz3DuI10W6yj5Ep+UsO/BNvTqxfOnXvi8UjTSEQE
         9yXA==
X-Gm-Message-State: AC+VfDw2pLMJO1ar4d+mqevWbrNzbK03/WemKdMQb6qLqHNqadzjgKvl
        wWiuoww5wFckmdjWRdzDx3gIN/4houT5FhIf+WCB9A==
X-Google-Smtp-Source: ACHHUZ6VzQfz/XQcHh/ttn1+NzMZTDD75a7lxKo1TiMTYNPuOyG6oJ4RvrY/EP3cTVVXOtZaGkwJB2p6TFlhNePHoEQ=
X-Received: by 2002:a19:6a01:0:b0:4f0:10e6:b7f with SMTP id
 u1-20020a196a01000000b004f010e60b7fmr140113lfu.0.1683527022663; Sun, 07 May
 2023 23:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000281ae805faa4844e@google.com> <20230503133253.GA1689514@hirez.programming.kicks-ass.net>
 <20230503162957.GE193380@cmpxchg.org> <2907c99f-6456-3147-f43d-a65c2cdaf574@linux.dev>
In-Reply-To: <2907c99f-6456-3147-f43d-a65c2cdaf574@linux.dev>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 8 May 2023 08:23:30 +0200
Message-ID: <CACT4Y+Zufm9kgObpUSFZ9WHXib0R4OzDrix6p703ZizDR8_Nog@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in psi_task_switch
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com>,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        surenb@google.com, syzkaller-bugs@googlegroups.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Aleksandr Nogikh <nogikh@google.com>
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

On Thu, 4 May 2023 at 11:57, Chengming Zhou <chengming.zhou@linux.dev> wrot=
e:
>
> On 2023/5/4 00:29, Johannes Weiner wrote:
> > On Wed, May 03, 2023 at 03:32:53PM +0200, Peter Zijlstra wrote:
> >> On Mon, May 01, 2023 at 09:43:02AM -0700, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    89d77f71f493 Merge tag 'riscv-for-linus-6.4-mw1' of g=
it://..
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1113550c2=
80000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4cc65ccad=
523b604
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0827f439748=
13b74e6db
> >>> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 202101=
10, GNU ld (GNU Binutils for Debian) 2.35.2
> >>> userspace arch: arm
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> >>> Reported-by: syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com
> >>>
> >>> Movable zone start for each node
> >>> Early memory node ranges
> >>>   node   0: [mem 0x0000000080000000-0x00000000ffffffff]
> >>> Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
> >>> percpu: Embedded 19 pages/cpu s47048 r8192 d22584 u77824
> >>> Kernel command line: root=3D/dev/vda console=3DttyAMA0  earlyprintk=
=3Dserial net.ifnames=3D0 sysctl.kernel.hung_task_all_cpu_backtrace=3D1 ima=
_policy=3Dtcb nf-conntrack-ftp.ports=3D20000 nf-conntrack-tftp.ports=3D2000=
0 nf-conntrack-sip.ports=3D20000 nf-conntrack-irc.ports=3D20000 nf-conntrac=
k-sane.ports=3D20000 binder.debug_mask=3D0 rcupdate.rcu_expedited=3D1 rcupd=
ate.rcu_cpu_stall_cputime=3D1 no_hash_pointers page_owner=3Don sysctl.vm.nr=
_hugepages=3D4 sysctl.vm.nr_overcommit_hugepages=3D4 secretmem.enable=3D1 s=
ysctl.max_rcu_stall_to_panic=3D1 msr.allow_writes=3Doff coredump_filter=3D0=
xffff root=3D/dev/vda console=3DttyAMA0 vmalloc=3D512M smp.csd_lock_timeout=
=3D300000 watchdog_thresh=3D165 workqueue.watchdog_thresh=3D420 sysctl.net.=
core.netdev_unregister_timeout_secs=3D420 dummy_hcd.num=3D2 panic_on_warn=
=3D1
> >>> Unknown kernel command line parameters "earlyprintk=3Dserial page_own=
er=3Don", will be passed to user space.
> >>> Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes, lin=
ear)
> >>> Inode-cache hash table entries: 131072 (order: 7, 524288 bytes, linea=
r)
> >>> Built 1 zonelists, mobility grouping on.  Total pages: 520868
> >>> allocated 2097152 bytes of page_ext
> >>> mem auto-init: stack:off, heap alloc:on, heap free:off
> >>> software IO TLB: area num 2.
> >>> software IO TLB: mapped [mem 0x00000000d9a47000-0x00000000dda47000] (=
64MB)
> >>> Memory: 1952320K/2097152K available (24576K kernel code, 2362K rwdata=
, 8400K rodata, 2048K init, 867K bss, 128448K reserved, 16384K cma-reserved=
, 524288K highmem)
> >>> SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D1
> >>> trace event string verifier disabled
> >>> rcu: Preemptible hierarchical RCU implementation.
> >>> rcu:        RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_ids=3D2.
> >>> rcu:        RCU callback double-/use-after-free debug is enabled.
> >>>     All grace periods are expedited (rcu_expedited).
> >>>     Trampoline variant of Tasks RCU enabled.
> >>>     Tracing variant of Tasks RCU enabled.
> >>> rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies=
.
> >>> rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D2
> >>> NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> >>> GIC physical location is 0x2c001000
> >>> rcu: srcu_init: Setting srcu_struct sizes based on contention.
> >>> sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 894784849=
71ns
> >>> clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_=
idle_ns: 1911260446275 ns
> >>> arch_timer: cp15 timer(s) running at 62.50MHz (virt).
> >>> clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x=
1cd42e208c, max_idle_ns: 881590405314 ns
> >>> sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 439804651=
1096ns
> >>> Switching to timer-based delay loop, resolution 16ns
> >>> Console: colour dummy device 80x30
> >>> Calibrating delay loop (skipped), value calculated using timer freque=
ncy.. 125.00 BogoMIPS (lpj=3D625000)
> >>> pid_max: default: 32768 minimum: 301
> >>> LSM: initializing lsm=3Dlockdown,capability,landlock,yama,safesetid,t=
omoyo,selinux,bpf,integrity
> >>> landlock: Up and running.
> >>> Yama: becoming mindful.
> >>> TOMOYO Linux initialized
> >>> SELinux:  Initializing.
> >>> LSM support for eBPF active
> >>> stackdepot: allocating hash table of 131072 entries via kvcalloc
> >>> Mount-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
> >>> Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes, lin=
ear)
> >>> CPU: Testing write buffer coherency: ok
> >>> CPU0: Spectre BHB: enabling loop workaround for all CPUs
> >>> CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> >>> 8<--- cut here ---
> >>> Unable to handle kernel NULL pointer dereference at virtual address 0=
000001c when read
> >>> [0000001c] *pgd=3D80000080004003, *pmd=3D00000000
> >>> Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> >>> Modules linked in:
> >>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> >>> Hardware name: ARM-Versatile Express
> >>> PC is at psi_task_switch+0x1e0/0x204 kernel/sched/psi.c:940
> >>> LR is at psi_task_switch+0x190/0x204 kernel/sched/psi.c:932
> >>
> >> Johannes, your commit 71dbdde7914d ("sched/psi: Remove NR_ONCPU task
> >> accounting") was the last to touch psi.c:640. Any ideas?
> >
> > PC is at :940, which is the group->pcpu->state_mask derefs. It's a bit
> > hard to say without the Code line, but 0x1c looks like the group->pcpu
> > offset on 32 bit, so presumably group is NULL.
>
> Yes, I think your analysis is correct.
>
> In psi_task_switch(), cgroup_psi(task_dfl_cgroup(next)) return NULL.
>
> ```
> static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
> {
>         return cgroup_ino(cgrp) =3D=3D 1 ? &psi_system : cgrp->psi;
> }
> ```
>
> So task_dfl_cgroup(next) shouldn't be NULL, or it should panic here.
>
> If cgrp is correct, cgrp->psi shouldn't be NULL, cgrp->psi is alloc
> with cgroup in cgroup_create().
>
> But here cgrp->psi =3D=3D NULL, I don't know why...
>
> >
> > Is this reproducible with 6.1? And 6.0?
> >
>
> I tried today, but can't reproduce it.
>
> My local qemu setup maybe not the very same with syzbot. I run the
> versatilepb machine on my x86_64 server and use busybox as the rootfs.
>
> > Looking through git, the most recent change to how the group is looked
> > up is in 6.1, dc86aba751e2 ("sched/psi: Cache parent psi_group to
> > speed up group iteration"). It does this:
> >
> > -static struct psi_group *iterate_groups(struct task_struct *task, void=
 **iter)
> > +static inline struct psi_group *task_psi_group(struct task_struct *tas=
k)
> >  {
> > -       if (*iter =3D=3D &psi_system)
> > -               return NULL;
> > -
> >  #ifdef CONFIG_CGROUPS
> > -       if (static_branch_likely(&psi_cgroups_enabled)) {
> > -               struct cgroup *cgroup =3D NULL;
> > -
> > -               if (!*iter)
> > -                       cgroup =3D task->cgroups->dfl_cgrp;
> > -               else
> > -                       cgroup =3D cgroup_parent(*iter);
> > -
> > -               if (cgroup && cgroup_parent(cgroup)) {
> > -                       *iter =3D cgroup;
> > -                       return cgroup_psi(cgroup);
> > -               }
> > -       }
> > +       if (static_branch_likely(&psi_cgroups_enabled))
> > +               return cgroup_psi(task_dfl_cgroup(task));
> >  #endif
> > -       *iter =3D &psi_system;
> >         return &psi_system;
> >  }
> >
> > Notably, it got rid of the if (cgroup) and now calls cgroup_psi()
> > unconditionally.
>
> All css_set is created from init_css_set as the ancestor, which has dfl_c=
grp set,
> so task->cgroups->dfl_cgrp shouldn't be NULL?
>
> Will continue to look into this issue.

arm32 kernel started falling apart in multiple random ways. Each
individual crash site is most likely red herring, see the following
for more info:
https://lore.kernel.org/all/CANp29Y5Bw5mrvJDzQ1AJ3eYj3bvaTzjYDVOFC-cWXb0=3D=
PEQqrQ@mail.gmail.com/


> Thanks.
>
> >
> > If this is easily reproducible, does the following fix it?
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index e072f6b31bf3..21268e67ae34 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -881,8 +881,11 @@ static void psi_group_change(struct psi_group *gro=
up, int cpu,
> >  static inline struct psi_group *task_psi_group(struct task_struct *tas=
k)
> >  {
> >  #ifdef CONFIG_CGROUPS
> > -       if (static_branch_likely(&psi_cgroups_enabled))
> > -               return cgroup_psi(task_dfl_cgroup(task));
> > +       if (static_branch_likely(&psi_cgroups_enabled)) {
> > +               struct cgroup *cgroup =3D task_dfl_cgroup(task);
> > +
> > +               if (cgroup)
> > +                       return cgroup_psi(cgroup);
> >  #endif
> >         return &psi_system;
> >  }
> >
> > [remaining email quoted below for Chengming]
> >
> >>> pc : [<802a3c58>]    lr : [<802a3c08>]    psr: a0000193
> >>> sp : 82601e70  ip : 5b923000  fp : 82601ebc
> >>> r10: 8261ae40  r9 : 00000001  r8 : 00000002
> >>> r7 : 1b5aa6f1  r6 : 00000000  r5 : 8260c964  r4 : 00000000
> >>> r3 : 826f6748  r2 : 8309d13c  r1 : 00000000  r0 : 00000000
> >>> Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> >>> Control: 30c5387d  Table: 80003000  DAC: fffffffd
> >>> Register r0 information:
> >>> 8<--- cut here ---
> >>> Unable to handle kernel paging request at virtual address 00802158 wh=
en read
> >>> [00802158] *pgd=3D80000080004003, *pmd=3D00000000
> >>> Internal error: Oops: 206 [#2] PREEMPT SMP ARM
> >>> Modules linked in:
> >>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> >>> Hardware name: ARM-Versatile Express
> >>> PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
> >>> PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
> >>> PC is at find_vm_area mm/vmalloc.c:2623 [inline]
> >>> PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4221
> >>> LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline=
]
> >>> LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
> >>> pc : [<80479e58>]    lr : [<81800154>]    psr: 20000193
> >>> sp : 82601cd8  ip : 82601cc0  fp : 82601cec
> >>> r10: 8261ae40  r9 : 8261c9a4  r8 : 8284f41c
> >>> r7 : 60000193  r6 : 00000001  r5 : 00000000  r4 : 00802160
> >>> r3 : f0830b42  r2 : 00001ef5  r1 : 00000000  r0 : 00000001
> >>> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> >>> Control: 30c5387d  Table: 80003000  DAC: fffffffd
> >>>
> >>>
> >>> ---
> >>> This report is generated by a bot. It may contain errors.
> >>> See https://goo.gl/tpsmEJ for more information about syzbot.
> >>> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>>
> >>> syzbot will keep track of this issue. See:
> >>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >>>
> >>> If the bug is already fixed, let syzbot know by replying with:
> >>> #syz fix: exact-commit-title
> >>>
> >>> If you want to change bug's subsystems, reply with:
> >>> #syz set subsystems: new-subsystem
> >>> (See the list of subsystem names on the web dashboard)
> >>>
> >>> If the bug is a duplicate of another bug, reply with:
> >>> #syz dup: exact-subject-of-another-report
> >>>
> >>> If you want to undo deduplication, reply with:
> >>> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/2907c99f-6456-3147-f43d-a65c2cdaf574%40linux.dev.
