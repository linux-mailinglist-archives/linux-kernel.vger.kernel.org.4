Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7CD6CDA2C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC2NJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC2NJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:09:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6609B3;
        Wed, 29 Mar 2023 06:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74BA0B822F3;
        Wed, 29 Mar 2023 13:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021EBC433D2;
        Wed, 29 Mar 2023 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680095391;
        bh=QA0CaowHS8lYn5wmOX7+pisJ5FR1qwMNwQVbvZ99QKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nakaeaekun5nbXp/DAXQTdtPYyMLwJ9ttqJT4pdFR1SN3SkVx6lcIPdajgiyNXOil
         vf2V6x5/3GTZMX7GH7/zwxWY4nPLPR0t2sCvvnczLIe3qoncVEpqT7+fvUt2ybVcmR
         5ffrzRP8x8yeYySGmcgFIm5fjwl25ziINsMs6tLSyiZSOrYyyXqTreD8XxV89qwFC6
         jK4vzpmv1F3He16pDi7nQ/m3rw6mnqs7FEgswBjCb/R/xvryOorHeR1B3VX6LGteQt
         pGFOWPjAZXKuQBF3cmcp+ghCNIvpnV8y6WATm+FzJ/ogG8Df4cBGSE5Y7LtfyFaLf2
         Qv1OJ6BQvlOzQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ABB7D4052D; Wed, 29 Mar 2023 10:09:48 -0300 (-03)
Date:   Wed, 29 Mar 2023 10:09:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, James Clark <james.clark@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Andres Freund <andres@anarazel.de>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v1 1/6] perf annotate: Delete session for debug builds
Message-ID: <ZCQ4nERbit/f6yhh@kernel.org>
References: <20230328235543.1082207-1-irogers@google.com>
 <20230328235543.1082207-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328235543.1082207-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 28, 2023 at 04:55:38PM -0700, Ian Rogers escreveu:
> Use the debug build indicator as the guide to free the session. This
> implements a behavior described in a comment, which is consequentially
> removed.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-annotate.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 4750fac7bf93..98d1b6379230 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -692,16 +692,12 @@ int cmd_annotate(int argc, const char **argv)
>  
>  out_delete:
>  	/*
> -	 * Speed up the exit process, for large files this can
> -	 * take quite a while.
> -	 *
> -	 * XXX Enable this when using valgrind or if we ever
> -	 * librarize this command.
> -	 *
> -	 * Also experiment with obstacks to see how much speed
> -	 * up we'll get here.
> -	 *
> -	 * perf_session__delete(session);
> +	 * Speed up the exit process by only deleting for debug builds. For
> +	 * large files this can save time.
>  	 */
> +#ifndef NDEBUG
> +	perf_session__delete(annotate.session);
> +#endif

So now, but default, we will call this, as we don't have this defined
only if DEBUG=1 is set, right?

⬢[acme@toolbox perf-tools-next]$ find tools/perf/ -type f | xargs grep NDEBUG
tools/perf/util/mutex.c:#ifndef NDEBUG
⬢[acme@toolbox perf-tools-next]$

- Arnaldo
