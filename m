Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7D63124A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 03:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKTCW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 21:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKTCW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 21:22:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FE811808
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 18:22:54 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y4so7760101plb.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 18:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAYxavzBh7dTg5qYVFFIARc9JdCSkYiV8sYDq21yJgo=;
        b=U5rYp7ntQpJWnHWauDEUuWONMjpOBFNsgN77WM1RfleTF+7IslK3H4UjSv2EdYDDmE
         LBaYHjhvAe2uWpZpYROJhVq9Wpm1qZ+MP08wn8uO6hhaKtk80tDN4rOD7wH2ZD4ndNFx
         jLJ+Ump1QITJ2gIj8adA0qMz+VkCjcO700LI1DMvFjan6Odb5LEG5I6Jw+YZyXT2YvNd
         qBLkHZAMlbn+xkhfBrZX/aG3/cA/x9h9nf9Ts3vg/G426Gof6/d0uy0KS5Dun+5MuD1M
         UM/B6xw9BB4BZ6+cRlgdQKgZLgGwA0oNNoRedYm93pRBHp7++Rby1AQfThWs27/Fhbnn
         Kr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAYxavzBh7dTg5qYVFFIARc9JdCSkYiV8sYDq21yJgo=;
        b=6GPG9IR3euatLfUZoFPmrqruzkIBnE4nLdp+mX4jeQXqyQt/fBVNdtNBcTbWl9p5x8
         D/Fe/tNDwxv4WjgydbMp0RvPk50NKQi4dr9dg7xkH9K7IfrGKxZ0aSSkllY083wJ8YZ6
         HEb5wHS1U+86iPQHDQJZKBRgz6nGPeR7ojaflYtbE+xpogdwb3hrKteSxhJBFPUP2ACP
         oYSGsBdR6+jxIpx4tlJ2DNEfs4rHf1lRHCpf+5m5tYGYe0/+MzpyUmtfX/orOlYZx0bI
         tc/q9YDfxyxJ0Wa7m2kNHKSyMrN0nAKAHubPsfWkkouBPUVX7xZNmrE+fNv5gKvdpTJz
         TrUA==
X-Gm-Message-State: ANoB5pla9Oi7Dh65EA7O2T4kkPn0Wwo8wVRgQaTZUtVyxlfTOOAcRmPD
        5Z6PYeT2xgZaNT6rOf1hD4UjWQ==
X-Google-Smtp-Source: AA0mqf6LvDxsMedfgFPG8RHNwqB/bLf7x6CJ3Z6AtXA/xznfEkQPbXcXYtyRr/fnQRt9EsZBl/Z+3A==
X-Received: by 2002:a17:90a:73c2:b0:200:a7b4:6511 with SMTP id n2-20020a17090a73c200b00200a7b46511mr14185138pjk.101.1668910973557;
        Sat, 19 Nov 2022 18:22:53 -0800 (PST)
Received: from ?IPV6:2409:8a28:e64:1940:9c00:a387:b0ad:7a03? ([2409:8a28:e64:1940:9c00:a387:b0ad:7a03])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090300d200b00186b138706fsm6477954plc.13.2022.11.19.18.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 18:22:52 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
X-Google-Original-From: Chengming Zhou <chengming.zhou@linux.dev>
Message-ID: <094299a3-f039-04c1-d749-2bea0bc14246@linux.dev>
Date:   Sun, 20 Nov 2022 10:22:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
Content-Language: en-US
To:     Josh Don <joshdon@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
References: <20221117005418.3499691-1-joshdon@google.com>
 <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
In-Reply-To: <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/19 03:25, Josh Don wrote:
> On Fri, Nov 18, 2022 at 4:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> preempt_disable() -- through rq->lock -- also holds off rcu. Strictly
>> speaking this here is superfluous. But if you want it as an annotation,
>> that's fine I suppose.
> 
> Yep, I purely added this as extra annotation for future readers.
> 
>> Ideally we'd first queue all the remotes and then process local, but
>> given how all this is organized that doesn't seem trivial to arrange.
>>
>> Maybe have this function return false when local and save that cfs_rq in
>> a local var to process again later, dunno, that might turn messy.
> 
> Maybe something like this? Apologies for inline diff formatting.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 012ec9d03811..100dae6023da 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5520,12 +5520,15 @@ static bool distribute_cfs_runtime(struct
> cfs_bandwidth *cfs_b)
>         struct cfs_rq *cfs_rq;
>         u64 runtime, remaining = 1;
>         bool throttled = false;
> +       int this_cpu = smp_processor_id();
> +       struct cfs_rq *local_unthrottle = NULL;
> +       struct rq *rq;
> +       struct rq_flags rf;
> 
>         rcu_read_lock();
>         list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
>                                 throttled_list) {
> -               struct rq *rq = rq_of(cfs_rq);
> -               struct rq_flags rf;
> +               rq = rq_of(cfs_rq);
> 
>                 if (!remaining) {
>                         throttled = true;
> @@ -5556,14 +5559,36 @@ static bool distribute_cfs_runtime(struct
> cfs_bandwidth *cfs_b)
>                 cfs_rq->runtime_remaining += runtime;
> 
>                 /* we check whether we're throttled above */
> -               if (cfs_rq->runtime_remaining > 0)
> -                       unthrottle_cfs_rq_async(cfs_rq);
> +               if (cfs_rq->runtime_remaining > 0) {
> +                       if (cpu_of(rq) != this_cpu ||
> +                           SCHED_WARN_ON(local_unthrottle)) {
> +                               unthrottle_cfs_rq_async(cfs_rq);
> +                       } else {
> +                               local_unthrottle = cfs_rq;
> +                       }
> +               } else {
> +                       throttled = true;
> +               }

Hello,

I don't get the point why local unthrottle is put after all the remote cpus,
since this list is FIFO? (earliest throttled cfs_rq is at the head)

Should we distribute runtime in the FIFO order?

Thanks.

> 
>  next:
>                 rq_unlock_irqrestore(rq, &rf);
>         }
>         rcu_read_unlock();
> 
> +       /*
> +        * We prefer to stage the async unthrottles of all the remote cpus
> +        * before we do the inline unthrottle locally. Note that
> +        * unthrottle_cfs_rq_async() on the local cpu is actually synchronous,
> +        * but it includes extra WARNs to make sure the cfs_rq really is
> +        * still throttled.
> +        */
> +       if (local_unthrottle) {
> +               rq = cpu_rq(this_cpu);
> +               rq_lock_irqsave(rq, &rf);
> +               unthrottle_cfs_rq_async(local_unthrottle);
> +               rq_unlock_irqrestore(rq, &rf);
> +       }
> +
>         return throttled;
>  }
> 
> Note that one change we definitely want is the extra setting of
> throttled = true in the case that cfs_rq->runtime_remaining <= 0, to
> catch the case where we run out of runtime to distribute on the last
> entity in the list.
> 
>>> +
>>> +     /* Already enqueued */
>>> +     if (SCHED_WARN_ON(!list_empty(&cfs_rq->throttled_csd_list)))
>>> +             return;
>>> +
>>> +     list_add_tail(&cfs_rq->throttled_csd_list, &rq->cfsb_csd_list);
>>> +
>>> +     smp_call_function_single_async(cpu_of(rq), &rq->cfsb_csd);
>>
>> Hurmph.. so I was expecting something like:
>>
>>         first = list_empty(&rq->cfsb_csd_list);
>>         list_add_tail(&cfs_rq->throttled_csd_list, &rq->cfsb_csd_list);
>>         if (first)
>>                 smp_call_function_single_async(cpu_of(rq), &rq->cfsb_csd);
>>
>> But I suppose I'm remembering the 'old' version. I don't think it is
>> broken as written. There's a very narrow window where you'll end up
>> sending a second IPI for naught, but meh.
> 
> The CSD doesn't get  unlocked until right before we call the func().
> But you're right that that's a (very) narrow window for an  extra IPI.
> Please feel free to modify the patch with that diff if you like.
> 
>>
>>> +}
>>
>> Let me go queue this thing, we can always improve upon matters later.
> 
> Thanks! Please add at least the extra assignment of 'throttled = true'
> from the diff above, but feel free to squash both the diffs if it
> makes sense to you.
