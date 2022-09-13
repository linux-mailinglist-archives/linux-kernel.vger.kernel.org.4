Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECA05B79B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiIMSgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiIMSgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:36:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0238732BA8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663091990; x=1694627990;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AUXPDv29W42VkuJbWr48okBTaBr9FqXtDuLVoVld2Ss=;
  b=kPtHa5MBO+4yv91rhR0lM+fhH60HGbS955Qvapb8WAJCfarQiS1gA8Uz
   tAYOzhe2OKpACuW4Y88h/KFezfTPbesghEV2lxKkAKZjjF34DIYedQ1KT
   joGaxWdLr3IOLBOKWNgFlLddT0xbhM0eCFRc+kdKkK5twSX4SdZMsGTso
   gTf4gFkElz17H65HUpXi+FlGN3BmdSASlZlTtGtqmqL8eQO73vxjVLlU2
   3ugomnS+gW726gP9ev1nB8Vierkahso3k658mFrVcr6lymCPniGltY2cp
   wHMC60McxadoEfzTN+T3QaEvvzR7ERzJTo3OHw8eqrYVogNPxXWIJx4fu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="299546763"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="299546763"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 10:59:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="758887310"
Received: from tleistix-mobl2.ger.corp.intel.com (HELO [10.251.208.174]) ([10.251.208.174])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 10:59:46 -0700
Message-ID: <8fb87d38-d417-a9ce-eb95-98a9b213f3b6@linux.intel.com>
Date:   Tue, 13 Sep 2022 19:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/5] soundwire: bus: Don't exit early if no device IDs
 were programmed
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220907085259.3602-1-rf@opensource.cirrus.com>
 <20220907085259.3602-6-rf@opensource.cirrus.com>
 <fa14881d-0eb8-f652-aea7-00d8c3f2a6bb@linux.intel.com>
 <49ee34ef-7d64-aeb6-eb1b-6cdbfd9e36ae@opensource.cirrus.com>
 <c68e5f78-51cc-6b16-dc7d-4540b78e4d2f@linux.intel.com>
 <11e57078-78c7-6f99-8633-e5e945330550@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <11e57078-78c7-6f99-8633-e5e945330550@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>>>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>>>>> index 6e569a875a9b..0bcc2d161eb9 100644
>>>>> --- a/drivers/soundwire/bus.c
>>>>> +++ b/drivers/soundwire/bus.c
>>>>> @@ -736,20 +736,19 @@ static int sdw_program_device_num(struct
>>>>> sdw_bus *bus)
>>>>>        struct sdw_slave_id id;
>>>>>        struct sdw_msg msg;
>>>>>        bool found;
>>>>> -    int count = 0, ret;
>>>>> +    int count = 0, num_programmed = 0, ret;
>>>>>        u64 addr;
>>>>>          /* No Slave, so use raw xfer api */
>>>>>        ret = sdw_fill_msg(&msg, NULL, SDW_SCP_DEVID_0,
>>>>>                   SDW_NUM_DEV_ID_REGISTERS, 0, SDW_MSG_FLAG_READ,
>>>>> buf);
>>>>>        if (ret < 0)
>>>>> -        return ret;
>>>>> +        return 0;
>>>>
>>>> this doesn't seem quite right to me, there are multiple -EINVAL cases
>>>> handled in sdw_fill_msg().
>>>>
>>>> I didn't check if all these error cases are irrelevant in that specific
>>>> enumeration case, if that was the case maybe we need to break that
>>>> function in two helpers so that all the checks can be skipped.
>>>>
>>>
>>> I don't think that there's anything useful that
>>> sdw_modify_slave_status() could do to recover from an error.
>>>
>>> If any device IDs were programmed then, according to the statement in
>>> sdw_modify_slave_status()
>>>
>>>      * programming a device number will have side effects,
>>>      * so we deal with other devices at a later time
>>>
>>> if this is true, then we need to exit to deal with what _was_
>>> programmed, even if one of them failed.
>>>
>>> If nothing was programmed, and there was an error, we can't bail out of
>>> sdw_modify_slave_status(). We have status for other devices which
>>> we can't simply ignore.
>>>
>>> Ultimately I can't see how pushing the error code up is useful.
>>> sdw_modify_slave_status() can't really do any effective recovery action,
>>> and the original behavior of giving up and returning means that
>>> an error in programming dev ID potentially causes collateral damage to
>>> the status of other peripherals.
>>
>> I was suggesting something like
>>
>>
>> void sdw_fill_msg_data(...)
>> {
>>    copy data in the msg structure
>> }
>>
>> int sdw_fill_msg(...)
>> {
>>      sdw_fill_msg_data();
>>      handle_error_cases
>> }
>>
>> and in sdw sdw_program_device_num() we call directly sdw_fill_msg_data()
>>
>> So no change in functionality beyond explicit skip of error checks that
>> are not relevant and cannot be handled even if they were.
>>
> 
> sdw_fill_msg() will never report an error during
> sdw_program_device_num() because the first check is to return if
> the address doesn't need paging, and sdw_program_device_num() only
> accesses SCP registers.
> 
> I don't want to mix coding improvements with bugfixes. Splitting
> sdw_fill_msg() isn't needed to fix this bug.

It's not required but it helps remove a useless always-false condition.
We have way too many error cases in the bus code, most of which have
never been tested. Agree it can be done later, it's just that reviewing
this code changes exposes things that were not noticed before.
