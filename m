Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16635696E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjBNUW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBNUW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:22:26 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4552A1CF73
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676406145; x=1707942145;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qCXN3yZ+2UzDm/9AJjAkJOQBYgE6jhH7GNEVXwCPOiA=;
  b=LiWmZvNgrGIJ55nAjWVDnfIpBQPl5Bj3J02crPAdR1qIFAtvrFnbW955
   E1+HbaCrekIDGaKA+X/tA1NiWbKA7J6PVSgmbFZ9zo/kU9i5VPiiNDRs7
   GBHOc5+BmYn/l3J1AbvhEPpv10gAq0ULW/vco2fr4CSdgymmoj0n0My/K
   qzB/Dv2xQvYDDVxoxH+nPP54pm4VfRZIoLGseIbRb4iTWrVkbXn+towRs
   PhKyCK4bw6LHotfOKXE7zYkXEPKisvgHYxZSfeTQYq5dgCeQrmuWASkMv
   f9DlfIsBYeKWMmXsZzDI7nzywRydRQqsFDOH3FQ3p7loC39KuPbvxFL0V
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="332570160"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="332570160"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 12:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812170439"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="812170439"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2023 12:22:01 -0800
Received: from [10.251.7.65] (kliang2-mobl1.ccr.corp.intel.com [10.251.7.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 80D84580BE4;
        Tue, 14 Feb 2023 12:22:00 -0800 (PST)
Message-ID: <4372ae84-76e2-8bae-b0ad-87102973df67@linux.intel.com>
Date:   Tue, 14 Feb 2023 15:21:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <875yc4rp68.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-02-14 3:02 p.m., Thomas Gleixner wrote:
> Kan!
> 
> On Mon, Feb 13 2023 at 11:07, kan liang wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>> +	} else if (perf_event_hw_time(event)) {
>> +		struct ktime_conv mono;
>> +
>> +		userpg->cap_user_time_mono_raw = 1;
>> +		ktime_get_fast_mono_raw_conv(&mono);
> 
> What guarantees that the clocksource used by the timekeeping core is
> actually TSC? Nothing at all. You cannot make assumptions here.
> 

Yes, you are right.
I will add a check to make sure the clocksource is TSC when perf does
the conversion.

Could you please comment on whether the patch is in the right direction?
This V2 patch series expose the kernel internal conversion information
into the user space. Is it OK for you?

Thanks,
Kan
