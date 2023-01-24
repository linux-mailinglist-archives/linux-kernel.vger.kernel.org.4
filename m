Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5BF679CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjAXPJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjAXPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:09:17 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9646720
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674572955; x=1706108955;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BZ1bras9OZjQk6cn5YA6PJrLhEhutWuitU79NN1qfdw=;
  b=d3WUJ/3o0N+9hr1gvBf3nCKuDi3SOqqBZfVIBMIn7/tGJy4Yt2yyi3Zc
   2MAsqH8VRutGmCtLOyrodfljr1rMFjUrJ28AqzxtCLGBhye1BlplKgxpx
   9EJFzBzHKTOiJYJ6DKEmiWvOxab0Icg8PmHCE9NzH3Nx6gHey41/sdVnz
   2CNLH/PdwLsEDQEDaS899xLky9hpMV8v2xI0Jepa2sEFAeJ746g23exVs
   P+0+SB/gECfO/aPKOi/XTpuZICEg0A9Hm46vDogIB91nyvrL/HAzYWMK6
   SWAK/Gi97z6fJNJOcgUImV7NYvwuM7GA4k+rsN8w+rusXVFA5WC6Ms8Mk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="306666292"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="306666292"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="786110198"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="786110198"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2023 07:04:46 -0800
Received: from [10.251.2.31] (kliang2-mobl1.ccr.corp.intel.com [10.251.2.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 361EC580B9A;
        Tue, 24 Jan 2023 07:04:45 -0800 (PST)
Message-ID: <a7a69606-544b-2cb1-9b1b-6eb7cfa139c3@linux.intel.com>
Date:   Tue, 24 Jan 2023 10:04:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/3] Convert TSC to monotonic clock for PEBS
To:     John Stultz <jstultz@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <CANDhNCo-+rV5+2pxAbpX4Lj6EhR9gsP0SqWpipm3j_G_e8cMzw@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCo-+rV5+2pxAbpX4Lj6EhR9gsP0SqWpipm3j_G_e8cMzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-24 1:13 a.m., John Stultz wrote:
> On Mon, Jan 23, 2023 at 10:27 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> A Processor Event Based Sampling (PEBS) record includes a field that
>> provide the time stamp counter value when the counter was overflowed
>> and the PEBS record was generated. The accurate time stamp can be used
>> to reconcile user samples. However, the current PEBS codes only can
>> convert the time stamp to sched_clock, which is not available from user
>> space. A solution to convert a given TSC to user visible monotonic
>> clock is required.
>>
>> The perf_event subsystem only converts the TSC in a NMI handler. The
>> converter function must be fast and NMI safe.
>>
>> Considered the below two existing functions, but none of them fulfill
>> the above requirements.
>> - The ktime_get_mono_fast_ns() is NMI safe, but it can only return the
>>   current clock monotonic rather than a given time's monotonic.
>> - The get_device_system_crosststamp() can calculate the system time from
>>   a given device time. But it's not fast and NMI safe.
> 
> So, apologies if this is a silly question (my brain quickly evicts the
> details on get_device_system_crosststamp every time I look at it), but
> rather then introducing a new interface, what would it take to rework
> the existing get_device_system_crosststamp() logic to be usable for
> both use cases?
> 

I once tried to rework the existing get_device_system_crosststamp() but
I gave up finally, because
- The existing function is already very complex. Adding a new case will
make it more complex. It's not easy to be maintained.
- Perf doesn't need all logic of the existing function. For example, the
history is not required. (I think there is no problem for perf if we
cannot get values for some corner cases. The worst case for perf is to
fallback to the time captured in the NMI handler. It's not very
accurate, but it should be acceptable.). The performance is priority
one. We want a function with much simpler logic.
- If I understand correct, we already introduced several dedicated
functions for fast NMI access, e.g., ktime_get_mono_fast_ns(). I think
we can follow the same idea.


Thanks,
Kan
