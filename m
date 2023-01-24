Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7D679E30
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjAXQHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjAXQGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:06:55 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AD246D7B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674576411; x=1706112411;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XdBMmP76/kIfQmuowbQ55kRU8wLLl2YLjduiN6mcGNk=;
  b=k+JuVgRWWl7Ct6Q5GclojB+KXNhcCWsKb0Z6wXIxXiMyc+ubMqvUUqzc
   dLjzFnVVSKWNCDMhA2lrkLY1iLsOIqsvX75FrN+DB1UExHnu6Kim3BLoG
   O2ksN0Z1a1gzrRNkIorDGviFzbk8FFtAFySE6yuM7ZjqUNYQv7946hvup
   ER+Cjxelg47y9SLy3s/i5N9r9/cRIhe7So3G1ZC051ytCXOfFM3jDgGWB
   IFh4DpBjGw7nxBWuKIO1GgJGqpoXSD1CHGku2hmJLKCzIwjoqffXGAKAK
   h/0LnSxw9LLz05HL5J22MOOlyLQ9TosKIlx59hBGFXTIqMYFK9gbljq4p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="353606265"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="353606265"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 08:06:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="990923894"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="990923894"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jan 2023 08:06:15 -0800
Received: from [10.251.2.31] (kliang2-mobl1.ccr.corp.intel.com [10.251.2.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 85040580B9A;
        Tue, 24 Jan 2023 08:06:14 -0800 (PST)
Message-ID: <8c1ca162-d6af-888b-6c9a-a907ad74efde@linux.intel.com>
Date:   Tue, 24 Jan 2023 11:06:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] timekeeping: NMI safe converter from a given time to
 monotonic
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, mingo@redhat.com, jstultz@google.com,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <20230123182728.825519-2-kan.liang@linux.intel.com> <87sfg0gvrk.ffs@tglx>
 <CABPqkBSt2WH=zo0_tXNb_Q7waDazvcquXgexXqqn=70A_f4H8Q@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CABPqkBSt2WH=zo0_tXNb_Q7waDazvcquXgexXqqn=70A_f4H8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-24 4:10 a.m., Stephane Eranian wrote:
> On Tue, Jan 24, 2023 at 12:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Mon, Jan 23 2023 at 10:27, kan liang wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> It's useful to provide a NMI safe function to convert a given time to
>>> monotonic. For example, the perf_event subsystem wants to convert a TSC
>>> of a PEBS record to a monotonic clock in a NMI handler.
>>
>> Why? That's a postprocessing problem, really.
>>

Besides the reason Stephane mentioned, the current perf tool assumes
that kernel always gives the time it asked. For example, without the
patch, the kernel uses ktime_get_mono_fast_ns() to get the MONOTONIC
time and dump it to user space.

If we want to break the assumption, I think we have to modify the
current interfaces and dump more extra data to indicate the clock
source. That makes the existing interface more complex. Preparing and
dumping the extra data also brings overhead. We also have to force the
user to update their tools.


Thanks,
Kan

> Because you want to correlate samples captured by PEBS with samples
> from applications timestamped with a user available clock such as
> CLOCK_MONOTONIC, for instance.
> When I create a perf_event event and I stipulate that
> event_attr.clockid=MONOTONIC, I expect all the samples from
> that event to be timestamped using the same clock source, regardless
> of PEBS or IBS.
> 
> 
> 
>> Thanks,
>>
>>         tglx
