Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF1D62E117
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiKQQH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240349AbiKQQGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:06:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A4A7A372;
        Thu, 17 Nov 2022 08:06:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313446211D;
        Thu, 17 Nov 2022 16:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2C9C433C1;
        Thu, 17 Nov 2022 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668701180;
        bh=ZQPKmG6AzHWOCY14wxSSY0gpc49wyGNbHCq41C6n3io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXYz0MBCgny11rLwELUSfmbzSG+SojZIE3Z77BlSGeToVCbaEIOLHeTm8R2GchlCM
         3r3k9SZw6lkgAbNeJajHciyYNTbriNmR3HBapMGyRbSiuX2HEmneSglXNEujkjwaos
         xpC7weVGnkV9FSQcdkvT5c+Bvw9/DLN9galoFxnIBK/z0OSz72AiyAO17Dm8WSTKAn
         gJ2gkbAZaE1q8PVNEgwCPqoSdwtdw19rZ34KTQUTW960bWDE+iwt5fxOmGMfh1RJBF
         8lYmJRduB/DgU6/s6w8fU9eecL0TajTDEpKuhDH1tqDQnJlsTRW3ZbyfGKxrBf29NP
         K9bdAmTrpK7Qw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E49E44034E; Thu, 17 Nov 2022 13:06:16 -0300 (-03)
Date:   Thu, 17 Nov 2022 13:06:16 -0300
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
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/12] perf test: Add 'leafloop' test workload
Message-ID: <Y3Zb+JChHoq+89yM@kernel.org>
References: <20221116233854.1596378-1-namhyung@kernel.org>
 <20221116233854.1596378-6-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116233854.1596378-6-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 16, 2022 at 03:38:47PM -0800, Namhyung Kim escreveu:
> The leafloop workload is to run an infinite loop in the test_leaf
> function.  This is needed for the ARM fp callgraph test to verify if it
> gets the correct callchains.
> 
>   $ perf test -w leafloop

On fedora:36

In file included from /usr/include/bits/libc-header-start.h:33,
                 from /usr/include/stdlib.h:26,
                 from tests/workloads/leafloop.c:2:
/usr/include/features.h:412:4: error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]
  412 | #  warning _FORTIFY_SOURCE requires compiling with optimization (-O)
      |    ^~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/tests/workloads/leafloop.o] Error 1
make[5]: *** Waiting for unfinished jobs....

I'll try removing the _FORTIFY_SOURCE
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/builtin-test.c       |  1 +
>  tools/perf/tests/tests.h              |  1 +
>  tools/perf/tests/workloads/Build      |  3 +++
>  tools/perf/tests/workloads/leafloop.c | 34 +++++++++++++++++++++++++++
>  4 files changed, 39 insertions(+)
>  create mode 100644 tools/perf/tests/workloads/leafloop.c
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 161f38476e77..0ed5ac452f6e 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -121,6 +121,7 @@ static struct test_suite **tests[] = {
>  static struct test_workload *workloads[] = {
>  	&workload__noploop,
>  	&workload__thloop,
> +	&workload__leafloop,
>  };
>  
>  static int num_subtests(const struct test_suite *t)
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index e6edfeeadaeb..86804dd6452b 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -202,5 +202,6 @@ struct test_workload workload__##work = {	\
>  /* The list of test workloads */
>  DECLARE_WORKLOAD(noploop);
>  DECLARE_WORKLOAD(thloop);
> +DECLARE_WORKLOAD(leafloop);
>  
>  #endif /* TESTS_H */
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
> index b8964b1099c0..631596bdb2b3 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -2,3 +2,6 @@
>  
>  perf-y += noploop.o
>  perf-y += thloop.o
> +perf-y += leafloop.o
> +
> +CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer
> diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
> new file mode 100644
> index 000000000000..1bf5cc97649b
> --- /dev/null
> +++ b/tools/perf/tests/workloads/leafloop.c
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <stdlib.h>
> +#include <linux/compiler.h>
> +#include "../tests.h"
> +
> +/* We want to check these symbols in perf script */
> +noinline void leaf(volatile int b);
> +noinline void parent(volatile int b);
> +
> +static volatile int a;
> +
> +noinline void leaf(volatile int b)
> +{
> +	for (;;)
> +		a += b;
> +}
> +
> +noinline void parent(volatile int b)
> +{
> +	leaf(b);
> +}
> +
> +static int leafloop(int argc, const char **argv)
> +{
> +	int c = 1;
> +
> +	if (argc > 0)
> +		c = atoi(argv[0]);
> +
> +	parent(c);
> +	return 0;
> +}
> +
> +DEFINE_WORKLOAD(leafloop);
> -- 
> 2.38.1.584.g0f3c55d4c2-goog

-- 

- Arnaldo
