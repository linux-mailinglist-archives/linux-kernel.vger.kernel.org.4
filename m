Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247CC72D0A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbjFLUgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbjFLUgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:36:04 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1EC1BC3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:35:22 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bc7ebb912dcso2098444276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1686602121; x=1689194121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tna/5MCpfh2CQQ+MigqWyTaJ1L9g7ThuMJA32e33y4A=;
        b=uPpOK67x/N/0dc7FRfJMGN81wHOiBPP7oDiOdsaD2qzpV+B/MTdEuYG39oOXu6v2gr
         JgevcePW5R1c5j7nMJXFkhpJ6BguEKUjC2vWog8KmEpSwxXPP7lOjzwK+Y2qLmn2Ixhq
         x737RZxkBLsn9MrwiUjsL2CBe7fs7JxdrA5ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602121; x=1689194121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tna/5MCpfh2CQQ+MigqWyTaJ1L9g7ThuMJA32e33y4A=;
        b=aoZCtTBXr05RelVMl6HujbmKCh+KTGWq1TacKc2Fjo3i8xWjcjq0RCW5cv0SCS1t/B
         q0zOaIrcuPaMCYA4lLI1F6i4M+AgYOBO1YXkJWdPyh0kbif+lZ1AXwlwjJ+jiDGr/gST
         yus16C18Mu8StItigVEXwAO9irSSzQnLmQjr1rXc82w0ymocND4ZRbmVz7x9k4k/isyF
         GIAgXFiAk+vTBddM4/5ELObdJDLenv4fF/5Rkm9e9KCUKUPxu6ovxsjPYtZBcK7RN0be
         AfVM0cmBiFAaDL/h6cfgVIOxZ4aySYnrjNPcrhJSfstFHSGWTyLW0LfbMUP/Zj7AdsTV
         lHiA==
X-Gm-Message-State: AC+VfDwiTtTDE/sWpAYpmRj5OCc8T+1AWIBfv2GOskDaz9nV31Bz1U7u
        RqXqfmibCdVtypn78shwxk9RqQTl4M/wPE9GBPWMu3lzUzJ8srji
X-Google-Smtp-Source: ACHHUZ5KcAQLLhVj7lmkq1gne9ElkQhjBzZ4S38AHrzzjOqMReAkePS2tJqdbLBT1dpZWqeO5d0fbOOH7l9Xn+lZaRI=
X-Received: by 2002:a25:b46:0:b0:bc4:72c4:b8e2 with SMTP id
 67-20020a250b46000000b00bc472c4b8e2mr7930703ybl.21.1686602121296; Mon, 12 Jun
 2023 13:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686239016.git.bristot@kernel.org> <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
 <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com> <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org>
In-Reply-To: <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 12 Jun 2023 16:35:10 -0400
Message-ID: <CAEXW_YR9Tfw5KyFU7TQtYE02k+DpaMXH=osx9Ws5w_j1YpHxhg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel!

On Mon, Jun 12, 2023 at 1:21=E2=80=AFPM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
[...]
> > On Thu, Jun 8, 2023 at 11:58=E2=80=AFAM Daniel Bristot de Oliveira
> > <bristot@kernel.org> wrote:
> >>
> >> From: Juri Lelli <juri.lelli@redhat.com>
> >>
> >> Starting deadline server for lower priority classes right away when
> >> first task is enqueued might break guarantees, as tasks belonging to
> >> intermediate priority classes could be uselessly preempted. E.g., a we=
ll
> >> behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
> >> there are still CPU cycles available for NORMAL tasks to run, as they'=
ll
> >> be running inside the fair deadline server for some period of time.
> >>
> >> To prevent this issue, implement a starvation monitor mechanism that
> >> starts the deadline server only if a (fair in this case) task hasn't
> >> been scheduled for some interval of time after it has been enqueued.
> >> Use pick/put functions to manage starvation monitor status.
> >
> > Me and Vineeth were discussing that another way of resolving this
> > issue is to use a DL-server for RT as well, and then using a smaller
> > deadline  for RT. That way the RT is more likely to be selected due to
> > its earlier deadline/period.
>
> It would not be that different from what we have now.
>
> One of the problems of throttling nowadays is that it accounts for a larg=
e window
> of time, and any "imprecision" can cause the mechanism not to work as exp=
ected.
>
> For example, we work on a fully-isolated CPU scenario, where some very sp=
oradic
> workload can be placed on the isolated CPU because of per-cpu kernel acti=
vities,
> e.g., kworkers... We need to let them run, but for a minimal amount of ti=
me, for
> instance, 20 us, to bound the interference.
>
> The current mechanism does not give this precision because the IRQ accoun=
ting
> does not account for runtime for the rt throttling (which makes sense).

I lost you here, "Runtime for the rt throttling" does not make much
sense to me as a statement.

> So the
> RT throttling has the 20 us stolen from IRQs and keeps running. The same =
will
> happen if we swap the current mechanism with a DL server for the RT.

I read this about 10 times to learn that *maybe* you mean that IRQs
stole time from the "Well behaved running time" of the RT class. I am
not seeing how that is related to creation of a DL-server for the RT
class. Maybe describe your point a bit more clearly?

>
> Also, thinking about short deadlines to fake a fixed priority is... not s=
tarting
> well. A fixed-priority higher instance is not a property of a deadline-ba=
sed
> scheduler, and Linux has a fixed-priority hierarchy: STOP -> DL -> RT -> =
CFS...
> It is simple, and that is good.
>
> That is why it is better to boost CFS instead of throttling RT. By boosti=
ng
> CFS, you do not need a server for RT, and we account for anything on top =
of CFS
> for free (IRQ/DL/FIFO...).

I did mention in my last email that it is not ideal. I just brought it
up as an option. It might reduce the problem being seen and is better
than not having it.

> > Another approach could be to implement the 0-laxity scheduling as a
> > general SCHED_DEADLINE feature, perhaps through a flag. And allow DL
> > tasks to opt-in to 0-laxity scheduling unless there are idle cycles.
> > And then opt-in the feature for the CFS deadline server task.
>
> A 0-laxity scheduler is not as simple as it sounds, as the priority also =
depends
> on the "C" (runtime, generally WCET), which is hard to find and embeds
> pessimism. Also, having such a feature would make other mechanisms harder=
, as
> well as debugging things. For example, proxy-execution or a more precise
> schedulability test...

I think you did not read my email properly, I was saying make the
0-laxity default-off and the opt-in for certain DL tasks. That may
work perfectly well for a system like ChromeOS where likely we will
use the DL server as the sole deadline task and opt-in for the
0-laxity. Then we don't need watchdog hacks at all and it all cleanly
works within the DL class itself. There are the drawbacks of the
pessimism/locking  etc (I already knew that by the way as the obvious
drawbacks of 0-laxity) but I am not immediately seeing how this
CFS-watchdog with 0-laxity is any different from the DL-server itself
having such a property. If you really have a concrete point on why
that won't work, and if you could clarify that more clearly why a
watchdog is better than it, that would be great.

> In a paper, the scheduler alone is the solution. In real life, the soluti=
on
> for problems like locking is as fundamental as the scheduler. We need to =
keep
> things simple to expand on these other topics as well.
>
> So, I do not think we need all the drawbacks of a mixed solution to just =
fix
> the throttling problem, and EDF is more capable and explored for the
> general case.

Again, I was saying making it opt-in seems like a reasonable approach
and just enabling such property for the DL server.

> With this patch's idea (and expansions), we can fix the throttling proble=
m
> without breaking other behaviors like scheduling order...

I don't mind the watchdog patch as such, of course. I presented its
mechanics at OSSNA and I know how it works, but I feel the DL server
opting-in for 0-laxity would be cleaner while keeping such behavior as
default-off for regular DL uses, that's my opinion -- but what else am
I missing?  Either way, no harm in discussing alternate approaches as
well even if we are settling for the watchdog.

> > Lastly, if the goal is to remove RT throttling code eventually, are
> > you also planning to remove RT group scheduling as well? Are there
> > users of RT group scheduling that might be impacted? On the other
> > hand, RT throttling / group scheduling code can be left as it is
> > (perhaps documenting it as deprecated) and the server stuff can be
> > implemented via a CONFIG option.
>
> I think that the idea is to have the DL servers eventually replace the gr=
oup
> schedule. But I also believe that it is better to start by solving the
> throttling and then moving to other constructions on top of the mechanism=
.

Hmm. For throttling at the root level yes, but  I am not seeing how
you can replace the group scheduling code for existing users of RT
Cgroups with this. The throttling in the RT group scheduling code is
not exactly only about "not starving CFS", it is more related to
letting RT groups run with certain bandwidth. So you cannot really
delete it if there are real users of that code -- you'll have to
migrate those users away first (to an alternate implementation like
DL).  If there are no users of RT group scheduling, that's lovely
though. We don't use it in ChromeOS fwiw.

- Joel
