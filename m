Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4481748A0D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjGERXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGERXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:23:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB31188
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688577825; x=1720113825;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BLPKbcIBH5PVkiqNNns0cBZ+/8DZ7Qmt6A7EBSFuMTA=;
  b=YVTm7Mb9bv1VfHjK0Gf36gy+xzsuGJr7VV+cPPlLPwuIlCm7vUMriI+s
   xaJXAci0j161mFi3nSo3PNhkUhaGZqiJ/H/ugCB+d3XLjgLxoGRpiSJVS
   /kzbzIJoKxD1Fca0Zkepn4sLC7LzpFP6tm0ezfSCZPrHx7Sfgj5bfqAw5
   HVwQlOtXLg+ziJEkGVJk8oTo26QryzkCr8wAmB7T2GEsWaylfEcrXqkap
   jk6cCYIafyEum3l+PWdRc2rdWD7SspsZEvsfF/kz3CxHpcWdyfYFxi9+c
   XkHMORhWh7RSN7hsDHbSy7gTgWAAwdm09z0JgYfnSwDs8L7qU6ZwMYTJY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="449764739"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="449764739"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 10:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="784628556"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="784628556"
Received: from yjie-desk1.jf.intel.com (HELO [10.24.96.120]) ([10.24.96.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 10:23:44 -0700
Message-ID: <19e61b7e-022e-b384-1f37-7354b7ee889d@linux.intel.com>
Date:   Wed, 5 Jul 2023 10:23:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/aperfmperf: Fix the fallback condition in
 arch_freq_get_on_cpu()
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yair Podemsky <ypodemsk@redhat.com>
References: <20230626193601.9169-1-yang.jie@linux.intel.com>
 <878rc1yvp3.ffs@tglx>
Content-Language: en-US
From:   Keyon Jie <yang.jie@linux.intel.com>
In-Reply-To: <878rc1yvp3.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/23 05:35, Thomas Gleixner wrote:
> On Mon, Jun 26 2023 at 12:36, Keyon Jie wrote:
>> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
>> index fdbb5f07448f..24e24e137226 100644
>> --- a/arch/x86/kernel/cpu/aperfmperf.c
>> +++ b/arch/x86/kernel/cpu/aperfmperf.c
>> @@ -432,7 +432,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
>>   	 * Bail on invalid count and when the last update was too long ago,
>>   	 * which covers idle and NOHZ full CPUs.
>>   	 */
>> -	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
>> +	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE * cpu_khz)
> 
> What?
> 
> #define MAX_SAMPLE_AGE  ((unsigned long)HZ / 50)
> 
> HZ is the number of ticks (jiffies) per second. 20ms is 1/50 of a
> second.
> 
> As the sample age is measured in jiffies and the maximum is defined to
> be 20ms, the existing code is correct.
> 
> With your change the condition resolves to:
> 
>       delta > MAX_SAMPLE_AGE * cpu_khz
> 
> cpu_khz = Nominal CPU frequency / 1000
> 
> Ergo:
> 
>       delta > (HZ / 50) * (cpufreq / 1000)
> 
>                  HZ * cpufreq
> -->  delta > ------------------
>                    50000
> 
> Let's describe cpufreq in GHz:
> 
>                  HZ * G * 1e9
> -->  delta > ------------------
>                    50000
> 
> -->  delta > HZ * G * 20000
> 
> delta is calculated in jiffies, i.e. the number of ticks since the last
> invocation. Because HZ is ticks per second, the resulting timeout
> measured in seconds is:
> 
>           HZ * G * 20000 / HZ
> 
> -->      G * 20000 seconds
> 
> 20000 seconds for a 1GHz CPU, 40000 seconds for a 4GHz CPU independent
> of the actual HZ value.
> 
> jiffies are incremented once per tick, i.e. at tick frequency. The
> number of ticks required to reach 20ms depends obviously on the tick
> frequency, aka HZ.
> 
> HZ         ticks per second     tick period     Number of ticks which
>                                                  are equivalent to 20ms
>   100        100                 10ms             2
>   250        250                  4ms             5
> 1000       1000                  1ms            10
> 
> And that's what the code does correctly:
> 
> #define MAX_SAMPLE_AGE  ((unsigned long)HZ / 50)
> 
> No?
> 
>>  From the commit f3eca381bd49 on, the fallback condition about the 'the
>> last update was too long' have been comparing ticks and milliseconds by
>> mistake, which leads to that the condition is met and the fallback
>> method is used frequently.
> 
> The comparison is comparing a tick delta with a maximum number of ticks
> and that's not a mistake. It's simply correct.
> 
>> The change to compare ticks here corrects that and fixes related issues
>> have been seen on x86 platforms since 5.18 kernel.
> 
> I have no idea what you are trying to "fix" here, but that's moot as
> there is nothing to fix.

Hi Thomas and Dave,

Thank you for educating on this, I think you are totally right. So the 
original issue described in the bugzilla is not caused by what I 
mentioned here. Please ignore this patch, we need to figure out another 
fix for the issue, sorry for the confusion.

Thanks,
~Keyon

> 
> Thanks,
> 
>          tglx
