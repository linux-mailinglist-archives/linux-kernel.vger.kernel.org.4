Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602BA5F6896
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiJFNx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiJFNxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:53:51 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFCA10FC9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:53:50 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i9so1018926ilv.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=j82tXFpkFT8gaTZpH0xHG4IZWHD6j85pZ1RQ1Pt6oWY=;
        b=Z0nXhBFk7XorjhfYiV6Hj0A9Xq+KR/UDEsWUs+QZIIIQmmIVPWlRoKlX1E6GPTW0Ed
         IDVpIYez7XxQpZwYRgYSg7cqX324L5M8q7Q1o++5Gg216CaZb52SlHl92qyKtvWv6lfs
         CrXGbIjnGNybixcnKq0gFlIryucedpvEhHaPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=j82tXFpkFT8gaTZpH0xHG4IZWHD6j85pZ1RQ1Pt6oWY=;
        b=5V1HRO4s0afqQS0qgdbetENMu5JP4OzMCPVsO6EldmYhVssVXBSHik1B+835bHGCFa
         dSVUkYfiigjkeISjmicKEttXGhhVHdXojSgW5w2hWsb3Dfz5n1auxiWin/A41GnJk/le
         a3+gM+1cDc6++/IAFW5v1Op6d5su0GAMwhT6xAenRgCvRbnu7C8/4DdeCn0N+FPA0MAJ
         jigMZGv2xETP16l5dORiuq2Mw0gTa9QD/txGLQwPMZoVJlcZ0evOcWdDiph1v8jNEqKv
         zto9yo+RjEUn2wvEudHOirdyBH65OJW0YyKBlNHq/UpA0SSWYQcBLROpj7V+2858ZDES
         nviQ==
X-Gm-Message-State: ACrzQf2U+IeXCnWWxZi5qmj3/1QdQJU7NuVc/1dr9Eo1lwruB3YyZF0C
        OYxcdz11BstXfuXhq3CzBZjmcceQ7oE8n99v9ZAJaf15AaQ=
X-Google-Smtp-Source: AMsMyM6j/BtUZ3Z41ozctM3MmRdCmMfh/u7Dn3TvnLXbmLMMymsjIDqC82JhSGUFi/WwVL+OoBBwraOcWQKsOo2FM+s=
X-Received: by 2002:a05:6e02:1b0f:b0:2f6:bfb1:8916 with SMTP id
 i15-20020a056e021b0f00b002f6bfb18916mr2416524ilv.148.1665064429485; Thu, 06
 Oct 2022 06:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu> <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
 <20221003161404.kdow5uyj7kvbqyxs@wubuntu> <bb28d85a-c50f-a25f-aeb4-672eecb75b55@joelfernandes.org>
 <20221005100402.3i46oqx5lxsw2qer@wubuntu>
In-Reply-To: <20221005100402.3i46oqx5lxsw2qer@wubuntu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 6 Oct 2022 09:53:38 -0400
Message-ID: <CAEXW_YSPBzjvWaFqhvYpO=RFyjKR0uTPChUwScNsFnEaZupsVQ@mail.gmail.com>
Subject: Re: Sum of weights idea for CFS PI
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Youssef Esmat <youssefesmat@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 6:04 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Joel
>
> On 10/04/22 16:27, Joel Fernandes wrote:
>
> [...]
>
> > I am treating the following the same:
> >
> >       a.  when A is running, it would be as above.
> >       b.  but if A was sleeping, B, C, and D would get 1/3.
> >
> >  similar to
> >
> >       a.  when A is running *and blocked on C for all its runtime*
> >               ^^ -- in this case, B and D should not have their distributions
> >                     changed at all because they are not participating in the
> >                     lock acquire and release. So they should neither be hurt
> >                     any more, nor be boosted. They should simply stay same [1]
> >
> >       b.  but if A was sleeping, B, C, and D would get 1/3.
> >
> >
> > [1] Why? Consider 3 tasks in the all-RT case, A high, B medium and C low prio.
> >
> > If all are running 100% and A does not block on C, B is blocked by A
> > indefinitely. So the prio of A and B are inverted. We seek to rectify this, that
> > is we need make changes such that, B is returned back to the blocked state. We
> > do this by boosting C.
> >
> > In other words, the prio inheritance will cause B's distribution to not be
> > changed (it was supposed to be blocked before and it is now going to be blocked
> > state again).
> >
> > CFS should not behave any differently, B's distribution should not be changed
> > before/after the priority inhertiance of A by C. That's just my opinion - and
> > that's how I calculated to distribution. With that mind, could you go back to
> > seeing if my math was originally correct or did I mess something up?
>
> It's not about the math. But I think the before and after can't be the same for
> C..

C is acquiring/releasing the lock so I expect its distribution to
change. I was talking about the poor B who has nothing to do with the
lock.

> > > I don't think this is valid. If A is blocked on C for 50% of the time, and
> > > sleeping for 50% of the time, when did it get blocked/unblocked?
> > >
> > > This will have an impact on the average share for C and skew it, no?
> > >
> > > Unless I missed something, the average share of C being (3/5 + 1/3) is an
> > > impossible state. You need to consider the portion of time when C runs as 1/5,
> > > when A is actually not blocked on anything, too.
> > >
> > > Hmm actually I just re-read your statement below and you just say 3/5 (18/30)
> > > is too much. You didn't consider the average. I'll leave the above in hope to
> > > help me understand what am I missing and where I went wrong :-)
> > >
> > > Generally IMHO looking at the average will not help. I think if the share
> > > values make sense in each state individually (and I believe they are), that
> > > would be enough. AFAICS, B and D are still taking the right amount of time when
> > > C inherits the bandwidth. And C by definition will run longer when A is blocked
> > > on it for the whole duration of this blocked time.
> >
> > I was degenerating the case where A sleeps (say I/O) vs A blocks, to simplify
> > the math, and then taking average of that. I think that's reasonable?
>
> I'm not sure. This is skewing the results in my view.
>
> I think the comparison should just be:
>
> 1) A, B, C, and D are all running and nothing gets blocked at all. Then shares
>    would be:
>
>    2/5, 1/5, 1/5, 1/5
>
> 2) A is blocked and C; B, C, D are running with no blocked time. Shares would
>    be:
>
>    - , 1/5, 3/5, 1/5
>
> By definition, we want to treat A in (2) as RUNNING because as soon as
> C unblocks A we should return to (1). From B and D perspective, their share is
> not impacted throughout this transition. Which is AFAIU is what we want to
> achieve.
>
> I think considering the sleeping time and averaging can lead to misleading
> results if care is not taken.

Yes, but that doesn't mean we can just ignore it. It is easy in my
view to skew the inherited weight to a very large number, only to find
that tasks unrelated to the lock acquire/release are "suffering"
though they had nothing to do with the lock or the PI. But it is
reasonable to try the simple approach first and see the impact.

I also never said the averaging approach or consideration of sleeping
time is perfect ;-)

> Anyway - just trying to explain how I see it and why C is unlikely to be taking
> too much time. I could be wrong. As Youssef said, I think there's no
> fundamental problem here.

I know on Android where they use smaller HZ, the large tick causes
lots of problems for large nice deltas. Example if a highly niced task
was to be preempted for 1ms, and preempts instead at 3ms, then the
less-niced task will not be so nice (even less nice than it promised
to be) any more because of the 2ms boost that the higher niced task
got. This can lead the the sched_latency thrown out of the window. Not
adjusting the weights properly can potentially make that problem much
worse IMO.

Thanks.
