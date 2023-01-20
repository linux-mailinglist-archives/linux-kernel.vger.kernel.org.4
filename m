Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6A3675DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjATTQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjATTQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:16:43 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5E59D291
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674242202; x=1705778202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8RxJmJCTilGnrtWWSCiuVo11UCJbpns4JVnRmQGbTTw=;
  b=gQX+YqglSUNmX5l/371/tI2AFw4+L2nbgs50sGseHU91Wsqx/nQ6ndAe
   /ibr5aTh2983ukUjjcVPWPK0SPwaMxDfYircqICIz/SaANXQ4CumQYxy8
   0GEG7QZkubLqlxHX/pyJvch4heaTwjjfQleRyS0f9AZiKB+NCeG255dm2
   im/l6TKOzTjx0EtZUoMS1aRgk0BbqS9H6kT3FUiF806Jp58UcYo+msa8N
   hzLo/4vQLQVpWy0lPy08eOZDePkKDDtor1s9t+YQTgDDz8AO70dthvFzO
   ygkEM3QbocKSpDdmyeefiIZA5eFrJCZGBqE8TtKAd3Izfj4SVIGm+Nirg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="388026929"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="388026929"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 11:16:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="691156080"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="691156080"
Received: from gallegos-mobl1.amr.corp.intel.com (HELO [10.212.24.2]) ([10.212.24.2])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 11:16:41 -0800
Message-ID: <881088ad-95d7-2462-20d2-72a6a9d3ba68@linux.intel.com>
Date:   Fri, 20 Jan 2023 10:20:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
 <20230119165104.3433290-2-ckeepax@opensource.cirrus.com>
 <c05a6791-96a7-2b10-d353-eb7b316aefc8@linux.intel.com>
 <20230120095941.GL36097@ediswmail.ad.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230120095941.GL36097@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/23 03:59, Charles Keepax wrote:
> On Thu, Jan 19, 2023 at 11:12:04AM -0600, Pierre-Louis Bossart wrote:
>> No objection on this addition, just a couple of comments to improve it:
>>
>>>  EXPORT_SYMBOL(sdw_bus_master_add);
>>> @@ -158,6 +183,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
>>>  	mutex_lock(&bus->bus_lock);
>>>  
>>>  	if (slave->dev_num) { /* clear dev_num if assigned */
>>> +		irq_dispose_mapping(irq_find_mapping(bus->domain, slave->dev_num));
>>> +
>>
>> could this be done conditionally. e.g.
>>
>> if (slave->prop.irq)
>>     irq_dispose_mapping(irq_find_mapping(bus->domain, slave->dev_num));
>>
>>> +			slave->irq = irq_create_mapping(bus->domain, dev_num);
>>> +			if (!slave->irq) {
>>> +				dev_err(bus->dev, "Failed to map IRQ\n");
>>> +				return -EINVAL;
>>> +			}
>>
>> ...and here....
>>
>> if (slave->prop.irq) {
>> 	slave->irq = irq_create_mapping(bus->domain, dev_num);
>> 	if (!slave->irq) {
>> 		dev_err(bus->dev, "Failed to map IRQ\n");
>> 		return -EINVAL;
>> 	}
>> }
>>
> 
> Yeah I am happy to make those conditional, I guess it is cleaner
> to not map IRQs if they wont be used.

ok

> 
>>> @@ -369,6 +371,7 @@ struct sdw_dpn_prop {
>>>   * @clock_reg_supported: the Peripheral implements the clock base and scale
>>>   * registers introduced with the SoundWire 1.2 specification. SDCA devices
>>>   * do not need to set this boolean property as the registers are required.
>>> + * @irq: call actual IRQ handler on slave, as well as callback
>>>   */
>>>  struct sdw_slave_prop {
>>>  	u32 mipi_revision;
>>> @@ -393,6 +396,7 @@ struct sdw_slave_prop {
>>>  	u8 scp_int1_mask;
>>>  	u32 quirks;
>>>  	bool clock_reg_supported;
>>> +	bool irq;
>>
>> this can be confused with the 'wake_capable' property.
>>
>> maybe 'out_of_band_irq' ?
>>
> 
> Yes I struggle on the name a bit and then just gave up and
> went with plain "irq", hard to know what to call it. Not sure
> out_of_band is quite right since it not really out of band,
> handle_nested_irq pretty much basically boils down to a function
> call really. Maybe something like "map_irq", or "use_domain_irq"?

Naming is hard. I use 'in-band wake' for SoundWire-based notifications,
so I used 'out-of-band' for non-SoundWire stuff.

use_domain_irq sounds goods to me, it's different enough that confusions
are not possible.

>> There should be an explanation and something checking that both are not
>> used concurrently.
> 
> I will try to expand the explanation a litte, but I dont see any
> reason to block calling both handlers, no ill effects would come
> for a driver having both and it is useful if any soundwire
> specific steps are needed that arn't on other control buses.

I think it's problematic if the peripheral tries to wake-up the manager
from clock-stop with both an in-band wake (i.e. drive the data line
high) and a separate GPIO-based interrupt. It's asking for trouble IMHO.
We spent hours in the MIPI team to make sure there were no races between
the manager-initiated restarts and peripheral-initiated restarts, adding
a 3rd mechanism in the mix gives me a migraine already.
