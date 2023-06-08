Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1256728341
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbjFHPJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbjFHPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:09:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0852D59
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686236973; x=1717772973;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=EePSVTT+XOqP8KK0ENYuYqvWSUC0AoMNrVkgXoocbKg=;
  b=OHqcsYHDL/JOotRvHVFyELhpufJhr3Kp9zb8dV45PP711kJJ9rNlupUL
   f1Emgp9KN+2E/EDJ68wplyZpyY093ymJYQ9BKzgj+ndhxhbEuCGds+WgS
   LXxzQJCgVJOtCalYoSa0Rddec1LcKQVe6NDq1wiui5jVPF7M4mxqa9wDu
   Eh7uj50GNR1srWTadB2BE16KG7tP5taQwyL6EnWkOEKB0bnfLmwTPVdm9
   1TOKTdlJYpKOFW9TuPI9dBHckqBz9Mn2ca5VNIXzUSj9McRR6JWDXAA4D
   CSPz7gzJkHF+cXcKjwCtG8lZzIKpTWv6m+bn8WWAk9I5hslD//VhSFrIK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="443700551"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="443700551"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 08:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="799842570"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="799842570"
Received: from svuppala-mobl.amr.corp.intel.com (HELO [10.212.207.249]) ([10.212.207.249])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 08:09:32 -0700
Message-ID: <6c75e986-29a4-d97c-3862-d20397f8b8b4@linux.intel.com>
Date:   Thu, 8 Jun 2023 10:09:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/4] soundwire: introduce SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com
References: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
 <20230531033736.792464-3-yung-chuan.liao@linux.intel.com>
 <ZIF94vZHzeGXfyin@matsya>
Content-Language: en-US
In-Reply-To: <ZIF94vZHzeGXfyin@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/23 02:06, Vinod Koul wrote:
> On 31-05-23, 11:37, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> This patch adds a new Device Number allocation strategy, with the IDA
>> used only for devices that are wake-capable.
>>
>> "regular" devices such as amplifiers will use Device Numbers
>> [1..min_ida-1].
>>
>> "wake-capable" devices such as jack or microphone codecs will use
>> Device Numbers [min_ida..11].
>>
>> This hybrid strategy extends the number of supported devices in a
>> system by only constraining the allocation if required, e.g. in the
>> case of Intel LunarLake platforms the wake-capable devices are
>> required to have a unique address to use the HDaudio SDI and HDAudio
>> WAKEEN/WAKESTS registers.
> 
> This seems to be a consequence of Intel hardware decisions, so I guess
> best suited place for this is Intel controller, do we really want to
> have this in core logic?

It's a valid objection.

The reason why I added the alternate strategies in the core logic is
that the IDA and hybrid approach are just software-based with no
specific hardware dependencies. If QCOM or AMD wanted to use the
strategies contributed and tested by Intel, it'd be a two-line change on
their side.

That said, it's likely that at some point *someone* will want to
constrain the device number allocation further, be it with ACPI/DT
properties or reading hardware registers. The device number is a
de-facto priority given the way we scan the PING frames, so some systems
may want to give a higher priority to a specific peripherals.

This would push us to add a master ops callback to control the device
number allocation. It's a bit invasive but that would give the ultimate
flexibility. Reuse between vendors could be possible if 'generic'
callbacks were part of a library to pick from.

I don't really have any objections if this vendor-specific callback was
preferred, it may be a bit early to add this but long-term it's probably
what makes more sense.

I'll go with the flow on suggested recommendations.

>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Rander Wang <rander.wang@intel.com>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>  drivers/soundwire/bus.c       | 26 +++++++++++++++++++++-----
>>  include/linux/soundwire/sdw.h |  4 ++++
>>  2 files changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index e8c1c55a2a73..6f465cce8369 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -159,7 +159,9 @@ static int sdw_delete_slave(struct device *dev, void *data)
>>  
>>  	if (slave->dev_num) { /* clear dev_num if assigned */
>>  		clear_bit(slave->dev_num, bus->assigned);
>> -		if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA)
>> +		if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA ||
>> +		    (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY &&
>> +		     slave->prop.wake_capable))
>>  			ida_free(&sdw_peripheral_ida, slave->dev_num);
>>  	}
>>  	list_del_init(&slave->node);
>> @@ -699,17 +701,31 @@ EXPORT_SYMBOL(sdw_compare_devid);
>>  /* called with bus_lock held */
>>  static int sdw_get_device_num(struct sdw_slave *slave)
>>  {
>> +	struct sdw_bus *bus = slave->bus;
>>  	int bit;
>>  
>> -	if (slave->bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA) {
>> +	if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA ||
>> +	    (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY &&
>> +	     slave->prop.wake_capable)) {
>>  		bit = ida_alloc_range(&sdw_peripheral_ida,
>> -				      slave->bus->dev_num_ida_min, SDW_MAX_DEVICES,
>> +				      bus->dev_num_ida_min, SDW_MAX_DEVICES,
>>  				      GFP_KERNEL);
>>  		if (bit < 0)
>>  			goto err;
>>  	} else {
>> -		bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
>> -		if (bit == SDW_MAX_DEVICES) {
>> +		int max_devices = SDW_MAX_DEVICES;
>> +
>> +		if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY &&
>> +		    !slave->prop.wake_capable) {
>> +			max_devices = bus->dev_num_ida_min - 1;
>> +
>> +			/* range check */
>> +			if (max_devices < 1 || max_devices > SDW_MAX_DEVICES)
>> +				return -EINVAL;
>> +		}
>> +
>> +		bit = find_first_zero_bit(bus->assigned, max_devices);
>> +		if (bit == max_devices) {
>>  			bit = -ENODEV;
>>  			goto err;
>>  		}
>> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
>> index 4656d6d0f3bb..8a7541ac735e 100644
>> --- a/include/linux/soundwire/sdw.h
>> +++ b/include/linux/soundwire/sdw.h
>> @@ -869,10 +869,14 @@ struct sdw_master_ops {
>>   * @SDW_DEV_NUM_ALLOC_DEFAULT: unconstrained first-come-first-serve allocation,
>>   * using range [1, 11]
>>   * @SDW_DEV_NUM_ALLOC_IDA: IDA-based allocation, using range [ida_min, 11]
>> + * @SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY: Hybrid allocation where wake-capable devices rely on
>> + * IDA-based allocation and range [ida_min, 11], while regular devices rely on default
>> + * allocation in range [1, ida_min - 1]
>>   */
>>  enum sdw_dev_num_alloc {
>>  	SDW_DEV_NUM_ALLOC_DEFAULT = 0,
>>  	SDW_DEV_NUM_ALLOC_IDA,
>> +	SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY,
>>  };
>>  
>>  /**
>> -- 
>> 2.25.1
> 
