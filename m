Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3D46072C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiJUIqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJUIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:45:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D481011B3;
        Fri, 21 Oct 2022 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666341941; x=1697877941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cYOVDmVnHFmOhRPj54AdvODl3iGXcWytkrbCDiD1aNE=;
  b=YC0ZvcIoOstHH6c2ZZ03zxRg5A9i69hVm++JmFoYAYvZEVzexKbG/iK5
   KcRrpKV5Gb4j8qWWrrgSijTsRUjjVhW3/46RJVvw8NPzZjrR0SkTZjR6O
   FA9WV0Nw+p68TOt/vcJOAw3VjoyflFkI2jVDWDVu33zimwGKuCdfHY86h
   7ETE0BaCP7wFVv6h5WRaC/CWYpxYLTSeT6AqNNWGsGHvsqfJ4j3+fM0g3
   doFFeR6oyujZbyK68Upq3leE9BED9ctWYlnZSdxtf1mBw5c5NSUWivyxW
   umdwLyo5lyYrt/o/5QwfcEhX8l6i38txijYBxLGviAcB/F8iLvQGM7LHt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305687689"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="305687689"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:45:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630376835"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="630376835"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.134])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:45:37 -0700
Message-ID: <d7f62f27-b9a3-cd56-2490-dd1695fc747e@intel.com>
Date:   Fri, 21 Oct 2022 11:45:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH 7/8] perf test: Test record with --threads option
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
 <20221020172643.3458767-8-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221020172643.3458767-8-namhyung@kernel.org>
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
> The --threads option changed the perf record behavior significantly, so
> it'd be nice if we test it separately.  Add --threads options with
> different argument in each test supported and check the result.
> 
> Also update the cleanup routine because threads recording produces data
> in a directory.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index c59d1459c960..01aa9531b369 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -13,8 +13,8 @@ testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
>  testsym="test_loop"
>  
>  cleanup() {
> -  rm -f "${perfdata}"
> -  rm -f "${perfdata}".old
> +  rm -rf "${perfdata}"
> +  rm -rf "${perfdata}".old
>  
>    if [ "${testprog}" != "true" ]; then
>      rm -f "${testprog}"
> @@ -171,6 +171,19 @@ test_system_wide() {
>      err=1
>      return
>    fi
> +  if ! perf record -aB --synth=no -e cpu-clock,cs --threads=cpu \
> +    -o "${perfdata}" ${testprog} 2> /dev/null
> +  then
> +    echo "System-wide record [Failed record --threads option]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> +  then
> +    echo "System-wide record [Failed --threads missing output]"
> +    err=1
> +    return
> +  fi
>    echo "Basic --system-wide mode test [Success]"
>  }
>  
> @@ -188,6 +201,19 @@ test_workload() {
>      err=1
>      return
>    fi
> +  if ! perf record -e cpu-clock,cs --threads=package \
> +    -o "${perfdata}" ${testprog} 2> /dev/null
> +  then
> +    echo "Workload record [Failed record --threads option]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> +  then
> +    echo "Workload record [Failed --threads missing output]"
> +    err=1
> +    return
> +  fi
>    echo "Basic target workload test [Success]"
>  }
>  

