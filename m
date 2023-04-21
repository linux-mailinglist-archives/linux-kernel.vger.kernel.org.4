Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8228D6EADC6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDUPLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjDUPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:11:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30543D32A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:11:03 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-518d325b8a2so2279129a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682089862; x=1684681862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6FaXoYkKJvHqik7V6/lHszSapOB8DXJHGCFiR9DavU=;
        b=MY4dMcKPtmfefWBSJwFWazfdvvF90KDinQ9nmY1Q8uwOjsr0eyWsv7dRFcTtNOKhie
         /F74SLFHoXkmGe2ljsQiGBYNOXxisfk2szEmRc7IPcFJhFvsm1AljpiagJvlYPNfo7Yb
         z9DN/4tl2GFtD0Kmf02wqFw98YzVaW65ti8jpyPfegGr7igzJEd5Nu6BhcsQHWItT2kG
         zVflS859lRQyk+8y6YpsIF4cHBUrcGO0+EMWeuANUoo001Y2EEx/fHwT2CL482Vog+dC
         KLMTW+NtLcsVl68L6vVJoMywB8g1oVNdjyDYltncfBRr+no5wEEikDenXCU2Y5TJa1LL
         Vnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089862; x=1684681862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6FaXoYkKJvHqik7V6/lHszSapOB8DXJHGCFiR9DavU=;
        b=gwmehkP+N5evc7EWlW/NdeXXl0UxsLRr6l1BIUTkJnhf6fpM7drThUfHRvtlCAtPLt
         7tl5w3OPDfy1Jwntzxb8Xy0rdd79EfG9ZttmhD61MRtZPee1ywuS5z+GsQICpXXAlnAc
         d5yqT6SO0qeNJnw78ZKuWi0CxOTglUNIbui1XTvJNhu2tkGHrW3ryp8EZAW3mgrK2XXR
         0WwWCZ0CXaGXBsTwBJuSOlWIXBphp1bKWr+xmImvfEEFauN1CsYK2WQ+sYpz7zykNCtp
         0sJf9SEBeATz/0twFyVRjwyazJdYc/aWrj+jOMyuEHUR1sk+YmN4R2As8/DH8R/xe2zb
         xtSA==
X-Gm-Message-State: AAQBX9dXZjn8X4dJn8IsiH8Mjrr3J3bTqaLcUCBA3PfjSOAkaLBmH8Iq
        fWUscmpZUhpRcu6PnlAPZxHMP0C+aOcuSgEuFYsgdA==
X-Google-Smtp-Source: AKy350ZeHOdgTFbV9bRp9hOfo9A6H5eKIZwRoj8/gMFvoMUuwXkKiCLwWI7n1GE8VMq6MLsPCQmh4HmKyLMoXJHA9RM=
X-Received: by 2002:a17:90b:4f47:b0:236:73d5:82cf with SMTP id
 pj7-20020a17090b4f4700b0023673d582cfmr5168643pjb.9.1682089862559; Fri, 21 Apr
 2023 08:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230416213406.2966521-1-davidai@google.com> <d83950c4-7458-aeea-f341-327c163704a8@arm.com>
 <CABN1KC+_HDi_i2zzpZVbqiUP5-QB9YrE5wzLqr==_wOemaCXzA@mail.gmail.com>
 <bf8f21be-7249-fc27-9704-211d0f5a12b1@arm.com> <CAKfTPtAgkyE1xntn-4u9o8DFhH9iGq54c-QXYr0cE+zvoPx9Gw@mail.gmail.com>
 <CAGETcx-suryHeB3wpaTSZBiw6+VwA7pe=GnrbtizSVj+C9Smtg@mail.gmail.com>
In-Reply-To: <CAGETcx-suryHeB3wpaTSZBiw6+VwA7pe=GnrbtizSVj+C9Smtg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Apr 2023 17:10:51 +0200
Message-ID: <CAKfTPtAfLqzwbCdd25HCFykBDhBQs9g7Mr6=X56nKYOOPnEdNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce SCHED_FLAG_RESET_UCLAMP_ON_FORK
 flag
To:     Saravana Kannan <saravanak@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 at 18:26, Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Apr 20, 2023 at 6:44=E2=80=AFAM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Thu, 20 Apr 2023 at 11:37, Dietmar Eggemann <dietmar.eggemann@arm.co=
m> wrote:
> > >
> > > On 20/04/2023 03:11, David Dai wrote:
> > > > On Tue, Apr 18, 2023 at 10:18=E2=80=AFPM Dietmar Eggemann
> > > > <dietmar.eggemann@arm.com> wrote:
> > > >>
> > > >
> > > > Hi Dietmar, thanks for your time,
> > > >
> > > >> On 16/04/2023 23:34, David Dai wrote:
> > > >>> A userspace service may manage uclamp dynamically for individual =
tasks and
> > > >>> a child task will unintentionally inherit a pesudo-random uclamp =
setting.
> > > >>> This could result in the child task being stuck with a static ucl=
amp value
> > > >>
> > > >> Could you explain this with a little bit more detail? Why isn't th=
e
> > > >> child task also managed by the userspace service?
> > > >
> > > > See Qais=E2=80=99 reply that contains more detail on how it=E2=80=
=99s being used in
> > > > Android. In general, if a dynamic userspace service will adjust ucl=
amp
> > > > on the fly for a given task, but has no knowledge or control over i=
f
> > > > or when a task forks. Depending on the timing of the fork, a child
> > > > task may inherit a very large or a small uclamp_min or uclamp_max
> > > > value. The intent of this patch is to provide more flexibility to t=
he
> > > > uclamp APIs such that child tasks do not get stuck with a poor ucla=
mp
> > > > value when spawned while retaining other sched attributes. When
> > > > RESET_ON_FORK is set on the parent task, it will reset uclamp value=
s
> > > > for the child but also reset other sched attributes as well.
> > >
> > > OK, in this case, why not just change behavior and always reset the
> > > uclamp values at fork?
> > >
> > > Do we anticipate a use-case in which uclamp inheritance would be requ=
ired?
> > >
> > > Let's not over-complicate the sched_[sg]etattr() unnecessarily.
> >
> > I was about to ask the same question and I'm aligned with Dietmar.
> > Use RESET_ON_FORK and set all attributes
>
> That's racy though. If we have an external service (that's only
> responsible for setting uclamp) setting all the attributes, the forked
> thread could also be trying to set some of the attributes. Also, how
> is this external service going to keep track of all the threads being
> forked and set the right attributes for all of them?

My assumption was that you didn't use RESET_ON_FORK because there were
other attributes that you wanted to keep from parent but it doesn't
seem to be the case so use RESET_ON_FORK and if needed the forked
thread will set its other attributes

>
> If it's not considered a UAPI breakage, I'd rather we never inherit uclam=
p.
>
> -Saravana
>
> >
> > >
> > > [...]
> > >
> > > >> Does this issue happen with uclamp mainline or only with Android's
> > > >> slightly different version (max- vs. sum aggregation)?
> > > >
> > > > I=E2=80=99m using the version of uclamp that=E2=80=99s in Linus=E2=
=80=99 tree. How uclamp is
> > > > aggregated is unrelated to the problem I=E2=80=99m trying to solve =
with this
> > > > patch. Which is to extend the uclamp APIs to have finer control for
> > > > the uclamp inheritance of child tasks.
> > >
> > > OK, I see.
