Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355835EDA45
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiI1Klc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiI1Kl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:41:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB4FE7E33C;
        Wed, 28 Sep 2022 03:41:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51C66143D;
        Wed, 28 Sep 2022 03:41:32 -0700 (PDT)
Received: from [10.57.0.129] (unknown [10.57.0.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC6A13F792;
        Wed, 28 Sep 2022 03:41:23 -0700 (PDT)
Message-ID: <a2a5e3ab-18ca-d61a-73bb-d60b9c2c8929@arm.com>
Date:   Wed, 28 Sep 2022 11:41:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/6] perf stat: Don't call perf_stat_evsel_id_init()
 repeatedly
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
 <20220926200757.1161448-3-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220926200757.1161448-3-namhyung@kernel.org>
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
> The evsel__reset_stat_priv() is called more than once if user gave -r
> option for multiple run.  But it doesn't need to re-initialize the id.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: James Clark <james.clark@arm.com>

> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 6bcd3dc32a71..e1d3152ce664 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -135,7 +135,6 @@ static void evsel__reset_stat_priv(struct evsel *evsel)
>  	struct perf_stat_evsel *ps = evsel->stats;
>  
>  	init_stats(&ps->res_stats);
> -	perf_stat_evsel_id_init(evsel);
>  }
>  
>  static int evsel__alloc_stat_priv(struct evsel *evsel)
> @@ -143,6 +142,7 @@ static int evsel__alloc_stat_priv(struct evsel *evsel)
>  	evsel->stats = zalloc(sizeof(struct perf_stat_evsel));
>  	if (evsel->stats == NULL)
>  		return -ENOMEM;
> +	perf_stat_evsel_id_init(evsel);
>  	evsel__reset_stat_priv(evsel);
>  	return 0;
>  }
