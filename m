Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB896072C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJUIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJUIqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:46:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC95811E47E;
        Fri, 21 Oct 2022 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666341955; x=1697877955;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MC3e58wHe4Ov1qfXX/UpYagXIF2oKZtIqFoVB0OWPpQ=;
  b=BAskgQZsTt1JqtWI+oARsz0NOAcFEJMlB+W6q5szK/JPDdRu03o31E0s
   XF5iWr4u41NNBn07ixCqGwSsDrbauBuX4EpLtck8Ueqe4CC/d5s+82l06
   IxAx3ctQIFh+Fy+/z2NeN67IXPItmqG28wH8QS/QaRaNFHwWNDV563XLt
   6w6sPiI1k6dFLuJqLzmXX2FPHN8M7PX1vnpXubjFfIJlSsJ17J5+0uiVw
   1fEVV021NGu8REsFT3cbA2Ce+sC8HQNwEtK6nJohAAHF9aDcB2zH9OQxZ
   XHWmRf+xLVPsCBD/9EGHdjDuVPhKhV7hAtqlMTyVPgj181bnlQ5xA69um
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305687725"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="305687725"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:45:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630376913"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="630376913"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.134])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:45:46 -0700
Message-ID: <723b1feb-b36b-ae7f-172d-24cbb46447ea@intel.com>
Date:   Fri, 21 Oct 2022 11:45:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH 4/8] perf test: Wait for a new thread when testing
 --per-thread record
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
 <20221020172643.3458767-5-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221020172643.3458767-5-namhyung@kernel.org>
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
> Just running the target program is not enough to test multi-thread
> target because it'd be racy perf vs target startup.  I used the
> initial delay but it cannot guarantee for perf to see the thread.
> 
> Instead, use wait_for_threads helper from shell/lib/waiting.sh to make
> sure it starts the sibling thread first.  Then perf record can use -p
> option to profile the target process.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/shell/record.sh | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 952981481239..d1640d1daf2e 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -4,6 +4,9 @@
>  
>  set -e
>  
> +shelldir=$(dirname "$0")
> +. "${shelldir}"/lib/waiting.sh
> +
>  err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
> @@ -96,6 +99,30 @@ test_per_thread() {
>      err=1
>      return
>    fi
> +
> +  # run the test program in background (forever)
> +  ${testprog} 1 &
> +  TESTPID=$!
> +
> +  rm -f "${perfdata}"
> +
> +  wait_for_threads ${TESTPID} 2
> +  perf record -p "${TESTPID}" --per-thread -o "${perfdata}" sleep 1 2> /dev/null
> +  kill ${TESTPID}
> +
> +  if [ ! -e "${perfdata}" ]
> +  then
> +    echo "Per-thread record [Failed record -p]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> +  then
> +    echo "Per-thread record [Failed -p missing output]"
> +    err=1
> +    return
> +  fi
> +
>    echo "Basic --per-thread mode test [Success]"
>  }
>  

