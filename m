Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DAE6448E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiLFQLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbiLFQLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:11:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3B93C6F5;
        Tue,  6 Dec 2022 08:05:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01293B81A10;
        Tue,  6 Dec 2022 16:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637FAC433D6;
        Tue,  6 Dec 2022 16:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670342742;
        bh=dhu2N+fEW5LFXReqHPaIbjnwpjqZjO1Gm9ovtwKYHj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aASCFaFX/41rDkHGOe4s8/Szn3fOhbUbO0PzyjQK17UbveQ/fODkG9W21MpOLYCEL
         zdOPglkViYxEIBDYBkmPAD20rti/LWZ9Z5WFRfo5otIFAeQKTyn2G1zMXk5gbYX/VU
         JxoPxZdR5R8naILz191DccbzKbwGD0+fOBQOB/r+enn9TS/ojPQt3BlKETiIqmhnzN
         PETmVcKDusM2qOE9dT8R6lh+SXWme02Wolp9ciEgX3TKwjZS8Ye4JcSHP61QTHb4xs
         WYpLmiPvkelKA8XakdeX2Ehqy58uTPoqw1qSeBCX5kMJxwSmXT0N4PAewigpK8xb6V
         6wGxUfnNAQbFA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 662F040404; Tue,  6 Dec 2022 13:05:39 -0300 (-03)
Date:   Tue, 6 Dec 2022 13:05:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf stat: Update event skip condition
Message-ID: <Y49oU5fJCNjAdh3S@kernel.org>
References: <20221205231630.319759-1-namhyung@kernel.org>
 <ED791914-FA30-410A-8BD8-735248940A72@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED791914-FA30-410A-8BD8-735248940A72@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 06, 2022 at 07:45:29PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 06-Dec-2022, at 4:46 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > In print_counter_aggrdata(), it skips some events that has no aggregate
> > count.  It's actually for system-wide per-thread mode and merged uncore
> > and hybrid events.
> > 
> > Let's update the condition to check them explicitly.
> > 
> > Fixes: 91f85f98da7a ("Display event stats using aggr counts")
> > Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > Athira, could you please check this fixes the problem?
> > 
> > tools/perf/util/stat-display.c | 16 +++++++++-------
> > 1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 847acdb5dc40..6c0de52ac4be 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -814,7 +814,8 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
> > 	os->nr = aggr->nr;
> > 	os->evsel = counter;
> > 
> > -	if (counter->supported && aggr->nr == 0)
> > +	/* Skip already merged uncore/hybrid events */
> > +	if (counter->merged_stat)
> > 		return;
> 
> Hi Namhyung,
> 
> Thanks for the fix.
> 
> This patch removes the merged_stat checks from print_aggr and print_aggr_cgroup.
> We also have this check in print_counter which needs to be removed.
> 
> With that change, 

Waiting for v2 then.

- Arnaldo
 
> Acked-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> 
> > 
> > 	uniquify_counter(config, counter);
> > @@ -823,6 +824,13 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
> > 	ena = aggr->counts.ena;
> > 	run = aggr->counts.run;
> > 
> > +	/*
> > +	 * Skip value 0 when enabling --per-thread globally, otherwise it will
> > +	 * have too many 0 output.
> > +	 */
> > +	if (val == 0 && config->aggr_mode == AGGR_THREAD && config->system_wide)
> > +		return;
> > +
> > 	if (!metric_only) {
> > 		if (config->json_output)
> > 			fputc('{', output);
> > @@ -899,9 +907,6 @@ static void print_aggr(struct perf_stat_config *config,
> > 		print_metric_begin(config, evlist, os, s);
> > 
> > 		evlist__for_each_entry(evlist, counter) {
> > -			if (counter->merged_stat)
> > -				continue;
> > -
> > 			print_counter_aggrdata(config, counter, s, os);
> > 		}
> > 		print_metric_end(config, os);
> > @@ -928,9 +933,6 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
> > 			print_metric_begin(config, evlist, os, s);
> > 
> > 			evlist__for_each_entry(evlist, counter) {
> > -				if (counter->merged_stat)
> > -					continue;
> > -
> > 				if (counter->cgrp != os->cgrp)
> > 					continue;
> > 
> > -- 
> > 2.39.0.rc0.267.gcb52ba06e7-goog
> > 

-- 

- Arnaldo
