Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491026072C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiJUIq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiJUIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:45:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6960B11CB43;
        Fri, 21 Oct 2022 01:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666341950; x=1697877950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kR+x7msIWbhHnYPQib6tmPLIIXAqfuqEsL8Ew2hIxpc=;
  b=EkbAq5D1i+0M7QAHS/VpqeqZ0CpR+t/GII6hOpXLcQhlluY6O/lepmUH
   61IeJ3T4Q0n++9gQ1SXtn5YPDlT0bA0T0j5fUFgUp+QxB/h4c6ynEoEHJ
   Q2AYlmdYE5Sj4HVPHiBB4fjFcyfBfd678rIJG2ERtJta6WLFAXi9t86cN
   VmHhIsqtEukPiSVKnLA9LlZCWIDSWgO++pi0z++tiD77k8CBbeN0k7LBp
   LwXpFRZO71WBZemGCrCAf0IQZ1wMHtJBOcS8ftRew73iDVYJx0jl/3hic
   zenmKxKlzXPXUie/vzFNDHoH0EYG3XWYQO6HW+SwGaV5ADhUy6wzlLe0F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305687717"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="305687717"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:45:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630376899"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="630376899"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.134])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:45:43 -0700
Message-ID: <5951ac79-2fb1-5b29-b48a-3bb5683c77ce@intel.com>
Date:   Fri, 21 Oct 2022 11:45:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH 3/8] perf test: Use a test program in perf record tests
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20221020172643.3458767-1-namhyung@kernel.org>
 <20221020172643.3458767-4-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221020172643.3458767-4-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/22 20:26, Namhyung Kim wrote:
> If the system has cc it could build a test program with two threads
> and then use it for more detailed testing.  Also it accepts an option
> to run a thread forever to ensure multi-thread runs.
> 
> If cc is not found, it falls back to use the default value 'true'.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/record.sh | 64 ++++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 464071462809..952981481239 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -6,10 +6,17 @@ set -e
>  
>  err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
> +testsym="test_loop"
>  
>  cleanup() {
>    rm -f "${perfdata}"
>    rm -f "${perfdata}".old
> +
> +  if [ "${testprog}" != "true" ]; then
> +    rm -f "${testprog}"
> +  fi
> +
>    trap - EXIT TERM INT
>  }
>  
> @@ -19,9 +26,56 @@ trap_cleanup() {
>  }
>  trap trap_cleanup EXIT TERM INT
>  
> +build_test_program() {
> +  if ! [ -x "$(command -v cc)" ]; then
> +    # No CC found. Fall back to 'true'
> +    testprog=true
> +    testsym=true
> +    return
> +  fi
> +
> +  echo "Build a test program"
> +  cat <<EOF | cc -o ${testprog} -xc - -pthread
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <pthread.h>
> +
> +void test_loop(void) {
> +  volatile int count = 1000000;
> +
> +  while (count--)
> +    continue;
> +}
> +
> +void *thfunc(void *arg) {
> +  int forever = *(int *)arg;
> +
> +  do {
> +    test_loop();
> +  } while (forever);
> +
> +  return NULL;
> +}
> +
> +int main(int argc, char *argv[]) {
> +  pthread_t th;
> +  int forever = 0;
> +
> +  if (argc > 1)
> +    forever = atoi(argv[1]);
> +
> +  pthread_create(&th, NULL, thfunc, &forever);
> +  test_loop();
> +  pthread_join(th, NULL);
> +
> +  return 0;
> +}
> +EOF
> +}
> +
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
> -  if ! perf record -o /dev/null --quiet true 2> /dev/null
> +  if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
>    then
>      echo "Per-thread record [Skipped event not supported]"
>      if [ $err -ne 1 ]
> @@ -30,13 +84,13 @@ test_per_thread() {
>      fi
>      return
>    fi
> -  if ! perf record --per-thread -o "${perfdata}" true 2> /dev/null
> +  if ! perf record --per-thread -o "${perfdata}" ${testprog} 2> /dev/null
>    then
>      echo "Per-thread record [Failed record]"
>      err=1
>      return
>    fi
> -  if ! perf report -i "${perfdata}" -q | grep -q true
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
>    then
>      echo "Per-thread record [Failed missing output]"
>      err=1
> @@ -62,7 +116,7 @@ test_register_capture() {
>      return
>    fi
>    if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
> -    -c 1000 --per-thread true 2> /dev/null \
> +    -c 1000 --per-thread ${testprog} 2> /dev/null \
>      | perf script -F ip,sym,iregs -i - 2> /dev/null \
>      | grep -q "DI:"
>    then
> @@ -73,6 +127,8 @@ test_register_capture() {
>    echo "Register capture test [Success]"
>  }
>  
> +build_test_program
> +
>  test_per_thread
>  test_register_capture
>  

