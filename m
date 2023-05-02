Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D976F3DD0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjEBGu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjEBGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:50:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD9B49F6
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:50:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4edc63e066fso990e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 23:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683010235; x=1685602235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erIBzIGL+Y9imDerKeMIgAoLSo4Gh5uDLXW/baLJroE=;
        b=ENytirZCmZ2K2cKQn/9JrKjJl+VXN1i6kRx0vaBZt3X9ey9aLeva4WucSfo89Dbx1z
         bvV30OS0kL6IfIT+cueiuvBYqI+yZTebmeY2aSQ9pvpRpp96KJ1n9OpQsXUv9/uYXo1I
         o/DTiG/dUDJ+0Jb0FT3Q4GqMAHJ6uGctDQYcWVMdZ01ezdxEl1reji+n20zKftmB8Sk0
         uRQ159VdOYZI509Kxd6fZw0Xg1LI2S+72HVOrNfOMI54yYm9s6SRp8FMVIaNHvvyGL1v
         O/te57EiPs1TKbyJdmjciO+Tb/QTSotKYXGBvioSe19czGH2GyGRQqtXQa2UXuXlrvx8
         KN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683010235; x=1685602235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erIBzIGL+Y9imDerKeMIgAoLSo4Gh5uDLXW/baLJroE=;
        b=ChFckFgZemVg5QIqTyz6aUKdWBDPnsH0sxW0fM/311T7sJ/HdVf8s5dDTKVozC1hsF
         rB8aWB//BnGnZvoLB6acCCs8WwBnUZlkcWKztHsnQiT/GgpGYYzmrxCtHwodOSnRb9zJ
         zzBfNAawAoc1j6/ZQkMOlSWWTnx+5kT74qm00FMY1H4Gz4E3SweX7U29qpm8yn3gCLrY
         Txb2vQf2y+DWAY3sj1sR0rztMRxgpdEL7pb3kmSJaLQHMs5hdlPVU/TZaRjI80oLEv/w
         zUMcsRHYab4wcGI7os40k63Fh65rtlfhsh3BC2S4/zG4vY6l1pguL9/Ote8QamdmSUz6
         HZ2A==
X-Gm-Message-State: AC+VfDzDCkQ9WEssftyGE9Dv7jwC0wXi7sGaqd9uXWWFYPXp+k2imhB/
        sVF+Ye/Qtk4j7PFWS/78Vkvx9s97gRlRyh1UdWdcaQ==
X-Google-Smtp-Source: ACHHUZ6uMKjhHLriYFj76+L3kl4iQujoCPg8C5n8Juk3sfq6GehBcdGg1VtugM55cpFEuD9kM0snJgeq1JxftGOrkDk=
X-Received: by 2002:a05:6512:39c4:b0:4f0:10e6:b51 with SMTP id
 k4-20020a05651239c400b004f010e60b51mr84381lfu.4.1683010234932; Mon, 01 May
 2023 23:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000058a08405fa6ba52a@google.com>
In-Reply-To: <00000000000058a08405fa6ba52a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 May 2023 08:50:22 +0200
Message-ID: <CACT4Y+YgaKVMqAT_qjZjFCWnSSJ=EU4fk1cue7RLsmS7p1H2AQ@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in corrupted
To:     syzbot <syzbot+0f3348b0cb4da6b6072d@syzkaller.appspotmail.com>
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

On Fri, 28 Apr 2023 at 22:52, syzbot
<syzbot+0f3348b0cb4da6b6072d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    22b8cc3e78f5 Merge tag 'x86_mm_for_6.4' of git://git.kern=
e..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11fa501028000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1af34c4cafb72=
074
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0f3348b0cb4da6b=
6072d
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, =
GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+0f3348b0cb4da6b6072d@syzkaller.appspotmail.com

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
> Memory: 1954368K/2097152K available (22528K kernel code, 2361K rwdata, 84=
00K rodata, 2048K init, 867K bss, 126400K reserved, 16384K cma-reserved, 52=
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
206 when execute
> [00000206] *pgd=3D80000080004003, *pmd=3D00000000
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
d/syzkaller-bugs/00000000000058a08405fa6ba52a%40google.com.
