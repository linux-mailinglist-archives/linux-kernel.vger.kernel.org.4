Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC28A65B528
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjABQhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABQhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:37:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911BC138;
        Mon,  2 Jan 2023 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672677464; x=1704213464;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=kN/SHISxRWT2L0F6Vw5HZe3KAE4ojWJmQqCG+JrHEBY=;
  b=bkWqbt/f39Iw7pW+XOg9nMrRmbBXx7XZ62MCajUm5kMOcV56gWMEU3eQ
   Zia2FjVcaHHhFuha+7K80h9s06ArLjp0cCGssNZL0/L4G5Z7xLXtgbn9b
   ACfHB5vfn6u1vp2qBFNEylhfyXhFEtqOotOp/FlXLOLyOzMyyNc17Rtv/
   R5pAUb3ANPglM/HfkcEuUbcUw1oGnfpYQ5PvLsp+97aepUg2v6E3jqJQ4
   qZf7mXBel/mpa/OFTgrVl0/TLsovW/Mi6k9R05x7S6WmKJjgKivry3O0R
   ub749ADbGAUaTu/BHrk8mf3U4I5P5cpPVLE/7p5EnuxdRkvhIrAsl1SNg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="305019794"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="305019794"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 08:37:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="743245438"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="743245438"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jan 2023 08:37:38 -0800
Message-ID: <5f54c5a3-caf0-2920-e90f-68124ed2e06c@linux.intel.com>
Date:   Mon, 2 Jan 2023 18:38:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-8-quic_wcheng@quicinc.com>
 <7dfe215b-4cc7-f95f-17c3-563c0120151a@linux.intel.com>
 <f7f80320-02bb-a573-dd95-b6d58c260624@quicinc.com>
Content-Language: en-US
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC PATCH 07/14] usb: host: xhci: Add XHCI secondary interrupter
 support
In-Reply-To: <f7f80320-02bb-a573-dd95-b6d58c260624@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.12.2022 23.14, Wesley Cheng wrote:
> Hi Mathias,
> 
> On 12/28/2022 7:47 AM, Mathias Nyman wrote:
>> On 24.12.2022 1.31, Wesley Cheng wrote:
>>> Implement the XHCI operations for allocating and requesting for a secondary
>>> interrupter.  The secondary interrupter can allow for events for a
>>> particular endpoint to be routed to a separate event ring.  The event
>>> routing is defined when submitting a transfer descriptor to the USB HW.
>>> There is a specific field which denotes which interrupter ring to route the
>>> event to when the transfer is completed.
>>>
>>> An example use case, such as audio packet offloading can utilize a separate
>>> event ring, so that these events can be routed to a different processor
>>> within the system.  The processor would be able to independently submit
>>> transfers and handle its completions without intervention from the main
>>> processor.
>>>
>>
>> Adding support for more xHCI interrupters than just the primary one make sense for
>> both the offloading and virtualization cases.
>>
>> xHCI support for several interrupters was probably added to support virtualization,
>> to hand over usb devices to virtual machines and give them their own event ring and
>> MSI/MSI-X vector.
>>
>> In this offloading case you probably want to avoid xHC interrupts from this device
>> completely, making sure it doesn't wake up the main CPU unnecessarily.
>>
>> So is the idea here to let xhci driver set up the new interrupter, its event ring,
>> and the endpoint transfer rings. Then pass the address of the endpoint transfer rings
>> and the new event ring to the separate processor.
>>
>> This separate processor then both polls the event ring for new events, sets its dequeue
>> pointer, clears EHB bit, and queues new TRBs on the transfer ring.
>>
>> so xhci driver does not handle any events for the audio part, and no audio data URBs
>> are sent to usb core?
> 
> Your entire description is correct.  To clarify, the interfaces which are non-audio will still be handled by the main processor.  For example, a USB headset can have a HID interface as well for volume control.  The HID interface will still be handled by the main processor, and events routed to the main event ring.
> 
>>
>> How about the control part?
>> Is the control endpoint for this device still handled normally by usb core/xhci?
>>
> 
> Control transfers are always handled on the main processor.  Only audio interface's endpoints.

Good to know, that means interrupter should be chosen per endpoint, not per device.

> 
>> For the xhci parts I think we should start start by adding generic support for several
>> interrupters, then add parts needed for offloading.
> 
> I can split up the patchsets to add interrupters first, then adding the offloading APIs in a separate patch.


I started looking at supporting secondary interrupters myself.
Let me work on that part a bit first. We have a bit different end goals.
I want to handle interrupts from a secondary interrupter, while this audio offload
really just wants to mask some interrupts.

Thanks
Mathias

