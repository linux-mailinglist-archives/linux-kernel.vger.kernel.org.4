Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3862B5F44E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJDN4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJDN4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:56:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587C35A8A1;
        Tue,  4 Oct 2022 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664891764; x=1696427764;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OsFxBUDczropkYp8svRZ0B/r3bo5n3O17o0P0QSfJ0w=;
  b=grPkoYkRJyEs+TXlNkhZGgMHYXJ7JnKfaOl+IOT3PwNpYlZxUDyxIICY
   GFuciTYwpAkyeYO7dlQcIMQqQbtbT/KzWuCnv2DKaoXs2dwmSVCyVIAFT
   srwrAcD05WzRk6a7xtqM87gPQH7Sg/873NqVjdZdlIh1L+QX0hh5qUBl4
   JT0IMfr5Li2y4acmo5SSfTEncmw58TrZh75WEZOylMGQPxGCQ0QqqFRLC
   3Ztu0M93bE3dph0PdHG1HJ4+46lpNJE+KlNMivCzMttPByG/m7ClojScQ
   ZSflGP0FqYqc+UiTWgHqy2gZzpksk4af1Bd0B1+QUrD45EsPIp49j5oHK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="303872862"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="303872862"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 06:56:03 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="619107704"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="619107704"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.38.250])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 06:55:58 -0700
Message-ID: <6fe60739-d6fc-17d1-ddce-0be43bb5c234@intel.com>
Date:   Tue, 4 Oct 2022 16:55:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
References: <20221003204647.1481128-1-namhyung@kernel.org>
 <20221003204647.1481128-3-namhyung@kernel.org> <YzwjkwgfAyMZRHpN@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YzwjkwgfAyMZRHpN@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/22 15:14, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 03, 2022 at 01:46:44PM -0700, Namhyung Kim escreveu:
>> The current code propagate evsel's cpu map settings to evlist when it's
>> added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
>> be updated in perf_evlist__set_maps() later.  No need to do it before
>> evlist's cpus are set actually.
>>
>> In fact it discards this intermediate all_cpus maps at the beginning
>> of perf_evlist__set_maps().  Let's not do this.  It's only needed when
>> an evsel is added after the evlist cpu/thread maps are set.
>>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>  tools/lib/perf/evlist.c                  | 11 ++++-------
>>  tools/lib/perf/include/internal/evlist.h |  1 +
>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
>> index 187129652ab6..8ce92070086c 100644
>> --- a/tools/lib/perf/evlist.c
>> +++ b/tools/lib/perf/evlist.c
>> @@ -67,9 +67,7 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
>>  {
>>  	struct perf_evsel *evsel;
>>  
>> -	/* Recomputing all_cpus, so start with a blank slate. */
>> -	perf_cpu_map__put(evlist->all_cpus);
>> -	evlist->all_cpus = NULL;
>> +	evlist->needs_map_propagation = true;
>>  
>>  	perf_evlist__for_each_evsel(evlist, evsel)
>>  		__perf_evlist__propagate_maps(evlist, evsel);
>> @@ -81,7 +79,9 @@ void perf_evlist__add(struct perf_evlist *evlist,
>>  	evsel->idx = evlist->nr_entries;
>>  	list_add_tail(&evsel->node, &evlist->entries);
>>  	evlist->nr_entries += 1;
>> -	__perf_evlist__propagate_maps(evlist, evsel);
>> +
>> +	if (evlist->needs_map_propagation)
>> +		__perf_evlist__propagate_maps(evlist, evsel);
>>  }
>>  
>>  void perf_evlist__remove(struct perf_evlist *evlist,
>> @@ -177,9 +177,6 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
>>  		evlist->threads = perf_thread_map__get(threads);
>>  	}
>>  
>> -	if (!evlist->all_cpus && cpus)
>> -		evlist->all_cpus = perf_cpu_map__get(cpus);
>> -
>>  	perf_evlist__propagate_maps(evlist);
> 
> IIRC Adrian suggested this extra thing, but he provided the Reviewed-by
> for the previous patch, where this isn't present, Adrian, can you please
> confirm this and if this is the case provide your Reviewed-by for this
> new version?

Oops sorry, I meant this one:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>


> 
> Thanks,
> 
> - Arnaldo
> 
>>  }
>>  
>> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
>> index 6f89aec3e608..850f07070036 100644
>> --- a/tools/lib/perf/include/internal/evlist.h
>> +++ b/tools/lib/perf/include/internal/evlist.h
>> @@ -19,6 +19,7 @@ struct perf_evlist {
>>  	int			 nr_entries;
>>  	int			 nr_groups;
>>  	bool			 has_user_cpus;
>> +	bool			 needs_map_propagation;
>>  	/**
>>  	 * The cpus passed from the command line or all online CPUs by
>>  	 * default.
>> -- 
>> 2.38.0.rc1.362.ged0d419d3c-goog
> 

