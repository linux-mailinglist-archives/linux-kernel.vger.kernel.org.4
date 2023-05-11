Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6766FEA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjEKEGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjEKEF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:05:58 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F3C44A4
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:05:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aaf91ae451so76165265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683777933; x=1686369933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eWlRUUZGBFaKuq4EKVx9pGaWvZYd54Hf9ePdoVjWuw=;
        b=Or1PsViZ28kJMmfxZkHl5Jp/Ep91br3CoPvO0+P75qiMkObtrKAJ7DhyWGSnzgl59z
         +ntvdJV+ftEKJMQ8FZINwSD1e+ozbe7WhOAa6de+Tcfh8EvZav17dF+vdeBWBJchvZJb
         xJryQrneXDY9JO9Jfn9uaEyn9ERjit0RyFAb6zaOqETQIBZBpZwpCj9RxLegivRniIJ8
         ELyBq2+hlnsXVsoIuzggkTCrJiqrNYt0fBgaYp2DWRtdiy0dNCl8khMC6lKSxw2cZQnb
         5P1FhCT0LR/IUOKbVwUsWZTmWLuFh9JKAA0GKbgeJ9pEhTQVnEs6tAHf27BRl7nsvgTT
         MqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683777933; x=1686369933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7eWlRUUZGBFaKuq4EKVx9pGaWvZYd54Hf9ePdoVjWuw=;
        b=X8waV26ezp8gJe0whk7y2hfHJKiYwRywI8pJyyRL2iLLhkNkVVbxWodCowxiv573ID
         Lizc7z5nmJcHZmEJhVapq+yHsX8/92t42lk98Yl7zRJyVz/NMpLi4E42NiT05hopusop
         AkYHGFwXPqB9bKzlpGjxJiUHPvQNLgL9dlEIbt09EQcD3+g8KPO5KiPX+OzD14DPZUnp
         t9pAZbPNduCQIaMlDsOx0JSPOuOMl7Y8NtlT82XnZm8khIYKV5EZkdRHk+KBvDKynfwC
         VOesgM75oHH+ilpJ4DIX5YaOwgmj+88zI+clh+YihSJi1kKMGLF5CDZFKteG6TWo4qMS
         x5jg==
X-Gm-Message-State: AC+VfDz6jjf9jiRIekm2u8Z+HYyQHlPwZbantVYQidPGAEph17c0ApLk
        4PaxkI8T1fkRU9aj5R5U3+L50g==
X-Google-Smtp-Source: ACHHUZ6GUwXPguOpqvv1OqiHWCMLuDDS7tnsm3HDqoC11oT8iXtTYH70PYGxfBabj4H59+Up0W3C1Q==
X-Received: by 2002:a17:902:e882:b0:1aa:f3c4:74e5 with SMTP id w2-20020a170902e88200b001aaf3c474e5mr24950838plg.0.1683777933284;
        Wed, 10 May 2023 21:05:33 -0700 (PDT)
Received: from [10.86.122.44] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001a980a23804sm4659657pll.4.2023.05.10.21.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 21:05:32 -0700 (PDT)
Message-ID: <7e751be3-c6e9-f89e-ab05-06f9195e3a5f@bytedance.com>
Date:   Thu, 11 May 2023 12:05:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH v2 2/2] sched/core: Avoid double calling
 update_rq_clock()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
References: <20230510083450.62334-1-jiahao.os@bytedance.com>
 <20230510083450.62334-3-jiahao.os@bytedance.com>
 <20230510143244.GM4253@hirez.programming.kicks-ass.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230510143244.GM4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/10 Peter Zijlstra wrote:
> On Wed, May 10, 2023 at 04:34:50PM +0800, Hao Jia wrote:

>> For the __balance_push_cpu_stop() case, we remove update_rq_clock() from
>> the __migrate_task() function to avoid double updating the rq clock.
>> And in order to avoid missing rq clock update, add update_rq_clock()
>> call before migration_cpu_stop() calls __migrate_task().
>>
>> For the unthrottle_cfs_rq() case, we use rq_clock_start_loop_update() to
>> prevent multiple calls to update_rq_clock() in unthrottle_cfs_rq().
>>
>> Note that the rq clock has been updated before the set_rq_offline()
>> function runs, so we don't need to call update_rq_clock() in
>> unthrottle_offline_cfs_rqs().
> 
> This reads like 3 separate issues -- in which case this ought to be 3
> separate patches.

I will do it in the next version.

Thanks,
Hao

> 
> 
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index ec7b3e0a2b20..9c712f29e5a4 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1536,6 +1536,27 @@ static inline void rq_clock_skip_update(struct rq *rq)
>>   	rq->clock_update_flags |= RQCF_REQ_SKIP;
>>   }
>>   
>> +/*
>> + * During cpu offlining and rq wide unthrottling, we can trigger
>> + * an update_rq_clock() for several cfs and rt runqueues (Typically
>> + * when using list_for_each_entry_*)
>> + * rq_clock_start_loop_update() can be called after updating the clock
>> + * once and before iterating over the list to prevent multiple update.
>> + * After the iterative traversal, we need to call rq_clock_stop_loop_update()
>> + * to restore rq->clock_update_flags.
>           ^^^^^^^
>> + */
>> +static inline void rq_clock_start_loop_update(struct rq *rq)
>> +{
>> +	lockdep_assert_rq_held(rq);
>> +	rq->clock_update_flags |= RQCF_ACT_SKIP;
>> +}
>> +
>> +static inline void rq_clock_stop_loop_update(struct rq *rq)
>> +{
>> +	lockdep_assert_rq_held(rq);
>> +	rq->clock_update_flags &= ~RQCF_ACT_SKIP;
>> +}
> 
> This does not restore the flag, it clears the flag.

Thanks for your review.
I will also modify it in the next version.

Thanks,
Hao
