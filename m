Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFF4627BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiKNLQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiKNLPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:15:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D5AE222B3;
        Mon, 14 Nov 2022 03:12:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73CA0ED1;
        Mon, 14 Nov 2022 03:12:20 -0800 (PST)
Received: from [10.57.70.83] (unknown [10.57.70.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC80D3F73D;
        Mon, 14 Nov 2022 03:12:11 -0800 (PST)
Message-ID: <bf0f1133-3612-7182-9d81-2969faf4e338@arm.com>
Date:   Mon, 14 Nov 2022 11:12:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 06/12] perf test: Replace arm callgraph fp test workload
 with leafloop
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
 <20221110181920.84900-7-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20221110181920.84900-7-namhyung@kernel.org>
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
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  .../perf/tests/shell/test_arm_callgraph_fp.sh | 34 ++-----------------
>  1 file changed, 3 insertions(+), 31 deletions(-)

Tested-by: James Clark <james.clark@arm.com>

> 
> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> index ec108d45d3c6..e61d8deaa0c4 100755
> --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> @@ -4,44 +4,16 @@
>  
>  lscpu | grep -q "aarch64" || exit 2
>  
> -if ! [ -x "$(command -v cc)" ]; then
> -	echo "failed: no compiler, install gcc"
> -	exit 2
> -fi
> -
>  PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> -TEST_PROGRAM_SOURCE=$(mktemp /tmp/test_program.XXXXX.c)
> -TEST_PROGRAM=$(mktemp /tmp/test_program.XXXXX)
> +TEST_PROGRAM="perf test -w leafloop"
>  
>  cleanup_files()
>  {
>  	rm -f $PERF_DATA
> -	rm -f $TEST_PROGRAM_SOURCE
> -	rm -f $TEST_PROGRAM
>  }
>  
>  trap cleanup_files exit term int
>  
> -cat << EOF > $TEST_PROGRAM_SOURCE
> -int a = 0;
> -void leaf(void) {
> -  for (;;)
> -    a += a;
> -}
> -void parent(void) {
> -  leaf();
> -}
> -int main(void) {
> -  parent();
> -  return 0;
> -}
> -EOF
> -
> -echo " + Compiling test program ($TEST_PROGRAM)..."
> -
> -CFLAGS="-g -O0 -fno-inline -fno-omit-frame-pointer"
> -cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
> -
>  # Add a 1 second delay to skip samples that are not in the leaf() function
>  perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
>  PID=$!
> @@ -58,11 +30,11 @@ wait $PID
>  # program
>  # 	728 leaf
>  # 	753 parent
> -# 	76c main
> +# 	76c leafloop
>  # ...
>  
>  perf script -i $PERF_DATA -F comm,ip,sym | head -n4
>  perf script -i $PERF_DATA -F comm,ip,sym | head -n4 | \
>  	awk '{ if ($2 != "") sym[i++] = $2 } END { if (sym[0] != "leaf" ||
>  						       sym[1] != "parent" ||
> -						       sym[2] != "main") exit 1 }'
> +						       sym[2] != "leafloop") exit 1 }'
