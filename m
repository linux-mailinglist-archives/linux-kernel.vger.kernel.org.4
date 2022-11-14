Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6775627BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiKNLQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbiKNLPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:15:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DBADF51;
        Mon, 14 Nov 2022 03:11:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25F4123A;
        Mon, 14 Nov 2022 03:11:48 -0800 (PST)
Received: from [10.57.70.83] (unknown [10.57.70.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43DE83F73D;
        Mon, 14 Nov 2022 03:11:39 -0800 (PST)
Message-ID: <38c4c93d-c3a5-2649-a57a-3c1ccd2027f3@arm.com>
Date:   Mon, 14 Nov 2022 11:11:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 02/12] perf test: Replace pipe test workload with noploop
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
 <20221110181920.84900-3-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20221110181920.84900-3-namhyung@kernel.org>
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
> So that it can get rid of requirement of a compiler.
> Also define and use more local symbols to ease future changes.
> 
>   $ sudo ./perf test -v pipe
>    87: perf pipe recording and injection test                          :
>   --- start ---
>   test child forked, pid 748003
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]
>       748014   748014       -1 |perf
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]
>       99.83%  perf     perf                  [.] noploop
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]
>       99.85%  perf     perf                  [.] noploop
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.160 MB /tmp/perf.data.2XYPdw (4007 samples) ]
>       99.83%  perf     perf                  [.] noploop
>   test child finished with 0
>   ---- end ----
>   perf pipe recording and injection test: Ok
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Tested-by: James Clark <james.clark@arm.com>

> ---
>  tools/perf/tests/shell/pipe_test.sh | 55 ++++++-----------------------
>  1 file changed, 10 insertions(+), 45 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
> index 1b32b4f28391..8dd115dd35a7 100755
> --- a/tools/perf/tests/shell/pipe_test.sh
> +++ b/tools/perf/tests/shell/pipe_test.sh
> @@ -2,68 +2,33 @@
>  # perf pipe recording and injection test
>  # SPDX-License-Identifier: GPL-2.0
>  
> -# skip if there's no compiler
> -if ! [ -x "$(command -v cc)" ]; then
> -	echo "failed: no compiler, install gcc"
> -	exit 2
> -fi
> -
> -file=$(mktemp /tmp/test.file.XXXXXX)
>  data=$(mktemp /tmp/perf.data.XXXXXX)
> +prog="perf test -w noploop"
> +task="perf"
> +sym="noploop"
>  
> -cat <<EOF | cc -o ${file} -x c -
> -#include <signal.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -
> -volatile int done;
> -
> -void sigalrm(int sig) {
> -	done = 1;
> -}
> -
> -__attribute__((noinline)) void noploop(void) {
> -	while (!done)
> -		continue;
> -}
> -
> -int main(int argc, char *argv[]) {
> -	int sec = 1;
> -
> -	if (argc > 1)
> -		sec = atoi(argv[1]);
> -
> -	signal(SIGALRM, sigalrm);
> -	alarm(sec);
> -
> -	noploop();
> -	return 0;
> -}
> -EOF
> -
> -
> -if ! perf record -e task-clock:u -o - ${file} | perf report -i - --task | grep test.file; then
> +if ! perf record -e task-clock:u -o - ${prog} | perf report -i - --task | grep ${task}; then
>  	echo "cannot find the test file in the perf report"
>  	exit 1
>  fi
>  
> -if ! perf record -e task-clock:u -o - ${file} | perf inject -b | perf report -i - | grep noploop; then
> +if ! perf record -e task-clock:u -o - ${prog} | perf inject -b | perf report -i - | grep ${sym}; then
>  	echo "cannot find noploop function in pipe #1"
>  	exit 1
>  fi
>  
> -perf record -e task-clock:u -o - ${file} | perf inject -b -o ${data}
> -if ! perf report -i ${data} | grep noploop; then
> +perf record -e task-clock:u -o - ${prog} | perf inject -b -o ${data}
> +if ! perf report -i ${data} | grep ${sym}; then
>  	echo "cannot find noploop function in pipe #2"
>  	exit 1
>  fi
>  
> -perf record -e task-clock:u -o ${data} ${file}
> -if ! perf inject -b -i ${data} | perf report -i - | grep noploop; then
> +perf record -e task-clock:u -o ${data} ${prog}
> +if ! perf inject -b -i ${data} | perf report -i - | grep ${sym}; then
>  	echo "cannot find noploop function in pipe #3"
>  	exit 1
>  fi
>  
>  
> -rm -f ${file} ${data} ${data}.old
> +rm -f ${data} ${data}.old
>  exit 0
