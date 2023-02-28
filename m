Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B146A578B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjB1LMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjB1LMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:12:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2A332BEDF;
        Tue, 28 Feb 2023 03:12:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5011C14;
        Tue, 28 Feb 2023 03:13:04 -0800 (PST)
Received: from [10.57.51.147] (unknown [10.57.51.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F86B3F881;
        Tue, 28 Feb 2023 03:12:18 -0800 (PST)
Message-ID: <678c5939-f512-d4f8-e290-9c0f2bf05023@arm.com>
Date:   Tue, 28 Feb 2023 11:12:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 13/14] perf kvm: Add TUI mode for stat report
To:     Leo Yan <leo.yan@linaro.org>
References: <20230228084147.106167-1-leo.yan@linaro.org>
 <20230228084147.106167-14-leo.yan@linaro.org>
Content-Language: en-US
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230228084147.106167-14-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/02/2023 08:41, Leo Yan wrote:
> Since we have supported histograms list and prepared the dimensions in
> the tool, this patch adds TUI mode for stat report.  It also adds UI
> progress for sorting for better user experience.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-kvm.c   | 110 ++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/kvm-stat.h |   1 +
>  2 files changed, 109 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 5b1b2042dfed..b0be59577779 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -23,6 +23,8 @@
>  #include "util/data.h"
>  #include "util/ordered-events.h"
>  #include "util/kvm-stat.h"
> +#include "ui/browsers/hists.h"
> +#include "ui/progress.h"
>  #include "ui/ui.h"
>  #include "util/string2.h"
>  
> @@ -506,10 +508,98 @@ static int kvm_hists__init(struct perf_kvm_stat *kvm)
>  
>  	__hists__init(&kvm_hists.hists, &kvm_hists.list);
>  	perf_hpp_list__init(&kvm_hists.list);
> +	kvm_hists.list.nr_header_lines = 1;
>  	return kvm_hpp_list__parse(&kvm_hists.list, output_columns,
>  				   kvm->sort_key);
>  }
>  
> +static int kvm_browser__title(struct hist_browser *browser,
> +			      char *buf, size_t size)
> +{
> +	scnprintf(buf, size, "KVM event statistics (%lu entries)",
> +		  browser->nr_non_filtered_entries);
> +	return 0;
> +}
> +
> +static struct hist_browser*
> +perf_kvm_browser__new(struct hists *hists)
> +{
> +	struct hist_browser *browser = hist_browser__new(hists);
> +
> +	if (browser)
> +		browser->title = kvm_browser__title;
> +
> +	return browser;
> +}
> +
> +static void print_result(struct perf_kvm_stat *kvm);
> +
> +#ifdef HAVE_SLANG_SUPPORT

Hi Leo,

I get an error because of this addition when building on x86. I think
it's because I don't have HAVE_SLANG_SUPPORT. It might be the same error
that you mentioned on v1?

   builtin-kvm.c:535:13: error: ‘print_result’ used but never defined
[-Werror]
   535 | static void print_result(struct perf_kvm_stat *kvm);

Other than that, for the whole set:

Reviewed-by: James Clark <james.clark@arm.com>

