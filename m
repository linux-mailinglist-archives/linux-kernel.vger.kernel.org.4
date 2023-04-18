Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5BE6E5A02
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjDRHD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDRHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:03:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C18C10FA;
        Tue, 18 Apr 2023 00:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681801433; x=1713337433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x7Uu3N5QkafQkge6vp0KSOnHXwk6jftMqow55HlSYc4=;
  b=FeQIFYA9h/lo6gXy3V+ERW4Gf4eBTtYl3guVVAyRTAQ0t6BW17QnjhyU
   MLRaBu/I+cX0Q+yvH+zYZJr1ElpFi7ppIPAhnsI0KtFEWJdp7ft9O7fyp
   kvta7UAcHRa0f7lmcVWmefG1O3qR/54w/8uyrUIb9KWzfF5feJBFD6nMo
   D7dLuln6+hCoYwPL98IMq2m9KQu1bUddzqLOSS+Uymzv/DA+NenPl7xlF
   H+Qgui5qxFXhAzdGCrKLIIWUs5aouGjTWmnuqbMpkYAYYSjwzrUxLGqYa
   dbIlLX5eOkDbEfIaT8QUwLoYVy70OGIC9F5qRD01UZKVb44pAfDX/SYnz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="407991827"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="407991827"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 00:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="690977399"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="690977399"
Received: from choiwony-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.90])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 00:03:48 -0700
Message-ID: <e7409ef9-0a80-9874-ef60-0fab0abb9711@intel.com>
Date:   Tue, 18 Apr 2023 10:03:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 0/5] perf: Add ioctl to emit sideband events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414082300.34798-1-adrian.hunter@intel.com>
 <20230417110221.GH83892@hirez.programming.kicks-ass.net>
 <CAP-5=fUD=RNqD-7229J5fgaUCMtNiu-urp-9B3LDq8JnP2sGBg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fUD=RNqD-7229J5fgaUCMtNiu-urp-9B3LDq8JnP2sGBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/23 19:37, Ian Rogers wrote:
> On Mon, Apr 17, 2023 at 4:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Fri, Apr 14, 2023 at 11:22:55AM +0300, Adrian Hunter wrote:
>>> Hi
>>>
>>> Here is a stab at adding an ioctl for sideband events.
>>>
>>> This is to overcome races when reading the same information
>>> from /proc.
>>
>> What races? Are you talking about reading old state in /proc the kernel
>> delivering a sideband event for the new state, and then you writing the
>> old state out?
>>
>> Surely that's something perf tool can fix without kernel changes?
> 
> So my reading is that during event synthesis there are races between
> reading the different /proc files. There is still, I believe, a race
> in with perf record/top with uid filtering which reminds me of this.
> The uid filtering race is that we scan /proc to find processes (pids)
> for a uid, we then synthesize the maps for each of these pids but if a
> pid starts or exits we either error out or don't sample that pid. I
> believe the error out behavior is easy to hit 100% of the time making
> uid mode of limited use.
> 
> This may be for something other than synthesis, but for synthesis a
> few points are:
>  - as servers get bigger and consequently more jobs get consolidated
> on them, synthesis is slow (hence --num-thread-synthesize) and also
> the events dominate the perf.data file - perhaps >90% of the file
> size, and a lot of that will be for processes with no samples in them.

Note also, for hardware tracing, it isn't generally possible to know
that during tracing, and figuring it out afterwards and working
backwards may not be feasible.

> Another issue here is that all those file descriptors don't come for
> free in the kernel.
>  - BPF has buildid+offset stack traces that remove the need for
> synthesis by having more expensive stack generation. I believe this is
> unpopular as adding this as a variant for every kind of event would be
> hard, but perhaps we can do some low-hanging fruit like instructions
> and cycles.
>  - I believe Jiri looked at doing synthesis with BPF. Perhaps we could
> do something similar to the off-cpu and tail-synthesize, where more
> things happen at the tail end of perf. Off-cpu records data in maps
> that it then synthesizes into samples.
> 
> There is also a long standing issue around not sampling munmap (or
> mremap) that causes plenty of issues. Perhaps if we had less mmap in
> the perf.data file we could add these.
> 
> Thanks,
> Ian

