Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3367F679CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbjAXPJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjAXPJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:09:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972D13C2F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674572958; x=1706108958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VgurDaBanJ3YjyQZlDQEHy5cvR66wrGbURn+EaouADw=;
  b=HmOfC1R1UEbwUKZqDLhCnGM6yK46R5PjU9xuIFfCiA6tww7kS+VHIIjT
   5I8dvy+D1/2WmKs7YYiFQiwlnZn/2lPYQAopbLRIp91ozsj2ORdlJ701C
   y9agytuoqdJ5xfDnZJQCAQnZzQj5zqDtfXE/cf80ul42mvtsh+UwAPbKs
   NysFT4l6MG11bR9QgGQy4wCDlwbqEiZ0K81eSmtx3ZrSgzw3/5bSfAN9U
   ogpBk0g6d4eWOWIXXI+YE+gy7geFy6DIxyEaEwmlX+g43N2jDx32bil8H
   z1GI8wz036t6HRs9yrWsm3lhBpWxKec4X7MBUKo11ZnobTONXpDJmMLch
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="388657805"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="388657805"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="662174845"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="662174845"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 24 Jan 2023 07:09:18 -0800
Received: from [10.251.2.31] (kliang2-mobl1.ccr.corp.intel.com [10.251.2.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EE107580B9A;
        Tue, 24 Jan 2023 07:09:16 -0800 (PST)
Message-ID: <9c17d6be-e532-84e1-4d35-77b9bd3051dc@linux.intel.com>
Date:   Tue, 24 Jan 2023 10:09:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] timekeeping: NMI safe converter from a given time to
 monotonic
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <20230123182728.825519-2-kan.liang@linux.intel.com>
 <CANDhNCpWwxXM8DD9h4zOW+bygshkOg9TWO9Z7wJO_B7bDtgEHw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCpWwxXM8DD9h4zOW+bygshkOg9TWO9Z7wJO_B7bDtgEHw@mail.gmail.com>
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



On 2023-01-24 2:01 a.m., John Stultz wrote:
> On Mon, Jan 23, 2023 at 10:27 AM <kan.liang@linux.intel.com> wrote:
>> +int notrace get_mono_fast_from_given_time(int (*get_time_fn)
>> +                                               (struct system_counterval_t *sys_counterval,
>> +                                               void *ctx),
>> +                                         void *ctx,
>> +                                         u64 *mono_ns)
>> +{
>> +       struct system_counterval_t system_counterval;
>> +       struct tk_fast *tkf = &tk_fast_mono;
>> +       u64 cycles, now, interval_start;
>> +       struct tk_read_base *tkr;
>> +       unsigned int seq;
>> +       int ret;
>> +
>> +       do {
>> +               seq = raw_read_seqcount_latch(&tkf->seq);
>> +               tkr = tkf->base + (seq & 0x01);
>> +
>> +               ret = get_time_fn(&system_counterval, ctx);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               /*
>> +                * Verify that the clocksource associated with the given
>> +                * timestamp is the same as the currently installed
>> +                * timekeeper clocksource
>> +                */
>> +               if (tkr->clock != system_counterval.cs)
>> +                       return -EOPNOTSUPP;
>> +               cycles = system_counterval.cycles;
>> +
>> +               /*
>> +                * Check whether the given timestamp is on the current
>> +                * timekeeping interval.
>> +                */
>> +               now = tk_clock_read(tkr);
>> +               interval_start = tkr->cycle_last;
>> +               if (!cycle_between(interval_start, cycles, now))
>> +                       return -EOPNOTSUPP;
> 
> So. I've not fully thought this out, but it seems like it would be
> quite likely that you'd run into the case where the cycle_last value
> is updated and your earlier TSC timestamp isn't valid for the current
> interval. The get_device_system_crosststamp() logic has a big chunk of
> complex code to try to handle this case by interpolating the cycle
> value back in time. How well does just failing in this case work out?
> 

For the case, perf fallback to the time captured in the NMI handler, via
ktime_get_mono_fast_ns().

The TSC in PEBS is captured by HW when the sample was generated. There
should be a small delta compared with the time captured in the NMI
handler. But I think the delta should be acceptable as a backup solution
for the most analysis cases. Also, I don't think the case (the
cycle_last value is updated during the monitoring) should occur very
often either. So I drop the history support to simplify the function.

Thanks,
Kan
