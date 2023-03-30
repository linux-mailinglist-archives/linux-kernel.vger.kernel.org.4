Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB6A6D1095
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjC3VL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjC3VLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:11:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27333DBE6;
        Thu, 30 Mar 2023 14:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF8FAB82A37;
        Thu, 30 Mar 2023 21:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C56BC433D2;
        Thu, 30 Mar 2023 21:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680210698;
        bh=0BNxiRvexGip6Q6l3mbtrFq0KLDE7GfQjeWE5qFYM1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRvJlCRpnS0i7CK1rEcQGoZXvWyFiqO/w0pRmO9u+sBxxxvvRYp1eRy45g9AinDoR
         MiMq7Qz/lDTARGEjkGplwNq/yJP4oLjsCnKBFS+X/Of45kHNr/ds9ogW5TfmrGVthD
         uj3t2bpZB8pcVL7rXjj8tUG/gUdwbY/9IRb8F53PuTgQ/32AKfMW5Zz+/MJae9v0aO
         hysXx+8nm1Ir/XIRhYdHHKEcwCI+Rb5fIZUk67a8BYoFV4m27WPD/GBczaxmUaR+2Q
         pG/jOnypA/BuD7v5q5aNQhFl/jTvXCYbz3Gu1PrGSXAqOBw42P0uLIs1eAd+HAxgrQ
         e8Mi29fCuVHeQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1FC44052D; Thu, 30 Mar 2023 18:11:35 -0300 (-03)
Date:   Thu, 30 Mar 2023 18:11:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] perf bench: Avoid NDEBUG warning
Message-ID: <ZCX7B/7ikbbie/FD@kernel.org>
References: <20230330183827.1412303-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330183827.1412303-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 30, 2023 at 11:38:25AM -0700, Ian Rogers escreveu:
> With NDEBUG set the asserts are compiled out. This yields
> "unused-but-set-variable" variables. Move these variables behind
> NDEBUG to avoid the warning.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/bench/find-bit-bench.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
> index d103c3136983..7e25b0e413f6 100644
> --- a/tools/perf/bench/find-bit-bench.c
> +++ b/tools/perf/bench/find-bit-bench.c
> @@ -61,7 +61,6 @@ static int do_for_each_set_bit(unsigned int num_bits)
>  	double time_average, time_stddev;
>  	unsigned int bit, i, j;
>  	unsigned int set_bits, skip;
> -	unsigned int old;
>  
>  	init_stats(&fb_time_stats);
>  	init_stats(&tb_time_stats);
> @@ -73,7 +72,10 @@ static int do_for_each_set_bit(unsigned int num_bits)
>  			__set_bit(i, to_test);
>  
>  		for (i = 0; i < outer_iterations; i++) {
> -			old = accumulator;
> +#ifndef NDEBUG
> +			unsigned int old = accumulator;
> +#endif
> +
>  			gettimeofday(&start, NULL);
>  			for (j = 0; j < inner_iterations; j++) {
>  				for_each_set_bit(bit, to_test, num_bits)
> @@ -85,7 +87,9 @@ static int do_for_each_set_bit(unsigned int num_bits)
>  			runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
>  			update_stats(&fb_time_stats, runtime_us);
>  
> +#ifndef NDEBUG
>  			old = accumulator;
> +#endif
>  			gettimeofday(&start, NULL);
>  			for (j = 0; j < inner_iterations; j++) {
>  				for (bit = 0; bit < num_bits; bit++) {
> -- 
> 2.40.0.348.gf938b09366-goog
> 

-- 

- Arnaldo
