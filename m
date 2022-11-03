Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98966617D79
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiKCNGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKCNFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3E9140C1;
        Thu,  3 Nov 2022 06:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B26C61E8D;
        Thu,  3 Nov 2022 13:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B3AC433D6;
        Thu,  3 Nov 2022 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667480695;
        bh=oy5jtXucnFC2/KubkB95H1Awbln/AILB0UMEh4jDg28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhMNge0Q1TP9KjVEmQZfOM2Il3+WXy9uOQaHZ7DYqmnAjHgwhb5tVjy2lTn8AKBfV
         ATL8Ee0vS6Qfki9ECYXr1fXhXSIQRCYeLDGuRmFKbqaaNxXClcneHoELLnoo111QxM
         6QAlAw6CSybITIBF+DkTq5KSz145uqwTyUNyF+++k3HO18sYGQlzHcwpvq+UtWFD1+
         xwcLfgARG0subSG5SbS1MvwNly0POnIp8ou8RumWjTg42+l2IE6w37vUWPuGYDq28I
         EEdduGleZ+x2l6TfOVKYnumgKLtWHdtePUBEMYBjP5v+iKyaaxcNP0N1e7Bp+yQX1H
         JLt0Vun/kvwAw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C30DA4034E; Thu,  3 Nov 2022 10:04:52 -0300 (-03)
Date:   Thu, 3 Nov 2022 10:04:52 -0300
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
Subject: Re: [PATCH v2 0/8] Update to C11, fix signal undefined behavior
Message-ID: <Y2O8dD/Noe+XnyT4@kernel.org>
References: <20221024181913.630986-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 24, 2022 at 11:19:05AM -0700, Ian Rogers escreveu:
> The use of C11 is mainstream in the kernel [1]. There was some
> confusion on volatile and signal handlers in [2] for which atomics
> (present in C11) make things clearer. Switch to using volatile
> sig_atomic_t as per [3]. Thanks to Leo Yan <leo.yan@linaro.org> for
> the suggestions.

Thanks, applied and testing building it now.

- Arnaldo
 
> [1] https://lore.kernel.org/lkml/CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com/
> [2] https://lore.kernel.org/lkml/20221024011024.462518-1-irogers@google.com/
> [3] https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers
> 
> v2. Remove unneeded stdatomic.h includes for sig_atomic_t as it is
>     declared in signal.h.
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
>  tools/perf/builtin-daemon.c | 2 +-
>  tools/perf/builtin-ftrace.c | 4 ++--
>  tools/perf/builtin-record.c | 8 ++++----
>  tools/perf/builtin-stat.c   | 8 ++++----
>  tools/perf/builtin-top.c    | 4 ++--
>  tools/perf/builtin-trace.c  | 4 ++--
>  tools/perf/util/session.c   | 3 ++-
>  8 files changed, 18 insertions(+), 17 deletions(-)
> 
> -- 
> 2.38.0.135.g90850a2211-goog

-- 

- Arnaldo
