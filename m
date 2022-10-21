Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53596072C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiJUIql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiJUIqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:46:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567C4122BD8;
        Fri, 21 Oct 2022 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666341955; x=1697877955;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ha7NloLaREqqfPcCh6ph5TTwUFuy1F1puCKnzB50uDc=;
  b=jVXXFOue4bLnOVg+Zpg7kzTWin2Oxb6oOI5XKq+TGF02CTBPWiu/5aM5
   hXBZWHCusr4uyZlAqULVbG5P9EJgXxXLJUdGwq6K8/E90HC6NSQ9yhdDJ
   OerHbatxZvoqGepJWH5yJbTlI93+lb5S3Rp9B4pxF6Xv9Vvoat1LHzhOY
   kk8OHUsLLIq/SBlRgXjVA9YixPCqRGLPl5nmRIuaR1BajRaUEGm7rq7tX
   y/s23l7ArkH0EH88LCZkFLGnBlxcVwEFaKDhEEdQni6iudJ5etlVzesLw
   AAfTWKYBvTpTC9qsMu7PTPaYBFQCyEZiPI0UVwiGjot/iM8TnCRR+d8r+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305687731"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="305687731"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:45:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630376938"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="630376938"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.134])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:45:50 -0700
Message-ID: <b82a3829-9ea9-1dbd-7318-f6ac4e5ea94e@intel.com>
Date:   Fri, 21 Oct 2022 11:45:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH 6/8] perf test: Add target workload test in perf record
 tests
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
 <20221020172643.3458767-7-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221020172643.3458767-7-namhyung@kernel.org>
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
> Add a subtest which profiles the given workload on the command line.
> As it's a minimal requirement, test should run ok so it doesn't skip
> the test even if it failed to run the perf record.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/shell/record.sh | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 345764afb745..c59d1459c960 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -174,11 +174,29 @@ test_system_wide() {
>    echo "Basic --system-wide mode test [Success]"
>  }
>  
> +test_workload() {
> +  echo "Basic target workload test"
> +  if ! perf record -o "${perfdata}" ${testprog} 2> /dev/null
> +  then
> +    echo "Workload record [Failed record]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> +  then
> +    echo "Workload record [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  echo "Basic target workload test [Success]"
> +}
> +
>  build_test_program
>  
>  test_per_thread
>  test_register_capture
>  test_system_wide
> +test_workload
>  
>  cleanup
>  exit $err

