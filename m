Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5836314F8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiKTPjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKTPjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:39:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C849938E;
        Sun, 20 Nov 2022 07:39:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87ACBB80AFE;
        Sun, 20 Nov 2022 15:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130A5C433C1;
        Sun, 20 Nov 2022 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668958755;
        bh=Ov21CMzyp/BQx+oKvHSoXyGPtWjylszVmHmrXdDBnII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nOpBz/Tt2MK+815wxsJ0xqHHMbU+V533z6kX9S+HtVhHHrM+ANNZ7enBRY0oLlSCW
         kPHHQyRdeN2Ju7Bxz5m+putCll6atJraZtSM2WIj8eCVkMYqbvvECX7wx1vzTgRdSl
         juUv7hUR21RwU+l4cWgEZ7exWeaJpNmAL2tzWy7u6ynQlcWb41f/fAzMWLvk6pPgAR
         U23rmZMcHA5dQA6vObztRffz8YqQzfckAGNCqmyVlhkPqx5ej4u7q4raW9pKK4ps7o
         NlEh4V8MuXXFWdRILicRHOEgZ+yV1WMlEbgK2krB92PGoExk2RpBuQk+OTfLZ9vQer
         BVcb1lnqQHXHA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C6CE74034E; Sun, 20 Nov 2022 12:39:11 -0300 (-03)
Date:   Sun, 20 Nov 2022 12:39:11 -0300
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
Subject: Re: [PATCH 08/12] perf test: Replace arm spe fork test workload with
 sqrtloop
Message-ID: <Y3pKH1djhiS31Wtn@kernel.org>
References: <20221116233854.1596378-1-namhyung@kernel.org>
 <20221116233854.1596378-9-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116233854.1596378-9-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 16, 2022 at 03:38:50PM -0800, Namhyung Kim escreveu:
> So that it can get rid of requirement of a compiler.  I've also removed
> killall as it'll kill perf process now and run the test workload for 10
> sec instead.

   8    73.81 alpine:edge                   : FAIL gcc version 11.2.1 20220219 (Alpine 11.2.1_git20220219)
    tests/workloads/sqrtloop.c:23:3: error: ignoring return value of function declared with const attribute [-Werror,-Wunused-value]
                    sqrt(rand());
                    ^~~~ ~~~~~~
    1 error generated.
    make[4]: *** [/git/perf-6.1.0-rc5/tools/build/Makefile.build:139: workloads] Error 2
    make[3]: *** [/git/perf-6.1.0-rc5/tools/build/Makefile.build:139: tests] Error 2


I'll fix this one, probably just prepending a (void *).

- Arnaldo
 
> Tested-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/test_arm_spe_fork.sh | 44 +--------------------
>  1 file changed, 1 insertion(+), 43 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_arm_spe_fork.sh b/tools/perf/tests/shell/test_arm_spe_fork.sh
> index c920d3583d30..da810e1b2b9e 100755
> --- a/tools/perf/tests/shell/test_arm_spe_fork.sh
> +++ b/tools/perf/tests/shell/test_arm_spe_fork.sh
> @@ -11,14 +11,7 @@ skip_if_no_arm_spe_event() {
>  
>  skip_if_no_arm_spe_event || exit 2
>  
> -# skip if there's no compiler
> -if ! [ -x "$(command -v cc)" ]; then
> -	echo "failed: no compiler, install gcc"
> -	exit 2
> -fi
> -
> -TEST_PROGRAM_SOURCE=$(mktemp /tmp/__perf_test.program.XXXXX.c)
> -TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
> +TEST_PROGRAM="perf test -w sqrtloop 10"
>  PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  PERF_RECORD_LOG=$(mktemp /tmp/__perf_test.log.XXXXX)
>  
> @@ -27,43 +20,10 @@ cleanup_files()
>  	echo "Cleaning up files..."
>  	rm -f ${PERF_RECORD_LOG}
>  	rm -f ${PERF_DATA}
> -	rm -f ${TEST_PROGRAM_SOURCE}
> -	rm -f ${TEST_PROGRAM}
>  }
>  
>  trap cleanup_files exit term int
>  
> -# compile test program
> -cat << EOF > $TEST_PROGRAM_SOURCE
> -#include <math.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <sys/wait.h>
> -
> -int workload() {
> -  while (1)
> -    sqrt(rand());
> -  return 0;
> -}
> -
> -int main() {
> -  switch (fork()) {
> -    case 0:
> -      return workload();
> -    case -1:
> -      return 1;
> -    default:
> -      wait(NULL);
> -  }
> -  return 0;
> -}
> -EOF
> -
> -echo "Compiling test program..."
> -CFLAGS="-lm"
> -cc $TEST_PROGRAM_SOURCE $CFLAGS -o $TEST_PROGRAM || exit 1
> -
>  echo "Recording workload..."
>  perf record -o ${PERF_DATA} -e arm_spe/period=65536/ -vvv -- $TEST_PROGRAM > ${PERF_RECORD_LOG} 2>&1 &
>  PERFPID=$!
> @@ -78,8 +38,6 @@ echo Log lines after 1 second = $log1
>  
>  kill $PERFPID
>  wait $PERFPID
> -# test program may leave an orphan process running the workload
> -killall $(basename $TEST_PROGRAM)
>  
>  if [ "$log0" = "$log1" ];
>  then
> -- 
> 2.38.1.584.g0f3c55d4c2-goog

-- 

- Arnaldo
