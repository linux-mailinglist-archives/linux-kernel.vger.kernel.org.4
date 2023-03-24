Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1716C867B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjCXUCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjCXUCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7F1BDA;
        Fri, 24 Mar 2023 13:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D47B862AD3;
        Fri, 24 Mar 2023 20:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1285FC433AC;
        Fri, 24 Mar 2023 20:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679688165;
        bh=o9LNgpUkQU5GtCzGEcr91MhmkAC63XUJuAMUwjp/kp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RybertnxI51al/qFxNaY1jGjocQVObF4Abyb2mNrbas/YXOmzZEW5l8Nt0yZgDBPl
         zjZZ0TUmPJhUG7wxu6zol09zNPXtig4p69kCFoH2hO5Cez90O2/ry2AL8wOdPrA9nL
         F6Q7Z407WfOK+up8cwCQATBn4m3w8zc2f/X28dMRt1JZsAuLLlNirZncC9GhUcECRO
         MCMM/vsc+HbGgyL4GgbZXl3eUGCzHrflv2Z/i67DVg3r68e+9Y3yQSEYt8yggLu7jy
         +gmj0LoLwu3SXISKeGMlZY47pM5c+e5Gj9UYoneUt/wXKN4u/0fWk4d9UUeOBOiuOC
         Ijhk0oWSFt88Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 904F04052D; Fri, 24 Mar 2023 17:02:42 -0300 (-03)
Date:   Fri, 24 Mar 2023 17:02:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        samantha.alt@intel.com, weilin.wang@intel.com
Subject: Re: [PATCH v3 0/9] Update Intel events and make nvdimm events dynamic
Message-ID: <ZB4B4kD5t77T/E5T@kernel.org>
References: <20230324072218.181880-1-irogers@google.com>
 <acb7dcae-6365-b2cb-6147-589376116df0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acb7dcae-6365-b2cb-6147-589376116df0@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 24, 2023 at 08:11:44AM -0400, Liang, Kan escreveu:
> 
> 
> On 2023-03-24 3:22 a.m., Ian Rogers wrote:
> > Update events from:
> > https://github.com/intel/perfmon/pull/62
> > 
> > Add new #has_pmem literal to allow memory metrics to be dynamic in how
> > nvdimm events are enabled. Update CLX, ICX and SPR for this using this
> > PR:
> > https://github.com/intel/perfmon/pull/63
> > 
> > v3. Change has_optane to has_pmem as suggested by Kan Liang and Dan Williams.
> > 
> > Ian Rogers (9):
> >   perf vendor events: Broadwell v27 events
> >   perf vendor events: Broadwellde v9 events
> >   perf vendor events: Broadwellx v20 events
> >   perf vendor events: Haswell v33 events
> >   perf vendor events: Haswellx v27 events
> >   perf vendor events: Jaketown v23 events
> >   perf vendor events: Sandybridge v19 events
> >   perf metrics: Add has_pmem literal
> >   perf vendor events: Update metrics to detect pmem at runtime
> > 
> 
> 
> Thanks Ian. The patch series looks good to me.
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo

> 
> Thanks,
> Kan
> 
> >  .../pmu-events/arch/x86/broadwell/cache.json  | 296 +++++-----
> >  .../arch/x86/broadwell/floating-point.json    |   7 +
> >  .../arch/x86/broadwell/frontend.json          |  18 +-
> >  .../pmu-events/arch/x86/broadwell/memory.json | 248 ++++-----
> >  .../arch/x86/broadwell/pipeline.json          |  22 +-
> >  .../arch/x86/broadwell/uncore-other.json      |   2 +-
> >  .../arch/x86/broadwellde/cache.json           | 105 ++--
> >  .../arch/x86/broadwellde/floating-point.json  |  45 +-
> >  .../arch/x86/broadwellde/frontend.json        |  18 +-
> >  .../arch/x86/broadwellde/memory.json          |  64 ++-
> >  .../arch/x86/broadwellde/pipeline.json        |  79 +--
> >  .../arch/x86/broadwellde/uncore-cache.json    |  72 +--
> >  .../arch/x86/broadwellde/uncore-memory.json   | 256 ++++++++-
> >  .../arch/x86/broadwellde/uncore-other.json    |  27 +-
> >  .../arch/x86/broadwellde/uncore-power.json    |  10 +-
> >  .../pmu-events/arch/x86/broadwellx/cache.json |  16 +-
> >  .../arch/x86/broadwellx/frontend.json         |  18 +-
> >  .../arch/x86/broadwellx/pipeline.json         |  20 +-
> >  .../arch/x86/broadwellx/uncore-cache.json     | 156 ++----
> >  .../x86/broadwellx/uncore-interconnect.json   |  84 +--
> >  .../arch/x86/broadwellx/uncore-memory.json    | 522 +++++++++---------
> >  .../arch/x86/broadwellx/uncore-other.json     |  44 +-
> >  .../arch/x86/broadwellx/uncore-power.json     |  10 +-
> >  .../arch/x86/cascadelakex/clx-metrics.json    |  10 +-
> >  .../pmu-events/arch/x86/haswell/cache.json    |  38 +-
> >  .../pmu-events/arch/x86/haswell/memory.json   |  38 +-
> >  .../pmu-events/arch/x86/haswell/pipeline.json |   8 +
> >  .../pmu-events/arch/x86/haswellx/cache.json   |   2 +-
> >  .../arch/x86/haswellx/pipeline.json           |   8 +
> >  .../arch/x86/haswellx/uncore-cache.json       |  16 +-
> >  .../arch/x86/haswellx/uncore-other.json       |   6 +-
> >  .../arch/x86/icelakex/icx-metrics.json        |  10 +-
> >  .../arch/x86/jaketown/pipeline.json           |   8 +
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |  14 +-
> >  .../arch/x86/sandybridge/pipeline.json        |   8 +
> >  .../arch/x86/sapphirerapids/spr-metrics.json  |  10 +-
> >  tools/perf/util/expr.c                        |  19 +
> >  37 files changed, 1323 insertions(+), 1011 deletions(-)
> > 

-- 

- Arnaldo
