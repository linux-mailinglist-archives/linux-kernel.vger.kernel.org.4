Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565196CEEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjC2QOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjC2QOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:14:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7A391
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:13:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eg48so65419158edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680106428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtjxQHAVek0fiDihNzOSf3NaXNmJd/De8NendcDYUPk=;
        b=k28XzCid+7iUXtTh/dchprDhZiqSwP8dxu8iur2QRSpMiYUk12TjRWp8zU8ORY/kGs
         azyNeWhWn0agjKGu5ccPzx/2gfydwcRsd9xLg+3iOidLzoCWOPGQjPl+uVovkEy+SBZN
         jTKChsEbfxVTPueR7b2nUkUEhcSRtwwEzrhiOBiIiJtwV1x3x7EXqQd8WLidIiM8FQoL
         lscVasViBlWqp5x4/x7wmayFBeiffJMaeQA0z9Gx6zRk6jWKGz8WGKCK8OLjo6+D3FgH
         kpZoopNMzuQqWVutWjNOMFs/HhafXyv5YUgIwIySPyIqvalyn38siCmMnQdrEsj0ZKOk
         asLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680106428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtjxQHAVek0fiDihNzOSf3NaXNmJd/De8NendcDYUPk=;
        b=mdm39lHxA9UrmGFjELrBysz92aq4Yd5OewE8IXZAPtvLEk6n8Nn5FbJDfHx+by7264
         ZxmoDpckN6GrRxQxKwKxnWXFwCV/VLh1hccUMSOy5el8YVwA/sHX+Jhqz/kGcomqbutA
         n6mpAJBXZOXclGmMBzFtTjcBdBrfeoWSwBNTpQcgwltTeIK4N/Heqy0ISgEWuAQh8iJg
         Sodu5wkN3IZr9v0WkzVzaKwJ3vLoyN0CMww6qr/TZIOZBo2aDQNju8/pv3EGZNHC0CnE
         CB6Oo16c/NXOCLN7y3WIosYErKY+oLkaxvYo3i/PyzJP7EdpRR30COaZnY3831Tmkrr7
         7NFA==
X-Gm-Message-State: AAQBX9dd6s24tEJm0Iyme9gS0OkCNMdfQF8xdevo8yQj5GFf+3FwDdH+
        JFsgJKn9G6vuiskGgjXoE61pig==
X-Google-Smtp-Source: AKy350aU6kbpNKNBJhpDB/9HwORB2YuC0CreY/Vy8r9hC6aQhd3aRcQS3q24bC38jAzcspqNgOmSIA==
X-Received: by 2002:a17:906:fc1e:b0:92b:f3c3:7c5f with SMTP id ov30-20020a170906fc1e00b0092bf3c37c5fmr19153435ejb.53.1680106428043;
        Wed, 29 Mar 2023 09:13:48 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:e994])
        by smtp.gmail.com with ESMTPSA id xo20-20020a170907bb9400b0093f0fbebfc2sm6211220ejc.144.2023.03.29.09.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:13:47 -0700 (PDT)
Date:   Wed, 29 Mar 2023 12:13:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        surenb@google.com, brauner@kernel.org, chris@chrisdown.name
Subject: Re: [PATCH v4 4/4] sched/psi: allow unprivileged polling of N*2s
 period
Message-ID: <ZCRjulHDZN3U5bUY@cmpxchg.org>
References: <20230329153327.140215-1-cerasuolodomenico@gmail.com>
 <20230329153327.140215-5-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329153327.140215-5-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 05:33:27PM +0200, Domenico Cerasuolo wrote:
> PSI offers 2 mechanisms to get information about a specific resource
> pressure. One is reading from /proc/pressure/<resource>, which gives
> average pressures aggregated every 2s. The other is creating a pollable
> fd for a specific resource and cgroup.
> 
> The trigger creation requires CAP_SYS_RESOURCE, and gives the
> possibility to pick specific time window and threshold, spawing an RT
> thread to aggregate the data.
> 
> Systemd would like to provide containers the option to monitor pressure
> on their own cgroup and sub-cgroups. For example, if systemd launches a
> container that itself then launches services, the container should have
> the ability to poll() for pressure in individual services. But neither
> the container nor the services are privileged.
> 
> This patch implements a mechanism to allow unprivileged users to create
> pressure triggers. The difference with privileged triggers creation is
> that unprivileged ones must have a time window that's a multiple of 2s.
> This is so that we can avoid unrestricted spawning of rt threads, and
> use instead the same aggregation mechanism done for the averages, which
> runs independently of any triggers.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Overall it looks good to me. Thanks for adding the comment on the
privilege check, it's much easier to understand now.

A few nitpicks below:

> @@ -151,6 +151,9 @@ struct psi_trigger {
>  
>  	/* Deferred event(s) from previous ratelimit window */
>  	bool pending_event;
> +
> +	/* Used to differentiate destruction action*/
> +	enum psi_aggregators aggregator;
>  };

The comment is a bit mysterious. How about

	/* Trigger type - PSI_AVGS for unprivileged, PSI_POLL for RT */

> @@ -186,9 +186,9 @@ static void group_init(struct psi_group *group)
>  		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
>  	group->avg_last_update = sched_clock();
>  	group->avg_next_update = group->avg_last_update + psi_period;
> -	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
>  	mutex_init(&group->avgs_lock);
> -	/* Init trigger-related members */
> +
> +	/* Init rtpoll trigger-related members */
>  	atomic_set(&group->rtpoll_scheduled, 0);
>  	mutex_init(&group->rtpoll_trigger_lock);
>  	INIT_LIST_HEAD(&group->rtpoll_triggers);
> @@ -197,6 +197,11 @@ static void group_init(struct psi_group *group)
>  	init_waitqueue_head(&group->rtpoll_wait);
>  	timer_setup(&group->rtpoll_timer, poll_timer_fn, 0);
>  	rcu_assign_pointer(group->rtpoll_task, NULL);
> +
> +	/* Init avg trigger-related members */
> +	INIT_LIST_HEAD(&group->avg_triggers);
> +	memset(group->avg_nr_triggers, 0, sizeof(group->avg_nr_triggers));
> +	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
>  }

Can you move those above the rtpoll inits?

It helps with navigating the code and spotting missing inits when the
init sequence follows the order of the struct members.

> @@ -430,21 +435,25 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
>  	return growth;
>  }
>  
> -static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total)
> +static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
> +						   enum psi_aggregators aggregator)
>  {
>  	struct psi_trigger *t;
> -	u64 *total = group->total[PSI_POLL];
> +	u64 *total = group->total[aggregator];
> +	struct list_head *triggers = aggregator == PSI_AVGS ? &group->avg_triggers
> +			: &group->rtpoll_triggers;
> +	u64 *aggregator_total = aggregator == PSI_AVGS ? group->avg_total : group->rtpoll_total;
>  	*update_total = false;

These lines are a bit too long. When the init part gets that long,
it's preferable to move it outside of the decl block:

	if (aggregator == PSI_AVGS) {
		triggers = &group->avg_triggers;
		aggregator_total = group->avg_total;
	} else {
		triggers = &group->rtpoll_triggers;
		aggregator_total = group->rtpoll_total;
	}

> @@ -1357,22 +1389,26 @@ void psi_trigger_destroy(struct psi_trigger *t)
>  		u64 period = ULLONG_MAX;
>  
>  		list_del(&t->node);
> -		group->rtpoll_nr_triggers[t->state]--;
> -		if (!group->rtpoll_nr_triggers[t->state])
> -			group->rtpoll_states &= ~(1 << t->state);
> -		/* reset min update period for the remaining triggers */
> -		list_for_each_entry(tmp, &group->rtpoll_triggers, node)
> -			period = min(period, div_u64(tmp->win.size,
> -					UPDATES_PER_WINDOW));
> -		group->rtpoll_min_period = period;
> -		/* Destroy rtpoll_task when the last trigger is destroyed */
> -		if (group->rtpoll_states == 0) {
> -			group->rtpoll_until = 0;
> -			task_to_destroy = rcu_dereference_protected(
> -					group->rtpoll_task,
> -					lockdep_is_held(&group->rtpoll_trigger_lock));
> -			rcu_assign_pointer(group->rtpoll_task, NULL);
> -			del_timer(&group->rtpoll_timer);
> +		if (t->aggregator == PSI_AVGS) {
> +			group->avg_nr_triggers[t->state]--;
> +		} else {
> +			group->rtpoll_nr_triggers[t->state]--;
> +			if (!group->rtpoll_nr_triggers[t->state])
> +				group->rtpoll_states &= ~(1 << t->state);
> +			/* reset min update period for the remaining triggers */
> +			list_for_each_entry(tmp, &group->rtpoll_triggers, node)
> +				period = min(period, div_u64(tmp->win.size,
> +						UPDATES_PER_WINDOW));
> +			group->rtpoll_min_period = period;
> +			/* Destroy rtpoll_task when the last trigger is destroyed */
> +			if (group->rtpoll_states == 0) {
> +				group->rtpoll_until = 0;
> +				task_to_destroy = rcu_dereference_protected(
> +						group->rtpoll_task,
> +						lockdep_is_held(&group->rtpoll_trigger_lock));
> +				rcu_assign_pointer(group->rtpoll_task, NULL);
> +				del_timer(&group->rtpoll_timer);

These lines are quite long too, we usually shoot for a line length of
80 characters. Can you do

		if (t->aggregator == PSI_AVGS) {
			group->avg_nr_triggers[t->state]--;
			return;
		}

		/* Else, it's an rtpoll trigger */
		group->rtpoll_nr_triggers[t->state]--;
		...

With that, please add

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
