Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F5174EFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjGKNNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjGKNNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:13:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E1AE55;
        Tue, 11 Jul 2023 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689081195; x=1720617195;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/7vwGw8JVVBWjjaOnf/D5yqf/lXwYo0FLMfcJLz4BCs=;
  b=m42X4evXVOAsTQFxp8vmQiFsjjNS6rE9/YxkAJifeqkYVfIDmgRwJTLA
   ydUR+2RqnXWu/g06RFmii5lmQRI4MBN6BgdBw2ut+OZK87HoE1EW893MQ
   5dXJAXRCC1MVVxOi4bjPDu3mQsXn2tE3geZ3hEJDsEq/VHQCnVuQbwuE7
   jXhdCK9wFh9iF75+nBAd9J0B3bJYyPlYJs67aRU7mqo5BK35nDDEY2y3B
   Cy9LrJY3j5xywfM5XWehLrOZJbZXU6EruLgGhfVKsh2+NH9aNpxmvcExe
   kg2HiX4lakXC7BFq8eIbwJpLcWW/DEalkoayn3Z1ZYCGyH2hjiFZF6nas
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363476461"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="363476461"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="786620591"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="786620591"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:13:12 -0700
Message-ID: <5882e592-641f-71cc-7a91-66f66b58d5a6@intel.com>
Date:   Tue, 11 Jul 2023 16:13:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 2/5] perf evlist: Add evlist__findnew_tracking_event()
 helper
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230704074217.240939-1-yangjihong1@huawei.com>
 <20230704074217.240939-3-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230704074217.240939-3-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/07/23 10:42, Yang Jihong wrote:
> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
> tracking to the evlist. We may need to search for the dummy event for
> some settings. Therefore, add evlist__findnew_tracking_event() helper.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/builtin-record.c | 11 +++--------
>  tools/perf/util/evlist.c    | 17 +++++++++++++++++
>  tools/perf/util/evlist.h    |  1 +
>  3 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index aec18db7ff23..8872cd037f2c 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1295,14 +1295,9 @@ static int record__open(struct record *rec)
>  	 */
>  	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>  	    perf_pmus__num_core_pmus() > 1) {
> -		pos = evlist__get_tracking_event(evlist);
> -		if (!evsel__is_dummy_event(pos)) {
> -			/* Set up dummy event. */
> -			if (evlist__add_dummy(evlist))
> -				return -ENOMEM;
> -			pos = evlist__last(evlist);
> -			evlist__set_tracking_event(evlist, pos);
> -		}
> +		pos = evlist__findnew_tracking_event(evlist);
> +		if (!pos)
> +			return -ENOMEM;
>  
>  		/*
>  		 * Enable the dummy event when the process is forked for
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 7ef43f72098e..4621ddaeb8f3 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1694,6 +1694,23 @@ void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_ev
>  	tracking_evsel->tracking = true;
>  }
>  
> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +
> +	evsel = evlist__get_tracking_event(evlist);
> +	if (!evsel__is_dummy_event(evsel)) {
> +		/* Set up dummy event. */
> +		if (evlist__add_dummy(evlist))

evlist__add_dummy() does not exclude_kernel so it
will end up relying on evsel__fallback() to work in
cases where the user does not have kernel access.

evlist__add_aux_dummy() is probably better suited.
Consequently perhaps pass system_wide as
a parameter to evlist__findnew_tracking_event() and
deal with that all inside evlist__findnew_tracking_event()

> +			return NULL;
> +
> +		evsel = evlist__last(evlist);
> +		evlist__set_tracking_event(evlist, evsel);
> +	}
> +
> +	return evsel;
> +}
> +
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str)
>  {
>  	struct evsel *evsel;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 664c6bf7b3e0..4d28c50ba842 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -387,6 +387,7 @@ bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr);
>  
>  struct evsel *evlist__get_tracking_event(struct evlist *evlist);
>  void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_evsel);
> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist);
>  
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
>  

