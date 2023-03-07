Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154666AE02D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjCGNSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCGNRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:17:39 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07FE23852;
        Tue,  7 Mar 2023 05:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678194999; x=1709730999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FB4sA1fq+0MTOLbrLzQkQ9+3JaYHjdTbqcWfzpw1jw4=;
  b=eQecOMzHtcUa3DJ7vldF1nuUW5GO50ZbPwBg0kBgpVIDjgflj+Vx5Lx6
   LgdKzzJT2tGzRh7KCkhw2xvDFTegq+407cwwdtde/HK87Vb5dXeuYQZ+L
   LRkSDnIlx//ghC9fUh3pMJud/5CPxOAEHRW5DPZnjkqCo/W5kuqV9x7jj
   WITxsJTXGE8NunFE4TpNNMNO4uJlmd3ouFAlR+fR9Hc4+H93CFEdbZsLk
   gTpzCE21LuO0Ryrt0G1j8k2DDUJC7UbhfmJ2qtqqxFR7jOWk0MmupXvlr
   ghXkaNaFN6HxJxrOFc0bdWTknnyNbl1RtJAbSe2FX0Uc60KX/w/nmn2Op
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="324151290"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="324151290"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 05:15:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="765638198"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="765638198"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.236])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 05:15:55 -0800
Message-ID: <fe407f8f-6676-12b8-3e45-2511219bfe28@intel.com>
Date:   Tue, 7 Mar 2023 15:15:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Bean Huo <huobean@gmail.com>
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <5712c69ae37447c5b576d87b247f5756@hyperstone.com>
 <a35f3d45cab0442b9491c0b120e3fb47@hyperstone.com>
 <CAPDyKFpv3hHvg5X8WNpQEnnsNdGCBMybT-32EGPNYtBtSgK9Fw@mail.gmail.com>
 <5d7d48ff-b007-e339-8177-d0a7b7b8adc4@intel.com>
 <CAPDyKFrW61y6B3xg9tyht505-mSHw=hAP4bGcUs68-zu7-=F7w@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFrW61y6B3xg9tyht505-mSHw=hAP4bGcUs68-zu7-=F7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/03/23 18:09, Ulf Hansson wrote:
> On Fri, 3 Mar 2023 at 15:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 3/03/23 14:01, Ulf Hansson wrote:
>>> On Fri, 3 Mar 2023 at 12:40, Christian Löhle <CLoehle@hyperstone.com> wrote:
>>>>
>>>>
>>>>>>
>>>>>> REQ_FUA is in general supported for eMMC cards, which translates into so called "reliable writes". To support these write operations, the CMD23 (MMC_CAP_CMD23), needs to be supported by the mmc host too, which is common but not always the case.
>>>>>>
>>>>>> For some eMMC devices, it has been reported that reliable writes are quite costly, leading to performance degradations.
>>>>>>
>>>>>> In a way to improve the situation, let's avoid announcing REQ_FUA support if the eMMC supports an internal cache, as that allows us to rely solely on flush-requests (REQ_OP_FLUSH) instead, which seems to be a lot cheaper.
>>>>>> Note that, those mmc hosts that lacks CMD23 support are already using this type of configuration, whatever that could mean.
>>>>>
>>>>> Just note that reliable write is strictly weaker than turning cache off/flushing, if card loses power during cache off/flush programming / busy, sector-wise atomicity is not mandated by the spec.
>>>>> (And that is assuming cache off/flush is actually respected by the card as intended by the spec, should some cards be checked?) Maybe some FS people can also chime in?
>>>>
>>>> Nevermind, the sector-wise atomicity should not matter on 5.1 cards or if the block length isn't being played with, which it isn't in our case.
>>>> If reliable write is implemented only according to spec, I don't see why the cache flushing should be less expensive, which would only make sense if
>>>> a) < sector chunks are committed to flash
>>>> b) reliable write is implemented much stricter than the spec, ensuring atomicity for the entire write.
>>>
>>> Right, I agree!
>>>
>>> Note 1) Reliable write was introduced way before cache management in
>>> the eMMC spec. So, if the support for reliable write would have a
>>> stricter implementation than needed, I would not be surprised.
>>
>> I am not sure when you say stricter than needed.  Historically
>> file systems assumed that sectors are updated atomically i.e.
>> there is never a sector with a mixture of old and new data.
>> The eMMC spec does not guarantee that, except for reliable
>> write.
> 
> Yes, I agree. With stricker, I was merely thinking of whether the eMMC
> makes the entire write request (multiple sectors) being atomic, or the
> guarantee is only per sector basis.
> 
> According to the eMMC spec, that seems to be implementation specific.
> One option could be heavier than the other, I guess.
> 
>>
>> File systems may use REQ_FUA for important information, like the
>> superblock or a journal commit record, so using reliable write
>> for REQ_FUA would seem to give better protection against file system
>> corruption than a cache flush which could leave a sector
>> half-written.
> 
> Yes, I agree. If we should fully conform to what is stated in the eMMC
> spec, we should probably keep the current path to support REQ_FUA.
> 
>>
>> On the other hand, sudden power loss is probably rare in battery
>> powered systems because they are designed to monitor the battery
>> power and shutdown when it gets too low.
>>
>> And file systems can use checksums to detect half-written updates.
>>
>> And there is anyway no protection for other (non REQ_FUA) writes a
>> file system might do and expect not to tear sectors.
>>
>> And you are more likely to smash the screen than bounce the battery
>> out and cause an unrecoverable file system error.
> 
> Right, these are good arguments to why $subject patch perhaps makes
> sense to move forward with anyway.

Yes

> 
> Moreover, it seems like some eMMC vendors don't really have any
> concerns with us moving away from reliable writes, to instead use only
> "cache flushing". I guess it can indicate that the regular writes may
> already be treated in an atomic kind of way, but who knows.

Indeed

> 
>>
>> Nevertheless, the commit message of this patch reads like the change
>> is an optimization, whereas it seems more like a policy change.
>> The commit message should perhaps say something like:
>> "The consensus is that the benefit of improved performance by not
>> using reliable-write for REQ_FUA is much greater than any potential
>> benefit that reliable-write might provide to avoid file system
>> corruption in the event of sudden power loss."
> 
> I agree. I will improve it along the lines of what you suggest.
> 
>>
>> As for allowing for the policy to be overridden, perhaps an mmc_core
>> module option?
> 
> Even if I am not very fond of module parameters, this seems like a
> reasonable thing to use for this case.
> 
> I was also looking at using a card quirk.

Yes that makes sense

> 
>>
>>>
>>> Note 2) In the eMMC v5.1 spec, the cache flushing support has been
>>> extended to allow an explicit barrier operation. Perhaps, we should
>>> let that option take precedence over a regular flush+barrier, for
>>> REQ_OP_FLUSH!?
>>>
>>>>
>>>> I guess the cards which increase performance do b)? Or something else?
>>>
>>> That's the tricky part to know, as it's the internals of the eMMC.
>>
>> It is the natural conclusion though.  The eMMC probably does not
>> update mapping information with every write, instead if power is
>> lost, it scans the updated areas at the next initialization. (The
>> power-off notify feature would commit the mapping information to
>> media to avoid that).  So a reliable write might have to:
>> 1. write information to record that the old mapping
>> should be used, not what might be discovered by scanning
>> 2. do the actual write
>> 3. write mapping information to record the new mapping
> 
> Yes. And depending on the eMMC device, some may be more clever than
> others for how to actually deal with this.
> 
>>
>>>
>>> Although, it seems like both Avri (WDC) and Bean (Micron) would be
>>> happy to proceed with $subject patch, which makes me more comfortable
>>> to move forward.
>>>
>>>> Anyway regarding FUA i don't have any concerns regarding reliability with cache flush.
>>>> I can add some performance comparisons with some eMMCs I have around though.
>>>
>>> That would be great, thanks a lot for helping out with testing!
>>>
> 
> Kind regards
> Uffe

