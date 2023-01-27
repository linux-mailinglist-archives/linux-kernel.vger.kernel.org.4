Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFB367DE71
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjA0HWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjA0HWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:22:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E740E4F86D;
        Thu, 26 Jan 2023 23:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674804153; x=1706340153;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1eorRSMffSeomkyqosY3JnKoG42HN4ninV9IzSPav20=;
  b=DAojCyNvxxGMKi05I4V+C9MkGcc3VT9a3KX7C6WvYbublM3zXzzqoLGW
   F+LrD7NSB+tm5uHoGZwafXDmTB88cJqRwVm5lT6oXe1yGuny29cOT4QFP
   YKTLe8iTcYZ3fgaJqhKq2kvPlZ5lA8FLodSilJaeQRBpB1fCUgRBXsy6R
   PigZ2GaVQisBP9mAGm/OU+ifS4Gpw04HSFyUP13OEMVHDqoCqCB3my6Sr
   /z8lBiag/j3DOuEZIxJafjA1lBXMsml2UcgN7Amnc9h9/WShE8DRGr/1e
   tPtcrUwuHYPJrcKSD6llG8WKeLOVJ9/ulBaNk0GIDn1w2pi9DlQR4DqDF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="324728461"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="324728461"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 23:22:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="726602682"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="726602682"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.57.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 23:22:16 -0800
Message-ID: <bda606c2-2b1b-de9f-1386-8ee2bf925b4b@intel.com>
Date:   Fri, 27 Jan 2023 09:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v1)
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>
References: <20230127001951.3432374-1-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230127001951.3432374-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/23 02:19, Namhyung Kim wrote:
> Hello,
> 
> I found some problems in Intel-PT and auxtrace in general with pipe.
> In the past it used to work with pipe, but recent code fails.

Pipe mode is a problem for Intel PT and possibly other auxtrace users.
Essentially the auxtrace buffers do not behave like the regular perf
event buffers.  That is because the head and tail are updated by
software, but in the auxtrace case the data is written by hardware.
So the head and tail do not get updated as data is written.  In the
Intel PT case, the head and tail are updated only when the trace is
disabled by software, for example:
    - full-trace, system wide : when buffer passes watermark
    - full-trace, not system-wide : when buffer passes watermark or
    context switches
    - snapshot mode : as above but also when a snapshot is made
    - sample mode : as above but also when a sample is made

That means finished-round ordering doesn't work.  An auxtrace buffer
can turn up that has data that extends back in time, possibly to the
very beginning of tracing.

For a perf.data file, that problem is solved by going through the trace
and queuing up the auxtrace buffers in advance.

For pipe mode, the order of events and timestamps can presumably
be messed up.

For Intel PT, it is a bit of a surprise that there is not 
validation to error out in pipe mode.

At the least, a warning is needed, and the above explanation needs
to be added to the documentation.

>                                                                As it
> also touches the generic code, other auxtrace users like ARM SPE will
> be affected too.  I added a test case to verify it works with pipes.
> 
> At last, I can run this command without a problem.
> 
>   $ perf record -o- -e intel_pt// true | perf inject -b | perf report -i- --itrace=i1000
> 
> The code is available at 'perf/auxtrace-pipe-v1' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> Namhyung Kim (4):
>   perf inject: Use perf_data__read() for auxtrace
>   perf intel-pt: Do not try to queue auxtrace data on pipe
>   perf session: Avoid calling lseek(2) for pipe
>   perf test: Add pipe mode test to the Intel PT test suite
> 
>  tools/perf/builtin-inject.c             |  6 +++---
>  tools/perf/tests/shell/test_intel_pt.sh | 17 +++++++++++++++++
>  tools/perf/util/auxtrace.c              |  3 +++
>  tools/perf/util/session.c               |  9 +++++++--
>  4 files changed, 30 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
> prerequisite-patch-id: 4ccdf9c974a3909075051f4ffe498faecab7567b

