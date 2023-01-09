Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE656662985
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbjAIPM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbjAIPMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:12:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDA666564;
        Mon,  9 Jan 2023 07:11:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 580501042;
        Mon,  9 Jan 2023 07:12:33 -0800 (PST)
Received: from [10.57.37.91] (unknown [10.57.37.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8269F3F587;
        Mon,  9 Jan 2023 07:11:49 -0800 (PST)
Message-ID: <14dd06c2-39f8-ccb5-ce59-f3a1e45c94d0@arm.com>
Date:   Mon, 9 Jan 2023 15:11:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] perf kmem: Support legacy tracepoints
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
References: <20230108062400.250690-1-leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230108062400.250690-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2023 06:23, Leo Yan wrote:
> Commit 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of
> tracepoints") removed tracepoints 'kmalloc_node' and
> 'kmem_cache_alloc_node', these two tracepoints have disappeared in the
> latest kernel, but we also need to consider the tool should be backward
> compatible with old kernels.
> 
> If detects the tracepoint "kmem:kmalloc_node" is existed on a system,
> this patch enables the legacy tracepoints, otherwise, it will ignore
> them for the new kernels.
> 
> Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Fixes: 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of tracepoints")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-kmem.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index e20656c431a4..50a3df5dc18a 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -1824,6 +1824,19 @@ static int parse_line_opt(const struct option *opt __maybe_unused,
>  	return 0;
>  }
>  
> +static bool slab_legacy_tp_is_exposed(void)
> +{
> +	/*
> +	 * The tracepoints "kmem:kmalloc_node" and
> +	 * "kmem:kmem_cache_alloc_node" have been removed on the latest
> +	 * kernel, if the tracepoint "kmem:kmalloc_node" is existed it
> +	 * means the tool is running on an old kernel, we need to
> +	 * rollback to support these legacy tracepoints.
> +	 */
> +	return IS_ERR(trace_event__tp_format("kmem", "kmalloc_node")) ?
> +		false : true;
> +}
> +
>  static int __cmd_record(int argc, const char **argv)
>  {
>  	const char * const record_args[] = {
> @@ -1831,22 +1844,28 @@ static int __cmd_record(int argc, const char **argv)
>  	};
>  	const char * const slab_events[] = {
>  	"-e", "kmem:kmalloc",
> -	"-e", "kmem:kmalloc_node",
>  	"-e", "kmem:kfree",
>  	"-e", "kmem:kmem_cache_alloc",
> -	"-e", "kmem:kmem_cache_alloc_node",
>  	"-e", "kmem:kmem_cache_free",
>  	};
> +	const char * const slab_legacy_events[] = {
> +	"-e", "kmem:kmalloc_node",
> +	"-e", "kmem:kmem_cache_alloc_node",
> +	};

Reviewed-by: James Clark <james.clark@arm.com>

This fixes the error with mem:kmalloc_node for me.

I was thinking that it might be best to add all events to the list
conditionally instead of just the legacy ones. That way, the same error
won't happen in the future. But maybe it's best to have an explicit
error again in case the breaking change was unintentional so it's fine
as it is I think.

James

