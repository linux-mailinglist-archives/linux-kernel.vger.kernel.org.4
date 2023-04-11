Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703406DDFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDKPjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDKPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:39:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B601D110;
        Tue, 11 Apr 2023 08:39:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93718D75;
        Tue, 11 Apr 2023 08:40:17 -0700 (PDT)
Received: from [10.57.20.231] (unknown [10.57.20.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDE873F73F;
        Tue, 11 Apr 2023 08:39:29 -0700 (PDT)
Message-ID: <9994acf8-e0bc-55ce-9012-e36ef3b8ddab@arm.com>
Date:   Tue, 11 Apr 2023 17:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 05/17] trace: energy_model: Add trace event for EM runtime
 modifications
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org
References: <20230314103357.26010-1-lukasz.luba@arm.com>
 <20230314103357.26010-6-lukasz.luba@arm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230314103357.26010-6-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lukasz,
Just a suggestion, maybe it would be good to trace the CPUs affected by
the modification. It is possible to retrieve this information by going
to /sys/kernel/debug/energy_model/xxx/cpus, but might be simpler when
parsing a trace.

Regards,
Pierre

On 3/14/23 11:33, Lukasz Luba wrote:
> The Energy Model (EM) supports runtime modifications. Track the changes
> in order to do post-processing analysis. Don't use arrays in the trace
> event, since they are not properly supported by the tools. Instead use
> simple "unroll" with emitting the trace event for each EM array entry
> with proper ID information. The older debugging mechanism which was
> the simple debugfs which dumping the EM content won't be sufficient for
> the modifiable EM purpose. This trace event mechanism would address the
> needs.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   include/trace/events/energy_model.h | 46 +++++++++++++++++++++++++++++
>   kernel/power/energy_model.c         |  3 ++
>   2 files changed, 49 insertions(+)
>   create mode 100644 include/trace/events/energy_model.h
> 
> diff --git a/include/trace/events/energy_model.h b/include/trace/events/energy_model.h
> new file mode 100644
> index 000000000000..f70babeb5dde
> --- /dev/null
> +++ b/include/trace/events/energy_model.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM energy_model
> +
> +#if !defined(_TRACE_ENERGY_MODEL_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_ENERGY_MODEL_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(em_perf_state,
> +	TP_PROTO(const char *dev_name, int nr_perf_states, int state,
> +		 unsigned long ps_frequency, unsigned long ps_power,
> +		 unsigned long ps_cost, unsigned long ps_flags),
> +
> +	TP_ARGS(dev_name, nr_perf_states, state, ps_frequency, ps_power, ps_cost,
> +		ps_flags),
> +
> +	TP_STRUCT__entry(
> +		__string(name, dev_name)
> +		__field(int, num_states)
> +		__field(int, state)
> +		__field(unsigned long, frequency)
> +		__field(unsigned long, power)
> +		__field(unsigned long, cost)
> +		__field(unsigned long, flags)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, dev_name);
> +		__entry->num_states = nr_perf_states;
> +		__entry->state = state;
> +		__entry->frequency = ps_frequency;
> +		__entry->power = ps_power;
> +		__entry->cost = ps_cost;
> +		__entry->flags = ps_flags;
> +	),
> +
> +	TP_printk("dev_name=%s nr_perf_states=%d state=%d frequency=%lu power=%lu cost=%lu flags=%lu",
> +		__get_str(name), __entry->num_states, __entry->state,
> +		__entry->frequency, __entry->power, __entry->cost,
> +		__entry->flags)
> +);
> +#endif /* _TRACE_ENERGY_MODEL_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 937e98a71ed5..3b778743ba89 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -17,6 +17,9 @@
>   #include <linux/sched/topology.h>
>   #include <linux/slab.h>
>   
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/energy_model.h>
> +
>   /*
>    * Mutex serializing the registrations of performance domains and letting
>    * callbacks defined by drivers sleep.
