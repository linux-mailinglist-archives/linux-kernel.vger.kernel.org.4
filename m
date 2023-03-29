Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CAB6CF2B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjC2TFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjC2TFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:05:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC2A1739
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:05:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ew6so67342202edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680116737;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wh2OgqRN7IUqaKEiP4k1yKjXmh3VmoomfWfE80XlVfg=;
        b=cDnXC0RmlrStn7pmbN1bP3Yqpe1Hnb+VkdHjQyhtS5AnQaU66og84qzDTDJuSlbkiz
         SV/fYoxnr3WuaaUKeVUsj06Hpx4nxGpab2ur6XwFtMhEUyOOJ4iy7Q48qZNTjlFIf//u
         CzaYZiT2WSOcoN4IpvBb0jU6rsqcWsXFocRTAg7jj4rESJHbADniExYIQcHFeFQkna2g
         Z2VxjB/6YBf+xCX8nIc1JsWkCeFRICjLiA//Gs6tdcD9GedGvRjU2lUrcL/aAQ9SFeWj
         5C0TF0+4nwb3XgKYLolFvDLM0C0CuMQAtsc3cEqKH2L30g7mgGgaglvounH8B+K9HPJf
         F9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680116737;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh2OgqRN7IUqaKEiP4k1yKjXmh3VmoomfWfE80XlVfg=;
        b=acPwUhjaHLLxFeufQ+dmIK0eS9rvlH8EUrg6DS6wUYDaoke5XJ+R9CvQ7DAMgwXF+t
         3b5Z+awrCtwLCvfo2qp2Wjpz0IxtZ7gNFwNHboJC7NxVMSPCXIxGoAFHJcUoXhL2V2sh
         /JyyhG5/4GIQ9ZL56dFy3xMjacl0PI31SCWZ40Z0JDXRmjXl1TrVwr3TwBOB37v1ptuI
         N4VqAicPkhASN6pb3l4Fl2Dj0IilcnT7muUIkcjEDmTZiGTwVw4zLa0l5694jJuGd0pj
         jGmC7qYjE2/ZtHXImEwolz10Jkv9K7E6bGpeDc0v/r3N2Ud1NrIp9SmXvFIMWqrNhIot
         fOcg==
X-Gm-Message-State: AAQBX9elEoGiWwjc4df+IXGsSHjrGndGZbHYqivy7uBRGtweC1PotAhV
        DwGhEd+JuIOkvobFph0vSlN46Q==
X-Google-Smtp-Source: AKy350bRVfZvYzAg7UEOBhLCqFWfWXay6/gXF7KYH+pzpX6kgPVVT9tYn8WzPLZvc4ank6GEdpup0w==
X-Received: by 2002:a05:6402:653:b0:4fb:e9b8:ca56 with SMTP id u19-20020a056402065300b004fbe9b8ca56mr17202649edx.41.1680116737379;
        Wed, 29 Mar 2023 12:05:37 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:64b0])
        by smtp.gmail.com with ESMTPSA id lm15-20020a170906980f00b008c76facbbf7sm16926702ejb.171.2023.03.29.12.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:05:37 -0700 (PDT)
Date:   Wed, 29 Mar 2023 15:05:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        surenb@google.com, brauner@kernel.org, chris@chrisdown.name
Subject: Re: [PATCH v4 4/4] sched/psi: allow unprivileged polling of N*2s
 period
Message-ID: <ZCSL/OBkpw5EClUu@cmpxchg.org>
References: <20230329153327.140215-1-cerasuolodomenico@gmail.com>
 <20230329153327.140215-5-cerasuolodomenico@gmail.com>
 <ZCRjulHDZN3U5bUY@cmpxchg.org>
 <CA+CLi1hupf1t52GR-GgvAxhfJeUs6Z59Pmgd4NLmkwiEKTyACQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CLi1hupf1t52GR-GgvAxhfJeUs6Z59Pmgd4NLmkwiEKTyACQ@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 08:32:12PM +0200, Domenico Cerasuolo wrote:
> On Wed, Mar 29, 2023 at 6:13 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > On Wed, Mar 29, 2023 at 05:33:27PM +0200, Domenico Cerasuolo wrote:
> > > PSI offers 2 mechanisms to get information about a specific resource
> > > pressure. One is reading from /proc/pressure/<resource>, which gives
> > > average pressures aggregated every 2s. The other is creating a pollable
> > > fd for a specific resource and cgroup.
> > >
> > > The trigger creation requires CAP_SYS_RESOURCE, and gives the
> > > possibility to pick specific time window and threshold, spawing an RT
> > > thread to aggregate the data.
> > >
> > > Systemd would like to provide containers the option to monitor pressure
> > > on their own cgroup and sub-cgroups. For example, if systemd launches a
> > > container that itself then launches services, the container should have
> > > the ability to poll() for pressure in individual services. But neither
> > > the container nor the services are privileged.
> > >
> > > This patch implements a mechanism to allow unprivileged users to create
> > > pressure triggers. The difference with privileged triggers creation is
> > > that unprivileged ones must have a time window that's a multiple of 2s.
> > > This is so that we can avoid unrestricted spawning of rt threads, and
> > > use instead the same aggregation mechanism done for the averages, which
> > > runs independently of any triggers.
> > >
> > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> >
> > Overall it looks good to me. Thanks for adding the comment on the
> > privilege check, it's much easier to understand now.
> >
> > A few nitpicks below:
> >
> > > @@ -151,6 +151,9 @@ struct psi_trigger {
> > >
> > >       /* Deferred event(s) from previous ratelimit window */
> > >       bool pending_event;
> > > +
> > > +     /* Used to differentiate destruction action*/
> > > +     enum psi_aggregators aggregator;
> > >  };
> >
> > The comment is a bit mysterious. How about
> >
> >         /* Trigger type - PSI_AVGS for unprivileged, PSI_POLL for RT */
> >
> > > @@ -186,9 +186,9 @@ static void group_init(struct psi_group *group)
> > >               seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
> > >       group->avg_last_update = sched_clock();
> > >       group->avg_next_update = group->avg_last_update + psi_period;
> > > -     INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
> > >       mutex_init(&group->avgs_lock);
> > > -     /* Init trigger-related members */
> > > +
> > > +     /* Init rtpoll trigger-related members */
> > >       atomic_set(&group->rtpoll_scheduled, 0);
> > >       mutex_init(&group->rtpoll_trigger_lock);
> > >       INIT_LIST_HEAD(&group->rtpoll_triggers);
> > > @@ -197,6 +197,11 @@ static void group_init(struct psi_group *group)
> > >       init_waitqueue_head(&group->rtpoll_wait);
> > >       timer_setup(&group->rtpoll_timer, poll_timer_fn, 0);
> > >       rcu_assign_pointer(group->rtpoll_task, NULL);
> > > +
> > > +     /* Init avg trigger-related members */
> > > +     INIT_LIST_HEAD(&group->avg_triggers);
> > > +     memset(group->avg_nr_triggers, 0, sizeof(group->avg_nr_triggers));
> > > +     INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
> > >  }
> >
> > Can you move those above the rtpoll inits?
> >
> > It helps with navigating the code and spotting missing inits when the
> > init sequence follows the order of the struct members.
> >
> > > @@ -430,21 +435,25 @@ static u64 window_update(struct psi_window *win,
> > u64 now, u64 value)
> > >       return growth;
> > >  }
> > >
> > > -static u64 update_triggers(struct psi_group *group, u64 now, bool
> > *update_total)
> > > +static u64 update_triggers(struct psi_group *group, u64 now, bool
> > *update_total,
> > > +                                                enum psi_aggregators
> > aggregator)
> > >  {
> > >       struct psi_trigger *t;
> > > -     u64 *total = group->total[PSI_POLL];
> > > +     u64 *total = group->total[aggregator];
> > > +     struct list_head *triggers = aggregator == PSI_AVGS ?
> > &group->avg_triggers
> > > +                     : &group->rtpoll_triggers;
> > > +     u64 *aggregator_total = aggregator == PSI_AVGS ? group->avg_total
> > : group->rtpoll_total;
> > >       *update_total = false;
> >
> > These lines are a bit too long. When the init part gets that long,
> > it's preferable to move it outside of the decl block:
> >
> >         if (aggregator == PSI_AVGS) {
> >                 triggers = &group->avg_triggers;
> >                 aggregator_total = group->avg_total;
> >         } else {
> >                 triggers = &group->rtpoll_triggers;
> >                 aggregator_total = group->rtpoll_total;
> >         }
> >
> > > @@ -1357,22 +1389,26 @@ void psi_trigger_destroy(struct psi_trigger *t)
> > >               u64 period = ULLONG_MAX;
> > >
> > >               list_del(&t->node);
> > > -             group->rtpoll_nr_triggers[t->state]--;
> > > -             if (!group->rtpoll_nr_triggers[t->state])
> > > -                     group->rtpoll_states &= ~(1 << t->state);
> > > -             /* reset min update period for the remaining triggers */
> > > -             list_for_each_entry(tmp, &group->rtpoll_triggers, node)
> > > -                     period = min(period, div_u64(tmp->win.size,
> > > -                                     UPDATES_PER_WINDOW));
> > > -             group->rtpoll_min_period = period;
> > > -             /* Destroy rtpoll_task when the last trigger is destroyed
> > */
> > > -             if (group->rtpoll_states == 0) {
> > > -                     group->rtpoll_until = 0;
> > > -                     task_to_destroy = rcu_dereference_protected(
> > > -                                     group->rtpoll_task,
> > > -
> >  lockdep_is_held(&group->rtpoll_trigger_lock));
> > > -                     rcu_assign_pointer(group->rtpoll_task, NULL);
> > > -                     del_timer(&group->rtpoll_timer);
> > > +             if (t->aggregator == PSI_AVGS) {
> > > +                     group->avg_nr_triggers[t->state]--;
> > > +             } else {
> > > +                     group->rtpoll_nr_triggers[t->state]--;
> > > +                     if (!group->rtpoll_nr_triggers[t->state])
> > > +                             group->rtpoll_states &= ~(1 << t->state);
> > > +                     /* reset min update period for the remaining
> > triggers */
> > > +                     list_for_each_entry(tmp, &group->rtpoll_triggers,
> > node)
> > > +                             period = min(period, div_u64(tmp->win.size,
> > > +                                             UPDATES_PER_WINDOW));
> > > +                     group->rtpoll_min_period = period;
> > > +                     /* Destroy rtpoll_task when the last trigger is
> > destroyed */
> > > +                     if (group->rtpoll_states == 0) {
> > > +                             group->rtpoll_until = 0;
> > > +                             task_to_destroy =
> > rcu_dereference_protected(
> > > +                                             group->rtpoll_task,
> > > +
> >  lockdep_is_held(&group->rtpoll_trigger_lock));
> > > +                             rcu_assign_pointer(group->rtpoll_task,
> > NULL);
> > > +                             del_timer(&group->rtpoll_timer);
> >
> > These lines are quite long too, we usually shoot for a line length of
> > 80 characters. Can you do
> >
> >                 if (t->aggregator == PSI_AVGS) {
> >                         group->avg_nr_triggers[t->state]--;
> >                         return;
> >                 }
> >
> >                 /* Else, it's an rtpoll trigger */
> >                 group->rtpoll_nr_triggers[t->state]--;
> >                 ...
> >
> Can't return there I think, the function doesn't end after the else branch,
> should I put a `goto out` instead to jump the rtpoll code?

You're right, I missed the bottom part beyond the diff.

Looking closer, I think trigger_create and trigger_destroy are
actually buggy. They have to protect against update_trigger(), so both
creation and destruction must take the right lock - avgs_lock or
rtpoll_trigger_lock - before modifying the list. They're both taking
only the rtpoll_trigger_lock right now.

IOW the trigger type distinction needs to be higher up in general.

	if (t->aggregator == PSI_AVGS) {
		mutex_lock(&group->avgs_lock);
		...
	} else {
		mutex_lock(&group->rtpoll_trigger_lock);
		...
	}
