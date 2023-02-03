Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECF9689BF6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjBCOgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjBCOgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:36:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066E83FA;
        Fri,  3 Feb 2023 06:36:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F19C61F48;
        Fri,  3 Feb 2023 14:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7245C433EF;
        Fri,  3 Feb 2023 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675434993;
        bh=28utDxiV3Rp5JUpEe2sC6Dt8bzeVHrv1nst7Z5amXrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/VQIdSD73xW8QY8ihx6OdRO2O4L+7xe6S5V7LFKkPxC5QMnyGa/aLQKyZQH0h3bi
         MwXvNHi/b+5oIX0kPZRlqKQPLeIzCnXFdBE2WnJpvgCZVJO1p1F8AQuptvZFr0mQ/j
         /pUmyNxxajhvQkINPwuPjAu/iDajZyxFQtuFzfbSbKns7rQ013mQFNY03Pj1wMWSeM
         gc/RVbiV24j87vku/8r7nYcdhVEIATMi8DQ0hhcjmnO/HaPOPDRiaVYz1dVvszajJY
         UU++TKmpzJaRJdUmUb22vBMWPFw2obXsKuU5Xn1W6vaxkDiUlt/4q5E3Mwuw/DawkC
         yRsrJ9Iwz2g5g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BCBC4405BE; Fri,  3 Feb 2023 11:36:30 -0300 (-03)
Date:   Fri, 3 Feb 2023 11:36:30 -0300
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
Message-ID: <Y90b7shHtOCQL3ma@kernel.org>
References: <20230203014014.75720-1-irogers@google.com>
 <CAP-5=fX0ohsCUspm7NowDy2bmSr2cJfp=iaStK4EAdVy7zBHGA@mail.gmail.com>
 <Y90XgtX9uv26UAQa@kernel.org>
 <Y90bsM4DGL+WV8m0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y90bsM4DGL+WV8m0@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 03, 2023 at 11:35:29AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 03, 2023 at 11:17:38AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Feb 02, 2023 at 05:41:22PM -0800, Ian Rogers escreveu:
> > > On Thu, Feb 2, 2023 at 5:40 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > ARM64 overrides a weak function but a previous change had broken the
> > > > build.
> > > >
> > > > Fixes: 8cefeb8bd336 ("perf pmu-events: Introduce pmu_metrics_table")
> > > 
> > > As 8cefeb8bd336 ("perf pmu-events: Introduce pmu_metrics_table") is
> > > only on tmp.perf/core then it may be best to just squash this fix into
> > > that.
> > 
> > Yeah, that was my intention, I'll fold it there to keep bisection,
> > thanks for fixing it so fast, I'll double check on my rk3399 board and
> > on again on the cross-build container.
> 
> Nope, that is not what I reported yesterday, trying to build it on the
> rk3399 board:

Sorry, pulled the trigger too soon, this is _before_ applying your fix,
I should't multitask too much :-\

I'll double check now, 

- Arnaldo
