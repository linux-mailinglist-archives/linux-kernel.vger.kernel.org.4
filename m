Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4049172EC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjFMTuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFMTug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:50:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FFA12A;
        Tue, 13 Jun 2023 12:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3550F61554;
        Tue, 13 Jun 2023 19:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7041BC433D9;
        Tue, 13 Jun 2023 19:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686685834;
        bh=xMKCKLypia4H3d+FkIf7L/MfI9HK2ZYXnemiSXrqvvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rz8sVmWOqpl0q1eCrKhIitzlf0wQZf9Dvnn0l4GNSj6MzgTgQnQL1tTtRAd7ozeeY
         8yy7ZgijaD+4UKMGI4D/PVMWnklsPkSAcx9BsFQRKdlhAY+f3CFHnGIygrmknTmSmb
         9soAMptXL+iy3tF75h8Ic+MneZK5LqlY5nVtk/OiJbB98NvUBoQM1HxO9rKhb9Q0pu
         A2WTkPMjTUftA1C0nMGJeq045xbnGOIdrfiMYXYpLuxspyXcc1K7TyYpdApbN0ykAf
         05qMvnQ/b36/Mkh+t7sS/YE3xv7+zHY1FjstsUDACeKGRjWyUJNS+lMXiSAHR2OLI5
         KUer+Xg7mYDHg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4348D40692; Tue, 13 Jun 2023 16:50:32 -0300 (-03)
Date:   Tue, 13 Jun 2023 16:50:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf util: asprintf helper for leak sanitizer
Message-ID: <ZIjIiPAfTwL/P1dt@kernel.org>
References: <20230613191639.1547925-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613191639.1547925-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 13, 2023 at 12:16:38PM -0700, Ian Rogers escreveu:
> asprintf is a source of memory leaks but produces bad stack traces on
> my Debian linux. This patch adds a simple asprintf implementation to
> util.c that works around it.

So is this something to report to the glibc maintainers or debian?

- Arnaldo
 
> Before output:
> ```
> ==1541752==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 10 byte(s) in 1 object(s) allocated from:
>     #0 0x7f90c76b89cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
>     #1 0x7f90c649d2c7 in __vasprintf_internal libio/vasprintf.c:71
>     #2 0x55ad9b79afbf  (/tmp/perf/perf+0x850fbf)
> 
> SUMMARY: AddressSanitizer: 10 byte(s) leaked in 1 allocation(s).
> ```
> 
> After output:
> ```
> ==1545918==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 10 byte(s) in 1 object(s) allocated from:
>     #0 0x7f2755a7077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
>     #1 0x564986a8df31 in asprintf util/util.c:566
>     #2 0x5649869b5901 in metricgroup__lookup_default_metricgroup util/metricgroup.c:1520
>     #3 0x5649869b5e57 in metricgroup__lookup_create util/metricgroup.c:1579
>     #4 0x5649869b6ddc in parse_groups util/metricgroup.c:1698
>     #5 0x5649869b7714 in metricgroup__parse_groups util/metricgroup.c:1771
>     #6 0x5649867da9d5 in add_default_attributes tools/perf/builtin-stat.c:2164
>     #7 0x5649867ddbfb in cmd_stat tools/perf/builtin-stat.c:2707
>     #8 0x5649868fa5a2 in run_builtin tools/perf/perf.c:323
>     #9 0x5649868fab13 in handle_internal_command tools/perf/perf.c:377
>     #10 0x5649868faedb in run_argv tools/perf/perf.c:421
>     #11 0x5649868fb443 in main tools/perf/perf.c:537
>     #12 0x7f2754846189 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
> 
> SUMMARY: AddressSanitizer: 10 byte(s) leaked in 1 allocation(s).
> ```
> 
> RFC: is this useful for others? Should we have a build flag for it?
> ---
>  tools/perf/util/util.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index c1fd9ba6d697..57eb528c5fed 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -552,3 +552,22 @@ int sched_getcpu(void)
>  	return -1;
>  }
>  #endif
> +
> +int asprintf(char **restrict strp, const char *restrict fmt, ...)
> +{
> +	char buf[1024];
> +	va_list ap;
> +	int size;
> +	char *result;
> +
> +	va_start(ap, fmt);
> +	size = vsnprintf(buf, sizeof(buf), fmt, ap);
> +	if (size < (int)sizeof(buf))
> +		result = strdup(buf);
> +	else
> +		size = vasprintf(&result, fmt, ap);
> +
> +	*strp = result;
> +	va_end(ap);
> +	return size;
> +}
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

-- 

- Arnaldo
