Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68164EA51
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiLPLZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiLPLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:25:35 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FD11B78B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:25:34 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso8246748pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCs56vtuJn9U3K5tw7HyOSDoCiLtIYrnD5dzO1FrD1Q=;
        b=LdoMleDU9cqL3VAT+vVDaxOkWXo829SXCpw73rTxsPUEF8tn2jgjvR5ywHq0dAL7t8
         0kkK/Zu73bmma8msNQ8YM8W7u2ICjxgDGHJJFPR5uPd3CQCqZPBRI0QtuvStV6W+icue
         yH6DT/x15iLSddhx5FTM6vT8Ev8dj85nphGkLKjs7j8499Z+WeZ4p33wvprw9K8lF6eF
         bKVD++A/zqxjCkJKdT9A62QU6lo969Wevh7b51bVDI6UQJ6JDZbSilmW3qlWZGBDuBfh
         vnzFrsYPoMYHA3GWh/qhJr1HuvwQ0GzCKYkTUomZYLLdI2XLruKxnRJtszaswUfxwtp9
         2bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCs56vtuJn9U3K5tw7HyOSDoCiLtIYrnD5dzO1FrD1Q=;
        b=iMctP2SV5feGjUrZP5SRVmetq8vV8ETr8awKLxNnQrQVqn9uft80DDfNH5jpwxhI6m
         1ruLgyu4I3wTOnxdTMafV8h1TVVKsiANyuTQD5ObwWmtjIMGqa6a9h73b/sSgYbeW9IR
         tcQzxESPuHux0c2lHgW+yuHEi4hoAxUZtacoxHFMVe3DzMySs2K68VUiglI4JRgyyj4b
         1cKPicloURYGw4MacfFjMRlLSD0lPZhDKKKuxuZLAVZZAEgKfjBpB0kIPVapvoPFKpRT
         l7ZfM6rFeKhTEjzkNxLV0e5gkvarJEXW/JPERvvp398SHU4l5GG5ZqeT49Q1heTpEBG/
         Zhqg==
X-Gm-Message-State: ANoB5pk3NtZoCzUj3o15QYT/+H+XdMhzu5IZbHPMQ7hskpwIFxqPTwGG
        nV4ckMek9nWmEkw/aVjcVk+RDg==
X-Google-Smtp-Source: AA0mqf4CofgC7ykpoOrpLkXFyBA/s7PPb8V1V4ow6EADmZ9EyYfRmZrgrmoeIktlbn+/DbDXDUr1iw==
X-Received: by 2002:a05:6a20:1588:b0:9d:efbf:7877 with SMTP id h8-20020a056a20158800b0009defbf7877mr45287630pzj.44.1671189931823;
        Fri, 16 Dec 2022 03:25:31 -0800 (PST)
Received: from [10.5.5.153] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id g26-20020aa796ba000000b0057709fce782sm1277719pfk.54.2022.12.16.03.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:25:31 -0800 (PST)
Message-ID: <1a2faca7-f77b-a131-b51d-cf2705594862@bytedance.com>
Date:   Fri, 16 Dec 2022 19:25:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v2] perf/core: Fix cgroup events tracking
Content-Language: en-US
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, ravi.bangoria@amd.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221207124023.66252-1-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20221207124023.66252-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, ping :-)


On 2022/12/7 20:40, Chengming Zhou wrote:
> We encounter perf warnings when using cgroup events like:
> ```
> cd /sys/fs/cgroup
> mkdir test
> perf stat -e cycles -a -G test
> ```
> 
> WARNING: CPU: 0 PID: 690 at kernel/events/core.c:849 perf_cgroup_switch+0xb2/0xc0
> Call Trace:
>  <TASK>
>  __schedule+0x4ae/0x9f0
>  ? _raw_spin_unlock_irqrestore+0x23/0x40
>  ? __cond_resched+0x18/0x20
>  preempt_schedule_common+0x2d/0x70
>  __cond_resched+0x18/0x20
>  wait_for_completion+0x2f/0x160
>  ? cpu_stop_queue_work+0x9e/0x130
>  affine_move_task+0x18a/0x4f0
> 
> WARNING: CPU: 0 PID: 690 at kernel/events/core.c:829 ctx_sched_in+0x1cf/0x1e0
> Call Trace:
>  <TASK>
>  ? ctx_sched_out+0xb7/0x1b0
>  perf_cgroup_switch+0x88/0xc0
>  __schedule+0x4ae/0x9f0
>  ? _raw_spin_unlock_irqrestore+0x23/0x40
>  ? __cond_resched+0x18/0x20
>  preempt_schedule_common+0x2d/0x70
>  __cond_resched+0x18/0x20
>  wait_for_completion+0x2f/0x160
>  ? cpu_stop_queue_work+0x9e/0x130
>  affine_move_task+0x18a/0x4f0
> 
> The above two warnings are not complete here since I remove other
> unimportant information. The problem is caused by the perf cgroup
> events tracking:
> 
> CPU0					CPU1
> perf_event_open()
>   perf_event_alloc()
>     account_event()
>       account_event_cpu()
>         atomic_inc(perf_cgroup_events)
> 					__perf_event_task_sched_out()
> 					  if (atomic_read(perf_cgroup_events))
> 					    perf_cgroup_switch()
> 					      // kernel/events/core.c:849
> 					      WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0)
> 					      if (READ_ONCE(cpuctx->cgrp) == cgrp) // false
> 					        return
> 					      perf_ctx_lock()
> 					      ctx_sched_out()
> 					      cpuctx->cgrp = cgrp
> 					      ctx_sched_in()
> 					        perf_cgroup_set_timestamp()
> 					          // kernel/events/core.c:829
> 					          WARN_ON_ONCE(!ctx->nr_cgroups)
> 					      perf_ctx_unlock()
>   perf_install_in_context()
>     cpu_function_call()
> 					__perf_install_in_context()
> 					  add_event_to_ctx()
> 					    list_add_event()
> 					      perf_cgroup_event_enable()
> 					        ctx->nr_cgroups++
> 					        cpuctx->cgrp = X
> 
> We can see from above that we wrongly use percpu atomic perf_cgroup_events
> to check if we need to perf_cgroup_switch(), which should only be used
> when we know this CPU has cgroup events enabled.
> 
> The commit bd2756811766 ("perf: Rewrite core context handling") change
> to have only one context per-CPU, so we can just use cpuctx->cgrp to
> check if this CPU has cgroup events enabled.
> 
> So percpu atomic perf_cgroup_events is not needed.
> 
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
> v2:
>  - Remove timestamps and fix race graph in commit log per Ravi Bangoria.
>  - Add Fixes tag and Tested-by tag.
> ---
>  kernel/events/core.c | 42 ++++++++++--------------------------------
>  1 file changed, 10 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index eacc3702654d..5d97a9f26003 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -380,7 +380,6 @@ enum event_type_t {
>  
>  /*
>   * perf_sched_events : >0 events exist
> - * perf_cgroup_events: >0 per-cpu cgroup events exist on this cpu
>   */
>  
>  static void perf_sched_delayed(struct work_struct *work);
> @@ -389,7 +388,6 @@ static DECLARE_DELAYED_WORK(perf_sched_work, perf_sched_delayed);
>  static DEFINE_MUTEX(perf_sched_mutex);
>  static atomic_t perf_sched_count;
>  
> -static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
>  static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
>  
>  static atomic_t nr_mmap_events __read_mostly;
> @@ -844,9 +842,16 @@ static void perf_cgroup_switch(struct task_struct *task)
>  	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
>  	struct perf_cgroup *cgrp;
>  
> -	cgrp = perf_cgroup_from_task(task, NULL);
> +	/*
> +	 * cpuctx->cgrp is set when the first cgroup event enabled,
> +	 * and is cleared when the last cgroup event disabled.
> +	 */
> +	if (READ_ONCE(cpuctx->cgrp) == NULL)
> +		return;
>  
>  	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
> +
> +	cgrp = perf_cgroup_from_task(task, NULL);
>  	if (READ_ONCE(cpuctx->cgrp) == cgrp)
>  		return;
>  
> @@ -3631,8 +3636,7 @@ void __perf_event_task_sched_out(struct task_struct *task,
>  	 * to check if we have to switch out PMU state.
>  	 * cgroup event are system-wide mode only
>  	 */
> -	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
> -		perf_cgroup_switch(next);
> +	perf_cgroup_switch(next);
>  }
>  
>  static bool perf_less_group_idx(const void *l, const void *r)
> @@ -4974,15 +4978,6 @@ static void unaccount_pmu_sb_event(struct perf_event *event)
>  		detach_sb_event(event);
>  }
>  
> -static void unaccount_event_cpu(struct perf_event *event, int cpu)
> -{
> -	if (event->parent)
> -		return;
> -
> -	if (is_cgroup_event(event))
> -		atomic_dec(&per_cpu(perf_cgroup_events, cpu));
> -}
> -
>  #ifdef CONFIG_NO_HZ_FULL
>  static DEFINE_SPINLOCK(nr_freq_lock);
>  #endif
> @@ -5048,8 +5043,6 @@ static void unaccount_event(struct perf_event *event)
>  			schedule_delayed_work(&perf_sched_work, HZ);
>  	}
>  
> -	unaccount_event_cpu(event, event->cpu);
> -
>  	unaccount_pmu_sb_event(event);
>  }
>  
> @@ -11679,15 +11672,6 @@ static void account_pmu_sb_event(struct perf_event *event)
>  		attach_sb_event(event);
>  }
>  
> -static void account_event_cpu(struct perf_event *event, int cpu)
> -{
> -	if (event->parent)
> -		return;
> -
> -	if (is_cgroup_event(event))
> -		atomic_inc(&per_cpu(perf_cgroup_events, cpu));
> -}
> -
>  /* Freq events need the tick to stay alive (see perf_event_task_tick). */
>  static void account_freq_event_nohz(void)
>  {
> @@ -11775,8 +11759,6 @@ static void account_event(struct perf_event *event)
>  	}
>  enabled:
>  
> -	account_event_cpu(event, event->cpu);
> -
>  	account_pmu_sb_event(event);
>  }
>  
> @@ -12822,13 +12804,11 @@ static void __perf_pmu_remove(struct perf_event_context *ctx,
>  
>  	perf_event_groups_for_cpu_pmu(event, groups, cpu, pmu) {
>  		perf_remove_from_context(event, 0);
> -		unaccount_event_cpu(event, cpu);
>  		put_pmu_ctx(event->pmu_ctx);
>  		list_add(&event->migrate_entry, events);
>  
>  		for_each_sibling_event(sibling, event) {
>  			perf_remove_from_context(sibling, 0);
> -			unaccount_event_cpu(sibling, cpu);
>  			put_pmu_ctx(sibling->pmu_ctx);
>  			list_add(&sibling->migrate_entry, events);
>  		}
> @@ -12847,7 +12827,6 @@ static void __perf_pmu_install_event(struct pmu *pmu,
>  
>  	if (event->state >= PERF_EVENT_STATE_OFF)
>  		event->state = PERF_EVENT_STATE_INACTIVE;
> -	account_event_cpu(event, cpu);
>  	perf_install_in_context(ctx, event, cpu);
>  }
>  
> @@ -13742,8 +13721,7 @@ static int __perf_cgroup_move(void *info)
>  	struct task_struct *task = info;
>  
>  	preempt_disable();
> -	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
> -		perf_cgroup_switch(task);
> +	perf_cgroup_switch(task);
>  	preempt_enable();
>  
>  	return 0;
