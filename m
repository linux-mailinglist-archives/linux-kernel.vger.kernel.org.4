Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDAD6F31B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjEAOBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEAOBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:01:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F79710D;
        Mon,  1 May 2023 07:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682949662; x=1714485662;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Qm+V5a7mXlhtM5xei+hBeHzRmB8KI195QQcxOYMy2bs=;
  b=cEiWTz30D2B+VRlhJ1SUr6S9ui8XfjcNH5ore/PKrHUF96M8OTKqeA60
   NlU2lPx6GJXZe4vRAZs7rWjLvUKIVczjNncKN/sicDE3KtZ7l10NmvZ0E
   R+hCXVen26bPYcwToAy1OaEkSSI4tzwh1NrMllLTBWeZ4px/AZLoiVIrP
   umGJTGk1qsNDKpck6QITmIuTTMEBerxTj/uOqKZ4qM+9R4EE9895AbOt8
   Z9Qqrhbfh5sTJhF/E6GD6IzWQjHAYKdPcqWARoAgCH5/0vVkt66mzt/HY
   sv1oNiqxn20dC4UmGYtgCq8+baz0my/tY1JgeiOa3TZoetOBWbOd3OvYs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="434464623"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="434464623"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:01:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="870186698"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="870186698"
Received: from blele-mobl.amr.corp.intel.com (HELO [10.212.170.95]) ([10.212.170.95])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:01:00 -0700
Message-ID: <3f618297-e1cd-a46d-5318-c3b77a0fc78d@linux.intel.com>
Date:   Mon, 1 May 2023 08:43:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 6/6] soundwire: qcom: do not probe devices before bus/link
 init
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-7-krzysztof.kozlowski@linaro.org>
 <28141433-2130-e278-0f59-d9ab507b9be3@linux.intel.com>
 <42fbf7ad-54db-0917-bb85-a1be9f99cc45@linaro.org>
Content-Language: en-US
In-Reply-To: <42fbf7ad-54db-0917-bb85-a1be9f99cc45@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/23 07:24, Krzysztof Kozlowski wrote:
> On 20/04/2023 23:37, Pierre-Louis Bossart wrote:
>>
>>
>> On 4/20/23 05:16, Krzysztof Kozlowski wrote:
>>> Soundwire devices are supposed to be kept in reset state (powered off)
>>> till their probe() or component bind() callbacks.  However if they are
>>> already powered on, then they might enumerate before the master
>>> initializes bus in qcom_swrm_init() leading to occasional errors like:
>>
>> The problem statement is really hard to follow.
>>
>> The peripheral can only be enumerated AFTER
>> a) the manager starts the bus clock and transmitting PING frames
>> b) the peripheral detects the sync words for 16 frames in a row.
>> c) the peripheral reports as Attached in the Device0 slot
>>
>> That sequence holds whether the manager does the enumeration manually or
>> relies on hardware-assisted autoenumeration. This is what the spec requires.
>>
>> So why can't the bus clock start be controlled by the manager driver,
>> and started once all required initializations are done?
>>
>> I mean, there's got to be some sort of parent-child hierarchy with
>> manager first, peripheral(s) second, I don't get how these steps could
>> be inverted or race.
>>
>>>   qcom-soundwire 6d30000.soundwire-controller: Qualcomm Soundwire controller v2.0.0 Registered
>>>   wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:4 (ops wcd938x_sdw_component_ops)
>>>   wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:3 (ops wcd938x_sdw_component_ops)
>>>   qcom-soundwire 6ad0000.soundwire-controller: swrm_wait_for_wr_fifo_avail err write overflow
>>>
>>> The problem primarily lies in Qualcomm Soundwire controller probe() sequence:
>>> 1. request_threaded_irq()
>>> 2. sdw_bus_master_add() - which will cause probe() and component bind()
>>>    of Soundwire devices, e.g. WCD938x codec drivers.  Device drivers
>>>    might already start accessing their registers.
>>
>> not if the bus clock hasn't started...
>>
>>> 3. qcom_swrm_init() - which initializes the link/bus and enables
>>>    interrupts.
>>
>> if you can move the clock start in 3) then problem solved. Why can't
>> this be done?
> 
> Responding to all your three responses:
> The clock is enabled in this 3. qcom_swrm_init(), so the old code to my
> knowledge is written exactly how you expect.
> 
> However even with stopped clock, the device enumerates at
> sdw_bus_master_add(), before anything is enabled.

Erm, that's not physically possible...

The peripheral can report as attached and be enumerated by the manager,
i.e. assigned a non-zero "Device Number" after the peripheral
synchronizes on 16 frames with valid static and dynamic syncwords. That
can only happen if there is a clock toggling and PING frames transmitted
on the data line.

There's something else at play here.

> I also checked the reset values of these registers - clock is off after
> reset. Assuming of course I look at correct clock registers... but I
> have only one.
> 
>>
>>> Any access to device registers at (2) above, will fail because link/bus
>>> is not yet initialized.
>>>
>>> However the fix is not as simple as moving qcom_swrm_init() before
>>> sdw_bus_master_add(), because this will cause early interrupt of new
>>> slave attached.  The interrupt handler expects bus master (ctrl->bus.md)
>>> to be allocated, so this would lead to NULL pointer exception.
>>>
>>> Rework the init sequence and change the interrupt handler.  The correct
>>> sequence fixing accessing device registers before link init is now:
>>> 1. qcom_swrm_init()
>>> 2. request_threaded_irq()
>>> 3. sdw_bus_master_add()
>>> which still might cause early interrupts, if Soundwire devices are not
>>> in powered off state before their probe.  This early interrupt issue is
>>
>> You'd need to clarify in which step the bus clock starts. In general,
>> you want to clock started last.
> 
> Clock is enabled in qcom_swrm_init() step, but as I wrote above, it
> looks like it does not matter for enumeration.

without a clock you can't have any enumeration.


>>> +	 * from reset by its probe() or bind() function, as a result of
>>> +	 * sdw_bus_master_add().
>>> +	 * Add a simple check to avoid NULL pointer except on early interrupts.
>>> +	 * Note that if this condition happens, the slave device will not be
>>> +	 * enumerated. Its driver should be fixed.
>>
>> ???
>>
>> The codec driver is NEVER involved in enumeration.
> 
> If the device stays in power down, only the driver bind can bring it on.
> enumeration won't happen when device is powered down, right?

The codec driver can indeed control the codec power with sideband links
- i.e. not with SoundWire but gpios/I2C/SPI, etc. - and it could very
well prevent the codec hardware from showing up on the bus until TBD
platform-specific criteria are met.

But that's not really taking part in the enumeration process, rather
gating the enumeration process.

>> The only thing a codec driver should do is provide a callback to be
>> notified of a status change for additional initialization, but the
>> enumeration can be done even in the absence of a codec driver.
>>
>> The proof in the pudding is that you can 'blacklist' a codec driver and
>> bind it later, after the hardware is enumerated. You can even unbind a
>> codec driver and nothing bad will happen (we hardened that sequence last
>> year).
>>
>> probe != enumeration != initialization for SoundWire codecs.
>>
>> Probe and enumeration can happen in any order
>> Initialization can only happen after both probe and enumeration happened.
> 
> I am speaking here about component_master_ops->bind() callback.

That's on the manager side, I really don't see how this is related to
the codec?

>>> +	 * removing Soundwire bus master.
>>> +	 */
>>> +	if (ctrl->version < SWRM_VERSION_2_0_0)
>>> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
>>> +				0);
>>> +	if (ctrl->mmio)
>>> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
>>> +				0);
>>> +
>>> +	cancel_delayed_work_sync(&ctrl->new_slave_work);
>>>  	sdw_bus_master_delete(&ctrl->bus);
>>>  	clk_disable_unprepare(ctrl->hclk);
>>
>> should the last two be inverted? Keeping a clock running while removing
>> stuff is asking for trouble.

actually it doesn't really matter, if the interrupts are disabled first
and you wait for in-flight work to be done. Ignore this comment.
> 
> It is a reversed probe(), which is usually correct. Do you expect
> probe() like:
> 
> 	clk_enable
> 	sdw_bus_master_add

it's likely the other way around,

probe():
sdw_bus_master_add
clk_enable

assuming that clk_enable() starts the bus - not sure it does based on
the answers above.

