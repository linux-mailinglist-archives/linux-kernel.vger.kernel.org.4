Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4786C5BE28C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiITJ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiITJ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:59:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3B6F268
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:59:08 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oaa1y-0000La-Uh; Tue, 20 Sep 2022 11:59:06 +0200
Message-ID: <42237005-5a6e-9462-bfdd-f1ba0c725c72@leemhuis.info>
Date:   Tue, 20 Sep 2022 11:59:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
Content-Language: en-US, de-DE
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, vschneid@redhat.com,
        kernel-team@android.com, Derek Dolney <z23@posteo.net>,
        Vincent Donnefort <vdonnefort@google.com>, peterz@infradead.org
References: <20220725095952.206884-1-vdonnefort@google.com>
 <b5c5b02d-85ca-9d3b-2b3d-8892ab6d22a7@leemhuis.info>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <b5c5b02d-85ca-9d3b-2b3d-8892ab6d22a7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663667948;1c3a15dd;
X-HE-SMSGID: 1oaa1y-0000La-Uh
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.22 11:46, Thorsten Leemhuis wrote:
> 
> Hi, this is your Linux kernel regression tracker.
> 
> On 25.07.22 11:59, Vincent Donnefort wrote:
>> The DYING/STARTING callbacks are not expected to fail. However, as reported
>> by Derek, drivers such as tboot are still free to return errors within
>> those sections, which halts the hot(un)plug and leaves the CPU in an
>> unrecoverable state.
>>
>> No rollback being possible there, let's only log the failures and proceed
>> with the following steps. This restores the hotplug behaviour prior to
>> commit 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215867
>> Fixes: 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
>> Reported-by: Derek Dolney <z23@posteo.net>
>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>> Tested-by: Derek Dolney <z23@posteo.net>
> 
> What's the status here? Did that patch to fixing a regression fall
> through the cracks? It looks like nothing happened for 3 weeks now,
> that's why I wondered, but maybe I missed something.

Hmm, Vincent seems to be MIA, at least I see no recent messages from him
on lore. Odd. But well, it's still a fix for a regression and it's up to
v5 already; Valentin already added his Reviewed-by, too. Would be a
shame to waste this.

Thomas, could you maybe take a look at the patch?  Maybe we're lucky and
the patch is already good to go...

Ciao, Thorsten

#regzbot poke

> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
> 
> 
>> v4 -> v5:
>>    - Remove WARN, only log broken states with pr_warn.
>> v3 -> v4:
>>    - Sorry ... wrong commit description style ...
>> v2 -> v3:
>>    - Tested-by tag.
>>    - Refine commit description.
>>    - Bugzilla link.
>> v1 -> v2:
>>    - Commit message rewording.
>>    - More details in the warnings.
>>    - Some variable renaming
>>
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index bbad5e375d3b..621e5af42d57 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -663,21 +663,51 @@ static bool cpuhp_next_state(bool bringup,
>>  	return true;
>>  }
>>  
>> -static int cpuhp_invoke_callback_range(bool bringup,
>> -				       unsigned int cpu,
>> -				       struct cpuhp_cpu_state *st,
>> -				       enum cpuhp_state target)
>> +static int __cpuhp_invoke_callback_range(bool bringup,
>> +					 unsigned int cpu,
>> +					 struct cpuhp_cpu_state *st,
>> +					 enum cpuhp_state target,
>> +					 bool nofail)
>>  {
>>  	enum cpuhp_state state;
>> -	int err = 0;
>> +	int ret = 0;
>>  
>>  	while (cpuhp_next_state(bringup, &state, st, target)) {
>> +		int err;
>> +
>>  		err = cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
>> -		if (err)
>> +		if (!err)
>> +			continue;
>> +
>> +		if (nofail) {
>> +			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
>> +				cpu, bringup ? "UP" : "DOWN",
>> +				cpuhp_get_step(st->state)->name,
>> +				st->state, err);
>> +			ret = -1;
>> +		} else {
>> +			ret = err;
>>  			break;
>> +		}
>>  	}
>>  
>> -	return err;
>> +	return ret;
>> +}
>> +
>> +static inline int cpuhp_invoke_callback_range(bool bringup,
>> +					      unsigned int cpu,
>> +					      struct cpuhp_cpu_state *st,
>> +					      enum cpuhp_state target)
>> +{
>> +	return __cpuhp_invoke_callback_range(bringup, cpu, st, target, false);
>> +}
>> +
>> +static inline void cpuhp_invoke_callback_range_nofail(bool bringup,
>> +						      unsigned int cpu,
>> +						      struct cpuhp_cpu_state *st,
>> +						      enum cpuhp_state target)
>> +{
>> +	__cpuhp_invoke_callback_range(bringup, cpu, st, target, true);
>>  }
>>  
>>  static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
>> @@ -999,7 +1029,6 @@ static int take_cpu_down(void *_param)
>>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
>>  	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
>>  	int err, cpu = smp_processor_id();
>> -	int ret;
>>  
>>  	/* Ensure this CPU doesn't handle any more interrupts. */
>>  	err = __cpu_disable();
>> @@ -1012,13 +1041,11 @@ static int take_cpu_down(void *_param)
>>  	 */
>>  	WARN_ON(st->state != (CPUHP_TEARDOWN_CPU - 1));
>>  
>> -	/* Invoke the former CPU_DYING callbacks */
>> -	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
>> -
>>  	/*
>> +	 * Invoke the former CPU_DYING callbacks
>>  	 * DYING must not fail!
>>  	 */
>> -	WARN_ON_ONCE(ret);
>> +	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
>>  
>>  	/* Give up timekeeping duties */
>>  	tick_handover_do_timer();
>> @@ -1296,16 +1323,14 @@ void notify_cpu_starting(unsigned int cpu)
>>  {
>>  	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>  	enum cpuhp_state target = min((int)st->target, CPUHP_AP_ONLINE);
>> -	int ret;
>>  
>>  	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
>>  	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
>> -	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
>>  
>>  	/*
>>  	 * STARTING must not fail!
>>  	 */
>> -	WARN_ON_ONCE(ret);
>> +	cpuhp_invoke_callback_range_nofail(true, cpu, st, target);
>>  }
>>  
>>  /*
