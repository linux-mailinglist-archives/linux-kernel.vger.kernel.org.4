Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D9E60B790
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiJXT0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiJXTYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:24:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FD55DF2E;
        Mon, 24 Oct 2022 10:58:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6F2E61522;
        Mon, 24 Oct 2022 17:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E1CC433D6;
        Mon, 24 Oct 2022 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666633882;
        bh=d3v3Gs9NL/24zvJCQfTzBZA+yqhawF/U1WV5qiof1bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hT9lB0u/Ddumj+USy4E8oWLC87dHHEplypeXSe5/N1S3ER9T54d+UBkVmqb2gxiPz
         vY3RzhkXExsQzrHNVmv7IB1mrE6Nb0NvWeIUYNrAX2sLgSXOylKpt1Pw0CTOT/EvFM
         5wj6JsqsAmlkNM26k7J/4OsCteeaMUEbDpuGQpnVjrSv54ezymWQnDKSc6pXerP8Wn
         iw/hl5BmZFGpKzLVEaY3tmfMRa+QxAHSQeCCxxR38VIOHiH+9ZgeN/YfKRVbHdf1Rc
         KfT0KZnrRruJ0vWYc9UbWEc0KuWELb5oyiaUcK182AOaC4g0KHR7oO8U6MSxv6EYu2
         9xiYrQskFhVyw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 84E61404BE; Mon, 24 Oct 2022 14:51:19 -0300 (-03)
Date:   Mon, 24 Oct 2022 14:51:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 0/8] Update to C11, fix signal undefined behavior
Message-ID: <Y1bQlxxABicj4k3+@kernel.org>
References: <20221024173523.602064-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 24, 2022 at 10:35:15AM -0700, Ian Rogers escreveu:
> The use of C11 is mainstream in the kernel [1]. There was some
> confusion on volatile and signal handlers in [2]. Switch to using
> stdatomic.h (requires C11) and sig_atomic_t as per [3]. Thanks to Leo
> Yan <leo.yan@linaro.org> for the suggestions.
> 
> [1] https://lore.kernel.org/lkml/CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com/
> [2] https://lore.kernel.org/lkml/20221024011024.462518-1-irogers@google.com/
> [3] https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

I think I'll apply this to perf/core, i.e. for 6.3, ok?

- Arnaldo
 
> 
> Ian Rogers (8):
>   perf build: Update to C standard to gnu11
>   perf record: Use sig_atomic_t for signal handlers
>   perf daemon: Use sig_atomic_t to avoid UB
>   perf ftrace: Use sig_atomic_t to avoid UB
>   perf session: Change type to avoid UB
>   perf stat: Use sig_atomic_t to avoid UB
>   perf top: Use sig_atomic_t to avoid UB
>   perf trace: Use sig_atomic_t to avoid UB
> 
>  tools/perf/Makefile.config  | 2 +-
>  tools/perf/builtin-daemon.c | 3 ++-
>  tools/perf/builtin-ftrace.c | 4 ++--
>  tools/perf/builtin-record.c | 9 +++++----
>  tools/perf/builtin-stat.c   | 9 +++++----
>  tools/perf/builtin-top.c    | 4 ++--
>  tools/perf/builtin-trace.c  | 4 ++--
>  tools/perf/util/session.c   | 3 ++-
>  8 files changed, 21 insertions(+), 17 deletions(-)
> 
> -- 
> 2.38.0.135.g90850a2211-goog

-- 

- Arnaldo
