Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F6A69E23B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjBUOWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjBUOWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:22:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631832886A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:22:06 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c23so188755pjo.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V7OOFYL+9a+DRriFIjyujp84znXjDZJVpnPQuMpQ90k=;
        b=uxXrXBivm84NQWwQYwLWkE3/QZuLMx8nAcxbhDvr3LCb32j58QCfPCWF9PRiwKN4rU
         bQcv+JQNONAnY/fDXnUVEM4w8U+O+CGCxIJG1roGRgJ7H6wvq6YF1NN4Ne530NS4O3OA
         Zbk6VkeDag4aHh9BFe7ZRabDCWJNb8m//dz6aToW0Lr7knW8nlgSJ4p8L/tMaWefru6W
         OK33p5NlRRDuk07EUn0aNKUfOQ9ZWZ9QliQCHlxevjzfprRpmncMGHGQP00ShcI8L1pG
         QW4WWlvOIPACNzDF/TEj3aU5hjRkeoELxyF6v3hqo6wzD38unTh3BufChDvkRbHTShn/
         KxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7OOFYL+9a+DRriFIjyujp84znXjDZJVpnPQuMpQ90k=;
        b=Csv30+zpLLE8H5Eb2gcCE6ne9Z+VCv2o1LQOJqgiI3XpBbcEV/luCHyUCjg5gpcFU9
         UwVSByz3YQjpOfD/HpPYt1TsS4u7rzRzBgpsaOy0KlsKGpSbN27jfCP501DtLqlX+fDa
         23p4fI8KrtnG2LCUgNh2iwF3BidRjLKBMdd6reeNUwqgKoUL9LQhb2FL8L9FJPgJnVJn
         lDV1zNWDclwqZV4nPn+1DbzGzwGCozfEBgXok8KBqO965p9dx4KIssipZAJ3vgRsUgxA
         wkTcGawoLT/vRme+1zP9YJEonlZn+XnYjnUyNrO+IrwKLwbSdAvQokJih8FtBWXeBW2y
         xHTw==
X-Gm-Message-State: AO0yUKW79t3BW6exJjfWbeytAr2R2kkPyXFIXCCGfT2kBLRx4ODc0T29
        V0jy/3K9b5/uJIiyar25A6vXCNy+j73xZbla29k9JA==
X-Google-Smtp-Source: AK7set+iK43TPWam+9Zj5i0P3RH21aXfv/HEmqvUC7dXOWrzdgAtUXYZftSsp58vvsBdi194m3WuRxlbsS8NJTdyzKo=
X-Received: by 2002:a17:90b:3946:b0:233:f98e:3a37 with SMTP id
 oe6-20020a17090b394600b00233f98e3a37mr1149844pjb.15.1676989325638; Tue, 21
 Feb 2023 06:22:05 -0800 (PST)
MIME-Version: 1.0
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-6-vincent.guittot@linaro.org> <Y/TBdB23akBbUjqd@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/TBdB23akBbUjqd@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Feb 2023 15:21:54 +0100
Message-ID: <CAKfTPtAk2A8zPgOfpbN0s4LZv+d7ABB9=5tAEMCbVrf263XtjA@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] sched/fair: Take into account latency priority at wakeup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 at 14:05, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 13, 2023 at 03:12:30PM +0100, Vincent Guittot wrote:
> > @@ -6155,6 +6159,35 @@ static int sched_idle_cpu(int cpu)
> >  }
> >  #endif
> >
> > +static void set_next_buddy(struct sched_entity *se);
> > +
> > +static void check_preempt_from_others(struct cfs_rq *cfs, struct sched_entity *se)
> > +{
> > +     struct sched_entity *next;
> > +
> > +     if (se->latency_offset >= 0)
> > +             return;
> > +
> > +     if (cfs->nr_running <= 1)
> > +             return;
> > +     /*
> > +      * When waking from another class, we don't need to check to preempt at
> > +      * wakeup and don't set next buddy as a candidate for being picked in
> > +      * priority.
> > +      * In case of simultaneous wakeup when current is another class, the
> > +      * latency sensitive tasks lost opportunity to preempt non sensitive
> > +      * tasks which woke up simultaneously.
> > +      */
> > +
> > +     if (cfs->next)
> > +             next = cfs->next;
> > +     else
> > +             next = __pick_first_entity(cfs);
> > +
> > +     if (next && wakeup_preempt_entity(next, se) == 1)
> > +             set_next_buddy(se);
> > +}
> > +
> >  /*
> >   * The enqueue_task method is called before nr_running is
> >   * increased. Here we update the fair scheduling stats and
> > @@ -6241,14 +6274,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >       if (!task_new)
> >               update_overutilized_status(rq);
> >
> > +     if (rq->curr->sched_class != &fair_sched_class)
> > +             check_preempt_from_others(cfs_rq_of(&p->se), &p->se);
> > +
> >  enqueue_throttle:
> >       assert_list_leaf_cfs_rq(rq);
> >
> >       hrtick_update(rq);
> >  }
>
> Hmm.. This sets a next selection when the task gets enqueued while not
> running a fair task -- and looses a wakeup preemption opportunity.
>
> Should we perhaps also do this for latency_nice == 0?, in any case I
> think this can be moved to its own patch to avoid doing too much in the
> one patch. It seems fairly self contained.

This function is then removed by patch 9 as the additional rb tree
fixes all cases

>
