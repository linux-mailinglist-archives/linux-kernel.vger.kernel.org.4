Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509C869E9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBUVnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBUVni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:43:38 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C001E2BD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:43:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c1so6833076plg.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lC9UgIUJfhwS67omGCcmYKZPBx7QNJ2T6Qs11z2tPT0=;
        b=SIhsDmDcBCZ7FKJkAr8rPhDUWX/2xPJN4T8EWXk+hxwYZmhnnfKrl0v1mIMbKQY9QT
         hrsLSirWfyR2YfNZATybcPqopF9GHfr7RjPuZsq7n583A5YCuHYaGAfwCAnsKBh9EvFc
         finOjDXTRf+/WmJQR16Q09kq5GO1gufX6bk+NsZ8/R2hXJDj3mS6pO0hUx9fneZtmc8O
         qD/xjoytIH0df+YtiZlNyms/CDH7BW2ZVkc5Bsc8bLLU1Lx6GoFt1piFzhu46vu0sEER
         aGy45tFA/ZoSWXOr9tA1rxHH9DkcXQSNbEy3nMT2by+157EtehRD/dR29nmqmeZW/RV7
         APRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lC9UgIUJfhwS67omGCcmYKZPBx7QNJ2T6Qs11z2tPT0=;
        b=foOzZ711rZY2+NWhGmc4SXCZf3kGe6vo97jxY0oK/dIG+Z0UIXK92Z+UxBIEA57nKM
         vjJWMkzscYSVCPEZWL6EYYaskwqps4LTjeNnrmJbGhM25gJOaJ1V0su9YLQCN/q78bRY
         rFmHb5oU/2L8SlmeYu8N27waPJbrZdlyIJ9DaVJRi8H49xv+q2VMlnKRA1F5cimzWsqO
         /IAYnaykYcFIEwW6R8USQqkFgda6ji+hDUwtIUOhDXajvpRaRLijLL2oD0Iapx3Owcf1
         t8YLnbrRGrCYTWzg28+NwSXJuJlsmaTzVMcQY4TrCDZQNVwvKNKn2SwVz4DcMPrPFQAm
         oqiw==
X-Gm-Message-State: AO0yUKUfwoK3O34P1A99M3p6s5xFmu9QIdcz6N8n9B7JqXtNWhE4jiLQ
        T+4BKI2sVmdKEZbfH1UQnWQPAiVwbGRf+qJd3nU=
X-Google-Smtp-Source: AK7set++dHBvDd33vPRxWxyuD2yW2SvN0u4KnRvd8aDMIH+S6ym0TMGCSeTHrtDRvYGvZro+I3dIiA==
X-Received: by 2002:a17:903:1386:b0:198:af4f:de12 with SMTP id jx6-20020a170903138600b00198af4fde12mr4553plb.18.1677015810045;
        Tue, 21 Feb 2023 13:43:30 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-67-188-112-16.hsd1.ca.comcast.net. [67.188.112.16])
        by smtp.gmail.com with ESMTPSA id j23-20020aa79297000000b00593cd0f37dcsm2188185pfa.169.2023.02.21.13.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 13:43:28 -0800 (PST)
From:   Benjamin Segall <bsegall@google.com>
To:     shrikanth hegde <sshegde@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Thomas Gleixner <tglx@linutronix.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Interleave cfs bandwidth timers for
 improved single thread performance at low utilization
References: <9c57c92c-3e0c-b8c5-4be9-8f4df344a347@linux.vnet.ibm.com>
        <Y/Ov+DzOtA0iHfFO@hirez.programming.kicks-ass.net>
        <0c4d7bbb-3fef-031e-e9a1-a678ab68ade7@linux.vnet.ibm.com>
Date:   Tue, 21 Feb 2023 13:43:27 -0800
In-Reply-To: <0c4d7bbb-3fef-031e-e9a1-a678ab68ade7@linux.vnet.ibm.com>
        (shrikanth hegde's message of "Wed, 22 Feb 2023 00:23:05 +0530")
Message-ID: <xm267cwa4ruo.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shrikanth hegde <sshegde@linux.vnet.ibm.com> writes:

> On 2/20/23 11:08 PM, Peter Zijlstra wrote:
>> On Tue, Feb 14, 2023 at 08:54:09PM +0530, shrikanth hegde wrote:
>> 
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index ff4dbbae3b10..7b69c329e05d 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -5939,14 +5939,25 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>>
>>>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>>>  {
>>> -	lockdep_assert_held(&cfs_b->lock);
>>> +	struct hrtimer *period_timer = &cfs_b->period_timer;
>>> +	s64 incr = ktime_to_ns(cfs_b->period) / 10;
>>> +	ktime_t delta;
>>> +	u64 orun = 1;
>>>
>>> +	lockdep_assert_held(&cfs_b->lock);
>>>  	if (cfs_b->period_active)
>>>  		return;
>>>
>>>  	cfs_b->period_active = 1;
>>> -	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>>> -	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>>> +	delta = ktime_sub(period_timer->base->get_time(),
>>> +			hrtimer_get_expires(period_timer));
>>> +	if (unlikely(delta >= cfs_b->period)) {
>>> +		orun = ktime_divns(delta, incr);
>>> +		hrtimer_add_expires_ns(period_timer, incr * orun);
>>> +	}
>>> +
>>> +	hrtimer_forward_now(period_timer, cfs_b->period);
>>> +	hrtimer_start_expires(period_timer, HRTIMER_MODE_ABS_PINNED);
>>>  }
>> 
>> What kind of mad hackery is this? Why can't you do the sane thing and
>> initialize the timer at !0 in init_cfs_bandwidth(), then any of the
>> forwards will stay in period -- as they should.
>> 
>> Please, go re-read Thomas's email.
>
> Thank you Peter for taking a look and review.
> we can scrap this implementation and switch to the one you suggested.
> All we need is to initialize the offset. 
>
> Only reason was the way i had implemented. This implementation couldn't be
> fit into init_cfs_bandwidth as timers would align if the cgroups are 
> created together and continue to align forever. 
>
>> 
>> *completely* untested...
>> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7c46485d65d7..4d6ea76096dc 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5915,6 +5915,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>> 
>>  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
>>  	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
>> +	cfs_b->period_timer.node.expires = get_random_u32_below(cfs_b->period);
>
> This approach/implementation is better as the random function provides uniform  
> distribution. Had to modify this a bit to make it work.  Along with setting     
> setting node.expires, we need to set _softexpires as well. Which is what        
> hrtimer_set_expires does.
>
> Here are the similar numbers again.
> 8 Core system with SMT=8. Total of 64 CPU                                       
> Workload: stress-ng --cpu=32 --cpu-ops=50000                                    
>                                                                                 
>            6.2-rc6                     |   with patch                           
> 8Core   1CG    power    2CG     power  |  1CG    power  2CG    power           
>         27.5    80.6    40      90     |  27.3    82    32.3    104             
>         27.5    81      40.2    91     |  27.5    81    38.7     96             
>         27.7    80      40.1    89     |  27.6    80    29.7    115             
>         27.7    80.1    40.3    94     |  27.6    80    31.5    105   
>
> Will collect some more benchmarks numbers w.r.t to performance.
>
>
>>  	cfs_b->period_timer.function = sched_cfs_period_timer;
>>  	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>>  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
>
> This below patch worked. 
> Does the below patch look okay? shall i send the [PATCH V1] with this
> change?

Yeah, this design makes way more sense.

>
> Question. 
> Should we skip this adding the offset for root_task_group?

The value should never come up, so it's just a question of if it's fine
to call get_random_* in early contexts, which I don't know offhand.

>
>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff4dbbae3b10..6448533178af 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5923,6 +5923,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
>  	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
>  	cfs_b->period_timer.function = sched_cfs_period_timer;
> +	/* Add a random offset so that timers interleave */
> +	hrtimer_set_expires(&cfs_b->period_timer, get_random_u32_below(cfs_b->period));
> +
>  	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
>  	cfs_b->slack_started = false;
