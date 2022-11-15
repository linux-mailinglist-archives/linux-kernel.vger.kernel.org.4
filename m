Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF09E6296C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiKOLHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiKOLHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:07:04 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E251DA9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:07:01 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1outmN-0000iz-Gx; Tue, 15 Nov 2022 12:06:59 +0100
Message-ID: <83ae518c-be71-6e3f-c9f8-3ea6e4b05d87@leemhuis.info>
Date:   Tue, 15 Nov 2022 12:06:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
Content-Language: en-US, de-DE
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, vschneid@redhat.com,
        kernel-team@android.com, Derek Dolney <z23@posteo.net>,
        Vincent Donnefort <vdonnefort@google.com>
References: <20220927101259.1149636-1-vdonnefort@google.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220927101259.1149636-1-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668510421;47015ee5;
X-HE-SMSGID: 1outmN-0000iz-Gx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

Peter, Thomas, what's the holdup with this patch?

I'm asking because I have the linked issue on the list of tracked
regressions and there wasn't really any progress for weeks now afaics
(if I missed anything, please let me know). I'm getting quite close to
the point where my only remaining option is "get Linus to look into
this", but I'd like to avoid that.

Ciao, Thorsten

On 27.09.22 12:12, Vincent Donnefort wrote:
> The DYING/STARTING callbacks are not expected to fail. However, as reported
> by Derek, drivers such as tboot are still free to return errors within
> those sections, which halts the hot(un)plug and leaves the CPU in an
> unrecoverable state.
> 
> No rollback being possible there, let's only log the failures and proceed
> with the following steps. This restores the hotplug behaviour prior to
> commit 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215867
> Fixes: 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
> Reported-by: Derek Dolney <z23@posteo.net>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> Tested-by: Derek Dolney <z23@posteo.net>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> 
> ---
> 
> v5 -> v6:
>    - Collect Reviewed-by
> v4 -> v5:
>    - Remove WARN, only log broken states with pr_warn.
> v3 -> v4:
>    - Sorry ... wrong commit description style ...
> v2 -> v3:
>    - Tested-by tag.
>    - Refine commit description.
>    - Bugzilla link.
> v1 -> v2:
>    - Commit message rewording.
>    - More details in the warnings.
>    - Some variable renaming
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index bbad5e375d3b..621e5af42d57 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -663,21 +663,51 @@ static bool cpuhp_next_state(bool bringup,
>  	return true;
>  }
>  
> -static int cpuhp_invoke_callback_range(bool bringup,
> -				       unsigned int cpu,
> -				       struct cpuhp_cpu_state *st,
> -				       enum cpuhp_state target)
> +static int __cpuhp_invoke_callback_range(bool bringup,
> +					 unsigned int cpu,
> +					 struct cpuhp_cpu_state *st,
> +					 enum cpuhp_state target,
> +					 bool nofail)
>  {
>  	enum cpuhp_state state;
> -	int err = 0;
> +	int ret = 0;
>  
>  	while (cpuhp_next_state(bringup, &state, st, target)) {
> +		int err;
> +
>  		err = cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
> -		if (err)
> +		if (!err)
> +			continue;
> +
> +		if (nofail) {
> +			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
> +				cpu, bringup ? "UP" : "DOWN",
> +				cpuhp_get_step(st->state)->name,
> +				st->state, err);
> +			ret = -1;
> +		} else {
> +			ret = err;
>  			break;
> +		}
>  	}
>  
> -	return err;
> +	return ret;
> +}
> +
> +static inline int cpuhp_invoke_callback_range(bool bringup,
> +					      unsigned int cpu,
> +					      struct cpuhp_cpu_state *st,
> +					      enum cpuhp_state target)
> +{
> +	return __cpuhp_invoke_callback_range(bringup, cpu, st, target, false);
> +}
> +
> +static inline void cpuhp_invoke_callback_range_nofail(bool bringup,
> +						      unsigned int cpu,
> +						      struct cpuhp_cpu_state *st,
> +						      enum cpuhp_state target)
> +{
> +	__cpuhp_invoke_callback_range(bringup, cpu, st, target, true);
>  }
>  
>  static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
> @@ -999,7 +1029,6 @@ static int take_cpu_down(void *_param)
>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
>  	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
>  	int err, cpu = smp_processor_id();
> -	int ret;
>  
>  	/* Ensure this CPU doesn't handle any more interrupts. */
>  	err = __cpu_disable();
> @@ -1012,13 +1041,11 @@ static int take_cpu_down(void *_param)
>  	 */
>  	WARN_ON(st->state != (CPUHP_TEARDOWN_CPU - 1));
>  
> -	/* Invoke the former CPU_DYING callbacks */
> -	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
> -
>  	/*
> +	 * Invoke the former CPU_DYING callbacks
>  	 * DYING must not fail!
>  	 */
> -	WARN_ON_ONCE(ret);
> +	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
>  
>  	/* Give up timekeeping duties */
>  	tick_handover_do_timer();
> @@ -1296,16 +1323,14 @@ void notify_cpu_starting(unsigned int cpu)
>  {
>  	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>  	enum cpuhp_state target = min((int)st->target, CPUHP_AP_ONLINE);
> -	int ret;
>  
>  	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
>  	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
> -	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
>  
>  	/*
>  	 * STARTING must not fail!
>  	 */
> -	WARN_ON_ONCE(ret);
> +	cpuhp_invoke_callback_range_nofail(true, cpu, st, target);
>  }
>  
>  /*
