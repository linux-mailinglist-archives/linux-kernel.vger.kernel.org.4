Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CCB6F21E9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347220AbjD2BRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjD2BRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:17:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E226A2;
        Fri, 28 Apr 2023 18:17:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7836D62DA9;
        Sat, 29 Apr 2023 01:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED16C433D2;
        Sat, 29 Apr 2023 01:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682731030;
        bh=O25C2lf3JDsYzim7XaruprOx13noBC1kpWMv0pf/5hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7TiSeB52VMbWxv6Q/ov1aH+L66g7MhYnJGg7IsEHqrG2pRd9rs6692XATOQRJfXx
         f6EDpvD3Kefj+XN4/PaSYr/WiJFe58xiBLRDY75CnHBTbE+cJmjv5Q+XkornnKFpu+
         uq8jQHycOHbSoreFogGlbVygmKYpGIN+O81UBJla732JiAujXBcMEASU9Bf1cjg/po
         EskcpMdFDiSgcQzulhRC54ZjUofgsUki8PTW3HRFbd3rBpvCYN3EiYljNgtzXr9Oo+
         DDAuPnIS8QYiH7+SLVkPCzX3+kFbST+E+GCliylhQyZQgNTgkyoByQLG4rJruQoDtN
         8hB+fdpQruGSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1BEFC403B5; Fri, 28 Apr 2023 22:17:08 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:17:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/43] perf stat: Disable TopdownL1 on hybrid
Message-ID: <ZExwFLSMGpFuqIPo@kernel.org>
References: <20230428073809.1803624-1-irogers@google.com>
 <20230428073809.1803624-2-irogers@google.com>
 <920c682a-3789-51fb-805e-4561c85f4219@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <920c682a-3789-51fb-805e-4561c85f4219@linux.intel.com>
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

Em Fri, Apr 28, 2023 at 09:31:30AM -0400, Liang, Kan escreveu:
> 
> 
> On 2023-04-28 3:37 a.m., Ian Rogers wrote:
> > Bugs with event parsing, event grouping and metrics causes the
> > TopdownL1 metricgroup to crash the perf command. Temporarily disable
> > the group if no events/metrics are spcecified.
> > 
> 
> I think it's OK to only disable the metric for perf stat default
> temporarily on hybrid as a workaround for 6.4.
> Now, the only problem is the default of perf stat on pre-icl in 6.4.
> 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Arnaldo, could you please back port this for 6.4 as well?

Sure, picking this one now
 
> Thanks,
> Kan
> > ---
> >  tools/perf/builtin-stat.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index efda63f6bf32..be9677aa642f 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1885,7 +1885,12 @@ static int add_default_attributes(void)
> >  		 * Add TopdownL1 metrics if they exist. To minimize
> >  		 * multiplexing, don't request threshold computation.
> >  		 */
> > -		if (metricgroup__has_metric("TopdownL1") &&
> > +		/*
> > +		 * TODO: TopdownL1 is disabled on hybrid CPUs to avoid a crashes
> > +		 * caused by exposing latent bugs. This is fixed properly in:
> > +		 * https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
> > +		 */
> > +		if (metricgroup__has_metric("TopdownL1") && !perf_pmu__has_hybrid() &&
> >  		    metricgroup__parse_groups(evsel_list, "TopdownL1",
> >  					    /*metric_no_group=*/false,
> >  					    /*metric_no_merge=*/false,
> > @@ -1894,6 +1899,7 @@ static int add_default_attributes(void)
> >  					    stat_config.system_wide,
> >  					    &stat_config.metric_events) < 0)
> >  			return -1;
> > +
> >  		/* Platform specific attrs */
> >  		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
> >  			return -1;

-- 

- Arnaldo
