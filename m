Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201946094DE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiJWQqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiJWQqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:46:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621A760693;
        Sun, 23 Oct 2022 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666543607; x=1698079607;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jjcKY1AML8veP32zA0GqudSRI7EtoeO02Jl9LYsqrDo=;
  b=NpTX5Xga9aSrhML8woht6b2geJgH6dAk4X6L4VlxEPFRUL5X1LaBpNZx
   FAUXG4vn3Nj06NuzhehwjkjJGmNpeFsCgIOnDvIVs0dj2rM4bC+fVoXNf
   v3aAVtT/bfx8jDYI+nNYICDCY9674/IXGBh1xbFZQGfY3TsdJo3uznhvF
   lwn03B+rxpIZjtMhEdwqFkOjiz9HAPWTKRe390PNP38K+2jgC93iuarc9
   AWRiKdEqYMw4eSZ2yEg+QcyM8w/buceQ4nNUeiqGMFc2g7wrAPPue1Y4v
   zqIP0a2v+TBz5hIC6m45ShI5yRPIkDJ04fK+hvws0dw1VI5PB1Nd9YS9H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="371501093"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="371501093"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 09:46:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="582191192"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="582191192"
Received: from etyuvae-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.32])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 09:46:44 -0700
Message-ID: <f79b22ea-2018-cb57-81b3-cdab2f66ea67@intel.com>
Date:   Sun, 23 Oct 2022 19:46:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v2] perf test: Do not fail Intel-PT misc test w/o
 libpython
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Ammy Yi <ammy.yi@intel.com>
References: <20221021181055.60183-1-namhyung@kernel.org>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221021181055.60183-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/22 21:10, Namhyung Kim wrote:
> The virtuall LBR test uses a python script to check the max size of
> branch stack in the Intel-PT generated LBR.  But it didn't check whether
> python scripting is available (as it's optional).
> 
> Let's skip the test if the python support is not available.
> 
> Fixes: f77811a0f625 ("perf test: test_intel_pt.sh: Add 9 tests")
> Cc: Ammy Yi <ammy.yi@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/shell/test_intel_pt.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> index 4c0aabbe33bd..f5ed7b1af419 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -526,6 +526,12 @@ test_kernel_trace()
>  test_virtual_lbr()
>  {
>  	echo "--- Test virtual LBR ---"
> +	# Check if python script is supported
> +	libpython=$(perf version --build-options | grep python | grep -cv OFF)
> +	if [ "${libpython}" != "1" ] ; then
> +		echo "SKIP: python scripting is not supported"
> +		return 2
> +	fi
>  
>  	# Python script to determine the maximum size of branch stacks
>  	cat << "_end_of_file_" > "${maxbrstack}"

