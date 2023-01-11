Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8C666006
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjAKQGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjAKQGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:06:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7564D38AD1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673453075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NjLWFj1vtsqWr2bI2lltl/16OGKE1+jKjqULl81THbM=;
        b=jPmdqI+lRYq1Y325jwNZIu5gsJCrt+CroTKO5QvVd5vUlUwBZGp9w8tuiIGTIEHLuM0Iem
        xoaOE6A34CydO2n09yvKprpv2FMYuqKGFvTMVdI0x8Xl21d8lnFHIPZxU2/kSzPrJ4S7nw
        PdLprWB7X+y9CuJ9votrWerT8RMFW8M=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-438-H58tEvylMOmRoOfPsdTe3A-1; Wed, 11 Jan 2023 11:04:28 -0500
X-MC-Unique: H58tEvylMOmRoOfPsdTe3A-1
Received: by mail-yb1-f199.google.com with SMTP id k204-20020a256fd5000000b007b8b040bc50so14924561ybc.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NjLWFj1vtsqWr2bI2lltl/16OGKE1+jKjqULl81THbM=;
        b=QiDjkcrcLU1IWcj8ufczZnR4WgQRTt9lzL6Ngm7LvbbcQyRK4oqoDw3SZQFmlKf5ZM
         SdEkKFjuaNqWN47D7WzM9ijOchFQDrPBcTVkxChJ4/KiI2GDCc+ahtbpgZtHidg66RJb
         6lLwnXtWZljW7kWBCiuGSJ8CJ0Yi0mWx9PF9VOwBtlbYWR4HsQFVBgmpQboTPdjFf/nS
         y6Cr9Yi7fUIKdFfXCk/DV9Q29K9eqBLQsnNmgstAMLcjeNnCDMW9RRQ1ac3iQRMpOAun
         FLMX/OaJhmOdVjhLRVxNyjN0sfs/KI/LKHg1U+QfTdUCKAnJFqDsbbpfwfAPZcN7ARzK
         349w==
X-Gm-Message-State: AFqh2krNzgiNDfcMPsdcWGHqISzvPOOj6H9uoJtf5pE6tHx0nJqvEmrL
        Sj2sy9WQ65/m/yQ76w2HxSbeIQPkl1Fo3q9Pzh1E9VWLXK9X0a8qLFgnNd8yM5R/nUTujvgi/XL
        K2KfZvZveQgsqOIPa2PHX6xEI
X-Received: by 2002:a05:7500:4890:b0:f0:659a:f068 with SMTP id gr16-20020a057500489000b000f0659af068mr202852gab.24.1673453067274;
        Wed, 11 Jan 2023 08:04:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuOlJi/Rx+7sJwyVBxif8ad3U8DB92q/sQdx3KFb9WEOhnlK9EZqEsYOS2AdUmkKYQ5yw5fBg==
X-Received: by 2002:a05:7500:4890:b0:f0:659a:f068 with SMTP id gr16-20020a057500489000b000f0659af068mr202828gab.24.1673453066857;
        Wed, 11 Jan 2023 08:04:26 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05620a179300b006b929a56a2bsm9253444qkb.3.2023.01.11.08.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 08:04:26 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 1/7] sched/fair: Generalize asym_packing logic for
 SMT local sched group
In-Reply-To: <20221229040003.GA11497@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
 <xhsmhv8m3e5sx.mognet@vschneid.remote.csb>
 <20221229040003.GA11497@ranerica-svr.sc.intel.com>
Date:   Wed, 11 Jan 2023 16:04:23 +0000
Message-ID: <xhsmhsfghcb20.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/22 20:00, Ricardo Neri wrote:
> On Thu, Dec 22, 2022 at 04:55:58PM +0000, Valentin Schneider wrote:
>> Some of this is new to me - I had missed the original series introducing
>> this. However ISTM that this is conflating two concepts: SMT occupancy
>> balancing, and asym packing.
>> 
>> Take the !local_is_smt :: sg_busy_cpus >= 2 :: return true; path. It does
>> not involve asym packing priorities at all. This can end up in an
>> ASYM_PACKING load balance,
>
> Yes, this the desired result: an idle low-priority CPU should help a high-
> priority core with more than one busy SMT sibling. But yes, it does not
> relate to priorities and can be implemented differently.
>
>> which per calculate_imbalance() tries to move
>> *all* tasks to the higher priority CPU - in the case of SMT balancing,
>> we don't want to totally empty the core, just its siblings.
>
> But it will not empty the core, only one of its SMT siblings. A single
> sibling will be selected in find_busiest_queue(). The other siblings will
> be unaffected.
>

Right

>> 
>> Is there an ITMT/big.LITTLE (or however x86 calls it) case that invalidates
>> the above?
>
> Please see below.
>
>> 
>> Say, what's not sufficient with the below? AFAICT the only thing that isn't
>> covered is the sg_busy_cpus >= 2 thing, but IMO that's SMT balancing, not
>> asym packing - if the current calculate_imbalance() doesn't do it, it
>> should be fixed to do it.
>
> Agreed.
>
>>Looking at the
>> 
>>   local->group_type == group_has_spare
>> 
>> case, it looks like it should DTRT.
>
> I had tried (and failed) to have find_busiest_group() handle the
> !local_is_smt :: sg_busy_cpus >= 2 case. Now I think I made it work.
>
> When the busiest group is not overloaded, find_busiest_group() and
> local->group = group_has_spare during an idle load balance events the
> number of *idle* CPUs. However, this does not work if the local and busiest
> groups have different weights. In SMT2, for instance, if busiest has 2 busy
> CPUs (i.e., 0 idle CPUs) and the destination CPU is idle, the difference in
> the number of idle CPUs is 1. find_busiest_group() will incorrectly goto
> out_balanced.
>
> This issue very visible in Intel hybrid processors because the big cores
> have SMT but the small cores do not. It can, however, be reproduced in non-
> hybrid processors by offlining the SMT siblings of some cores.
>

I think I follow. If we're comparing two groups each spanning an SMT2 core,
then

  busiest->group_weight > 1 && local->idle_cpus <= (busiest->idle_cpus + 1)

is false if local is fully idle and busiest fully busy, but if local
becomes a non-SMT core, then that's true and we goto out_balanced.


With that said, shouldn't SD_PREFER_SIBLING help here? cf.

	if (sds.prefer_sibling && local->group_type == group_has_spare &&
	    busiest->sum_nr_running > local->sum_nr_running + 1)

It should be set on any topology level below the NUMA ones, we do remove it
on SD_ASYM_CPUCAPACITY levels because this used to interfere with misfit
balancing (it would override the group_type), things are a bit different
since Vincent's rewrite of load_balance() but I think we still want it off
there. I would expect it to be set in your system, though whether this is
playing nice with the asymmetry is another matter :-)

> The problem can be fixed by instead balancing the number of *busy* CPUs,
> which is what in general we want, IMO. (When two groups have the same
> weight, it is equivalent to balancing the number of idle CPUs).
>
> This patch worked for me:
>
> @@ -9787,14 +9787,18 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  			lsub_positive(&nr_diff, local->sum_nr_running);
>  			env->imbalance = nr_diff;
>  		} else {
> +			unsigned int busiest_busy_cpus, local_busy_cpus;
> +
> +			busiest_busy_cpus = busiest->group_weight - busiest->idle_cpus;
> +			local_busy_cpus = local->group_weight - local->idle_cpus;
>  
>  			/*
>  			 * If there is no overload, we just want to even the number of
> -			 * idle cpus.
> +			 * busy cpus.
>  			 */
>  			env->migration_type = migrate_task;
> -			env->imbalance = max_t(long, 0,
> -					       (local->idle_cpus - busiest->idle_cpus));
> +			env->imbalance = max_t(long, 0 ,
> +					       (busiest_busy_cpus -  local_busy_cpus));
>  		}
>  
>  #ifdef CONFIG_NUMA
> @@ -9981,18 +9985,24 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  			 */
>  			goto out_balanced;
>  
> -		if (busiest->group_weight > 1 &&
> -		    local->idle_cpus <= (busiest->idle_cpus + 1))
> -			/*
> -			 * If the busiest group is not overloaded
> -			 * and there is no imbalance between this and busiest
> -			 * group wrt idle CPUs, it is balanced. The imbalance
> -			 * becomes significant if the diff is greater than 1
> -			 * otherwise we might end up to just move the imbalance
> -			 * on another group. Of course this applies only if
> -			 * there is more than 1 CPU per group.
> -			 */
> -			goto out_balanced;
> +		if (busiest->group_weight > 1) {
> +			unsigned int local_busy_cpus, busiest_busy_cpus;
> +
> +			local_busy_cpus = local->group_weight - local->idle_cpus;
> +			busiest_busy_cpus = busiest->group_weight - busiest->idle_cpus;
> +
> +			if (busiest_busy_cpus <= local_busy_cpus + 1)
> +				/*
> +				 * If the busiest group is not overloaded
> +				 * and there is no imbalance between this and busiest
> +				 * group wrt busy CPUs, it is balanced. The imbalance
> +				 * becomes significant if the diff is greater than 1
> +				 * otherwise we might end up to just move the imbalance
> +				 * on another group. Of course this applies only if
> +				 * there is more than 1 CPU per group.
> +				 */
> +				goto out_balanced;
> +		}
>  
>  		if (busiest->sum_h_nr_running == 1)
>  			/*
>
> With this I can remove the sg_busy_cpus >=2 thing from asym_smt_can_pull_tasks().
>
>> 
>> ---
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 224107278471f..15eb2d3cff186 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9176,12 +9176,15 @@ static inline bool
>>  sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
>>  	   struct sched_group *group)
>>  {
>> -	/* Only do SMT checks if either local or candidate have SMT siblings */
>> -	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
>> -	    (group->flags & SD_SHARE_CPUCAPACITY))
>> -		return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
>> +	/*
>> +	 * For SMT, env->idle != CPU_NOT_IDLE isn't sufficient, we need to make
>> +	 * sure the whole core is idle.
>> +	 */
>> +	if (((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
>> +	     (group->flags & SD_SHARE_CPUCAPACITY)) &&
>> +	    !test_idle_cores(env->dst_cpu))
>
> But test_idle_cores() tests for *any* idle core in the highest domain with the
> SD_SHARE_PKG_RESOURCES flag. Here we are only interested in the SMT siblings
> of env->dst_cpu. If is_core_idle(env->dst_cpu) is used, then I agree with the
> change.
>

Right, I had gotten confused with test_idle_cores()

> Thanks and BR,
> Ricardo

