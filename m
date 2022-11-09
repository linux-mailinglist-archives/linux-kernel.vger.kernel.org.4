Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB286232A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiKISkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKISkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:40:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E924DF5B0;
        Wed,  9 Nov 2022 10:39:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A325FB81F90;
        Wed,  9 Nov 2022 18:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ABCC433C1;
        Wed,  9 Nov 2022 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668019197;
        bh=GYxMAZ3wSyTinwzhB7VkfYbbF5onx9+U4IQcdZlqAss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VrPBc8QnNZGVmwKtQBYXVXcUAOHh+lb3V3nSFWS+2B3rFmj7i4envYwUzaLdvBXi6
         VLa9uCayrG/GdM9ipqB/fcdfRbDYvHWdRknCE2DmaDrmrkTB5Dgwih2HPSR3pnrXm+
         FDumyi8L2uS7BQw3TgUgg4rwpSrv1z231mDowcwfI5sV6EuoR3roDHR7JR+HOXs6mS
         DruBBLWNUsZNy44m+7+P9AldO1ZZmuTweva1ZgYMbrMuhwlqWo6PZz12sTojNSXTsC
         WAVEhI5O1nRJvk1VaY8YWZCWDvsU7weTW944VqllYsRRgEXELVPXIxh2OAWTnUPN13
         iWg2RIgcuIpug==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4ABFB4034E; Wed,  9 Nov 2022 15:39:55 -0300 (-03)
Date:   Wed, 9 Nov 2022 15:39:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH 03/12] perf test: Add 'thloop' test workload
Message-ID: <Y2vz+3u9shFbWy1B@kernel.org>
References: <20221109174635.859406-1-namhyung@kernel.org>
 <20221109174635.859406-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109174635.859406-4-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 09, 2022 at 09:46:26AM -0800, Namhyung Kim escreveu:
> The thloop is similar to noploop but runs in two threads.  This is
> needed to verify perf record --per-thread to handle multi-threaded
> programs properly.
> 
>   $ perf test -w thloop
> 
> It also takes an optional argument to specify runtime in seconds
> (default: 1).
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/builtin-test.c     |  1 +
>  tools/perf/tests/tests.h            |  1 +
>  tools/perf/tests/workloads/Build    |  1 +
>  tools/perf/tests/workloads/thloop.c | 53 +++++++++++++++++++++++++++++
>  4 files changed, 56 insertions(+)
>  create mode 100644 tools/perf/tests/workloads/thloop.c
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index ce641ccfcf81..161f38476e77 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -120,6 +120,7 @@ static struct test_suite **tests[] = {
>  
>  static struct test_workload *workloads[] = {
>  	&workload__noploop,
> +	&workload__thloop,
>  };
>  
>  static int num_subtests(const struct test_suite *t)
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index d315d0d6fc97..e6edfeeadaeb 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -201,5 +201,6 @@ struct test_workload workload__##work = {	\
>  
>  /* The list of test workloads */
>  DECLARE_WORKLOAD(noploop);
> +DECLARE_WORKLOAD(thloop);
>  
>  #endif /* TESTS_H */
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
> index f98e968d4633..b8964b1099c0 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  perf-y += noploop.o
> +perf-y += thloop.o
> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
> new file mode 100644
> index 000000000000..7fd3ac79e732
> --- /dev/null
> +++ b/tools/perf/tests/workloads/thloop.c
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <pthread.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <linux/compiler.h>
> +#include "../tests.h"
> +
> +static volatile int done;
> +static volatile unsigned count;

sig_atomic_t

> +/* We want to check this symbol in perf report */
> +noinline void test_loop(void);
> +
> +static void sighandler(int sig __maybe_unused)
> +{
> +	done = 1;
> +}
> +
> +noinline void test_loop(void)
> +{
> +	while (!done)
> +		count++;
> +}
> +
> +static void *thfunc(void *arg)
> +{
> +	void (*loop_fn)(void) = arg;
> +
> +	loop_fn();
> +	return NULL;
> +}
> +
> +static int thloop(int argc, const char **argv)
> +{
> +	int sec = 1;
> +	pthread_t th;
> +
> +	if (argc > 0)
> +		sec = atoi(argv[0]);
> +
> +	signal(SIGINT, sighandler);
> +	signal(SIGALRM, sighandler);
> +	alarm(sec);
> +
> +	pthread_create(&th, NULL, thfunc, test_loop);
> +	test_loop();
> +	pthread_join(th, NULL);
> +
> +	return 0;
> +}
> +
> +DEFINE_WORKLOAD(thloop);
> -- 
> 2.38.1.431.g37b22c650d-goog

-- 

- Arnaldo
