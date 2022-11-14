Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8423627BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiKNLSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbiKNLRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:17:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8359D21E2C;
        Mon, 14 Nov 2022 03:14:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9093E23A;
        Mon, 14 Nov 2022 03:14:37 -0800 (PST)
Received: from [10.57.70.83] (unknown [10.57.70.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF4F93F73D;
        Mon, 14 Nov 2022 03:14:28 -0800 (PST)
Message-ID: <f1006813-9367-975c-573b-de2c859a65e9@arm.com>
Date:   Mon, 14 Nov 2022 11:14:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 12/12] perf test: Replace data symbol test workload with
 datasym
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
 <20221110181920.84900-13-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20221110181920.84900-13-namhyung@kernel.org>
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
>   $ sudo ./perf test -v 109
>   109: Test data symbol                                                :
>   --- start ---
>   test child forked, pid 844526
>   Recording workload...
>   [ perf record: Woken up 2 times to write data ]
>   [ perf record: Captured and wrote 0.354 MB /tmp/__perf_test.perf.data.GFeZO (4847 samples) ]
>   Cleaning up files...
>   test child finished with 0
>   ---- end ----
>   Test data symbol: Ok
> 
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/test_data_symbol.sh | 29 +---------------------
>  1 file changed, 1 insertion(+), 28 deletions(-)
> 
Tested-by: James Clark <james.clark@arm.com>


> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
> index cd6eb54d235d..d871e6c743ef 100755
> --- a/tools/perf/tests/shell/test_data_symbol.sh
> +++ b/tools/perf/tests/shell/test_data_symbol.sh
> @@ -11,13 +11,7 @@ skip_if_no_mem_event() {
>  
>  skip_if_no_mem_event || exit 2
>  
> -# skip if there's no compiler
> -if ! [ -x "$(command -v cc)" ]; then
> -	echo "skip: no compiler, install gcc"
> -	exit 2
> -fi
> -
> -TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
> +TEST_PROGRAM="perf test -w datasym"
>  PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  
>  check_result() {
> @@ -45,31 +39,10 @@ cleanup_files()
>  {
>  	echo "Cleaning up files..."
>  	rm -f ${PERF_DATA}
> -	rm -f ${TEST_PROGRAM}
>  }
>  
>  trap cleanup_files exit term int
>  
> -# compile test program
> -echo "Compiling test program..."
> -cat << EOF | cc -o ${TEST_PROGRAM} -x c -
> -typedef struct _buf {
> -	char data1;
> -	char reserved[55];
> -	char data2;
> -} buf __attribute__((aligned(64)));
> -
> -static buf buf1;
> -
> -int main(void) {
> -	for (;;) {
> -		buf1.data1++;
> -		buf1.data2 += buf1.data1;
> -	}
> -	return 0;
> -}
> -EOF
> -
>  echo "Recording workload..."
>  
>  # perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't support
