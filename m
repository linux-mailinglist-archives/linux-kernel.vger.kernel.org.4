Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACF1621E0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiKHUuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiKHUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:50:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2C14FF83;
        Tue,  8 Nov 2022 12:50:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54B9661789;
        Tue,  8 Nov 2022 20:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2DAC433C1;
        Tue,  8 Nov 2022 20:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667940640;
        bh=NPpgBvtP8l9ohShELFg2NniEcgCrGhEDM/j1P5wv1g8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJjOYUPyyRR4HyHcUsTcBTjY2VDReJ3KrdoEAlKgqNbFOheGReSWWDlYIGjE0rRfb
         MicxFvyAA0Ygm1L6ExbPXukuC1x/+7cVRfL8Y71+NeMqvecdK/EMvq935hB0pVZx9x
         ExKLzTAo5sCRgkH9nTeDYBqN2osa5p20IFjWsyqKDn8aBIqr56Q2HZ49IlqG16pooi
         hO0tXFEH0m6FGrxLfreghko8o/RcbuoZ87/jR707x+sW+Iutn+EQH8eIMtw/h7TE7X
         WVYyWOLNl0awlE3yH1lVO5LgSX6bLZl/9iehzW/sNz6Os8zCCAuyfN1vavv3fbZ/Rl
         5KKk7DcV60MOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B5A814034E; Tue,  8 Nov 2022 17:50:37 -0300 (-03)
Date:   Tue, 8 Nov 2022 17:50:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH 1/9] perf stat: Fix crash with --per-node --metric-only
 in CSV mode
Message-ID: <Y2rBHW39Z5PQAhDV@kernel.org>
References: <20221107213314.3239159-1-namhyung@kernel.org>
 <20221107213314.3239159-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107213314.3239159-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 07, 2022 at 01:33:06PM -0800, Namhyung Kim escreveu:
> The following command will get segfault due to missing aggr_header_csv
> for AGGR_NODE:
> 
>   $ sudo perf stat -a --per-node -x, --metric-only true

Thanks, applied to perf/urgent.

- Arnaldo
 
> Fixes: 86895b480a2f ("perf stat: Add --per-node agregation support")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 657434cd29ee..ea41e6308c50 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -534,7 +534,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  			[AGGR_CORE] = 2,
>  			[AGGR_THREAD] = 1,
>  			[AGGR_UNSET] = 0,
> -			[AGGR_NODE] = 0,
> +			[AGGR_NODE] = 1,
>  		};
>  
>  		pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
> @@ -819,6 +819,7 @@ static int aggr_header_lens[] = {
>  	[AGGR_SOCKET] = 12,
>  	[AGGR_NONE] = 6,
>  	[AGGR_THREAD] = 24,
> +	[AGGR_NODE] = 6,
>  	[AGGR_GLOBAL] = 0,
>  };
>  
> @@ -828,6 +829,7 @@ static const char *aggr_header_csv[] = {
>  	[AGGR_SOCKET] 	= 	"socket,cpus",
>  	[AGGR_NONE] 	= 	"cpu,",
>  	[AGGR_THREAD] 	= 	"comm-pid,",
> +	[AGGR_NODE] 	= 	"node,",
>  	[AGGR_GLOBAL] 	=	""
>  };
>  
> -- 
> 2.38.1.431.g37b22c650d-goog

-- 

- Arnaldo
