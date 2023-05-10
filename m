Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013926FD887
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjEJHtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjEJHst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:48:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F4C116;
        Wed, 10 May 2023 00:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683704928; x=1715240928;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6eDtIx2YBNgQFwjSWUq5JDTK8aEJbBLa3Av68jI/EWU=;
  b=WkcbexobUnr3XmsgD4wwDFE02uc6ssPZ9VtrWyzLI3PBcO5J6/Hf5j/5
   7tC/LwhIS86R8zCY/PzbEkC9AJcxJxe5dbnSB/j3NH68SljOTntWyq98n
   1TIuZSX8TmM4SEGporIq2qKOHO49b+3GqWJzM3lrP1oFheuNoaPQZzTbH
   4JfcTTx2ieUlowFjtVzUK/hcBCgc5+g0Ivtjxg2PmaZJ3xXbHo8gfYXGD
   BORTaZIze4OQcnguxgHQK+iyKKchiFhySIQezLYXFQ7FtH95hVF29FlZJ
   aJV2atulFn00QSMyPG9fsOU1aUxcXGQCRDQcCZqthhP8chSCmVahhhyHK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="329771253"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="329771253"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 00:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="843420747"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="843420747"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.254])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 00:48:44 -0700
Message-ID: <07770bac-cbeb-170e-b3c1-d0276d4ffef3@intel.com>
Date:   Wed, 10 May 2023 10:48:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] perf trace-event-info: Add tracepoint_id_to_name()
 helper
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, anshuman.khandual@arm.com,
        jesussanp@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230419122912.73746-1-yangjihong1@huawei.com>
 <20230419122912.73746-2-yangjihong1@huawei.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230419122912.73746-2-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/23 15:29, Yang Jihong wrote:
> Add tracepoint_id_to_name() helper to search for the trace events directory
> by given event id and return the corresponding tracepoint.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/util/trace-event-info.c | 13 +++++++++++++
>  tools/perf/util/trace-event.h      |  6 ++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
> index c24b3a15e319..79907caaf0ca 100644
> --- a/tools/perf/util/trace-event-info.c
> +++ b/tools/perf/util/trace-event-info.c
> @@ -466,6 +466,19 @@ static struct tracepoint_path *tracepoint_id_to_path(u64 config)
>  	return NULL;
>  }
>  
> +char *tracepoint_id_to_name(u64 config)
> +{
> +	char buf[MAX_EVENT_LENGTH];
> +	struct tracepoint_path *path = NULL;

Initializer should be tracepoint_id_to_path(config) i.e.

	struct tracepoint_path *path = tracepoint_id_to_path(config);

> +
> +	path = tracepoint_id_to_path(config);
> +	if (path == NULL)
> +		return NULL;
> +
> +	snprintf(buf, sizeof(buf), "%s:%s", path->system, path->name);

asprintf() can be used then buf and strdup() are not needed.

> +	return strdup(buf);
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

