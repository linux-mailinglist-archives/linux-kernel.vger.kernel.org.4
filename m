Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF03639402
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 06:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiKZFbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 00:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiKZFbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 00:31:31 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EDD27DE7;
        Fri, 25 Nov 2022 21:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669440690; x=1700976690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TMHajWVMCTIkEZPhUcbuPvDsvB/UrywpiTrMk6I6Rb0=;
  b=RDWASuecXBUddgsg28Fr4cK/yecHWpN35t/6KEaGBWPFMh5iqOwLpgYY
   VnSqUvu5IONJ1CM88hcJkmz5898UJVazAZk6b/JE/I/TtkTzkRL+QGf04
   +TQm5Z+uTz/T5vbiRjxE3zeN2AQ1N/mww1+L+maW+zhob0pBPEVggoDbt
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Nov 2022 21:31:29 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 21:31:29 -0800
Received: from [10.50.56.30] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 25 Nov
 2022 21:31:26 -0800
Message-ID: <1401b84a-4f40-df5a-b200-761b19103410@quicinc.com>
Date:   Sat, 26 Nov 2022 11:01:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        <neeraj.iitr10@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221125155427.1381933-1-qiang1.zhang@intel.com>
 <Y4F5r9nLDtCrl6df@google.com>
 <PH0PR11MB588009DA52C17BAE7388F99EDA119@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y4GXUFn12oVkk/d8@google.com>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <Y4GXUFn12oVkk/d8@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 11/26/2022 10:04 AM, Joel Fernandes wrote:
> On Sat, Nov 26, 2022 at 02:43:59AM +0000, Zhang, Qiang1 wrote:
>> On Fri, Nov 25, 2022 at 11:54:27PM +0800, Zqiang wrote:
>>> Currently, for the case of num_online_cpus() <= 1, return directly,
>>> indicates the end of current grace period and then release old data.
>>> it's not accurate, for SMP system, when num_online_cpus() is equal
>>> one, maybe another cpu that in offline process(after invoke
>>> __cpu_disable()) is still in the rude RCU-Tasks critical section
>>> holding the old data, this lead to memory corruption.
>>>
>>> Therefore, this commit add cpus_read_lock/unlock() before executing
>>> num_online_cpus().
>>
>>
>>> I am not sure if this is needed. The only way what you suggest can happen is
>>> if the tasks-RCU protected data is accessed after the num_online_cpus() value is
>>> decremented on the CPU going offline.
>>>
>>> However, the number of online CPUs value is changed on a CPU other than the
>>> CPU going offline.
>>>
>>> So there's no way the CPU going offline can run any code (it is already
>>> dead courtesy of CPUHP_AP_IDLE_DEAD). So a corruption is impossible.
>>>
>>> Or, did I miss something?
>>
>> Hi joel
>>
>> Suppose the system has two cpus
>>
>> 	CPU0                                                                     CPU1
>> 					     cpu_stopper_thread
>>                                                                                    take_cpu_down
>> 						    __cpu_disable
>> 							dec __num_online_cpus
>>   rcu_tasks_rude_wait_gp                                      cpuhp_invoke_callback
> 
> Thanks for clarifying!
> 
> You are right, this can be a problem for anything in the stop machine on the
> CPU going offline from CPUHP_AP_ONLINE to CPUHP_AP_IDLE_DEAD, during which
> the code execute on that CPU is not accounted for in num_online_cpus().
> 
> Actually Neeraj found a similar issue 2 years ago and instead of hotplug
> lock, he added a new attribute to rcu_state to track number of CPUs.
> 
> See:
> https://lore.kernel.org/r/20200923210313.GS29330@paulmck-ThinkPad-P72
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2317853.html
> 
> Could we do something similar?
> 
> Off note is the comment in that thread:
>    Actually blocking CPU hotplug would not only result in excessive overhead,
>    but would also unnecessarily impede CPU-hotplug operations.
> 
> Neeraj is also on the thread and could chime in.
> 

I agree that using a counter, which is updated on the control CPU - 
after the CPU is dead ( for offline case) and before the CPU starts 
executing in kernel (for online case) optimizes the fast path.
However, given that, in the common case (num_online_cpus() > 1),
we also need to acquire cpus_read_lock(), I am not sure of how much 
actual impact that optimization will have.


Thanks
Neeraj

> Thanks,
> 
>   - Joel
> 
> 
>> 	num_online_cpus() == 1
>> 		return;
>>          
>> when __num_online_cpus == 1, the CPU1 not completely offline.
>>
>> Thanks
>> Zqiang
>>
>>>
>>> thanks,
>>>
>>> - Joel
>>
>>
>>
>>>
>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>> ---
>>>   kernel/rcu/tasks.h | 20 ++++++++++++++++++--
>>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>>> index 4a991311be9b..08e72c6462d8 100644
>>> --- a/kernel/rcu/tasks.h
>>> +++ b/kernel/rcu/tasks.h
>>> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct *work)
>>>   {
>>>   }
>>>   
>>> +static DEFINE_PER_CPU(struct work_struct, rude_work);
>>> +
>>>   // Wait for one rude RCU-tasks grace period.
>>>   static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>>>   {
>>> +	int cpu;
>>> +	struct work_struct *work;
>>> +
>>> +	cpus_read_lock();
>>>   	if (num_online_cpus() <= 1)
>>> -		return;	// Fastpath for only one CPU.
>>> +		goto end;// Fastpath for only one CPU.
>>>   
>>>   	rtp->n_ipis += cpumask_weight(cpu_online_mask);
>>> -	schedule_on_each_cpu(rcu_tasks_be_rude);
>>> +	for_each_online_cpu(cpu) {
>>> +		work = per_cpu_ptr(&rude_work, cpu);
>>> +		INIT_WORK(work, rcu_tasks_be_rude);
>>> +		schedule_work_on(cpu, work);
>>> +	}
>>> +
>>> +	for_each_online_cpu(cpu)
>>> +		flush_work(per_cpu_ptr(&rude_work, cpu));
>>> +
>>> +end:
>>> +	cpus_read_unlock();
>>>   }
>>>   
>>>   void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
>>> -- 
>>> 2.25.1
>>>
