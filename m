Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71D56BB6E8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjCOPGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjCOPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:06:35 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AAE1814D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:06:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VdweCzU_1678892786;
Received: from 30.0.170.252(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0VdweCzU_1678892786)
          by smtp.aliyun-inc.com;
          Wed, 15 Mar 2023 23:06:30 +0800
Message-ID: <7b331383-e6b7-f94b-6af8-72d5d8d688bf@linux.alibaba.com>
Date:   Wed, 15 Mar 2023 23:06:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/resctrl: Only show tasks' pids in current pid
 namespace
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, james.morse@arm.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20230116071246.97717-1-shawnwang@linux.alibaba.com>
 <95fca7d1-d473-e9e2-b6c8-c4ae3d44d2df@intel.com>
From:   Shawn Wang <shawnwang@linux.alibaba.com>
In-Reply-To: <95fca7d1-d473-e9e2-b6c8-c4ae3d44d2df@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 2/16/23 5:43 AM, Reinette Chatre wrote:
> Hi Shawn,
> 
> On 1/15/2023 11:12 PM, Shawn Wang wrote:
>> When writing a task id to the "tasks" file in an rdtgroup,
>> rdtgroup_tasks_write() treats the pid as a number in the current pid
>> namespace. But when reading the "tasks" file, rdtgroup_tasks_show() shows
>> the list of global pids from the init namespace. If current pid namespace
>> is not the init namespace, pids in "tasks" will be confusing and incorrect.
>>
>> To be more robust, let the "tasks" file only show pids in the current pid
>> namespace.
>>
> 
> Is it possible to elaborate more on the use case that this is aiming to
> address? It is unexpected to me that resource management is approached from
> within a container. My expectation is that the resource management and monitoring
> is done from the host.

We have a scenario where we only want to mount the resctrl filesystem under a specific container.
And We found that the pids in the tasks under resctrl are inconsistent with the pids obtained by top.

Besides, current rdtgroup_move_task() uses the find_task_by_vpid() to get the real pid.
Our modification is also to maintain symmetry with the rdtgroup_move_task().

>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 5993da21d822..9e97ae24c159 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -718,11 +718,15 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>>   static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
>>   {
>>   	struct task_struct *p, *t;
>> +	pid_t pid;
>>   
>>   	rcu_read_lock();
>>   	for_each_process_thread(p, t) {
>> -		if (is_closid_match(t, r) || is_rmid_match(t, r))
>> -			seq_printf(s, "%d\n", t->pid);
>> +		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
>> +			pid = task_pid_vnr(t);
>> +			if (pid)
>> +				seq_printf(s, "%d\n", pid);
>> +		}
>>   	}
>>   	rcu_read_unlock();
>>   }
> 
> This looks like it would solve the stated problem. Does it slow down
> reading a tasks file in a measurable way?

We didn't test it, but it is proportional to the number of pids in the group.
In addition, only an if statement is added here, and actually the reading of
the tasks interface will not be called frequently, so it will not be a bottleneck.

Thanks,
Shawn
