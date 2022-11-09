Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FF5622B1E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKIMHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKIMHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:07:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A52B52A94A;
        Wed,  9 Nov 2022 04:07:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95CF31FB;
        Wed,  9 Nov 2022 04:07:23 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19B793F534;
        Wed,  9 Nov 2022 04:07:15 -0800 (PST)
Message-ID: <64b87f41-022e-cb3b-83d9-a5b88010e46e@arm.com>
Date:   Wed, 9 Nov 2022 12:07:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 14/14] coresight: trace-id: Add debug & test macros to
 Trace ID allocation
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20221101163103.17921-1-mike.leach@linaro.org>
 <20221101163103.17921-15-mike.leach@linaro.org>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221101163103.17921-15-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2022 16:31, Mike Leach wrote:
> Adds in a number of pr_debug macros to allow the debugging and test of
> the trace ID allocation system.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-trace-id.c  | 33 +++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index 8e05a244c9d6..1588bad60715 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -64,6 +64,27 @@ static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_ma
>   	set_bit(id, id_map->pend_rel_ids);
>   }
>   
> +/* #define TRACE_ID_DEBUG 1 */
> +#ifdef TRACE_ID_DEBUG
> +
> +static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
> +					  const char *func_name)
> +{
> +	pr_debug("%s id_map::\n", func_name);
> +	pr_debug("Avial= %*pb\n", CORESIGHT_TRACE_IDS_MAX, id_map->used_ids);

minor nit: "Avail". Rather, shouldn't it be "Used" ?

Otherwise, the code looks good to me. The only concern is, the code
could be stale without actually getting compiled. Could we turn this to
may be:

#if defined(TRACE_ID_DEBUG) || defined(CONFIG_COMPILE_TEST)

or even tie this to a CONFIG, so that the code can be tested.

e.g., CONFIG_CORESIGHT_DEBUG_TRACEID depending on the DEBUG_KERNEL

Suzuki


> +	pr_debug("Pend = %*pb\n", CORESIGHT_TRACE_IDS_MAX, id_map->pend_rel_ids);
> +}
> +#define DUMP_ID_MAP(map)   coresight_trace_id_dump_table(map, __func__)
> +#define DUMP_ID_CPU(cpu, id) pr_debug("%s called;  cpu=%d, id=%d\n", __func__, cpu, id)
> +#define DUMP_ID(id)   pr_debug("%s called; id=%d\n", __func__, id)
> +#define PERF_SESSION(n) pr_debug("%s perf count %d\n", __func__, n)
> +#else
> +#define DUMP_ID_MAP(map)
> +#define DUMP_ID(id)
> +#define DUMP_ID_CPU(cpu, id)
> +#define PERF_SESSION(n)
> +#endif
> +
>   /* release all pending IDs for all current maps & clear CPU associations */
>   static void coresight_trace_id_release_all_pending(void)
>   {
> @@ -81,6 +102,7 @@ static void coresight_trace_id_release_all_pending(void)
>   		clear_bit(cpu, cpu_id_release_pending);
>   	}
>   	spin_unlock_irqrestore(&id_map_lock, flags);
> +	DUMP_ID_MAP(id_map);
>   }
>   
>   static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> @@ -120,6 +142,8 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
>   get_cpu_id_out_unlock:
>   	spin_unlock_irqrestore(&id_map_lock, flags);
>   
> +	DUMP_ID_CPU(cpu, id);
> +	DUMP_ID_MAP(id_map);
>   	return id;
>   }
>   
> @@ -146,6 +170,8 @@ static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id
>   	}
>   
>   	spin_unlock_irqrestore(&id_map_lock, flags);
> +	DUMP_ID_CPU(cpu, id);
> +	DUMP_ID_MAP(id_map);
>   }
>   
>   static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
> @@ -157,6 +183,8 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
>   	id = coresight_trace_id_alloc_new_id(id_map, 0);
>   	spin_unlock_irqrestore(&id_map_lock, flags);
>   
> +	DUMP_ID(id);
> +	DUMP_ID_MAP(id_map);
>   	return id;
>   }
>   
> @@ -167,6 +195,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
>   	spin_lock_irqsave(&id_map_lock, flags);
>   	coresight_trace_id_free(id, id_map);
>   	spin_unlock_irqrestore(&id_map_lock, flags);
> +
> +	DUMP_ID(id);
> +	DUMP_ID_MAP(id_map);
>   }
>   
>   /* API functions */
> @@ -204,6 +235,7 @@ EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
>   void coresight_trace_id_perf_start(void)
>   {
>   	atomic_inc(&perf_cs_etm_session_active);
> +	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
>   }
>   EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
>   
> @@ -211,6 +243,7 @@ void coresight_trace_id_perf_stop(void)
>   {
>   	if (!atomic_dec_return(&perf_cs_etm_session_active))
>   		coresight_trace_id_release_all_pending();
> +	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
>   }
>   EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
>   

