Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E755067AB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjAYHiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjAYHiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:38:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC48635AA;
        Tue, 24 Jan 2023 23:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674632287; x=1706168287;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=td2yaLP75K7hdcR8vRnyCdAYZQaUWatMbukN3aHfTn0=;
  b=EEMpObBHffWjkMi1GohQFpPW4WpfsfzKK7EaPXFDiurxd7Dp1DPNnQkU
   fPF53sWlKPIRwvSSX3NIxCC6xB30Y6yRz4l25Dct202jYIng8k6dUWeQC
   LEaoUCSjDZw0IR83+ZtLgQIYAoRTNwYqkI5HWlH6hqNZgJn7idsv2AjqA
   XWtB2RkdW854R5xvGUZh/cpBhhxZFuP0aJUbwH5Qgy6pmIsz6BUN9BBwh
   xZQbcsfeWdn/sPNAvLtoVR0gWo71fU70XQ3zlF9GV9OyNXsxXFzcLh5lG
   zKAb32oLqlfKZm02D5R+wez1rKxC8rwyuOBIgzG8URQs6ESZNNJx24Ii1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="310075307"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="310075307"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 23:38:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="655719572"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="655719572"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.193])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 23:38:03 -0800
Message-ID: <231b238b-d464-464e-01d1-a2d5374a79ea@intel.com>
Date:   Wed, 25 Jan 2023 09:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH] perf/util: Symbol lookup can fail if multiple segmets
 match stext
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        David Reaver <me@davidreaver.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20230124223531.GB1962@templeofstupid.com>
 <65cb75e0-4c0b-9384-1f6b-77a0053d8109@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <65cb75e0-4c0b-9384-1f6b-77a0053d8109@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/23 09:29, Adrian Hunter wrote:

Also subject line has spelling mistake, and should identify kcore
as the issue e.g.

perf symbol: Symbol lookup with kcore can fail if multiple segments match stext

> On 25/01/23 00:35, Krister Johansen wrote:
>> This problem was encountered on an arm64 system with a lot of memory.
>> Without kernel debug symbols installed, and with both kcore and kallsyms
>> available, perf managed to get confused and returned "unknown" for all
>> of the kernel symbols that it tried to look up.
>>
>> On this system, stext fell within the vmalloc segment.  The kcore symbol
>> matching code tries to find the first segment that contains stext and
>> uses that to replace the segment generated from just the kallsyms
>> information.  In this case, however, there were two: a very large
>> vmalloc segment, and the text segment.  This caused perf to get confused
>> because multiple overlapping segments were inserted into the RB tree
>> that holds the discovered segments.  However, that alone wasn't
>> sufficient to cause the problem. Even when we could find the segment,
>> the offsets were adjusted in such a way that the newly generated symbols
>> didn't line up with the instruction addresses in the trace.  The most
>> obvious solution would be to consult which segment type is text from
>> kcore, but this information is not exposed to users.
>>
>> Instead, select the smallest matching segment that contains stext
>> instead of the first matching segment.  This allows us to match the text
>> segment instead of vmalloc, if one is contained within the other.
>>
>> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
>> ---
>>  tools/perf/util/symbol.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index a3a165ae933a..14ac4189eaff 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -1368,10 +1368,16 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>>  
>>  	/* Find the kernel map using the '_stext' symbol */
>>  	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
>> +		u64 replacement_size = 0;
> 
> We'd usually put a blank line here
> 
>>  		list_for_each_entry(new_map, &md.maps, node) {
>> -			if (stext >= new_map->start && stext < new_map->end) {
>> +			u64 new_size = new_map->end - new_map->start;
>> +
>> +			if (!(stext >= new_map->start && stext < new_map->end))
>> +				continue;
>> +
> 
> Really needs a comment, and please be specific e.g.
> 
>  ARM64 vmalloc segment overlaps the kernel text segment, so
>  choosing the smaller segment will get the kernel text.
> 
> 
> 
>> +			if (!replacement_map || new_size < replacement_size) {
>>  				replacement_map = new_map;
>> -				break;
>> +				replacement_size = new_size;
>>  			}
>>  		}
>>  	}
> 

