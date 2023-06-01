Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4BE71F0ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjFARjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjFARjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:39:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00B189;
        Thu,  1 Jun 2023 10:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EF7564863;
        Thu,  1 Jun 2023 17:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B8AC433D2;
        Thu,  1 Jun 2023 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685641145;
        bh=y9bqKEJBVo66+k1yGNlCIyUnSWKH4ZnijIpz+KHfwQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWDgCrdvgwOPqj/mJRdtMAeae3bcVmNrTuuBrn/aSckfBbo/MZFP0Dj/TnuxybXzD
         E7gdOrMoRl7FuB4VopBfg3utefYigrfiNHNKNE4eu4vKDaMemQxeyGHzyqORitj/AZ
         baxFXHR0N83tnuCqRH9q/zipAwD7netcnPhstyJxjQWJHJa4V+jqC/V5OucpYViDWU
         oGj14DYx1VysMJyBShE+F3lrcjMafg3yUbsf19y2n0sWHcdOcCU8riKXYq8PeAFCwT
         7553CmVsm9MehIrDp6+4WEa0svqTBAy9ugo9KHKZlDao6+GDYAC4YMMj4KpyMe0hlG
         8uH0S+yqNiHLg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9635640692; Thu,  1 Jun 2023 14:39:02 -0300 (-03)
Date:   Thu, 1 Jun 2023 14:39:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH v2 0/4] Hybrid event parsing fixes
Message-ID: <ZHjXttVpQE6nUy8s@kernel.org>
References: <20230601082954.754318-1-irogers@google.com>
 <07b1f8d9-3839-81cd-0c46-3742f6273901@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b1f8d9-3839-81cd-0c46-3742f6273901@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 01, 2023 at 09:59:20AM -0400, Liang, Kan escreveu:
> 
> 
> On 2023-06-01 4:29 a.m., Ian Rogers wrote:
> > Correct various issues that have come up in mailing list discussions,
> > the most impactful of which is the wildcard opening of events of type
> > PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE. But also try to avoid a
> > parse-error without a warning, have more fall-back behaviors and be
> > liberal with the definition of software events.
> > 
> > The majority of the change is in correcting the parse-event test to
> > match the new hybrid parsing.
> > 
> > Ian Rogers (4):
> >   perf pmu: Correct perf_pmu__auto_merge_stats affecting hybrid
> >   perf evsel: Add verbose 3 print of evsel name when opening
> >   perf parse-events: Wildcard most "numeric" events
> >   perf test: Update parse-events expectations
> 
> The patch set fixes the issues I found on a hybrid machine.
> 
> Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo

 
> It's better to fold the examples (especially for the patch 1) in the
> description. So we can understand what's it trying to fix and what's the
> expected result now.
> 
> Thanks,
> Kan
> 
> > 
> >  tools/perf/tests/parse-events.c | 1108 ++++++++++++++++---------------
> >  tools/perf/util/evsel.c         |    1 +
> >  tools/perf/util/parse-events.c  |  104 ++-
> >  tools/perf/util/parse-events.y  |   10 +-
> >  tools/perf/util/pmu.c           |   18 +-
> >  tools/perf/util/pmu.h           |    5 +
> >  tools/perf/util/pmus.c          |    5 +
> >  tools/perf/util/pmus.h          |    1 +
> >  8 files changed, 698 insertions(+), 554 deletions(-)
> > 

-- 

- Arnaldo
