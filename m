Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E33689C14
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjBCOnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCOnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:43:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5DA79F30;
        Fri,  3 Feb 2023 06:43:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7695B829B9;
        Fri,  3 Feb 2023 14:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AECC433EF;
        Fri,  3 Feb 2023 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675435406;
        bh=OK/0v0S2oRpvThJ+ETGusIsaKx+GkR617f/EkmDsJDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sMu1n2cWnUK0wSXdleTQOxzAEKesZkvKvIeSXACETbSggy3BkxgSmITZbKfSZibTF
         4CXlDS3xTV94Nl0u/9mn3RTFtBVi7iPSiU9g635a4nchfabmTfhu2HJ0k9oqMOk3as
         8BQDrMWvG+AKAfq/gUiFIAhtIC4T3nwz0UGtLpk96rDxg+UT/P+aKV8f2sQvbrQq74
         3/kFwFXgf55wQDpO4OfLgw85SuOf5o3F5E9pgcKpvRlnJkG6xrCKvfVgLrKf8K/Us6
         78Lg1TxqgyGmtkE0XZ6z08oNOzp/ebes7jm3l2qiNsF96o+54on5neZPYPMmqTtm4c
         yNa2D86AXkjwQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EC9CB405BE; Fri,  3 Feb 2023 11:43:23 -0300 (-03)
Date:   Fri, 3 Feb 2023 11:43:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [PATCH v1] perf pmu: Fix aarch64 build
Message-ID: <Y90di+N7TODkFvMV@kernel.org>
References: <20230203014014.75720-1-irogers@google.com>
 <CAP-5=fX0ohsCUspm7NowDy2bmSr2cJfp=iaStK4EAdVy7zBHGA@mail.gmail.com>
 <Y90XgtX9uv26UAQa@kernel.org>
 <Y90bsM4DGL+WV8m0@kernel.org>
 <Y90b7shHtOCQL3ma@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y90b7shHtOCQL3ma@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 03, 2023 at 11:36:30AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 03, 2023 at 11:35:29AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Feb 03, 2023 at 11:17:38AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Feb 02, 2023 at 05:41:22PM -0800, Ian Rogers escreveu:
> > > > On Thu, Feb 2, 2023 at 5:40 PM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > ARM64 overrides a weak function but a previous change had broken the
> > > > > build.
> > > > >
> > > > > Fixes: 8cefeb8bd336 ("perf pmu-events: Introduce pmu_metrics_table")
> > > > 
> > > > As 8cefeb8bd336 ("perf pmu-events: Introduce pmu_metrics_table") is
> > > > only on tmp.perf/core then it may be best to just squash this fix into
> > > > that.
> > > 
> > > Yeah, that was my intention, I'll fold it there to keep bisection,
> > > thanks for fixing it so fast, I'll double check on my rk3399 board and
> > > on again on the cross-build container.
> > 
> > Nope, that is not what I reported yesterday, trying to build it on the
> > rk3399 board:
> 
> Sorry, pulled the trigger too soon, this is _before_ applying your fix,
> I should't multitask too much :-\
> 
> I'll double check now, 

Ok, now it is exploding at:

pmu-events/pmu-events.c: In function ‘decompress’:
pmu-events/pmu-events.c:3598:11: error: ‘struct pmu_event’ has no member named ‘metric_name’
 3598 |         pe->metric_name = (*p == '\0' ? NULL : p);
      |           ^~
pmu-events/pmu-events.c:3600:11: error: ‘struct pmu_event’ has no member named ‘metric_group’
 3600 |         pe->metric_group = (*p == '\0' ? NULL : p);
      |           ^~
pmu-events/pmu-events.c:3614:11: error: ‘struct pmu_event’ has no member named ‘metric_constraint’
 3614 |         pe->metric_constraint = (*p == '\0' ? NULL : p);
      |           ^~
pmu-events/pmu-events.c:3616:11: error: ‘struct pmu_event’ has no member named ‘metric_expr’
 3616 |         pe->metric_expr = (*p == '\0' ? NULL : p);
      |           ^~
pmu-events/pmu-events.c: At top level:
pmu-events/pmu-events.c:3637:32: error: no previous prototype for ‘perf_pmu__find_table’ [-Werror=missing-prototypes]
 3637 | const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu)
      |                                ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:98: /tmp/build/perf/pmu-events/pmu-events.o] Error 1
make[2]: *** [Makefile.perf:676: /tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf/builtin-ftrace.o

