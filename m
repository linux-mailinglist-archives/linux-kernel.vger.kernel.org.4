Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9436C35D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjCUPir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCUPip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:38:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC5323D8E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679413119; x=1710949119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oldf4kjaQJcTQ9uXaaXfmdQbhwPXm+kkDs/uC9KsfFM=;
  b=aDNmgXkMA9LlgMCvLptys6CZpLGf/KfTg7FXA/RSuHs3W/GI1S/4540M
   I5BeoUxGz8z96UvXDnf8u6KTNLwKSfzkZIWNgqSDECwFEnjqTulA1s0KR
   NozEkBbUavpjSgKrOFaDehj1wT+cp1ne+lNAxr+JkW45wKpE02jVSjXAj
   jbNsMvfDsyC2+OiYEt1ZfDawH9EQuL9r7kRmalD0Si6/dWy07NM6bjI0P
   +op2ARe/TyMd7H3xv/X1nRdPd5fnSSjLYnuUCCehnyhp4Hoag2dYS9BWs
   d5tzjzX/yeokSItzSMn95TT/OGsTvoKJM1UDrPA5INL1oW7o1+18Q/Ujz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="319364829"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="319364829"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 08:38:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="770691221"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="770691221"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2023 08:38:39 -0700
Received: from [10.209.33.254] (kliang2-mobl1.ccr.corp.intel.com [10.209.33.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CAE755805CB;
        Tue, 21 Mar 2023 08:38:37 -0700 (PDT)
Message-ID: <29588394-0b14-86f3-9933-1a852707c233@linux.intel.com>
Date:   Tue, 21 Mar 2023 11:38:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH V2 4/9] perf/x86: Enable post-processing monotonic raw
 conversion
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, jstultz@google.com,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-5-kan.liang@linux.intel.com> <875yc4rp68.ffs@tglx>
 <4372ae84-76e2-8bae-b0ad-87102973df67@linux.intel.com> <873578rmp2.ffs@tglx>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <873578rmp2.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2023-02-14 3:55 p.m., Thomas Gleixner wrote:
> On Tue, Feb 14 2023 at 15:21, Kan Liang wrote:
>> On 2023-02-14 3:02 p.m., Thomas Gleixner wrote:
>>>
>>> What guarantees that the clocksource used by the timekeeping core is
>>> actually TSC? Nothing at all. You cannot make assumptions here.
>>>
>>
>> Yes, you are right.
>> I will add a check to make sure the clocksource is TSC when perf does
>> the conversion.
>>
>> Could you please comment on whether the patch is in the right direction?
>> This V2 patch series expose the kernel internal conversion information
>> into the user space. Is it OK for you?
> 
> Making the conversion info an ABI is suboptimal at best. I'm still
> trying to wrap my brain around all of this. Will reply over there once
> my confusion subsides.
> 

John and I have tried a pure user-space solution (avoid exposing
internal conversion info) to convert a given TSC to a monotonic raw.
But it doesn't work well.
https://lore.kernel.org/lkml/CANDhNComKRDdZJ8SJECNdoAzQhmR3vu9yKAtp7NKDmECxff=fg@mail.gmail.com/

So, for now, there seems only two solutions.
Solution 1: Do the conversion in the kernel (Similar to V1).
https://lore.kernel.org/lkml/20230123182728.825519-1-kan.liang@linux.intel.com/

Solution 2: Expose the internal conversion information to the user space
via perf mmap and does post-processing conversion. (Implemented in this V2)

Personally, I incline the solution 1. Because
- The current monotonic raw is calculated in the kernel as well.
  The solution 1 just follow the existing method. It doesn't introduce
extra overhead.
- It avoids exposing the internal timekeeping state directly to userspace.


What do you think? Are there other directions I can explore?

Thanks,
Kan
