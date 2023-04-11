Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53556DD63B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjDKJHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjDKJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:06:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955304C0E;
        Tue, 11 Apr 2023 02:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681203944; x=1712739944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tO4l5mpv5t8dT99m/4iF2/BD89zicwZ1JuziwCmRYf8=;
  b=VDvDuoc/iZ0A1Q81zr6IWz4K/+69zZXbc9qM9RB2d0In1z2V1sOYTk3h
   wSUvsE9Mdb8H6CnAFbP3bBSm6PHKh9dLRms8t3wPL4yZaHijie6TLw1vq
   lx3plpFwzs+MFol03iDBVQJaeFYI4EM6QAWrfV1hFzpWUehmlHTKBc3wj
   rgky2JPQas5tlQTIJp4ae9PxwaSbU53TlGLur77rfIhb6cA6FMYaIeTUi
   B430iVCDgbP4O2dHAS0G05GfsE+9N5S1HK+a731o8HvoiUMLNxAmb3zNz
   HBKNT38e7qY6phq/uN0UVqWR5hSQaCNPiG1cEw0FZoRK3ow9eW2MjFQjr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="343567435"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343567435"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 02:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="753065240"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="753065240"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 02:05:40 -0700
Message-ID: <27b982f0-22cf-6a74-6ffa-7a3bb58ad3c8@intel.com>
Date:   Tue, 11 Apr 2023 12:05:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/2] perf script: print raw ip instead of binary offset
 for callchain
Content-Language: en-US
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230410070858.4051548-1-changbin.du@huawei.com>
 <20230410070858.4051548-2-changbin.du@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230410070858.4051548-2-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/23 10:08, Changbin Du wrote:
> Before this, the raw ip is printed for non-callchain and dso offset for
> callchain. This inconsistent output for address may confuse people. And
> mostly what we expect is the raw ip.

This patch does not apply anymore, refer:

	https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf-tools-next

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
> ---
>  tools/perf/util/evsel_fprintf.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index bd22c4932d10..1fb8044d402e 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -153,13 +153,8 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  			if (map)
>  				addr = map->map_ip(map, node->ip);
>  
> -			if (print_ip) {
> -				/* Show binary offset for userspace addr */
> -				if (map && !map->dso->kernel)
> -					printed += fprintf(fp, "%c%16" PRIx64, s, addr);
> -				else
> -					printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
> -			}
> +			if (print_ip)
> +				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
>  
>  			if (print_sym) {
>  				printed += fprintf(fp, " ");

