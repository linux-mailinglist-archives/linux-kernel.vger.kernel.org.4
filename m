Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CE1683248
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjAaQKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjAaQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:10:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B893AAD;
        Tue, 31 Jan 2023 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675181416; x=1706717416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M6PZlPE0vbWrAxe58dcPMH9f1ftccPFfuRcuKb6RkyQ=;
  b=ixZYJUgpx7jCA4rW7gcomDAKDIZLWd4ftpsIIsQn5HYJt0mHSd3uBH39
   Cgwr0UQxhxP6vrkK5p1T8LgroQ9kNRmi3T+WidT3RvnmFGQ2BulOb36/n
   GK/siS7Mv2Kq0THOq5of6UFvcsZ0NgM0tQ/EMczft/ujxRbqgunEk4g+A
   Wv8TaZJWkez4Tep/oE1SVF/5eduimTsgdV+HZ5tbkM0ot+/tGG56olfrw
   WS4jto+mGqEnL12pUvXn8qHTx3w+wj7Dp1SX7Jewm+eZ81L3zhtoQaKsu
   wknQeZh4xHHz8eYgLRi65GevmUmAST5vmVmvnIN9Aj7Ts6uiRGNEyKl6J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="390243308"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390243308"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:10:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="788493939"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="788493939"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.47.218])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:10:12 -0800
Message-ID: <49214ccf-4847-1553-f911-57f194114969@intel.com>
Date:   Tue, 31 Jan 2023 18:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v2)
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Stephane Eranian <eranian@google.com>
References: <20230131023350.1903992-1-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230131023350.1903992-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/23 04:33, Namhyung Kim wrote:
> Hello,
> 
> I found some problems in Intel-PT and auxtrace in general with pipe.
> In the past it used to work with pipe, but recent code fails.  As it
> also touches the generic code, other auxtrace users like ARM SPE will
> be affected too.  I added a test case to verify it works with pipes.
> 
> Changes in v2)
>  * add a warning in intel_pt_process_auxtrace_info()
>  * add Reviewed-by from James

Minor changes suggested for patch 2, otherwise:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> At last, I can run this command without a problem.
> 
>   $ perf record -o- -e intel_pt// true | perf inject -b | perf report -i- --itrace=i1000
> 
> The code is available at 'perf/auxtrace-pipe-v2' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf inject: Use perf_data__read() for auxtrace
>   perf intel-pt: Do not try to queue auxtrace data on pipe
>   perf session: Avoid calling lseek(2) for pipe
>   perf test: Add pipe mode test to the Intel PT test suite
> 
>  tools/perf/Documentation/perf-intel-pt.txt | 30 ++++++++++++++++++++++
>  tools/perf/builtin-inject.c                |  6 ++---
>  tools/perf/tests/shell/test_intel_pt.sh    | 17 ++++++++++++
>  tools/perf/util/auxtrace.c                 |  3 +++
>  tools/perf/util/intel-pt.c                 |  6 +++++
>  tools/perf/util/session.c                  |  9 +++++--
>  6 files changed, 66 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9

