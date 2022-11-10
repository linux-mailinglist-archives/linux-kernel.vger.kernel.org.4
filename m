Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61F6244A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiKJOtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:49:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2FC0FAD7;
        Thu, 10 Nov 2022 06:49:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C0A71FB;
        Thu, 10 Nov 2022 06:49:49 -0800 (PST)
Received: from [10.1.28.168] (e127744.cambridge.arm.com [10.1.28.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C74C03F703;
        Thu, 10 Nov 2022 06:49:41 -0800 (PST)
Subject: Re: [PATCH 07/12] perf test: Add 'sqrtloop' test workload
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
References: <20221109174635.859406-1-namhyung@kernel.org>
 <20221109174635.859406-8-namhyung@kernel.org>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <3be361f6-dd50-8998-872e-27bbf9f02017@arm.com>
Date:   Thu, 10 Nov 2022 14:49:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20221109174635.859406-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 17:46, Namhyung Kim wrote:
> The sqrtloop creates a child process to run an infinite loop calling
> sqrt() with rand().  This is needed for ARM SPE fork test.
>
>   $ perf test -w sqrtloop
>
> It can take an optional argument to specify how long it will run in
> seconds (default: 1).
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/builtin-test.c       |  1 +
>  tools/perf/tests/tests.h              |  1 +
>  tools/perf/tests/workloads/Build      |  1 +
>  tools/perf/tests/workloads/sqrtloop.c | 44 +++++++++++++++++++++++++++
>  4 files changed, 47 insertions(+)
>  create mode 100644 tools/perf/tests/workloads/sqrtloop.c
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 0ed5ac452f6e..9acb7a93eeb9 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -122,6 +122,7 @@ static struct test_workload *workloads[] = {
>  	&workload__noploop,
>  	&workload__thloop,
>  	&workload__leafloop,
> +	&workload__sqrtloop,
>  };
>  
>  static int num_subtests(const struct test_suite *t)
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 86804dd6452b..18c40319e67c 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -203,5 +203,6 @@ struct test_workload workload__##work = {	\
>  DECLARE_WORKLOAD(noploop);
>  DECLARE_WORKLOAD(thloop);
>  DECLARE_WORKLOAD(leafloop);
> +DECLARE_WORKLOAD(sqrtloop);
>  
>  #endif /* TESTS_H */
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
> index 631596bdb2b3..1ca95cb0fdb5 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -3,5 +3,6 @@
>  perf-y += noploop.o
>  perf-y += thloop.o
>  perf-y += leafloop.o
> +perf-y += sqrtloop.o
>  
>  CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer
> diff --git a/tools/perf/tests/workloads/sqrtloop.c b/tools/perf/tests/workloads/sqrtloop.c
> new file mode 100644
> index 000000000000..f7d1f8d4867b
> --- /dev/null
> +++ b/tools/perf/tests/workloads/sqrtloop.c
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <math.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <linux/compiler.h>
> +#include <sys/wait.h>
> +#include "../tests.h"
> +
> +static volatile int done;
> +
> +static void sighandler(int sig __maybe_unused)
> +{
> +	done = 1;
> +}
> +
> +static int __sqrtloop(int sec)
> +{
> +	signal(SIGALRM, sighandler);
> +	alarm(sec);
> +
> +	while (!done)
> +		sqrt(rand());
> +	return 0;
> +}

I get some implicit declaration errors on x86 build

(gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0)

.  CC      tests/workloads/sqrtloop.o
.tests/workloads/sqrtloop.c: In function ‘__sqrtloop’:
.tests/workloads/sqrtloop.c:19:2: error: implicit declaration of function ‘alarm’ [-Werror=implicit-function-declaration]
.   19 |  alarm(sec);
.      |  ^~~~~
.tests/workloads/sqrtloop.c: In function ‘sqrtloop’:
.tests/workloads/sqrtloop.c:33:10: error: implicit declaration of function ‘fork’ [-Werror=implicit-function-declaration]
.   33 |  switch (fork()) {
.      |          ^~~~

> +
> +static int sqrtloop(int argc, const char **argv)
> +{
> +	int sec = 1;
> +
> +	if (argc > 0)
> +		sec = atoi(argv[0]);
> +
> +	switch (fork()) {
> +	case 0:
> +		return __sqrtloop(sec);
> +	case -1:
> +		return -1;
> +	default:
> +		wait(NULL);
> +	}
> +	return 0;
> +}
> +
> +DEFINE_WORKLOAD(sqrtloop);
