Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381A75E89EF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiIXIPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbiIXINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:13:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A70C8404;
        Sat, 24 Sep 2022 01:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664007016; x=1695543016;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qk4rgPKpb4exKsQvAcw1Mt2JweFp8OmbtQi1fVR2RqM=;
  b=Qde4DbtdY0Jx4Ho/AFgcTqOFQlPJderFJEr3y8z7cDNV4PfdD4V3DTWR
   n1sf5nevp29XvtZWKxQTbOGiamCITg5BclxcKchaXoh1prxXbs55iFv8j
   ePc8noGF3LWO63VWFWZbbzjRzIM2KfDEF+pPX3RBJ9DuckM985EtRPCZI
   fnvWrYECKmD5dn/ocM3Wscek/GhEcTPDmPndK4Wqp9rQnHSrygBR6Oqd8
   W9qICa3zR4RoEIK+GbvkVA64sSEif5uKx6J+tnFrAeJF2sgUWNztmgYz0
   1M67+/6jWMWc/jjw0PlTRYFflEmCpSPawVH75KWjpdouEPyIwCTmwwj4f
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="387046756"
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="387046756"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 01:10:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="571645162"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 01:10:03 -0700
Message-ID: <7c89e623-c90f-181b-d22a-e1349ddb3340@intel.com>
Date:   Sat, 24 Sep 2022 11:09:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] perf test: Add kernel lock contention test
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20220924004221.841024-1-namhyung@kernel.org>
 <20220924004221.841024-3-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220924004221.841024-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/22 03:42, Namhyung Kim wrote:
> Add a new shell test to check if both normal perf lock record +
> contention and BPF (with -b) option are working.  Use perf bench
> sched messaging as a workload since it'd create some contention for
> sending and receiving messages.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

There are a few things below that don't need to be fixed but
are perhaps things to be aware of.

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  tools/perf/tests/shell/lock_contention.sh | 73 +++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100755 tools/perf/tests/shell/lock_contention.sh
> 
> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
> new file mode 100755
> index 000000000000..04bf604e3c6f
> --- /dev/null
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -0,0 +1,73 @@
> +#!/bin/sh
> +# kernel lock contention analysis test
> +# SPDX-License-Identifier: GPL-2.0

All the shell tests are like this, but checkpatch says:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 2
#24: FILE: tools/perf/tests/shell/lock_contention.sh:2:
+# kernel lock contention analysis test

WARNING: Misplaced SPDX-License-Identifier tag - use line 2 instead
#25: FILE: tools/perf/tests/shell/lock_contention.sh:3:
+# SPDX-License-Identifier: GPL-2.0

> +
> +set -e
> +
> +err=0
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +result=$(mktemp /tmp/__perf_test.result.XXXXX)
> +
> +cleanup() {
> +	rm -f ${perfdata}
> +	rm -f ${result}
> +	trap - exit term int
> +}
> +
> +trap_cleanup() {
> +	cleanup

With "set -e", a command failure will end up here with err=0

> +	exit ${err}
> +}
> +trap trap_cleanup exit term int

shellcheck -S warning tools/perf/tests/shell/lock_contention.sh

In tools/perf/tests/shell/lock_contention.sh line 14:
        trap - exit term int
               ^--^ SC2039: In POSIX sh, using lower/mixed case for signal names is undefined.
                    ^--^ SC2039: In POSIX sh, using lower/mixed case for signal names is undefined.
                         ^-^ SC2039: In POSIX sh, using lower/mixed case for signal names is undefined.


In tools/perf/tests/shell/lock_contention.sh line 21:
trap trap_cleanup exit term int
                  ^--^ SC2039: In POSIX sh, using lower/mixed case for signal names is undefined.
                       ^--^ SC2039: In POSIX sh, using lower/mixed case for signal names is undefined.
                            ^-^ SC2039: In POSIX sh, using lower/mixed case for signal names is undefined.


> +
> +check() {
> +	if [ `id -u` != 0 ]; then
> +		echo "[Skip] No root permission"
> +		err=2
> +		exit
> +	fi
> +
> +	if ! perf list | grep -q lock:contention_begin; then
> +		echo "[Skip] No lock contention tracepoints"
> +		err=2
> +		exit
> +	fi
> +}
> +
> +test_record()
> +{
> +	echo "Testing perf lock record and perf lock contention"
> +	perf lock record -o ${perfdata} -- perf bench sched messaging > /dev/null 2>&1
> +	# the output goes to the stderr and we expect only 1 output (-E 1)
> +	perf lock contention -i ${perfdata} -E 1 -q 2> ${result}
> +	if [ $(cat "${result}" | wc -l) != "1" ]; then
> +		echo "[Fail] Recorded result count is not 1:" $(cat "${result}" | wc -l)
> +		err=1
> +		exit
> +	fi
> +}
> +
> +test_bpf()
> +{
> +	echo "Testing perf lock contention --use-bpf"
> +
> +	if ! perf lock con -b true > /dev/null 2>&1 ; then
> +		echo "[Skip] No BPF support"
> +		exit
> +	fi
> +
> +	# the perf lock contention output goes to the stderr
> +	perf lock con -a -b -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
> +	if [ $(cat "${result}" | wc -l) != "1" ]; then
> +		echo "[Fail] BPF result count is not 1:" $(cat "${result}" | wc -l)
> +		err=1
> +		exit
> +	fi
> +}
> +
> +check
> +
> +test_record
> +test_bpf
> +
> +exit ${err}

