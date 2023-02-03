Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20D689E7E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjBCPn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjBCPny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:43:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1D1991C9;
        Fri,  3 Feb 2023 07:43:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 832D461F78;
        Fri,  3 Feb 2023 15:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D950C433D2;
        Fri,  3 Feb 2023 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675439031;
        bh=QzHwbvdzJR6mErN/zIzcOVMcsP1F30dlSQclZPv72B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UbbF0xAiNC89xQ5+9sm34iQzWVPMfZowuzZgFzPT78pXxWNr3UFbXVVm5h1k7/keE
         P7OTOFCzKnTTDat8F/503u13jEbmpfO+tQ6wrCAFGmPvc1rg4YULTP1EGhSyPDPzAl
         3DwuvvXHuNYiY89ygTOx8ZOF9A0RcDozTJd6TYPBEYk4QTrObN33bDKP4MBEy0UjSg
         0PSggRFRKSNjTasaEZjN9qt8dIbOR91ty9xFG911bVUyH5jmIAvhxs9pYH5FENsVgF
         2iIWuZ2SCvgulp0GRkV+bqS0gOBwEqvnalCjQRTyMsx2g+G8m/V2TidcSjigpGKEh4
         6JSDIghYRoOqQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B472405BE; Fri,  3 Feb 2023 12:43:48 -0300 (-03)
Date:   Fri, 3 Feb 2023 12:43:48 -0300
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
Message-ID: <Y90rtA95mWW5Othk@kernel.org>
References: <20230203014014.75720-1-irogers@google.com>
 <CAP-5=fX0ohsCUspm7NowDy2bmSr2cJfp=iaStK4EAdVy7zBHGA@mail.gmail.com>
 <Y90XgtX9uv26UAQa@kernel.org>
 <Y90bsM4DGL+WV8m0@kernel.org>
 <Y90b7shHtOCQL3ma@kernel.org>
 <Y90di+N7TODkFvMV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y90di+N7TODkFvMV@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 03, 2023 at 11:43:23AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 03, 2023 at 11:36:30AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Feb 03, 2023 at 11:35:29AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Feb 03, 2023 at 11:17:38AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Thu, Feb 02, 2023 at 05:41:22PM -0800, Ian Rogers escreveu:
> > > > > On Thu, Feb 2, 2023 at 5:40 PM Ian Rogers <irogers@google.com> wrote:
> > > > > >
> > > > > > ARM64 overrides a weak function but a previous change had broken the
> > > > > > build.
> > > > > >
> > > > > > Fixes: 8cefeb8bd336 ("perf pmu-events: Introduce pmu_metrics_table")
> > > > > 
> > > > > As 8cefeb8bd336 ("perf pmu-events: Introduce pmu_metrics_table") is
> > > > > only on tmp.perf/core then it may be best to just squash this fix into
> > > > > that.
> > > > 
> > > > Yeah, that was my intention, I'll fold it there to keep bisection,
> > > > thanks for fixing it so fast, I'll double check on my rk3399 board and
> > > > on again on the cross-build container.
> > > 
> > > Nope, that is not what I reported yesterday, trying to build it on the
> > > rk3399 board:
> > 
> > Sorry, pulled the trigger too soon, this is _before_ applying your fix,
> > I should't multitask too much :-\
> > 
> > I'll double check now, 
> 
> Ok, now it is exploding at:
> 
> pmu-events/pmu-events.c: In function ‘decompress’:
> pmu-events/pmu-events.c:3598:11: error: ‘struct pmu_event’ has no member named ‘metric_name’
>  3598 |         pe->metric_name = (*p == '\0' ? NULL : p);
>       |           ^~
> pmu-events/pmu-events.c:3600:11: error: ‘struct pmu_event’ has no member named ‘metric_group’
>  3600 |         pe->metric_group = (*p == '\0' ? NULL : p);
>       |           ^~
> pmu-events/pmu-events.c:3614:11: error: ‘struct pmu_event’ has no member named ‘metric_constraint’
>  3614 |         pe->metric_constraint = (*p == '\0' ? NULL : p);
>       |           ^~
> pmu-events/pmu-events.c:3616:11: error: ‘struct pmu_event’ has no member named ‘metric_expr’
>  3616 |         pe->metric_expr = (*p == '\0' ? NULL : p);
>       |           ^~
> pmu-events/pmu-events.c: At top level:
> pmu-events/pmu-events.c:3637:32: error: no previous prototype for ‘perf_pmu__find_table’ [-Werror=missing-prototypes]
>  3637 | const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu)
>       |                                ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:98: /tmp/build/perf/pmu-events/pmu-events.o] Error 1
> make[2]: *** [Makefile.perf:676: /tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      /tmp/build/perf/builtin-ftrace.o

I tried bisecting, but at this cset:

acme@roc-rk3399-pc:~/git/perf$ git log --oneline -1
d22e569cd33d (HEAD) perf pmu-events: Separate the metrics from events for no jevents
acme@roc-rk3399-pc:~/git/perf$

I'm getting this:

  CC      /tmp/build/perf/pmu-events/pmu-events.o
pmu-events/pmu-events.c:3637:32: error: no previous prototype for ‘perf_pmu__find_table’ [-Werror=missing-prototypes]
 3637 | const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu)
      |                                ^~~~~~~~~~~~~~~~~~~~
  CC      /tmp/build/perf/builtin-ftrace.o
  CC      /tmp/build/perf/builtin-help.o
  CC      /tmp/build/perf/builtin-buildid-list.o
cc1: all warnings being treated as errors
make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:97: /tmp/build/perf/pmu-events/pmu-events.o] Error 1
make[2]: *** [Makefile.perf:676: /tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf/builtin-buildid-cache.o

<SNIP>

  CC      /tmp/build/perf/tests/attr.o
arch/arm64/util/pmu.c: In function ‘pmu_events_table__find’:
arch/arm64/util/pmu.c:35:24: error: implicit declaration of function ‘perf_pmu__find_table’; did you mean ‘perf_pmu__find_by_type’? [-Werror=implicit-function-declaration]
   35 |                 return perf_pmu__find_table(pmu);
      |                        ^~~~~~~~~~~~~~~~~~~~
      |                        perf_pmu__find_by_type
arch/arm64/util/pmu.c:35:24: error: returning ‘int’ from a function with return type ‘const struct pmu_events_table *’ makes pointer from integer without a cast [-Werror=int-conversion]
   35 |                 return perf_pmu__find_table(pmu);
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/acme/git/perf/tools/build/Makefile.build:97: /tmp/build/perf/arch/arm64/util/pmu.o] Error 1
make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: arm64] Error 2
make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: arch] Error 2
make[3]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf/tests/vmlinux-kallsyms.o

-----

I'm building with:


acme@roc-rk3399-pc:~/git/perf$ alias m
alias m='make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin && git status && perf test python'
acme@roc-rk3399-pc:~/git/perf$ rm -rf /tmp/build/$(basename $(pwd)) ; mkdir -p /tmp/build/$(basename $(pwd)) ; m


To then go back to:

> pmu-events/pmu-events.c:3616:11: error: ‘struct pmu_event’ has no member named ‘metric_expr’

