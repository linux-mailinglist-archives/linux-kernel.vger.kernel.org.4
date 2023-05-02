Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E34B6F41FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjEBKv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEBKv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:51:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C5930EC
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:51:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4edc63e066fso1913e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683024682; x=1685616682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9qMzmYwH4A73j9Uo0VGBU0UVYPI6bWM4XwJxhZTK6k=;
        b=spjwfzaP2Q4oIrn3O0pOUWzYcgaIJ7WSUG8Mv6QnGv0FmeOiw7liCv9b7EGW6maPJd
         aiM3DmCj5CPWAWMA7T0OVrnb82c0OKPFPn7Go0wV+YCRCJfcFSw2HmS7ITqf0DcIj8Dz
         MZJMmq4h64zIkh8/oIaoNHfbWt49ReHJ15XSPz1NsEIZQeWFvDm5+ApFEk0qtw/6eac/
         C5M1Ef3Soh8BZUNSIjwBXE+I3iBdgUoZB9NutUB46vU4H8bJLeve7HWZkyWDZMFE7unW
         V4ima/3IvIip/B58wygltAfqEdf8joHXM44LCJZAMZxLZx9/Wm/PAvtqjc0Jx4jW+5EK
         Ox4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683024682; x=1685616682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9qMzmYwH4A73j9Uo0VGBU0UVYPI6bWM4XwJxhZTK6k=;
        b=dEWCWqCO+6t0oiy6c6eOPKyWHWryL7J1f01jUKzVtSGyHYJOgFgN4plMGtrlX6UUYL
         Kwpv/VBeoIXJhvVePG/kAaH5dLRO93lKOX45tI+UodHAz/DfySpclIkdSrhVjFjZRJ/J
         37g2aK/njgwZ+5hIGvMEhaNs98kjuNX873CATQp8q7JqvGAoLzbbpWfM9lHni2VLfZyh
         t2G0DW/dDv/+QkD/+i80SZu86D7gqXe3h+V1XXCixn/z2eiIrHmLRoXQJyt1kSa6d1BX
         ITND4gIpt8PmdexWqHlj4k+fN9leJ0gYE/RWmKid049u8+R0QEa1UKmU1vA3YqAKgdER
         rZww==
X-Gm-Message-State: AC+VfDxAk13NGzUYCIOGa249BmKyTyyXSfiDQH5gtEPyukKPUj6znXMu
        4f370XoC0NOtyEZBEzg8M8WDVWoJMrmdAS8EVhScTBjSLl8ABA2q2SF2LQ==
X-Google-Smtp-Source: ACHHUZ5X3VDSwNP41vasrajEaHyTcoRsJghd3PrH9Ghpcgz/gsr8oY44Azj+ppJ63mGiK1eqPZuNX0xhqQWCp4Cxwu4=
X-Received: by 2002:a05:6512:3d90:b0:4f1:21a2:901f with SMTP id
 k16-20020a0565123d9000b004f121a2901fmr114730lfv.3.1683024682035; Tue, 02 May
 2023 03:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000065594605fab2e72c@google.com>
In-Reply-To: <00000000000065594605fab2e72c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 May 2023 12:51:09 +0200
Message-ID: <CACT4Y+bOmSHmau-7o0wzajAc=e=xVYnUkGgYX-jL8iYrPB=JXQ@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in gpiod_set_value
To:     syzbot <syzbot+5e3c3df60302959ef641@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     brgl@bgdev.pl, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

On Tue, 2 May 2023 at 11:52, syzbot
<syzbot+5e3c3df60302959ef641@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    865fdb08197e Merge tag 'input-for-v6.4-rc0' of git://git.=
k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16481bf828000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd43eae746231f=
eb3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5e3c3df60302959=
ef641
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, =
GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+5e3c3df60302959ef641@syzkaller.appspotmail.com

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
> Memory: 1952316K/2097152K available (24576K kernel code, 2364K rwdata, 84=
04K rodata, 2048K init, 868K bss, 128452K reserved, 16384K cma-reserved, 52=
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
> Unable to handle kernel paging request at virtual address 000c01f3 when r=
ead
> [000c01f3] *pgd=3D80000080004003, *pmd=3D00000000
> Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at gpiod_set_value+0x38/0xc0 drivers/gpio/gpiolib.c:3222
> LR is at gpio_led_set+0x5c/0x60 drivers/leds/leds-gpio.c:54
> pc : [<80891a24>]    lr : [<8107f408>]    psr: 20000113
> sp : 82601e90  ip : 82601ea8  fp : 82601ea4
> r10: 00000000  r9 : 827e16e6  r8 : 00000001
> r7 : dddd1798  r6 : 000000ff  r5 : 00000001  r4 : 835c27a8
> r3 : 000c0193  r2 : 8107f3ac  r1 : 00000001  r0 : 83194800
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: 80003000  DAC: fffffffd
> Register r0 information: slab kmalloc-1k start 83194800 pointer offset 0 =
size 1024
> Register r1 information: non-paged memory
> Register r2 information: non-slab/vmalloc memory
> Register r3 information: non-paged memory
> Register r4 information: slab kmalloc-192 start 835c2780 pointer offset 4=
0 size 192
> Register r5 information: non-paged memory
> Register r6 information: non-paged memory
> Register r7 information:
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address df943ff8 when r=
ead
> [df943ff8] *pgd=3D80000080007003, *pmd=3D83093003, *pte=3D802160e88021666=
4
> Internal error: Oops: 207 [#2] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
> PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
> PC is at find_vm_area mm/vmalloc.c:2623 [inline]
> PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4221
> LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
> LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
> pc : [<8047a1f0>]    lr : [<818016fc>]    psr: a0000193
> sp : 82601cf8  ip : 82601ce0  fp : 82601d0c
> r10: 8261ae40  r9 : 8261c9a4  r8 : 8285041c
> r7 : 60000113  r6 : 00000008  r5 : dddd2000  r4 : df944000
> r3 : 00000000  r2 : 0000215b  r1 : 00000000  r0 : 00000001
> Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
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
d/syzkaller-bugs/00000000000065594605fab2e72c%40google.com.
