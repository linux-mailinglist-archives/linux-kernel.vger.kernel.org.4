Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A21627BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiKNLRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiKNLQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:16:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F421518E10;
        Mon, 14 Nov 2022 03:14:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7634F23A;
        Mon, 14 Nov 2022 03:14:15 -0800 (PST)
Received: from [10.57.70.83] (unknown [10.57.70.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AFE83F73D;
        Mon, 14 Nov 2022 03:14:06 -0800 (PST)
Message-ID: <4be2b6bf-eb60-511d-dfd1-90d91c02c105@arm.com>
Date:   Mon, 14 Nov 2022 11:14:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 10/12] perf test: Replace brstack test workload
Content-Language: en-US
To:     German Gomez <german.gomez@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
References: <20221110181920.84900-1-namhyung@kernel.org>
 <20221110181920.84900-11-namhyung@kernel.org>
 <1036a42b-b438-67b2-c4ca-0e440d266d6d@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <1036a42b-b438-67b2-c4ca-0e440d266d6d@arm.com>
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



On 10/11/2022 19:20, German Gomez wrote:
> Hi Namhyung, thanks for doing the refactor, it looks a lot cleaner
> 
> On 10/11/2022 18:19, Namhyung Kim wrote:
>> So that it can get rid of requirement of a compiler.  Also rename the
>> symbols to match with the perf test workload.
>>
>> Cc: German Gomez <german.gomez@arm.com>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>  tools/perf/tests/shell/test_brstack.sh | 66 +++++---------------------
>>  1 file changed, 12 insertions(+), 54 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
>> index ec801cffae6b..a8a182dea25f 100755
>> --- a/tools/perf/tests/shell/test_brstack.sh
>> +++ b/tools/perf/tests/shell/test_brstack.sh
>> @@ -4,18 +4,12 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  # German Gomez <german.gomez@arm.com>, 2022
>>  
>> -# we need a C compiler to build the test programs
>> -# so bail if none is found
>> -if ! [ -x "$(command -v cc)" ]; then
>> -	echo "failed: no compiler, install gcc"
>> -	exit 2
>> -fi
>> -
>>  # skip the test if the hardware doesn't support branch stack sampling
>>  # and if the architecture doesn't support filter types: any,save_type,u
>>  perf record -b -o- -B --branch-filter any,save_type,u true > /dev/null 2>&1 || exit 2
>>  
>>  TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
>> +TESTPROG="perf test -w brstack"
>>  
>>  cleanup() {
>>  	rm -rf $TMPDIR
>> @@ -23,57 +17,24 @@ cleanup() {
>>  
>>  trap cleanup exit term int
>>  
>> -gen_test_program() {
>> -	# generate test program
>> -	cat << EOF > $1
>> -#define BENCH_RUNS 999999
>> -int cnt;
>> -void bar(void) {
>> -}			/* return */
>> -void foo(void) {
>> -	bar();		/* call */
>> -}			/* return */
>> -void bench(void) {
>> -  void (*foo_ind)(void) = foo;
>> -  if ((cnt++) % 3)	/* branch (cond) */
>> -    foo();		/* call */
>> -  bar();		/* call */
>> -  foo_ind();		/* call (ind) */
>> -}
>> -int main(void)
>> -{
>> -  int cnt = 0;
>> -  while (1) {
>> -    if ((cnt++) > BENCH_RUNS)
>> -      break;
>> -    bench();		/* call */
>> -  }			/* branch (uncond) */
>> -  return 0;
>> -}
>> -EOF
>> -}
>> -
>>  test_user_branches() {
>>  	echo "Testing user branch stack sampling"
>>  
>> -	gen_test_program "$TEMPDIR/program.c"
>> -	cc -fno-inline -g "$TEMPDIR/program.c" -o $TMPDIR/a.out
>> -
>> -	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- $TMPDIR/a.out > /dev/null 2>&1
>> +	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
>>  	perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
>>  
>>  	# example of branch entries:
>> -	# 	foo+0x14/bar+0x40/P/-/-/0/CALL
>> +	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
>>  
>>  	set -x
>> -	egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/IND_CALL$"	$TMPDIR/perf.script
>> -	egrep -m1 "^foo\+[^ ]*/bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
>> -	egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/CALL$"	$TMPDIR/perf.script
>> -	egrep -m1 "^bench\+[^ ]*/bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
>> -	egrep -m1 "^bar\+[^ ]*/foo\+[^ ]*/RET$"		$TMPDIR/perf.script
>> -	egrep -m1 "^foo\+[^ ]*/bench\+[^ ]*/RET$"	$TMPDIR/perf.script
>> -	egrep -m1 "^bench\+[^ ]*/bench\+[^ ]*/COND$"	$TMPDIR/perf.script
>> -	egrep -m1 "^main\+[^ ]*/main\+[^ ]*/UNCOND$"	$TMPDIR/perf.script
>> +	egrep -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL$"	$TMPDIR/perf.script
>> +	egrep -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
>> +	egrep -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL$"	$TMPDIR/perf.script
>> +	egrep -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
>> +	egrep -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET$"		$TMPDIR/perf.script
>> +	egrep -m1 "^brstack_foo\+[^ ]*/brstsack_bench\+[^ ]*/RET$"	$TMPDIR/perf.script
> 
> Small typo here s/brstsack_bench/brstack_bench

With this typo fixed and with the other "-b" fix mentioned:

Tested-by: James Clark <james.clark@arm.com>


> 
> I think James was doing some BRBE work here, so probably best if he also gives his review/test tag.
> 
> Acked-by: German Gomez <german.gomez@arm.com>
> 
>> +	egrep -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND$"	$TMPDIR/perf.script
>> +	egrep -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND$"		$TMPDIR/perf.script
>>  	set +x
>>  
>>  	# some branch types are still not being tested:
>> @@ -88,10 +49,7 @@ test_filter() {
>>  
>>  	echo "Testing branch stack filtering permutation ($filter,$expect)"
>>  
>> -	gen_test_program "$TEMPDIR/program.c"
>> -	cc -fno-inline -g "$TEMPDIR/program.c" -o $TMPDIR/a.out
>> -
>> -	perf record -o $TMPDIR/perf.data --branch-filter $filter,save_type,u -- $TMPDIR/a.out > /dev/null 2>&1
>> +	perf record -o $TMPDIR/perf.data --branch-filter $filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
>>  	perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
>>  
>>  	# fail if we find any branch type that doesn't match any of the expected ones
