Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2FC664CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjAJTqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjAJTqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:46:35 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C343D9EC;
        Tue, 10 Jan 2023 11:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673379994; x=1704915994;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=KqQe3X8R2+M4ca8Y3nt3MFKKLU33LTTi3NG9IoqqMpY=;
  b=YCLK7wPX/YybJccre6Tdprp7RuVNpQyGfDG4+VCqNbXt7nRG0Kn/Wqxn
   9rwB2tCceIueG7xZ1K8CJ5HyEOOUlkkfyteVxvIz/0c6BhtN8oCdCT/Ro
   AB7HcVFsVlbGm/YLyiPH9oVDhxXN0eutnTwsyhGZZ+im668hwS4Arrzn+
   k2wcO2KVxcxtnmNWaz6T681WGEqJhSwgVtxMSB4JfVi6eO4H6O0mhDlMS
   tC4kDCJfWu7geKlR/5rvBy5O3qtj27NoTIPqILcA/cEqXHXf2XGIawrLa
   7N3aMVTgJd2g231Xxo2rbkqmPGkQSon4cvKLa4f5MhoNw88uYcHyPMbR4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385550319"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="385550319"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 11:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="831113342"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="831113342"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2023 11:46:28 -0800
Message-ID: <cefcc5c6-6a91-c737-252a-edf596f77473@linux.intel.com>
Date:   Tue, 10 Jan 2023 21:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org, Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-8-quic_wcheng@quicinc.com>
 <7dfe215b-4cc7-f95f-17c3-563c0120151a@linux.intel.com>
 <f7f80320-02bb-a573-dd95-b6d58c260624@quicinc.com>
 <5f54c5a3-caf0-2920-e90f-68124ed2e06c@linux.intel.com>
 <d1334e58-1126-c068-d211-8fd3b7dcbf17@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC PATCH 07/14] usb: host: xhci: Add XHCI secondary interrupter
 support
In-Reply-To: <d1334e58-1126-c068-d211-8fd3b7dcbf17@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.1.2023 22.24, Wesley Cheng wrote:
> Hi Mathias,
> 
> On 1/2/2023 8:38 AM, Mathias Nyman wrote:
>> On 29.12.2022 23.14, Wesley Cheng wrote:
>>> Hi Mathias,
>>>
>>> On 12/28/2022 7:47 AM, Mathias Nyman wrote:
>>>> On 24.12.2022 1.31, Wesley Cheng wrote:
>>>>> Implement the XHCI operations for allocating and requesting for a secondary
>>>>> interrupter.  The secondary interrupter can allow for events for a
>>>>> particular endpoint to be routed to a separate event ring.  The event
>>>>> routing is defined when submitting a transfer descriptor to the USB HW.
>>>>> There is a specific field which denotes which interrupter ring to route the
>>>>> event to when the transfer is completed.
>>>>>
>>>>> An example use case, such as audio packet offloading can utilize a separate
>>>>> event ring, so that these events can be routed to a different processor
>>>>> within the system.  The processor would be able to independently submit
>>>>> transfers and handle its completions without intervention from the main
>>>>> processor.
>>>>>
>>>>
>>>> Adding support for more xHCI interrupters than just the primary one make sense for
>>>> both the offloading and virtualization cases.
>>>>
>>>> xHCI support for several interrupters was probably added to support virtualization,
>>>> to hand over usb devices to virtual machines and give them their own event ring and
>>>> MSI/MSI-X vector.
>>>>
>>>> In this offloading case you probably want to avoid xHC interrupts from this device
>>>> completely, making sure it doesn't wake up the main CPU unnecessarily.
>>>>
>>>> So is the idea here to let xhci driver set up the new interrupter, its event ring,
>>>> and the endpoint transfer rings. Then pass the address of the endpoint transfer rings
>>>> and the new event ring to the separate processor.
>>>>
>>>> This separate processor then both polls the event ring for new events, sets its dequeue
>>>> pointer, clears EHB bit, and queues new TRBs on the transfer ring.
>>>>
>>>> so xhci driver does not handle any events for the audio part, and no audio data URBs
>>>> are sent to usb core?
>>>
>>> Your entire description is correct.  To clarify, the interfaces which are non-audio will still be handled by the main processor.  For example, a USB headset can have a HID interface as well for volume control.  The HID interface will still be handled by the main processor, and events routed to the main event ring.
>>>
>>>>
>>>> How about the control part?
>>>> Is the control endpoint for this device still handled normally by usb core/xhci?
>>>>
>>>
>>> Control transfers are always handled on the main processor.  Only audio interface's endpoints.
>>
>> Good to know, that means interrupter should be chosen per endpoint, not per device.
>>
>>>
>>>> For the xhci parts I think we should start start by adding generic support for several
>>>> interrupters, then add parts needed for offloading.
>>>
>> I can split up the patchsets to add interrupters first, then adding the offloading APIs in a separate patch.
>>
>>
>> I started looking at supporting secondary interrupters myself.
>> Let me work on that part a bit first. We have a bit different end goals.
>> I want to handle interrupts from a secondary interrupter, while this audio offload
>> really just wants to mask some interrupts.
>>
> 
> I was looking at how we could possibly split up the XHCI secondary interrupter, and offloading parts.  Since the XHCI secondary interrupter is a feature that is defined in the XHCI spec (and we aren't doing anything outside of what is defined), I was thinking of having a separate XHCI driver (ie xhci-sec.c/h) that can be used to define all APIs related to setting up the event ring and ring management. (interrupt support can be added here)  This aligns a bit with what Alan suggested, and removing the APIs in the USB HCD, since this is XHCI specific stuff. ( https://lore.kernel.org/linux-usb/Y6zwZOquZOTZfnvP@rowland.harvard.edu/ )

Already started working on the interrupter, that part fits well into current driver.

Code (untested, will be randomly rebased etc) can be found in my feature_interrupters branch:
git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git feature_interrupters
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters

First step turns current event ring into a primary interrupter.
last patch is a test implementation for creating and freeing new secondary interrupters.

> 
> For the offloading part, I think this is a bit more dependent on how different platforms implement it.  To use more of a generic approach like how Albert suggested here:
> 
> https://patchwork.kernel.org/project/linux-usb/list/?series=704174
> 
> Basically to give vendors the ability to define their own sequences/callbacks, and from which the XHCI driver will call into. (if needed)  These would need to be a separate set of XHCI drivers as well.
> 
> Do you think this is a proper model for us to go with, so that we can allow for vendors to easily add functionality?  Appreciate the inputs.

I'm not convinced that overriding different xhci memory allocation functions is the best solution.
I think xhci driver will need to know which endpoints are offloaded.
maybe usb class driver could register an "offloader" with xhci for a usb device.

Trying to figure out what this xhci offload API would look like.
The dsp needs at least dma address of an event ring, and offloaded endpoint rings.
Is there anything else that the dsp would directly need to take care of, or can
we just export some xhci functions for starting/stopping endpoints, and update event deq?

Thanks
-Mathias

