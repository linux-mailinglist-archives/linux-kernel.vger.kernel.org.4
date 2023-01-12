Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90962666E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbjALJ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbjALJ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:28:54 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF03F019;
        Thu, 12 Jan 2023 01:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673515400; x=1705051400;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=KCmtELpXeP5LskyWbQS213aTgoVkvOKnKp0NJZDzsjE=;
  b=Zcw8rWabGAEtN+04M46VUCzXJJtwsWRiknfjwOrDmqWQU6P981sSSqSo
   7XF8N6YvAFa0xYIiVJ2dwspNq8EOPtre2OgRg+2htCzl+DkzfdYhpo8x2
   6cqPk6/1+X/DE3as5WxsMuigZoFgwEn9Ulg+OKssXbfUFeSDgDRhEHN23
   Voi37RYdJEo36vkpzCvbOznsO1ZtbHu1N4sQO93Zcs78G0haXJoU3xqzr
   p+8CeYvHibhfWuqcLhDQGryoGH9SnGum5sP7P8t1ryNLAgQbz0KSc3nsa
   47QXrXL7RqYqiGedT3oui5g/+vio/wT97Xm2qgUJGkZbbBJzLDbo+9ir8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324889911"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="324889911"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:23:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="690053909"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="690053909"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 12 Jan 2023 01:23:14 -0800
Message-ID: <d9cb0835-9514-c5b6-695d-1027b238078c@linux.intel.com>
Date:   Thu, 12 Jan 2023 11:24:34 +0200
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
        agross@kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Albert Wang <albertccwang@google.com>
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
 <cefcc5c6-6a91-c737-252a-edf596f77473@linux.intel.com>
 <23a2b82e-4f4f-66e2-2c60-3613ffe7912f@quicinc.com>
 <23037fab-1a9e-66c1-8e90-d94b213c8c7d@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC PATCH 07/14] usb: host: xhci: Add XHCI secondary interrupter
 support
In-Reply-To: <23037fab-1a9e-66c1-8e90-d94b213c8c7d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.1.2023 5.11, Wesley Cheng wrote:
> Hi Mathias,
> 
> On 1/10/2023 12:03 PM, Wesley Cheng wrote:
>> Hi Mathias,
>>
>> On 1/10/2023 11:47 AM, Mathias Nyman wrote:
>>> On 9.1.2023 22.24, Wesley Cheng wrote:
>>>> Hi Mathias,
>>>>
>>>> On 1/2/2023 8:38 AM, Mathias Nyman wrote:
>>>>> On 29.12.2022 23.14, Wesley Cheng wrote:
>>>>>> Hi Mathias,
>>>>>>
>>>>>> On 12/28/2022 7:47 AM, Mathias Nyman wrote:
>>>>>>> On 24.12.2022 1.31, Wesley Cheng wrote:
>>>>>>>> Implement the XHCI operations for allocating and requesting for a secondary
>>>>>>>> interrupter.  The secondary interrupter can allow for events for a
>>>>>>>> particular endpoint to be routed to a separate event ring.  The event
>>>>>>>> routing is defined when submitting a transfer descriptor to the USB HW.
>>>>>>>> There is a specific field which denotes which interrupter ring to route the
>>>>>>>> event to when the transfer is completed.
>>>>>>>>
>>>>>>>> An example use case, such as audio packet offloading can utilize a separate
>>>>>>>> event ring, so that these events can be routed to a different processor
>>>>>>>> within the system.  The processor would be able to independently submit
>>>>>>>> transfers and handle its completions without intervention from the main
>>>>>>>> processor.
>>>>>>>>
>>>>>>>
>>>>>>> Adding support for more xHCI interrupters than just the primary one make sense for
>>>>>>> both the offloading and virtualization cases.
>>>>>>>
>>>>>>> xHCI support for several interrupters was probably added to support virtualization,
>>>>>>> to hand over usb devices to virtual machines and give them their own event ring and
>>>>>>> MSI/MSI-X vector.
>>>>>>>
>>>>>>> In this offloading case you probably want to avoid xHC interrupts from this device
>>>>>>> completely, making sure it doesn't wake up the main CPU unnecessarily.
>>>>>>>
>>>>>>> So is the idea here to let xhci driver set up the new interrupter, its event ring,
>>>>>>> and the endpoint transfer rings. Then pass the address of the endpoint transfer rings
>>>>>>> and the new event ring to the separate processor.
>>>>>>>
>>>>>>> This separate processor then both polls the event ring for new events, sets its dequeue
>>>>>>> pointer, clears EHB bit, and queues new TRBs on the transfer ring.
>>>>>>>
>>>>>>> so xhci driver does not handle any events for the audio part, and no audio data URBs
>>>>>>> are sent to usb core?
>>>>>>
>>>>>> Your entire description is correct.  To clarify, the interfaces which are non-audio will still be handled by the main processor. For example, a USB headset can have a HID interface as well for volume control.  The HID interface will still be handled by the main processor, and events routed to the main event ring.
>>>>>>
>>>>>>>
>>>>>>> How about the control part?
>>>>>>> Is the control endpoint for this device still handled normally by usb core/xhci?
>>>>>>>
>>>>>>
>>>>>> Control transfers are always handled on the main processor.  Only audio interface's endpoints.
>>>>>
>>>>> Good to know, that means interrupter should be chosen per endpoint, not per device.
>>>>>
>>>>>>
>>>>>>> For the xhci parts I think we should start start by adding generic support for several
>>>>>>> interrupters, then add parts needed for offloading.
>>>>>>
>>>>> I can split up the patchsets to add interrupters first, then adding the offloading APIs in a separate patch.
>>>>>
>>>>>
>>>>> I started looking at supporting secondary interrupters myself.
>>>>> Let me work on that part a bit first. We have a bit different end goals.
>>>>> I want to handle interrupts from a secondary interrupter, while this audio offload
>>>>> really just wants to mask some interrupts.
>>>>>
>>>>
>>>> I was looking at how we could possibly split up the XHCI secondary interrupter, and offloading parts.  Since the XHCI secondary interrupter is a feature that is defined in the XHCI spec (and we aren't doing anything outside of what is defined), I was thinking of having a separate XHCI driver (ie xhci-sec.c/h) that can be used to define all APIs related to setting up the event ring and ring management. (interrupt support can be added here)  This aligns a bit with what Alan suggested, and removing the APIs in the USB HCD, since this is XHCI specific stuff. ( https://lore.kernel.org/linux-usb/Y6zwZOquZOTZfnvP@rowland.harvard.edu/ )
>>>
>>> Already started working on the interrupter, that part fits well into current driver.
>>>
>>> Code (untested, will be randomly rebased etc) can be found in my feature_interrupters branch:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git feature_interrupters
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters
>>
>> Oh perfect, let me take a look.  Thanks for this!
>>
> 
> I actually tried to see if I could get our audio offloading to work with your current series.  (I understand its still work in progress)  I did have to make some changes to expose the APIs to our class driver, but I wanted to let you know about one of the issues I saw when developing my implementation, because I am seeing the same behavior w/ yours. (and there's a discrepancy w/ what's stated in the XHCI spec :))
> 
> So the reason why my initial submission did the event ring allocation and set up before the run/stop bit was set, is that I found that when writing to the ir_set->erst_base in this scenario (for the secondary interrupter), it lead to a SMMU fault from the DWC3 controller.  One thing I noticed, was that the SMMU fault address was the lower 32 bits of the segment table base address allocated.  The XHCI driver utilizes the xhci_write_64() api which first writes the lower 32 bits then the upper 32 bits.  The XHCI spec states that:
> 
> Table 5-41: Event Ring Segment Table Base Address Register Bit Definitions (ERSTBA)
> 
> "Event Ring Segment Table Base Address Register – RW. Default = ‘0’. This field defines the
> high order bits of the start address of the Event Ring Segment Table.
> Writing this register sets the Event Ring State Machine:EREP Advancement to the Start state.
> Refer to Figure 4-12 for more information.
> **For Secondary Interrupters: This field may be modified at any time.**"
> 
> I'm not sure if this is an issue with the specific controller we're using, so maybe I will wait until you can give this a try on your set up.  However, it doesn't seem to be true that we can write the ERSTBA any time we want to.  My assumption is that once I made the lower 32 bit write, the controller attempted to enable the Event Ring State machine (Figure 4-12), and this led to a SMMU fault, since the upper 64 bits haven't been written.  I also did some bit banging manually as well (using devmem) and any time I write to the secondary ring ERSTBA register it generates a fault. (before any offloading has started)

Tried on an Intel host and it seems to work fine.
I created a few secondary interrupters while xHC was running without issues.
DMA mask is 64 bits.
Only created the interrupters, no events on those new event rings, and didn't actually
check that the values written to ERSTBA were 64 bit.

Does temporarily setting DMA mask to 32 bits while allocating erst help in your case?

Thanks
Mathias

