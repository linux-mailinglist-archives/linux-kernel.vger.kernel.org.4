Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800555F9EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiJJMgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiJJMgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:36:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FDC3FA18;
        Mon, 10 Oct 2022 05:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665405372; x=1696941372;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4+frokLrfq+rbpCITnmGE0GdTX2LnzeDU7bHK2xfiR0=;
  b=bT4baR/WqK3J1kRc3plAsGJCvo5nHn3dQYecVV0chxuvJpaPZySXvD9G
   blsdpoNtnODbcoA8ty/VFd5ovq/tTNt2x2b50rPdAh8Nl26rbZ66Owe3y
   octhbqNY9yGe6GvTBw5Axy79sq7NhuIjK1hVoreAdDomqf0qYFDMdBx0H
   oSkkIz/4mOJ8aUNGQTArDIX72AegFAR/MF3eKiFTmufqTT+LS5XnAT4gA
   zQJdNCoFGmwdU60WZmCvDNKJXiUTA+AiAx45eyZeyT0YkD/vbpYkw5PF3
   I+cXX6GfDxtco4uS4gfxJkmpkhsxWhIYDiOd1q7V34Pow9MLUtySy1ZbD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="305808966"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="305808966"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 05:36:12 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="954901439"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="954901439"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.62.180])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 05:36:10 -0700
Message-ID: <59847aad-6339-9a06-f743-257a4bc4229a@intel.com>
Date:   Mon, 10 Oct 2022 15:36:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCHv2 1/2] mmc: block: Remove error check of hw_reset on reset
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <003d34d1643242488b533dc14f69830f@hyperstone.com>
 <e6acc89d-7d17-62ee-d67a-b78b1cdcd085@intel.com>
 <27343e2a17d1481f9a62d710480bc041@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <27343e2a17d1481f9a62d710480bc041@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 11:08, Christian Löhle wrote:
> 
>>
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com> 
>> Sent: Samstag, 8. Oktober 2022 10:38
>> To: Christian Löhle <CLoehle@hyperstone.com>; Ulf Hansson <ulf.hansson@linaro.org>; Linux MMC List <linux-mmc@vger.kernel.org>; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCHv2 1/2] mmc: block: Remove error check of hw_reset on reset
>>
>> On 7/10/22 18:42, Christian Löhle wrote:
>>> Before switching back to the right partition in mmc_blk_reset there 
>>> used to be a check if hw_reset was even supported.
>>> This return value was removed, so there is no reason to check.
>>>
>>> Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in 
>>> mmc_hw|sw_reset()")
>>> Cc: stable@vger.kernel.org
>>>
>>> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
>>> ---
>>> -v2: Do not attempt to switch partitions if reset failed
>>>
>>>  drivers/mmc/core/block.c | 28 +++++++++++++---------------
>>>  1 file changed, 13 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index 
>>> ce89611a136e..8db72cba2bbe 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -991,29 +991,27 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
>>>  			 int type)
>>>  {
>>>  	int err;
>>> +	struct mmc_blk_data *main_md = dev_get_drvdata(&host->card->dev);
>>> +	int part_err;
>>>  
>>>  	if (md->reset_done & type)
>>>  		return -EEXIST;
>>>  
>>>  	md->reset_done |= type;
>>>  	err = mmc_hw_reset(host->card);
>>> +	if (err)
>>> +		return err;
>>
>> This could be a potential source of data corruption.
>>
>> There is no guarantee that a subsequent I/O will fail just because the reset failed.  Reading / writing the wrong partition would be disastrous, so we should always try to get back to the correct partition.
>>
>> I haven't looked at the possibility of just flagging the partition as invalid - need to be sure any subsequent I/O attempts still go through a path that switches the partition.
> 
> I can see where youre coming from, but similarly a failing mmc_blk_part_switch doesn't imply all subsequent IO will fail.
> Flagging the partition as invalid can be seen as rendering the system to a potentially useless state, which is a bit overboard for e.g. one CRC7 failure on the switch.

I wasn't clear sorry.  I meant setting main_md->part_curr to a value
that doesn't match any partition, thereby forcing the next I/O to
switch partition first.

> Not sure yet what the ideal behavior is, but either way I would go with v1 1/2 and v2 2/2 for now? That already fixes imo the most relevant potential data corruptions. (successful reset -> no switch)
> Then we can come up with a a good handling for mmc_blk_reset or even around mmc_blk_part_switch.
> Or what do you suggest?

What about what I just described above.

