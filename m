Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983D25B5F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiILRf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiILRf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:35:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A1F29CB7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663004156; x=1694540156;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AIZnlJYM89tISECNxQc09LxTR6ae1lgY75ZxwPGHJi8=;
  b=BoOB+qHvlPmyiMAr8dQzmaguDrE2PJ4OwKvsalbUcU3ij+wDaBJ/y8dn
   9UlO7FnAv1H/1S0SFsT2RrhfwmVFYOg8f6rXgXi0YBxe9d8z2OWvoZkcG
   uabUB0Fn2jaybXxfHqc68HrbhmVXxGThtc0Wnd3DjsfLQCTbu/a7j5HXT
   60uRhF2nf4aU6zLQbBuZoiH/9gK4CUPls2O7xm3N3IDySMuha3eDhRb5Q
   YzAO2UY87D9arV4Wm9oTcGUr0Iv97L28Zl905m7/Ttn8Weh8iJuZia5ZG
   G50DH643QP4cuuWb6vKfbJf0wfFxhhoFW0bd3yYZkOyV2roDWshLRKj0s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324164964"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324164964"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 10:35:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="705236390"
Received: from vtsymbal-mobl.ger.corp.intel.com (HELO [10.252.32.67]) ([10.252.32.67])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 10:35:53 -0700
Message-ID: <c68e5f78-51cc-6b16-dc7d-4540b78e4d2f@linux.intel.com>
Date:   Mon, 12 Sep 2022 19:09:00 +0200
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <49ee34ef-7d64-aeb6-eb1b-6cdbfd9e36ae@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/22 14:25, Richard Fitzgerald wrote:
> On 12/09/2022 12:43, Pierre-Louis Bossart wrote:
>>
>>
>> On 9/7/22 10:52, Richard Fitzgerald wrote:
>>> Only exit sdw_handle_slave_status() right after calling
>>> sdw_program_device_num() if it actually programmed an ID into at
>>> least one device.
>>>
>>> sdw_handle_slave_status() should protect itself against phantom
>>> device #0 ATTACHED indications. In that case there is no actual
>>> device still on #0. The early exit relies on there being a status
>>> change to ATTACHED on the reprogrammed device to trigger another
>>> call to sdw_handle_slave_status() which will then handle the status
>>> of all peripherals. If no device was actually programmed with an
>>> ID there won't be a new ATTACHED indication. This can lead to the
>>> status of other peripherals not being handled.
>>>
>>> The status passed to sdw_handle_slave_status() is obviously always
>>> from a point of time in the past, and may indicate accumulated
>>> unhandled events (depending how the bus manager operates). It's
>>> possible that a device ID is reprogrammed but the last PING status
>>> captured state just before that, when it was still reporting on
>>> ID #0. Then sdw_handle_slave_status() is called with this PING info,
>>> just before a new PING status is available showing it now on its new
>>> ID. So sdw_handle_slave_status() will receive a phantom report of a
>>> device on #0, but it will not find one.
>>>
>>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>>> ---
>>>   drivers/soundwire/bus.c | 27 +++++++++++++++------------
>>>   1 file changed, 15 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>>> index 6e569a875a9b..0bcc2d161eb9 100644
>>> --- a/drivers/soundwire/bus.c
>>> +++ b/drivers/soundwire/bus.c
>>> @@ -736,20 +736,19 @@ static int sdw_program_device_num(struct
>>> sdw_bus *bus)
>>>       struct sdw_slave_id id;
>>>       struct sdw_msg msg;
>>>       bool found;
>>> -    int count = 0, ret;
>>> +    int count = 0, num_programmed = 0, ret;
>>>       u64 addr;
>>>         /* No Slave, so use raw xfer api */
>>>       ret = sdw_fill_msg(&msg, NULL, SDW_SCP_DEVID_0,
>>>                  SDW_NUM_DEV_ID_REGISTERS, 0, SDW_MSG_FLAG_READ, buf);
>>>       if (ret < 0)
>>> -        return ret;
>>> +        return 0;
>>
>> this doesn't seem quite right to me, there are multiple -EINVAL cases
>> handled in sdw_fill_msg().
>>
>> I didn't check if all these error cases are irrelevant in that specific
>> enumeration case, if that was the case maybe we need to break that
>> function in two helpers so that all the checks can be skipped.
>>
> 
> I don't think that there's anything useful that
> sdw_modify_slave_status() could do to recover from an error.
> 
> If any device IDs were programmed then, according to the statement in
> sdw_modify_slave_status()
> 
>     * programming a device number will have side effects,
>     * so we deal with other devices at a later time
> 
> if this is true, then we need to exit to deal with what _was_
> programmed, even if one of them failed.
> 
> If nothing was programmed, and there was an error, we can't bail out of
> sdw_modify_slave_status(). We have status for other devices which
> we can't simply ignore.
> 
> Ultimately I can't see how pushing the error code up is useful.
> sdw_modify_slave_status() can't really do any effective recovery action,
> and the original behavior of giving up and returning means that
> an error in programming dev ID potentially causes collateral damage to
> the status of other peripherals.

I was suggesting something like


void sdw_fill_msg_data(...)
{
  copy data in the msg structure
}

int sdw_fill_msg(...)
{
    sdw_fill_msg_data();
    handle_error_cases
}

and in sdw sdw_program_device_num() we call directly sdw_fill_msg_data()

So no change in functionality beyond explicit skip of error checks that
are not relevant and cannot be handled even if they were.



