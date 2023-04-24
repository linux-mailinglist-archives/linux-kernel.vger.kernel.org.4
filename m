Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E086D776B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbjDEI4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbjDEI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8F619A3;
        Wed,  5 Apr 2023 01:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 922FD624FF;
        Wed,  5 Apr 2023 08:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FA9C4339B;
        Wed,  5 Apr 2023 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680685010;
        bh=/KfvjCzvgYkaAu1HIMxMzJAKnYLwttbLrbgub4uLoT4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JOYvBlPCUoLJOaXfQC6YOMmxcvjqZ8e1CGw0+pJvUHaYSsqAuH0mfd5UPfJtQUCDe
         F9CjnRzXOWNQqMphdzOkVk2A9bgc8gi9cdJfphiJmaV3gNvcUyN/Xz2o1EY1Rx3Jm9
         YI9wzaj0tNEIk93VYHoEvNFehr15c9ZIQA6aGYnyT8ZiFIAzjDeeiILoKpKkxkiJRE
         zC6M1xDdnRkXADnt9Ckuw2ATVEfXzlMoS71qMYwvggDKcUS2TzG1Z7HNDLVJ+6Jpe8
         yaaDRULKRf29pB3Rvlxe06MralH7FR3cu80rv1XNUroReOzaFXWXDRZIhrTzIm+5ZL
         O1/WjPHBjIc1Q==
Message-ID: <8884129b-8c73-df1e-e342-01defce0d407@kernel.org>
Date:   Wed, 5 Apr 2023 11:56:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com" <srk@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230321184346.dxmqwq5rcsc2otrj@synopsys.com>
 <20230321190458.6uqlbtyfh3hc6ilg@synopsys.com>
 <7db7eb59-68fc-b7b2-5a29-00b698f68cbb@kernel.org>
 <20230322173150.nscqyzwcrecxjuaa@synopsys.com>
 <20230323021737.pv2nrb2md54a5pdg@synopsys.com>
 <624243b4-3fb5-6e60-e324-8df6b853205f@kernel.org>
 <20230323205139.4on6vx555ohdec7y@synopsys.com>
 <4d2f628e-6adc-5190-61b3-cc9d61f34a84@kernel.org>
 <20230403233652.2exkx2ikifuo4m6h@synopsys.com>
 <75db038b-ec7b-80e5-2652-8c5d2a9e317a@kernel.org>
 <20230404215317.44j2cl3uhzdk3aty@synopsys.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230404215317.44j2cl3uhzdk3aty@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2023 00:53, Thinh Nguyen wrote:
> On Tue, Apr 04, 2023, Roger Quadros wrote:
>>
>>
>> On 04/04/2023 02:37, Thinh Nguyen wrote:
>>> On Fri, Mar 31, 2023, Roger Quadros wrote:
>>>> Hi,
>>>>
>>>> On 23/03/2023 22:51, Thinh Nguyen wrote:
>>>>> On Thu, Mar 23, 2023, Roger Quadros wrote:
>>>>>>
>>>>>>
>>>>>> On 23/03/2023 04:17, Thinh Nguyen wrote:
>>>>>>> On Wed, Mar 22, 2023, Thinh Nguyen wrote:
>>>>>>>> On Wed, Mar 22, 2023, Roger Quadros wrote:
>>>>>>>>> On 21/03/2023 21:05, Thinh Nguyen wrote:
>>>>>>>>>> On Tue, Mar 21, 2023, Thinh Nguyen wrote:
>>>>>>>>>>> On Tue, Mar 21, 2023, Roger Quadros wrote:
>>>>>>>>>>>> Hi Thinh,
>>>>>>>>>>>>
>>>>>>>>>>>> On 20/03/2023 20:52, Thinh Nguyen wrote:
>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Mon, Mar 20, 2023, Roger Quadros wrote:
>>>>>>>>>>>>>> Implement 'snps,gadget-keep-connect-sys-sleep' property.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Do not stop the gadget controller and disconnect if this
>>>>>>>>>>>>>> property is present and we are connected to a USB Host.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Prevent System sleep if Gadget is not in USB suspend.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>  drivers/usb/dwc3/core.c   | 25 +++++++++++++++++++------
>>>>>>>>>>>>>>  drivers/usb/dwc3/core.h   |  2 ++
>>>>>>>>>>>>>>  drivers/usb/dwc3/gadget.c | 25 +++++++++++++++++++++++--
>>>>>>>>>>>>>>  3 files changed, 44 insertions(+), 8 deletions(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>>>>>>>>>>>> index 476b63618511..a47bbaa27302 100644
>>>>>>>>>>>>>> --- a/drivers/usb/dwc3/core.c
>>>>>>>>>>>>>> +++ b/drivers/usb/dwc3/core.c
>>>>>>>>>>>>>> @@ -1575,6 +1575,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>>>>>>>>>>>>>  	dwc->dis_split_quirk = device_property_read_bool(dev,
>>>>>>>>>>>>>>  				"snps,dis-split-quirk");
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>> +	dwc->gadget_keep_connect_sys_sleep = device_property_read_bool(dev,
>>>>>>>>>>>>>> +				"snps,gadget-keep-connect-sys-sleep");
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>  	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
>>>>>>>>>>>>>>  	dwc->tx_de_emphasis = tx_de_emphasis;
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>> @@ -2027,14 +2030,20 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>  	unsigned long	flags;
>>>>>>>>>>>>>>  	u32 reg;
>>>>>>>>>>>>>> +	int ret;
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>  	switch (dwc->current_dr_role) {
>>>>>>>>>>>>>>  	case DWC3_GCTL_PRTCAP_DEVICE:
>>>>>>>>>>>>>>  		if (pm_runtime_suspended(dwc->dev))
>>>>>>>>>>>>>>  			break;
>>>>>>>>>>>>>> -		dwc3_gadget_suspend(dwc);
>>>>>>>>>>>>>> +		ret = dwc3_gadget_suspend(dwc);
>>>>>>>>>>>>>> +		if (ret) {
>>>>>>>>>>>>>> +			dev_err(dwc->dev, "gadget not suspended: %d\n", ret);
>>>>>>>>>>>>>> +			return ret;
>>>>>>>>>>>>>> +		}
>>>>>>>>>>>>>>  		synchronize_irq(dwc->irq_gadget);
>>>>>>>>>>>>>> -		dwc3_core_exit(dwc);
>>>>>>>>>>>>>> +		if(!dwc->gadget_keep_connect_sys_sleep)
>>>>>>>>>>>>>> +			dwc3_core_exit(dwc);
>>>>>>>>>>>>>>  		break;
>>>>>>>>>>>>>>  	case DWC3_GCTL_PRTCAP_HOST:
>>>>>>>>>>>>>>  		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
>>>>>>>>>>>>>> @@ -2088,11 +2097,15 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>  	switch (dwc->current_dr_role) {
>>>>>>>>>>>>>>  	case DWC3_GCTL_PRTCAP_DEVICE:
>>>>>>>>>>>>>> -		ret = dwc3_core_init_for_resume(dwc);
>>>>>>>>>>>>>> -		if (ret)
>>>>>>>>>>>>>> -			return ret;
>>>>>>>>>>>>>> +		if (!dwc->gadget_keep_connect_sys_sleep)
>>>>>>>>>>>>>> +		{
>>>>>>>>>>>>>> +			ret = dwc3_core_init_for_resume(dwc);
>>>>>>>>>>>>>> +			if (ret)
>>>>>>>>>>>>>> +				return ret;
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>>>>>>>>>>>>>> +		}
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>> -		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>>>>>>>>>>>>>>  		dwc3_gadget_resume(dwc);
>>>>>>>>>>>>>>  		break;
>>>>>>>>>>>>>>  	case DWC3_GCTL_PRTCAP_HOST:
>>>>>>>>>>>>>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>>>>>>>>>>>>>> index 582ebd9cf9c2..f84bac815bed 100644
>>>>>>>>>>>>>> --- a/drivers/usb/dwc3/core.h
>>>>>>>>>>>>>> +++ b/drivers/usb/dwc3/core.h
>>>>>>>>>>>>>> @@ -1328,6 +1328,8 @@ struct dwc3 {
>>>>>>>>>>>>>>  	unsigned		dis_split_quirk:1;
>>>>>>>>>>>>>>  	unsigned		async_callbacks:1;
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>> +	unsigned		gadget_keep_connect_sys_sleep:1;
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>  	u16			imod_interval;
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>  	int			max_cfg_eps;
>>>>>>>>>>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>>>>>>>>>>> index 3c63fa97a680..8062e44f63f6 100644
>>>>>>>>>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>>>>>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>>>>>>>>>> @@ -4572,12 +4572,23 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
>>>>>>>>>>>>>>  int dwc3_gadget_suspend(struct dwc3 *dwc)
>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>  	unsigned long flags;
>>>>>>>>>>>>>> +	int link_state;
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>  	if (!dwc->gadget_driver)
>>>>>>>>>>>>>>  		return 0;
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>> -	dwc3_gadget_run_stop(dwc, false, false);
>>>>>>>>>>>>>> +	if (dwc->gadget_keep_connect_sys_sleep && dwc->connected) {
>>>>>>>>>>>>>> +		link_state = dwc3_gadget_get_link_state(dwc);
>>>>>>>>>>>>>> +		/* Prevent PM Sleep if not in U3/L2 */
>>>>>>>>>>>>>> +		if (link_state != DWC3_LINK_STATE_U3)
>>>>>>>>>>>>>> +			return -EBUSY;
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +		/* don't stop/disconnect */
>>>>>>>>>>>>>> +		dwc3_gadget_disable_irq(dwc);
>>>>>>>>>>>>>
>>>>>>>>>>>>> We shouldn't disable event interrupt here. What will happen if the
>>>>>>>>>>>>
>>>>>>>>>>>> Due to some reason, if I don't disable the event interrupts here then
>>>>>>>>>>>> after USB resume the USB controller is malfunctioning.
>>>>>>>>>>>> It no longer responds to any requests from Host.
>>>>>>>>>>>
>>>>>>>>>>> You should look into this. These events are important as they can tell
>>>>>>>>>>> whether the host initiates resume.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> device is disconnected and reconnect to the host while the device is
>>>>>>>>>>>>> still in system suspend? The host would not be able to communicate with
>>>>>>>>>>>>> the device then.
>>>>>>>>>>>>
>>>>>>>>>>>> In the TI platform, The system is woken up on any VBUS/linestate change
>>>>>>>>>>>> and in dwc3_gadget_resume we enable the events again and check for pending
>>>>>>>>>>>> events. Is it pointless to check for pending events there?
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> It seems fragile for the implementation to be dependent on platform
>>>>>>>>>>> specific feature right?
>>>>>>>>>>>
>>>>>>>>>>> Also, what will happen in a typical case when the host puts the device
>>>>>>>>>>> in suspend and initiates resume while the device is in system suspend
>>>>>>>>>>> (and stay in suspend over a period of time)? There is no VBUS change.
>>>>>>>>>>> There will be problem if host detects no response from device in time.
>>>>>>>>>>>
>>>>>>>>>>> Don't we need these events to wakeup the device?
>>>>>>>>>
>>>>>>>>> That's why the TI implementation has line-state change detection to
>>>>>>>>> detect a USB resume. We are doing a out-of-band wake-up. The wake up
>>>>>>>>> events are configured in the wrapper driver (dwc3-am62.c).
>>>>>>>>>
>>>>>>>>> Do you know of any dwc3 implementation that uses in-band mechanism
>>>>>>>>> to wake up the System. i.e. it relies on events enabled in DEVTEN register?
>>>>>>>>>
>>>>>>>>
>>>>>>>> We rely on PME. The PME is generated from the PMU of the usb controller
>>>>>>>> when it detects a resume. If your platform supports hibernation and if
>>>>>>>> the resume signal is connected to the lower layer power manager of your
>>>>>>>> device, then you can wakeup the system one level at a time. For example,
>>>>>>>> if your device is a pci device, that wakeup signal would tie to the pci
>>>>>>>> power manager, waking up the pci layer before waking up the core of the
>>>>>>>> usb controller. That's how the host wakes up the host system (e.g. from
>>>>>>>> remote wakeup). For this to work, we expect something similar on the
>>>>>>>> device side.
>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> We may not be able to suspend everything in system suspend for this
>>>>>>>>>> case. I'm thinking of treating these events as if they are PME to wakeup
>>>>>>>>>> the device, but they are not the same. It may not be simple to handle
>>>>>>>>>> this. The lower layers may need to stay awake for the dwc3 to handle
>>>>>>>>>> these events. Hm... it gets a bit complicated.
>>>>>>>>>
>>>>>>>>> As we are going into suspend, we are not really in a position to handle any
>>>>>>>>> (DEVTEN) events till we have fully resumed.
>>>>>>>>> So yes, we need to rely on platform specific implementation to wake
>>>>>>>>> the System on any USB event.
>>>>>>>>>
>>>>>>>>
>>>>>>>> You may be able to detect vbus change through the connector controller.
>>>>>>>> However, the usb controller is the one that detects host resume. What
>>>>>>>> platform specific implementation do you have outside of the usb
>>>>>>>> controller do you have to get around that?
>>>>>>>>
>>>>>>>> I'm not sure if your platform supports hibernation or if the PME signal
>>>>>>>> on your platform can wakeup the system, but currently dwc3 driver
>>>>>>>> doesn't handle hibernation (device side). If there's no hibernation,
>>>>>>>> there's no PME.
>>>>>>
>>>>>> No, in this TI SoC, hibernation feature is not supported in the dwc3 core.
>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> Actually, I think the dwc3 core is still on during system suspend for
>>>>>>> you right? Then I think we can use the wakeup event to wakeup system
>>>>>>> suspend on host resume? You can ignore about PME in this case. You may
>>>>>>> need to look into what needs stay awake to allow for handling of the
>>>>>>> dwc3 event.
>>>>>>
>>>>>> But in SoC deep-sleep state, all clocks to the dwc3 core are stopped.
>>>>>> So I'm not sure if dwc3 events will work.
>>>>>>
>>>>>
>>>>> Right, you need to keep those clocks running to detect host resume.
>>>>> There's still some power saving through the dwc3 controller's handling
>>>>> in suspend. You may have some limited power saving from other suspended
>>>>> devices on your setup. However, I don't think we can expect the platform
>>>>> to go into deep-sleep and also handle host resume.
>>>>
>>>> Why not? if the PHY can detect the host resume and wake up the SoC it will
>>>> work right?
>>>>
>>>
>>> Hm... I supposed it may be possible. But it may need some unconventional
>>> design? The dwc3 controller is currently registered to the phy. For that
>>> to work, your phy needs to be able to talk to both the dwc3 controller
>>> and some other controller (equivalent to dwc3 PMU) that manages
>>> power/interrupt. The dwc3 controller would need to relinquish control to
>>> this other phy controller on suspend. The phy driver would then be able
>>> to assert interrupt waking up the system on resume sigal detection,
>>> which in turn relinquish control to the dwc3 controller. All of this has
>>> to work while the phy signaling remains synchronized with the dwc3
>>> controller.
>>
>> My understanding is that all this is taken care by PHY integration design with
>> DWC3 core on the TI SoC.
>>
>>>
>>> From the patches you sent, I don't see the changes necesssary for this
>>> to work. If there is something that I'm missing, please also note it or
>>> add it here to the series.
>>
>> There is nothing more as the details are taken care by PHY logic and
>> necessary integration with DWC3.
>>
>> For the PHY wake-up programming details you have already checked this series [1].
>>
>> [1] - https://urldefense.com/v3/__https://lore.kernel.org/all/20230316131226.89540-1-rogerq@kernel.org/__;!!A4F2R9G_pg!ayqpaWwnWIO7SKktk4kI2EJLwDTIv2nYYCgBGHUlt56KTzeYkDEdq2Q5ZvZFsuCWIlcXGET230YY5J3y_sHV$ 
>>
> 
> I may have misunderstood your platform implementation. My understanding
> is that it can only detect VBUS and that it can only resume on VBUS
> valid.
> 
> Does the "LINESTATE" here gets asserted if say there's a LFPS detection?

Yes. The wake up logic on the SoC is snooping the UTMI lines from the PHY and on any
change it can detect and wake up the SoC.

cheers,
-roger
