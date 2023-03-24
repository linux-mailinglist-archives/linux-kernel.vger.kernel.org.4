Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8737B6C7DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCXMLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCXMLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:11:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C80199;
        Fri, 24 Mar 2023 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679659909; x=1711195909;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=OrmkHnEqDqvlgMUnTSJSjo/LeOztRtGPwf/gceCWb44=;
  b=Zs4UOXmvqRbCij1xhtSBSb+ixGbPQh9rNa9Q/qTzBv7/J/+H333y2hZl
   WoGbpfXCyD4LuPOfAMlDUYeBocTiHKwLxLPJEjv9s4JG0Yqc0cfoszxYc
   CIm+UqOLK1ntY1OxpvAShCGZM8VmG5SUXJaK5whTX76hStpYVlX6RijAu
   w5Pl07vleIipLQpJVsAv/w0XNNazWJsd1NqGPkTsgnchAGD7VhhPPHQnx
   1/XaEhM0Z1NPav/TwValovzfdBI5CK6QotBcywAYVG7OR6ewANj1BOXMY
   hviMBOgVwlQXVxPt32ub8m/CSYyjgef6Vk6YlmpSh5VUML3FAYadKlcLm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="319414760"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="319414760"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 05:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="751881732"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="751881732"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 24 Mar 2023 05:11:46 -0700
Received: from [10.255.231.167] (kliang2-mobl1.ccr.corp.intel.com [10.255.231.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 68AEE580BBE;
        Fri, 24 Mar 2023 05:11:44 -0700 (PDT)
Message-ID: <acb7dcae-6365-b2cb-6147-589376116df0@linux.intel.com>
Date:   Fri, 24 Mar 2023 08:11:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/9] Update Intel events and make nvdimm events dynamic
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
References: <20230324072218.181880-1-irogers@google.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230324072218.181880-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-24 3:22 a.m., Ian Rogers wrote:
> Update events from:
> https://github.com/intel/perfmon/pull/62
> 
> Add new #has_pmem literal to allow memory metrics to be dynamic in how
> nvdimm events are enabled. Update CLX, ICX and SPR for this using this
> PR:
> https://github.com/intel/perfmon/pull/63
> 
> v3. Change has_optane to has_pmem as suggested by Kan Liang and Dan Williams.
> 
> Ian Rogers (9):
>   perf vendor events: Broadwell v27 events
>   perf vendor events: Broadwellde v9 events
>   perf vendor events: Broadwellx v20 events
>   perf vendor events: Haswell v33 events
>   perf vendor events: Haswellx v27 events
>   perf vendor events: Jaketown v23 events
>   perf vendor events: Sandybridge v19 events
>   perf metrics: Add has_pmem literal
>   perf vendor events: Update metrics to detect pmem at runtime
> 


Thanks Ian. The patch series looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>  .../pmu-events/arch/x86/broadwell/cache.json  | 296 +++++-----
>  .../arch/x86/broadwell/floating-point.json    |   7 +
>  .../arch/x86/broadwell/frontend.json          |  18 +-
>  .../pmu-events/arch/x86/broadwell/memory.json | 248 ++++-----
>  .../arch/x86/broadwell/pipeline.json          |  22 +-
>  .../arch/x86/broadwell/uncore-other.json      |   2 +-
>  .../arch/x86/broadwellde/cache.json           | 105 ++--
>  .../arch/x86/broadwellde/floating-point.json  |  45 +-
>  .../arch/x86/broadwellde/frontend.json        |  18 +-
>  .../arch/x86/broadwellde/memory.json          |  64 ++-
>  .../arch/x86/broadwellde/pipeline.json        |  79 +--
>  .../arch/x86/broadwellde/uncore-cache.json    |  72 +--
>  .../arch/x86/broadwellde/uncore-memory.json   | 256 ++++++++-
>  .../arch/x86/broadwellde/uncore-other.json    |  27 +-
>  .../arch/x86/broadwellde/uncore-power.json    |  10 +-
>  .../pmu-events/arch/x86/broadwellx/cache.json |  16 +-
>  .../arch/x86/broadwellx/frontend.json         |  18 +-
>  .../arch/x86/broadwellx/pipeline.json         |  20 +-
>  .../arch/x86/broadwellx/uncore-cache.json     | 156 ++----
>  .../x86/broadwellx/uncore-interconnect.json   |  84 +--
>  .../arch/x86/broadwellx/uncore-memory.json    | 522 +++++++++---------
>  .../arch/x86/broadwellx/uncore-other.json     |  44 +-
>  .../arch/x86/broadwellx/uncore-power.json     |  10 +-
>  .../arch/x86/cascadelakex/clx-metrics.json    |  10 +-
>  .../pmu-events/arch/x86/haswell/cache.json    |  38 +-
>  .../pmu-events/arch/x86/haswell/memory.json   |  38 +-
>  .../pmu-events/arch/x86/haswell/pipeline.json |   8 +
>  .../pmu-events/arch/x86/haswellx/cache.json   |   2 +-
>  .../arch/x86/haswellx/pipeline.json           |   8 +
>  .../arch/x86/haswellx/uncore-cache.json       |  16 +-
>  .../arch/x86/haswellx/uncore-other.json       |   6 +-
>  .../arch/x86/icelakex/icx-metrics.json        |  10 +-
>  .../arch/x86/jaketown/pipeline.json           |   8 +
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |  14 +-
>  .../arch/x86/sandybridge/pipeline.json        |   8 +
>  .../arch/x86/sapphirerapids/spr-metrics.json  |  10 +-
>  tools/perf/util/expr.c                        |  19 +
>  37 files changed, 1323 insertions(+), 1011 deletions(-)
> 
