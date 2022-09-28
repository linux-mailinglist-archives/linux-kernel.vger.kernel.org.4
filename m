Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388525EDF40
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiI1Owx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiI1OwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:52:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE1D195E59;
        Wed, 28 Sep 2022 07:52:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A498923A;
        Wed, 28 Sep 2022 07:52:24 -0700 (PDT)
Received: from [10.57.0.129] (unknown [10.57.0.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 274E23F73D;
        Wed, 28 Sep 2022 07:52:16 -0700 (PDT)
Message-ID: <ee88c7fa-67fa-1d96-1067-f0d87b96e653@arm.com>
Date:   Wed, 28 Sep 2022 15:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/6] perf stat: Don't compare runtime stat for shadow
 stats
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
References: <20220926200757.1161448-1-namhyung@kernel.org>
 <20220926200757.1161448-7-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220926200757.1161448-7-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/09/2022 21:07, Namhyung Kim wrote:
> Now it always uses the global rt_stat.  Let's get rid of the field from
> the saved_value.  When the both evsels are NULL, it'd return 0 so remove
> the block in the saved_value_cmp.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-shadow.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
Reviewed-by: James Clark <james.clark@arm.com>

> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 99d05262055c..700563306637 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -35,7 +35,6 @@ struct saved_value {
>  	int ctx;
>  	int map_idx;
>  	struct cgroup *cgrp;
> -	struct runtime_stat *stat;
>  	struct stats stats;
>  	u64 metric_total;
>  	int metric_other;
> @@ -67,16 +66,6 @@ static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
>  	if (a->cgrp != b->cgrp)
>  		return (char *)a->cgrp < (char *)b->cgrp ? -1 : +1;
>  
> -	if (a->evsel == NULL && b->evsel == NULL) {
> -		if (a->stat == b->stat)
> -			return 0;
> -
> -		if ((char *)a->stat < (char *)b->stat)
> -			return -1;
> -
> -		return 1;
> -	}
> -
>  	if (a->evsel == b->evsel)
>  		return 0;
>  	if ((char *)a->evsel < (char *)b->evsel)
> @@ -120,7 +109,6 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
>  		.evsel = evsel,
>  		.type = type,
>  		.ctx = ctx,
> -		.stat = st,
>  		.cgrp = cgrp,
>  	};
>  
