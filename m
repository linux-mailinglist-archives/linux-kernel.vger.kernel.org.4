Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885C615242
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKAT3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiKAT3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:29:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB582653
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:28:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t4so9423716wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpxD0CC8Le+odbmrnFgB9f9Kjs8Pu2XoXqY50zKKmmU=;
        b=iQMELqfpQRkU/Kyive+I3yIO2Z0k4maLPNCGAExsPinHEEeTT8HTxVZVl+Yyk0W1aM
         cVJZFh2xM11aKftShgn+0kFG10iDF99VWFiZcjzIoqhUNaNIeL6WvWtzzj4FdqLcJXjW
         t78gtEmvn+jjPKpHO1ejf7OxPCwXA9qHnLbJxgb5nAlvn3mdd7QuOSU21hBNVtXMI8RL
         Ho/EBhi9WEgVc8ZN9emy7P6ngXIdPNSk0TY012315j92zzdL0itYYrh/MuAYfa1qvU2Q
         fW6yiJyYGmCd+eA4ivZ5iiTHR0jzQBw36ObcgvjAnH2fX0smTkrcc+1vR97YKxghEJ7t
         Qoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpxD0CC8Le+odbmrnFgB9f9Kjs8Pu2XoXqY50zKKmmU=;
        b=YMsywW1ABl8WbXhnHZpecXGLl+d3sU/XQEVgyM+CI87G2GZajKGdcBlrxe+QpkZ+4N
         8oSphBpwej8q3V6R8bZG12KV60/+TUkdizWl9n95/+EzPVaaJVsCyiua3kjX6GFDzCOm
         2LVLELKJzoTE1eVE/IIr5hegZeSKpW67/AnoepZbCcuXsNEg7I2yJ7XUyzdA+cYHNEIZ
         VJmYPe4Vv8pQI+K+6an06TFTqlDbYb8O9MX61pTBdMo/0gygm2evWX6cxwBRycT63pwb
         6cT4lOLb1vyITWSK6JVQ2E922+jzk5NzvSWLrOsWocD0d+zvcnwSw+tt45BrMoSh5T24
         TABw==
X-Gm-Message-State: ACrzQf1JXKRidCw9boaYBKBWJ0pR5xGyk8XTrl3LD7WW6xed9s+KufMP
        ytF+lpC46FfQiOA6jRil9wi2XQ==
X-Google-Smtp-Source: AMsMyM6NMpAw77BTZmlwZnqD072bw0q4nNxbHL3+NfU9jENMWhZawqxjCnBqrHsY+IpQQiFwzPO6kA==
X-Received: by 2002:a7b:c8c5:0:b0:3cf:634f:53a9 with SMTP id f5-20020a7bc8c5000000b003cf634f53a9mr13188124wml.82.1667330934545;
        Tue, 01 Nov 2022 12:28:54 -0700 (PDT)
Received: from airbuntu (92.40.168.201.threembb.co.uk. [92.40.168.201])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b003c6f1732f65sm9545803wmq.38.2022.11.01.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 12:28:54 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:28:48 +0000
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
Message-ID: <20221101192848.pjns3um7dnrwrk5p@airbuntu>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221028093403.6673-7-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 11:34, Vincent Guittot wrote:
> Task can set its latency priority with sched_setattr(), which is then used
> to set the latency offset of its sched_enity, but sched group entities
> still have the default latency offset value.
> 
> Add a latency.nice field in cpu cgroup controller to set the latency
> priority of the group similarly to sched_setattr(). The latency priority
> is then used to set the offset of the sched_entities of the group.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
>  kernel/sched/core.c                     | 52 +++++++++++++++++++++++++
>  kernel/sched/fair.c                     | 33 ++++++++++++++++
>  kernel/sched/sched.h                    |  4 ++
>  4 files changed, 97 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index be4a77baf784..d8ae7e411f9c 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
>          values similar to the sched_setattr(2). This maximum utilization
>          value is used to clamp the task specific maximum utilization clamp.
>  
> +  cpu.latency.nice
> +	A read-write single value file which exists on non-root
> +	cgroups.  The default is "0".
> +
> +	The nice value is in the range [-20, 19].
> +
> +	This interface file allows reading and setting latency using the
> +	same values used by sched_setattr(2).

I'm still not sure about this [1].

In some scenarios we'd like to get the effective latency_nice of the task. How
will the task inherit the cgroup value or be impacted by it?

For example if there are tasks that belong to a latency sensitive cgroup; and
I'd like to skip some searches in EAS to improve that latency sensitivity - how
would I extract this info in EAS path given these tasks are using default
latency_nice value? And if should happen if their latency_nice is set to
something else other than default?

[1] https://lore.kernel.org/lkml/20221012160734.hrkb5jcjdq7r23pr@wubuntu/


Thanks

--
Qais Yousef

>  
>  
>  Memory
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index caf54e54a74f..3f42b1f61a7e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10890,6 +10890,47 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
>  {
>  	return sched_group_set_idle(css_tg(css), idle);
>  }
> +
> +static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
> +				    struct cftype *cft)
> +{
> +	int prio, delta, last_delta = INT_MAX;
> +	s64 weight;
> +
> +	weight = css_tg(css)->latency_offset * NICE_LATENCY_WEIGHT_MAX;
> +	weight = div_s64(weight, get_sched_latency(false));
> +
> +	/* Find the closest nice value to the current weight */
> +	for (prio = 0; prio < ARRAY_SIZE(sched_latency_to_weight); prio++) {
> +		delta = abs(sched_latency_to_weight[prio] - weight);
> +		if (delta >= last_delta)
> +			break;
> +		last_delta = delta;
> +	}
> +
> +	return LATENCY_TO_NICE(prio-1);
> +}
> +
> +static int cpu_latency_nice_write_s64(struct cgroup_subsys_state *css,
> +				     struct cftype *cft, s64 nice)
> +{
> +	s64 latency_offset;
> +	long weight;
> +	int idx;
> +
> +	if (nice < MIN_LATENCY_NICE || nice > MAX_LATENCY_NICE)
> +		return -ERANGE;
> +
> +	idx = NICE_TO_LATENCY(nice);
> +	idx = array_index_nospec(idx, LATENCY_NICE_WIDTH);
> +	weight = sched_latency_to_weight[idx];
> +
> +	latency_offset = weight * get_sched_latency(false);
> +	latency_offset = div_s64(latency_offset, NICE_LATENCY_WEIGHT_MAX);
> +
> +	return sched_group_set_latency(css_tg(css), latency_offset);
> +}
> +
>  #endif
>  
>  static struct cftype cpu_legacy_files[] = {
> @@ -10904,6 +10945,11 @@ static struct cftype cpu_legacy_files[] = {
>  		.read_s64 = cpu_idle_read_s64,
>  		.write_s64 = cpu_idle_write_s64,
>  	},
> +	{
> +		.name = "latency.nice",
> +		.read_s64 = cpu_latency_nice_read_s64,
> +		.write_s64 = cpu_latency_nice_write_s64,
> +	},
>  #endif
>  #ifdef CONFIG_CFS_BANDWIDTH
>  	{
> @@ -11121,6 +11167,12 @@ static struct cftype cpu_files[] = {
>  		.read_s64 = cpu_idle_read_s64,
>  		.write_s64 = cpu_idle_write_s64,
>  	},
> +	{
> +		.name = "latency.nice",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.read_s64 = cpu_latency_nice_read_s64,
> +		.write_s64 = cpu_latency_nice_write_s64,
> +	},
>  #endif
>  #ifdef CONFIG_CFS_BANDWIDTH
>  	{
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4299d5108dc7..9583936ce30c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11764,6 +11764,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
>  		goto err;
>  
>  	tg->shares = NICE_0_LOAD;
> +	tg->latency_offset = 0;
>  
>  	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
>  
> @@ -11862,6 +11863,9 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
>  	}
>  
>  	se->my_q = cfs_rq;
> +
> +	se->latency_offset = tg->latency_offset;
> +
>  	/* guarantee group entities always have weight */
>  	update_load_set(&se->load, NICE_0_LOAD);
>  	se->parent = parent;
> @@ -11992,6 +11996,35 @@ int sched_group_set_idle(struct task_group *tg, long idle)
>  	return 0;
>  }
>  
> +int sched_group_set_latency(struct task_group *tg, s64 latency)
> +{
> +	int i;
> +
> +	if (tg == &root_task_group)
> +		return -EINVAL;
> +
> +	if (abs(latency) > sysctl_sched_latency)
> +		return -EINVAL;
> +
> +	mutex_lock(&shares_mutex);
> +
> +	if (tg->latency_offset == latency) {
> +		mutex_unlock(&shares_mutex);
> +		return 0;
> +	}
> +
> +	tg->latency_offset = latency;
> +
> +	for_each_possible_cpu(i) {
> +		struct sched_entity *se = tg->se[i];
> +
> +		WRITE_ONCE(se->latency_offset, latency);
> +	}
> +
> +	mutex_unlock(&shares_mutex);
> +	return 0;
> +}
> +
>  #else /* CONFIG_FAIR_GROUP_SCHED */
>  
>  void free_fair_sched_group(struct task_group *tg) { }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 99f10b4dc230..95d4be4f3af6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -407,6 +407,8 @@ struct task_group {
>  
>  	/* A positive value indicates that this is a SCHED_IDLE group. */
>  	int			idle;
> +	/* latency constraint of the group. */
> +	int			latency_offset;
>  
>  #ifdef	CONFIG_SMP
>  	/*
> @@ -517,6 +519,8 @@ extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
>  
>  extern int sched_group_set_idle(struct task_group *tg, long idle);
>  
> +extern int sched_group_set_latency(struct task_group *tg, s64 latency);
> +
>  #ifdef CONFIG_SMP
>  extern void set_task_rq_fair(struct sched_entity *se,
>  			     struct cfs_rq *prev, struct cfs_rq *next);
> -- 
> 2.17.1
> 
