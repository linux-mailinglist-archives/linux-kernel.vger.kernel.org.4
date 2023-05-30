Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6656D715C97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjE3LGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjE3LGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:06:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76BACA8;
        Tue, 30 May 2023 04:06:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 704B12F4;
        Tue, 30 May 2023 04:07:03 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E08BB3F67D;
        Tue, 30 May 2023 04:06:15 -0700 (PDT)
Message-ID: <418bef75-883c-2442-3376-03fd7537c734@arm.com>
Date:   Tue, 30 May 2023 13:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 03/17] PM: EM: Refactor em_pd_get_efficient_state() to
 be more flexible
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
 <20230512095743.3393563-4-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230512095743.3393563-4-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 11:57, Lukasz Luba wrote:
> Prepare em_pd_get_efficient_state() for the upcoming changes and
> make it possible to re-use. Return an index for the best performance

Don't get the `possible to re-use`? Did you mean `possible to be
re-used`? But then `re-used` for what?

> state. The function arguments that are introduced should allow to
> work on different performance state arrays. The caller of
> em_pd_get_efficient_state() should be able to use the index either
> on the default or the modifiable EM table.

This describes the WHAT but not the WHY.

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b9caa01dfac4..8069f526c9d8 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -175,33 +175,35 @@ void em_dev_unregister_perf_domain(struct device *dev);
>  
>  /**
>   * em_pd_get_efficient_state() - Get an efficient performance state from the EM
> - * @pd   : Performance domain for which we want an efficient frequency
> - * @freq : Frequency to map with the EM
> + * @state:		List of performance states, in ascending order
> + * @nr_perf_states:	Number of performance states
> + * @freq:		Frequency to map with the EM
> + * @pd_flags:		Performance Domain flags
>   *
>   * It is called from the scheduler code quite frequently and as a consequence
>   * doesn't implement any check.
>   *
> - * Return: An efficient performance state, high enough to meet @freq
> + * Return: An efficient performance state id, high enough to meet @freq
>   * requirement.
>   */
> -static inline
> -struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
> -						unsigned long freq)
> +static inline int
> +em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
> +			  unsigned long freq, unsigned long pd_flags)
>  {
>  	struct em_perf_state *ps;
>  	int i;
>  
> -	for (i = 0; i < pd->nr_perf_states; i++) {
> -		ps = &pd->table[i];
> +	for (i = 0; i < nr_perf_states; i++) {
> +		ps = &table[i];
>  		if (ps->frequency >= freq) {
> -			if (pd->flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
> +			if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
>  			    ps->flags & EM_PERF_STATE_INEFFICIENT)
>  				continue;
> -			break;
> +			return i;
>  		}
>  	}
>  
> -	return ps;
> +	return nr_perf_states - 1;
>  }
>  
>  /**
> @@ -226,7 +228,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  {
>  	unsigned long freq, scale_cpu;
>  	struct em_perf_state *ps;
> -	int cpu;
> +	int cpu, i;
>  
>  	if (!sum_util)
>  		return 0;
> @@ -251,7 +253,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  	 * Find the lowest performance state of the Energy Model above the
>  	 * requested frequency.
>  	 */
> -	ps = em_pd_get_efficient_state(pd, freq);
> +	i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
> +				      pd->flags);
> +	ps = &pd->table[i];
>  
>  	/*
>  	 * The capacity of a CPU in the domain at the performance state (ps)

