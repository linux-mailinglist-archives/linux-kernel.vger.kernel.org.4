Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8D72BABD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjFLIcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjFLIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:32:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79D7ADF;
        Mon, 12 Jun 2023 01:31:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ACE11FB;
        Mon, 12 Jun 2023 01:32:08 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD87D3F663;
        Mon, 12 Jun 2023 01:31:20 -0700 (PDT)
Message-ID: <441ba0b3-c942-5fa9-f6e6-bd3da559c65b@arm.com>
Date:   Mon, 12 Jun 2023 09:31:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] perf stat: Add missing newline in pr_err messages
To:     Yang Jihong <yangjihong1@huawei.com>
References: <20230610094441.221525-1-yangjihong1@huawei.com>
Content-Language: en-US
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230610094441.221525-1-yangjihong1@huawei.com>
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



On 10/06/2023 10:44, Yang Jihong wrote:
> The newline is missing for error messages in add_default_attributes()
> 
> Before:
> 
>   # perf stat --topdown
>   Topdown requested but the topdown metric groups aren't present.
>   (See perf list the metric groups have names like TopdownL1)#
> 
> After:
> 
>   # perf stat --topdown
>   Topdown requested but the topdown metric groups aren't present.
>   (See perf list the metric groups have names like TopdownL1)
>   #
> 
> In addition, perf_stat_init_aggr_mode() and perf_stat_init_aggr_mode_file()
> have the same problem, fixed by the way.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
> 
> Changes since v1:
>  - Correct commit title to `pr_err`
> 
>  tools/perf/builtin-stat.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b9ad32f21e57..78644ae538c4 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1398,7 +1398,7 @@ static int perf_stat_init_aggr_mode(void)
>  		stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
>  							 get_id, /*data=*/NULL, needs_sort);
>  		if (!stat_config.aggr_map) {
> -			pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
> +			pr_err("cannot build %s map\n", aggr_mode__string[stat_config.aggr_mode]);
>  			return -1;
>  		}
>  		stat_config.aggr_get_id = aggr_mode__get_id(stat_config.aggr_mode);
> @@ -1650,7 +1650,7 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
>  	stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
>  						 get_id, env, needs_sort);
>  	if (!stat_config.aggr_map) {
> -		pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
> +		pr_err("cannot build %s map\n", aggr_mode__string[stat_config.aggr_mode]);
>  		return -1;
>  	}
>  	stat_config.aggr_get_id = aggr_mode__get_id_file(stat_config.aggr_mode);
> @@ -1789,7 +1789,7 @@ static int add_default_attributes(void)
>  		 * on an architecture test for such a metric name.
>  		 */
>  		if (!metricgroup__has_metric("transaction")) {
> -			pr_err("Missing transaction metrics");
> +			pr_err("Missing transaction metrics\n");
>  			return -1;
>  		}
>  		return metricgroup__parse_groups(evsel_list, "transaction",
> @@ -1805,7 +1805,7 @@ static int add_default_attributes(void)
>  		int smi;
>  
>  		if (sysfs__read_int(FREEZE_ON_SMI_PATH, &smi) < 0) {
> -			pr_err("freeze_on_smi is not supported.");
> +			pr_err("freeze_on_smi is not supported.\n");
>  			return -1;
>  		}
>  
> @@ -1818,7 +1818,7 @@ static int add_default_attributes(void)
>  		}
>  
>  		if (!metricgroup__has_metric("smi")) {
> -			pr_err("Missing smi metrics");
> +			pr_err("Missing smi metrics\n");
>  			return -1;
>  		}
>  
> @@ -1843,7 +1843,7 @@ static int add_default_attributes(void)
>  
>  		if (!max_level) {
>  			pr_err("Topdown requested but the topdown metric groups aren't present.\n"
> -				"(See perf list the metric groups have names like TopdownL1)");
> +				"(See perf list the metric groups have names like TopdownL1)\n");
>  			return -1;
>  		}
>  		if (stat_config.topdown_level > max_level) {
