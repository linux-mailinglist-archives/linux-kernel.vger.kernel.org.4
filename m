Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C14F6FFE2A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbjELAwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjELAwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:52:38 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EED54C3E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 17:52:37 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3ef34c49cb9so894371cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683852756; x=1686444756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGt7XvztPoU2+SAzWDZV94SrMYmoPfEkg7iGBCsgMsY=;
        b=58DjcIqQzx/Nx80LHlV1KPOL+NOIHHX3EzYogrDcdcbU+7w24gJ7cOADnZILgOHr0q
         IMr6s/jyki/uxFyihR29fQbATNKJE9mYIR2qhmd2U2V94pT8w1VINvpPt++G5TSEqxUD
         xeAP7DtKt7REtodiKPK7LqsTztJSeLptzPahVQOfTGJ3T5h7m+Ffl7NioJeYnETCnmCV
         +oGFFWw6ILxzCSROGFVWcFIHERpXKdwdEjBQJ/InlWzkR0ELIA5+2WPQ9zoviBtYwISS
         G3lPqlSFEf+OqgVwi815/WXF0M+CttNuyHxJHqoM5/v/Y8E6xoQLRErT00DZP/Qc0z7Z
         sryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683852756; x=1686444756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGt7XvztPoU2+SAzWDZV94SrMYmoPfEkg7iGBCsgMsY=;
        b=D3tIAvu7wTpHk6/WI8ctlN0/4bX6wVmqW0UxkztPHbic/q8IhIGjiN1KzCD4YgSEQ8
         CDBvNaGycmdMSkVEBS1EzyLTYjaHCOJmi1OH7xIbSg0GovULUasyg5iXmYNKuZHG93YJ
         Ld/KyXr8NqyHH28uBb20/XbgAgmNdUT9GW6sq2AK87a5xZwTwAiomEMdY92jqFzKRwrV
         s3OAiCQwkPlwiSOMs+ZAWL+pXlskpqfZcUJBhD8TtUEt+WHNX51lXeaMDZC7tPnde8k7
         P7PrWBne9Sgu7czORD2IJEeXQIY8J/3Ci1AKeQnMhF8AdaNwsIf97/jfUe6J6t/Wu4Ya
         tl6w==
X-Gm-Message-State: AC+VfDx0zKBj5waYP07wM5a8YVE8OvwMAazKON89s45pCiGXKMzo8utx
        jct0jXV0vcgUkOLJIKxdK1UUA7mkmjbrl7SvBwhw
X-Google-Smtp-Source: ACHHUZ77e8wbJchadgIQmEQ1P5Br+jtt2kfcR6W3fPs6+kgDzZLLnn7C1nUOpvunSHXX4K+THypl/IAFfE9fGhYHw88=
X-Received: by 2002:ac8:5dd1:0:b0:3ef:3083:a437 with SMTP id
 e17-20020ac85dd1000000b003ef3083a437mr207476qtx.18.1683852756301; Thu, 11 May
 2023 17:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230406194053.876844-1-arve@android.com> <20230511214144.1924757-1-jstultz@google.com>
 <20230511223124.GJ2296992@hirez.programming.kicks-ass.net>
In-Reply-To: <20230511223124.GJ2296992@hirez.programming.kicks-ass.net>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 11 May 2023 17:52:24 -0700
Message-ID: <CANDhNCp-na5EE2o9furCtnm1Fz_WAaHpWh24e1sbwc-U+=ktog@mail.gmail.com>
Subject: Re: [PATCH] sched/wait: Fix a kthread_park race with wait_woken()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
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

On Thu, May 11, 2023 at 3:31=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, May 11, 2023 at 09:41:30PM +0000, John Stultz wrote:
> > From: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> >
> > kthread_park and wait_woken have a similar race that kthread_stop and
> > wait_woken used to have before it was fixed in
> > cb6538e740d7543cd989128625cf8cac4b471e0a. Extend that fix to also cover
>
>   cb6538e740d7 ("sched/wait: Fix a kthread race with wait_woken()")
>
> > kthread_park.
> >
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> > Signed-off-by: John Stultz <jstultz@google.com>
> > ---
> > This seemingly slipped by, so I wanted to resend it
> > for review.
> > ---
> >  kernel/sched/wait.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> > index 133b74730738..a9cf49da884b 100644
> > --- a/kernel/sched/wait.c
> > +++ b/kernel/sched/wait.c
> > @@ -425,9 +425,9 @@ int autoremove_wake_function(struct wait_queue_entr=
y *wq_entry, unsigned mode, i
> >  }
> >  EXPORT_SYMBOL(autoremove_wake_function);
> >
> > -static inline bool is_kthread_should_stop(void)
> > +static inline bool is_kthread_should_stop_or_park(void)
> >  {
> > -     return (current->flags & PF_KTHREAD) && kthread_should_stop();
> > +     return (current->flags & PF_KTHREAD) && (kthread_should_stop() ||=
 kthread_should_park());
> >  }
> >
> >  /*
>
> That's a bit sad; that two function calls for checking two consecutive
> bits in the same word :-(
>
> If we move this to kthread.c and write it like:
>
>         kthread =3D __to_kthread(current);
>         if (!kthread)
>                 return false;
>
>         return test_bit(KTHREAD_SHOULD_STOP, &kthread->flags) ||
>                test_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
>
> Then the compiler should be able to merge the two bits in a single load
> and test due to constant_test_bit() -- do check though.

Hrm. Apologies, as it's been awhile since I've looked at disassembled
asm, so I may be wrong, but I don't think that's happening here.

With the logic above I'm seeing it build as:
0000000000000a50 <kthread_should_stop_or_park>:
     a50:       65 48 8b 14 25 00 00    mov    %gs:0x0,%rdx
     a57:       00 00
     a59:       48 8b 8a 78 0a 00 00    mov    0xa78(%rdx),%rcx
     a60:       31 c0                   xor    %eax,%eax
     a62:       48 85 c9                test   %rcx,%rcx
     a65:       74 11                   je     a78
<kthread_should_stop_or_park+0x28>
     a67:       f6 42 2e 20             testb  $0x20,0x2e(%rdx)
     a6b:       74 0b                   je     a78
<kthread_should_stop_or_park+0x28>
     a6d:       48 8b 01                mov    (%rcx),%rax
     a70:       48 d1 e8                shr    %rax
     a73:       83 e0 01                and    $0x1,%eax
     a76:       74 05                   je     a7d
<kthread_should_stop_or_park+0x2d>
     a78:       e9 00 00 00 00          jmp    a7d
<kthread_should_stop_or_park+0x2d>
     a7d:       48 8b 01                mov    (%rcx),%rax
     a80:       48 c1 e8 02             shr    $0x2,%rax
     a84:       83 e0 01                and    $0x1,%eax
     a87:       e9 00 00 00 00          jmp    a8c
<kthread_should_stop_or_park+0x3c>
     a8c:       0f 1f 40 00             nopl   0x0(%rax)


Where as if I drop the second test_bit() to see if it was similar, I see:
0000000000000a50 <kthread_should_stop_or_park>:
     a50:       65 48 8b 14 25 00 00    mov    %gs:0x0,%rdx
     a57:       00 00
     a59:       48 8b 8a 78 0a 00 00    mov    0xa78(%rdx),%rcx
     a60:       31 c0                   xor    %eax,%eax
     a62:       48 85 c9                test   %rcx,%rcx
     a65:       74 14                   je     a7b
<kthread_should_stop_or_park+0x2b>
     a67:       f6 42 2e 20             testb  $0x20,0x2e(%rdx)
     a6b:       74 0e                   je     a7b
<kthread_should_stop_or_park+0x2b>
     a6d:       48 8b 01                mov    (%rcx),%rax
     a70:       48 d1 e8                shr    %rax
     a73:       83 e0 01                and    $0x1,%eax
     a76:       e9 00 00 00 00          jmp    a7b
<kthread_should_stop_or_park+0x2b>
     a7b:       e9 00 00 00 00          jmp    a80
<__pfx_kthread_freezable_should_stop>


Despite that, should I still re-submit the change this way?

thanks
-john
