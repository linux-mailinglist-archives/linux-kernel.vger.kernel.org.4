Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84D72CEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbjFLSzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFLSz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:55:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EC318C;
        Mon, 12 Jun 2023 11:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3856060916;
        Mon, 12 Jun 2023 18:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8E6C433EF;
        Mon, 12 Jun 2023 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686596127;
        bh=ONXIez0vKmrr43qDMis8+baQaxtszu1bEx4H6HRpMpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zd8OUhNOmT1yyAs/JuUHTfp9vsDJicN2sz4c8xn1u8o7TIzggO6nP3VtDgTcyzeEm
         judS8jM+NRwjwDTYHZjwCJBsLdwgoi7KP5KlGFpT2n0ExN2/3rdBncNqyIUq0rVFRq
         Tw8GlCDPLKPQzDatI+tcXy3I8hM006qdT6qC3+X2/H5gx9qd1Q1slf6zCwOoHhruAz
         LhrHvEPYIHf4NyX2xeXrwO3621Zjw0qUkBxVea3HEh/s8xYwB/pe4XrlK2W2PsRcPs
         ZIcxm01BIK1MK2fOK8D9aXn4nWvzw+eZIo4PD4zd17D5I+qjBspJAApS0nHqabg4+h
         U+LUP4GuDhUTA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 22FAA40692; Mon, 12 Jun 2023 15:55:25 -0300 (-03)
Date:   Mon, 12 Jun 2023 15:55:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf stat: Add missing newline in pr_err messages
Message-ID: <ZIdqHeZOWCztKVe2@kernel.org>
References: <20230610094441.221525-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230610094441.221525-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 10, 2023 at 09:44:41AM +0000, Yang Jihong escreveu:
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

Wait a bit till I push what I had to perf-tools-next, as it is not
applying right now:

⬢[acme@toolbox perf-tools-next]$ patch -p1 < ~/wb/1.patch
patching file tools/perf/builtin-stat.c
Hunk #1 succeeded at 1594 (offset 196 lines).
Hunk #2 succeeded at 1910 (offset 260 lines).
Hunk #3 FAILED at 1789.
Hunk #4 succeeded at 2066 (offset 261 lines).
Hunk #5 FAILED at 1818.
Hunk #6 succeeded at 2104 (offset 261 lines).
2 out of 6 hunks FAILED -- saving rejects to file tools/perf/builtin-stat.c.rej
⬢[acme@toolbox perf-tools-next]$
 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
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
> -- 
> 2.30.GIT
> 

-- 

- Arnaldo
