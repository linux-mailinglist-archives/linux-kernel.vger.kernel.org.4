Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2F64CAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbiLNNSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbiLNNSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:18:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686CF1B1F0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0409F619B2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69D5C433EF;
        Wed, 14 Dec 2022 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671023922;
        bh=vUEUw7umkHcdN8/poSpqNEUmzIsAMybBL8IL/dAeuUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVXi2uB7BtOjWKiCScn5bL9wd1ewcVR4gJUZN10rI/+X+ZA01cOJIbqR6STKAvEKz
         iHEx+hSxSwpam3bUActYuIbvmF/3ejyT+QjK6j4nzbUCkt9vrUzn5dHHxvSSjwBdCa
         1wZ4+QXEoW7AddsbPvZft77G/y4jMFapXIAC+n06Yj/fUfkBXIjNC52Pqx9c2Lh/WN
         ZIXeeVnplrYXgBItr+zqv5B31FPHHludoL9GiPDmu2Wh+RIrtsJ8FnfnzDORMHGrun
         x8nU5igAlnMZXJvaItaPy9oXl77tlB3iWbj5FTeUtM39p65qyOZRQoBg23ZUhf4wEC
         l9GGMhajS+vMw==
Date:   Wed, 14 Dec 2022 14:18:39 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     atomlin@redhat.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 3/5] mm/vmstat: manage per-CPU stats from CPU context
 when NOHZ full
Message-ID: <20221214131839.GE1930067@lothringen>
References: <20221206161826.698593151@redhat.com>
 <20221206162416.474800121@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206162416.474800121@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 01:18:29PM -0300, Marcelo Tosatti wrote:
> For nohz full CPUs, manage per-CPU stat syncing from CPU context:
> start delayed work when marking per-CPU vmstat dirty.
> 
> When returning to userspace, fold the stats and cancel the delayed work.
> 
> When entering idle, only fold the stats.

The changelog still misses the reason behind the changes.

> @@ -195,9 +196,24 @@ void fold_vm_numa_events(void)
>  
>  #ifdef CONFIG_SMP
>  static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
> +int sysctl_stat_interval __read_mostly = HZ;
>  
>  static inline void vmstat_mark_dirty(void)
>  {
> +	int cpu = smp_processor_id();
> +
> +	if (tick_nohz_full_cpu(cpu) && !this_cpu_read(vmstat_dirty)) {
> +		struct delayed_work *dw;
> +
> +		dw = &per_cpu(vmstat_work, cpu);

this_cpu_ptr()

> +		if (!delayed_work_pending(dw)) {
> +			unsigned long delay;
> +
> +			delay = round_jiffies_relative(sysctl_stat_interval);
> +			queue_delayed_work_on(cpu, mm_percpu_wq, dw, delay);
> +		}
> +	}
>  	this_cpu_write(vmstat_dirty, true);
>  }
>  
> @@ -1973,21 +1986,27 @@ static void vmstat_update(struct work_st
>   * until the diffs stay at zero. The function is used by NOHZ and can only be
>   * invoked when tick processing is not active.
>   */
> -void quiet_vmstat(void)
> +void quiet_vmstat(bool user)
>  {
> +	struct delayed_work *dw;
> +
>  	if (system_state != SYSTEM_RUNNING)
>  		return;
>  
>  	if (!is_vmstat_dirty())
>  		return;
>  
> +	refresh_cpu_vm_stats(false);
> +
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
> +	dw = &per_cpu(vmstat_work, smp_processor_id());

this_cpu_ptr()

Thanks.

> +	if (delayed_work_pending(dw))
> +		cancel_delayed_work(dw);
>  }
>  
>  /*
