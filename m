Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F16DDB07
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDKMjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDKMjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:39:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6F51FE4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B879960DDC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBF9C433D2;
        Tue, 11 Apr 2023 12:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681216710;
        bh=9p1kY1s+7Url6KLLgVchnGKkLKzSxT34GC4qnc9lzuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSDiAjGeOY0ohQTlG7VP5N/7tt+77Ml6R2XgmXiqWJLUNmV0IY+4EvG6DzC9DlWr+
         QLcxchBtjjgHZ7zOaIYUU51vra0Zth0TOtCYJAMJlaGc3LklC90n8+3jkUaFUTmj5n
         AH3g6f9yYjVjsZ/vUCERWH7YeO7/ozrfXyoDs3KykygHflzwSqJIIdYB/AWsRpTGHg
         T7sfZTdC6ROonzGiT9Gv4fBfmitVexzXLAW78jzvDaMGCe2sr2i6XEjkTOEmlafyxU
         bsxOkUKct5QYr+USrc0ex2KkkgAZ5Qwievck/dBYBmo6yxHVYkb8QWSPd98vB/LwQx
         YGUrJfg1do1rw==
Date:   Tue, 11 Apr 2023 13:38:25 +0100
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tuanphan@os.amperecomputing.com, robin.murphy@arm.com,
        suzuki.poulose@arm.com
Subject: Re: [PATCH] perf/arm-dmc620: Reverse locking order in
 dmc620_pmu_get_irq()
Message-ID: <20230411123823.GA22686@willie-the-truck>
References: <20230405172842.2663770-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405172842.2663770-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

[+Tuan Phan, Robin and Suzuki]

On Wed, Apr 05, 2023 at 01:28:42PM -0400, Waiman Long wrote:
> The following circular locking dependency was reported when running
> cpus online/offline test on an arm64 system.
> 
> [   84.195923] Chain exists of:
>                  dmc620_pmu_irqs_lock --> cpu_hotplug_lock --> cpuhp_state-down
> 
> [   84.207305]  Possible unsafe locking scenario:
> 
> [   84.213212]        CPU0                    CPU1
> [   84.217729]        ----                    ----
> [   84.222247]   lock(cpuhp_state-down);
> [   84.225899]                                lock(cpu_hotplug_lock);
> [   84.232068]                                lock(cpuhp_state-down);
> [   84.238237]   lock(dmc620_pmu_irqs_lock);
> [   84.242236]
>                 *** DEADLOCK ***
> 
> The problematic locking order seems to be
> 
> 	lock(dmc620_pmu_irqs_lock) --> lock(cpu_hotplug_lock)
> 
> This locking order happens when dmc620_pmu_get_irq() is called from
> dmc620_pmu_device_probe(). Fix this possible deadlock scenario by
> reversing the locking order.
> 
> Also export __cpuhp_state_add_instance_cpuslocked() so that it can be
> accessed by kernel modules.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  drivers/perf/arm_dmc620_pmu.c | 4 +++-
>  kernel/cpu.c                  | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> index 54aa4658fb36..78d3bfbe96a6 100644
> --- a/drivers/perf/arm_dmc620_pmu.c
> +++ b/drivers/perf/arm_dmc620_pmu.c
> @@ -425,7 +425,7 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
>  	if (ret)
>  		goto out_free_irq;
>  
> -	ret = cpuhp_state_add_instance_nocalls(cpuhp_state_num, &irq->node);
> +	ret = cpuhp_state_add_instance_nocalls_cpuslocked(cpuhp_state_num, &irq->node);
>  	if (ret)
>  		goto out_free_irq;
>  
> @@ -445,9 +445,11 @@ static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
>  {
>  	struct dmc620_pmu_irq *irq;
>  
> +	cpus_read_lock();
>  	mutex_lock(&dmc620_pmu_irqs_lock);
>  	irq = __dmc620_pmu_get_irq(irq_num);
>  	mutex_unlock(&dmc620_pmu_irqs_lock);
> +	cpus_read_unlock();
>  
>  	if (IS_ERR(irq))
>  		return PTR_ERR(irq);
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6c0a92ca6bb5..05daaef362e6 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2036,6 +2036,7 @@ int __cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
>  	mutex_unlock(&cpuhp_state_mutex);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance_cpuslocked);

Thanks for the fix, but I think it would be much cleaner if we could handle
this internally to the driver without having to export additional symbols
from the hotplug machinery.

Looking at the driver, it looks like it would make more sense to register
each PMU instance with the cpuhp state machine and avoid having to traverse
a mutable list, rather than add irq instances.

That said, I really don't grok this comment:

	/* We're only reading, but this isn't the place to be involving RCU */

Given that perf_pmu_migrate_context() calls synchronize_rcu()...

So perhaps we could just walk the list using RCU as the easiest fix?

Will
