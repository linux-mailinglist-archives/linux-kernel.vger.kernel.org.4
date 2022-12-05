Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC16428F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiLENJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLENJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:09:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8606BDF4B;
        Mon,  5 Dec 2022 05:09:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E781B810A2;
        Mon,  5 Dec 2022 13:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D96C433D6;
        Mon,  5 Dec 2022 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670245779;
        bh=JGe7A2mKPNwISfXUyKM/xAD82YV2mzxDTWEoLEbnyVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMG8Li8P2nmWIjukJsiXe7RmCS1MnjA3TpdGjdg4cZmMJoreI+YRGsKMl0V2BPfn5
         AJYIyap2lGDFIpe6Hca/nfPN70jceWnqglbSmbvt+Bc2etTh7lapPSd5zk/EapkW+p
         QNyQdDQyCeHTZtHUbKf7qeTrT0TLkvlC8mE8cnbcmUqquwEKYv+U3QtHw2OFJTPaRn
         tS3/XwC2MIufljrnrQDQ9t4bHwyP0hrsm4sZbdHZ6akl9TeKBylCY7B8SAywIFrgOO
         DONXkqudP6C29gIl/0dmRE3zn/azAC7aCeHbLPKbbeIeyoVIeIdENsA3A+hnXyS2qv
         E0UyAjlPnPy7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0720B40404; Mon,  5 Dec 2022 10:09:37 -0300 (-03)
Date:   Mon, 5 Dec 2022 10:09:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH] Revert "perf stat: Rename "aggregate-number" to
 "cpu-count" in JSON"
Message-ID: <Y43tkBsn5gZhIkXa@kernel.org>
References: <20221130193613.1046804-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130193613.1046804-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 30, 2022 at 11:36:13AM -0800, Namhyung Kim escreveu:
> This reverts commit c4b41b83c25073c09bfcc4e5ec496c9dd316656b.
> 
> As Ian said, the "cpu-count" is not appropriate for uncore events, also it
> caused a perf test failure.

This was applied, thanks.

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 847acdb5dc40..f1ee4b052198 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -281,19 +281,19 @@ static void print_aggr_id_json(struct perf_stat_config *config,
>  
>  	switch (config->aggr_mode) {
>  	case AGGR_CORE:
> -		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"cpu-count\" : %d, ",
> +		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
>  			id.socket, id.die, id.core, nr);
>  		break;
>  	case AGGR_DIE:
> -		fprintf(output, "\"die\" : \"S%d-D%d\", \"cpu-count\" : %d, ",
> +		fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
>  			id.socket, id.die, nr);
>  		break;
>  	case AGGR_SOCKET:
> -		fprintf(output, "\"socket\" : \"S%d\", \"cpu-count\" : %d, ",
> +		fprintf(output, "\"socket\" : \"S%d\", \"aggregate-number\" : %d, ",
>  			id.socket, nr);
>  		break;
>  	case AGGR_NODE:
> -		fprintf(output, "\"node\" : \"N%d\", \"cpu-count\" : %d, ",
> +		fprintf(output, "\"node\" : \"N%d\", \"aggregate-number\" : %d, ",
>  			id.node, nr);
>  		break;
>  	case AGGR_NONE:
> -- 
> 2.38.1.584.g0f3c55d4c2-goog

-- 

- Arnaldo
