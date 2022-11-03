Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18D56173FF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiKCCGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKCCGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:06:43 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A10F12088;
        Wed,  2 Nov 2022 19:06:42 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N2n9Y3kZnzJnQN;
        Thu,  3 Nov 2022 10:03:45 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 10:06:34 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 10:06:33 +0800
Subject: Re: [PATCH] ftrace: Fix use-after-free for dynamic ftrace_ops
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20221101064146.69551-1-lihuafei1@huawei.com>
 <20221102185348.40f9deab@rorschach.local.home>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <f54ae16d-81e9-c4a6-00aa-63902111bfb9@huawei.com>
Date:   Thu, 3 Nov 2022 10:06:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20221102185348.40f9deab@rorschach.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/3 6:53, Steven Rostedt wrote:
> On Tue, 1 Nov 2022 14:41:46 +0800
> Li Huafei <lihuafei1@huawei.com> wrote:
> 
> 
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index fbf2543111c0..4219cc2a04a6 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -3030,13 +3030,16 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
>>  
>>  	if (!command || !ftrace_enabled) {
> 
> ftrace_enabled is seldom not set. I don't think we even need to check
> it. It's just the value of /proc/sys/kernel/ftrace_enabled, where most
> people don't even know that file exists. I do want to get rid of it one
> day too. So let's not optimize for it.
> 

Agree. The code will look much simpler this way.

>>  		/*
>> -		 * If these are dynamic or per_cpu ops, they still
>> -		 * need their data freed. Since, function tracing is
>> -		 * not currently active, we can just free them
>> -		 * without synchronizing all CPUs.
>> +		 * If these are dynamic, they still need their data freed. If
>> +		 * function tracing is currently active, we neet to synchronize
>> +		 * all CPUs before we can release them.
>>  		 */
>> -		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
>> +		if (ops->flags & FTRACE_OPS_FL_DYNAMIC) {
>> +			if (ftrace_enabled)
>> +				goto sync_rcu;
>> +
>>  			goto free_ops;
> 
> Change the above just to "goto out;"
> 
>> +		}
>>  
>>  		return 0;
>>  	}
>> @@ -3083,6 +3086,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
>>  	 * ops.
>>  	 */
> 
> Add here:
> 
>  out:
> 
>>  	if (ops->flags & FTRACE_OPS_FL_DYNAMIC) {
>> + sync_rcu:
>>  		/*
>>  		 * We need to do a hard force of sched synchronization.
>>  		 * This is because we use preempt_disable() to do RCU, but
> 
> And get rid of the labels in the if block.
> 

Will make the above changes in v2, thanks!

> Thanks!
> 
> -- Steve
> 
> .
> 
