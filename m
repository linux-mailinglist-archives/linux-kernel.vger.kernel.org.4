Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0556F719FC8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjFAOYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjFAOYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:24:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FC9FC;
        Thu,  1 Jun 2023 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629473; x=1717165473;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=a21Bq6Sjdj/JyHm5wqh7wSxYryZ6wTGMMTZyPDza/H0=;
  b=ZRT4MmXgrOQq00M4+jDLZSN/7Perlirff+D3NVT8ZIGlsA7k6b+ciLRk
   5R2hU2FOLr2cBgpVzagK8oCHJXcSi4X/PA1ikbIAewsQqnd4rrGGzoOJO
   hMoQvnEHNMc8/kTS73hNnXUE0tLHsqOCFkscBhBHBqNF/8dbpIsN16z/5
   Erl96iJazSzDwKzVYkTGJquE3jygkSOFPpCQf0p5t+S0ay9vqEVT57Sp/
   EGIPUDxrdhSyEiWBfORr0CafBTUf5qG17SbLCxiw17UCtH/VjL7uqTAk3
   FboopAo4kOhgBqaN0PRsBgwBVTac5INMujH6rIKYtVSMUXXEvF/GLzxmI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421369369"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421369369"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="797156201"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="797156201"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jun 2023 06:59:23 -0700
Received: from [10.212.129.33] (kliang2-mobl1.ccr.corp.intel.com [10.212.129.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EC418580BF6;
        Thu,  1 Jun 2023 06:59:21 -0700 (PDT)
Message-ID: <07b1f8d9-3839-81cd-0c46-3742f6273901@linux.intel.com>
Date:   Thu, 1 Jun 2023 09:59:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 0/4] Hybrid event parsing fixes
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
References: <20230601082954.754318-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230601082954.754318-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-01 4:29 a.m., Ian Rogers wrote:
> Correct various issues that have come up in mailing list discussions,
> the most impactful of which is the wildcard opening of events of type
> PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE. But also try to avoid a
> parse-error without a warning, have more fall-back behaviors and be
> liberal with the definition of software events.
> 
> The majority of the change is in correcting the parse-event test to
> match the new hybrid parsing.
> 
> Ian Rogers (4):
>   perf pmu: Correct perf_pmu__auto_merge_stats affecting hybrid
>   perf evsel: Add verbose 3 print of evsel name when opening
>   perf parse-events: Wildcard most "numeric" events
>   perf test: Update parse-events expectations

The patch set fixes the issues I found on a hybrid machine.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

It's better to fold the examples (especially for the patch 1) in the
description. So we can understand what's it trying to fix and what's the
expected result now.

Thanks,
Kan

> 
>  tools/perf/tests/parse-events.c | 1108 ++++++++++++++++---------------
>  tools/perf/util/evsel.c         |    1 +
>  tools/perf/util/parse-events.c  |  104 ++-
>  tools/perf/util/parse-events.y  |   10 +-
>  tools/perf/util/pmu.c           |   18 +-
>  tools/perf/util/pmu.h           |    5 +
>  tools/perf/util/pmus.c          |    5 +
>  tools/perf/util/pmus.h          |    1 +
>  8 files changed, 698 insertions(+), 554 deletions(-)
> 
