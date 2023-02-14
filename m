Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB58F696BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjBNRqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjBNRqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:46:11 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B0D16AE9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676396770; x=1707932770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MjXWDKZpkL6Hd3+GFgzTpPQbT0boFTVUpRHjvfgWru8=;
  b=DsIXDKKcTR3eXJs6rsiCOC8tfHIaFneYnZf8xa2o0AM6WlSUxa7Z6M2d
   XmImp3Ta35K7X+vj9/V93YPOn72Awhhc2jcP37rxVEvseupEIN6YD3lUh
   3Yrkr7lePvAKcWUfjVkaTWSueGc9J8l+zroC/+EYvcuU/HSVIB5jmg5pP
   PP2Eu+eI4MIfFKVcsV2cqjzLoNHk6aCWpSwD/1B2F7g7JBRoDzGMIqBy7
   yvq7vbn2qbZq/4fKzWHwP97XRZE6oa3IItdHXs1/lzGv8hUH5VRp3Kfv/
   DZ7cxOHIQxZwRM5SGXoUGQjVbADoCFWtuCq/6unQ0aBsCakKdOvU38KSb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="417440343"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="417440343"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:46:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="619143465"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="619143465"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2023 09:46:09 -0800
Received: from [10.251.7.65] (kliang2-mobl1.ccr.corp.intel.com [10.251.7.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 336CF580BE4;
        Tue, 14 Feb 2023 09:46:08 -0800 (PST)
Message-ID: <8dc13cf0-42f4-9ef1-1e22-de58ff743a0d@linux.intel.com>
Date:   Tue, 14 Feb 2023 12:46:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com>
 <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com>
 <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <Y+tl1ZJiWuMeKCnB@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Y+tl1ZJiWuMeKCnB@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-02-14 5:43 a.m., Peter Zijlstra wrote:
> On Mon, Feb 13, 2023 at 02:22:39PM -0800, John Stultz wrote:
>> The interpoloation is pretty easy to do:
>>
>> do {
>>     start= readtsc();
>>     clock_gett(CLOCK_MONOTONIC_RAW, &ts);
>>     end = readtsc();
>>     delta = end-start;
>> } while (delta  > THRESHOLD)   // make sure the reads were not preempted
>> mid = start + (delta +(delta/2))/2; //round-closest
>>
>> and be able to get you a fairly close matching of TSC to
>> CLOCK_MONOTONIC_RAW value.
>>
>> Once you have that mapping you can take a few samples and establish
>> the linear function.
> 
> Right, this is how we do the TSC calibration in the first place, and if
> NTP can achieve high correctness over a network, then surely we can do
> better locally.
> 
> That is, this scheme should work for all CLOCKs, not only MONOTONIC_RAW.

If I understand correctly, the TSC calibration is done in the kernel.
The kernel keeps updating the mul/shift. We dump the mul/shift into the
perf mmap page for the user tools.

But for the CLOCKs, the mul/shift is kernel internal values which we
don't want to expose to the user space.

If we only apply the scheme in the user space, it brings some observable
 errors based on my test mentioned in the other thread.

Thanks,
Kan
