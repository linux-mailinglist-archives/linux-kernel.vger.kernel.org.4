Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D7F716E60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjE3UKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjE3UJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:09:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965369D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 13:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30E2C62EFF
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCA8C433EF;
        Tue, 30 May 2023 20:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685477388;
        bh=EqzuJeBD8W0a4J7cFQ8JgaCPj41wztauFHAzGU/TFJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YthwCQBjp/rV4SJKc7dML2Um491iha4xNQT6UYafxLvOm+RrmymkwrFWJEa+B50Vs
         rUZ9fGv9W1yznyK08EWeEeJoc7o0CcuT7C175z0QD1oRnaNYL19RX5lMD8yPOkBNZi
         4nUY80Bl9bTrvTwbLIom3Piidx4BN5JRVLiYhBKo=
Date:   Tue, 30 May 2023 13:09:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 3/4] workqueue: add schedule_on_each_cpumask helper
Message-Id: <20230530130947.37edbab6b672bfce6f481295@linux-foundation.org>
In-Reply-To: <20230530145335.930262644@redhat.com>
References: <20230530145234.968927611@redhat.com>
        <20230530145335.930262644@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 11:52:37 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:

> Add a schedule_on_each_cpumask function, equivalent to
> schedule_on_each_cpu but accepting a cpumask to operate.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> 
> Index: linux-vmstat-remote/kernel/workqueue.c
> ===================================================================
> --- linux-vmstat-remote.orig/kernel/workqueue.c
> +++ linux-vmstat-remote/kernel/workqueue.c
> @@ -3455,6 +3455,56 @@ int schedule_on_each_cpu(work_func_t fun
>  	return 0;
>  }
>  
> +
> +/**
> + * schedule_on_each_cpumask - execute a function synchronously on each
> + * CPU in "cpumask", for those which are online.
> + *
> + * @func: the function to call
> + * @mask: the CPUs which to call function on
> + *
> + * schedule_on_each_cpu() executes @func on each specified CPU that is online,
> + * using the system workqueue and blocks until all such CPUs have completed.
> + * schedule_on_each_cpu() is very slow.
> + *
> + * Return:
> + * 0 on success, -errno on failure.
> + */
> +int schedule_on_each_cpumask(work_func_t func, cpumask_t *cpumask)
> +{
> +	int cpu;
> +	struct work_struct __percpu *works;
> +	cpumask_var_t effmask;
> +
> +	works = alloc_percpu(struct work_struct);
> +	if (!works)
> +		return -ENOMEM;
> +
> +	if (!alloc_cpumask_var(&effmask, GFP_KERNEL)) {
> +		free_percpu(works);
> +		return -ENOMEM;
> +	}
> +
> +	cpumask_and(effmask, cpumask, cpu_online_mask);
> +
> +	cpus_read_lock();
> +
> +	for_each_cpu(cpu, effmask) {

Should we check here that the cpu is still online?

> +		struct work_struct *work = per_cpu_ptr(works, cpu);
> +
> +		INIT_WORK(work, func);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_cpu(cpu, effmask)
> +		flush_work(per_cpu_ptr(works, cpu));
> +
> +	cpus_read_unlock();
> +	free_percpu(works);
> +	free_cpumask_var(effmask);
> +	return 0;
> +}
> +
>  /**
>   * execute_in_process_context - reliably execute the routine with user context
>   * @fn:		the function to execute
> --- linux-vmstat-remote.orig/include/linux/workqueue.h
> +++ linux-vmstat-remote/include/linux/workqueue.h
> @@ -450,6 +450,7 @@ extern void __flush_workqueue(struct wor
>  extern void drain_workqueue(struct workqueue_struct *wq);
>  
>  extern int schedule_on_each_cpu(work_func_t func);
> +extern int schedule_on_each_cpumask(work_func_t func, cpumask_t *cpumask);

May as well make schedule_on_each_cpu() call
schedule_on_each_cpumask()?  Save a bit of text, and they're hardly
performance-critical to that extent.
