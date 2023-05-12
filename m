Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE77005AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbjELKec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240645AbjELKeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:34:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693F912492;
        Fri, 12 May 2023 03:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683887613; x=1715423613;
  h=message-id:date:mime-version:from:subject:to:references:
   in-reply-to:content-transfer-encoding;
  bh=/zL9B3y256x+WcUzPppGfr9xXV82oxf98bzuketet9s=;
  b=PgSnU8SXBBnBIHp8C2kAqLnLsiIfsYsYzW+g+0dkoS4rHSF83dV6UaNR
   DXKyQpKve2OxbySJo3N6SzAilyQJ4l0cnTXQqX71PsKeVEfEtDUbwHLN3
   eH3BvKLFgMVLT9tv2AvIGV2CZSsKkzt4ZSBDvbXMzyYAk2UMI6T7OSTsR
   sRQkdE0bdxDwA5DFCPW2bOQsCAOfHK2m234PtZtFGInek8bX/C4ejsgzv
   dYj3t9O6Fej1bmizI/M+p34GxEJQQGm2U3NWWfh4lBqu1ZOOTFd1R2Y/P
   64FR7UR7Cj78iQBHDC0nB/rKfIiU8SypRIo4DD7Q7qv90GrUbjFWXr0Q2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335278641"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="335278641"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:33:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="765136113"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="765136113"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.197])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:33:25 -0700
Message-ID: <14f09d56-d4f1-8602-6a98-5588cbef8c81@intel.com>
Date:   Fri, 12 May 2023 13:33:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/4] perf trace-event-info: Add tracepoint_id_to_name()
 helper
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, anshuman.khandual@arm.com,
        jesussanp@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230511075154.240163-1-yangjihong1@huawei.com>
 <20230511075154.240163-2-yangjihong1@huawei.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230511075154.240163-2-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/23 10:51, Yang Jihong wrote:
> Add tracepoint_id_to_name() helper to search for the trace events directory
> by given event id and return the corresponding tracepoint.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/util/trace-event-info.c | 11 +++++++++++
>  tools/perf/util/trace-event.h      |  6 ++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
> index c24b3a15e319..a5c65cb02a28 100644
> --- a/tools/perf/util/trace-event-info.c
> +++ b/tools/perf/util/trace-event-info.c
> @@ -466,6 +466,17 @@ static struct tracepoint_path *tracepoint_id_to_path(u64 config)
>  	return NULL;
>  }
>  
> +char *tracepoint_id_to_name(u64 config)
> +{
> +	char *buf = NULL;
> +	struct tracepoint_path *path = tracepoint_id_to_path(config);

It is considered slightly nicer to put local declarations
in descending order of line length. i.e.

	struct tracepoint_path *path = tracepoint_id_to_path(config);
	char *buf = NULL;

> +
> +	if ((path != NULL) && (asprintf(&buf, "%s:%s", path->system, path->name) > 0))

The parentheses are unnecessary and kernel style tends to avoid "!= NULL"
i.e.

	if (path && asprintf(&buf, "%s:%s", path->system, path->name) > 0)

> +		return buf;
> +
> +	return NULL;
> +}
> +
>  static struct tracepoint_path *tracepoint_name_to_path(const char *name)
>  {
>  	struct tracepoint_path *path = zalloc(sizeof(*path));
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index a0cff184b1cd..a69ee29419f3 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -62,6 +62,12 @@ unsigned long long eval_flag(const char *flag);
>  
>  int read_tracing_data(int fd, struct list_head *pattrs);
>  
> +/*
> + * Return the tracepoint name in the format "subsystem:event_name",
> + * callers should free the returned string.
> + */
> +char *tracepoint_id_to_name(u64 config);
> +
>  struct tracing_data {
>  	/* size is only valid if temp is 'true' */
>  	ssize_t size;

