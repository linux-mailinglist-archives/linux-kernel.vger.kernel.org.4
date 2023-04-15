Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC86E2F26
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 07:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDOFUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 01:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDOFUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 01:20:11 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C085593
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 22:20:09 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id hg12so5995230pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 22:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681536009; x=1684128009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zruA2qAmGh4CM+gfc55bRvR0bjxsCVmvjsUPo7Fqk2o=;
        b=GxEhZo7zYKJXXcZdTHoMubmf2eMAe2CnjcSceDY6BYGebKRzb/5S3Pls7OTccjKF6W
         ewqfikVZ0HarBg+ny09K97lCMLd+lbCZw5HHNBtBeNDycD8Su/pXqfD2SNT9SxWhwqF3
         mbYRxHC8oQjR3R/ZYpfq9N1UFgIhDQzi35ffsxD6/tWyTbLos9mF3BjS3X2VdVFq2V5K
         /zd+TUxRjNVO1K1nWiPVon/Uj1vWUK6vSbT2UFd9PPojpB2J+cjKzTAQWLIugbE7CE/y
         vZETTPQ1BND6RJpQ1lGFybbuwfNNCKDRkj6duGwNSD0ZUlqykUo8R5YCNwsf8S4vWqP0
         fQ7A==
X-Gm-Message-State: AAQBX9fim+YnRHU+rrmio3UYLzMHak6PYm33UZypK93f6Tzbz4KwjOOO
        UIj6Gb8ZEomCgbNOJJB22HM=
X-Google-Smtp-Source: AKy350bFs3SM/8SAi6IgHGRaH1LrbDqrokI9AwBu8QHlXMdCoBaWwmuvkYIOqFX6nvP4STELaB1yyg==
X-Received: by 2002:a17:902:ebc5:b0:1a6:8405:f709 with SMTP id p5-20020a170902ebc500b001a68405f709mr5399474plg.20.1681536008814;
        Fri, 14 Apr 2023 22:20:08 -0700 (PDT)
Received: from snowbird ([2600:6c4e:237f:f314::916])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090ae50800b0024752ff8061sm660740pjy.12.2023.04.14.22.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 22:20:08 -0700 (PDT)
Date:   Fri, 14 Apr 2023 22:20:04 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Dave Chinner <dchinner@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ye Bin <yebin10@huawei.com>, linux-mm@kvack.org
Subject: Re: [patch 1/3] lib/percpu_counter: Fix CPU hotplug handling
Message-ID: <ZDo0BHfm+iEGQyEX@snowbird>
References: <20230414162755.281993820@linutronix.de>
 <20230414162841.166896739@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414162841.166896739@linutronix.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Apr 14, 2023 at 06:30:43PM +0200, Thomas Gleixner wrote:
> Commit 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race") tried to
> address a race condition between percpu_counter_sum() and a concurrent CPU
> hotplug operation.
> 
> The race window is between the point where an un-plugged CPU removed itself
> from the online_cpu_mask and the hotplug state callback which folds the per
> CPU counters of the now dead CPU into the global count.
> 
> percpu_counter_sum() used for_each_online_cpu() to accumulate the per CPU
> local counts, so during the race window it missed to account for the not
> yet folded back local count of the offlined CPU.
> 
> The attempt to address this used the admittedly undocumented and
> pointlessly public cpu_dying_mask by changing the loop iterator to take
> both the cpu_online_mask and the cpu_dying_mask into account.
> 
> That works to some extent, but it is incorrect.
> 
> The cpu_dying_mask bits are sticky even after cpu_up()/cpu_down()
> completes. That means that all offlined CPUs are always taken into
> account. In the case of disabling SMT at boottime or runtime this results
> in evaluating _all_ offlined SMT siblings counters forever.  Depending on
> system size, that's a massive amount of cache-lines to be touched forever.
> 
> It might be argued, that the cpu_dying_mask bit could be cleared when
> cpu_down() completes, but that's not possible under all circumstances.
> 
> Especially with partial hotplug the bit must be sticky in order to keep the
> initial user, i.e. the scheduler correct. Partial hotplug which allows
> explicit state transitions also can create a situation where the race
> window gets recreated:
> 
>        cpu_down(target = CPUHP_PERCPU_CNT_DEAD + 1)
> 
> brings a CPU down to one state before the per CPU counter folding
> callback. As this did not reach CPUHP_OFFLINE state the bit would stay set.
> Now the next partial operation:
> 
>        cpu_up(target = CPUHP_PERCPU_CNT_DEAD + 2)
> 
> has to clear the bit and the race window is open again.
> 
> There are two ways to solve this:
> 
>   1) Maintain a local CPU mask in the per CPU counter code which
>      gets the bit set when a CPU comes online and removed in the
>      the CPUHP_PERCPU_CNT_DEAD state after folding.
> 
>      This adds more code and complexity.
> 
>   2) Move the folding hotplug state into the DYING callback section, which
>      runs on the outgoing CPU immediatedly after it cleared its online bit.
> 
>      There is no concurrency vs. percpu_counter_sum() on another CPU
>      because all still online CPUs are waiting in stop_machine() for the
>      outgoing CPU to complete its shutdown. The raw spinlock held around
>      the CPU mask iteration prevents that an online CPU reaches the stop
>      machine thread while iterating, which implicitely prevents the
>      outgoing CPU from clearing its online bit.
> 
>      This is way simpler than #1 and makes the hotplug calls symmetric for
>      the price of a slightly longer wait time in stop_machine(), which is
>      not the end of the world as CPU un-plug is already slow. The overall
>      time for a cpu_down() operation stays exactly the same.
> 
> Implement #2 and plug the race completely.
> 
> percpu_counter_sum() is still inherently racy against a concurrent
> percpu_counter_add_batch() fastpath unless externally serialized.  That's
> completely independent of CPU hotplug though.
> 
> Fixes: 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Ye Bin <yebin10@huawei.com>
> Cc: linux-mm@kvack.org
> ---
>  include/linux/cpuhotplug.h |    2 -
>  lib/percpu_counter.c       |   57 +++++++++++++++++++--------------------------
>  2 files changed, 26 insertions(+), 33 deletions(-)
> 
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -91,7 +91,6 @@ enum cpuhp_state {
>  	CPUHP_PRINTK_DEAD,
>  	CPUHP_MM_MEMCQ_DEAD,
>  	CPUHP_XFS_DEAD,
> -	CPUHP_PERCPU_CNT_DEAD,
>  	CPUHP_RADIX_DEAD,
>  	CPUHP_PAGE_ALLOC,
>  	CPUHP_NET_DEV_DEAD,
> @@ -196,6 +195,7 @@ enum cpuhp_state {
>  	CPUHP_AP_SMPCFD_DYING,
>  	CPUHP_AP_X86_TBOOT_DYING,
>  	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
> +	CPUHP_AP_PERCPU_COUNTER_STARTING,
>  	CPUHP_AP_ONLINE,
>  	CPUHP_TEARDOWN_CPU,
>  
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -12,7 +12,7 @@
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  static LIST_HEAD(percpu_counters);
> -static DEFINE_SPINLOCK(percpu_counters_lock);
> +static DEFINE_RAW_SPINLOCK(percpu_counters_lock);
>  #endif
>  
>  #ifdef CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER
> @@ -126,13 +126,8 @@ EXPORT_SYMBOL(percpu_counter_sync);
>   * Add up all the per-cpu counts, return the result.  This is a more accurate
>   * but much slower version of percpu_counter_read_positive().
>   *
> - * We use the cpu mask of (cpu_online_mask | cpu_dying_mask) to capture sums
> - * from CPUs that are in the process of being taken offline. Dying cpus have
> - * been removed from the online mask, but may not have had the hotplug dead
> - * notifier called to fold the percpu count back into the global counter sum.
> - * By including dying CPUs in the iteration mask, we avoid this race condition
> - * so __percpu_counter_sum() just does the right thing when CPUs are being taken
> - * offline.
> + * Note: This function is inherently racy against the lockless fastpath of
> + * percpu_counter_add_batch() unless externaly serialized.
>   */
>  s64 __percpu_counter_sum(struct percpu_counter *fbc)
>  {
> @@ -142,10 +137,8 @@ s64 __percpu_counter_sum(struct percpu_c
>  
>  	raw_spin_lock_irqsave(&fbc->lock, flags);
>  	ret = fbc->count;
> -	for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask) {
> -		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
> -		ret += *pcount;
> -	}
> +	for_each_online_cpu(cpu)
> +		ret += *per_cpu_ptr(fbc->counters, cpu);
>  	raw_spin_unlock_irqrestore(&fbc->lock, flags);
>  	return ret;
>  }
> @@ -167,9 +160,9 @@ int __percpu_counter_init(struct percpu_
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  	INIT_LIST_HEAD(&fbc->list);
> -	spin_lock_irqsave(&percpu_counters_lock, flags);
> +	raw_spin_lock_irqsave(&percpu_counters_lock, flags);
>  	list_add(&fbc->list, &percpu_counters);
> -	spin_unlock_irqrestore(&percpu_counters_lock, flags);
> +	raw_spin_unlock_irqrestore(&percpu_counters_lock, flags);
>  #endif
>  	return 0;
>  }
> @@ -185,9 +178,9 @@ void percpu_counter_destroy(struct percp
>  	debug_percpu_counter_deactivate(fbc);
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -	spin_lock_irqsave(&percpu_counters_lock, flags);
> +	raw_spin_lock_irqsave(&percpu_counters_lock, flags);
>  	list_del(&fbc->list);
> -	spin_unlock_irqrestore(&percpu_counters_lock, flags);
> +	raw_spin_unlock_irqrestore(&percpu_counters_lock, flags);
>  #endif
>  	free_percpu(fbc->counters);
>  	fbc->counters = NULL;
> @@ -197,22 +190,29 @@ EXPORT_SYMBOL(percpu_counter_destroy);
>  int percpu_counter_batch __read_mostly = 32;
>  EXPORT_SYMBOL(percpu_counter_batch);
>  
> -static int compute_batch_value(unsigned int cpu)
> +static void compute_batch_value(int offs)
>  {
> -	int nr = num_online_cpus();
> +	int nr = num_online_cpus() + offs;
> +
> +	percpu_counter_batch = max(32, nr * 2);
> +}
>  
> -	percpu_counter_batch = max(32, nr*2);
> +static int percpu_counter_cpu_starting(unsigned int cpu)
> +{
> +	/* If invoked during hotplug @cpu is not yet marked online. */
> +	compute_batch_value(cpu_online(cpu) ? 0 : 1);
>  	return 0;
>  }
>  
> -static int percpu_counter_cpu_dead(unsigned int cpu)
> +static int percpu_counter_cpu_dying(unsigned int cpu)
>  {
>  #ifdef CONFIG_HOTPLUG_CPU
>  	struct percpu_counter *fbc;
> +	unsigned long flags;
>  
> -	compute_batch_value(cpu);
> +	compute_batch_value(0);
>  
> -	spin_lock_irq(&percpu_counters_lock);
> +	raw_spin_lock_irqsave(&percpu_counters_lock, flags);
>  	list_for_each_entry(fbc, &percpu_counters, list) {
>  		s32 *pcount;
>  
> @@ -222,7 +222,7 @@ static int percpu_counter_cpu_dead(unsig
>  		*pcount = 0;
>  		raw_spin_unlock(&fbc->lock);
>  	}
> -	spin_unlock_irq(&percpu_counters_lock);
> +	raw_spin_unlock_irqrestore(&percpu_counters_lock, flags);
>  #endif
>  	return 0;
>  }
> @@ -256,15 +256,8 @@ EXPORT_SYMBOL(__percpu_counter_compare);
>  
>  static int __init percpu_counter_startup(void)
>  {
> -	int ret;
> -
> -	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "lib/percpu_cnt:online",
> -				compute_batch_value, NULL);
> -	WARN_ON(ret < 0);
> -	ret = cpuhp_setup_state_nocalls(CPUHP_PERCPU_CNT_DEAD,
> -					"lib/percpu_cnt:dead", NULL,
> -					percpu_counter_cpu_dead);
> -	WARN_ON(ret < 0);
> +	WARN_ON(cpuhp_setup_state(CPUHP_AP_PERCPU_COUNTER_STARTING, "lib/percpu_counter:starting",
> +				  percpu_counter_cpu_starting, percpu_counter_cpu_dying));
>  	return 0;
>  }
>  module_init(percpu_counter_startup);
> 

Thanks for this work. This is a much more complete solution.

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
