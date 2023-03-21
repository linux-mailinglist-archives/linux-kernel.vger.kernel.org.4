Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6356C2A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCUGRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCUGRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:17:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949AB28D25
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:17:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o2so7596951plg.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679379423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/XFy3BrtprXmq1aKoa/kZV0js+UWaXDXYxM8MGGdLM=;
        b=CjZckBepbyPqCNhM64GAICMEtyA/D5nH7tIHa3iA4TEPj/MMUYbW2jPMRqntuA+DZN
         6wxh9lCd6W24O9rhl6AHzW5cZs+QLOpGGVPXbPgCpYORa5k3jyojV4qkAOY5TVO9Q2OH
         wy51MVdrWAbAhohVsRTGw0ZEGEsgsMNViPxgRRhCb/9GrexHCJThOcOdc+mhcd9bB+1M
         5GmsvlP9gUrG80qpXaIDuNNtms2pwzKg2Fpqjs00Fl86AQnr2NCckNmY/j0kjqc+0ZXL
         CY7CuvV+mf0zAmsruTdDS9l0JSiL38EtMN5VDvBz55qey3MVQJJJ15zjV/AK5zrlGBS6
         5tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g/XFy3BrtprXmq1aKoa/kZV0js+UWaXDXYxM8MGGdLM=;
        b=bjTdfG8ZK4JtZuxkYUMC5dMuTe0OzKLfbgmzNsK3lgmy/zDfJxF2HHMzZDHXCmmPgD
         3zdb0DMruiELG+LA7C0g2ncBLW/hhxR74GNrhZzL26RWud4Urs0aGBxEOisDXWYu/1zZ
         2V6CN4VLB+0052OqdrmOVX+mKhMrazjDtxmALlcdEBrE+QLXOMumk2UTh8h7cLbbyvcO
         oawoFI/cPUP6tKGVyiNxzkluus3EZGMfJBzxtVj8Si9n/uH1YUGLH9bAwyeJH2o2S+60
         dCLlJN0ZwFYzCWOqF3EbRm4luHfYp4M9kwc95IMY/GRCVuq3DX1VlOuDkiTb8w49G2Ys
         fauQ==
X-Gm-Message-State: AO0yUKUtiqb9I15HRXu7dPZIsfKvL/S4BUjAMCX8oYXb+mWWmsysmnmL
        xoyTRJ+Ly8Te5ulR76yPOffS2g==
X-Google-Smtp-Source: AK7set/EPNVI2Hq/yPps/ElVd+VMkvSGzQrrOgO1fT/PlHgx/aUppMyB7cG0d7AB4gMsGXTw09JQzg==
X-Received: by 2002:a17:903:120f:b0:19e:874e:7275 with SMTP id l15-20020a170903120f00b0019e874e7275mr1467005plh.23.1679379423129;
        Mon, 20 Mar 2023 23:17:03 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902b78100b001a199972508sm7735810pls.124.2023.03.20.23.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 23:17:02 -0700 (PDT)
Message-ID: <18404dfb-c727-1b33-a5f9-0e7b65e74f66@bytedance.com>
Date:   Tue, 21 Mar 2023 14:16:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [External] Re: [PATCH] sched/core: Avoid selecting the task that
 is throttled to run when core-sched enable
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
References: <20230316081806.69544-1-jiahao.os@bytedance.com>
 <20230320124701.GL2194297@hirez.programming.kicks-ass.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230320124701.GL2194297@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/20 Peter Zijlstra wrote:
> On Thu, Mar 16, 2023 at 04:18:06PM +0800, Hao Jia wrote:
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index af017e038b48..27cb06e19b12 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -261,36 +261,51 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
>>   		resched_curr(rq);
>>   }
>>   
>> +static int sched_task_is_throttled(struct task_struct *p, int cpu)
>>   {
>> +	if (p->sched_class->task_is_throttled)
>> +		return p->sched_class->task_is_throttled(p, cpu);
>>   
>> +	return 0;
>>   }
>>   
>>   static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
>>   {
>>   	struct rb_node *node = &p->core_node;
>> +	int cpu = task_cpu(p);
>> +
>> +	do {
>> +		node = rb_next(node);
>> +		if (!node)
>> +			return NULL;
>> +
>> +		p = container_of(node, struct task_struct, core_node);
> 
> I've changed this to __node_2_sc() to match the rest. It looks to have
> been randomly not using it.

OK, Thanks!
> 
>> +		if (p->core_cookie != cookie)
>> +			return NULL;
>> +	} while (sched_task_is_throttled(p, cpu));
>> +
>> +	return p;
>> +}
>>   
>> +/*
>> + * Find left-most (aka, highest priority) and unthrottled task matching @cookie.
>> + * If no suitable task is found, NULL will be returned.
>> + */
>> +static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
>> +{
>> +	struct task_struct *p;
>> +	struct rb_node *node;
>> +
>> +	node = rb_find_first((void *)cookie, &rq->core_tree, rb_sched_core_cmp);
>>   	if (!node)
>>   		return NULL;
>>   
>> +	p = __node_2_sc(node);
>> +	if (!sched_task_is_throttled(p, rq->cpu))
>> +		return p;
>> +
>> +	return sched_core_next(p, cookie);
>>   }
>>   
>>   /*
> 
> OK, fair enough.

Thanks for your review. Do I need to modify to send V2 patch?

Thanks,
Hao
> 
> 
