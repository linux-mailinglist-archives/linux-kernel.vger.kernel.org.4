Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED945BD132
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiISPjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiISPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:39:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F46463E4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:39:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id c7so22947382ljm.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BjstHUcG1b9c4lXIMYaiIxLcV+RFGNGSeHkYMGDVm24=;
        b=lNXQ1tnAZnbdX3F2/TDyMxjxK9ZTpUFY+3AJ0Va+/QFk6CQ2Bb9/zaT/H5tK9wyUNh
         u/fJBm36WLNpQpzQ03RTy1T3kEV2M6/TZ+IKfH6hmgXjU2goSkHZTa9IH+RkRixp6l+m
         GlPOyfWLVPsH641paiEb5vptDq5NpAdZlalNyf2TnudeXrzHiCyygKcNZVACtfRnbbM2
         E1eA/TkxvmWRqccEgYOziXU/nfcpUQQLG2XLlvnehxPahKxrxiE6EZaCHrfLq9Hggjr2
         eH07CC68KvazOZAQkDSWSWaVZjuW/+B3V3+2EnumE+M6ea99tCkH7pMFCxrBR+CHAo7u
         /ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BjstHUcG1b9c4lXIMYaiIxLcV+RFGNGSeHkYMGDVm24=;
        b=C18osnUqdUqCvByUuVwpJ/1pykW6h7b72ZF6REKn5AyTyyw4Ekv03FHSfp+/T9mlnR
         TO0OaJnURa55kXEQXrw11idc6ojOAbbct0WtsqAHEUOREoazADbw+Ft6Rh/v56HhovA3
         xilX2kl1J1JfRHvob+2+SxfZQPFC33GpJusN4+KKSme/va4zulQS5oq9NcyHlWtjp721
         5EMnYzkd6/cBRdoPXvylRCcQtQONde2mqL8CAFFGEl5UYnFE4F3rfiqWHwqVA/JEM9WS
         yhX526kq3g70TVj+QrEIOjc2wwUrDLaIpZSpF7wsml3vRdZS9YEM6jui98ic7LDv9Gyp
         DaoQ==
X-Gm-Message-State: ACrzQf3mSbDBTZymRRUbe54ULnP7BS9yoY2u64vTXFNhlPznRpSK0TLq
        YcPSgvvlkbcXtyhf2Mw1wi4UPIRD1z5JdUXRtnr6JQ==
X-Google-Smtp-Source: AMsMyM5j7eq6Wj2UNHu8v8Z/Pc35FCfhaCw9MLQKGUzd1DSvzwpWWbOzbaBLSwZKf4K2fPVO0eIcrN3uHW/iSR+8nG0=
X-Received: by 2002:a2e:bf01:0:b0:25f:df1a:f39d with SMTP id
 c1-20020a2ebf01000000b0025fdf1af39dmr5735699ljr.365.1663601978334; Mon, 19
 Sep 2022 08:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-6-vincent.guittot@linaro.org> <073938c4-ab23-2270-8e60-291f2901e230@arm.com>
In-Reply-To: <073938c4-ab23-2270-8e60-291f2901e230@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 19 Sep 2022 17:39:26 +0200
Message-ID: <CAKfTPtCWE5O4TeTBG8hgar8w56-WzvmX7aR9D7dXN_vJ5LCLyQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] sched/fair: Take into account latency priority at wakeup
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sept 2022 at 12:05, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 16/09/2022 10:03, Vincent Guittot wrote:
>
> [...]
>
> > @@ -4512,7 +4519,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
> >       p->prio = current->normal_prio;
> >
> >       /* Propagate the parent's latency requirements to the child as well */
> > -     p->latency_nice = current->latency_nice;
> > +     p->latency_prio = current->latency_prio;
>
> Isn't here a `set_latency_offset(p)` missing here?

Hmm, I think it's the opposite and the line above is a nop from the
beginning (i.e. patch 2).

>
> >
> >       uclamp_fork(p);
> >
>
> [...]
>
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e8c1b889dcbb..a20eadb0af97 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4574,6 +4574,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >               update_idle_cfs_rq_clock_pelt(cfs_rq);
> >  }
> >
> > +static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se);
>
> minor: `struct sched_entity *curr` ... doesn't have to be current
> (cfs_rq->curr). Isn't this more like `struct sched_entity *sea, struct
> sched_entity *seb`? Anyway, it's already the case for
> `wakeup_preempt_entity`.
>
> [...]
>
> > @@ -5732,6 +5735,35 @@ static int sched_idle_cpu(int cpu)
> >  }
> >  #endif
> >
> > +static void set_next_buddy(struct sched_entity *se);
> > +
> > +static void check_preempt_from_others(struct cfs_rq *cfs, struct sched_entity *se)
>
> minor: Why `struct cfs_rq *cfs` and not `struct cfs_rq *cfs_rq` ?
>
> Using `cfs_rq` would make it more consistent when looking for things
> like `cfs_rq->nr_running` for example.
>
> > +{
> > +     struct sched_entity *next;
> > +
> > +     if (se->latency_offset >= 0)
> > +             return;
> > +
> > +     if (cfs->nr_running <= 1)
> > +             return;
> > +     /*
> > +      * When waking from idle, we don't need to check to preempt at wakeup
>
> s/idle/others ?

yes, I forgot to update the comment

>
> > +      * the idle thread and don't set next buddy as a candidate for being
> > +      * picked in priority.
> > +      * In case of simultaneous wakeup from idle, the latency sensitive tasks
> > +      * lost opportunity to preempt non sensitive tasks which woke up
> > +      * simultaneously.
> > +      */
>
> The position of this comment block within this function is somehow
> misleading since it describes the reason for the function rather then a
> particular condition within this function. Wouldn't it be more readable
> when it would be a function header comment instead?

I put it after the usual early return tests to put the comment close
to the useful part: the use of next buddy and __pick_first_entity()

>
> [...]
>
> > @@ -7148,6 +7181,22 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  }
> >  #endif /* CONFIG_SMP */
> >
> > +static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se)
> > +{
> > +     long latency_offset = se->latency_offset;
> > +
> > +     /*
> > +      * A negative latency weigth means that the sched_entity has latency
>
> s/weigth/latency_offset ?

yes

>
>
> > +      * requirement that needs to be evaluated versus other entity.
> > +      * Otherwise, use the latency weight to evaluate how much scheduling
> > +      * delay is acceptable by se.
> > +      */
> > +     if ((se->latency_offset < 0) || (curr->latency_offset < 0))
> > +             latency_offset -= curr->latency_offset;
>
> I still don't get the rationale behind why when either one (se or curr)
> of the latency_nice values is negative, we use the diff between them but
> if not, we only care about se's value. Why don't you always use the diff
> between se and curr? Since we have a range [-20 ... 19] why shouldn't we
> use the difference between let's say se = 19 and curr = 5?
> You discussed this with Tao Zhou on the v1 but I didn't understand it fully.

Let say that current has a latency nice prio of 19 and a task A with a
latency nice of 10 wakes up. Both tasks don't care about scheduling
latency (current more than task A). If we use the diff, the output of
wakeup_latency_gran() would be negative (-10ms) which reflects the
fact that the waking task is sensitive to the latency and wants to
preempt current even if its vruntime is after. But obviously both
current and task A don't care to preempt at wakeup.

>
> [...]
