Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ECE6D839C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjDEQ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDEQ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:26:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D9ACA;
        Wed,  5 Apr 2023 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680711965; x=1712247965;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OBPArDpGTZjCLqy9R4ICyoG2JGVamWpModrhzwKQTJE=;
  b=eQEZrZKM4DS0aZKPJ5TE/Hch5M/Q8kA/g5vhMnfUej1ou9egQueYeSgd
   tSM4Vei2GeyuyFyF8AXNwIaou4pisOg2kCQx3Auh+gQVJC6hbzSE8ygqk
   rQ08vjOz9mS3A5tx3DH7ZC6ClSvzsKWTO7DBHDH9SVzXbZ7Ldf+GXeZVt
   cQsfkUcXXCFRnUKtqolcQe/QOp1ED2sG+/vfH3rQrweHDzWo46zXIHlQY
   YkZOsaIWO0iAG4jgcq4rUy/LmxEHvobwUffv6lsoh9bXchEMc4H+x/Ov0
   S++BfuEdkOfZD5F3E2Utxhb+yCVuaEBhqLLTVvAYX8XYxLvDHY8Gg8MGI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428787799"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="428787799"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 09:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="686806956"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="686806956"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.88])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 09:25:32 -0700
Message-ID: <2aaba740-35e4-4a68-2676-63d47898378c@intel.com>
Date:   Wed, 5 Apr 2023 19:25:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v5 00/17] Reference count checker and related fixes
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
References: <20230320212248.1175731-1-irogers@google.com>
 <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
 <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
 <ZCxvYpeoemPHUmJ4@kernel.org> <ZCxyZcnd9/4zjbQZ@kernel.org>
 <527b8bcb-d462-5fff-5310-703b55902a61@intel.com>
 <ZC11tTdXuJR/M8o+@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZC11tTdXuJR/M8o+@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/04/23 16:20, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 05, 2023 at 11:47:26AM +0300, Adrian Hunter escreveu:
>> On 4/04/23 21:54, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Apr 04, 2023 at 03:41:38PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> Em Tue, Apr 04, 2023 at 08:25:41PM +0300, Adrian Hunter escreveu:
>>>>> On 4/04/23 18:58, Ian Rogers wrote:
>>>>>> Ping. It would be nice to have this landed or at least the first 10
>>>>>> patches that refactor the map API and are the bulk of the
>>>>>> lines-of-code changed. Having those landed would make it easier to
>>>>>> rebase in the future, but I also think the whole series is ready to
>>>>>> go.
>>>>>
>>>>> I was wondering if the handling of dynamic data like struct map makes
>>>>> any sense at present.  Perhaps someone can reassure me.
>>>>>
>>>>> A struct map can be updated when an MMAP event is processed.  So it
>>>>
>>>> Yes, it can, and the update is made via a new PERF_RECORD_MMAP, right?
>>>>
>>>> So:
>>>>
>>>> 	perf_event__process_mmap()
>>>> 	  machine__process_mmap2_event()
>>>> 	    map__new() + thread__insert_map(thread, map)
>>>> 	    	maps__fixup_overlappings()
>>>> 			maps__insert(thread->maps, map);
>>>>
>>>> Ok, from this point on new samples on ] map->start .. map->end ] will
>>>> grab a refcount to this new map in its hist_entry, right?
>>>>
>>>> When we want to sort by dso we will look at hist_entry->map->dso, etc.
>>>
>>> And in 'perf top' we go decaying hist entries, when we delete the
>>> hist_entry, drop the reference count to things it holds, that will then
>>> be finally deleted when no more hist_entries point to it.
>>>
>>>>> seems like anything racing with event processing is already broken, and
>>>>> reference counting / locking cannot help - unless there is also
>>>>> copy-on-write (which there isn't at present)?
>  
>> So I checked, and struct map *is* copy-on-write in
>> maps__fixup_overlappings(), so that should not be a problem.
>  
>>>>> For struct maps, referencing it while simultaneously processing
>>>>> events seems to make even less sense?
> 
>>>> Can you elaborate some more?
>  
>> Only that the maps are not necessarily stable e.g. the map that you
>> need has been replaced in the meantime.
> 
> Well, it may be sliced in several or shrunk by new ones overlapping it,
> but it if completely disappears, say a new map starts before the one
> disappearing and ends after it, then it remains with reference counts if
> there are hist_entries (or other data structure) pointing to them,
> right?
>  
>> But upon investigation, the only user at the moment is
>> maps__find_ams().  If we kept the removed maps (we used to),
>> it might be possible to make maps__find_ams() work correctly
>> in any case.
> 
> Humm, I think I see what you mean, maps__find_ams() is called when we
> are annotating a symbol, not when we're processing a sample, so it may
> be the case that at the time of annotation the executable that is being
> found (its parsing the target IP of a 'call' assembly instruction) was
> replaced, is that the case?

Yes, that is the possibility

