Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7831675DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjATTQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjATTQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:16:42 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D488A0C6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674242201; x=1705778201;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w2pg29GHRHLoIcIIyn5qgQAb3vzo6OXjuMsGiS2pt9Q=;
  b=kmloEFabWd+vs0yPlM+5cePB4DZnFvoggvcOimZnCGIJpTWwQqn1Jljr
   jFog1IgVPtvcnrPOJD3TKU6J6KKNUv0YKFGnMva3FtSvMxE9ZhFYFziHo
   naemXoZaXT/CGklUtURSg1wvG34AXw1/6aKWK3w4OCMEadRPDdvZErWVO
   EVyNCdTsYAypUpU+Szxz7gttvquel9kpyWCDROgHXUFsyulIiyXHU4GRT
   PWu0+vpS2VohocOgbhGyYB24c/jfTMZos8uUikzpYRW+niWCdM3RAfmv1
   3ipZKYBv19SeFSGXprDY/v2Q9leyeZUWOFTG7LvsQ9yYAeQFruOncct6h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="388026918"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="388026918"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 11:16:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="691156075"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="691156075"
Received: from gallegos-mobl1.amr.corp.intel.com (HELO [10.212.24.2]) ([10.212.24.2])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 11:16:40 -0800
Message-ID: <cb69c3dc-e7bc-d893-6df2-e8c431d33972@linux.intel.com>
Date:   Fri, 20 Jan 2023 10:11:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] soundwire: bus: Don't filter slave alerts
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     vkoul@kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
References: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
 <db571218-1adb-cb46-5b76-55eaf379f6ca@linux.intel.com>
 <20230120101415.GM36097@ediswmail.ad.cirrus.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230120101415.GM36097@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/23 04:14, Charles Keepax wrote:
> On Thu, Jan 19, 2023 at 11:27:14AM -0600, Pierre-Louis Bossart wrote:
>> On 1/19/23 10:51, Charles Keepax wrote:
>>> Currently the SoundWire core will loop handling slave alerts but it will
>>> only handle those present when the alert was first raised. This causes
>>> some issues with the Cadence SoundWire IP, which only generates an IRQ
>>> when alert changes state. This means that if a new alert arrives whilst
>>> old alerts are being handled it will not be handled in the currently
>>> loop and then no further alerts will be processed since alert never
>>> changes state to trigger a new IRQ.
>>>
>>> Correct this issue by allowing the core to handle all pending alerts in
>>> the IRQ handling loop. The code will still only loop up to
>>> SDW_READ_INTR_CLEAR_RETRY times, so it shouldn't be possible for it get
>>> completely stuck and if you are generating IRQs faster than you can
>>> handle them you likely have bigger problems anyway.
>>
>> The change makes sense, but it's a bit odd to change the way the
>> interrupts are handled because of a specific design. The bus should be
>> able to deal with various designs, not force a one-size-fits-all policy
>> that may not be quite right in all cases.
>>
>> Could we have a new flag at the bus level that says that peripheral
>> interrupts are not filtered, and set if for the Intel case?
>>
>> We could similarly make the SDW_READ_INTR_CLEAR_RETRY constant
>> bus/platform specific. The SoundWire spec mandates that we re-read the
>> status after clearing the interrupt, but it doesn't say how to deal with
>> recurring interrupts.
> 
> Perhaps I should have phrased the commit message differently
> here. To be honest I am not really convince the old code makes
> a huge amount of sense. So I would prefer not to add a flag
> enabling the weird behaviour.
> 
> I would be of the opinion that there are really two options
> for IRQ handling code like this that make sense:
> 
> 1) Loop until the IRQs are handled, ie. it is the soundwire
> core's responsibility to make sure all the IRQs are handled
> before moving on.
> 
> 2) Just handle the IRQs available when the function is called,
> ie. it is the drivers responsibility to keep calling the core
> until the IRQs are handled.
> 
> That way there is a clearly defined who that is responsible.
> The old code is a weird mix of the two where most of the time
> it is the soundwire core's responsibly to handle recurring
> IRQs unless a new one happens in which case it is the drivers
> responsibilty to recall the core.
> 
> Also the new code will still work for drivers that have level
> IRQs and recall the core, without any modification of those
> drivers. So I don't see what anyone would be gaining from the
> old system.

I think the intent of the 'old code' was the option 2), expect that it's
broken on Intel platforms and not possible because of the hardware design.

I am good with your two suggested options.

> Regarding making the clear retries platform specific that makes
> sense to me but is clearly a separate patch. I will add it onto
> my soundwire todo list.

yes, it's a separate patch indeed.

