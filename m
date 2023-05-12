Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36BA700D16
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjELQfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjELQfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:35:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE44BA25F;
        Fri, 12 May 2023 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683909305; x=1715445305;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=478mvwmsv9IeCMZb4/HmUb/CH/Ey2PB85AwyLXEFDQk=;
  b=UeEvL9hWfot7tSnqfsI2FbgI5ESm1HAlmg3BbnV7MgpL/ysAA3dhbjv8
   6zVUa4KFZ+8wJV35SYcvBezL46wytR+Z4VRj4TlpZb5dxgz3Jbo6YWXst
   KAt1/R0jIWobmrhdQxOCWVkaXgNpZcZd1RP/URnBUaogS/I0g2J7VzlEt
   DfyBCBZr5nU63VMD2iSwlOv1lGweEXsgUPQky/T6M0F9umqPemUyui48K
   jGFgdE/w3L9OfPjxe10jFJHHhneIiWT4XiFPsSPDs8+PVSmkm7msjR68p
   LTT90qUbyq44P5axVYuQLhu64TT2tUJ+/55wZZn6lfY4+a86nj0FMDy08
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="331193612"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="331193612"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 09:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="1030146824"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="1030146824"
Received: from winkelru-mobl.amr.corp.intel.com (HELO [10.212.144.249]) ([10.212.144.249])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 09:35:03 -0700
Message-ID: <5363c7b7-7a5b-490c-445b-fb7ccd693c63@linux.intel.com>
Date:   Fri, 12 May 2023 11:34:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 01/10] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-2-ckeepax@opensource.cirrus.com>
 <0471f085-14bf-c159-9b92-62983af6c19a@linux.intel.com>
 <20230512160224.GK68926@ediswmail.ad.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230512160224.GK68926@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/23 11:02, Charles Keepax wrote:
> On Fri, May 12, 2023 at 08:45:51AM -0500, Pierre-Louis Bossart wrote:
>>> @@ -1711,6 +1739,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>>>  				struct device *dev = &slave->dev;
>>>  				struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
>>>  
>>> +				if (slave->prop.use_domain_irq && slave->irq)
>>> +					handle_nested_irq(slave->irq);
>>> +
>>
>> I am a bit lost here, I can understand that alerts would be handled by a
>> dedicated handler, but here the code continues and will call the
>> existing interrupt_callback.
>>
>> Is this intentional? I wonder if there's a risk with two entities
>> dealing with the same event and programming the same registers.
>> Shouldn't there be some sort of 'either or' rule?
>>
> 
> I guess there is a risk of them "handling" the IRQ twice,
> although it is hard to see why you would write the driver that
> way. Also since they are sequencial the second would I guess
> just see that no IRQs are pending.
> 
> The intention for calling both is that it facilitates using
> the same IRQ handler for I2C and SoundWire. At least on the
> Cirrus devices there are a bunch of chip specific registers
> that need treated exactly the same on I2C and SoundWire, but
> then a couple of extra registers that need handled in the
> SoundWire case. This way the handling of those can be kept
> completely in the SoundWire part of the code and not ifdef-ed
> into the main IRQ path.

Sounds good to me, but it's worth adding a comment and improving the
commit message with design intent/rules since it's a common part in
drivers/soundwire/
