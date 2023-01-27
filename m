Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972A167E980
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjA0Pcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjA0Pck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:32:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2990D21959;
        Fri, 27 Jan 2023 07:32:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B75F32B;
        Fri, 27 Jan 2023 07:33:20 -0800 (PST)
Received: from [10.57.48.133] (unknown [10.57.48.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 348363F64C;
        Fri, 27 Jan 2023 07:32:37 -0800 (PST)
Message-ID: <37242bcd-57f5-65c8-3c5e-e90c434f5e18@arm.com>
Date:   Fri, 27 Jan 2023 15:32:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v1)
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Stephane Eranian <eranian@google.com>
References: <20230127001951.3432374-1-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230127001951.3432374-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/01/2023 00:19, Namhyung Kim wrote:
> Hello,
> 
> I found some problems in Intel-PT and auxtrace in general with pipe.
> In the past it used to work with pipe, but recent code fails.  As it
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
For the whole set:

Reviewed-by: James Clark <james.clark@arm.com>

> base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
> prerequisite-patch-id: 4ccdf9c974a3909075051f4ffe498faecab7567b
