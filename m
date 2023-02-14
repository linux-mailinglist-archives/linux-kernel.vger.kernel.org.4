Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA1696E46
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjBNUJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBNUJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:09:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7C99ED2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676405355; x=1707941355;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6KTXezJdcdIsfRcOoSRe9qsBMcWZBYlAz/wYn8oJjBg=;
  b=UbCW89pVWXQQuPmT7zK3Xf20I43UmmG3OGk2Cr8XYduVK8rZZMb+2fBd
   Ei+eKutcOJWziYB25zA+5Ge9My9OFpeQ8cNf03TAO/Zbj/ayJr+XjACNU
   5c4YjeM90BJFFfNWZmyyu3ZstIF/J6jG/WdMelptSGU7j7bEeV1NxczBc
   G8EZRhmm2o4DBqLOczT9JUdyHtVSotYsdDb8rsEX21DKmKrXPlZ3T4HcT
   80Jb5BzJ7aTnMtmgLhi6YB5ZHUB2g3UnHCnQZA4oTCt6HBKeDFnCVGu7i
   0pvg+52g0FwZUCnjFPN+7xFfP/KtSByvGArLWW5zjJbrIom/JC9CuUDMy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="314903707"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="314903707"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 12:09:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="671335014"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="671335014"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 14 Feb 2023 12:09:14 -0800
Received: from [10.251.7.65] (kliang2-mobl1.ccr.corp.intel.com [10.251.7.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CDC60580B9E;
        Tue, 14 Feb 2023 12:09:12 -0800 (PST)
Message-ID: <5dc37d95-493b-cb2a-1cc7-4ea80dc22740@linux.intel.com>
Date:   Tue, 14 Feb 2023 15:09:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com>
 <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com>
 <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <Y+tl1ZJiWuMeKCnB@hirez.programming.kicks-ass.net>
 <8dc13cf0-42f4-9ef1-1e22-de58ff743a0d@linux.intel.com>
 <CANDhNCrLTBB6UaSxUhivGKv+ugnMYtCqDSDiz7o-DnE2MkC8jA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCrLTBB6UaSxUhivGKv+ugnMYtCqDSDiz7o-DnE2MkC8jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-02-14 2:37 p.m., John Stultz wrote:
> On Tue, Feb 14, 2023 at 9:46 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>> On 2023-02-14 5:43 a.m., Peter Zijlstra wrote:
>>> On Mon, Feb 13, 2023 at 02:22:39PM -0800, John Stultz wrote:
>>>> The interpoloation is pretty easy to do:
>>>>
>>>> do {
>>>>     start= readtsc();
>>>>     clock_gett(CLOCK_MONOTONIC_RAW, &ts);
>>>>     end = readtsc();
>>>>     delta = end-start;
>>>> } while (delta  > THRESHOLD)   // make sure the reads were not preempted
>>>> mid = start + (delta +(delta/2))/2; //round-closest
>>>>
>>>> and be able to get you a fairly close matching of TSC to
>>>> CLOCK_MONOTONIC_RAW value.
>>>>
>>>> Once you have that mapping you can take a few samples and establish
>>>> the linear function.
>>>
>>> Right, this is how we do the TSC calibration in the first place, and if
>>> NTP can achieve high correctness over a network, then surely we can do
>>> better locally.
>>>
>>> That is, this scheme should work for all CLOCKs, not only MONOTONIC_RAW.
>>
>> If I understand correctly, the TSC calibration is done in the kernel.
>> The kernel keeps updating the mul/shift. We dump the mul/shift into the
>> perf mmap page for the user tools.
> 
> Where is that done in the perf mmap? I wasn't aware.

The updating of the mul/shift for sched_clock should be done in the
set_cyc2ns_scale() in tsc.c

The perf user space tool mmap a page to retrieve the enabling
time/running time from the kernel. On X86 and Arm, the conversion
information from HW time (TSC) to sched_clock/perf_time is also stored
in the page. Please see the arch_perf_update_userpage(). In the perf
mmap, it only retrieve the current mul/shift information and write them
into the page for the user space tool.

This V2 patch series try to do the same thing for the monotonic raw
conversion. So the kernel internal mul/shift information has to be exposed.


Thanks,
Kan
