Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5699F6C2FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCULMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCULMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:12:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E233E1CE;
        Tue, 21 Mar 2023 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679397137; x=1710933137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MhU6jD2fUIFAat7Wm0+a/KEv4Se3mr5PyLZOZyObNA4=;
  b=d8ujS8csXyz4k0+hPxkK6nb/ZjBj/qxqxjqAkbrz0e9kZ8d+Q0lLMzE3
   pWR85rG8NQigkeGbm5EvwYdt1vJtQB8jjORZ+nOYaV4eF48ruDjKr2tgj
   djft4TkbNAMqBRtglzqi5ITBN+/eGCPSXSAd+Iq+mDhWHrprAJkY2xzA9
   eCBoS6tyOCD40t2iha6M9Pp1Lvjbp8mtcmVkNelqRl2jgRXfCtCbAPtPJ
   JP3lHYsYfNvzX8n3BnXAQhDg6dxyICgH0KWB6mVWREQMiwCKLYCvcS+2Q
   OrBbWbD/Ut0oB9O8S2Gde2xPXAZUN6Ul3tmqug864ldt6fOrz46Qz90uR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="327285232"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="327285232"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 04:12:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="658728302"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="658728302"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.63.64])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 04:12:13 -0700
Message-ID: <2333076d-f500-4db9-7acc-5b9ed000c37d@intel.com>
Date:   Tue, 21 Mar 2023 13:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] mmc: core: Allow to avoid REQ_FUA if the eMMC supports an
 internal cache
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
References: <20230316164514.1615169-1-ulf.hansson@linaro.org>
 <8d6d12b5-39d4-ac07-f725-18ae9df9765b@intel.com>
 <CAPDyKFrvWA-SxM6d=eVHFyPTYygsXmWQGVmnHJxsRFwGOhVjYw@mail.gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFrvWA-SxM6d=eVHFyPTYygsXmWQGVmnHJxsRFwGOhVjYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/23 13:03, Ulf Hansson wrote:
> On Tue, 21 Mar 2023 at 11:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 16/03/23 18:45, Ulf Hansson wrote:
>>> REQ_FUA translates into so called "reliable writes" (atomic writes) for
>>> eMMC cards, which is generally supported as it was introduced as a
>>> mandatory feature already in the v4.3 (2007) of the eMMC spec. To fully
>>> support the reliable writes (thus REQ_FUA), the mmc host driver needs to
>>> support the CMD23 (MMC_CAP_CMD23) too, which is rather common nowadays.
>>>
>>> File systems typically uses REQ_FUA for writing their meta-data and other
>>> important information. Ideally it should provide an increased protection
>>> against data-corruption, during sudden power-failures. This said, file
>>> systems have other ways to handle sudden power-failures too, like using
>>> checksums to detect partly-written data, for example.
>>>
>>> It has been reported that the reliable writes are costly for some eMMCs,
>>> leading to performance degradations. Exactly why, is in the implementation
>>> details of the internals of the eMMC.
>>>
>>> Moreover, in the v4.5 (2011) of the eMMC spec, the cache-control was
>>> introduced as an optional feature. It allows the host to trigger a flush of
>>> the eMMC's internal write-cache. In the past, before the cache-control
>>> feature was added, the reliable write acted as trigger for the eMMC, to
>>> also flush its internal write-cache, even if that too remains as an
>>> implementation detail of the eMMC.
>>>
>>> In a way to try to improve the situation with costly reliable writes and
>>> REQ_FUA, let's add a new card quirk MMC_QUIRK_AVOID_REL_WRITE, which may be
>>> set to avoid announcing the support for it. However, as mentioned above,
>>> due to the specific relationship with the cache-control feature, we must
>>> keep REQ_FUA unless that is supported too.
>>>
>>> Reported-by: Wenchao Chen <wenchao.chen666@gmail.com>
>>> Acked-by: Bean Huo <beanhuo@micron.com>
>>> Acked-by: Avri Altman <avri.altman@wdc.com>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Minor cosmetic suggestion below, but nevertheless:
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Thanks!
> 
>>
>>> ---
>>>
>>> Updated since the RFC:
>>>       Added a card quirk to maintain the current behaviour. The quirk isn't
>>>       set for any cards yet, which is needed (a patch on top) to move forward
>>>       with this.
>>>
>>> ---
>>>  drivers/mmc/core/block.c | 16 ++++++++++++----
>>>  drivers/mmc/core/card.h  |  5 +++++
>>>  include/linux/mmc/card.h |  1 +
>>>  3 files changed, 18 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>>> index 672ab90c4b2d..35292e36a1fb 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -2409,8 +2409,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>>>       struct mmc_blk_data *md;
>>>       int devidx, ret;
>>>       char cap_str[10];
>>> -     bool cache_enabled = false;
>>> -     bool fua_enabled = false;
>>> +     bool cache_enabled, avoid_fua, fua_enabled = false;
>>>
>>>       devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
>>>       if (devidx < 0) {
>>> @@ -2494,11 +2493,20 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>>>           ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
>>>            card->ext_csd.rel_sectors)) {
>>>               md->flags |= MMC_BLK_REL_WR;
>>> +     }
>>> +
>>> +     /*
>>> +      * REQ_FUA is supported through eMMC reliable writes, which has been
>>> +      * reported to be a bit costly for some eMMCs. In these cases, let's
>>> +      * rely on the flush requests (REQ_OP_FLUSH) instead, if we can use the
>>> +      * cache-control feature too.
>>> +      */
>>> +     cache_enabled = mmc_cache_enabled(card->host);
>>> +     avoid_fua = cache_enabled && mmc_card_avoid_rel_write(card);
>>> +     if (md->flags & MMC_BLK_REL_WR && !avoid_fua) {
>>>               fua_enabled = true;
>>>               cache_enabled = true;
>>>       }
>>
>> looks like this could be just:
>>
>>         fua_enabled = (md->flags & MMC_BLK_REL_WR) && !avoid_fua;
>>
>> with fua_enabled no longer needing initialization
> 
> Unless I misunderstand your point, that would work for fua_enabled,
> but would not be sufficient for cache_enabled.
> 
> cache_enabled should be set if fua_enabled is set - and no matter
> whether mmc_cache_enabled() returns true or not.
> 
> Did that make sense?

Yes, you are right, sorry!

> 
> [...]
> 
> Kind regards
> Uffe

