Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7809266DC34
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbjAQLVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbjAQLUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:20:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1960822DF1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FA31B81339
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BF6C433D2;
        Tue, 17 Jan 2023 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673954440;
        bh=4DCV6WZYesAEkNeZ/teJctemuihbCRpmJREz+EC478o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Tvo/DrN7J3HTzL0oIDOcCDi3n6XLfptLZcKsoF6fgeyRLgSuIjhui8Nbsbngj/0Ng
         CbqBqWb+vOe64iAYLOsNkdQwkka3NwZx9e18LjsiheneJ0ZBwrcR5XmQSJMgHs+klh
         XmfXX+mtz8lBKJSz16PYycKe/hDI2w+qx2fq6KcsjKoSmgjITY3XAIMQ2rW7oJIlO1
         cMHjHzZLtt+RRweMnzQROjlwmRtbFQH4jeSm8Y7BSRp8vafs8xpjDLJ5DhoNqkTLXH
         9wLBEC/VirKrop9L6LWVXXDhxhzRHmsvtxMVe6USePUG887mJBchxw8lqWNHjGw7WJ
         lAzXMqAG245TQ==
Message-ID: <d2e94ca1-5807-5a21-b8ed-743f5fb042c4@kernel.org>
Date:   Tue, 17 Jan 2023 12:20:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] sched/idle: Make idle poll dynamic per-cpu
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20230112162426.217522-1-bristot@kernel.org>
 <Y8PEM9TK4vTPWuxH@gmail.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <Y8PEM9TK4vTPWuxH@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/23 10:15, Ingo Molnar wrote:
> 
> * Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> idle=poll is frequently used on ultra-low-latency systems. Examples of
>> such systems are high-performance trading and 5G NVRAM. The performance
>> gain is given by avoiding the idle driver machinery and by keeping the
>> CPU is always in an active state - avoiding (odd) hardware heuristics that
>> are out of the control of the OS.
>>
>> Currently, idle=poll is an all-or-nothing static option defined at
>> boot time. The motivation for creating this option dynamic and per-cpu
>> are two:
>>
>>   1) Reduce the power usage/heat by allowing only selected CPUs to
>>      do idle polling;
>>   2) Allow multi-tenant systems (e.g., Kubernetes) to enable idle
>>      polling only when ultra-low-latency applications are present
>>      on specific CPUs.
>>
>> Joe Mario did some experiments with this option enabled, and the results
>> were significant. For example, by using dynamic idle polling on
>> selected CPUs, cyclictest performance is optimal (like when using
>> idle=poll), but cpu power consumption drops from 381 to 233 watts.
>>
>> Also, limiting idle=poll to the set of CPUs that benefits from
>> it allows other CPUs to benefit from frequency boosts. Joe also
>> shows that the results can be in the order of 80nsec round trip
>> improvement when system-wide idle=poll was not used.
>>
>> The user can enable idle polling with this command:
>>   # echo 1 > /sys/devices/system/cpu/cpu{CPU_ID}/idle_poll
>>
>> And disable it via:
>>   # echo 0 > /sys/devices/system/cpu/cpu{CPU_ID}/idle_poll
>>
>> By default, all CPUs have idle polling disabled (the current behavior).
>> A static key avoids the CPU mask check overhead when no idle polling
>> is enabled.
> 
> Sounds useful in general.
> 
> A couple of observations:
> 
> ABI: how about putting the new file into the existing 
> /sys/devices/system/cpu/cpuidle/ directory - the sysfs space of cpuidle? 
> Arguably this flag is an extension of it.
> 

I tried that, but then this option will depend on CONFIG_CPU_IDLE, which... is not
away set, and idle_poll does not depend on now... so I am not sure if it is
the best option... or am I missing something? suggestions?

>>  extern char __cpuidle_text_start[], __cpuidle_text_end[];
>>  
>> +/*
>> + * per-cpu idle polling selector.
>> + */
>> +static struct cpumask cpu_poll_mask;
>> +DEFINE_STATIC_KEY_FALSE(cpu_poll_enabled);
>> +
>> +/*
>> + * Protects the mask/static key relation.
>> + */
>> +DEFINE_MUTEX(cpu_poll_mutex);
>> +
>> +static ssize_t idle_poll_store(struct device *dev, struct device_attribute *attr,
>> +			       const char *buf, size_t count)
>> +{
>> +	int cpu = dev->id;
>> +	int retval, set;
>> +	bool val;
>> +
>> +	retval = kstrtobool(buf, &val);
>> +	if (retval)
>> +		return retval;
>> +
>> +	mutex_lock(&cpu_poll_mutex);
>> +
>> +	if (val) {
>> +		set = cpumask_test_and_set_cpu(cpu, &cpu_poll_mask);
>> +
>> +		/*
>> +		 * If the CPU was already on, do not increase the static key usage.
>> +		 */
>> +		if (!set)
>> +			static_branch_inc(&cpu_poll_enabled);
>> +	} else {
>> +		set = cpumask_test_and_clear_cpu(cpu, &cpu_poll_mask);
>> +
>> +		/*
>> +		 * If the CPU was already off, do not decrease the static key usage.
>> +		 */
>> +		if (set)
>> +			static_branch_dec(&cpu_poll_enabled);
>> +	}
> 
> Nit: I think 'old_bit' or so is easier to read than a generic 'set'?

ack

> 
>> +
>> +	mutex_unlock(&cpu_poll_mutex);
> 
> Also, is cpu_poll_mutex locking really necessary, given that these bitops 
> methods are atomic, and CPUs observe cpu_poll_enabled without taking any 
> locks?

you are right, it is not needed. I will remove it.

>> +static int is_cpu_idle_poll(int cpu)
>> +{
>> +	if (static_branch_unlikely(&cpu_poll_enabled))
>> +		return cpumask_test_cpu(cpu, &cpu_poll_mask);
>> +
>> +	return 0;
>> +}
> 
> static inline might be justified in this case I guess.

ack

>> @@ -51,18 +136,21 @@ __setup("hlt", cpu_idle_nopoll_setup);
>>  
>>  static noinline int __cpuidle cpu_idle_poll(void)
>>  {
>> -	trace_cpu_idle(0, smp_processor_id());
>> +	int cpu = smp_processor_id();
>> +
>> +	trace_cpu_idle(0, cpu);
>>  	stop_critical_timings();
>>  	ct_idle_enter();
>>  	local_irq_enable();
>>  
>>  	while (!tif_need_resched() &&
>> -	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
>> +	       (cpu_idle_force_poll || tick_check_broadcast_expired()
>> +		|| is_cpu_idle_poll(cpu)))
>>  		cpu_relax();
>>  
>>  	ct_idle_exit();
>>  	start_critical_timings();
>> -	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>> +	trace_cpu_idle(PWR_EVENT_EXIT, cpu);
>>  
>>  	return 1;
> 
> So I think the introduction of the 'cpu' local variable to clean up the 
> flow of cpu_idle_poll() should be a separate preparatory patch, which will 
> make the addition of the is_cpu_idle_poll() call a bit easier to read in 
> the second patch.

Makes sense.

>>  }
>> @@ -296,7 +384,8 @@ static void do_idle(void)
>>  		 * broadcast device expired for us, we don't want to go deep
>>  		 * idle as we know that the IPI is going to arrive right away.
>>  		 */
>> -		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
>> +		if (cpu_idle_force_poll || tick_check_broadcast_expired()
>> +		    || is_cpu_idle_poll(cpu)) {
>>  			tick_nohz_idle_restart_tick();
>>  			cpu_idle_poll();
> 
> Shouldn't we check is_cpu_idle_poll() right after the cpu_idle_force_poll 
> check, and before the tick_check_broadcast_expired() check?

Right.

> Shouldn't matter to the outcome, but for consistency's sake.

Maybe, we can move the cpu_idle_force_poll check inside cpu_idle_force_poll()?

because...

> Plus, if we are doing this anyway, maybe cpu_idle_force_poll could now be 
> implemented as 0/all setting of cpu_poll_mask, eliminating the 
> cpu_idle_force_poll flag? As a third patch on top.

I started doing it, but then I noticed some points:

- the cpu_idle_force_poll can stack, as platforms can call cpu_idle_poll_ctrl(true)
on top of idle=poll. So we would still need an integer to count how many times the
cpu_idle_force_poll was called.

- call to cpu_idle_poll_ctrl(false) when cpu_idle_force_poll reaches 0 cannot
unset all bits from the cpu_poll_mask because the user setup would be lost.

So I think that cpu_idle_force_poll is being used for two purposes: 1) user setting
via idle=poll, and 2) as a kernel facility via cpu_idle_poll_ctrl(true/false) other
than idle=poll.

So, maybe we can make idle=poll to change the initial value of the bitmask to
all 1 (with the addition that the user can now undo it), and keep cpu_idle_force_poll
for internal use?

Thanks!
-- Daniel
> 
> Thanks,
> 
> 	Ingo

