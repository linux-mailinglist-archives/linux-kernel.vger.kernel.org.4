Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3708C5ED2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiI1BtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiI1BtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:49:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBB61EE74E;
        Tue, 27 Sep 2022 18:49:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d11so10585304pll.8;
        Tue, 27 Sep 2022 18:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=5Vg9DwF7vi5Rl3xXxBWJzxL4mqinTrC7c17A9WSWn9I=;
        b=ScSGb+e6Kdbh97BaYYrf5xnUPg2TUlcgJWbl6QelkJeycbjW9RUSF79cPDe0w/ku8T
         zbhNo/Bm/asCb6cI01SABPnxaHjaHelIz1TJ8BH2s6Bv+AIkrTwKbpI8XsKevXPQ3EsN
         AQpfWxVLltbQcEfKLW9vBDGQVN8hRb9KvjU1JIrup2xg9HacHsU3/rpAm5kYdbiZkIqj
         PakmYCb9SqfCeBw0yqwYxFJtZhDEL7Jn8+QGaEnQCY+KpZMQh1x1VfpRoWrmLuDrNbS3
         Wvxrox8k5DKMYNclpAYwX3pJJdwumdLApoT8JzvTeLHKqEQj5Iov+9192QuYoyIml9Tu
         a9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5Vg9DwF7vi5Rl3xXxBWJzxL4mqinTrC7c17A9WSWn9I=;
        b=pI2xSUZiL80xOKli5BvgEUAT6tayWETPpqvKSoNMAcOD0ZW9F+v/2S29B8is/r98B1
         jI7FI5AQZlU6MmULMbJhXBwIxTndmtGZyj5WnAJQIyqcSqqpKoMU47PQMEasVFoGHKlV
         9WIPT8VOeaofSncqijkkApK0mx2huywCzY19sZfQdYHek9xEXS/Qzq899LHJaLQzFQwC
         so2vFutwRqC2fQz8NhHjkx98a1sBBFxz3C2smwYMnRNdnJvfG1OXzRrJanxQrybwJah5
         L3fla3i0ePoPp5JpsTQGJcoVD8sxLgfJYzvqMvNgFvMagMyPx3PuQ4vUf0HZz1WX9a9N
         GsvA==
X-Gm-Message-State: ACrzQf0jI4Uxjtpb9JECH1GpdFaSrldbnC1pL0ok1rzPNGfXAWjfkUz6
        6tdj7MQpunnXTO+GND6JKJgjN2RyQtSgAXvaB20=
X-Google-Smtp-Source: AMsMyM4FsOphlNPc27yHcJFuFy/eZgOUk4rcOBHq3sWv00e0XJ1giG/PqpsP9+UnYyO+P5aXIycnRDgwOU5M0xE/ooA=
X-Received: by 2002:a17:902:e744:b0:178:6d7b:6d08 with SMTP id
 p4-20020a170902e74400b001786d7b6d08mr30585585plf.128.1664329743194; Tue, 27
 Sep 2022 18:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220927014823.11439-1-zhouzhouyi@gmail.com> <CN6WCMKCWHOG.LT2QV3910UJ2@bobo>
In-Reply-To: <CN6WCMKCWHOG.LT2QV3910UJ2@bobo>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 28 Sep 2022 09:48:52 +0800
Message-ID: <CAABZP2wYcNXkTo=tgX-ARziwgD2rng+-wCZ-qfQ6M30+vmLEug@mail.gmail.com>
Subject: Re: [PATCH linux-next][RFC] powerpc: avoid lockdep when we are offline
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org, paulmck@kernel.org,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank Nick for reviewing my patch

On Tue, Sep 27, 2022 at 12:25 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Tue Sep 27, 2022 at 11:48 AM AEST, Zhouyi Zhou wrote:
> > This is second version of my fix to PPC's  "WARNING: suspicious RCU usa=
ge",
> > I improved my fix under Paul E. McKenney's guidance:
> > Link: https://lore.kernel.org/lkml/20220914021528.15946-1-zhouzhouyi@gm=
ail.com/T/
> >
> > During the cpu offlining, the sub functions of xive_teardown_cpu will
> > call __lock_acquire when CONFIG_LOCKDEP=3Dy. The latter function will
> > travel RCU protected list, so "WARNING: suspicious RCU usage" will be
> > triggered.
> >
> > Avoid lockdep when we are offline.
>
> I don't see how this is safe. If RCU is no longer watching the CPU then
> the memory it is accessing here could be concurrently freed. I think the
> warning is valid.
Agree
>
> powerpc's problem is that cpuhp_report_idle_dead() is called before
> arch_cpu_idle_dead(), so it must not rely on any RCU protection there.
> I would say xive cleanup just needs to be done earlier. I wonder why it
> is not done in __cpu_disable or thereabouts, that's where the interrupt
> controller is supposed to be stopped.
Yes, I learn flowing events sequence from kgdb debugging
__cpu_disable -> pseries_cpu_disable -> set_cpu_online(cpu, false)  =3D
leads to =3D>  do_idle: if (cpu_is_offline(cpu) -> arch_cpu_idle_dead
so xive cleanup should be done in pseries_cpu_disable.
But as a beginner, I afraid that I am incompetent to do above
sophisticated work without error although I am very like to,
Could any expert do this for us?

Thanks a lot
Cheers
Zhouyi
>
> Thanks,
> Nick
>
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> > Dear PPC and RCU developers
> >
> > I found this bug when trying to do rcutorture tests in ppc VM of
> > Open Source Lab of Oregon State University
> >
> > console.log report following bug:
> > [   37.635545][    T0] WARNING: suspicious RCU usage^M
> > [   37.636409][    T0] 6.0.0-rc4-next-20220907-dirty #8 Not tainted^M
> > [   37.637575][    T0] -----------------------------^M
> > [   37.638306][    T0] kernel/locking/lockdep.c:3723 RCU-list traversed=
 in non-reader section!!^M
> > [   37.639651][    T0] ^M
> > [   37.639651][    T0] other info that might help us debug this:^M
> > [   37.639651][    T0] ^M
> > [   37.641381][    T0] ^M
> > [   37.641381][    T0] RCU used illegally from offline CPU!^M
> > [   37.641381][    T0] rcu_scheduler_active =3D 2, debug_locks =3D 1^M
> > [   37.667170][    T0] no locks held by swapper/6/0.^M
> > [   37.668328][    T0] ^M
> > [   37.668328][    T0] stack backtrace:^M
> > [   37.669995][    T0] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 6.0.0-=
rc4-next-20220907-dirty #8^M
> > [   37.672777][    T0] Call Trace:^M
> > [   37.673729][    T0] [c000000004653920] [c00000000097f9b4] dump_stack=
_lvl+0x98/0xe0 (unreliable)^M
> > [   37.678579][    T0] [c000000004653960] [c0000000001f2eb8] lockdep_rc=
u_suspicious+0x148/0x16c^M
> > [   37.680425][    T0] [c0000000046539f0] [c0000000001ed9b4] __lock_acq=
uire+0x10f4/0x26e0^M
> > [   37.682450][    T0] [c000000004653b30] [c0000000001efc2c] lock_acqui=
re+0x12c/0x420^M
> > [   37.684113][    T0] [c000000004653c20] [c0000000010d704c] _raw_spin_=
lock_irqsave+0x6c/0xc0^M
> > [   37.686154][    T0] [c000000004653c60] [c0000000000c7b4c] xive_spapr=
_put_ipi+0xcc/0x150^M
> > [   37.687879][    T0] [c000000004653ca0] [c0000000010c72a8] xive_clean=
up_cpu_ipi+0xc8/0xf0^M
> > [   37.689856][    T0] [c000000004653cf0] [c0000000010c7370] xive_teard=
own_cpu+0xa0/0xf0^M
> > [   37.691877][    T0] [c000000004653d30] [c0000000000fba5c] pseries_cp=
u_offline_self+0x5c/0x100^M
> > [   37.693882][    T0] [c000000004653da0] [c00000000005d2c4] arch_cpu_i=
dle_dead+0x44/0x60^M
> > [   37.695739][    T0] [c000000004653dc0] [c0000000001c740c] do_idle+0x=
16c/0x3d0^M
> > [   37.697536][    T0] [c000000004653e70] [c0000000001c7a1c] cpu_startu=
p_entry+0x3c/0x40^M
> > [   37.699694][    T0] [c000000004653ea0] [c00000000005ca20] start_seco=
ndary+0x6c0/0xb50^M
> > [   37.701742][    T0] [c000000004653f90] [c00000000000d054] start_seco=
ndary_prolog+0x10/0x14^M
> >
> >
> > Tested on PPC VM of Open Source Lab of Oregon State University.
> > Test results show that although "WARNING: suspicious RCU usage" has gon=
e,
> > and there are less "BUG: soft lockup" reports than the original kernel
> > (9 vs 13), which sounds good ;-)
> >
> > But after my modification, results-rcutorture-kasan/SRCU-P/console.log.=
diags
> > shows a new warning:
> > [  222.289242][  T110] WARNING: CPU: 6 PID: 110 at kernel/rcu/rcutortur=
e.c:2806 rcu_torture_fwd_prog+0xc88/0xdd0
> >
> > I guess above new warning also exits in original kernel, so I write a t=
iny test script as follows:
> >
> > #!/bin/sh
> >
> > COUNTER=3D0
> > while [ $COUNTER -lt 1000 ] ; do
> >     qemu-system-ppc64 -nographic -smp cores=3D8,threads=3D1 -net none -=
M pseries -nodefaults -device spapr-vscsi -serial file:/tmp/console.log -m =
2G -kernel /tmp/vmlinux -append "debug_boot_weak_hash panic=3D-1 console=3D=
ttyS0 rcupdate.rcu_cpu_stall_suppress_at_boot=3D1 torture.disable_onoff_at_=
boot rcupdate.rcu_task_stall_timeout=3D30000 rcutorture.torture_type=3Dsrcu=
d rcupdate.rcu_self_test=3D1 rcutorture.fwd_progress=3D3 srcutree.big_cpu_l=
im=3D5 rcutorture.onoff_interval=3D1000 rcutorture.onoff_holdoff=3D30 rcuto=
rture.n_barrier_cbs=3D4 rcutorture.stat_interval=3D15 rcutorture.shutdown_s=
ecs=3D420 rcutorture.test_no_idle_hz=3D1 rcutorture.verbose=3D1"&
> >     qemu_pid=3D$!
> >     cd ~/next1/linux-next
> >     make clean
> > #I use "make vmlinux -j 8" to create heavy background jitter
> >     make vmlinux -j 8  > /dev/null 2>&1
> >     make_pid=3D$!
> >     wait $qemu_pid
> >     kill $qemu_pid
> >     kill $make_id
> >     if grep -q WARN /tmp/console.log;
> >     then
> >         echo $COUNTER > /tmp/counter
> >         exit
> >     fi
> >     COUNTER=3D$(($COUNTER+1))
> > done
> >
> > Above test shows that original kernel also warn about
> > "WARNING: CPU: 6 PID: 110 at kernel/rcu/rcutorture.c:2806 rcu_torture_f=
wd_prog+0xc88/0xdd0"
> >
> > But I am not very sure about my results, so I still add a [RFC] to my s=
ubject line.
> >
> > Thank all of you for your guidance and encouragement ;-)
> >
> > Cheers
> > Zhouyi
> > --
> >  arch/powerpc/platforms/pseries/hotplug-cpu.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerp=
c/platforms/pseries/hotplug-cpu.c
> > index e0a7ac5db15d..e47098f00da1 100644
> > --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > @@ -64,10 +64,15 @@ static void pseries_cpu_offline_self(void)
> >
> >       local_irq_disable();
> >       idle_task_exit();
> > +     /* prevent lockdep code from traveling RCU protected list
> > +      * when we are offline.
> > +      */
> > +     lockdep_off();
> >       if (xive_enabled())
> >               xive_teardown_cpu();
> >       else
> >               xics_teardown_cpu();
> > +     lockdep_on();
> >
> >       unregister_slb_shadow(hwcpu);
> >       rtas_stop_self();
> > --
> > 2.25.1
>
