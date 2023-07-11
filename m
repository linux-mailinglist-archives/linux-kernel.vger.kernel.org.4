Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2324874E25F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGKAAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGKAAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:00:15 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45C1A7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:00:14 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-346258cf060so27735ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689033614; x=1691625614;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzjqKyy3RJozxwYzvwQHf7u8DmmIJyuitJSCSOORBzg=;
        b=FskCZG8NomIVXpbo5BJcg8DNkZ4gYsvg1bKtVjoYvTUzWtnnFCRrLL/WrSthQXdxhA
         LwGzokwy1AECgtb/oK4pAJSYcSTar8aGCV/R01dEbRsoyamafl9xJYaMeeMoybR38O/a
         Mpx0IXl4fGwFz0K2f+tzwKc06eScCnoNY15kSqkVBbWJ+MtQyGOQmYKO8YLgcsvI6QNz
         1kWnmy1O+aJzdcDd54YAQJBMQ2zi8so2qmbIa5ikdnMdQGe9UluBlv89/5/dv6fMSeO5
         d8BJE76Wb9SRis3zaj0DAVAtbtGKSTPHVvYg68yYRbvaFNq900uUXCN2332bXkkTAOmG
         j4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689033614; x=1691625614;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzjqKyy3RJozxwYzvwQHf7u8DmmIJyuitJSCSOORBzg=;
        b=i2ljAtnLZJYUW5EzdeWgNwssDIN4bHgZOqeJBNWNHORbrZNNoJjW2OV+OAFi/Ng6xE
         TMifT/Ge4GWuoKiuaFt129fJi69wYMKGHwjvLDLd7j31iZaeRnpg4kOolOGf06FWqhpK
         x/pqV+pYVOTjO/MYietYZMw0epgmuwMc/TL5sbuYgkzigMM0pXZIXetXZNVkXnmrdHP7
         33Xn1D94ZYrse9FdSaY3FWxgysvLcQyrm49qh6SWVYk7nVtwuA0koCA7hFjiVO0DZxaj
         FSnPdW/2xJdmG+BhWKVe+yoGPtSxjCU+4LJJMXz7KTTebJKTeDfhAnuo4zhPS6FaeVO/
         5Oiw==
X-Gm-Message-State: ABy/qLZTZ3DSq4KcRKta0Y6diG8rrfqcm+ya+/Vg8RW5ZwFe4CaNa4sk
        49BzuIYe5JiyJ/lX+L8q1Mhyvw==
X-Google-Smtp-Source: APBJJlFlSqWv8QWWG9+dmVP5iYH+CAIh/AyRcMmGjrQXYHMZ4/UO+Ro9uzHGJsZq0C8Rx8J1t8FBxg==
X-Received: by 2002:a05:6e02:1542:b0:346:3e9:427f with SMTP id j2-20020a056e02154200b0034603e9427fmr54987ilu.7.1689033613762;
        Mon, 10 Jul 2023 17:00:13 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id n10-20020a63b44a000000b0054fb537ca5dsm200309pgu.92.2023.07.10.17.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:00:13 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 1/2] sched, cgroup: Restore meaning to
 hierarchical_quota
References: <20230707195748.2918490-1-pauld@redhat.com>
        <20230707195748.2918490-2-pauld@redhat.com>
Date:   Mon, 10 Jul 2023 17:00:11 -0700
In-Reply-To: <20230707195748.2918490-2-pauld@redhat.com> (Phil Auld's message
        of "Fri, 7 Jul 2023 15:57:47 -0400")
Message-ID: <xm26h6qbfhbo.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> In cgroupv2 cfs_b->hierarchical_quota is set to -1 for all task
> groups due to the previous fix simply taking the min.  It should
> reflect a limit imposed at that level or by an ancestor. Even
> though cgroupv2 does not require child quota to be less than or
> equal to that of its ancestors the task group will still be
> constrained by such a quota so this should be shown here. Cgroupv1
> continues to set this correctly.
>
> In both cases, add initialization when a new task group is created
> based on the current parent's value (or RUNTIME_INF in the case of
> root_task_group). Otherwise, the field is wrong until a quota is
> changed after creation and __cfs_schedulable() is called.

Reviewed-by: Ben Segall <bsegall@google.com>

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a68d1276bab0..1b214e10c25d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11038,11 +11038,14 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
>  
>  		/*
>  		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
> -		 * always take the min.  On cgroup1, only inherit when no
> -		 * limit is set:
> +		 * always take the non-RUNTIME_INF min.  On cgroup1, only
> +		 * inherit when no limit is set:
>  		 */
>  		if (cgroup_subsys_on_dfl(cpu_cgrp_subsys)) {
> -			quota = min(quota, parent_quota);
> +			if (quota == RUNTIME_INF)
> +				quota = parent_quota;
> +			else if (parent_quota != RUNTIME_INF)
> +				quota = min(quota, parent_quota);
>  		} else {
>  			if (quota == RUNTIME_INF)
>  				quota = parent_quota;

I suppose you could also set RUNTIME_INF to be a positive value or
better yet just compare at unsigned, but it's not like config needs to
be fast, so no need to mess with that.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..92381f9ecf37 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6005,13 +6005,14 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
>  }
>  
> -void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> +void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent)
>  {
>  	raw_spin_lock_init(&cfs_b->lock);
>  	cfs_b->runtime = 0;
>  	cfs_b->quota = RUNTIME_INF;
>  	cfs_b->period = ns_to_ktime(default_cfs_period());
>  	cfs_b->burst = 0;
> +	cfs_b->hierarchical_quota = ((parent) ? parent->hierarchical_quota : RUNTIME_INF);

Minor style nit: don't need any of these parens here.
