Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204FE6DC334
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 06:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjDJE4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 00:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDJE4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 00:56:39 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9B73C1E
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 21:56:38 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id x30so814730uaf.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 21:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681102597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62JnBfaVx0hXYbeR9SyTVLNLjarBUu+shVGi2TYHZQw=;
        b=EiYCztEn1RUaYHkrrh77dkmUO+/6HRlkfWqLWZsMtvb6ZmKT08zhOvVCRleMq5NKIl
         8MCIVV7SZpvf9l5xmuN3R8Qcp23wpLvhLG+FXsn3L8t6OUU4ljkebjR3WxgJSdEqQ/al
         rJRUy38Ki1iZoUf0LkUiXoCgj5tRUwijNKJ9NxbA3QhwAcoC4pX4rhkWMPkvqSePu4dV
         Ch/BfnhdiwmNtuA6Qc7FPAH5MZ7CwIEWCXAwX31AQo5eE/SHMFtz9KTrkPcYDybA4zyH
         6F2id4TRL7RLrm4vncFpw2BT12LuY8zFhlo1KPYNvwJk6sE3odVLaJB83iVaHSbjecih
         yHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681102597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62JnBfaVx0hXYbeR9SyTVLNLjarBUu+shVGi2TYHZQw=;
        b=RE3zFf2WqpApBTkFEfpPWAjSGBKdJeWXBmFCL8QFTbiYKwvBB8USlZ9911n92Gh+Wm
         jnp0lIQvbK/Ulcf4li82fahBgaw0Hy9NmzRjZVcHq5yuoOQVeWEqvuV960ldd33jd28V
         iG6B1wd3ZvEOg3DFkfJejmF/XTkNz4LNMRNRs0nSVakO4Bgch2SE0hqas+H3bimiGbqP
         DhEdVZCgptvm6/blsyOAlEzk1rqydaFrdHcyoP1vA1pyIXzdLxHLqiLcE5A6IG1+zIkC
         8qqrXxVxMcjlO2yTS/Hp7PtJgioYkx3JfkoZ/2WYPBwUULhCrXk2v0j8XwGV35N7q6ib
         /HsA==
X-Gm-Message-State: AAQBX9djHQ8eNz9JtOuvabf3rrZXBdkuOwtYI+tDtgsjsBVGnO0dPSIu
        GA4QXWorcSHxy6s32PVz3QnT8mLNB6Li6Bzjo6roOi3xr0s=
X-Google-Smtp-Source: AKy350aLqdAm5MtlVCwcSmxJmZL5vLzHRoBQJNI7LFFHxtF40LaEZe0GByjcmHQqy7A1s4pPKsNbCWrSyzSmbWYYVec=
X-Received: by 2002:a1f:2b44:0:b0:436:597e:2c84 with SMTP id
 r65-20020a1f2b44000000b00436597e2c84mr2882057vkr.13.1681102597318; Sun, 09
 Apr 2023 21:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com> <20230308073201.3102738-3-avagin@google.com>
 <ZDDddj50KZInqa84@chenyu5-mobl1>
In-Reply-To: <ZDDddj50KZInqa84@chenyu5-mobl1>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Sun, 9 Apr 2023 21:56:26 -0700
Message-ID: <CANaxB-y0eDExPB0v=LRPyoz1e-3tJ2VuuCmYJ3qkAERpnbz+aQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] sched: add WF_CURRENT_CPU and externise ttwu
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Andrei Vagin <avagin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 8:20=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> wrote:
>
> On 2023-03-07 at 23:31:57 -0800, Andrei Vagin wrote:
> > From: Peter Oskolkov <posk@google.com>
> >
> > Add WF_CURRENT_CPU wake flag that advices the scheduler to
> > move the wakee to the current CPU. This is useful for fast on-CPU
> > context switching use cases.
> >
> > In addition, make ttwu external rather than static so that
> > the flag could be passed to it from outside of sched/core.c.
> >
> > Signed-off-by: Peter Oskolkov <posk@google.com>
> > Signed-off-by: Andrei Vagin <avagin@google.com>
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7569,6 +7569,10 @@ select_task_rq_fair(struct task_struct *p, int p=
rev_cpu, int wake_flags)
> >       if (wake_flags & WF_TTWU) {
> >               record_wakee(p);
> >
> > +             if ((wake_flags & WF_CURRENT_CPU) &&
> > +                 cpumask_test_cpu(cpu, p->cpus_ptr))
> > +                     return cpu;
> > +
> I tried to reuse WF_CURRENT_CPU to mitigate the cross-cpu wakeup, however=
 there
> are regressions when running some workloads, and these workloads want to =
be
> spreaded on idle CPUs whenever possible.
> The reason for the regression is that, above change chooses current CPU n=
o matter
> what the load/utilization of this CPU is. So task are stacked on 1 CPU an=
d hurts
> throughput/latency. And I believe this issue would be more severe on syst=
em with
> smaller number of CPU within 1 LLC(when compared to Intel platforms), suc=
h as AMD,
> Arm64.

WF_CURRENT_CPU works only in certain conditions. Maybe you saw my
attempt to change how WF_SYNC works:

https://www.spinics.net/lists/kernel/msg4567650.html

Then we've found that this idea doesn't work well, and it is a reason
why we have the separate WF_CURRENT_CPU flag.

>
> I know WF_CURRENT_CPU benefits seccomp, and can we make this change more =
genefic
> to benefit other workloads, by making the condition to trigger WF_CURRENT=
_CPU stricter?
> Say, only current CPU has 1 runnable task, and treat current CPU as the l=
ast resort by
> checking if the wakee's previous CPU is not idle. In this way, we can ena=
ble WF_CURRENT_CPU flag
> dynamically when some condition is met(a short task for example).

We discussed all of these here and here:

https://www.spinics.net/lists/kernel/msg4657545.html

https://lore.kernel.org/lkml/CANaxB-yWkKzhhPMGXCQbtjntJbqZ40FL2qtM2hk7LLWE-=
ZpbAg@mail.gmail.com/

I like your idea about short-duration tasks, but I think it is a
separate task and it has to be done in a separate patch set. Here, I
solve the problem of optimizing synchronous switches when one task wakes
up another one and falls asleep immediately after that. Waking up the
target task on the current CPU looks reasonable for a few reasons in
this case. First, waking up a task on the current CPU is cheaper than on
another one and it is much cheaper than waking on an idle cpu.  Second,
when tasks want to do synchronous switches, they often exchange some
data, so memory caches can play on us.

Thanks,
Andrei
