Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6855F651A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiJFLSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiJFLSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:18:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E41088A19;
        Thu,  6 Oct 2022 04:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEDE1618F4;
        Thu,  6 Oct 2022 11:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13154C433D7;
        Thu,  6 Oct 2022 11:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665055123;
        bh=NmgD4KwjgIP+G5CWV5Nr+UE8zmLMjwG+tcNbB1sVk/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVrVIG/l6vjZjObOaxmB4GdJ+0VdwUnMIHBos9TBagpaq2wAQaBCWs5oDETJyeWzN
         O2cpwWRyJg4JwQED9QKPuuCS+h7AYigkPje7wKfHAuAluPXraJp2yV8TWBX1DtyF9b
         wftjURf7cYOat5zeVekvHeS7uOFkh+Y8NL0KwYvRv3bmSId3fhhra+Qhs6AphbP73a
         tf4ajN5WkXWimxdWHqoLoYeG98RzGGnnT3yDcl8F8Vxk/Ty+eG6E3qBIcEz+hMBi+4
         t5q7x9+L+l/SatfPaoNCtxGbJPOWLvgHE4xtWBboSW5XAtuQgk8wGVu3EPAHOG2MuH
         RqWGVuEC8zExw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 812644062C; Thu,  6 Oct 2022 08:18:40 -0300 (-03)
Date:   Thu, 6 Oct 2022 08:18:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5] perf test: Introduce script for data symbol testing
Message-ID: <Yz65kF01XYLayp9E@kernel.org>
References: <20221006101039.47870-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006101039.47870-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 06, 2022 at 06:10:39PM +0800, Leo Yan escreveu:
> This commit introduces a shell script for data symbol testing.
> 
> The testing is designed a data structure with 64-byte alignment, it has
> two fields "data1" and "data2", and other fields are reserved.
> 
> Using "perf mem" command, we can record and report memory samples for a
> self-contained workload with 1 second duration.  If have no any memory
> sample for the data structure "buf1", it reports failure;  and by
> checking the offset in structure "buf1", if any memory accessing is not
> for "data1" and "data2" fields, it means wrong data symbol parsing and
> returns failure.

Replaced the one I had merged with v5 and added this:

Committer testing:

  [root@quaco ~]# grep -m1 "model name" /proc/cpuinfo
  model name    : Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
  [root@quaco ~]#
  [root@quaco ~]# perf test -v "data symbol"
  104: Test data symbol                                                :
  --- start ---
  test child forked, pid 192318
  Compiling test program...
  Recording workload...
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.389 MB /tmp/__perf_test.perf.data.LIuQl (5570 samples) ]
  Cleaning up files...
  test child finished with 0
  ---- end ----
  Test data symbol: Ok
  [root@quaco ~]#

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

-------------

The verbose mode could show the 'perf report' output, I think, but this
can be done later, if agreed.

Thanks, applied!

- Arnaldo
 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
> 
> Changes from v4:
> - Remove the redundant argument "--" before CPU list (Namhyung).
>   This patch is dependent on the fixing:
>   https://lore.kernel.org/lkml/20221004200211.1444521-1-namhyung@kernel.org/
> 
> Changes from v3:
> - Add specific testing chunk for AMD CPUs (Ravi).
> 
>  tools/perf/tests/shell/test_data_symbol.sh | 93 ++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_data_symbol.sh
> 
> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
> new file mode 100755
> index 000000000000..cd6eb54d235d
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_data_symbol.sh
> @@ -0,0 +1,93 @@
> +#!/bin/bash
> +# Test data symbol
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Leo Yan <leo.yan@linaro.org>, 2022
> +
> +skip_if_no_mem_event() {
> +	perf mem record -e list 2>&1 | egrep -q 'available' && return 0
> +	return 2
> +}
> +
> +skip_if_no_mem_event || exit 2
> +
> +# skip if there's no compiler
> +if ! [ -x "$(command -v cc)" ]; then
> +	echo "skip: no compiler, install gcc"
> +	exit 2
> +fi
> +
> +TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
> +PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +check_result() {
> +	# The memory report format is as below:
> +	#    99.92%  ...  [.] buf1+0x38
> +	result=$(perf mem report -i ${PERF_DATA} -s symbol_daddr -q 2>&1 |
> +		 awk '/buf1/ { print $4 }')
> +
> +	# Testing is failed if has no any sample for "buf1"
> +	[ -z "$result" ] && return 1
> +
> +	while IFS= read -r line; do
> +		# The "data1" and "data2" fields in structure "buf1" have
> +		# offset "0x0" and "0x38", returns failure if detect any
> +		# other offset value.
> +		if [ "$line" != "buf1+0x0" ] && [ "$line" != "buf1+0x38" ]; then
> +			return 1
> +		fi
> +	done <<< "$result"
> +
> +	return 0
> +}
> +
> +cleanup_files()
> +{
> +	echo "Cleaning up files..."
> +	rm -f ${PERF_DATA}
> +	rm -f ${TEST_PROGRAM}
> +}
> +
> +trap cleanup_files exit term int
> +
> +# compile test program
> +echo "Compiling test program..."
> +cat << EOF | cc -o ${TEST_PROGRAM} -x c -
> +typedef struct _buf {
> +	char data1;
> +	char reserved[55];
> +	char data2;
> +} buf __attribute__((aligned(64)));
> +
> +static buf buf1;
> +
> +int main(void) {
> +	for (;;) {
> +		buf1.data1++;
> +		buf1.data2 += buf1.data1;
> +	}
> +	return 0;
> +}
> +EOF
> +
> +echo "Recording workload..."
> +
> +# perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't support
> +# user/kernel filtering and per-process monitoring, spin program on
> +# specific CPU and test in per-CPU mode.
> +is_amd=$(egrep -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
> +if (($is_amd >= 1)); then
> +	perf mem record -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM &
> +else
> +	perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
> +fi
> +
> +PERFPID=$!
> +
> +sleep 1
> +
> +kill $PERFPID
> +wait $PERFPID
> +
> +check_result
> +exit $?
> -- 
> 2.34.1

-- 

- Arnaldo
