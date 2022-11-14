Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CED627BED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiKNLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbiKNLQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:16:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65B8C22B10;
        Mon, 14 Nov 2022 03:12:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7488323A;
        Mon, 14 Nov 2022 03:12:37 -0800 (PST)
Received: from [10.57.70.83] (unknown [10.57.70.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8AA63F73D;
        Mon, 14 Nov 2022 03:12:28 -0800 (PST)
Message-ID: <f76388e6-df62-baf0-4f6b-84fc3822b233@arm.com>
Date:   Mon, 14 Nov 2022 11:12:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 08/12] perf test: Replace arm spe fork test workload with
 sqrtloop
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
References: <20221110181920.84900-1-namhyung@kernel.org>
 <20221110181920.84900-9-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20221110181920.84900-9-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 18:19, Namhyung Kim wrote:
> So that it can get rid of requirement of a compiler.  I've also removed
> killall as it'll kill perf process now and run the test workload for 10
> sec instead.
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/test_arm_spe_fork.sh | 44 +--------------------
>  1 file changed, 1 insertion(+), 43 deletions(-)

Tested-by: James Clark <james.clark@arm.com>

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
