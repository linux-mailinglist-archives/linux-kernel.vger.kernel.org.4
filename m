Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF57961954C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKDLVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKDLVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:21:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5781EADF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:21:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k8so6651672wrh.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CPJQLTqgqhkUtx+2R1QXT7VFUlZrxBQTxeHe3kJSttw=;
        b=8Qimd9U5PhbMIg+/GlAePDse4ywOBiN7eINMxWz3i9/jKG0cRrQckxiLoIJe1mJ290
         E9B6nMviD7+Omz6lWF5zvOAgra6q69XLLLSwnfr56oRJeKIwRDyRRtcdOr/aqhL1yUcP
         /khEI4rlfXFxp3g3QOW7GMiO5JWtG8Lo7Ca9QmutXM1wk+Nlz9TtWoRdh+QhmHnGnVRk
         bXBGVeDkTz63KO6OYSy5wHAFDSqCLhOhiAA5OAbH8Yh7lmxbKaw7VX76yIuiUS+twqmb
         3rky3CKqGgOOYQlAfMYcPw+KdDT1DfVY86FGFfNqFrhjJ5g/i6pFtlGcXmhQUnEdKCKy
         KLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPJQLTqgqhkUtx+2R1QXT7VFUlZrxBQTxeHe3kJSttw=;
        b=8EuBZkyjjKk8SpHX4Q8Es7ojWCNAl7LyTYI3DsUryWc1CplqK650ohAspp7fMGIrwD
         fiGfWKqOdINhkNx0S15L4e3HXApQNX4hB0VCn0cfhycCGuTSZ+KZiKNDKiP+B3LctV3J
         8/GkmZHens5OgpVUUz8FkiVgvJCQeaEAnyooE1a5DB4sC0OG1/6ww4pNWhtQGR/2ISRQ
         1j9MVGXdfEy94c4DSr/z/iN03EJ5en9l6rNE0+zUncFLgZiJLJabRZF9fAszU3iaN1jC
         dYlcq/5dWdv6Mmtcfx6iUCRw6fRPyktEiEp4WDDzWHiTm2ka+o8Upm2/UGCKS/sbQzpC
         tuRg==
X-Gm-Message-State: ACrzQf3y3Zt/weG6Rt33WteoUDQ+Yff1yayMZhb7V2q7hujMCSu5rgmI
        MlcHOQ21J6HBppeti6lTp2iQuQ==
X-Google-Smtp-Source: AMsMyM4tUCN9isR4czNaxRl0x6dvAYhQV88rJLiz84ONdqwnifZ9ftZfWrE+zPxDWcGHO2f6GwkJpA==
X-Received: by 2002:a5d:52d0:0:b0:21e:4923:fa09 with SMTP id r16-20020a5d52d0000000b0021e4923fa09mr22761436wrv.244.1667560900482;
        Fri, 04 Nov 2022 04:21:40 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d6606000000b00238df11940fsm3182343wru.16.2022.11.04.04.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:21:40 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:21:38 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
Message-ID: <20221104112138.hlnwjmw2ls4gswuo@airbuntu>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org>
 <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
 <20221103142732.m5ibwkuymvhcdxkn@airbuntu>
 <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/22 18:02, Vincent Guittot wrote:
> On Thu, 3 Nov 2022 at 15:27, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 11/03/22 09:46, Vincent Guittot wrote:
> > > On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 10/28/22 11:34, Vincent Guittot wrote:
> > > > > Task can set its latency priority with sched_setattr(), which is then used
> > > > > to set the latency offset of its sched_enity, but sched group entities
> > > > > still have the default latency offset value.
> > > > >
> > > > > Add a latency.nice field in cpu cgroup controller to set the latency
> > > > > priority of the group similarly to sched_setattr(). The latency priority
> > > > > is then used to set the offset of the sched_entities of the group.
> > > > >
> > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > ---
> > > > >  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> > > > >  kernel/sched/core.c                     | 52 +++++++++++++++++++++++++
> > > > >  kernel/sched/fair.c                     | 33 ++++++++++++++++
> > > > >  kernel/sched/sched.h                    |  4 ++
> > > > >  4 files changed, 97 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > > > index be4a77baf784..d8ae7e411f9c 100644
> > > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > > @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
> > > > >          values similar to the sched_setattr(2). This maximum utilization
> > > > >          value is used to clamp the task specific maximum utilization clamp.
> > > > >
> > > > > +  cpu.latency.nice
> > > > > +     A read-write single value file which exists on non-root
> > > > > +     cgroups.  The default is "0".
> > > > > +
> > > > > +     The nice value is in the range [-20, 19].
> > > > > +
> > > > > +     This interface file allows reading and setting latency using the
> > > > > +     same values used by sched_setattr(2).
> > > >
> > > > I'm still not sure about this [1].
> > >
> > > I'm still not sure about what you are trying to say here ...
> > >
> > > This is about setting a latency nice prio to a group level.
> > >
> > > >
> > > > In some scenarios we'd like to get the effective latency_nice of the task. How
> > > > will the task inherit the cgroup value or be impacted by it?
> > > >
> > > > For example if there are tasks that belong to a latency sensitive cgroup; and
> > > > I'd like to skip some searches in EAS to improve that latency sensitivity - how
> > > > would I extract this info in EAS path given these tasks are using default
> > > > latency_nice value? And if should happen if their latency_nice is set to
> > > > something else other than default?
> > > >
> > > > [1] https://lore.kernel.org/lkml/20221012160734.hrkb5jcjdq7r23pr@wubuntu/
> > >
> > > Hmm so you are speaking about something that is not part of the patch.
> > > Let focus on the patchset for now
> >
> > I am focusing on this patchset. Isn't this an essential part of the design?
> > Once the interface is out we can't change it. As it stands, I can't see how it
> 
> So, are you speaking about the interface i.e. setting a value between [-20:19]

About how the cgroup and per task interface interact.

How to get the effective value of latency_nice for a task that belongs to
a hierarchy?

If I have a task that has p->latency_nice = 20 but it belongs to a cgroup that
has tg->cpu.latency.nice = -19

And I want to use this interface in EAS; how should I interpret these values?
How should I walk up the hierarchy and decide the _effective_ latency_nice
value?

> 
> > can be used to replace prefer_idle in cgroup as used in Android. I can't see
> > how this could happen if we don't define how the task will inherit the cgroup
> > value. If we can, mind elaborating how please?
> 
> Or how to take into account the value set for a cgroup ?

Yes that. How to calculate effective value in a hierarchy taking parents,
children and task latency_nice values into account.

> 
> Regarding the behavior, the rule remains the same that a sched_entity
> attached to a cgroup will not get more (latency in this case) than
> what has been set for the group entity.

So it behaves like a limit as described in cgroup-v2.rst? Is this enforced in
the series?


Thanks

--
Qais Yousef

> 
> >
> >
> > Thanks
> >
> > --
> > Qais Yousef
