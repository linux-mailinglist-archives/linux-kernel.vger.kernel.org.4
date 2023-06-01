Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7FE719203
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 06:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjFAEys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 00:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjFAEyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 00:54:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198CD123;
        Wed, 31 May 2023 21:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685595284; x=1717131284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SewPFnvtVo+X+t6ckcZON8ckwT8Kc4YETG5Z6sGInsk=;
  b=C5ZErqLUKgjrRJEEjgmbSm6jQVGwgU1bkB5kJ77Eb+QXKnvpSr43SK3+
   4OlrYE7rYBpPMTWXxTCvczwbAUOzbpW65KGdyBoJWAhizdrlB8nDFompC
   +oOIgyfJQ0r1xQDoKws5QaKmfwwtH/kNQeEFWrxHW7708OF/wWg41eRvw
   c2qCAjan2Z9a5sRT7toR2hdjKqZizkyyM2QAP4JdLRKLjZWfkjZ7ZwcAB
   JJOYlECIiaP0i1iOBHko7jhrJ019IyRHPR7bYkHRXpuFcn033bhQDqe2v
   XxW7xPg9GqccVKLE70YwZGSzLR91kz0WydIsCCHeZHATUxW54+4esmcJG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="335801689"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="335801689"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 21:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="953915731"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="953915731"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.54.252])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 21:54:41 -0700
Message-ID: <dfef9c42-5b84-6720-656f-5d3ac1d8ccf5@intel.com>
Date:   Thu, 1 Jun 2023 07:54:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH] perf script: Increase PID/TID width for output
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230531203236.1602054-1-namhyung@kernel.org>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230531203236.1602054-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/23 23:32, Namhyung Kim wrote:
> On large systems, it's common that PID/TID is bigger than 5-digit and it
> makes the output unaligned.  Let's increase the width to 7.

Might be worth noting that currently the biggest PID_MAX_LIMIT
is 2^22 so pids don't get bigger than 7 digits presently.

> 
> Before:
> 
>   $ perf script
>   ...
>            swapper     0 [006] 1540823.803935:    1369324 cycles:P:  ffffffff9c755588 ktime_get+0x18 ([kernel.kallsyms])
>        gvfsd-dnssd 95114 [004] 1540823.804164:    1643871 cycles:P:  ffffffff9cfdca5c __get_user_8+0x1c ([kernel.kallsyms])
>          perf-exec 1558582 [000] 1540823.804209:    1018714 cycles:P:  ffffffff9c924ab9 __slab_free+0x9 ([kernel.kallsyms])
>              nmcli 1558589 [007] 1540823.804384:    1859212 cycles:P:      7f70537a8ad8 __strchrnul_evex+0x18 (/usr/lib/x86_64-linux-gnu/libc.so.6>
>              sleep 1558582 [000] 1540823.804456:     987425 cycles:P:      7fd35bb27b30 _dl_init+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2>
>        dbus-daemon  3043 [003] 1540823.804575:    1564465 cycles:P:  ffffffff9cb2bb70 llist_add_batch+0x0 ([kernel.kallsyms])
>              gdbus 1558592 [001] 1540823.804766:    1315219 cycles:P:  ffffffff9c797b2e audit_filter_syscall+0x9e ([kernel.kallsyms])
>     NetworkManager  3452 [005] 1540823.805301:    1558782 cycles:P:      7fa957737748 g_bit_lock+0x58 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.5>
> 
> After:
> 
>   $ perf script
>   ...
>            swapper       0 [006] 1540823.803935:    1369324 cycles:P:  ffffffff9c755588 ktime_get+0x18 ([kernel.kallsyms])
>        gvfsd-dnssd   95114 [004] 1540823.804164:    1643871 cycles:P:  ffffffff9cfdca5c __get_user_8+0x1c ([kernel.kallsyms])
>          perf-exec 1558582 [000] 1540823.804209:    1018714 cycles:P:  ffffffff9c924ab9 __slab_free+0x9 ([kernel.kallsyms])
>              nmcli 1558589 [007] 1540823.804384:    1859212 cycles:P:      7f70537a8ad8 __strchrnul_evex+0x18 (/usr/lib/x86_64-linux-gnu/libc.so.6>
>              sleep 1558582 [000] 1540823.804456:     987425 cycles:P:      7fd35bb27b30 _dl_init+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2>
>        dbus-daemon    3043 [003] 1540823.804575:    1564465 cycles:P:  ffffffff9cb2bb70 llist_add_batch+0x0 ([kernel.kallsyms])
>              gdbus 1558592 [001] 1540823.804766:    1315219 cycles:P:  ffffffff9c797b2e audit_filter_syscall+0x9e ([kernel.kallsyms])
>     NetworkManager    3452 [005] 1540823.805301:    1558782 cycles:P:      7fa957737748 g_bit_lock+0x58 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.5>
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/builtin-script.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 029d5a597233..70549fc93b12 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -801,11 +801,11 @@ static int perf_sample__fprintf_start(struct perf_script *script,
>  	}
>  
>  	if (PRINT_FIELD(PID) && PRINT_FIELD(TID))
> -		printed += fprintf(fp, "%5d/%-5d ", sample->pid, sample->tid);
> +		printed += fprintf(fp, "%7d/%-7d ", sample->pid, sample->tid);
>  	else if (PRINT_FIELD(PID))
> -		printed += fprintf(fp, "%5d ", sample->pid);
> +		printed += fprintf(fp, "%7d ", sample->pid);
>  	else if (PRINT_FIELD(TID))
> -		printed += fprintf(fp, "%5d ", sample->tid);
> +		printed += fprintf(fp, "%7d ", sample->tid);
>  
>  	if (PRINT_FIELD(CPU)) {
>  		if (latency_format)

