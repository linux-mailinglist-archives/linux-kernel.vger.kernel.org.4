Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085496E596E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjDRGaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDRGaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:30:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937B6119;
        Mon, 17 Apr 2023 23:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681799406; x=1713335406;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nDNhe3Tsv85RglO2DALJKYqrP8C4vKN59/PeHUPKaHU=;
  b=Yxq8hxop4lvETvYPt0/uyzQy5WJP5K/NlMuA2b+nr8RU9RfoTz1+AVRB
   QebcQaH/K5jFwfCCsKwxJMtTpW95Q7dS/z8uXhYj4aAt0bs3hLbgFS/8d
   nGy0uErt8Mf5mRIINn626TbB7bQ2KuqIoHQXR6E8lRqYU3nm558R7Vvkx
   5Ab/nJaS/snEz8gJ4BRtPOceS9BFvKRCjMNZePsKvVhS5BTWWos1zjesn
   TTryVgqcGZWxzc0fFjHQBC8qdJc4/8iXfzYsxkrSlil/9QWpKJFHd1xw0
   U82KaPNTOjnbBgwYPnW9wxKn+Ed17v8xmJ3zp+KzXxj+X2nZKfk/0ZpBn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="325429177"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="325429177"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 23:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="721416375"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="721416375"
Received: from choiwony-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.90])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 23:30:03 -0700
Message-ID: <d6a66fd3-b70a-3649-e13e-b3bd891de853@intel.com>
Date:   Tue, 18 Apr 2023 09:29:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 1/5] perf: Add ioctl to emit sideband events
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414082300.34798-1-adrian.hunter@intel.com>
 <20230414082300.34798-2-adrian.hunter@intel.com>
 <20230417105727.GG83892@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230417105727.GG83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/23 13:57, Peter Zijlstra wrote:
> On Fri, Apr 14, 2023 at 11:22:56AM +0300, Adrian Hunter wrote:
>> perf tools currently read /proc to get this information, but that
>> races with changes made by the kernel.
>>
>> Add an ioctl to output status-only sideband events for a currently
>> active event on the current CPU. Using timestamps, these status-only
>> sideband events will be correctly ordered with respect to "real"
>> sideband events.
>>
>> The assumption is a user will:
>> 	- open and enable a dummy event to track sideband events
>> 	- call the new ioctl to get sideband information for currently
>> 	  running processes as needed
>> 	- enable the remaining selected events
>>
>> The initial sideband events to be supported will be: fork, namespaces, comm
>> and mmap.
>>
>> Add a new misc flag PERF_RECORD_MISC_STATUS_ONLY to differentiate "real"
>> sideband events from status-only sideband events.
>>
>> The limitation that the event must be active is significant. The ioctl
>> caller must either:
>> 	i)  For a CPU context, set CPU affinity to the correct CPU.
>> 	    Note, obviously that would not need to be done for system-wide
>> 	    tracing on all CPUs. It would also only need to be done for the
>> 	    period of tracing when the ioctl is to be used.
>> 	ii) Use an event opened for the current process on all CPUs.
>> 	    Note, if such an additional event is needed, it would also use
>> 	    additional memory from the user's perf_event_mlock_kb /
>> 	    RLIMIT_MEMLOCK limit.
> 
> Why would a single per-task event not work? I see nothing in the code
> that would require a per-task-per-cpu setup. Or am I just having trouble
> reading again?

Sorry, "all CPUS" should have been "cpu=-1"

