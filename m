Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B893627AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiKNKhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbiKNKhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:37:10 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929B01DDC2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:37:06 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id r2so5493914ilg.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kUfZpgyT1aXwhu6NA1BbyyvFD5NqbthpSkv4Q+l4OA8=;
        b=oUGODufunBtb8c8mH3rQb9Wx+RvO55bpVkl8eb7+3fbojnnIJdbHIOXZMBMC3Xu9Za
         wAu8ocwg5VAP9PP+Wcx2iIJzgExBVcJ0QevN14MqQLRpafDwpDlMWHrnSUwyTeQfbHyG
         ubZh4EzfcuYWrpX9fY2MZjVXF8iAfpfBdetsPx/RAkEzRTW/JItz4mLFwDZLBqILI1QU
         DauXdQ30QadQsP3/0CYTm6Yhl3cOx+hGLzmSmoJOKVVV6PmCxJlDx+f5Kdax3LQKO+Ps
         clIyHZBfBFnwhXsmNQ0IWRfzznGWA410D/Q11FRbhVh0EtXsQ9OHtru0VjYwXI+Y8Jd+
         4EDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUfZpgyT1aXwhu6NA1BbyyvFD5NqbthpSkv4Q+l4OA8=;
        b=kdFQ6X+e+NUvSQ/n8gNSwLnUFV6QrZRjSGb9aDCCm+BfnX5m06w4UQcekeUwgoH0fn
         bKZ3TctJioOlvP0GvOk6IcAzgY46hc7W7Z7k/fn4BHPkIpal53vltcHc14e/SXO8FKTz
         TW8F9ypd3f0EcnfmuEkxCumXCi4mrGyE+ldA/qqGqpvN3aau5d5b/4OXyhS0aCtR9xRf
         sYyggba0smyX4WDezGPC/aBgC9PjQ5FKUIfss6ZYNBmg1DnFJdd24r/1sh2n3ba6Mo74
         AvDy046kE8+TJKLHZ46IDfLg1G2MBZEE/Hwi9tDiExdmi9786S99JD2RyeajDBgVX2M1
         ddsA==
X-Gm-Message-State: ANoB5pmztBqR5nO8NN5UFumi2Qx/PsNJkM0KmgEJqZCWryauLzFJed8T
        fGHU4xRLEuUqqAEtDA0lpnFn9JhKzg80vdlnhoTKHA==
X-Google-Smtp-Source: AA0mqf7flPzb5Zj/eQlu7L+vqCycSWHuRxGckQCi/bOssCCHcJ1enUhjf97ctWlLvjd/sPjBDPvbPydPzaBOJCYa0fE=
X-Received: by 2002:a92:6c0b:0:b0:2fa:f47:d960 with SMTP id
 h11-20020a926c0b000000b002fa0f47d960mr5805051ilc.19.1668422225948; Mon, 14
 Nov 2022 02:37:05 -0800 (PST)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-6-vincent.guittot@linaro.org> <dbdb2a45-5e81-7cb8-04c6-e10c0e1a3184@linux.vnet.ibm.com>
In-Reply-To: <dbdb2a45-5e81-7cb8-04c6-e10c0e1a3184@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Nov 2022 11:36:54 +0100
Message-ID: <CAKfTPtBTd61tcDbVkm=3a8+xwHCbn5QHCkdmqWcvudzZND1AFQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] sched/fair: Take into account latency priority at wakeup
To:     shrikanth suresh hegde <sshegde@linux.vnet.ibm.com>
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Nov 2022 at 09:51, shrikanth suresh hegde
<sshegde@linux.vnet.ibm.com> wrote:
>
>
> >   /*
> >    * Preempt the current task with a newly woken task if needed:
> >    */
> > @@ -4566,7 +4568,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >   {
> >       unsigned long ideal_runtime, delta_exec;
> >       struct sched_entity *se;
> > -     s64 delta;
> > +     s64 delta, offset;
> >
> >       ideal_runtime = sched_slice(cfs_rq, curr);
> >       delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
> > @@ -4591,10 +4593,12 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >       se = __pick_first_entity(cfs_rq);
> >       delta = curr->vruntime - se->vruntime;
> >
> > -     if (delta < 0)
> > +     offset = wakeup_latency_gran(curr, se);
> > +     if (delta < offset)
> >               return;
> >
> > -     if (delta > ideal_runtime)
> > +     if ((delta > ideal_runtime) ||
> > +         (delta > get_latency_max()))
> >               resched_curr(rq_of(cfs_rq));
> >   }
> >
> >
> Hi Vincent,
>
> I am not sure if i have understood this below change correctly.

I assume you wanted to say above as you removed the end of the patch

>
> wakeup_latency_gran - this function returns difference in latency nice offsets.
> Hence the more negative the value, it means se has more latency requirement
> compared to current. Hence se should preempt the current here right?

yes. the latency nice offset can add a offset in the comparison of (delta < 0)


>
> we are comparing delta to get_latency_max and ideal_runtime, both of which can
> be higher positive value, hence we will not preempt. that is not what we want
> right?

Here we are in the tick and not in the wakeup path. So the wakeup
preemption, if any, should have already happened and we now have to
make sure that if current has not been preempted at wakeup, it will
not get too much run time that will move waiting tasks out of the
sched_latency period

>
