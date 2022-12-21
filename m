Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463D2653484
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiLURD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiLURDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:03:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B5D140B0;
        Wed, 21 Dec 2022 09:03:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26644B81BE1;
        Wed, 21 Dec 2022 17:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A860DC433EF;
        Wed, 21 Dec 2022 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671642192;
        bh=U7EE+wRsWxkI1lNUdsnqBHX8mCVM3dbk+Yz0Z/0wCrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGMWvSAq73CLEixLFovtAjbFETQX2yCTBsBV8+d6f6Slk20iEbKyPCFlnjI9H6ckl
         hwO4a5yILIwaTSmMVw5T27tIz++nOECXr+94i/+HzKPwSuJKBPt7wySEObPLuoy+yV
         b+rlZ1pxDjbDVXZux++DsNvTshgJOdePGT3f4SzxSbMb6z9RgNqlZhApgrZrYAVxty
         5qgN6mhq/zc995ICnrQQs5P5aLdtoaC57CtO0e4ZfkpxgcQE9mmG28h9lxPL1g5px2
         RwSybQzP6E7hO8XLjTs/lldn0AC2yaDqZlaFxG6jHgn9KpXjoGThtEJ53HhUNybdkV
         ybQ6QBQJ39m+Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CB12940367; Wed, 21 Dec 2022 14:03:09 -0300 (-03)
Date:   Wed, 21 Dec 2022 14:03:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Sandipan Das <sandipan.das@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com, jhladky@redhat.com,
        ravi.bangoria@amd.com, ananth.narayan@amd.com
Subject: Re: [PATCH v2 0/4] perf vendor events amd: Add Zen 4 events and
 metrics
Message-ID: <Y6M8TeUR73AB+TKP@kernel.org>
References: <20221214082652.419965-1-sandipan.das@amd.com>
 <CAP-5=fWm55y6LdZozX=LuLZhk+SWm_yi5tLcKgT_UJt9FETNPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWm55y6LdZozX=LuLZhk+SWm_yi5tLcKgT_UJt9FETNPQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 14, 2022 at 07:59:01AM -0800, Ian Rogers escreveu:
> On Wed, Dec 14, 2022 at 12:27 AM Sandipan Das <sandipan.das@amd.com> wrote:
> >
> > Add events and metrics taken from the Processor Programming Reference
> > (PPR) for AMD Family 19h Model 11h Revision B1 processors which can be
> > found at: https://www.amd.com/system/files/TechDocs/55901_0.25.zip
> >
> > Previous versions can be found at:
> > v1: https://lore.kernel.org/all/20221207053007.336806-1-sandipan.das@amd.com/
> >
> > Changes in v2:
> > - Remove "bytes" from the names of data fabric bandwidth metrics which
> >   use a scale unit.
> > - Use better group names for pipeline utilization metrics.
> > - Move patch that adds family-model mapping to the end of the series for
> >   avoiding potential build issues.
> >
> > Sandipan Das (4):
> >   perf vendor events amd: Add Zen 4 core events
> >   perf vendor events amd: Add Zen 4 uncore events
> >   perf vendor events amd: Add Zen 4 metrics
> >   perf vendor events amd: Add Zen 4 mapping
> 
> Series: Acked-by: Ian Rogers <irogers@google.com>

Please add the Acked-by:  on a separate line, like

Series:
Acked-by: Ian Rogers <irogers@google.com>

To avoid confusing b4

Thanks,

- Arnaldo
 
> Thanks,
> Ian
> 
> >  .../pmu-events/arch/x86/amdzen4/branch.json   |   82 ++
> >  .../pmu-events/arch/x86/amdzen4/cache.json    |  772 ++++++++++++
> >  .../pmu-events/arch/x86/amdzen4/core.json     |  122 ++
> >  .../arch/x86/amdzen4/data-fabric.json         | 1090 +++++++++++++++++
> >  .../arch/x86/amdzen4/floating-point.json      |  818 +++++++++++++
> >  .../pmu-events/arch/x86/amdzen4/memory.json   |  174 +++
> >  .../pmu-events/arch/x86/amdzen4/other.json    |  138 +++
> >  .../pmu-events/arch/x86/amdzen4/pipeline.json |   98 ++
> >  .../arch/x86/amdzen4/recommended.json         |  334 +++++
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |    3 +-
> >  10 files changed, 3630 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/branch.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/cache.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/core.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/data-fabric.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/floating-point.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/other.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
> >
> > --
> > 2.34.1
> >

-- 

- Arnaldo
