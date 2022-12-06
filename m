Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B410644AC7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiLFSD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiLFSDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:03:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2B3C2EF75
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 10:03:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 436D223A;
        Tue,  6 Dec 2022 10:03:58 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFBF13F73B;
        Tue,  6 Dec 2022 10:03:48 -0800 (PST)
Message-ID: <75ba5884-63c0-5180-00b8-e9764306a83e@arm.com>
Date:   Tue, 6 Dec 2022 19:03:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/7] sched/fair: Introduce sched_smt_siblings_idle()
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-5-ricardo.neri-calderon@linux.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221122203532.15013-5-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 21:35, Ricardo Neri wrote:
> Architectures that implement arch_asym_cpu_priority() may need to know the
> idle state of the SMT siblings of a CPU. The scheduler has this information
> and functionality. Expose it.
> 
> Move the existing functionality outside of the NUMA code.

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0e4251f83807..9517c48df50e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1052,6 +1052,28 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   * Scheduling class queueing methods:
>   */
>  
> +static inline bool is_core_idle(int cpu)
> +{
> +#ifdef CONFIG_SCHED_SMT
> +	int sibling;
> +
> +	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
> +		if (cpu == sibling)
> +			continue;
> +
> +		if (!idle_cpu(sibling))
> +			return false;
> +	}
> +#endif
> +
> +	return true;
> +}
> +
> +bool sched_smt_siblings_idle(int cpu)
> +{
> +	return is_core_idle(cpu);
> +}

Nitpick: Can we not just have one exported function for both use-cases:
NUMA and x86 ITMT?

[...]
