Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA446D1F83
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjCaLy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCaLy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F27712CD2;
        Fri, 31 Mar 2023 04:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 205EA6280F;
        Fri, 31 Mar 2023 11:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57965C433D2;
        Fri, 31 Mar 2023 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680263694;
        bh=Z9WDinB4HAD4+ej+KHX2YQpkyN011VRo+nzW6UoXFGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oo1TrPYNGd8nHLWdOKsxsdNiwQa797E7PgKK3FmyPSd1LXbaYpp3Xto3iulKgVwPe
         3jy64DZST+DnbkVEBw8E87rxAjNz6z7Led9a5LTxbY72frLGtam+PnQOe6Zy95yapz
         1H3gpV970ra9/gpWH3XZpF+Nqc5HTwlU+5GLVe+okoQP2Y1zhVO01cmdDHxlFW5PEc
         2GNY/ZxAkSJWIUBKA9hfICq3RmhjxtAdhOekxSJYO7SKURCpChrWQ+OJjS+KIK+B0V
         2jeBhyzygyzlGqhtchgb3OM9kCmtGvoH/b9Kig15UuTAgAKgEnLm29ujfN+cI1SUsa
         u4S4paNcUiR0w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EBA324052D; Fri, 31 Mar 2023 08:54:51 -0300 (-03)
Date:   Fri, 31 Mar 2023 08:54:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, ravi.bangoria@amd.com, sandipan.das@amd.com,
        ananth.narayan@amd.com, gautham.shenoy@amd.com, eranian@google.com
Subject: Re: [RFC PATCH 1/4] perf: Read cache instance ID when building cache
 topology
Message-ID: <ZCbKCwJDf3PrjSLH@kernel.org>
References: <20230331045117.1266-1-kprateek.nayak@amd.com>
 <20230331045117.1266-2-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331045117.1266-2-kprateek.nayak@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 31, 2023 at 10:21:14AM +0530, K Prateek Nayak escreveu:
> CPU cache level data currently stores cache level, type, line size,
> associativity, sets, total cache size, and the CPUs sharing the cache.
> Also read and store the cache instance ID from
> "/sys/devices/system/cpu/cpuX/cache/indexY/id" in the cache level data.
> Use instance ID as well when comparing cache levels.

And if a new perf tool is used in an older kernel without this new 'id'
file?

Please check if the file exists, if it doesn't don't fail, just
initialize with a zero, this way the latest perf will be usable in older
kernels.

- Arnaldo
 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  tools/perf/util/env.h    | 1 +
>  tools/perf/util/header.c | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 4566c51f2fd9..d761bfae76af 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -17,6 +17,7 @@ struct cpu_topology_map {
>  
>  struct cpu_cache_level {
>  	u32	level;
> +	u32	id;
>  	u32	line_size;
>  	u32	sets;
>  	u32	ways;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 404d816ca124..5c3f5d260612 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1131,6 +1131,9 @@ static bool cpu_cache_level__cmp(struct cpu_cache_level *a, struct cpu_cache_lev
>  	if (a->level != b->level)
>  		return false;
>  
> +	if (a->id != b->id)
> +		return false;
> +
>  	if (a->line_size != b->line_size)
>  		return false;
>  
> @@ -1168,6 +1171,10 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
>  	if (sysfs__read_int(file, (int *) &cache->level))
>  		return -1;
>  
> +	scnprintf(file, PATH_MAX, "%s/id", path);
> +	if (sysfs__read_int(file, (int *) &cache->id))
> +		return -1;
> +
>  	scnprintf(file, PATH_MAX, "%s/coherency_line_size", path);
>  	if (sysfs__read_int(file, (int *) &cache->line_size))
>  		return -1;
> -- 
> 2.34.1
> 

-- 

- Arnaldo
