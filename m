Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08D619AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiKDO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiKDO5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:57:14 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B2A2EF7B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:57:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 8so3205258qka.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pXs7a80MiRrSN/mYyVru9Ezoiw99Yr3cn9WHrmdzdQ8=;
        b=L0ntIMSt29Ou6sORuv3iEguMcfRIzzXYWwwc8JBNq0zOqVPhnzfrnBtDxEc32HRuq1
         Yext8W+wEO0oEEeWhHxiPmebdKWDYedEAC+vUSN36IYO2FQUun/UhuqF/IHikB+1RjZp
         Wp79SpqiK5AH3/x8iX4UtI0gUf3tqSRcN3qHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXs7a80MiRrSN/mYyVru9Ezoiw99Yr3cn9WHrmdzdQ8=;
        b=ve42sJjdb6U4nBoJiUA660MRn8hQJVJOWEBZOsBg5Tf9wGTJH60lAtswlTmt5NXwKC
         zaE9vJSUozMMXuDx6Pl+1TB8XO6y54UVHL5oSljSkljAWQ5vgnii0g5+C6BqU60Ehnrp
         t9b7b++hOlfRbJ2usXro/w+GIeXmBmPTdFUlF5ndNvO+w1wYK8RtXp2cJ679XUtcQdka
         GgSwIswXPhrfM//b/oyPJY+dSt1xXPY0c7BXrzIE7UYDxom+3ymhayDJbLzG4rOnmgty
         sUyf/7s9lLa2sCmiFg2QsfkJTg2vh090CiGG035RbXJaM625sz/uzGdC5Xwmgt71P0Yv
         blhw==
X-Gm-Message-State: ACrzQf1TMX1cOgY9rHBrUdCCdH9Q1mBot4TwDpX+aI51+yEqCrXD1ER2
        bsminx4Xf/e1Hwbgx2U8uNUfBA==
X-Google-Smtp-Source: AMsMyM4Rol8Kyro6eny0h2a1BmJu9IBp9fwpzOL5VakSmL7H0PJgwmLFaGpJOP5lpC7boV3iqmsmhg==
X-Received: by 2002:a05:620a:2042:b0:6fa:2168:9cd with SMTP id d2-20020a05620a204200b006fa216809cdmr22780273qka.729.1667573832427;
        Fri, 04 Nov 2022 07:57:12 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ff23-20020a05622a4d9700b00359961365f1sm2539916qtb.68.2022.11.04.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:57:11 -0700 (PDT)
Date:   Fri, 4 Nov 2022 14:57:11 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
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
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
Message-ID: <Y2UoR9LqxWInJ90t@google.com>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org>
 <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
 <20221103142732.m5ibwkuymvhcdxkn@airbuntu>
 <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
 <20221104112138.hlnwjmw2ls4gswuo@airbuntu>
 <CAKfTPtAuJvV117iwnpVpajC6nWPzagtTMk+8NPnGVyukygiFMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAuJvV117iwnpVpajC6nWPzagtTMk+8NPnGVyukygiFMg@mail.gmail.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:24:23PM +0100, Vincent Guittot wrote:
> On Fri, 4 Nov 2022 at 12:21, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 11/03/22 18:02, Vincent Guittot wrote:
> > > On Thu, 3 Nov 2022 at 15:27, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 11/03/22 09:46, Vincent Guittot wrote:
> > > > > On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrote:
> > > > > >
> > > > > > On 10/28/22 11:34, Vincent Guittot wrote:
> > > > > > > Task can set its latency priority with sched_setattr(), which is then used
> > > > > > > to set the latency offset of its sched_enity, but sched group entities
> > > > > > > still have the default latency offset value.
> > > > > > >
> > > > > > > Add a latency.nice field in cpu cgroup controller to set the latency
> > > > > > > priority of the group similarly to sched_setattr(). The latency priority
> > > > > > > is then used to set the offset of the sched_entities of the group.
> > > > > > >
> > > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > > ---
> > > > > > >  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> > > > > > >  kernel/sched/core.c                     | 52 +++++++++++++++++++++++++
> > > > > > >  kernel/sched/fair.c                     | 33 ++++++++++++++++
> > > > > > >  kernel/sched/sched.h                    |  4 ++
> > > > > > >  4 files changed, 97 insertions(+)
> > > > > > >
> > > > > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > > > > > index be4a77baf784..d8ae7e411f9c 100644
> > > > > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > > > > @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
> > > > > > >          values similar to the sched_setattr(2). This maximum utilization
> > > > > > >          value is used to clamp the task specific maximum utilization clamp.
> > > > > > >
> > > > > > > +  cpu.latency.nice
> > > > > > > +     A read-write single value file which exists on non-root
> > > > > > > +     cgroups.  The default is "0".
> > > > > > > +
> > > > > > > +     The nice value is in the range [-20, 19].
> > > > > > > +
> > > > > > > +     This interface file allows reading and setting latency using the
> > > > > > > +     same values used by sched_setattr(2).
> > > > > >
> > > > > > I'm still not sure about this [1].
> > > > >
> > > > > I'm still not sure about what you are trying to say here ...
> > > > >
> > > > > This is about setting a latency nice prio to a group level.
> > > > >
> > > > > >
> > > > > > In some scenarios we'd like to get the effective latency_nice of the task. How
> > > > > > will the task inherit the cgroup value or be impacted by it?
> > > > > >
> > > > > > For example if there are tasks that belong to a latency sensitive cgroup; and
> > > > > > I'd like to skip some searches in EAS to improve that latency sensitivity - how
> > > > > > would I extract this info in EAS path given these tasks are using default
> > > > > > latency_nice value? And if should happen if their latency_nice is set to
> > > > > > something else other than default?
> > > > > >
> > > > > > [1] https://lore.kernel.org/lkml/20221012160734.hrkb5jcjdq7r23pr@wubuntu/
> > > > >
> > > > > Hmm so you are speaking about something that is not part of the patch.
> > > > > Let focus on the patchset for now
> > > >
> > > > I am focusing on this patchset. Isn't this an essential part of the design?
> > > > Once the interface is out we can't change it. As it stands, I can't see how it
> > >
> > > So, are you speaking about the interface i.e. setting a value between [-20:19]
> >
> > About how the cgroup and per task interface interact.
> >
> > How to get the effective value of latency_nice for a task that belongs to
> > a hierarchy?
> 
> At the common parents level of the 2 entities that you want to compare
> and root level if there no other entity to compare with
> 
> >
> > If I have a task that has p->latency_nice = 20 but it belongs to a cgroup that
> > has tg->cpu.latency.nice = -19
> 
> according to what i said above, latency_nice = 20 inside the group and
> -19 when comparing at the parent level
> 
> >
> > And I want to use this interface in EAS; how should I interpret these values?
> > How should I walk up the hierarchy and decide the _effective_ latency_nice
> > value?
> 
> The current use of latency_nice doesn't need to walk the hierarchy
> because it applies at each scheduling level so the childs
> automatically follow parents' latency.

Not really, I don't see how that will work that way in the wake up path. The
wake up path (EAS in particular) does not walk through CPU controller group
hierarchy from top level, it only cares about cpuset/affinities and the
"effective" values of tasks.

So when you wake up a task, how will you retrieve the attribute for 'prefer
idle' in the wakeup path using this patchset? The only way is to aggregate
the CGroup hierarchy information to get a per-task effective value; say using
a min function.

If you see uclamp_rq_util_with(), that also is using doing uclamp
aggregation similarly.

So I think Qais is asking about the aggregation function in the EAS wakeup
path.

Thanks.
