Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A48696E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBNUim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBNUik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:38:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A5F8A47
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676407118; x=1707943118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=o2Hw1hPaEygeOSddXQktfP3hPdv9FuwhxG7VodTe9xs=;
  b=ls+XoK87TVZyoUAZFlFIWKTD1roNNRgib1lpwQ3fkzHC5aG9heRzprBE
   7YRlDAAHLcV5aPQbYCnpVzE9let1MAp1OQGwh7McnziiPgyqCJAWQA9tE
   OjAeT8xa6lyIUTdBz27FHFAd+sKB6diES1yHSXmeBn35m0jLXGH4JlEjq
   glHVx4IwAxXbJFJwV5Gp92uMschrZ0wm+0PLZEP13KlPR3TJft1h/JH41
   oh4DCDQPy/jVcEZhroz27fzd08f7cF5CoM0U1tFiGq1SlILexFko3FAMV
   hUSYV2Qm5PwgqWZfM/j5GbcVKTWDgqBoWvdjI53UZIK2EQlJ8B6eqge6C
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="393663832"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="c'?scan'208";a="393663832"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 12:38:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="701761850"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="c'?scan'208";a="701761850"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 14 Feb 2023 12:38:38 -0800
Received: from [10.251.7.65] (kliang2-mobl1.ccr.corp.intel.com [10.251.7.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id F2BB6580B9E;
        Tue, 14 Feb 2023 12:38:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------nLHK0qNIW0GE07OiMcnccIdj"
Message-ID: <568b09ce-dc6a-8d2a-13ca-6df045236449@linux.intel.com>
Date:   Tue, 14 Feb 2023 15:38:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        adrian.hunter@intel.com
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com>
 <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com>
 <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <6898b1c8-9dbf-67ce-46e6-15d5307ced25@linux.intel.com>
 <0df181b9-fb34-78e8-1376-65d45f7f938f@linux.intel.com>
 <CANDhNCoZNmK12beqE5AAnQrpHEW01xKWwOWTQQEsWSuOaH0HRQ@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCoZNmK12beqE5AAnQrpHEW01xKWwOWTQQEsWSuOaH0HRQ@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------nLHK0qNIW0GE07OiMcnccIdj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-02-14 3:11 p.m., John Stultz wrote:
> On Tue, Feb 14, 2023 at 9:00 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>> On 2023-02-14 9:51 a.m., Liang, Kan wrote:
>>> If I understand correctly, the idea is to let the user space tool run
>>> the above interpoloation algorithm several times to 'guess' the atomic
>>> mapping. Using the mapping information to covert the TSC from the PEBS
>>> record. Is my understanding correct?
>>>
>>> If so, to be honest, I doubt we can get the accuracy we want.
>>>
>>
>> I implemented a simple test to evaluate the error.
> 
> Very cool!
> 
>> I collected TSC -> CLOCK_MONOTONIC_RAW mapping using the above algorithm
>> at the start and end of perf cmd.
>>         MONO_RAW        TSC
>> start   89553516545645  223619715214239
>> end     89562251233830  223641517000376
>>
>> Here is what I get via mult/shift conversion from this patch.
>>         MONO_RAW        TSC
>> PEBS    89555942691466  223625770878571
>>
>> Then I use the time information from start and end to create a linear
>> function and 'guess' the MONO_RAW of PEBS from the TSC. I get
>> 89555942692721.
>> There is a 1255 ns difference.
>> I tried several different PEBS records. The error is ~1000ns.
>> I think it should be an observable error.
> 
> Interesting. That's a good bit higher than I'd expect as I'd expect a
> clock_gettime() call to take ~ double digit nanoseconds range on
> average, so the error should be within that.
> 
> Can you share your logic?
> 

I run the algorithm right before and after the perf command as below.
(The source code of time is attached.)

$./time
$perf record -e cycles:upp --clockid monotonic_raw $some_workaround
$./time

The time will dump both MONO_RAW and TSC. That's where "start" and "end"
from.
The perf command print out both TSC and converted MONO_RAW (using the
mul/shift from this patch series). That's where "PEBS" value from.

Than I use the below formula to calculate the guessed MONO_RAW of PEBS TSC.
Guessed_MONO_RAW = (PEBS_TSC - start_TSC) / (end_TSC - start_TSC) *
(end_MONO_RAW - start_MONO_RAW) + start_MONO_RAW.

The guessed_MONO_RAW is 89555942692721.
The PEBS_MONO_RAW is 89555942691466.
The difference is 1255.

Is the calculation correct?

Thanks,
Kan
--------------nLHK0qNIW0GE07OiMcnccIdj
Content-Type: text/plain; charset=UTF-8; name="time.c"
Content-Disposition: attachment; filename="time.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN5cy90aW1lLmg+CiNpbmNsdWRlIDx0aW1lLmg+CiNpbmNsdWRlIDxzdGRp
by5oPgojaW5jbHVkZSA8ZXJybm8uaD4KCnN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBy
ZHRzYyAoKQp7CiAgdW5zaWduZWQgbG9uZyB2YXI7CiAgdW5zaWduZWQgaW50IGhpLCBsbzsK
CiAgYXNtIHZvbGF0aWxlICgicmR0c2MiIDogIj1hIiAobG8pLCAiPWQiIChoaSkpOwogIHZh
ciA9ICgodW5zaWduZWQgbG9uZyBsb25nIGludCkgaGkgPDwgMzIpIHwgbG87CgogIHJldHVy
biB2YXI7Cn0KCnR5cGVkZWYgdW5zaWduZWQgbG9uZyBsb25nIHU2NDsKCmludCBtYWluKCkK
ewoJc3RydWN0IHRpbWVzcGVjIHRzOwoJdTY0IHN0YXJ0LCBlbmQsIGRlbHRhLCBtaWQ7Cglk
byB7CgkJc3RhcnQ9IHJkdHNjKCk7CgkJY2xvY2tfZ2V0dGltZShDTE9DS19NT05PVE9OSUNf
UkFXLCAmdHMpOwoJCWVuZCA9IHJkdHNjKCk7CgkJZGVsdGEgPSBlbmQtc3RhcnQ7Cgl9IHdo
aWxlIChkZWx0YSAgPiAyMDAwMCk7ICAgLy8gbWFrZSBzdXJlIHRoZSByZWFkcyB3ZXJlIG5v
dCBwcmVlbXB0ZWQKCW1pZCA9IHN0YXJ0ICsgKGRlbHRhICsoZGVsdGEvMikpLzI7IC8vcm91
bmQtY2xvc2VzdAoJcHJpbnRmKCIlbGx1ICVsbHUgJWxsdVxuIiwgc3RhcnQsIGVuZCwgZGVs
dGEpOwoJcHJpbnRmKCJNT05PX1JBVzogJWxsdSBUU0M6ICVsbHVcbiIsICh1NjQpdHMudHZf
c2VjICogMTAwMDAwMDAwMCArIHRzLnR2X25zZWMsIG1pZCk7Cn0K

--------------nLHK0qNIW0GE07OiMcnccIdj--
