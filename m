Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED2F6F6056
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjECU5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECU5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:57:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4034283DD;
        Wed,  3 May 2023 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683147422; x=1714683422;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pg9xUSRzGA/HQgdxuqEX8JIYLlxXFCihuVeAre4i0cs=;
  b=QTKpbgEYGPjW9N2N4FzDNRMGJdC03Pqv/Jv0m0XnmB9eqM7+paCyy7JP
   BQa00U3o8AlGIJ/TjNriDKSWvV1ChWAMT5qAeJOdxq6y95n7wBT8EYDIO
   +w59nJLQ8Kh3Jxtb8cY3Qw+8eqi7tU4ktEjhZ24UuAtNbQGIxhpl8w0uP
   F6SCT7ofCs3WA4i4DAj1uqnw/3/8hC0ZfdQg5w5MhW0yBJT8YUsQAiLwF
   YBjcV3trrIGs2Q3Hp5gUSMQheLDURSplEpm5sIZfCGKr3fseoDWPtQaUu
   P6ZYCi8FAnuf32qoFqGZ6Y+DIEsl1OHhDV6esB7sPEeSS+1fXrZeReYEK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="337906277"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="337906277"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 13:56:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="820904633"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="820904633"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 03 May 2023 13:56:41 -0700
Received: from [10.209.46.175] (kliang2-mobl1.ccr.corp.intel.com [10.209.46.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D09C4580B0E;
        Wed,  3 May 2023 13:56:37 -0700 (PDT)
Message-ID: <b8f03c40-d238-2ce9-5b50-bd9e1465be23@linux.intel.com>
Date:   Wed, 3 May 2023 16:56:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 00/44] Fix perf on Intel hybrid CPUs
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
References: <20230502223851.2234828-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-02 6:38 p.m., Ian Rogers wrote:
> TL;DR: hybrid doesn't crash, json metrics work on hybrid on both PMUs
> or individually, event parsing doesn't always scan all PMUs, more and
> new tests that also run without hybrid, less code.
> 
> The first 4 patches are aimed at Linux 6.4 to address issues raised,
> in particular by Kan, on the existing perf stat behavior with json
> metrics. They avoid duplicated events by removing groups. They don't
> hide events and metrics to make event multiplexing obvious. They avoid
> terminating perf when paranoia is higher due to certain events that
> always fail. They avoid rearranging events by PMUs when the events
> aren't in a group.
> 
> The next 5 patches avoid grouping events for metrics where they could
> never succeed and were previously posted as:
> "perf vendor events intel: Add xxx metric constraints"
> https://lore.kernel.org/all/20230419005423.343862-1-irogers@google.com/
> In general the generated json is coming from:
> https://github.com/intel/perfmon/pull/73
> 
> Next are some general and test improvements.
> 
> Next event parsing is rewritten to not scan all PMUs for the benefit
> of raw and legacy cache parsing, instead these are handled by the
> lexer and a new term type. This ultimately removes the need for the
> event parser for hybrid to be recursive as legacy cache can be just a
> term. Tests are re-enabled for events with hyphens, so AMD's
> branch-brs event is now parsable.
> 
> The cputype option is made a generic pmu filter flag and is tested
> even on non-hybrid systems.
> 
> The final patches address specific json metric issues on hybrid, in
> both the json metrics and the metric code.
> 
> The patches add slightly more code than they remove, in areas like
> better json metric constraints and tests, but in the core util code,
> the removal of hybrid is a net reduction:
>  22 files changed, 711 insertions(+), 1016 deletions(-)
> 
> Sample output is contained in the v1 patch set:
> https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
> 
> Tested on Tigerlake, Skylake and Alderlake CPUs.
> 
> The v4 patch set:
>  - rebase, 1 of the Linux 6.4 recommended patches are merged leaving:
>    1) perf metric: Change divide by zero and !support events behavior
>    2) perf stat: Introduce skippable evsels
>    3) perf metric: Json flag to not group events if gathering a metric group
>    4) perf parse-events: Don't reorder ungrouped events by pmu
>    whose diffstat is:
>     30 files changed, 326 insertions(+), 33 deletions(-)
>    but without the vendor event updates (the tend to be large as they
>    repeat something per architecture per metric) is just:
>     10 files changed, 90 insertions(+), 32 deletions(-)

I have tested the 4 patches on top of the perf-tools-next branch on both
Cascade Lake and Raptor Lake. The result looks good to me.

They address the permission error found in the default mode of perf stat
on the Cascade Lake. Thanks Ian for the fix.

Arnaldo, could you please consider to back port them for the 6.4?

Thanks,
Kan
