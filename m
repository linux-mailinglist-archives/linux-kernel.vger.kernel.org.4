Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EB56A99B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCCOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjCCOld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:41:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C69360B3;
        Fri,  3 Mar 2023 06:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677854492; x=1709390492;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PCA7xcIf7pUPetZRCkhEcheUlk5lHEZhdWB8pICiDFU=;
  b=nJEH9APUT4DJ0WlHz2KViL4BB18UVqZZ2Ro4nz3zCdR6suY1qjO6FRAW
   BeuR8FEM4a6UAR/mC6g6SNr4GRpGeJYWitdOha9VMJDDv7FEIYHEAPVyo
   RZ18G3pwvpLiWhzNNIApuMSmRZ1q6Jy4pYUoBhem4LP0G68JxoFiYgnlh
   aTmV/pl4cAGls+X+FI8BUJwXFrEUTcsOjMl+aCCR6KsxImJ9AkkcKo1NV
   QnJKo0rHBZVRAV6p40bRwJzK5e8riMJt/4Clgmc+EedzUYn6oV9hTzrp5
   WNuomMhwqpBP/qvzBPs11idiZJ6gdtzwkPVd6g/teZZLDvl5NlOBYnKKJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="362648656"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="362648656"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 06:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="705664872"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="705664872"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.216.227])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 06:41:27 -0800
Message-ID: <5d7d48ff-b007-e339-8177-d0a7b7b8adc4@intel.com>
Date:   Fri, 3 Mar 2023 16:41:23 +0200
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFpv3hHvg5X8WNpQEnnsNdGCBMybT-32EGPNYtBtSgK9Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/03/23 14:01, Ulf Hansson wrote:
> On Fri, 3 Mar 2023 at 12:40, Christian Löhle <CLoehle@hyperstone.com> wrote:
>>
>>
>>>>
>>>> REQ_FUA is in general supported for eMMC cards, which translates into so called "reliable writes". To support these write operations, the CMD23 (MMC_CAP_CMD23), needs to be supported by the mmc host too, which is common but not always the case.
>>>>
>>>> For some eMMC devices, it has been reported that reliable writes are quite costly, leading to performance degradations.
>>>>
>>>> In a way to improve the situation, let's avoid announcing REQ_FUA support if the eMMC supports an internal cache, as that allows us to rely solely on flush-requests (REQ_OP_FLUSH) instead, which seems to be a lot cheaper.
>>>> Note that, those mmc hosts that lacks CMD23 support are already using this type of configuration, whatever that could mean.
>>>
>>> Just note that reliable write is strictly weaker than turning cache off/flushing, if card loses power during cache off/flush programming / busy, sector-wise atomicity is not mandated by the spec.
>>> (And that is assuming cache off/flush is actually respected by the card as intended by the spec, should some cards be checked?) Maybe some FS people can also chime in?
>>
>> Nevermind, the sector-wise atomicity should not matter on 5.1 cards or if the block length isn't being played with, which it isn't in our case.
>> If reliable write is implemented only according to spec, I don't see why the cache flushing should be less expensive, which would only make sense if
>> a) < sector chunks are committed to flash
>> b) reliable write is implemented much stricter than the spec, ensuring atomicity for the entire write.
> 
> Right, I agree!
> 
> Note 1) Reliable write was introduced way before cache management in
> the eMMC spec. So, if the support for reliable write would have a
> stricter implementation than needed, I would not be surprised.

I am not sure when you say stricter than needed.  Historically
file systems assumed that sectors are updated atomically i.e.
there is never a sector with a mixture of old and new data.
The eMMC spec does not guarantee that, except for reliable
write.

File systems may use REQ_FUA for important information, like the
superblock or a journal commit record, so using reliable write
for REQ_FUA would seem to give better protection against file system
corruption than a cache flush which could leave a sector
half-written.

On the other hand, sudden power loss is probably rare in battery
powered systems because they are designed to monitor the battery
power and shutdown when it gets too low.

And file systems can use checksums to detect half-written updates.

And there is anyway no protection for other (non REQ_FUA) writes a
file system might do and expect not to tear sectors.

And you are more likely to smash the screen than bounce the battery
out and cause an unrecoverable file system error.

Nevertheless, the commit message of this patch reads like the change
is an optimization, whereas it seems more like a policy change.
The commit message should perhaps say something like:
"The consensus is that the benefit of improved performance by not
using reliable-write for REQ_FUA is much greater than any potential
benefit that reliable-write might provide to avoid file system
corruption in the event of sudden power loss."

As for allowing for the policy to be overridden, perhaps an mmc_core
module option?

> 
> Note 2) In the eMMC v5.1 spec, the cache flushing support has been
> extended to allow an explicit barrier operation. Perhaps, we should
> let that option take precedence over a regular flush+barrier, for
> REQ_OP_FLUSH!?
> 
>>
>> I guess the cards which increase performance do b)? Or something else?
> 
> That's the tricky part to know, as it's the internals of the eMMC.

It is the natural conclusion though.  The eMMC probably does not
update mapping information with every write, instead if power is
lost, it scans the updated areas at the next initialization. (The
power-off notify feature would commit the mapping information to
media to avoid that).  So a reliable write might have to:
1. write information to record that the old mapping
should be used, not what might be discovered by scanning
2. do the actual write
3. write mapping information to record the new mapping

> 
> Although, it seems like both Avri (WDC) and Bean (Micron) would be
> happy to proceed with $subject patch, which makes me more comfortable
> to move forward.
> 
>> Anyway regarding FUA i don't have any concerns regarding reliability with cache flush.
>> I can add some performance comparisons with some eMMCs I have around though.
> 
> That would be great, thanks a lot for helping out with testing!
> 
> Kind regards
> Uffe

