Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A2064B7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiLMOoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbiLMOoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:44:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B33E2FE;
        Tue, 13 Dec 2022 06:44:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4645FB811D8;
        Tue, 13 Dec 2022 14:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C77CC433EF;
        Tue, 13 Dec 2022 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670942645;
        bh=ITWlJPRHLiVkjAwuGTarFPRTpQtiWPKN8YZPZTB5+Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXofy+aMduC6B9MfC3WZE0lQqiRZBaj4sij5umxyw1Uegbs2Vo3Izg8hmPsHhvG9E
         VW6KtuJIkHFlM89Vs492/2iFBynyyt4LVYkmuEBshZ9NQcKQy350yuXpjSESxJCdPm
         dlNo1FBOlWDYQ3Mo381eWPkQCacFhrHFoPZJ02sF6D+I76tyyQ95g7+6ODXx5eSdQw
         QI9vO44PGn27xc34uZOuKfp8fitewFc1svBivOFQUPaBS5HzsjIVwK6504OAj6TRvP
         mdCWkvRBTpUeX+ESxjeSE+NthSodHBl+EkaVu5mnOc4hDpw0Wu2NeZoLdldrHssazq
         U0SSJXbEVtM7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D06E40367; Tue, 13 Dec 2022 11:44:02 -0300 (-03)
Date:   Tue, 13 Dec 2022 11:44:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     =?iso-8859-1?Q?Adri=E1n?= Herrera Arcila <adrian.herrera@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, songliubraving@fb.com, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH 2/2] perf stat: fix unexpected delay behaviour
Message-ID: <Y5iPsjF/lEsEldU8@kernel.org>
References: <20220729161244.10522-1-adrian.herrera@arm.com>
 <20220729161244.10522-2-adrian.herrera@arm.com>
 <e3e123db-5321-c96e-1753-27059c729640@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3e123db-5321-c96e-1753-27059c729640@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 01, 2022 at 09:20:37AM +0100, James Clark escreveu:
> 
> 
> On 29/07/2022 17:12, Adrián Herrera Arcila wrote:
> > The described --delay behaviour is to delay the enablement of events, but
> > not the execution of the command, if one is passed, which is incorrectly
> > the current behaviour.
> > 
> > This patch decouples the enablement from the delay, and enables events
> > before or after launching the workload dependent on the options passed
> > by the user. This code structure is inspired by that in perf-record, and
> > tries to be consistent with it.
> > 
> > Link: https://lore.kernel.org/linux-perf-users/7BFD066E-B0A8-49D4-B635-379328F0CF4C@fb.com
> > Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> > Signed-off-by: Adrián Herrera Arcila <adrian.herrera@arm.com>
> > ---
> >  tools/perf/builtin-stat.c | 56 ++++++++++++++++++++++-----------------
> >  1 file changed, 32 insertions(+), 24 deletions(-)
> 
> Looks good to me. Fixes the counter delay issue and the code is pretty
> similar to perf record now. Although I would wait for Leo's or Song's
> comment as well because they were involved.

I think I didn't notice Leo's ack, it still applies, so I'm doing it
now.

- Arnaldo
 
> Reviewed-by: James Clark <james.clark@arm.com>
> 
> > 
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 318ffd119dad..f98c823b16dd 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -559,7 +559,7 @@ static bool handle_interval(unsigned int interval, int *times)
> >  	return false;
> >  }
> >  
> > -static int enable_counters(void)
> > +static int enable_bpf_counters(void)
> >  {
> >  	struct evsel *evsel;
> >  	int err;
> > @@ -572,28 +572,6 @@ static int enable_counters(void)
> >  		if (err)
> >  			return err;
> >  	}
> > -
> > -	if (stat_config.initial_delay < 0) {
> > -		pr_info(EVLIST_DISABLED_MSG);
> > -		return 0;
> > -	}
> > -
> > -	if (stat_config.initial_delay > 0) {
> > -		pr_info(EVLIST_DISABLED_MSG);
> > -		usleep(stat_config.initial_delay * USEC_PER_MSEC);
> > -	}
> > -
> > -	/*
> > -	 * We need to enable counters only if:
> > -	 * - we don't have tracee (attaching to task or cpu)
> > -	 * - we have initial delay configured
> > -	 */
> > -	if (!target__none(&target) || stat_config.initial_delay) {
> > -		if (!all_counters_use_bpf)
> > -			evlist__enable(evsel_list);
> > -		if (stat_config.initial_delay > 0)
> > -			pr_info(EVLIST_ENABLED_MSG);
> > -	}
> >  	return 0;
> >  }
> >  
> > @@ -966,10 +944,24 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >  			return err;
> >  	}
> >  
> > -	err = enable_counters();
> > +	err = enable_bpf_counters();
> >  	if (err)
> >  		return -1;
> >  
> > +	/*
> > +	 * Enable events manually here if perf-stat is run:
> > +	 * 1. with a target (any of --all-cpus, --cpu, --pid or --tid)
> > +	 * 2. without measurement delay (no --delay)
> > +	 * 3. without all events associated to BPF
> > +	 *
> > +	 * This is because if run with a target, events are not enabled
> > +	 * on exec if a workload is passed, and because there is no delay
> > +	 * we ensure to enable them before the workload starts
> > +	 */
> > +	if (!target__none(&target) && !stat_config.initial_delay &&
> > +	    !all_counters_use_bpf)
> > +		evlist__enable(evsel_list);
> > +
> >  	/* Exec the command, if any */
> >  	if (forks)
> >  		evlist__start_workload(evsel_list);
> > @@ -977,6 +969,22 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >  	t0 = rdclock();
> >  	clock_gettime(CLOCK_MONOTONIC, &ref_time);
> >  
> > +	/*
> > +	 * If a measurement delay was specified, start it, and if positive,
> > +	 * enable events manually after. We respect the delay even if all
> > +	 * events are associated to BPF
> > +	 */
> > +	if (stat_config.initial_delay) {
> > +		/* At this point, events are guaranteed disabled */
> > +		pr_info(EVLIST_DISABLED_MSG);
> > +		if (stat_config.initial_delay > 0) {
> > +			usleep(stat_config.initial_delay * USEC_PER_MSEC);
> > +			if (!all_counters_use_bpf)
> > +				evlist__enable(evsel_list);
> > +			pr_info(EVLIST_ENABLED_MSG);
> > +		}
> > +	}
> > +
> >  	if (forks) {
> >  		if (interval || timeout || evlist__ctlfd_initialized(evsel_list))
> >  			status = dispatch_events(forks, timeout, interval, &times);

-- 

- Arnaldo
