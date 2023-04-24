Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55AA6EC4C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 07:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjDXFY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 01:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjDXFYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:24:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D39B30FC;
        Sun, 23 Apr 2023 22:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682313887; x=1713849887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pDo+WzaV27eFKOaHEniUgptQBnTicerMM7HsNTWKrkI=;
  b=j98Zmgrhbw1iPOrHeoSZ1UaS8dMCUT3t8dKJL45nLj+PRcGHpjwx8ig1
   10J8//AwPB0Uz3XTHfIV8FLq/9zrl5oCMnOuq3fxAlKzkjkETUkEkl6rv
   yLS/FBx3KRPfwSkm8PWd3eZUBj8Mq4ZYKJe9aqWpGUugQErJ4FlYATFnz
   dMxMPff/bttcLPVLd3nIYeiAVdOt7Z6H/hV0tzP1d8F3WJx7eH/SmPQu7
   dqZvytTL4LYeBczSPn3+YwkB6lTncrf7yKPmJXinfiEPrLeffZDg18+r+
   J8b4YTs+0Z1NZerYu7eyMsQ4CzAETGwXrID7Q/MHhkZTxXV4VRRtaMMKz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="346385381"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="346385381"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="817121685"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="817121685"
Received: from faerberc-mobl2.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.217])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:24:42 -0700
Message-ID: <8459fe09-7f89-3713-b4b8-fddeff7d4855@intel.com>
Date:   Mon, 24 Apr 2023 08:24:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5 1/3] perf script: print raw ip instead of binary offset
 for callchain
To:     Changbin Du <changbin.du@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>
References: <20230418031825.1262579-1-changbin.du@huawei.com>
 <20230418031825.1262579-2-changbin.du@huawei.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230418031825.1262579-2-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/23 06:18, Changbin Du wrote:
> Before this, the raw ip is printed for non-callchain and dso offset for
> callchain. This inconsistent output for address may confuse people. And
> mostly what we expect is the raw ip.
> 
> 'dso offset' is printed in callchain:
> $ perf script
> ...
> ls 1341034 2739463.008343:    2162417 cycles:
>         ffffffff99d657a7 [unknown] ([unknown])
>         ffffffff99e00b67 [unknown] ([unknown])
>                    235d3 memset+0x53 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)  # dso offset
>                     a61b _dl_map_object+0x1bb (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
> 
> raw ip is printed for non-callchain:
> $ perf script  -G
> 	...
>         ls 1341034 2739463.008876:    2053304 cycles:  ffffffffc1596923 [unknown] ([unknown])
>         ls 1341034 2739463.009381:    1917049 cycles:      14def8e149e6 __strcoll_l+0xd96 (/usr/lib/x86_64-linux-gnu/libc-2.31.so) # raw ip
> 
> Let's have consistent output for it. Later I'll add a new field 'dsoff' to
> print dso offset.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/evsel_fprintf.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index a09ac00810b7..cc80ec554c0a 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -153,13 +153,8 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  			if (map)
>  				addr = map__map_ip(map, node->ip);
>  
> -			if (print_ip) {
> -				/* Show binary offset for userspace addr */
> -				if (map && !map__dso(map)->kernel)
> -					printed += fprintf(fp, "%c%16" PRIx64, s, addr);
> -				else
> -					printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
> -			}
> +			if (print_ip)
> +				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
>  
>  			if (print_sym) {
>  				printed += fprintf(fp, " ");

