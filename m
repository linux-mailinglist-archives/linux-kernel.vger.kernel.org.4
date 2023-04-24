Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C686ED3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjDXRum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjDXRuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:50:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2696A78
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682358637; x=1713894637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ziePy92IPPK6glem4eSx9yH7EIhypT1MNm01nLVUDgI=;
  b=R2UmlEh+vsRiPH7CjK4ywtft7FpJDzTLQ8S0fy8AubWGKwrB3bG4VzSR
   oAPKkmL8fUtPmCLYDhe2emgEo94CCINSLPiguDm+eP1ycsgjWATBFbi+x
   KFZqSuORCh5Ja9/6UwN2paPhUv8rsTeQ01ppRRau8ZllVdUauWpDSZQ3y
   qhTy+/Inxo7rs3XE97Rs3fF5IklaoIGV8pqgzhYX13d9zHsvB+JR2kNBI
   LvsBF8uSWDdjHZgJQ10B7T1ZpbPa/r9kSWsil7CshVWpeCyhCI0CuETDT
   O7RzgVat+cKUPT4I9lB/d5x8VMcZDYJy2HDYvpMM1snzrs9+GAz73icXC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="432792707"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="432792707"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 10:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="867567531"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="867567531"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 24 Apr 2023 10:50:20 -0700
Received: from [10.212.171.72] (kliang2-mobl1.ccr.corp.intel.com [10.212.171.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4B847580C6E;
        Mon, 24 Apr 2023 10:50:19 -0700 (PDT)
Message-ID: <dd0fdd1b-b906-dc5c-9302-660c5ae1643a@linux.intel.com>
Date:   Mon, 24 Apr 2023 13:50:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] perf evsel: Introduce evsel__name_is() method to
 check if the evsel name is equal to a given string
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <ZEGLM8VehJbS0gP2@kernel.org> <ZEGOJuJd4uLS2392@kernel.org>
 <ZEGSU5DrAODcLmc3@kernel.org>
 <7de5c749-5960-2fa1-d48a-be360b08d5e1@linux.intel.com>
 <ZEa7h8ZCAS+dHTBL@kernel.org> <ZEa8DWkBw6GStTzx@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZEa8DWkBw6GStTzx@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-24 1:27 p.m., Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 24, 2023 at 02:25:27PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Apr 20, 2023 at 05:16:18PM -0400, Liang, Kan escreveu:
>>>
>>>
>>> On 2023-04-20 3:28 p.m., Arnaldo Carvalho de Melo wrote:
>>>> Em Thu, Apr 20, 2023 at 04:10:30PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>> Em Thu, Apr 20, 2023 at 03:57:55PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>> This makes the logic a bit clear by avoiding the !strcmp() pattern and
>>>>>> also a way to intercept the pointer if we need to do extra validation on
>>>>>> it or to do lazy setting of evsel->name via evsel__name(evsel).
>>>>>
>>>>> + this, looking if there are others...
>>>>
>>>> Somehow the first message didn't go thru, so below is the combined
>>>> patch, this is an effort to avoid accessing evsel->name directly as the
>>>> preferred way to get an evsel name is evsel__name(), so looking for
>>>> direct access and providing accessors that avoid that.
>>>
>>> One more
>>>
>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>>> index 2260e27adf44..3a960a3f6962 100644
>>> --- a/tools/perf/util/evlist.c
>>> +++ b/tools/perf/util/evlist.c
>>> @@ -467,7 +467,7 @@ static int evsel__strcmp(struct evsel *pos, char
>>> *evsel_name)
>>>  		return 0;
>>>  	if (evsel__is_dummy_event(pos))
>>>  		return 1;
>>> -	return strcmp(pos->name, evsel_name);
>>> +	return !evsel__name_is(pos, evsel_name);
>>>  }
>>>
>>>  static int evlist__is_enabled(struct evlist *evlist)
>>
>> Added
>>  
>>>>
>>>> From e60455d6a4e35ba0c376966443294586a1adc3ec Mon Sep 17 00:00:00 2001
>>>> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>> Date: Thu, 20 Apr 2023 15:54:11 -0300
>>>> Subject: [PATCH 1/1] perf evsel: Introduce evsel__name_is() method to check if
>>>>  the evsel name is equal to a given string
>>>>
>>>> This makes the logic a bit clear by avoiding the !strcmp() pattern and
>>>> also a way to intercept the pointer if we need to do extra validation on
>>>> it or to do lazy setting of evsel->name via evsel__name(evsel).
>>>>
>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>> Cc: Ian Rogers <irogers@google.com>
>>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>>> Cc: "Liang, Kan" <kan.liang@linux.intel.com>
>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>> Link: https://lore.kernel.org/lkml/ZEGLM8VehJbS0gP2@kernel.org
>>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>
>>> With the above one,
>>>
>>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>
>> Added these extra ones and actually made evsel__name_is() use
>> evsel__name().
>>
>> Does your reviewed-by stands after these extra changes?
>

Yes, the below extra changes look good to me as well.

Thanks,
Kan

> 
> oops, fix that pos->name leftover:
> 
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 2260e27adf44c579..a0504316b06fbcba 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -467,7 +467,7 @@ static int evsel__strcmp(struct evsel *pos, char *evsel_name)
>  		return 0;
>  	if (evsel__is_dummy_event(pos))
>  		return 1;
> -	return strcmp(pos->name, evsel_name);
> +	return !evsel__name_is(pos, evsel_name);
>  }
>  
>  static int evlist__is_enabled(struct evlist *evlist)
> @@ -1706,7 +1706,7 @@ struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str)
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (!evsel->name)
>  			continue;
> -		if (strcmp(str, evsel->name) == 0)
> +		if (evsel__name_is(evsel, str))
>  			return evsel;
>  	}
>  
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 81b854650160c2b0..356c07f03be6bfce 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -823,7 +823,7 @@ const char *evsel__name(struct evsel *evsel)
>  
>  bool evsel__name_is(struct evsel *evsel, const char *name)
>  {
> -	return !strcmp(evsel->name, name);
> +	return !strcmp(evsel__name(evsel), name);
>  }
>  
>  const char *evsel__group_pmu_name(const struct evsel *evsel)
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 31b1cd0935e277ba..650cd8df40412a38 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -2893,7 +2893,7 @@ static struct evsel *find_evsel(struct evlist *evlist, char *event_name)
>  	full_name = !!strchr(event_name, ':');
>  	evlist__for_each_entry(evlist, pos) {
>  		/* case 2 */
> -		if (full_name && !strcmp(pos->name, event_name))
> +		if (full_name && evsel__name_is(pos, event_name))
>  			return pos;
>  		/* case 3 */
>  		if (!full_name && strstr(pos->name, event_name)) {
