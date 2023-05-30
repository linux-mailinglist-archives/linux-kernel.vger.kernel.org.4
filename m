Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0373D716627
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjE3PGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjE3PFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FBA121;
        Tue, 30 May 2023 08:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B743F63219;
        Tue, 30 May 2023 15:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F12C433EF;
        Tue, 30 May 2023 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685459104;
        bh=jNNk+uMNRoA7Qd9nZx0RRfbd8TyvCtB4eZfArdxB/cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PG/8L34vZjQpHcvAP8K6XWHVv8POvmKaiukMc7GdaF51AcOoSGhhXQfF8ESwlB6Qc
         DqZIzb2oH0ihQwMzyRMq8zRvMmrYLW3aynzbr14TmXXCk8ai5okWaZsTPgb6jemnxx
         TQ9Fs9LkUesSibtst2bAGshu1YtoivJ1I69897JU5xflDksOodTCCA3SHwP2m+WCeb
         9kDTqlS1ZiF6Weni/x9CX8VLRsmesIzLTxtn0rtsGev+JiZcAe7aonplZuC+exbDdL
         dewVM2SGuxZYeoIoSnXNPo4+gsE+eda0WFR+xhD4f/KtWEviSc9D1G9AMS7GXsV1v+
         +EGyRfZlxSrXA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2B72040692; Tue, 30 May 2023 12:05:01 -0300 (-03)
Date:   Tue, 30 May 2023 12:05:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1] perf kvm: Fix powerpc build
Message-ID: <ZHYQndjJ/lR3soZy@kernel.org>
References: <20230530021433.3107580-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530021433.3107580-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 29, 2023 at 07:14:33PM -0700, Ian Rogers escreveu:
> Missed function rename from pmu_have_event to perf_pmus__have_event.
> 
> Fixes: 1eaf496ed386 ("perf pmu: Separate pmu and pmus")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/powerpc/util/kvm-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

[acme@quaco perf-tools-next]$ grep perf_pmus__have_event tools/perf/util/*.h
tools/perf/util/pmus.h:bool perf_pmus__have_event(const char *pname, const char *name);
[acme@quaco perf-tools-next]$ vim tools/perf/arch/powerpc/util/kvm-stat.c
[acme@quaco perf-tools-next]$ grep -w perf_pmus__have_event tools/perf/util/*.h
tools/perf/util/pmus.h:bool perf_pmus__have_event(const char *pname, const char *name);
[acme@quaco perf-tools-next]$ grep -w perf_pmus__have_event tools/perf/arch/powerpc/util/kvm-stat.c
		if (perf_pmus__have_event("trace_imc", "trace_cycles")) {
[acme@quaco perf-tools-next]$ grep util\/pmus.h tools/perf/arch/powerpc/util/kvm-stat.c
[acme@quaco perf-tools-next]$ 

I'm adding the missing explicit:

#include "util/pmus.h"

to tools/perf/arch/powerpc/util/kvm-stat.c, ok?

Also removing the now needless util/pmu.h include.

Thanks,

- Arnaldo
 
> diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
> index ea1220d66b67..1039e15c27c9 100644
> --- a/tools/perf/arch/powerpc/util/kvm-stat.c
> +++ b/tools/perf/arch/powerpc/util/kvm-stat.c
> @@ -204,7 +204,7 @@ int kvm_add_default_arch_event(int *argc, const char **argv)
>  
>  	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
>  	if (!event) {
> -		if (pmu_have_event("trace_imc", "trace_cycles")) {
> +		if (perf_pmus__have_event("trace_imc", "trace_cycles")) {
>  			argv[j++] = strdup("-e");
>  			argv[j++] = strdup("trace_imc/trace_cycles/");
>  			*argc += 2;
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 

-- 

- Arnaldo
