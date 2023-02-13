Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8384E695344
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBMVlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjBMVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:41:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC54CDD6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676324468; x=1707860468;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I+Do5yG6CSTWM/1NENZGpIrLn3nrV0kj+LIwDd2hl3o=;
  b=TBKrMG6sPu0550tz1gyC9tlKvS4+TjULSM7pbbGvpyR3A80h5zORsnm8
   rdQG3RtF3MgQPlk/Abidqz/545z9KxLqaLoBHq1p3lDrt98zDdLECUvwD
   xDioa6Ed9gvafBNLjAdpO8KsgOwOBQk1OpXtX5jHz+yuYj05lbBflLr1S
   fg577RU8IHSA7QHfmLfiDwp2P4pzcl4GL6GlcRWocwN3WYuVoOi8r38CK
   ex9xQdumD0GGEsK1rjlL7m+IKlbGW1wjFlewMLPZIcR0cftWVXvJmfVQh
   +W9zQ2FoLpW6Nve0Zc9i8mkuSsnAC9iuUkq8ym97ZedtVHIrVxTwXn6pl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="314652877"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="314652877"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 13:40:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="997828871"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="997828871"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 13 Feb 2023 13:40:46 -0800
Received: from [10.251.27.51] (kliang2-mobl1.ccr.corp.intel.com [10.251.27.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7ABEB580BE4;
        Mon, 13 Feb 2023 13:40:45 -0800 (PST)
Message-ID: <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com>
Date:   Mon, 13 Feb 2023 16:40:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
Content-Language: en-US
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com>
 <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
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



On 2023-02-13 2:37 p.m., John Stultz wrote:
> On Mon, Feb 13, 2023 at 11:08 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The monotonic raw clock is not affected by NTP/PTP correction. The
>> calculation of the monotonic raw clock can be done in the
>> post-processing, which can reduce the kernel overhead.
>>
>> Add hw_time in the struct perf_event_attr to tell the kernel dump the
>> raw HW time to user space. The perf tool will calculate the HW time
>> in post-processing.
>> Currently, only supports the monotonic raw conversion.
>> Only dump the raw HW time with PERF_RECORD_SAMPLE, because the accurate
>> HW time can only be provided in a sample by HW. For other type of
>> records, the user requested clock should be returned as usual. Nothing
>> is changed.
>>
>> Add perf_event_mmap_page::cap_user_time_mono_raw ABI to dump the
>> conversion information. The cap_user_time_mono_raw also indicates
>> whether the monotonic raw conversion information is available.
>> If yes, the clock monotonic raw can be calculated as
>> mono_raw = base + ((cyc - last) * mult + nsec) >> shift
> 
> Again, I appreciate you reworking and resending this series out, I
> know it took some effort.
> 
> But oof, I'd really like to make sure we're not exporting timekeeping
> internals to userland.
> 
> I think Thomas' suggestion of doing the timestamp conversion in
> post-processing was more about interpolating collected system times
> with the counter (tsc) values captured.
>

Thomas, could you please clarify your suggestion regarding "the relevant
conversion information" provided by the kernel?
https://lore.kernel.org/lkml/87ilgsgl5f.ffs@tglx/

Is it only the interpolation information or the entire conversion
information (Mult, shift etc.)?

If it's only the interpolation information, the user space will be lack
of information to handle all the cases. If I understand John's comments
correctly, it could also bring some interpolation error which can only
be addressed by the mult/shift conversion.

If the suggestion is to dump the entire conversion information into the
user space, we have to expose the timekeeping internals.

Considering the above difficulties, could we use the kernel conversion?
(The current perf already uses the kernel conversion for monotonic raw.
It should not bring extra overhead.)

Thanks,
Kan

> I get the interpolation can be difficult as the counter value and
> system time can't currently atomically collected, so potentially there
> may be a need for a way to tie two together (see my previous email's
> thought of ktime_get_raw_monotonic_from_timestamp()), but we'd
> probably want a clear understanding of the benefit (quantitative
> reduction in interpolation error, and what real benefit that brings),
> and would also want the driver to generate and share those pairs
> rather than having userland have access.
> 
> thanks
> -john
