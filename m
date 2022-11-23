Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A763627E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbiKWOzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiKWOzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:55:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991856F36D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:55:39 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so1638652wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chmtGnsus2siWyRYD7j8nqXM4/MnipeMsStsAl8qHxI=;
        b=sXSiYX9FDnheG+uA+L4OWQ7cU4H+RkVLIuiCZ52pOGaWPdKiTDlBZs3rzxDwU9rgnJ
         OUgOx/Ay65LZaWF2018/Vs5JCmgCaJjKGqrwu4WOyeujp1bCBz5eeTCiIJDRKBUFCca5
         4ATci4YHWxge5ITrJoZWyT6TNoR2z6KkyTZTWuQ7mzMuqpiKMQQq/kqGcuLBoAdjvwzF
         EhmvRyH4PluErXcn1nikepcPN0e8YxeYhZHgz/NU50wRogvNVfiHCWzPd9C+6m0KSEYv
         7P5MM0XJ3qBmSrqvLaCTm43LPT8dSc7P6HyXOTzGomLMcQmu3yYhUBD7TUhUhPy+8+Zv
         ZIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chmtGnsus2siWyRYD7j8nqXM4/MnipeMsStsAl8qHxI=;
        b=q+jhQi1wePX2TIr9yi8QP+NwltbvhZmvdUA3IHhFvEvIg0jl7lo858ROBbzBPLf+aO
         EB1CNU7zLtdPv07Q/UYac6hu8G8cMVUeqn6HwQ4CduHVq9BjaAkElsrUS1LaFlVcbcqL
         uGrVnX0wMF3MM0RY1KiWvPzBjit01HsoegsIiygpJ2N1Olz5+yx5rIC1axyzVdSmwDxy
         7+E9YQKF0bZYoPebJsxgx0KP7OCfxtja5MDAIhpFoykZdq7aD1c3hTS1KRpTSFMoia40
         C1kS0YYTmC6xQ2HeGjDYxUkW3OuLukL3KKVggkLaMWW6DIsHNr712IOBrxpALyRzjfv7
         ZgaA==
X-Gm-Message-State: ANoB5pkxrFHE4itiAVwh60AKuSVwfeswRv7AhHetoRhCF1/tek+pEpH8
        3op8qoL70jVSV6J9DK4emeo/ljX/Be/OTw==
X-Google-Smtp-Source: AA0mqf68Le9xPtvKc4RZeNhEjaikEX0oXlyIy9H4vyqM3h3X4CeSvuwQNQ+OpAxhsiMrq71z6E3nJw==
X-Received: by 2002:a05:600c:4d0a:b0:3c6:a7a1:eebd with SMTP id u10-20020a05600c4d0a00b003c6a7a1eebdmr19997432wmp.176.1669215337966;
        Wed, 23 Nov 2022 06:55:37 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:5fb5:228c:93d7:c5d8])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c1d0200b003c6d21a19a0sm2957487wms.29.2022.11.23.06.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:55:37 -0800 (PST)
Date:   Wed, 23 Nov 2022 15:55:31 +0100
From:   Marco Elver <elver@google.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in task_work_run (2)
Message-ID: <Y340Y2iwy3YubOk1@elver.google.com>
References: <000000000000e7513905ebf4346f@google.com>
 <20221027030304.3017-1-hdanton@sina.com>
 <CANpmjNM-FNsMn4FR2murHHKt6jsVUDCO=ETmNQe-f+jrQ+4nHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM-FNsMn4FR2murHHKt6jsVUDCO=ETmNQe-f+jrQ+4nHg@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 12:12PM +0100, Marco Elver wrote:
> On Thu, 27 Oct 2022 at 05:03, Hillf Danton <hdanton@sina.com> wrote:
> >
> > On 26 Oct 2022 11:29:35 -0700
> > > syzbot has found a reproducer for the following issue on:
> > >
> > > HEAD commit:    88619e77b33d net: stmmac: rk3588: Allow multiple gmac cont..
> > > git tree:       bpf
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1646d6f2880000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=9228d6098455bb209ec8
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bc425e880000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1126516e880000
> >
> > Grab another hold on event upon adding task work in bid to fix uaf.
> >
> > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git  88619e77b33d
> >
> > --- x/kernel/events/core.c
> > +++ c/kernel/events/core.c
> > @@ -2291,6 +2291,7 @@ event_sched_out(struct perf_event *event
> >                     !event->pending_work) {
> >                         event->pending_work = 1;
> >                         dec = false;
> > +                       atomic_long_inc(&event->refcount);
> >                         task_work_add(current, &event->pending_task, TWA_RESUME);
> >                 }
> >                 if (dec)
> > @@ -6561,6 +6562,8 @@ static void perf_pending_task(struct cal
> >         struct perf_event *event = container_of(head, struct perf_event, pending_task);
> >         int rctx;
> >
> > +       if (event->state == PERF_EVENT_STATE_DEAD)
> > +               goto out;
> >         /*
> >          * If we 'fail' here, that's OK, it means recursion is already disabled
> >          * and we won't recurse 'further'.
> > @@ -6577,6 +6580,8 @@ static void perf_pending_task(struct cal
> >         if (rctx >= 0)
> >                 perf_swevent_put_recursion_context(rctx);
> >         preempt_enable_notrace();
> > +out:
> > +       put_event(event);
> >  }
> >
> >  #ifdef CONFIG_GUEST_PERF_EVENTS
> 
> I'm not convinced this is what we want - while we could prolong the
> lifetime of an event, but if we're concurrently killing the event
> somewhere, we might as well cancel the task work (and potentially just
> skip a pending SIGTRAP). Your change most likely results in similar
> behaviour due to the DEAD check, although it prolongs the event's
> lifetime unnecessarily.

Turns out we can't cancel a task work from within another task work
properly - which apparently would be necessary, because I go this stack
trace (even with a task_work_cancel() in _free_event()):

 | BUG: KASAN: use-after-free in task_work_run+0x1b0/0x270 kernel/task_work.c:178
 | Read of size 8 at addr ffff8880752b1c18 by task syz-executor361/3766
 | 
 | CPU: 0 PID: 3766 Comm: syz-executor361 Not tainted 6.1.0-rc2-syzkaller-00073-g88619e77b33d #0
 | Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
 | Call Trace:
 |  <TASK>
 |  task_work_run+0x1b0/0x270 kernel/task_work.c:178
 |  exit_task_work include/linux/task_work.h:38 [inline]
 |  do_exit+0xb35/0x2a20 kernel/exit.c:820
 |  do_group_exit+0xd0/0x2a0 kernel/exit.c:950
 |  get_signal+0x21a1/0x2430 kernel/signal.c:2858
 |  arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 |  exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 |  exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
 |  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 |  syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
 |  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 |  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 |  </TASK>
 | 
 | Allocated by task 3766:
 |  perf_event_alloc.part.0+0x69/0x3bc0 kernel/events/core.c:11625
 |  perf_event_alloc kernel/events/core.c:12174 [inline]
 |  __do_sys_perf_event_open+0x4ae/0x32d0 kernel/events/core.c:12272
 |  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 |  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 |  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 | 
 | Freed by task 0:
 |  rcu_do_batch kernel/rcu/tree.c:2250 [inline]
 |  rcu_core+0x81f/0x1980 kernel/rcu/tree.c:2510
 |  __do_softirq+0x1f7/0xad8 kernel/softirq.c:571
 | 
 | Last potentially related work creation:
 |  call_rcu+0x99/0x820 kernel/rcu/tree.c:2798
 |  put_event kernel/events/core.c:5095 [inline]
 |  perf_event_release_kernel+0x6f2/0x940 kernel/events/core.c:5210
 |  perf_release+0x33/0x40 kernel/events/core.c:5220
 |  __fput+0x27c/0xa90 fs/file_table.c:320
 |  task_work_run+0x16b/0x270 kernel/task_work.c:179
 |  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 |  exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 |  exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 |  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 |  syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
 |  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 |  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 | 
 | Second to last potentially related work creation:
 |  task_work_add+0x7b/0x2c0 kernel/task_work.c:48
 |  event_sched_out+0xe35/0x1190 kernel/events/core.c:2294
 |  __perf_remove_from_context+0x87/0xc40 kernel/events/core.c:2359
 |  event_function+0x29e/0x3e0 kernel/events/core.c:254
 |  remote_function kernel/events/core.c:92 [inline]
 |  remote_function+0x11e/0x1a0 kernel/events/core.c:72
 |  __flush_smp_call_function_queue+0x205/0x9a0 kernel/smp.c:630
 |  __sysvec_call_function_single+0xca/0x4d0 arch/x86/kernel/smp.c:248
 |  sysvec_call_function_single+0x8e/0xc0 arch/x86/kernel/smp.c:243
 |  asm_sysvec_call_function_single+0x16/0x20 arch/x86/include/asm/idtentry.h:657
 | 
 | The buggy address belongs to the object at ffff8880752b17c0
 |  which belongs to the cache perf_event of size 1392
 | The buggy address is located 1112 bytes inside of
 |  1392-byte region [ffff8880752b17c0, ffff8880752b1d30)
 | 
 | [...]

My guess is that the __fput task work is in the same task as the perf
task work, and so if we tried to cancel the task work from within
__fput, it won't actually cancel it if task_work_run() already exchanged
the 'task_works' list.

So it looks like prolonging the perf events lifetime is the only option
right now?

Peter, any preferences?

Thanks,
-- Marco
