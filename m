Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B25A626D75
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 03:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiKMCfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 21:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKMCfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 21:35:15 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8A1FD02;
        Sat, 12 Nov 2022 18:35:14 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 136so7476454pga.1;
        Sat, 12 Nov 2022 18:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5CsSwyo4jN4ThWQ8+juXA0dRTOlHjW4IoApBU1fpU1k=;
        b=qS+J+eeZUgXl6JfEMJ9bs3p/nlCFU2pSL08jttp3R9fh8UUVgLuz4hJztqe3WHYrDB
         S/j5MNjdR8z5fyct9i0j7EMhII0SKn1AnuGxtSRHdEVi7B6Y2daSEEBNqku2BRkH+ES+
         /Fgr/qfo0k6MYB/fV/ALfn87em44xKlOaXBinDSPoS/qk/tQiU4JHR+CgHljTyQ3NpW6
         qPLOPPs9IImllpn2hQvGpHrDsKSi9E0cM0cmwu9iZLt2rvcQjX0C3OtEEeJFyawvwCSh
         syNvZy7QsgFjtmsRCpf8k3zKVHJQQyRxjmVO0wT3iL7LF8c82zk3DL2YbouRNsExQjEu
         IQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CsSwyo4jN4ThWQ8+juXA0dRTOlHjW4IoApBU1fpU1k=;
        b=lnz37uDDpGeBe6OGFdhr3oUcA1QRvrePfHTpqWnzvmsEVorkufgBcKt2ajFD8NLbOr
         Ztq9+/bpPyPmjAfVwa9wd0eRt0KtGS4Z4kdF7UCmsERqn11W6EI9+QjpkxKfxRitYsu1
         DYjRSbXbOzo4E30bohH9WhlxEtz+z3ZoTXlpqLQ+k8cMPNWWafDDy/MZPtqxYkphyr5E
         XSl8KtNKirus3ABv7NygUedMbC9/lJHaAcHl1eblyPBBx0nYN1P5I9SoPgSQZM7gNlo3
         F77CHIdOpNSbrBMj60P6eFHBeak/d3/AoYMOLasWAeZLJj9WKOHsQHNw+RjcMsReyp2U
         moPQ==
X-Gm-Message-State: ANoB5pkt0UmiRO5qj1qu9lDI0TRkRPfvJkfm7eHvPiL+wz2qEbz4msnN
        EcN6SktpPWazFZFyX2qI3ORkmhQggjOvYCEPW3M=
X-Google-Smtp-Source: AA0mqf5xYB1jNVvvsmtjIP5m13hMa3pcOYArwr+4mt3KWllQOGUbxkiiRAclcwpNWONCavbjD87bPm5lFrWD17kLYBI=
X-Received: by 2002:a63:5307:0:b0:45b:f8be:7402 with SMTP id
 h7-20020a635307000000b0045bf8be7402mr6958674pgb.484.1668306914167; Sat, 12
 Nov 2022 18:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20221010023315.98396-1-zhouzhouyi@gmail.com> <87bkqjorez.fsf@mpe.ellerman.id.au>
 <CAABZP2wFY19MTsDm1SH86Ms_zRRgC77oceMkJKPqawxyExJjqQ@mail.gmail.com>
In-Reply-To: <CAABZP2wFY19MTsDm1SH86Ms_zRRgC77oceMkJKPqawxyExJjqQ@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sun, 13 Nov 2022 10:35:02 +0800
Message-ID: <CAABZP2x9OBDBqPKLoCMDKZiLZYO16beCzS0VUVEjcXU-VU3REw@mail.gmail.com>
Subject: Re: [PATCH linux-next][RFC] powerpc: fix HOTPLUG error in rcutorture
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org, paulmck@kernel.org,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I also reappear the same phenomenon in RISC-V:
[  120.156380] scftorture: --- End of test: LOCK_HOTPLUG

So I guess it is not the arch's responsibility.
I am very interested in it ;-)

Thank you both for your guidance!
Cheers
Zhouyi

On Tue, Oct 11, 2022 at 9:59 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> Thanks Michael for reviewing my patch
>
> On Mon, Oct 10, 2022 at 7:21 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Zhouyi Zhou <zhouzhouyi@gmail.com> writes:
> > > I think we should avoid torture offline the cpu who do tick timer
> > > when nohz full is running.
> >
> > Can you tell us what the bug you're fixing is?
> >
> > Did you see a crash/oops/hang etc? Or are you just proposing this as
> > something that would be a good idea?
> Sorry for the trouble and inconvenience that I bring to the community.
> I haven't made myself clear in my patch.
> The ins and outs are as follows:
> 1) cd linux-next
> 2) ./tools/testing/selftests/rcutorture/bin/torture.sh
> after 19 hours ;-)
> 3) tail  ./tools/testing/selftests/rcutorture/res/2022.09.30-01.06.22-torture/results-scftorture/NOPREEMPT/console.log
>
> [  121.449268][   T57] scftorture:  scf_invoked_count VER: 2415215
> resched: 697463 single: 619512/619760 single_ofl: 255751/256554
> single_rpc: 620692 single_rpc_ofl: 0 many: 155476/154658 all:
> 77282/76988 onoff: 3/3:5/6 18,25:9,28 63:93 (HZ=100) ste: 0 stnmie: 0
> stnmoe: 0 staf: 0
> [  121.454485][   T57] scftorture: --- End of test: LOCK_HOTPLUG:
> verbose=1 holdoff=10 longwait=0 nthreads=4 onoff_holdoff=30
> onoff_interval=1000 shutdown_secs=1 stat_interval=15 stutter=5
> use_cpus_read_lock=0, weight_resched=-1, weight_single=-1,
> weight_single_rpc=-1, weight_single_wait=-1, weight_many=-1,
> weight_many_wait=-1, weight_all=-1, weight_all_wait=-1
> [  121.469305][   T57] reboot: Power down
>
> I see "End of test: LOCK_HOTPLUG", which means the function
> torture_offline in kernel torture.c failed to bring down the cpu.
> 4) Then I chase the reason down to tick_nohz_cpu_down:
> if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
>       return -EBUSY;
> 5) I create above patch
> >
> > > Tested on PPC VM of Open Source Lab of Oregon State University.
> > > The test results show that after the fix, the success rate of
> > > rcutorture is improved.
> > > After:
> > > Successes: 40 Failures: 9
> > > Before:
> > > Successes: 38 Failures: 11
> > >
> > > I examined the console.log and Make.out files one by one, no new
> > > compile error or test error is introduced by above fix.
> > >
> > > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > ---
> > > Dear PPC developers
> > >
> > > I found this bug when trying to do rcutorture tests in ppc VM of
> > > Open Source Lab of Oregon State University:
> > >
> > > ubuntu@ubuntu:~/linux-next/tools/testing/selftests/rcutorture/res/2022.09.30-01.06.22-torture$ find . -name "console.log.diags"|xargs grep HOTPLUG
> > > ./results-scftorture/NOPREEMPT/console.log.diags:WARNING: HOTPLUG FAILURES NOPREEMPT
> > > ./results-rcutorture/TASKS03/console.log.diags:WARNING: HOTPLUG FAILURES TASKS03
> > > ./results-rcutorture/TREE04/console.log.diags:WARNING: HOTPLUG FAILURES TREE04
> > > ./results-scftorture-kasan/NOPREEMPT/console.log.diags:WARNING: HOTPLUG FAILURES NOPREEMPT
> > > ./results-rcutorture-kasan/TASKS03/console.log.diags:WARNING: HOTPLUG FAILURES TASKS03
> > > ./results-rcutorture-kasan/TREE04/console.log.diags:WARNING: HOTPLUG FAILURES TREE04
> > >
> > > I tried to fix this bug.
> > >
> > > Thanks for your patience and guidance ;-)
> > >
> > > Thanks
> > > Zhouyi
> > > --
> > >  arch/powerpc/kernel/sysfs.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> > > index ef9a61718940..be9c0e45337e 100644
> > > --- a/arch/powerpc/kernel/sysfs.c
> > > +++ b/arch/powerpc/kernel/sysfs.c
> > > @@ -4,6 +4,7 @@
> > >  #include <linux/smp.h>
> > >  #include <linux/percpu.h>
> > >  #include <linux/init.h>
> > > +#include <linux/tick.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/export.h>
> > >  #include <linux/nodemask.h>
> > > @@ -21,6 +22,7 @@
> > >  #include <asm/firmware.h>
> > >  #include <asm/idle.h>
> > >  #include <asm/svm.h>
> > > +#include "../../../kernel/time/tick-internal.h"
> >
> > Needing to include this internal header is a sign that we are using the
> > wrong API or otherwise using time keeping internals we shouldn't be.
> Yes, when I do this, I guess there is something wrong in my patch.
> >
> > >  #include "cacheinfo.h"
> > >  #include "setup.h"
> > > @@ -1151,7 +1153,11 @@ static int __init topology_init(void)
> > >                * CPU.  For instance, the boot cpu might never be valid
> > >                * for hotplugging.
> > >                */
> > > -             if (smp_ops && smp_ops->cpu_offline_self)
> > > +             if (smp_ops && smp_ops->cpu_offline_self
> > > +#ifdef CONFIG_NO_HZ_FULL
> > > +                 && !(tick_nohz_full_running && tick_do_timer_cpu == cpu)
> > > +#endif
> > > +                 )
> >
> > I can't see any other arches doing anything like this. I don't think
> > it's the arches responsibility.
> Agree!
>
> X86 seems to disable CPU0's hotplug by default, while
> tick_do_timer_cpu has a default value 0.
>
> 42 #ifdef CONFIG_BOOTPARAM_HOTPLUG_CPU0
> 43 static int cpu0_hotpluggable = 1;
> 44 #else
> 45 static int cpu0_hotpluggable;
> 46 static int __init enable_cpu0_hotplug(char *str)
> 47 {
> 48         cpu0_hotpluggable = 1;
> 49         return 1;
> 50 }
> 51
> 52 __setup("cpu0_hotplug", enable_cpu0_hotplug);
> 53 #endif
>
> I need more time to make clear the relationship of X86's
> cpu0_hotpluggable and tick_do_timer_cpu, but
> I also intend to think it's time keeping the mechanism's responsibility.
>
>
> >
> > If the time keeping core needs a CPU to stay online to run the timer
> > then it needs to organise that itself IMHO :)
>
> Um, I am going to submit a patch to time keeping community sometime
> next month ;-)
>
> Thanks again
> Cheers
> Zhouyi
> >
> > cheers
> >
> > >                       c->hotpluggable = 1;
> > >  #endif
> > >
> > > --
> > > 2.25.1
