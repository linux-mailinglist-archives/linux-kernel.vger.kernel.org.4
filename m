Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78052657DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiL1PqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiL1PqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:46:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8947614D27;
        Wed, 28 Dec 2022 07:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672242373; x=1703778373;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=SB1x38s3dv6Gdzi7eiwaN7LwRGEtLuEFsZIEzhZwdls=;
  b=UBGqbU5V0c0n6bGCc03FYH4wSOXmVytfP7hOBWhgEvMoeakXOeHgXye/
   1UVzWNvVQX4SjM/i7kVfGDDo60mc2NIN3/yb2y2U93Wd2flct+JbcPz7y
   In508AxydbVsy1R5WG7xulsQo0GythLWrg3omyiPmbcInouCAZRe8UFgg
   SOCj2FMdzP6medUMzDI/MQxthO9LM25JBt/4opvIYB0ciIzXA73Q5y+3A
   ABkj6j3WY/FLy58jn6m8NzzqulbNu63Us+AsOGEcyyRA0kKr5zbngx3QJ
   ZVEm2ebkJyzuz40afva9gx7DJZgtQr/CLVKXPGPpu4xcgchJKsi83MypU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="304388687"
X-IronPort-AV: E=Sophos;i="5.96,281,1665471600"; 
   d="scan'208";a="304388687"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 07:46:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="982118992"
X-IronPort-AV: E=Sophos;i="5.96,281,1665471600"; 
   d="scan'208";a="982118992"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 28 Dec 2022 07:46:07 -0800
Message-ID: <7dfe215b-4cc7-f95f-17c3-563c0120151a@linux.intel.com>
Date:   Wed, 28 Dec 2022 17:47:24 +0200
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
Content-Language: en-US
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC PATCH 07/14] usb: host: xhci: Add XHCI secondary interrupter
 support
In-Reply-To: <20221223233200.26089-8-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.12.2022 1.31, Wesley Cheng wrote:
> Implement the XHCI operations for allocating and requesting for a secondary
> interrupter.  The secondary interrupter can allow for events for a
> particular endpoint to be routed to a separate event ring.  The event
> routing is defined when submitting a transfer descriptor to the USB HW.
> There is a specific field which denotes which interrupter ring to route the
> event to when the transfer is completed.
> 
> An example use case, such as audio packet offloading can utilize a separate
> event ring, so that these events can be routed to a different processor
> within the system.  The processor would be able to independently submit
> transfers and handle its completions without intervention from the main
> processor.
> 

Adding support for more xHCI interrupters than just the primary one make sense for
both the offloading and virtualization cases.

xHCI support for several interrupters was probably added to support virtualization,
to hand over usb devices to virtual machines and give them their own event ring and
MSI/MSI-X vector.

In this offloading case you probably want to avoid xHC interrupts from this device
completely, making sure it doesn't wake up the main CPU unnecessarily.

So is the idea here to let xhci driver set up the new interrupter, its event ring,
and the endpoint transfer rings. Then pass the address of the endpoint transfer rings
and the new event ring to the separate processor.

This separate processor then both polls the event ring for new events, sets its dequeue
pointer, clears EHB bit, and queues new TRBs on the transfer ring.

so xhci driver does not handle any events for the audio part, and no audio data URBs
are sent to usb core?

How about the control part?
Is the control endpoint for this device still handled normally by usb core/xhci?

For the xhci parts I think we should start start by adding generic support for several
interrupters, then add parts needed for offloading.

Thanks
Mathias

