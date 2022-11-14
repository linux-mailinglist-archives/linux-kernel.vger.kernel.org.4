Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09623627BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiKNLQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiKNLPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:15:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D4FF1C906;
        Mon, 14 Nov 2022 03:11:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8052B23A;
        Mon, 14 Nov 2022 03:12:05 -0800 (PST)
Received: from [10.57.70.83] (unknown [10.57.70.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EEAB3F918;
        Mon, 14 Nov 2022 03:11:56 -0800 (PST)
Message-ID: <12640727-474b-093b-6286-27364e0ac2d6@arm.com>
Date:   Mon, 14 Nov 2022 11:11:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 04/12] perf test: Replace record test workload with thloop
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
 <20221110181920.84900-5-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20221110181920.84900-5-namhyung@kernel.org>
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
> So that it can get rid of requirements for a compiler.
> 
>   $ sudo ./perf test -v 92
>    92: perf record tests                                               :
>   --- start ---
>   test child forked, pid 740204
>   Basic --per-thread mode test
>   Basic --per-thread mode test [Success]
>   Register capture test
>   Register capture test [Success]
>   Basic --system-wide mode test
>   Basic --system-wide mode test [Success]
>   Basic target workload test
>   Basic target workload test [Success]
>   test child finished with 0
>   ---- end ----
>   perf record tests: Ok
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/record.sh | 59 ++------------------------------
>  1 file changed, 3 insertions(+), 56 deletions(-)

Tested-by: James Clark <james.clark@arm.com>

> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index e93b3a8871fe..4dff89e3a3fd 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -9,17 +9,13 @@ shelldir=$(dirname "$0")
>  
>  err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> -testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
> +testprog="perf test -w thloop"
>  testsym="test_loop"
>  
>  cleanup() {
>    rm -rf "${perfdata}"
>    rm -rf "${perfdata}".old
>  
> -  if [ "${testprog}" != "true" ]; then
> -    rm -f "${testprog}"
> -  fi
> -
>    trap - EXIT TERM INT
>  }
>  
> @@ -29,53 +25,6 @@ trap_cleanup() {
>  }
>  trap trap_cleanup EXIT TERM INT
>  
> -build_test_program() {
> -  if ! [ -x "$(command -v cc)" ]; then
> -    # No CC found. Fall back to 'true'
> -    testprog=true
> -    testsym=true
> -    return
> -  fi
> -
> -  echo "Build a test program"
> -  cat <<EOF | cc -o ${testprog} -xc - -pthread
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <pthread.h>
> -
> -void test_loop(void) {
> -  volatile int count = 1000000;
> -
> -  while (count--)
> -    continue;
> -}
> -
> -void *thfunc(void *arg) {
> -  int forever = *(int *)arg;
> -
> -  do {
> -    test_loop();
> -  } while (forever);
> -
> -  return NULL;
> -}
> -
> -int main(int argc, char *argv[]) {
> -  pthread_t th;
> -  int forever = 0;
> -
> -  if (argc > 1)
> -    forever = atoi(argv[1]);
> -
> -  pthread_create(&th, NULL, thfunc, &forever);
> -  test_loop();
> -  pthread_join(th, NULL);
> -
> -  return 0;
> -}
> -EOF
> -}
> -
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
>    if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
> @@ -96,8 +45,8 @@ test_per_thread() {
>      return
>    fi
>  
> -  # run the test program in background (forever)
> -  ${testprog} 1 &
> +  # run the test program in background (for 30 seconds)
> +  ${testprog} 30 &
>    TESTPID=$!
>  
>    rm -f "${perfdata}"
> @@ -205,8 +154,6 @@ test_workload() {
>    echo "Basic target workload test [Success]"
>  }
>  
> -build_test_program
> -
>  test_per_thread
>  test_register_capture
>  test_system_wide
