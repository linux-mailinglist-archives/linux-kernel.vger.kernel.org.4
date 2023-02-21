Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09AA69DA03
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 05:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjBUECZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 23:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjBUECX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 23:02:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEFE9B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 20:02:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1EE2B80E83
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CDBC433A8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676952138;
        bh=KzEwKLdm6B9RhZLzeverE5IC+lYYGONo2bo/76e7UgU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iXlWwmVao2HIedFAE7RgEPlY/0Y8KEjRrMRiTrYSt4Mmuif6ErFJ1a8vHuBw34bgQ
         jSXPx+mqB/34Hiiuhs2cQzG3suEE/uZnHmkftIoA5YwXBv5JI+c9MOwYa8muO5SknB
         4atfbM50sG+6tmug2nalWvxfnXINxRjm1+k5SOBzgdqg+j8KCywG+KwKFm6i7bDHHp
         8nmOBPBYWK/x5++PCDmgPz8KsFrZt21+2a9FHM51mGlY32oq9J5k6tPnBn+mJmh+Dc
         y5I4NH/O94WKlxhjjisuyD5cByQtP2n48v4YOWGgdN4fEmDLMyC1B2A84khL4Glx2P
         bgF1bhQ1W1sSg==
Received: by mail-ed1-f52.google.com with SMTP id x10so11178100edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 20:02:18 -0800 (PST)
X-Gm-Message-State: AO0yUKU2xtkCbz+8+FfW0TUevDnLOj0s0QMwv7opsH3u4jCvAJLL/3nQ
        yUYQHmp8VwD+vdGhPxpgfWDXFggcSnbVYqPeeXA=
X-Google-Smtp-Source: AK7set+t2CPBk6iETbVJqohSICnV1UGu08xgJGB/Avm3PchIsJ1bK9a4xjpb/hkxoMcLtO6A2WKiY54p2Htiq1ITkLo=
X-Received: by 2002:a50:8adc:0:b0:4af:515d:5691 with SMTP id
 k28-20020a508adc000000b004af515d5691mr477288edk.7.1676952136553; Mon, 20 Feb
 2023 20:02:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJF2gTR5QFGseLOJqBbi9mMAVE5jXyva7o3--mV2j=OkGtp5GQ@mail.gmail.com>
 <mhng-b3cb21cc-7fc1-41d2-8396-b9605412a293@palmer-ri-x1c9a>
In-Reply-To: <mhng-b3cb21cc-7fc1-41d2-8396-b9605412a293@palmer-ri-x1c9a>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 21 Feb 2023 12:02:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRQSjWQ2K7v0Kn_qTtXvdnQLVXT5a_ihAqOVrjyEgd2Ww@mail.gmail.com>
Message-ID: <CAJF2gTRQSjWQ2K7v0Kn_qTtXvdnQLVXT5a_ihAqOVrjyEgd2Ww@mail.gmail.com>
Subject: Re: [PATCH -next V7 6/7] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     e.shatokhin@yadro.com, suagrfillet@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        rostedt@goodmis.org, mhiramat@kernel.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org, andy.chiu@sifive.com,
        linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 5:30 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 18 Jan 2023 22:05:04 PST (-0800), guoren@kernel.org wrote:
> > Thx Evgenii & Song,
> >
> > I got it; it would be put into v8.
>
> Sorry if I missed it, but I don't see a v8 on patchwork.  I queued up
> the first three patches onto for-next as they seem like pretty
> independent fixes/cleanups, I'll hold off on the others until v8.
Thx for approving. I would keep the patch series more independent next time=
.


>
> Thanks!
>
> >
> > On Wed, Jan 18, 2023 at 11:19 PM Evgenii Shatokhin
> > <e.shatokhin@yadro.com> wrote:
> >>
> >> On 18.01.2023 05:37, Song Shuai wrote:
> >> > Evgenii Shatokhin <e.shatokhin@yadro.com> =E4=BA=8E2023=E5=B9=B41=E6=
=9C=8817=E6=97=A5=E5=91=A8=E4=BA=8C 16:22=E5=86=99=E9=81=93=EF=BC=9A
> >> >>
> >> >> On 17.01.2023 16:16, Evgenii Shatokhin wrote:
> >> >>> Hi, Song,
> >> >>>
> >> >>> On 17.01.2023 12:32, Song Shuai wrote:
> >> >>>>
> >> >>>> Hi, Evgenii:
> >> >>>>
> >> >>>> Evgenii Shatokhin <e.shatokhin@yadro.com> =E4=BA=8E2023=E5=B9=B41=
=E6=9C=8816=E6=97=A5=E5=91=A8=E4=B8=80 14:30=E5=86=99=E9=81=93=EF=BC=9A
> >> >>>>
> >> >>>>>
> >> >>>>> Hi,
> >> >>>>>
> >> >>>>> On 12.01.2023 12:06, guoren@kernel.org wrote:
> >> >>>>>> From: Song Shuai <suagrfillet@gmail.com>
> >> >>>>>>
> >> >>>>>> select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_=
MULTI
> >> >>>>>> for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code fo=
r
> >> >>>>>> the ftrace-direct*.c files in samples/ftrace/.
> >> >>>>>>
> >> >>>>>> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> >> >>>>>> Tested-by: Guo Ren <guoren@kernel.org>
> >> >>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >> >>>>>> ---
> >> >>>>>>     arch/riscv/Kconfig                          |  2 ++
> >> >>>>>>     samples/ftrace/ftrace-direct-modify.c       | 33 ++++++++++=
++++++++
> >> >>>>>>     samples/ftrace/ftrace-direct-multi-modify.c | 37
> >> >>>>>> +++++++++++++++++++++
> >> >>>>>>     samples/ftrace/ftrace-direct-multi.c        | 22 ++++++++++=
++
> >> >>>>>>     samples/ftrace/ftrace-direct-too.c          | 26 ++++++++++=
+++++
> >> >>>>>>     samples/ftrace/ftrace-direct.c              | 22 ++++++++++=
++
> >> >>>>>>     6 files changed, 142 insertions(+)
> >> >>>>>
> >> >>>>> The samples were built OK now, but ftrace-direct-multi and
> >> >>>>> ftrace-direct-multi-modify report incorrect values of ip/pc it s=
eems.
> >> >>>>>
> >> >>>>> I ran 'insmod ftrace-direct-multi.ko', waited a little and then =
checked
> >> >>>>> the messages in the trace:
> >> >>>>>
> >> >>>>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> >> >>>>> #              | |         |   |||||     |         |
> >> >>>>>         migration/1-19      [001] .....  3858.532131: my_direct_=
func1: my
> >> >>>>> direct func1 ip 0
> >> >>>>>         migration/0-15      [000] d.s2.  3858.532136: my_direct_=
func1: my
> >> >>>>> direct func1 ip ff60000001ba9600
> >> >>>>>         migration/0-15      [000] d..2.  3858.532204: my_direct_=
func1: my
> >> >>>>> direct func1 ip ff60000003334d00
> >> >>>>>         migration/0-15      [000] .....  3858.532232: my_direct_=
func1: my
> >> >>>>> direct func1 ip 0
> >> >>>>>           rcu_sched-14      [001] .....  3858.532257: my_direct_=
func1: my
> >> >>>>> direct func1 ip 0
> >> >>>>>              insmod-415     [000] .....  3858.532270: my_direct_=
func1: my
> >> >>>>> direct func1 ip 7fffffffffffffff
> >> >>>>>              <idle>-0       [001] ..s1.  3858.539051: my_direct_=
func1: my
> >> >>>>> direct func1 ip ff60000001ba9600
> >> >>>>>              <idle>-0       [001] dns2.  3858.539124: my_direct_=
func1: my
> >> >>>>> direct func1 ip ff60000001ba9600
> >> >>>>>           rcu_sched-14      [001] .....  3858.539208: my_direct_=
func1: my
> >> >>>>> direct func1 ip 0
> >> >>>>> [...]
> >> >>>>>
> >> >>>>> If I understand it right, my_direct_func1() should print the add=
ress of
> >> >>>>> some location in the code, probably - at the beginning of the tr=
aced
> >> >>>>> functions.
> >> >>>>>
> >> >>>>> The printed values (0x0, 0x7fffffffffffffff, ...) are not valid =
code
> >> >>>>> addresses.
> >> >>>>>
> >> >>>> The invalid code address is only printed by accessing the schedul=
e()
> >> >>>> function's first argument whose address stores in a0 register.
> >> >>>> While schedule() actually has no parameter declared, so my_direct=
_func
> >> >>>> just prints the a0 in the context of the schedule()'s caller and
> >> >>>> the address maybe varies depending on the caller.
> >> >>>>
> >> >>>> I can't really understand why tracing the first argument of the
> >> >>>> schedule() function, but it seems nonsense at this point.
> >> >>>
> >> >>> The question is, what should be passed as the argument(s) of
> >> >>> my_direct_func() in this particular sample module. The kernel docs=
 and
> >> >>> commit logs seem to contain no info on that.
> >> >>>
> >> >>> With direct functions, I suppose, the trampoline can pass anything=
 it
> >> >>> wants to my_direct_func(), not just the arguments of the traced fu=
nction.
> >> >>>
> >> >>> I'd check what these sample modules do on x86 and would try to mat=
ch
> >> >>> that behaviour on RISC-V.
> >> >>
> >> >> I have checked ftrace-direct-multi.ko and ftrace-direct-multi-modif=
y.ko
> >> >> on 6.2-rc4 built for x86-64 - yes, ip/pc in the traced function sho=
uld
> >> >> be passed to my_direct_func().
> >> >>
> >> >> ftrace-direct-multi.ko:
> >> >> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> >> >> #              | |         |   |||||     |         |
> >> >>             insmod-10829   [000] d.h1.  1719.518535: my_direct_func=
: ip
> >> >> ffffffff87332f45 // wake_up_process+0x5
> >> >>    rcu_tasks_kthre-11      [000] .....  1719.518696: my_direct_func=
: ip
> >> >> ffffffff8828d935 // schedule+0x5
> >> >>             insmod-10829   [000] .....  1719.518708: my_direct_func=
: ip
> >> >> ffffffff8828d935
> >> >>    systemd-journal-293     [001] .....  1719.518823: my_direct_func=
: ip
> >> >> ffffffff8828d935
> >> >>            systemd-1       [000] .....  1719.519141: my_direct_func=
: ip
> >> >> ffffffff8828d935
> >> >>             <idle>-0       [001] ..s1.  1719.521889: my_direct_func=
: ip
> >> >> ffffffff87332f45
> >> >>             <idle>-0       [000] d.s2.  1719.521901: my_direct_func=
: ip
> >> >> ffffffff87332f45
> >> >>        rcu_preempt-15      [001] .....  1719.521917: my_direct_func=
: ip
> >> >> ffffffff8828d935
> >> >> [...]
> >> >>
> >> >> The ip values are wake_up_process+0x5 and schedule+0x5, the locatio=
ns
> >> >> where the execution of the traced functions resumes after the Ftrac=
e
> >> >> trampoline has finished.
> >> >>
> >> >> The results with ftrace-direct-multi-modify.ko are similar to that.
> >> >>
> >> >> The samples look like a demonstration, that one can pass anything
> >> >> necessary to the handler in case of "direct" functions.
> >> >>
> >> >> I suppose, the RISC-V-specific asm code in these two sample modules
> >> >> could be updated to pass the saved pc value to my_direct_func() in =
a0.
> >> >
> >> > Yes, you're right.
> >> >
> >> > I added 'mv a0,t0' in front of `call my_direct_func` to pass the add=
ress of
> >> > traced function with mcount offset.
> >> >
> >> > Here is the updated patch for your reference.
> >> > https://github.com/sugarfillet/linux/commit/95b174fb104dd970b982ee6f=
a19879393e229318
> >>
> >> Thank you for the quick fix. This one looks good to me.
> >>
> >> ftrace-direct-multi*.ko now report the ip values corresponding to
> >> schedule+0x8 and wake_up_process+0x8, which is what was expected here.
> >>
> >> One more thing: please change my "Co-developed-by:" into "Tested-by:" =
in
> >> your patch, becase this is what I actually did: tested it and reported
> >> the results. I cannot take your credit for development of this patch ;=
-)
> >>
> >> Looking forward for v8 of the series.
> >> >
> >> >
> >> >>
> >> >>>
> >> >>>>
> >> >>>> As for this patch, it just impls a simple mcount (direct_caller) =
to
> >> >>>> trace kernel functions, and basically saves the necessary ABI,
> >> >>>> call the tracing function, and restores the ABI, just like other
> >> >>>> arches do.
> >> >>>> so It shouldn't be blamed.
> >> >>>>
> >> >>>> I started an independent patch to replace schedule with kick_proc=
ess
> >> >>>> to make these samples more reasonable. And It has no conflict wit=
h the
> >> >>>> current patch, so we can go on.
> >> >>>>
> >> >>>> Link:
> >> >>>> https://lore.kernel.org/linux-kernel/20230117091101.3669996-1-sua=
grfillet@gmail.com/T/#u
> >> >>>>
> >> >>>>> The same issue is with ftrace-direct-multi-modify.ko.
> >> >>>>>
> >> >>>>> Is anything missing here?
> >> >>>>>
> >> >>>>>>
> >> >>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> >>>>>> index 307a9f413edd..e944af44f681 100644
> >> >>>>>> --- a/arch/riscv/Kconfig
> >> >>>>>> +++ b/arch/riscv/Kconfig
> >> >>>>>> @@ -112,6 +112,8 @@ config RISCV
> >> >>>>>>            select HAVE_POSIX_CPU_TIMERS_TASK_WORK
> >> >>>>>>            select HAVE_REGS_AND_STACK_ACCESS_API
> >> >>>>>>            select HAVE_FUNCTION_ARG_ACCESS_API
> >> >>>>>> +       select HAVE_SAMPLE_FTRACE_DIRECT
> >> >>>>>> +       select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> >> >>>>>>            select HAVE_STACKPROTECTOR
> >> >>>>>>            select HAVE_SYSCALL_TRACEPOINTS
> >> >>>>>>            select HAVE_RSEQ
> >> >>>>>> diff --git a/samples/ftrace/ftrace-direct-modify.c
> >> >>>>>> b/samples/ftrace/ftrace-direct-modify.c
> >> >>>>>> index de5a0f67f320..be7bf472c3c7 100644
> >> >>>>>> --- a/samples/ftrace/ftrace-direct-modify.c
> >> >>>>>> +++ b/samples/ftrace/ftrace-direct-modify.c
> >> >>>>>> @@ -23,6 +23,39 @@ extern void my_tramp2(void *);
> >> >>>>>>
> >> >>>>>>     static unsigned long my_ip =3D (unsigned long)schedule;
> >> >>>>>>
> >> >>>>>> +#ifdef CONFIG_RISCV
> >> >>>>>> +
> >> >>>>>> +asm (" .pushsection    .text, \"ax\", @progbits\n"
> >> >>>>>> +"      .type           my_tramp1, @function\n"
> >> >>>>>> +"      .globl          my_tramp1\n"
> >> >>>>>> +"   my_tramp1:\n"
> >> >>>>>> +"      addi sp,sp,-16\n"
> >> >>>>>> +"      sd   t0,0(sp)\n"
> >> >>>>>> +"      sd   ra,8(sp)\n"
> >> >>>>>> +"      call my_direct_func1\n"
> >> >>>>>> +"      ld   t0,0(sp)\n"
> >> >>>>>> +"      ld   ra,8(sp)\n"
> >> >>>>>> +"      addi sp,sp,16\n"
> >> >>>>>> +"      jr t0\n"
> >> >>>>>> +"      .size           my_tramp1, .-my_tramp1\n"
> >> >>>>>> +
> >> >>>>>> +"      .type           my_tramp2, @function\n"
> >> >>>>>> +"      .globl          my_tramp2\n"
> >> >>>>>> +"   my_tramp2:\n"
> >> >>>>>> +"      addi sp,sp,-16\n"
> >> >>>>>> +"      sd   t0,0(sp)\n"
> >> >>>>>> +"      sd   ra,8(sp)\n"
> >> >>>>>> +"      call my_direct_func2\n"
> >> >>>>>> +"      ld   t0,0(sp)\n"
> >> >>>>>> +"      ld   ra,8(sp)\n"
> >> >>>>>> +"      addi sp,sp,16\n"
> >> >>>>>> +"      jr t0\n"
> >> >>>>>> +"      .size           my_tramp2, .-my_tramp2\n"
> >> >>>>>> +"      .popsection\n"
> >> >>>>>> +);
> >> >>>>>> +
> >> >>>>>> +#endif /* CONFIG_RISCV */
> >> >>>>>> +
> >> >>>>>>     #ifdef CONFIG_X86_64
> >> >>>>>>
> >> >>>>>>     #include <asm/ibt.h>
> >> >>>>>> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c
> >> >>>>>> b/samples/ftrace/ftrace-direct-multi-modify.c
> >> >>>>>> index d52370cad0b6..10884bf418f7 100644
> >> >>>>>> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> >> >>>>>> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> >> >>>>>> @@ -21,6 +21,43 @@ void my_direct_func2(unsigned long ip)
> >> >>>>>>     extern void my_tramp1(void *);
> >> >>>>>>     extern void my_tramp2(void *);
> >> >>>>>>
> >> >>>>>> +#ifdef CONFIG_RISCV
> >> >>>>>> +
> >> >>>>>> +asm (" .pushsection    .text, \"ax\", @progbits\n"
> >> >>>>>> +"      .type           my_tramp1, @function\n"
> >> >>>>>> +"      .globl          my_tramp1\n"
> >> >>>>>> +"   my_tramp1:\n"
> >> >>>>>> +"       addi sp,sp,-24\n"
> >> >>>>>> +"       sd   a0,0(sp)\n"
> >> >>>>>> +"       sd   t0,8(sp)\n"
> >> >>>>>> +"       sd   ra,16(sp)\n"
> >> >>>>>> +"       call my_direct_func1\n"
> >> >>>>>> +"       ld   a0,0(sp)\n"
> >> >>>>>> +"       ld   t0,8(sp)\n"
> >> >>>>>> +"       ld   ra,16(sp)\n"
> >> >>>>>> +"       addi sp,sp,24\n"
> >> >>>>>> +"      jr t0\n"
> >> >>>>>> +"      .size           my_tramp1, .-my_tramp1\n"
> >> >>>>>> +
> >> >>>>>> +"      .type           my_tramp2, @function\n"
> >> >>>>>> +"      .globl          my_tramp2\n"
> >> >>>>>> +"   my_tramp2:\n"
> >> >>>>>> +"       addi sp,sp,-24\n"
> >> >>>>>> +"       sd   a0,0(sp)\n"
> >> >>>>>> +"       sd   t0,8(sp)\n"
> >> >>>>>> +"       sd   ra,16(sp)\n"
> >> >>>>>> +"       call my_direct_func2\n"
> >> >>>>>> +"       ld   a0,0(sp)\n"
> >> >>>>>> +"       ld   t0,8(sp)\n"
> >> >>>>>> +"       ld   ra,16(sp)\n"
> >> >>>>>> +"       addi sp,sp,24\n"
> >> >>>>>> +"      jr t0\n"
> >> >>>>>> +"      .size           my_tramp2, .-my_tramp2\n"
> >> >>>>>> +"      .popsection\n"
> >> >>>>>> +);
> >> >>>>>> +
> >> >>>>>> +#endif /* CONFIG_RISCV */
> >> >>>>>> +
> >> >>>>>>     #ifdef CONFIG_X86_64
> >> >>>>>>
> >> >>>>>>     #include <asm/ibt.h>
> >> >>>>>> diff --git a/samples/ftrace/ftrace-direct-multi.c
> >> >>>>>> b/samples/ftrace/ftrace-direct-multi.c
> >> >>>>>> index ec1088922517..a35bf43bf6d7 100644
> >> >>>>>> --- a/samples/ftrace/ftrace-direct-multi.c
> >> >>>>>> +++ b/samples/ftrace/ftrace-direct-multi.c
> >> >>>>>> @@ -16,6 +16,28 @@ void my_direct_func(unsigned long ip)
> >> >>>>>>
> >> >>>>>>     extern void my_tramp(void *);
> >> >>>>>>
> >> >>>>>> +#ifdef CONFIG_RISCV
> >> >>>>>> +
> >> >>>>>> +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> >> >>>>>> +"       .type           my_tramp, @function\n"
> >> >>>>>> +"       .globl          my_tramp\n"
> >> >>>>>> +"   my_tramp:\n"
> >> >>>>>> +"       addi sp,sp,-24\n"
> >> >>>>>> +"       sd   a0,0(sp)\n"
> >> >>>>>> +"       sd   t0,8(sp)\n"
> >> >>>>>> +"       sd   ra,16(sp)\n"
> >> >>>>>> +"       call my_direct_func\n"
> >> >>>>>> +"       ld   a0,0(sp)\n"
> >> >>>>>> +"       ld   t0,8(sp)\n"
> >> >>>>>> +"       ld   ra,16(sp)\n"
> >> >>>>>> +"       addi sp,sp,24\n"
> >> >>>>>> +"       jr t0\n"
> >> >>>>>> +"       .size           my_tramp, .-my_tramp\n"
> >> >>>>>> +"       .popsection\n"
> >> >>>>>> +);
> >> >>>>>> +
> >> >>>>>> +#endif /* CONFIG_RISCV */
> >> >>>>>> +
> >> >>>>>>     #ifdef CONFIG_X86_64
> >> >>>>>>
> >> >>>>>>     #include <asm/ibt.h>
> >> >>>>>> diff --git a/samples/ftrace/ftrace-direct-too.c
> >> >>>>>> b/samples/ftrace/ftrace-direct-too.c
> >> >>>>>> index e13fb59a2b47..3b62e33c2e6d 100644
> >> >>>>>> --- a/samples/ftrace/ftrace-direct-too.c
> >> >>>>>> +++ b/samples/ftrace/ftrace-direct-too.c
> >> >>>>>> @@ -18,6 +18,32 @@ void my_direct_func(struct vm_area_struct *v=
ma,
> >> >>>>>>
> >> >>>>>>     extern void my_tramp(void *);
> >> >>>>>>
> >> >>>>>> +#ifdef CONFIG_RISCV
> >> >>>>>> +
> >> >>>>>> +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> >> >>>>>> +"       .type           my_tramp, @function\n"
> >> >>>>>> +"       .globl          my_tramp\n"
> >> >>>>>> +"   my_tramp:\n"
> >> >>>>>> +"       addi sp,sp,-40\n"
> >> >>>>>> +"       sd   a0,0(sp)\n"
> >> >>>>>> +"       sd   a1,8(sp)\n"
> >> >>>>>> +"       sd   a2,16(sp)\n"
> >> >>>>>> +"       sd   t0,24(sp)\n"
> >> >>>>>> +"       sd   ra,32(sp)\n"
> >> >>>>>> +"       call my_direct_func\n"
> >> >>>>>> +"       ld   a0,0(sp)\n"
> >> >>>>>> +"       ld   a1,8(sp)\n"
> >> >>>>>> +"       ld   a2,16(sp)\n"
> >> >>>>>> +"       ld   t0,24(sp)\n"
> >> >>>>>> +"       ld   ra,32(sp)\n"
> >> >>>>>> +"       addi sp,sp,40\n"
> >> >>>>>> +"       jr t0\n"
> >> >>>>>> +"       .size           my_tramp, .-my_tramp\n"
> >> >>>>>> +"       .popsection\n"
> >> >>>>>> +);
> >> >>>>>> +
> >> >>>>>> +#endif /* CONFIG_RISCV */
> >> >>>>>> +
> >> >>>>>>     #ifdef CONFIG_X86_64
> >> >>>>>>
> >> >>>>>>     #include <asm/ibt.h>
> >> >>>>>> diff --git a/samples/ftrace/ftrace-direct.c
> >> >>>>>> b/samples/ftrace/ftrace-direct.c
> >> >>>>>> index 1f769d0db20f..2cfe5a7d2d70 100644
> >> >>>>>> --- a/samples/ftrace/ftrace-direct.c
> >> >>>>>> +++ b/samples/ftrace/ftrace-direct.c
> >> >>>>>> @@ -15,6 +15,28 @@ void my_direct_func(struct task_struct *p)
> >> >>>>>>
> >> >>>>>>     extern void my_tramp(void *);
> >> >>>>>>
> >> >>>>>> +#ifdef CONFIG_RISCV
> >> >>>>>> +
> >> >>>>>> +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> >> >>>>>> +"       .type           my_tramp, @function\n"
> >> >>>>>> +"       .globl          my_tramp\n"
> >> >>>>>> +"   my_tramp:\n"
> >> >>>>>> +"       addi sp,sp,-24\n"
> >> >>>>>> +"       sd   a0,0(sp)\n"
> >> >>>>>> +"       sd   t0,8(sp)\n"
> >> >>>>>> +"       sd   ra,16(sp)\n"
> >> >>>>>> +"       call my_direct_func\n"
> >> >>>>>> +"       ld   a0,0(sp)\n"
> >> >>>>>> +"       ld   t0,8(sp)\n"
> >> >>>>>> +"       ld   ra,16(sp)\n"
> >> >>>>>> +"       addi sp,sp,24\n"
> >> >>>>>> +"       jr t0\n"
> >> >>>>>> +"       .size           my_tramp, .-my_tramp\n"
> >> >>>>>> +"       .popsection\n"
> >> >>>>>> +);
> >> >>>>>> +
> >> >>>>>> +#endif /* CONFIG_RISCV */
> >> >>>>>> +
> >> >>>>>>     #ifdef CONFIG_X86_64
> >> >>>>>>
> >> >>>>>>     #include <asm/ibt.h>
> >> >>>>>> --
> >> >>>>>> 2.36.1
> >> >>>>
> >> >>>> --
> >> >>>> Thanks,
> >> >>>> Song
> >> >>>>
> >> >>>
> >> >>> Regards,
> >> >>> Evgenii
> >> >>
> >> >>
> >> >
> >> >
> >> > --
> >> > Thanks,
> >> > Song
> >> >
> >>
> >>
> >
> >
> > --
> > Best Regards
> >  Guo Ren



--=20
Best Regards
 Guo Ren
