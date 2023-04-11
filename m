Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C586DDC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjDKNeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDKNd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:33:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C83C24;
        Tue, 11 Apr 2023 06:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681220037; x=1712756037;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ACSa9W+8xFJ/wPrK67chyTahAU/o7lM2Wo9G0gI7dRA=;
  b=Y5CnUt7AxU1G9O3bMZjdrHkQr1tyoAE5Jx7v0vbaz3W6AmLR/0BtcW9O
   b7zJDiAoi44/PwmpZ50HmEug370bQ+BR0iSm3GRW1X7wys2Q1SU0CnBs5
   hqKDw7hvx3wm/5RtrI8lWBML4yXheLX57G1z69iqG9Q5hWxjHQp+Ho04G
   bTSsmzAncSXX3N2qxE7EDt/GiCXzGbCS1ZEOxNhrDV6oPGiqpGK+Ez7zS
   KNi1XlmLrCPcRg4v7dJkzPXKS7GFc4s+RmJEA0NbXu6h2CxW4bIhHCMuZ
   50OXflkaGdqOWikoTsIJLUUq6Ste7m3afXqtLXva7KGm+ztteATxT153i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343618684"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343618684"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 06:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="832339442"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="832339442"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2023 06:33:56 -0700
Received: from [10.212.228.7] (kliang2-mobl1.ccr.corp.intel.com [10.212.228.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3939E580D1F;
        Tue, 11 Apr 2023 06:33:55 -0700 (PDT)
Message-ID: <d45c758a-4802-be12-c3a6-c39f76efbb6a@linux.intel.com>
Date:   Tue, 11 Apr 2023 09:33:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] perf tests: Fix tests in 'Parse event definition strings'
To:     tinghao.zhang@intel.com, acme@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, Yi Ammy <ammy.yi@intel.com>
References: <20230411094330.653965-1-tinghao.zhang@intel.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230411094330.653965-1-tinghao.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-11 5:43 a.m., tinghao.zhang@intel.com wrote:
> From: Tinghao Zhang <tinghao.zhang@intel.com>
> 
> The 'Test event parsing' test set under 'Parse event definion strings'
> does not apply to hybrid events. Since hybrid events have a dedicated
> test set 'Test parsing of hybrid CPU events', skip these tests on hybrid
> platforms.
> 
> Fixes: 7741e03e808a ("perf test: Parse events break apart tests")
> Reported-by: Yi Ammy <ammy.yi@intel.com>
> Signed-off-by: Tinghao Zhang <tinghao.zhang@intel.com>


This patch looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/tests/parse-events.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 71a5cb343311..c6949e458e61 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2146,6 +2146,9 @@ static int test_events(const struct evlist_test *events, int cnt)
>  
>  static int test__events2(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
> +	if (perf_pmu__has_hybrid())
> +		return TEST_SKIP;
> +
>  	return test_events(test__events, ARRAY_SIZE(test__events));
>  }
>  
> @@ -2421,7 +2424,7 @@ static int test__pmu_events_alias2(struct test_suite *test __maybe_unused,
>  static struct test_case tests__parse_events[] = {
>  	TEST_CASE_REASON("Test event parsing",
>  			 events2,
> -			 "permissions"),
> +			 "permissions or hybrid"),
>  	TEST_CASE_REASON("Test parsing of \"hybrid\" CPU events",
>  			 hybrid,
>  			"not hybrid"),
