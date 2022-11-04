Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76128619444
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiKDKPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKDKPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:15:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E8629CA4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:15:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 21so6911923edv.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 03:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVn5TJYiroJv/K/sO5rbvPlTKOYI+y0PAMWggqqQgYE=;
        b=e82UZy+Nhu8tkCgMDxA5kfcraAhCOOHetYKAVyf0WNFNE/PkOGbYJPKi07KYWLMteb
         3HCQ3yTPkC01eHTzu+qLm8kPyNUlMHc27x4tpHhM/173R/ULWRVdFgBs1k3frrb+RoTo
         nAJUd4IvqvN2iGPSTxYsLi+wF6VJatyRLTYuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVn5TJYiroJv/K/sO5rbvPlTKOYI+y0PAMWggqqQgYE=;
        b=ouE6jnHtgLKyZ0o0nc/kCaxtXi5jdjcCMQfLGMIktqdcAdVP9SbhEy3RzfyCCyBUrf
         OqMNfXuV7TrHDBV/NKcpNGCUQAxwsg0K4J0yOBF+wyhyWk8TdeDzeo/X62HhIzv0Hp1W
         LT2kw+mRAmlevHpJdWOZifwxN8USDrqCPZ5FXRBqwgMkkoC35I44ffdFs58/T84A85Q0
         2AA6gN+hYhh0H4fIkFRznXKLurYKDQzDJFgif9VZKO0gnP3/2uJ0apIpngDASl3v+396
         NRGBMWYHsnUrCv12U7WUtGCjUHsVR45ldalZ+ez4m3xWbhEacjH5kha7JGzZXEiQWZFE
         haeA==
X-Gm-Message-State: ACrzQf2qmWUYVJyyEhEBzVCNQRl9blZDYqbN5ii+Fthp2epsiy4IemJm
        JFeyhx9ZSxRuh5W2CofsDoqtsE/v/2courAuD9ZkCQ==
X-Google-Smtp-Source: AMsMyM7Ksw01y0zDOiEjWaUs2VZAW6ZWCcllIAGuVcrk5atZz/UKRjjEyTxDzh8s4d+zeP0kkcYkvu9YDQBSzdgBadw=
X-Received: by 2002:a05:6402:174f:b0:463:12ed:3f8f with SMTP id
 v15-20020a056402174f00b0046312ed3f8fmr32949898edx.67.1667556901577; Fri, 04
 Nov 2022 03:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org> <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
 <20221103142732.m5ibwkuymvhcdxkn@airbuntu> <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
In-Reply-To: <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 4 Nov 2022 10:14:50 +0000
Message-ID: <CAEXW_YQd2y9=RHw3Sge7ghnhBz0AyR+B-U4zG10LXuSbg5bGSA@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 5:03 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 3 Nov 2022 at 15:27, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 11/03/22 09:46, Vincent Guittot wrote:
> > > On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 10/28/22 11:34, Vincent Guittot wrote:
> > > > > Task can set its latency priority with sched_setattr(), which is =
then used
> > > > > to set the latency offset of its sched_enity, but sched group ent=
ities
> > > > > still have the default latency offset value.
> > > > >
> > > > > Add a latency.nice field in cpu cgroup controller to set the late=
ncy
> > > > > priority of the group similarly to sched_setattr(). The latency p=
riority
> > > > > is then used to set the offset of the sched_entities of the group=
.
> > > > >
> > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > ---
> > > > >  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> > > > >  kernel/sched/core.c                     | 52 +++++++++++++++++++=
++++++
> > > > >  kernel/sched/fair.c                     | 33 ++++++++++++++++
> > > > >  kernel/sched/sched.h                    |  4 ++
> > > > >  4 files changed, 97 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentat=
ion/admin-guide/cgroup-v2.rst
> > > > > index be4a77baf784..d8ae7e411f9c 100644
> > > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > > @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
> > > > >          values similar to the sched_setattr(2). This maximum uti=
lization
> > > > >          value is used to clamp the task specific maximum utiliza=
tion clamp.
> > > > >
> > > > > +  cpu.latency.nice
> > > > > +     A read-write single value file which exists on non-root
> > > > > +     cgroups.  The default is "0".
> > > > > +
> > > > > +     The nice value is in the range [-20, 19].
> > > > > +
> > > > > +     This interface file allows reading and setting latency usin=
g the
> > > > > +     same values used by sched_setattr(2).
> > > >
> > > > I'm still not sure about this [1].
> > >
> > > I'm still not sure about what you are trying to say here ...
> > >
> > > This is about setting a latency nice prio to a group level.
> > >
> > > >
> > > > In some scenarios we'd like to get the effective latency_nice of th=
e task. How
> > > > will the task inherit the cgroup value or be impacted by it?
> > > >
> > > > For example if there are tasks that belong to a latency sensitive c=
group; and
> > > > I'd like to skip some searches in EAS to improve that latency sensi=
tivity - how
> > > > would I extract this info in EAS path given these tasks are using d=
efault
> > > > latency_nice value? And if should happen if their latency_nice is s=
et to
> > > > something else other than default?
> > > >
> > > > [1] https://lore.kernel.org/lkml/20221012160734.hrkb5jcjdq7r23pr@wu=
buntu/
> > >
> > > Hmm so you are speaking about something that is not part of the patch=
.
> > > Let focus on the patchset for now
> >
> > I am focusing on this patchset. Isn't this an essential part of the des=
ign?
> > Once the interface is out we can't change it. As it stands, I can't see=
 how it
>
> So, are you speaking about the interface i.e. setting a value between [-2=
0:19]
>
> > can be used to replace prefer_idle in cgroup as used in Android. I can'=
t see
> > how this could happen if we don't define how the task will inherit the =
cgroup
> > value. If we can, mind elaborating how please?
>
> Or how to take into account the value set for a cgroup ?
>
> Regarding the behavior, the rule remains the same that a sched_entity
> attached to a cgroup will not get more (latency in this case) than
> what has been set for the group entity.

I think the interface solves a different problem which is latency of
task or cgroup wrt other group. Vincent, you are setting this for a
=E2=80=9Ctop app=E2=80=9D group in android in your tests, and seeing improv=
ement
correct? AFAICS, this improvement comes because of lower latency
during *same CPU* competition between different groups by juggling
around the wakeup-preemption window -- which maybe is good for
Android.

OTOH, the =E2=80=9Cprefer idle=E2=80=9D flag in android that Qais is referr=
ing to,
will need a completely different method as I cannot see how a nice
value can communicate that (that can complement Vincent's changes
here). And it will need to have a per-task interface as well. We have
something in ChromeOS as well, which is a proc knob and also
out-of-tree patch for that [1]. Without [1] we fail Android CTS
testing on a recent ARM64 ChromeOS device.
[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/3884575
The changelog in [1] also has a detailed description of the ChromeOS usecas=
e.

Qais, any other reason you can see why Vincent's change will not be a
good thing for Android? Since you 1 CGroup for the whole user-facing
app (top app), you can just set that to a low "latency_nice" and get
better wake-up latency for that.

(Side rant about latency and CFS -- IMHO a better long term solution
for lower latency is to use RT but don't throttle -- rather demote. Or
break CFS into multiple tiers, and apply demotion. This is in a way
what Vincent is doing, as the task becomes more CPU bound'ish, he's
taking away the latency boost. Vincent/Qais, somebody was working on
the RT demotion vs throttling a while back, any idea on the latest on
that?).

thanks,

 - Joel


>
> >
> >
> > Thanks
> >
> > --
> > Qais Yousef
