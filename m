Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7260A622885
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiKIKdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKIKdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:33:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D8B6263F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:33:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1B231FB;
        Wed,  9 Nov 2022 02:33:24 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FB4C3F534;
        Wed,  9 Nov 2022 02:33:17 -0800 (PST)
Message-ID: <33fcfe74-f6c7-f85c-5a8d-51efdecfa0ab@arm.com>
Date:   Wed, 9 Nov 2022 11:33:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/9] sched/uclamp: Fix relationship between uclamp and
 migration margin
Content-Language: en-US
To:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-2-qais.yousef@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220804143609.515789-2-qais.yousef@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2022 16:36, Qais Yousef wrote:

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 52dc9d6f811e..00c2de800685 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4254,6 +4254,129 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>  	trace_sched_util_est_se_tp(&p->se);
>  }
>  
> +static inline int util_fits_cpu(unsigned long util,
> +				unsigned long uclamp_min,
> +				unsigned long uclamp_max,
> +				int cpu)
> +{
> +	unsigned long capacity_orig, capacity_orig_thermal;
> +	unsigned long capacity = capacity_of(cpu);
> +	bool fits, uclamp_max_fits;
> +
> +	/*
> +	 * Check if the real util fits without any uclamp boost/cap applied.
> +	 */
> +	fits = fits_capacity(util, capacity);
> +
> +	if (!uclamp_is_used())
> +		return fits;
> +
> +	/*
> +	 * We must use capacity_orig_of() for comparing against uclamp_min and
> +	 * uclamp_max. We only care about capacity pressure (by using
> +	 * capacity_of()) for comparing against the real util.
> +	 *
> +	 * If a task is boosted to 1024 for example, we don't want a tiny
> +	 * pressure to skew the check whether it fits a CPU or not.
> +	 *
> +	 * Similarly if a task is capped to capacity_orig_of(little_cpu), it
> +	 * should fit a little cpu even if there's some pressure.
> +	 *
> +	 * Only exception is for thermal pressure since it has a direct impact
> +	 * on available OPP of the system.
> +	 *
> +	 * We honour it for uclamp_min only as a drop in performance level
> +	 * could result in not getting the requested minimum performance level.
> +	 *
> +	 * For uclamp_max, we can tolerate a drop in performance level as the
> +	 * goal is to cap the task. So it's okay if it's getting less.
> +	 *
> +	 * In case of capacity inversion, which is not handled yet, we should
> +	 * honour the inverted capacity for both uclamp_min and uclamp_max all
> +	 * the time.
> +	 */
> +	capacity_orig = capacity_orig_of(cpu);
> +	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);

Did you and Vincent agreed at the end to use `cap_orig - _instantaneous_
thermal pressure` (1) here?

Last email in v1 from Vincent on this one was
https://lkml.kernel.org/r/20220722151300.GA30193@vingu-book :

"Using capacity_orig_of(cpu) - thermal_load_avg(rq_of(cpu)) seems like
a simple solution to cover thermal mitigation".

And there is no Acked-By/Reviewed-By so far.

We use (1) in feec() to cater for the thermal throttling (thermal
restricting policy->max) schedutil takes into account immediately when
asking for frequency (performance). EAS and schedutil should see the
same thing.

Do you want to use the same in util_fits_cpu() since it's used in feec()?

[...]
