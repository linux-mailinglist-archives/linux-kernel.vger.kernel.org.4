Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1324465517C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbiLWOl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiLWOlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:41:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76DC26A82
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 06:41:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F654611DB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 14:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A76DC433D2;
        Fri, 23 Dec 2022 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671806513;
        bh=37BtRM3lBO+1nDbvr3DPq5coHa2cgacS+AVXyWnLNOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kox8nRoWLjje3Cjgbtjsl1MUkRM6pr89A0hlUvaZL1bXsWL6WvlOZT8S5LNQ437Ik
         9MGEtfPFcaJvdgRCrlFQ1nWuCz8f4iAB8NwrZe3hhfkHWq3yJ7N6Z72IF6otN52F+P
         QvaIQtXHPH5dWnGMu6tagb/hP9Lh+/8AzXx+a0gNepIwzX5CCRwejwtS4xlHRxGf2/
         UQWBAU0CaKLo3GT9R2CObcJeSb3TvX31aIAhX383GjJFp7KgXe/XeMKYrH+nGRKjWG
         ls9M/e9igPRFWQMahWwo7ivthVHTKTH/1JOstNMAxAKqpYpsBXRtl0YMaAHyaiQgIz
         FjSJasnbusqFw==
Date:   Fri, 23 Dec 2022 15:41:50 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     atomlin@atomlin.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v11 3/6] mm/vmstat: manage per-CPU stats from CPU context
 when NOHZ full
Message-ID: <20221223144150.GA79369@lothringen>
References: <20221221165801.362118576@redhat.com>
 <20221221170436.330627967@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221170436.330627967@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 01:58:04PM -0300, Marcelo Tosatti wrote:
> @@ -194,21 +195,50 @@ void fold_vm_numa_events(void)
>  #endif
>  
>  #ifdef CONFIG_SMP
> -static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +
> +struct vmstat_dirty {
> +	bool dirty;
> +	bool cpuhotplug;

May be call it "online" for clarity. Also should it depend on CONFIG_FLUSH_WORK_ON_RESUME_USER?

> +};
> +
> +static DEFINE_PER_CPU_ALIGNED(struct vmstat_dirty, vmstat_dirty_pcpu);
> +static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
> +int sysctl_stat_interval __read_mostly = HZ;
>  
>  static inline void vmstat_mark_dirty(void)
>  {
> -	this_cpu_write(vmstat_dirty, true);
> +	struct vmstat_dirty *vms = this_cpu_ptr(&vmstat_dirty_pcpu);
> +
> +#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER

Please avoid ifdeffery in the middle of a function when possible.
This block could be in a different function or use IS_ENABLED()
for example.

> +	int cpu = smp_processor_id();
> +
> +	if (tick_nohz_full_cpu(cpu) && !vms->dirty) {
> +		struct delayed_work *dw;
> +
> +		dw = this_cpu_ptr(&vmstat_work);
> +		if (!delayed_work_pending(dw) && !vms->cpuhotplug) {
> +			unsigned long delay;
> +
> +			delay = round_jiffies_relative(sysctl_stat_interval);
> +			queue_delayed_work_on(cpu, mm_percpu_wq, dw, delay);
> +		}
> +	}
> +#endif
> +	vms->dirty = true;
>  }
>  
>  static inline void vmstat_clear_dirty(void)
>  {
> -	this_cpu_write(vmstat_dirty, false);
> +	struct vmstat_dirty *vms = this_cpu_ptr(&vmstat_dirty_pcpu);
> +
> +	vms->dirty = false;

You could keep this_cpu_write(vmstat_dirty.dirty, false)

>  }
>  
>  static inline bool is_vmstat_dirty(void)
>  {
> -	return this_cpu_read(vmstat_dirty);
> +	struct vmstat_dirty *vms = this_cpu_ptr(&vmstat_dirty_pcpu);
> +
> +	return vms->dirty;

Ditto with this_cpu_read()?

>  }
>  
>  int calculate_pressure_threshold(struct zone *zone)
> @@ -1981,13 +2008,18 @@ void quiet_vmstat(void)
>  	if (!is_vmstat_dirty())
>  		return;
>  
> +	refresh_cpu_vm_stats(false);
> +
> +#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER

This can use IS_ENABLED()

> +	if (!user)
> +		return;
>  	/*
> -	 * Just refresh counters and do not care about the pending delayed
> -	 * vmstat_update. It doesn't fire that often to matter and canceling
> -	 * it would be too expensive from this path.
> -	 * vmstat_shepherd will take care about that for us.
> +	 * If the tick is stopped, cancel any delayed work to avoid
> +	 * interruptions to this CPU in the future.
>  	 */
> -	refresh_cpu_vm_stats(false);
> +	if (delayed_work_pending(this_cpu_ptr(&vmstat_work)))
> +		cancel_delayed_work(this_cpu_ptr(&vmstat_work));
> +#endif
>  }
>  
>  /*
> @@ -2008,8 +2040,15 @@ static void vmstat_shepherd(struct work_
>  	/* Check processors whose vmstat worker threads have been disabled */
>  	for_each_online_cpu(cpu) {
>  		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
> +		struct vmstat_dirty *vms = per_cpu_ptr(&vmstat_dirty_pcpu, cpu);
>  
> -		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
> +#ifdef CONFIG_FLUSH_WORK_ON_RESUME_USER

Same here.

> +		/* NOHZ full CPUs manage their own vmstat flushing */
> +		if (tick_nohz_full_cpu(cpu))
> +			continue;
> +#endif
> +
> +		if (!delayed_work_pending(dw) && vms->dirty)
>  			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
>  
>  		cond_resched();
> @@ -2053,8 +2111,15 @@ static int vmstat_cpu_online(unsigned in
>  	return 0;
>  }
>  
> +/*
> + * ONLINE: The callbacks are invoked on the hotplugged CPU from the per CPU
> + * hotplug thread with interrupts and preemption enabled.

This is OFFLINE and the reason behind that comment is confusing.

> + */
>  static int vmstat_cpu_down_prep(unsigned int cpu)
>  {
> +	struct vmstat_dirty *vms = per_cpu_ptr(&vmstat_dirty_pcpu, cpu);
> +
> +	vms->cpuhotplug = true;

this_cpu_write() ?

>  	cancel_delayed_work_sync(&per_cpu(vmstat_work, cpu));
>  	return 0;
>  }
> +config FLUSH_WORK_ON_RESUME_USER
> +	bool "Flush per-CPU vmstats on user return (for nohz full CPUs)"
> +	depends on NO_HZ_FULL
> +	default y
> +
> +	help
> +	  By default, nohz full CPUs flush per-CPU vm statistics on return
> +	  to userspace (to avoid additional interferences when executing
> +	  userspace code). This has a small but measurable impact on
> +	  system call performance. You can disable this to improve system call
> +	  performance, at the expense of potential interferences to userspace
> +	  execution.

Can you move that below config CPU_ISOLATION ?

Thanks!

> +
>  # multi-gen LRU {
>  config LRU_GEN
>  	bool "Multi-Gen LRU"
> 
> 
