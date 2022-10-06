Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2246B5F6BDE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiJFQgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiJFQgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:36:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8307BCE981
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:36:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i6so2553588pfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ucc3H353pfhO9D3mu0OAivcolX8NkVraTmei59FLgzI=;
        b=X4yPCdfYzyfkJdB3bw/3EWh0rPYsOnVcGCmCmoelp1sVIb1qNPy+lJJv3YzYKv45ro
         N3luk5tOYm0YGs6DcNSKeXDebPO+VGcxJnQ8vdJpWodVCRzOSO7h5bfBpLmGVFSCvpbp
         4MLPeLcJvayvA9fUS/3nbZ8al2wWahwGOp9Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ucc3H353pfhO9D3mu0OAivcolX8NkVraTmei59FLgzI=;
        b=776WBs/f+wxxveZsDlmEjGZvNKIOkCePwIkvhDkisPIYP7obUIizLT0v5/aW+QYhIf
         lx4CCINf9CEgupD/a1qJV7OYzV/P6v2SrK3S+ljZaZvJlxri+w4BRi7AXnmy7HIc26wj
         jKXs870v/kDDV7Nd8ERLDLmsuf3ysw2HaSi3T/HVL2t7FgV0xzpRNJs1RQKmHD1xSXCR
         AApHSabhDqJhVcjsNcYbulEa7+LrW1sI5NEl1mvcL7Urkqd1vmmwOdH2siGljlXI65jy
         8It2ghW3ANOPfbK8a8M+QWb70bIcGHTxewynAnb9o4Gc3dTSd8d9sMW3JBTO7866pr7C
         1ZGQ==
X-Gm-Message-State: ACrzQf0eXZw+7T6LY9Twqv4UD1/jFptAbnNXIOanlZ1Ch16yYbdL6y76
        2BWAafxJYaiEwO2wFZqB7M/SmD2/exMxMo9MmsrSBA==
X-Google-Smtp-Source: AMsMyM62hNnOjGbaLtODyZCeuAJMWDoty7Y9VuykJDiogxGPyJvNE8goTE8Lfe3S1euUYTinHL0IQtCeeDouyskkCjQ=
X-Received: by 2002:a63:5164:0:b0:43b:e57c:a15f with SMTP id
 r36-20020a635164000000b0043be57ca15fmr584986pgl.586.1665074159892; Thu, 06
 Oct 2022 09:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <YzG51Jyd5zhvygtK@arm.com> <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N>
 <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com> <YzR5WSLux4mmFIXg@FVFF77S0Q05N>
 <2cb606b4-aa8b-e259-cdfd-1bfc61fd7c44@huawei.com> <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
 <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com> <20221005110707.55bd9354@gandalf.local.home>
 <CABRcYmJGY6fp0CtUBYN8BjEDN=r42BPLSBcrxqu491bTRmfm7g@mail.gmail.com>
 <20221005113019.18aeda76@gandalf.local.home> <Yz4BQXtYPa/TU652@krava>
In-Reply-To: <Yz4BQXtYPa/TU652@krava>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 6 Oct 2022 18:35:48 +0200
Message-ID: <CABRcYmJDF=Wt1XiaDTyvE-eVbVTw4KYQnies9q1XcdkD+T36vQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 12:12 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Oct 05, 2022 at 11:30:19AM -0400, Steven Rostedt wrote:
> > On Wed, 5 Oct 2022 17:10:33 +0200
> > Florent Revest <revest@chromium.org> wrote:
> >
> > > On Wed, Oct 5, 2022 at 5:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Wed, 5 Oct 2022 22:54:15 +0800
> > > > Xu Kuohai <xukuohai@huawei.com> wrote:
> > > >
> > > > > 1.3 attach bpf prog with with direct call, bpftrace -e 'kfunc:vfs_write {}'
> > > > >
> > > > > # dd if=/dev/zero of=/dev/null count=1000000
> > > > > 1000000+0 records in
> > > > > 1000000+0 records out
> > > > > 512000000 bytes (512 MB, 488 MiB) copied, 1.72973 s, 296 MB/s
> > > > >
> > > > >
> > > > > 1.4 attach bpf prog with with indirect call, bpftrace -e 'kfunc:vfs_write {}'
> > > > >
> > > > > # dd if=/dev/zero of=/dev/null count=1000000
> > > > > 1000000+0 records in
> > > > > 1000000+0 records out
> > > > > 512000000 bytes (512 MB, 488 MiB) copied, 1.99179 s, 257 MB/s
> > >
> > > Thanks for the measurements Xu!
> > >
> > > > Can you show the implementation of the indirect call you used?
> > >
> > > Xu used my development branch here
> > > https://github.com/FlorentRevest/linux/commits/fprobe-min-args
>
> nice :) I guess you did not try to run it on x86, I had to add some small
> changes and disable HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS to compile it

Indeed, I haven't tried building on x86 yet, I'll have a look at what
I broke, thanks. :)
That branch is just an outline of the idea at this point anyway. Just
enough for performance measurements, not particularly ready for
review.

> >
> > That looks like it could be optimized quite a bit too.
> >
> > Specifically this part:
> >
> > static bool bpf_fprobe_entry(struct fprobe *fp, unsigned long ip, struct ftrace_regs *regs, void *private)
> > {
> >       struct bpf_fprobe_call_context *call_ctx = private;
> >       struct bpf_fprobe_context *fprobe_ctx = fp->ops.private;
> >       struct bpf_tramp_links *links = fprobe_ctx->links;
> >       struct bpf_tramp_links *fentry = &links[BPF_TRAMP_FENTRY];
> >       struct bpf_tramp_links *fmod_ret = &links[BPF_TRAMP_MODIFY_RETURN];
> >       struct bpf_tramp_links *fexit = &links[BPF_TRAMP_FEXIT];
> >       int i, ret;
> >
> >       memset(&call_ctx->ctx, 0, sizeof(call_ctx->ctx));
> >       call_ctx->ip = ip;
> >       for (i = 0; i < fprobe_ctx->nr_args; i++)
> >               call_ctx->args[i] = ftrace_regs_get_argument(regs, i);
> >
> >       for (i = 0; i < fentry->nr_links; i++)
> >               call_bpf_prog(fentry->links[i], &call_ctx->ctx, call_ctx->args);
> >
> >       call_ctx->args[fprobe_ctx->nr_args] = 0;
> >       for (i = 0; i < fmod_ret->nr_links; i++) {
> >               ret = call_bpf_prog(fmod_ret->links[i], &call_ctx->ctx,
> >                                     call_ctx->args);
> >
> >               if (ret) {
> >                       ftrace_regs_set_return_value(regs, ret);
> >                       ftrace_override_function_with_return(regs);
> >
> >                       bpf_fprobe_exit(fp, ip, regs, private);
> >                       return false;
> >               }
> >       }
> >
> >       return fexit->nr_links;
> > }
> >
> > There's a lot of low hanging fruit to speed up there. I wouldn't be too
> > fast to throw out this solution if it hasn't had the care that direct calls
> > have had to speed that up.
> >
> > For example, trampolines currently only allow to attach to functions with 6
> > parameters or less (3 on x86_32). You could make 7 specific callbacks, with
> > zero to 6 parameters, and unroll the argument loop.
> >
> > Would also be interesting to run perf to see where the overhead is. There
> > may be other locations to work on to make it almost as fast as direct
> > callers without the other baggage.
>
> I can boot the change and run tests in qemu but for some reason it
> won't boot on hw, so I have just perf report from qemu so far

Oh, ok, that's interesting. The changes look pretty benign (only
fprobe and arm64 specific code) I'm curious how that would break the
boot uh :p

>
> there's fprobe/rethook machinery showing out as expected
>
> jirka
>
>
> ---
> # To display the perf.data header info, please use --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 23K of event 'cpu-clock:k'
> # Event count (approx.): 5841250000
> #
> # Overhead  Command  Shared Object                                   Symbol
> # ........  .......  ..............................................  ..................................................
> #
>     18.65%  bench    [kernel.kallsyms]                               [k] syscall_enter_from_user_mode
>             |
>             ---syscall_enter_from_user_mode
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>     13.03%  bench    [kernel.kallsyms]                               [k] seqcount_lockdep_reader_access.constprop.0
>             |
>             ---seqcount_lockdep_reader_access.constprop.0
>                ktime_get_coarse_real_ts64
>                syscall_trace_enter.constprop.0
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      9.49%  bench    [kernel.kallsyms]                               [k] rethook_try_get
>             |
>             ---rethook_try_get
>                fprobe_handler
>                ftrace_trampoline
>                __x64_sys_getpgid
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      8.71%  bench    [kernel.kallsyms]                               [k] rethook_recycle
>             |
>             ---rethook_recycle
>                fprobe_handler
>                ftrace_trampoline
>                __x64_sys_getpgid
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      4.31%  bench    [kernel.kallsyms]                               [k] rcu_is_watching
>             |
>             ---rcu_is_watching
>                |
>                |--1.49%--rethook_try_get
>                |          fprobe_handler
>                |          ftrace_trampoline
>                |          __x64_sys_getpgid
>                |          do_syscall_64
>                |          entry_SYSCALL_64_after_hwframe
>                |          syscall
>                |
>                |--1.10%--do_getpgid
>                |          __x64_sys_getpgid
>                |          do_syscall_64
>                |          entry_SYSCALL_64_after_hwframe
>                |          syscall
>                |
>                |--1.02%--__bpf_prog_exit
>                |          call_bpf_prog.isra.0
>                |          bpf_fprobe_entry
>                |          fprobe_handler
>                |          ftrace_trampoline
>                |          __x64_sys_getpgid
>                |          do_syscall_64
>                |          entry_SYSCALL_64_after_hwframe
>                |          syscall
>                |
>                 --0.70%--__bpf_prog_enter
>                           call_bpf_prog.isra.0
>                           bpf_fprobe_entry
>                           fprobe_handler
>                           ftrace_trampoline
>                           __x64_sys_getpgid
>                           do_syscall_64
>                           entry_SYSCALL_64_after_hwframe
>                           syscall
>
>      2.94%  bench    [kernel.kallsyms]                               [k] lock_release
>             |
>             ---lock_release
>                |
>                |--1.51%--call_bpf_prog.isra.0
>                |          bpf_fprobe_entry
>                |          fprobe_handler
>                |          ftrace_trampoline
>                |          __x64_sys_getpgid
>                |          do_syscall_64
>                |          entry_SYSCALL_64_after_hwframe
>                |          syscall
>                |
>                 --1.43%--do_getpgid
>                           __x64_sys_getpgid
>                           do_syscall_64
>                           entry_SYSCALL_64_after_hwframe
>                           syscall
>
>      2.91%  bench    bpf_prog_21856463590f61f1_bench_trigger_fentry  [k] bpf_prog_21856463590f61f1_bench_trigger_fentry
>             |
>             ---bpf_prog_21856463590f61f1_bench_trigger_fentry
>                |
>                 --2.66%--call_bpf_prog.isra.0
>                           bpf_fprobe_entry
>                           fprobe_handler
>                           ftrace_trampoline
>                           __x64_sys_getpgid
>                           do_syscall_64
>                           entry_SYSCALL_64_after_hwframe
>                           syscall
>
>      2.69%  bench    [kernel.kallsyms]                               [k] bpf_fprobe_entry
>             |
>             ---bpf_fprobe_entry
>                fprobe_handler
>                ftrace_trampoline
>                __x64_sys_getpgid
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      2.60%  bench    [kernel.kallsyms]                               [k] lock_acquire
>             |
>             ---lock_acquire
>                |
>                |--1.34%--__bpf_prog_enter
>                |          call_bpf_prog.isra.0
>                |          bpf_fprobe_entry
>                |          fprobe_handler
>                |          ftrace_trampoline
>                |          __x64_sys_getpgid
>                |          do_syscall_64
>                |          entry_SYSCALL_64_after_hwframe
>                |          syscall
>                |
>                 --1.24%--do_getpgid
>                           __x64_sys_getpgid
>                           do_syscall_64
>                           entry_SYSCALL_64_after_hwframe
>                           syscall
>
>      2.42%  bench    [kernel.kallsyms]                               [k] syscall_exit_to_user_mode_prepare
>             |
>             ---syscall_exit_to_user_mode_prepare
>                syscall_exit_to_user_mode
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      2.37%  bench    [kernel.kallsyms]                               [k] __audit_syscall_entry
>             |
>             ---__audit_syscall_entry
>                syscall_trace_enter.constprop.0
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                |
>                 --2.36%--syscall
>
>      2.35%  bench    [kernel.kallsyms]                               [k] syscall_trace_enter.constprop.0
>             |
>             ---syscall_trace_enter.constprop.0
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      2.12%  bench    [kernel.kallsyms]                               [k] check_preemption_disabled
>             |
>             ---check_preemption_disabled
>                |
>                 --1.55%--rcu_is_watching
>                           |
>                            --0.59%--do_getpgid
>                                      __x64_sys_getpgid
>                                      do_syscall_64
>                                      entry_SYSCALL_64_after_hwframe
>                                      syscall
>
>      2.00%  bench    [kernel.kallsyms]                               [k] fprobe_handler
>             |
>             ---fprobe_handler
>                ftrace_trampoline
>                __x64_sys_getpgid
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      1.94%  bench    [kernel.kallsyms]                               [k] local_irq_disable_exit_to_user
>             |
>             ---local_irq_disable_exit_to_user
>                syscall_exit_to_user_mode
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      1.84%  bench    [kernel.kallsyms]                               [k] rcu_read_lock_sched_held
>             |
>             ---rcu_read_lock_sched_held
>                |
>                |--0.93%--lock_acquire
>                |
>                 --0.90%--lock_release
>
>      1.71%  bench    [kernel.kallsyms]                               [k] migrate_enable
>             |
>             ---migrate_enable
>                __bpf_prog_exit
>                call_bpf_prog.isra.0
>                bpf_fprobe_entry
>                fprobe_handler
>                ftrace_trampoline
>                __x64_sys_getpgid
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      1.66%  bench    [kernel.kallsyms]                               [k] call_bpf_prog.isra.0
>             |
>             ---call_bpf_prog.isra.0
>                bpf_fprobe_entry
>                fprobe_handler
>                ftrace_trampoline
>                __x64_sys_getpgid
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      1.53%  bench    [kernel.kallsyms]                               [k] __rcu_read_unlock
>             |
>             ---__rcu_read_unlock
>                |
>                |--0.86%--__bpf_prog_exit
>                |          call_bpf_prog.isra.0
>                |          bpf_fprobe_entry
>                |          fprobe_handler
>                |          ftrace_trampoline
>                |          __x64_sys_getpgid
>                |          do_syscall_64
>                |          entry_SYSCALL_64_after_hwframe
>                |          syscall
>                |
>                 --0.66%--do_getpgid
>                           __x64_sys_getpgid
>                           do_syscall_64
>                           entry_SYSCALL_64_after_hwframe
>                           syscall
>
>      1.31%  bench    [kernel.kallsyms]                               [k] debug_smp_processor_id
>             |
>             ---debug_smp_processor_id
>                |
>                 --0.77%--rcu_is_watching
>
>      1.22%  bench    [kernel.kallsyms]                               [k] migrate_disable
>             |
>             ---migrate_disable
>                __bpf_prog_enter
>                call_bpf_prog.isra.0
>                bpf_fprobe_entry
>                fprobe_handler
>                ftrace_trampoline
>                __x64_sys_getpgid
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      1.19%  bench    [kernel.kallsyms]                               [k] __bpf_prog_enter
>             |
>             ---__bpf_prog_enter
>                call_bpf_prog.isra.0
>                bpf_fprobe_entry
>                fprobe_handler
>                ftrace_trampoline
>                __x64_sys_getpgid
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      0.84%  bench    [kernel.kallsyms]                               [k] __radix_tree_lookup
>             |
>             ---__radix_tree_lookup
>                find_task_by_pid_ns
>                do_getpgid
>                __x64_sys_getpgid
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      0.82%  bench    [kernel.kallsyms]                               [k] do_getpgid
>             |
>             ---do_getpgid
>                __x64_sys_getpgid
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      0.78%  bench    [kernel.kallsyms]                               [k] debug_lockdep_rcu_enabled
>             |
>             ---debug_lockdep_rcu_enabled
>                |
>                 --0.63%--rcu_read_lock_sched_held
>
>      0.74%  bench    ftrace_trampoline                               [k] ftrace_trampoline
>             |
>             ---ftrace_trampoline
>                __x64_sys_getpgid
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      0.72%  bench    [kernel.kallsyms]                               [k] preempt_count_add
>             |
>             ---preempt_count_add
>
>      0.71%  bench    [kernel.kallsyms]                               [k] ktime_get_coarse_real_ts64
>             |
>             ---ktime_get_coarse_real_ts64
>                syscall_trace_enter.constprop.0
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      0.69%  bench    [kernel.kallsyms]                               [k] do_syscall_64
>             |
>             ---do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                |
>                 --0.68%--syscall
>
>      0.60%  bench    [kernel.kallsyms]                               [k] preempt_count_sub
>             |
>             ---preempt_count_sub
>
>      0.59%  bench    [kernel.kallsyms]                               [k] __rcu_read_lock
>             |
>             ---__rcu_read_lock
>
>      0.59%  bench    [kernel.kallsyms]                               [k] __x64_sys_getpgid
>             |
>             ---__x64_sys_getpgid
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      0.58%  bench    [kernel.kallsyms]                               [k] __audit_syscall_exit
>             |
>             ---__audit_syscall_exit
>                syscall_exit_to_user_mode_prepare
>                syscall_exit_to_user_mode
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      0.53%  bench    [kernel.kallsyms]                               [k] audit_reset_context
>             |
>             ---audit_reset_context
>                syscall_exit_to_user_mode_prepare
>                syscall_exit_to_user_mode
>                do_syscall_64
>                entry_SYSCALL_64_after_hwframe
>                syscall
>
>      0.45%  bench    [kernel.kallsyms]                               [k] rcu_read_lock_held
>      0.36%  bench    [kernel.kallsyms]                               [k] find_task_by_vpid
>      0.32%  bench    [kernel.kallsyms]                               [k] __bpf_prog_exit
>      0.26%  bench    [kernel.kallsyms]                               [k] syscall_exit_to_user_mode
>      0.20%  bench    [kernel.kallsyms]                               [k] idr_find
>      0.18%  bench    [kernel.kallsyms]                               [k] find_task_by_pid_ns
>      0.17%  bench    [kernel.kallsyms]                               [k] update_prog_stats
>      0.16%  bench    [kernel.kallsyms]                               [k] _raw_spin_unlock_irqrestore
>      0.14%  bench    [kernel.kallsyms]                               [k] pid_task
>      0.04%  bench    [kernel.kallsyms]                               [k] memchr_inv
>      0.04%  bench    [kernel.kallsyms]                               [k] smp_call_function_many_cond
>      0.03%  bench    [kernel.kallsyms]                               [k] do_user_addr_fault
>      0.03%  bench    [kernel.kallsyms]                               [k] kallsyms_expand_symbol.constprop.0
>      0.03%  bench    [kernel.kallsyms]                               [k] native_flush_tlb_global
>      0.03%  bench    [kernel.kallsyms]                               [k] __change_page_attr_set_clr
>      0.02%  bench    [kernel.kallsyms]                               [k] memcpy_erms
>      0.02%  bench    [kernel.kallsyms]                               [k] unwind_next_frame
>      0.02%  bench    [kernel.kallsyms]                               [k] copy_user_enhanced_fast_string
>      0.01%  bench    [kernel.kallsyms]                               [k] __orc_find
>      0.01%  bench    [kernel.kallsyms]                               [k] call_rcu
>      0.01%  bench    [kernel.kallsyms]                               [k] __alloc_pages
>      0.01%  bench    [kernel.kallsyms]                               [k] __purge_vmap_area_lazy
>      0.01%  bench    [kernel.kallsyms]                               [k] __softirqentry_text_start
>      0.01%  bench    [kernel.kallsyms]                               [k] __stack_depot_save
>      0.01%  bench    [kernel.kallsyms]                               [k] __up_read
>      0.01%  bench    [kernel.kallsyms]                               [k] __virt_addr_valid
>      0.01%  bench    [kernel.kallsyms]                               [k] clear_page_erms
>      0.01%  bench    [kernel.kallsyms]                               [k] deactivate_slab
>      0.01%  bench    [kernel.kallsyms]                               [k] do_check_common
>      0.01%  bench    [kernel.kallsyms]                               [k] finish_task_switch.isra.0
>      0.01%  bench    [kernel.kallsyms]                               [k] free_unref_page_list
>      0.01%  bench    [kernel.kallsyms]                               [k] ftrace_rec_iter_next
>      0.01%  bench    [kernel.kallsyms]                               [k] handle_mm_fault
>      0.01%  bench    [kernel.kallsyms]                               [k] orc_find.part.0
>      0.01%  bench    [kernel.kallsyms]                               [k] try_charge_memcg
>      0.00%  bench    [kernel.kallsyms]                               [k] ___slab_alloc
>      0.00%  bench    [kernel.kallsyms]                               [k] __fdget_pos
>      0.00%  bench    [kernel.kallsyms]                               [k] __handle_mm_fault
>      0.00%  bench    [kernel.kallsyms]                               [k] __is_insn_slot_addr
>      0.00%  bench    [kernel.kallsyms]                               [k] __kmalloc
>      0.00%  bench    [kernel.kallsyms]                               [k] __mod_lruvec_page_state
>      0.00%  bench    [kernel.kallsyms]                               [k] __mod_node_page_state
>      0.00%  bench    [kernel.kallsyms]                               [k] __mutex_lock
>      0.00%  bench    [kernel.kallsyms]                               [k] __raw_spin_lock_init
>      0.00%  bench    [kernel.kallsyms]                               [k] alloc_vmap_area
>      0.00%  bench    [kernel.kallsyms]                               [k] allocate_slab
>      0.00%  bench    [kernel.kallsyms]                               [k] audit_get_tty
>      0.00%  bench    [kernel.kallsyms]                               [k] bpf_ksym_find
>      0.00%  bench    [kernel.kallsyms]                               [k] btf_check_all_metas
>      0.00%  bench    [kernel.kallsyms]                               [k] btf_put
>      0.00%  bench    [kernel.kallsyms]                               [k] cmpxchg_double_slab.constprop.0.isra.0
>      0.00%  bench    [kernel.kallsyms]                               [k] do_fault
>      0.00%  bench    [kernel.kallsyms]                               [k] do_raw_spin_trylock
>      0.00%  bench    [kernel.kallsyms]                               [k] find_vma
>      0.00%  bench    [kernel.kallsyms]                               [k] fs_reclaim_release
>      0.00%  bench    [kernel.kallsyms]                               [k] ftrace_check_record
>      0.00%  bench    [kernel.kallsyms]                               [k] ftrace_replace_code
>      0.00%  bench    [kernel.kallsyms]                               [k] get_mem_cgroup_from_mm
>      0.00%  bench    [kernel.kallsyms]                               [k] get_page_from_freelist
>      0.00%  bench    [kernel.kallsyms]                               [k] in_gate_area_no_mm
>      0.00%  bench    [kernel.kallsyms]                               [k] in_task_stack
>      0.00%  bench    [kernel.kallsyms]                               [k] kernel_text_address
>      0.00%  bench    [kernel.kallsyms]                               [k] kernfs_fop_read_iter
>      0.00%  bench    [kernel.kallsyms]                               [k] kernfs_put_active
>      0.00%  bench    [kernel.kallsyms]                               [k] kfree
>      0.00%  bench    [kernel.kallsyms]                               [k] kmem_cache_alloc
>      0.00%  bench    [kernel.kallsyms]                               [k] ksys_read
>      0.00%  bench    [kernel.kallsyms]                               [k] lookup_address_in_pgd
>      0.00%  bench    [kernel.kallsyms]                               [k] mlock_page_drain_local
>      0.00%  bench    [kernel.kallsyms]                               [k] page_remove_rmap
>      0.00%  bench    [kernel.kallsyms]                               [k] post_alloc_hook
>      0.00%  bench    [kernel.kallsyms]                               [k] preempt_schedule_irq
>      0.00%  bench    [kernel.kallsyms]                               [k] queue_work_on
>      0.00%  bench    [kernel.kallsyms]                               [k] stack_trace_save
>      0.00%  bench    [kernel.kallsyms]                               [k] within_error_injection_list
>
>
> #
> # (Tip: To record callchains for each sample: perf record -g)
> #
>

Thanks for the measurements Jiri! :) At this point, my hypothesis is
that the biggest part of the performance hit comes from arm64 specific
code in ftrace so I would rather wait to see what Xu finds out on his
pi4. Also, I found an arm64 board today so I should soon be able to
make measurements there too.
