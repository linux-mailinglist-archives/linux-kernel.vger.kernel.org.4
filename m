Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404BD680C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbjA3LyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbjA3LyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:54:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863FD16AE4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675079592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UorKXiYhOLzx8w7FOKgdDJJdKg4bn3M6MkxAIFes/DA=;
        b=GmnsHWGo/RXDJ0ZwhClOOhsoZE4AJLy/HHuxfizymFEPzowtV/SHd7ruytyqHYSs6u0Qs8
        0nCzGUe5tj6DSqteZEd0IsbjKCC/pCZ/OOkfiDVb6vt7kFvpWuNSQ9dy22hKgAXK6i2dKm
        a7N6H9C4l5RZF7Q/aNWTDaqANRsMW8M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-299-4WKcmglfMzaCJAAVso8RLg-1; Mon, 30 Jan 2023 06:50:01 -0500
X-MC-Unique: 4WKcmglfMzaCJAAVso8RLg-1
Received: by mail-pj1-f71.google.com with SMTP id c8-20020a17090a674800b0022cb9c81fb0so660060pjm.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UorKXiYhOLzx8w7FOKgdDJJdKg4bn3M6MkxAIFes/DA=;
        b=Z5UZGTaYcxbeLdtFRTOq9YnuUIkLW490LKvD25CKUJ70MCMvcr5IWKqo0jIaD2O6vS
         CHaugurWH3BE0ZsRVl6uDkQb7avD79yaBfJcOF8Mq+U+ZTmsCQpdCveHvQI2fgjadHnL
         hOanM26ly3Wtt/aTToSBnuBDfZsGhWKEm8n2JSKmjUe+Oh+gPpQETNDaSZyK5aNmR/3d
         8VhrvkXIoU4h6lNy9b2xMFnlBGapoIQiKm2iBtay1w0j2/Nzz/dBrvmeevfw5RPPU9QQ
         05a680nSdExx5Q7C7X8J9sSxWQjtPgdyWF/IjuDallsOFRnMa+wgfiCl8sHhcNij0HpY
         PAYg==
X-Gm-Message-State: AFqh2kr6eQqO3ifnxEGT3rYG2isMI2gvvi4qf7z072irg0KoOUN9MjfN
        O134xd1HihDVOkyOAseEH9xMnbZcXbfRG1kC8bYhKMLtn+wOjLY5bKAdQ/9ANu9a0YhMxLIXf++
        6wI9f0O53SZuzS3QMlgYaB5rSKBvCfgEDc5Ly9tjF
X-Received: by 2002:aa7:910c:0:b0:58d:bb12:2da5 with SMTP id 12-20020aa7910c000000b0058dbb122da5mr6008248pfh.27.1675079400126;
        Mon, 30 Jan 2023 03:50:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtALu5mFTBsxu/YnMlq0ZBLgbSfN1s0qraym/tkAVGjH1oXxeyJbSP9OuU5xYe+OFfLGyeFgGcuo2qk4atro5o=
X-Received: by 2002:aa7:910c:0:b0:58d:bb12:2da5 with SMTP id
 12-20020aa7910c000000b0058dbb122da5mr6008230pfh.27.1675079399855; Mon, 30 Jan
 2023 03:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20230120150246.20797-1-wander@redhat.com> <20230120150246.20797-2-wander@redhat.com>
 <20230123163002.GB6268@redhat.com> <CAAq0SUk1vfNDuzGbXNftgW4wq4PC_EzMhpq4E=RBQNkOB3f4YQ@mail.gmail.com>
 <xhsmhbkmkdla4.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhbkmkdla4.mognet@vschneid.remote.csb>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 30 Jan 2023 08:49:48 -0300
Message-ID: <CAAq0SUnUH6DEjwEs2RxRCtkTU121JXpdsV_rZky1d0Bo04=fiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] sched/task: Add the put_task_struct_atomic_safe function
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 12:55 PM Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 23/01/23 14:24, Wander Lairson Costa wrote:
> > On Mon, Jan 23, 2023 at 1:30 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >>
> >> On 01/20, Wander Lairson Costa wrote:
> >> >
> >> > +static inline void put_task_struct_atomic_safe(struct task_struct *task)
> >> > +{
> >> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> >> > +             /*
> >> > +              * Decrement the refcount explicitly to avoid unnecessarily
> >> > +              * calling call_rcu.
> >> > +              */
> >> > +             if (refcount_dec_and_test(&task->usage))
> >> > +                     /*
> >> > +                      * under PREEMPT_RT, we can't call put_task_struct
> >> > +                      * in atomic context because it will indirectly
> >> > +                      * acquire sleeping locks.
> >> > +                      */
> >> > +                     call_rcu(&task->rcu, __delayed_put_task_struct);
> >>                                   ^^^^^^^^^
> >> I am not sure the usage of task->rcu is safe...
> >>
> >> Suppose that, before __delayed_put_task_struct() is called by RCU, this task
> >> does the last schedule and calls put_task_struct_rcu_user().
> >>
> >> And, can't we simply turn put_task_struct() into something like
> >>
> >>         put_task_struct(struct task_struct *t)
> >>         {
> >>                 if (refcount_dec_and_test(&t->usage)) {
> >>                         if (IS_ENABLED(CONFIG_PREEMPT_RT)
> >>                             && (in_atomic() || irqs_disabled()))
> >>                                 call_rcu(...);
> >>                         else
> >>                                 __put_task_struct(t);
> >>                 }
> >>         }
> >>
> >> ?
> >
> > Yeah, that was one approach I thought about. I chose to use an
> > explicit function because I assumed calling __put_task_struct() from a
> > non-preemptable context should be the exception, not the rule.
>
> I'd tend to agree.
>
> > Therefore (if I am correct in my assumption), it would make sense for
> > only some call sites to pay the overhead price for it. But this is
> > just a guess, and I have no evidence to support my claim.
>
> My worry here is that it's easy to miss problematic callgraphs, and it's
> potentially easy for new ones to creep in. Having a solution within
> put_task_struct() itself would prevent that.
>

We could add a WARN_ON statement in put_task_struct() to detect such cases.

> Another thing, if you look at release_task_stack(), it either caches the
> outgoing stack for later use, or frees it via RCU (regardless of
> PREEMPT_RT). Perhaps we could follow that and just always punt the freeing
> of the task struct to RCU?
>

That's a point. Do you mean doing that even for !PREEMPT_RT?

