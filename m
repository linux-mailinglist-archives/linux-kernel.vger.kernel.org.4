Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F995F7A73
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJGPXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJGPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE252BB0A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665156209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0zkP1DFoQh1o4BGqMLDIYV20TUATGz3NEL7A1fKH5eA=;
        b=EqrX5xWOXQnBelOAVvYGbZeIl38+UPQ7XbZki/ArYqpQtXZqWZSpYiUGVD0pbpiF/OzFvJ
        xyWrrGH9N0LkASJeNeMt5Y0FXUhbDLSLuoWArywU+xKmrm+uLpZEAqf5vWtw/370N8amks
        wpe0fry2vbMA27rK5HBjfpymK1kPMOE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-GBUdlKU6N7SAUq2ywZhftw-1; Fri, 07 Oct 2022 11:23:26 -0400
X-MC-Unique: GBUdlKU6N7SAUq2ywZhftw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E95F780206D;
        Fri,  7 Oct 2022 15:23:25 +0000 (UTC)
Received: from [10.22.18.97] (unknown [10.22.18.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9DEC403167;
        Fri,  7 Oct 2022 15:23:24 +0000 (UTC)
Message-ID: <f115b037-e687-38f2-a270-bbf3c9f90ef8@redhat.com>
Date:   Fri, 7 Oct 2022 11:23:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v10 3/5] sched: Enforce user requested affinity
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <20220922180041.1768141-1-longman@redhat.com>
 <20220922180041.1768141-4-longman@redhat.com>
 <Yz/5CZ8nj7MI+cO2@hirez.programming.kicks-ass.net>
 <2afd6a8c-016b-0a7c-8574-d2a10641938f@redhat.com>
In-Reply-To: <2afd6a8c-016b-0a7c-8574-d2a10641938f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/22 10:57, Waiman Long wrote:
>
> On 10/7/22 06:01, Peter Zijlstra wrote:
>> On Thu, Sep 22, 2022 at 02:00:39PM -0400, Waiman Long wrote:
>>> @@ -9647,6 +9656,9 @@ void __init sched_init(void)
>>>               cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>>>           per_cpu(select_rq_mask, i) = (cpumask_var_t)kzalloc_node(
>>>               cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>>> +        per_cpu(runqueues.scratch_mask, i) =
>>> +            (cpumask_var_t)kzalloc_node(cpumask_size(),
>>> +                            GFP_KERNEL, cpu_to_node(i));
>>>       }
>>>   #endif /* CONFIG_CPUMASK_OFFSTACK */
>> That doesn't actually apply; I've made it:
>>
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -9748,6 +9748,7 @@ void __init sched_init(void)
>>             rq->core_cookie = 0UL;
>>   #endif
>> + zalloc_cpumask_var_node(&per_cpu(runqueues.scratch_mask, i), 
>> GFP_KERNEL, cpu_to_node(i));
>>       }
>>         set_load_weight(&init_task, false);
>>
> Sorry, I should have worked on the latest tip tree instead.

To be consistent with the surround context, it may be better to change 
it to

+        zalloc_cpumask_var_node(rq->scratch_mask, GFP_KERNEL, 
cpu_to_node(i));

Cheers,
Longman

