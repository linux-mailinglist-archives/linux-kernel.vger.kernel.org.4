Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B02625F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiKKQDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiKKQDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:03:03 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EA963B99;
        Fri, 11 Nov 2022 08:03:02 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id i131so6155435ybc.9;
        Fri, 11 Nov 2022 08:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze681dLMQ2jEa0ql/Xw2YsxHC1RCLWkqOmAAVQWKCDg=;
        b=mvelyhuxQwXakg/ZfJiB0xqHgx2q4zFZgQOfhy/w/ZurA7mkxXJVQ0utTGlARaw1sV
         sMvc9NQks23llyP817awfzwngwaRBbmaxLhKjaOEpEtop5H2zoBRuJDU1L0G0TG6OI/a
         X6kfxfQESTidiEU+33GlQdR9d7BBK63JUObhmnMrplxBu9Jb5qOOhY3NBLwsr7BKdrLQ
         qhQ3XhAbt/4gAdBPqLFlxVjdXTIaOa9eWAUHSgZD7VjwiBcuNywFr/lh9eoMhD2AOcd3
         K1nPkf3p3YiUepDPzJaOU9voOuOOYwCpQU/7Hq2luz6FTuUDu6tmIZ7PEFA/ftqDaRei
         8w+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ze681dLMQ2jEa0ql/Xw2YsxHC1RCLWkqOmAAVQWKCDg=;
        b=UozOjR83pKZn5AvWY+J4Yr8wPMkt7uzipDFKTjsTjLr5xD+oPoYUIIsoKgIZqqE0Y+
         r1wOIuiAI7+ZndaAk5TxQ7SrZSSPDIpiUlkJDx3VTnpKe0T9ZRkS/viv0amqubTnr4iW
         TXD651SpEMs6QVPK8bo4Ma2atMgobKwK29+yHhD0cHt+jVEQ/ldjlT7CX2OQqGcbT14p
         UtjIlIpQK7V/MBNnCUlSrbMptTtJkPmNC5yafQbvxhQ/yvGn3iDxPZqLLp/MJ15pY+o/
         x5COR4hUVEHsuaGdHvNSHlgfS6dmjIlL5WpHtb13P7v9s2W5R3K0afPv2RlRidxa0vxb
         ZO/g==
X-Gm-Message-State: ANoB5pm42XXRPoyczv83r+IG/Ldt16R4V+23W8VQCn7OttfqTokycxj3
        tTtQtI9uP9Y1INAlofUUDJE7WaFK8t2kN8Lo/9pFO1CtoA==
X-Google-Smtp-Source: AA0mqf5xzJLy6JTGd7j6/cE1nrP+2h8Mf0NfKb64LVkQUTBLhLgEO/3CgkWKEmKnEmDya8HPuy1LFQ3ER9YFwwwhsww=
X-Received: by 2002:a25:41c9:0:b0:6c2:75ce:daef with SMTP id
 o192-20020a2541c9000000b006c275cedaefmr2488748yba.532.1668182581267; Fri, 11
 Nov 2022 08:03:01 -0800 (PST)
MIME-Version: 1.0
References: <CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com>
 <Y1pqWPRmP0M+hcXf@krava> <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
 <Y2J+n7SqmtfyA7ZM@krava> <Y2j6ivTwFmA0FtvY@krava> <CAADnVQKXcdVa-gDj2_QTrBuVea+KMuFUdabR--HCf7x6Vo6uXg@mail.gmail.com>
 <Y2uv/GjnSdr/ujOj@krava> <CAADnVQJp0ZrodRu8ZtvvtXk6KAbjxmwqD-nXgFAxNpNxN6JM=g@mail.gmail.com>
 <Y2w9bNhVlAs/PcNV@krava> <Y25gFdliV7XqdUnN@krava>
In-Reply-To: <Y25gFdliV7XqdUnN@krava>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Sat, 12 Nov 2022 00:02:50 +0800
Message-ID: <CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com>
Subject: Re: WARNING in bpf_bprintf_prepare
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>
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

Jiri Olsa <olsajiri@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8811=E6=97=A5=
=E5=91=A8=E4=BA=94 22:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 10, 2022 at 12:53:16AM +0100, Jiri Olsa wrote:
>
> SNIP
>
> > > > > > ---
> > > > > > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_prob=
e.h
> > > > > > index 6a13220d2d27..5a354ae096e5 100644
> > > > > > --- a/include/trace/bpf_probe.h
> > > > > > +++ b/include/trace/bpf_probe.h
> > > > > > @@ -78,11 +78,15 @@
> > > > > >  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_A=
RGS__))(__VA_ARGS__)
> > > > > >
> > > > > >  #define __BPF_DECLARE_TRACE(call, proto, args)                =
         \
> > > > > > +static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);     =
         \
> > > > > >  static notrace void                                           =
         \
> > > > > >  __bpf_trace_##call(void *__data, proto)                       =
                 \
> > > > > >  {                                                             =
         \
> > > > > >         struct bpf_prog *prog =3D __data;                      =
           \
> > > > > > -       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST=
_TO_U64(args));  \
> > > > > > +                                                              =
         \
> > > > > > +       if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##=
call) =3D=3D 1))             \
> > > > > > +               CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(pr=
og, CAST_TO_U64(args));  \
> > > > > > +       this_cpu_dec(__bpf_trace_tp_active_##call);            =
                         \
> > > > > >  }
> > > > >
> > > > > This approach will hurt real use cases where
> > > > > multiple and different raw_tp progs run on the same cpu.
> > > >
> > > > would the 2 levels of nesting help in here?
> > > >
> > > > I can imagine the change above would break use case where we want t=
o
> > > > trigger tracepoints in irq context that interrupted task that's alr=
eady
> > > > in the same tracepoint
> > > >
> > > > with 2 levels of nesting we would trigger that tracepoint from irq =
and
> > > > would still be safe with bpf_bprintf_prepare buffer
> > >
> > > How would these 2 levels work?
> >
> > just using the active counter like below, but I haven't tested it yet
> >
> > jirka
>
> seems to be working
> Hao Sun, could you please test this patch?
>

Hi Jirka,

I've tested the proposed patch, the warning from bpf_bprintf_prepare will n=
ot
be triggered with the patch, but the reproducer can still trigger the follo=
wing
warning. My test was conducted on:

commit:  f67dd6ce0723 Merge tag 'slab-for-6.1-rc4-fixes'
git tree:   upstream
kernel config: https://pastebin.com/raw/sE5QK5HL
C reproducer: https://pastebin.com/raw/X96ASi27
console log *before* the patch: https://pastebin.com/raw/eSCUNFrd
console log *after* the patch: https://pastebin.com/raw/tzcmdWZt

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
WARNING: possible recursive locking detected
6.1.0-rc4-00020-gf67dd6ce0723-dirty #11 Not tainted
--------------------------------------------
a.out/6703 is trying to acquire lock:
ffffffff8ce0ea18 (trace_printk_lock){....}-{2:2}, at:
____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
ffffffff8ce0ea18 (trace_printk_lock){....}-{2:2}, at:
bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:376

but task is already holding lock:
ffffffff8ce0ea18 (trace_printk_lock){....}-{2:2}, at:
____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
ffffffff8ce0ea18 (trace_printk_lock){....}-{2:2}, at:
bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:376

other info that might help us debug this:
Possible unsafe locking scenario:

CPU0
----
lock(trace_printk_lock);
lock(trace_printk_lock);

*** DEADLOCK ***

May be due to missing lock nesting notation

4 locks held by a.out/6703:
#0: ffffffff8ce02fc8 (event_mutex){+.+.}-{3:3}, at:
__ftrace_set_clr_event kernel/trace/trace_events.c:1060 [inline]
#0: ffffffff8ce02fc8 (event_mutex){+.+.}-{3:3}, at:
trace_set_clr_event+0xd5/0x140 kernel/trace/trace_events.c:1126
#1: ffffffff8cd85f00 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run
kernel/trace/bpf_trace.c:2249 [inline]
#1: ffffffff8cd85f00 (rcu_read_lock){....}-{1:2}, at:
bpf_trace_run2+0xb9/0x3d0 kernel/trace/bpf_trace.c:2293
#2: ffffffff8ce0ea18 (trace_printk_lock){....}-{2:2}, at:
____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
#2: ffffffff8ce0ea18 (trace_printk_lock){....}-{2:2}, at:
bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:376
#3: ffffffff8cd85f00 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run
kernel/trace/bpf_trace.c:2249 [inline]
#3: ffffffff8cd85f00 (rcu_read_lock){....}-{1:2}, at:
bpf_trace_run2+0xb9/0x3d0 kernel/trace/bpf_trace.c:2293

stack backtrace:
CPU: 7 PID: 6703 Comm: a.out Not tainted 6.1.0-rc4-00020-gf67dd6ce0723-dirt=
y #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux
1.16.0-3-3 04/01/2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xfc/0x174 lib/dump_stack.c:106
print_deadlock_bug kernel/locking/lockdep.c:2990 [inline]
check_deadlock kernel/locking/lockdep.c:3033 [inline]
validate_chain kernel/locking/lockdep.c:3818 [inline]
__lock_acquire.cold+0x119/0x3b9 kernel/locking/lockdep.c:5055
lock_acquire kernel/locking/lockdep.c:5668 [inline]
lock_acquire+0x1dc/0x600 kernel/locking/lockdep.c:5633
__raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
_raw_spin_lock_irqsave+0x36/0x50 kernel/locking/spinlock.c:162
____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:376
___bpf_prog_run+0x42e5/0x8de0 kernel/bpf/core.c:1818
__bpf_prog_run32+0x99/0xe0 kernel/bpf/core.c:2041
bpf_dispatcher_nop_func include/linux/bpf.h:964 [inline]
__bpf_prog_run include/linux/filter.h:600 [inline]
bpf_prog_run include/linux/filter.h:607 [inline]
__bpf_trace_run kernel/trace/bpf_trace.c:2254 [inline]
bpf_trace_run2+0x14d/0x3d0 kernel/trace/bpf_trace.c:2293
__bpf_trace_contention_begin+0xc8/0x120 include/trace/events/lock.h:95
__traceiter_contention_begin+0x56/0x90 include/trace/events/lock.h:95
trace_contention_begin.constprop.0+0x143/0x240 include/trace/events/lock.h:=
95
__pv_queued_spin_lock_slowpath+0xfd/0xc70 kernel/locking/qspinlock.c:405
pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
do_raw_spin_lock+0x20a/0x2b0 kernel/locking/spinlock_debug.c:115
__raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
_raw_spin_lock_irqsave+0x3e/0x50 kernel/locking/spinlock.c:162
____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:376
___bpf_prog_run+0x42e5/0x8de0 kernel/bpf/core.c:1818
__bpf_prog_run32+0x99/0xe0 kernel/bpf/core.c:2041
bpf_dispatcher_nop_func include/linux/bpf.h:964 [inline]
__bpf_prog_run include/linux/filter.h:600 [inline]
bpf_prog_run include/linux/filter.h:607 [inline]
__bpf_trace_run kernel/trace/bpf_trace.c:2254 [inline]
bpf_trace_run2+0x14d/0x3d0 kernel/trace/bpf_trace.c:2293
__bpf_trace_contention_begin+0xc8/0x120 include/trace/events/lock.h:95
__traceiter_contention_begin+0x56/0x90 include/trace/events/lock.h:95
trace_contention_begin+0x129/0x1e0 include/trace/events/lock.h:95
__mutex_lock_common kernel/locking/mutex.c:605 [inline]
__mutex_lock+0x15a/0x12d0 kernel/locking/mutex.c:747
__ftrace_set_clr_event kernel/trace/trace_events.c:1060 [inline]
trace_set_clr_event+0xd5/0x140 kernel/trace/trace_events.c:1126
__set_printk_clr_event kernel/trace/bpf_trace.c:419 [inline]
bpf_get_trace_printk_proto kernel/trace/bpf_trace.c:425 [inline]
bpf_tracing_func_proto+0x476/0x5a0 kernel/trace/bpf_trace.c:1422
raw_tp_prog_func_proto+0x4f/0x60 kernel/trace/bpf_trace.c:1885
check_helper_call+0x20a/0x94d0 kernel/bpf/verifier.c:7255
do_check kernel/bpf/verifier.c:12384 [inline]
do_check_common+0x6b3e/0xdf20 kernel/bpf/verifier.c:14643
do_check_main kernel/bpf/verifier.c:14706 [inline]
bpf_check+0x714c/0xa9b0 kernel/bpf/verifier.c:15276
bpf_prog_load+0xfb1/0x2110 kernel/bpf/syscall.c:2605
__sys_bpf+0xaba/0x5520 kernel/bpf/syscall.c:4965
__do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
__x64_sys_bpf+0x74/0xb0 kernel/bpf/syscall.c:5067
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe9f4ee4469
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007fff7c845438 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe9f4ee4469
RDX: 0000000000000048 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 00007fff7c845450 R08: 00007fe9f4f2e160 R09: 00007fff7c845450
R10: 0000000020001cc2 R11: 0000000000000246 R12: 000055643c800c00
R13: 00007fff7c845570 R14: 0000000000000000 R15: 0000000000000000
</TASK>

Regards
Hao

> thanks,
> jirka
> >
> >
> > ---
> > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > index 6a13220d2d27..ca5dd34478b7 100644
> > --- a/include/trace/bpf_probe.h
> > +++ b/include/trace/bpf_probe.h
> > @@ -78,11 +78,15 @@
> >  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(=
__VA_ARGS__)
> >
> >  #define __BPF_DECLARE_TRACE(call, proto, args)                        =
       \
> > +static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);            \
> >  static notrace void                                                  \
> >  __bpf_trace_##call(void *__data, proto)                               =
       \
> >  {                                                                    \
> >       struct bpf_prog *prog =3D __data;                                =
 \
> > -     CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(ar=
gs));  \
> > +                                                                     \
> > +     if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##call) < 3)=
)              \
> > +             CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_T=
O_U64(args));  \
> > +     this_cpu_dec(__bpf_trace_tp_active_##call);                      =
               \
> >  }
> >
> >  #undef DECLARE_EVENT_CLASS
