Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F64606F58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJUFWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJUFWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:22:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9644022C463;
        Thu, 20 Oct 2022 22:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666329752; x=1697865752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3PJgVr8qHbN+Jff90taot4dZd0DM8HVweUC1UAiiEw8=;
  b=HAPTmDno+97duEOk69pCdYVimT3iNxU+CpHL+ox3NimV4FjzQKkFPO6J
   llVfMKvct4KgvS3CL+aZT/bbsOF+iCrwFQEbOY85j7XkbogQPPw3uXV12
   zLbj7Fw/9WgHtJV7TJ9xGcYOJhYAGX+3Qok2aEjeSe063ncMVav7uZmIK
   MX6mYw7QswUb87z/UjoIgtiR4/OWNvfRBQqaLk/jP1oTdWSglnrk8s0Gd
   4Ew2avNw5mW6HAl6FRrS69s4JnRN23H4uVJFHkkavw6/Q6LsguEZqLyT3
   dVjMPwt6Y8V3zFnF1eUxXaJ4WG8nV2LksOisW433OlopnjpbpbdNutWhv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305650388"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="305650388"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:22:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="661389478"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="661389478"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.134])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:22:28 -0700
Message-ID: <0beb829f-82e7-9caa-806e-276adc8e697f@intel.com>
Date:   Fri, 21 Oct 2022 08:22:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH] perf test: Do not fail Intel-PT misc test w/o libpython
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Ammy Yi <ammy.yi@intel.com>
References: <20221020192917.3542757-1-namhyung@kernel.org>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221020192917.3542757-1-namhyung@kernel.org>
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

On 20/10/22 22:29, Namhyung Kim wrote:
> The virtuall LBR test uses a python script to check the max size of
> branch stack in the Intel-PT generated LBR.  But it didn't check whether
> python scripting is available (as it's optional).
> 
> Let's skip the test if the python support is not available.
> 
> Fixes: f77811a0f625 ("perf test: test_intel_pt.sh: Add 9 tests")
> Cc: Ammy Yi <ammy.yi@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/test_intel_pt.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> index 4c0aabbe33bd..e66b7d977462 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -526,6 +526,12 @@ test_kernel_trace()
>  test_virtual_lbr()
>  {
>  	echo "--- Test virtual LBR ---"
> +	# Check if python script is supported
> +	libpython=$(ldd $(which perf) | grep -c python)

'which' might not be installed.  Don't about 'ldd'.

Maybe 'perf version --build-options' can be used instead e.g.

$ perf version --build-options | grep -i libpython | grep -vi off
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT

> +	if [ "${libpython}" != "1" ] ; then
> +		echo "SKIP: python scripting is not supported"
> +		return 2
> +	fi
>  
>  	# Python script to determine the maximum size of branch stacks
>  	cat << "_end_of_file_" > "${maxbrstack}"

