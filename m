Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0322A74F336
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjGKPTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjGKPTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:19:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFDECE;
        Tue, 11 Jul 2023 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689088783; x=1720624783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RPEqQ1NRCXtz4rGqZRl1bYAvipwQ1TUTiiBY0hY4Ojw=;
  b=SX8uxqncaczXxLsmi4wNk4nydxfHAzfZnSh6FHjK+0dFj5cU8TDwkKrV
   G4Dey36U3bMl/In5mNJ6eZukVsEqrm5QqO/K/5QYajO5QH5PrLcYZUsd1
   /R/n3OnAyDFkfnrrzFyYslK3fG9Njut5oI/9KiGMhnDqZ/P3OLTmozkEY
   Nc+4beGVtBrUIYESDLbnwVdasG2TNyd7ZGPJ5jtVUH7cSryDtbc7I0Bov
   +iNw9O8lzGsRqK1w5yIS74xQTR57y5Bn0Ru5mFZKL9BoxAq7elqlrCrv8
   YjAvC+dAlHlnIa4NdHwDFirjwPGwPC0sZznYdzpaVHGm4ui8pKu18m7rd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367227008"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="367227008"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 08:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="750790829"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="750790829"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.50])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 08:19:39 -0700
Message-ID: <a791e982-ada3-7f26-e105-bc7fa9c7d346@intel.com>
Date:   Tue, 11 Jul 2023 18:19:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] perf machine: Include data symbols in the kernel map
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230620201818.1670753-1-namhyung@kernel.org>
 <20230620201818.1670753-3-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230620201818.1670753-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/23 23:18, Namhyung Kim wrote:
> When perf record -d is used, it needs data mmaps to symbolize global data.
> But it missed to collect kernel data maps so it cannot symbolize them.
> Instead of having a separate map, just increase the kernel map size to
> include the data section.
> 
> Probably we can have a separate kernel map for data, but the current
> code assumes a single kernel map.  So it'd require more changes in other
> places and looks error-prone.  I decided not to go that way for now.
> 
> Also it seems the kernel module size already includes the data section.
> 
> For example, my system has the following.
> 
>   $ grep -e _stext -e _etext -e _edata /proc/kallsyms
>   ffffffff99800000 T _stext
>   ffffffff9a601ac8 T _etext
>   ffffffff9b446a00 D _edata
> 
> Size of the text section is (0x9a601ac8 - 0x99800000 = 0xe01ac8) and
> size of the data section is (0x9b446a00 - 0x99800000 = 0x1c46a00).
> 
> Before:
>   $ perf record -d true
> 
>   $ perf report -D | grep MMAP | head -1
>   0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0xe01ac8) @ 0xffffffff99800000]: x [kernel.kallsyms]_text
>                                                                ^^^^^^^^
>                                                                  here
> After:
>   $ perf report -D | grep MMAP | head -1
>   0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0x1c46a00) @ 0xffffffff99800000]: x [kernel.kallsyms]_text
>                                                                ^^^^^^^^^
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/machine.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index ddc0a2130caf..e93a66f6e0b3 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1218,7 +1218,10 @@ static int machine__get_running_kernel_start(struct machine *machine,
>  
>  	*start = addr;
>  
> -	err = kallsyms__get_function_start(filename, "_etext", &addr);
> +	if (machine->has_data_mmap)
> +		err = kallsyms__get_symbol_start(filename, "_edata", &addr);
> +	else
> +		err = kallsyms__get_function_start(filename, "_etext", &addr);

What is the downside of just extending it unconditionally?

>  	if (!err)
>  		*end = addr;
>  

