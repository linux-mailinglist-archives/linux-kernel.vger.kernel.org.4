Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A5F67B71B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjAYQoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjAYQoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:44:10 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0BD59772
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674665049; x=1706201049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ymKUuvKJzg6bYBAbsVKuOt2HkdaWMZ/U3Tp0GZn66pg=;
  b=GUWtqpnL3tI3DH+XivaJ0Q1ujiE20U9JXdxRkZFZeqehLXuJsd7TsRbg
   OmET+zdTYEA9W000zkf2VS0sqOlBHuzDspnrsqA+b8C7LTXIZ8J/f+VpF
   1QTxZJ6FtgQ3nSrYCMtyzAzTsfZX8JSHLbdPggPpwYFxtFtaIAbWeyNwa
   HTj3WgPVgzba07zaeB5ZXynBLuLglyhNyNvDm4qbQ25sfn2r+GpL2RmgS
   5ulq7ol0IFhT0Bu89/tGTBb6gk+aDWqPyIMaDIP2170dZFn5pd6qhlWRe
   AkxXXnolUMElAQmPed1AbGq13J1+XUKZKgvnTKKoUnFGsyFaoiPIe22Yg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306265093"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="306265093"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 08:44:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="805061593"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="805061593"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2023 08:44:08 -0800
Received: from [10.209.72.24] (kliang2-mobl1.ccr.corp.intel.com [10.209.72.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D244E5807E2;
        Wed, 25 Jan 2023 08:44:06 -0800 (PST)
Message-ID: <01434319-3828-0d50-4274-8f95b18dafc1@linux.intel.com>
Date:   Wed, 25 Jan 2023 11:44:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] timekeeping: NMI safe converter from a given time to
 monotonic
To:     John Stultz <jstultz@google.com>
Cc:     Stephane Eranian <eranian@google.com>, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ak@linux.intel.com
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <20230123182728.825519-2-kan.liang@linux.intel.com>
 <CANDhNCpWwxXM8DD9h4zOW+bygshkOg9TWO9Z7wJO_B7bDtgEHw@mail.gmail.com>
 <9c17d6be-e532-84e1-4d35-77b9bd3051dc@linux.intel.com>
 <CANDhNCp_0Os+e0A0LZ7yKw16mWai9MAPMPYL0p1NkcVxifh88w@mail.gmail.com>
 <1fb59dfa-1ab9-51ad-98c6-89431aa56918@linux.intel.com>
 <CANDhNCodq8iyRY-md-nRkAPYS5p3iTCgDqZXvWAA108TctQASg@mail.gmail.com>
 <c8ad4654-6bfd-2983-036e-e969787992e9@linux.intel.com>
 <CANDhNCqxOurpjKQaEEgxdFYV8kQQHVUNZUy1B5AewSi8bys8iQ@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCqxOurpjKQaEEgxdFYV8kQQHVUNZUy1B5AewSi8bys8iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-24 5:40 p.m., John Stultz wrote:
> On Tue, Jan 24, 2023 at 2:08 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>> On 2023-01-24 3:33 p.m., John Stultz wrote:
>>> On Tue, Jan 24, 2023 at 12:13 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>> On 2023-01-24 1:43 p.m., John Stultz wrote:
>>>> I read the code correctly, it should happen only when adjusting NTP or
>>>> suspending/resuming. If so, I think the drawback should not impact the
>>>> normal analysis work. I will call out the drwabacks in the comments
>>>> where the function is used.
>>> So the adjustments are done at tick time depending on the current NTP
>>> "error" (basically what the kernel tracks as the delta from its sense
>>> of what NTP has told us).
>>>
>>> Not just at the time when ntp makes an adjustment.
>>>
>>> So the window for it to happen is every timekeeping update (which is ~HZ).
>>
>> You mean the tkf->base is updated in each tick?
> 
> Right, every call to timekeeping_update(), which is called for every
> major state change in time along with regular updates via
> timekeeping_advance() which is called from update_wall_time() which
> gets called from the various tick handlers.
> 
>> If so, that should be a problem.
>>
>> Does the NTP "error" consistently happen on all the platforms? Or just
>> on some platforms which we can check and limit the usage?
> 
> Basically any platform where adjtimex was ever called.  Both offset
> and freq adjustments will trigger this. The trouble is that the
> adjustments requested are finer grained than what the actual
> clocksources mult values can be adjusted for. So the kernel tracks the
> error internally and will oscillate the clocksource multiplier value
> to keep the long-term accuracy close to what was requested.
> 
>> There are two configurations for PEBS, single PEBS, and large PEBS.
>> For the single PEBS mode, HW triggers a NMI for each record. The TSC is
>> the time which the record is generated, and we convert it in the same
>> NMI. I don't think the NTP "error" can impact it.
> 
> If the clocksource is being adjusted in between reads (imagine the
> freq is dropped), when using the fast accessors, time may seem to go
> backwards between those reads.
> 
> In fact, if the same TSC value is used for two calls in a row, you
> could see time go backwards or forwards between them if the adjustment
> happened inbetween.
> 
> The regular (non-fast) clocksource accessors use the seqcount to
> prevent reads from occuring while the adjustment is made from being
> used (you'll note we always re-read the clocksource within the
> seqcount loop) but this makes it not NMI safe.
> 
> 
>> But for the large PEBS mode, HW triggers a NMI only when a fixed number
>> of records are generated. It's very likely that the base has been
>> updated between the records. That could bring troubles, since we can
>> only fall back to the NMI handler time of the last record. I'm afraid we
>> have to disable the large PEBS mode.
>>
> 
> Right, if I recall, this is why the interpolation is done in the
> existing get_device_system_crosststamp(). It's obviously never going
> to be perfect as we dont' keep the timekeeper state for every tick,
> but it might be better than the bailout you have if you didn't luck
> into the current interval.
> 
> My apologies, as my intention isn't to dissuade you here, but just to
> make sure the complexities (and unfortunately there are a lot) are
> well worked out and well tested.
> 

Thank you very much for your patience and all the details, I really
appreciate it. I think I understand the problem and the concerns now. I
will reevaluate the current design and try to find a proper solution.

Thanks,
Kan
