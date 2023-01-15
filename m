Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1408E66B019
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjAOJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAOJPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:15:38 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0BF86B0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:15:36 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id u9so61688458ejo.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QX7PK/GQnL52HAMed7VXtoYgs2n35QC9h6+hKnx771M=;
        b=QjpJsxqFjS1eru/JhYrv5MEEsEj+dAanYXU0hzzXXkMfsk+8+eiu/UvNfbIEgOo3v5
         ewrAKubVgSc+lWz1PpVUHkKOQ6a34J9UBH0KBeNaBdWWNm8SZvq1S0MJC2pZa3LWp2fy
         NlnDwsDi+DmjAJArq3qHfefjcf4b4f0l+fEYU/teifrfBmL31FRQ8jSBWKb4zwSFHMO5
         9ptlK4i8Iq56zokVwuIfEhx4A9d+yhOZXEG4OV1muncHDwQF+z/Qw4+jMEKRJCAV2S5Z
         UZvmP8/Ap0oVcJ+f39Dw04DOp3+sJzvVCcfZGjbKFAqN96OdQdmwg5hXe3TfRFw4NPUF
         4shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX7PK/GQnL52HAMed7VXtoYgs2n35QC9h6+hKnx771M=;
        b=k+MrMVbSXF4MlunqEU/u5a0MBBO5dihhNJwR0MSj8pqcRukUcqwL1i9jTGXspAyOz/
         euXVKMRgX4fNA0JmEosgMOEbDW0MsrNDL3GhUfUsXaGfWjBjLFzPNy8F1v7Xi6JznGz0
         qkhds/zEOVD5imUOwv7jVgTI+yfQx803qVB2t/JLBzkIyAHg6sjrgBABB+uoMIUWpnpI
         k9la9uDrHXWc5vz3wAUGpow6MKZIuOKFI4IXiPo/I8mvjnQYv0Ctg/zCSvdZNucYnqeI
         hitdhyko5mCGXM9W3G3FjEjyMS6s//eA3/u5/VdxwZPSSFhKZnQmN0ksR44na7waPOlF
         q3QQ==
X-Gm-Message-State: AFqh2kqX/+UjLVg0dNsvY/YwsoGvU6JcNOYRzAhYCMWwOhao+yV9R9TM
        SxnNcDm1Dbq9u2Ffv74K1uw=
X-Google-Smtp-Source: AMrXdXtOPDxxZTaPLFOFsyGoL1Ckz8ObKK8IPyktKxmYTSCjvnU7OOW3HrybNYyLl6ADIb6fSyM8uA==
X-Received: by 2002:a17:906:1b4a:b0:84d:4e4e:2c7b with SMTP id p10-20020a1709061b4a00b0084d4e4e2c7bmr8885747ejg.30.1673774135302;
        Sun, 15 Jan 2023 01:15:35 -0800 (PST)
Received: from gmail.com (1F2EF7EB.nat.pool.telekom.hu. [31.46.247.235])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906311200b0084b89c66eb5sm10462888ejx.4.2023.01.15.01.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 01:15:33 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 15 Jan 2023 10:15:31 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] sched/idle: Make idle poll dynamic per-cpu
Message-ID: <Y8PEM9TK4vTPWuxH@gmail.com>
References: <20230112162426.217522-1-bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112162426.217522-1-bristot@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> idle=poll is frequently used on ultra-low-latency systems. Examples of
> such systems are high-performance trading and 5G NVRAM. The performance
> gain is given by avoiding the idle driver machinery and by keeping the
> CPU is always in an active state - avoiding (odd) hardware heuristics that
> are out of the control of the OS.
> 
> Currently, idle=poll is an all-or-nothing static option defined at
> boot time. The motivation for creating this option dynamic and per-cpu
> are two:
> 
>   1) Reduce the power usage/heat by allowing only selected CPUs to
>      do idle polling;
>   2) Allow multi-tenant systems (e.g., Kubernetes) to enable idle
>      polling only when ultra-low-latency applications are present
>      on specific CPUs.
> 
> Joe Mario did some experiments with this option enabled, and the results
> were significant. For example, by using dynamic idle polling on
> selected CPUs, cyclictest performance is optimal (like when using
> idle=poll), but cpu power consumption drops from 381 to 233 watts.
> 
> Also, limiting idle=poll to the set of CPUs that benefits from
> it allows other CPUs to benefit from frequency boosts. Joe also
> shows that the results can be in the order of 80nsec round trip
> improvement when system-wide idle=poll was not used.
> 
> The user can enable idle polling with this command:
>   # echo 1 > /sys/devices/system/cpu/cpu{CPU_ID}/idle_poll
> 
> And disable it via:
>   # echo 0 > /sys/devices/system/cpu/cpu{CPU_ID}/idle_poll
> 
> By default, all CPUs have idle polling disabled (the current behavior).
> A static key avoids the CPU mask check overhead when no idle polling
> is enabled.

Sounds useful in general.

A couple of observations:

ABI: how about putting the new file into the existing 
/sys/devices/system/cpu/cpuidle/ directory - the sysfs space of cpuidle? 
Arguably this flag is an extension of it.


>  extern char __cpuidle_text_start[], __cpuidle_text_end[];
>  
> +/*
> + * per-cpu idle polling selector.
> + */
> +static struct cpumask cpu_poll_mask;
> +DEFINE_STATIC_KEY_FALSE(cpu_poll_enabled);
> +
> +/*
> + * Protects the mask/static key relation.
> + */
> +DEFINE_MUTEX(cpu_poll_mutex);
> +
> +static ssize_t idle_poll_store(struct device *dev, struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	int cpu = dev->id;
> +	int retval, set;
> +	bool val;
> +
> +	retval = kstrtobool(buf, &val);
> +	if (retval)
> +		return retval;
> +
> +	mutex_lock(&cpu_poll_mutex);
> +
> +	if (val) {
> +		set = cpumask_test_and_set_cpu(cpu, &cpu_poll_mask);
> +
> +		/*
> +		 * If the CPU was already on, do not increase the static key usage.
> +		 */
> +		if (!set)
> +			static_branch_inc(&cpu_poll_enabled);
> +	} else {
> +		set = cpumask_test_and_clear_cpu(cpu, &cpu_poll_mask);
> +
> +		/*
> +		 * If the CPU was already off, do not decrease the static key usage.
> +		 */
> +		if (set)
> +			static_branch_dec(&cpu_poll_enabled);
> +	}

Nit: I think 'old_bit' or so is easier to read than a generic 'set'?


> +
> +	mutex_unlock(&cpu_poll_mutex);

Also, is cpu_poll_mutex locking really necessary, given that these bitops 
methods are atomic, and CPUs observe cpu_poll_enabled without taking any 
locks?

> +static int is_cpu_idle_poll(int cpu)
> +{
> +	if (static_branch_unlikely(&cpu_poll_enabled))
> +		return cpumask_test_cpu(cpu, &cpu_poll_mask);
> +
> +	return 0;
> +}

static inline might be justified in this case I guess.

> @@ -51,18 +136,21 @@ __setup("hlt", cpu_idle_nopoll_setup);
>  
>  static noinline int __cpuidle cpu_idle_poll(void)
>  {
> -	trace_cpu_idle(0, smp_processor_id());
> +	int cpu = smp_processor_id();
> +
> +	trace_cpu_idle(0, cpu);
>  	stop_critical_timings();
>  	ct_idle_enter();
>  	local_irq_enable();
>  
>  	while (!tif_need_resched() &&
> -	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
> +	       (cpu_idle_force_poll || tick_check_broadcast_expired()
> +		|| is_cpu_idle_poll(cpu)))
>  		cpu_relax();
>  
>  	ct_idle_exit();
>  	start_critical_timings();
> -	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> +	trace_cpu_idle(PWR_EVENT_EXIT, cpu);
>  
>  	return 1;

So I think the introduction of the 'cpu' local variable to clean up the 
flow of cpu_idle_poll() should be a separate preparatory patch, which will 
make the addition of the is_cpu_idle_poll() call a bit easier to read in 
the second patch.

>  }
> @@ -296,7 +384,8 @@ static void do_idle(void)
>  		 * broadcast device expired for us, we don't want to go deep
>  		 * idle as we know that the IPI is going to arrive right away.
>  		 */
> -		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
> +		if (cpu_idle_force_poll || tick_check_broadcast_expired()
> +		    || is_cpu_idle_poll(cpu)) {
>  			tick_nohz_idle_restart_tick();
>  			cpu_idle_poll();

Shouldn't we check is_cpu_idle_poll() right after the cpu_idle_force_poll 
check, and before the tick_check_broadcast_expired() check?

Shouldn't matter to the outcome, but for consistency's sake.

Plus, if we are doing this anyway, maybe cpu_idle_force_poll could now be 
implemented as 0/all setting of cpu_poll_mask, eliminating the 
cpu_idle_force_poll flag? As a third patch on top.

Thanks,

	Ingo
