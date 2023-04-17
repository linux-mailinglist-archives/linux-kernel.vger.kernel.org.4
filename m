Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ABE6E4AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDQOIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjDQOIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:08:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034DF975F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681740454; x=1713276454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bhwRLPV34WShb6w6QjaqfrKCYZuctnWKlLTj4ixAkeM=;
  b=ZjtNMl8qr5rf6dh+lYrdk6qeFUKQJXoOmo4S+grdD0xmdWHD6NUyGO9c
   YbPQH0/w9V+nUs0JedSdgYrY3i+oHTIrv0nShEKTYIygQjqnCWDQZNvZt
   V0Uzf9yjwQkNkBzlVCtFvrscEBWOzFgGVmN+RSQoWOgSrFyFwdEPCt+48
   9XO084Uo/5uxkWHgQj4ckFB5N8va20RQiEs5gb3Ud64XzPke/Bgl0rdjf
   CiYvp1Cb1ekzJKF9p/HRQWMCdxqpqxk9GOy/ysu/nNfgKf6p7k8WDXUwV
   IYuDQ8zqU2QVyGfTm7zdGEiPpwHTbcWXAVM2qjekNCUWZqbajImauIeEL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="431190369"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="431190369"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 07:07:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="814819464"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="814819464"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 17 Apr 2023 07:07:09 -0700
Received: from [10.212.231.244] (kliang2-mobl1.ccr.corp.intel.com [10.212.231.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4AAAB580C99;
        Mon, 17 Apr 2023 07:07:08 -0700 (PDT)
Message-ID: <e83bfdc8-96d1-48df-0d5e-ea83359999e2@linux.intel.com>
Date:   Mon, 17 Apr 2023 10:07:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Content-Language: en-US
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, eranian@google.com
References: <20230414103832.GD83892@hirez.programming.kicks-ass.net>
 <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
 <20230414145324.GB761523@hirez.programming.kicks-ass.net>
 <803927bb-6f74-5c09-3c18-2fd5f423287b@linux.intel.com>
 <20230414160945.GC761523@hirez.programming.kicks-ass.net>
 <085fa11e-ea07-c148-1b32-8a09007ee12b@linux.intel.com>
 <20230414192407.GA778423@hirez.programming.kicks-ass.net>
 <2428e6a2-9578-1e1d-bdef-ffcc87301503@linux.intel.com>
 <20230414220106.GC778423@hirez.programming.kicks-ass.net>
 <d53d4df7-d0b8-2fbc-4912-f89686b5d931@linux.intel.com>
 <20230417114654.GL83892@hirez.programming.kicks-ass.net>
 <b008c6c8-5c6a-7a65-d123-058d7e8456b0@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <b008c6c8-5c6a-7a65-d123-058d7e8456b0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-17 9:37 a.m., Andi Kleen wrote:
> 
> On 4/17/2023 4:46 AM, Peter Zijlstra wrote:
>> On Fri, Apr 14, 2023 at 03:47:29PM -0700, Andi Kleen wrote:
>>>> Yeah, don't do this. There is no guarantee what so ever you'll get any
>>>> of those events in the 0-3 range.
>>>
>>> The kernel can simply force to 0-3 if LBR is enabled and the feature
>>> too.
>>> It's in Kan's patch
>>>
>>> and it isn't particularly complicated.
>> And what, totally leave 4-7 unused even if those counters were not
>> related to LBR at all? That seems exceedingly daft.
> 
> 
> Only for the events which enabled LBR and also only if the branch events
> feature is enabled
> 
> -j event -e '{event1:b,event2:b,event3:b,event4:b,event5,event6}'
> 
> event5 and 6 can go > 3
> 
> Given there is currently no syntax to control branch events inside a
> group other than fully enabling/disabling LBR.
> 
> Kan, I guess that could be added to the user tools.

We already have a per-event option for LBR, branch_type, which can be
used to control branch events in a group. With the patch in this series,
we can do, e.g.,

-j call -e
'{cpu/event=0x1,branch_type=event,/,cpu/event=0x2,branch_type=event/,cpu/event=0x3,branch_type=event/,cpu/event=0x4,branch_type=event/,cpu/event=0x5/,cpu/event=0x6/}'


Thanks,
Kan
