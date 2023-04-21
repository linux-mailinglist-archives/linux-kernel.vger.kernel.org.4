Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED9B6EA537
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjDUHto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjDUHtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:49:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7312D57;
        Fri, 21 Apr 2023 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682063381; x=1713599381;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vyjw8gaJvfXStzUI8gtf7qcqGZwPkXifYf2vhi91CVI=;
  b=ATFKrbkzbdVdLCu+OKC+QUtx6dxXa9ytUmg0fGgIEqkgyE7Orlbx+I/3
   1pukV2NpMZxSfUDIFX0HSBL9WQr1KEzvx55lOFKRBsQ720JTxHT3f9U3N
   AkhtYP4y1Vrw940swRPMoqrO9t/heW6ApR6jFC8IUuLe5lCX/zMGopaMP
   Wcp5bg80g2NX7VFt4dHfvVHRoVoR6hj+TxiOb4OwwPx7GOR9PS7GdV0Fk
   kfyzvk7uT4fzd98SKKEgdBtoaRZhzfmMVxllF/fzzKqk/8D7H7E0yaWTp
   nWYXdaCXo8T8vYQi28vl+/G9uG75DuVUi1hw+Eju2CZzLyIjVp4WjZpbw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="344693371"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="344693371"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 00:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="685652489"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="685652489"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga007.jf.intel.com with ESMTP; 21 Apr 2023 00:49:38 -0700
Message-ID: <a2bea61f-05c2-77bf-73d7-04e35e5023af@linux.intel.com>
Date:   Fri, 21 Apr 2023 10:51:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] xhci: Add zhaoxin xHCI U1/U2 feature support
Content-Language: en-US
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
References: <20230420172130.375819-1-WeitaoWang-oc@zhaoxin.com>
 <20230420172130.375819-3-WeitaoWang-oc@zhaoxin.com>
 <92cf6ed0-be37-d8a6-14c7-c5043f076916@intel.com>
 <a270bd46-fb39-50a7-c2a7-da98b06458ff@zhaoxin.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <a270bd46-fb39-50a7-c2a7-da98b06458ff@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.4.2023 13.56, WeitaoWang-oc@zhaoxin.com wrote:
> On 2023/4/20 22:07, Mathias Nyman wrote:
>> On 20.4.2023 20.21, Weitao Wang wrote:
>>> Add U1/U2 feature support of xHCI for zhaoxin.
>>>
>>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>>> ---
>>>   drivers/usb/host/xhci-pci.c |  5 +++++
>>>   drivers/usb/host/xhci.c     | 27 +++++++++++++++++++++++++--
>>>   2 files changed, 30 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>>> index 6db07ca419c3..a235effe8e5c 100644
>>> --- a/drivers/usb/host/xhci-pci.c
>>> +++ b/drivers/usb/host/xhci-pci.c
>>> @@ -334,6 +334,11 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>>>            pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
>>>           xhci->quirks |= XHCI_NO_SOFT_RETRY;
>>> +    if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
>>> +        xhci->quirks |= XHCI_LPM_SUPPORT;
>>> +        xhci->quirks |= XHCI_ZHAOXIN_HOST;
>>> +    }
>>> +
>>>       /* xHC spec requires PCI devices to support D3hot and D3cold */
>>>       if (xhci->hci_version >= 0x120)
>>>           xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>>> index 6307bae9cddf..730c0f68518d 100644
>>> --- a/drivers/usb/host/xhci.c
>>> +++ b/drivers/usb/host/xhci.c
>>> @@ -4802,7 +4802,7 @@ static u16 xhci_calculate_u1_timeout(struct xhci_hcd *xhci,
>>>           }
>>>       }
>>> -    if (xhci->quirks & XHCI_INTEL_HOST)
>>> +    if (xhci->quirks & (XHCI_INTEL_HOST | XHCI_ZHAOXIN_HOST))
>>>           timeout_ns = xhci_calculate_intel_u1_timeout(udev, desc);
>>
>> Looks odd to tie Zhaoxin vendor to Intel specific values but ok,
>> if they diverge in the future we anyway need to modify this.
> 
> These Intel specific values look good for zhaoxin xHCI with test.
> Reused this piece of code for simplicity. If there are any difference
> for these value, update will be submitted in the future.
> 
>>>       else
>>>           timeout_ns = udev->u1_params.sel;
>>> @@ -4866,7 +4866,7 @@ static u16 xhci_calculate_u2_timeout(struct xhci_hcd *xhci,
>>>           }
>>>       }
>>> -    if (xhci->quirks & XHCI_INTEL_HOST)
>>> +    if (xhci->quirks & (XHCI_INTEL_HOST | XHCI_ZHAOXIN_HOST))
>>>           timeout_ns = xhci_calculate_intel_u2_timeout(udev, desc);
>>
>> same.
>>
>>>       else
>>>           timeout_ns = udev->u2_params.sel;
>>> @@ -4938,6 +4938,27 @@ static int xhci_update_timeout_for_interface(struct xhci_hcd *xhci,
>>>       return 0;
>>>   }
>>> +static int xhci_check_zhaoxin_tier_policy(struct usb_device *udev,
>>> +        enum usb3_link_state state)
>>> +{
>>> +    struct usb_device *parent;
>>> +    unsigned int num_hubs;
>>> +
>>> +    /* Don't enable U1/U2 if the device is on an external hub. */
>>> +    for (parent = udev->parent, num_hubs = 0; parent->parent;
>>> +            parent = parent->parent)
>>> +        num_hubs++;
>>> +
>>> +    if (num_hubs < 1)
>>> +        return 0;
>>> +
>>> +    dev_dbg(&udev->dev, "Disabling U1/U2 link state for device"
>>> +            " below external hub.\n");
>>> +    dev_dbg(&udev->dev, "Plug device into root hub "
>>> +            "to decrease power consumption.\n");
>>> +    return -E2BIG;
>>> +}
>>> +
>>
>> I don't think we should add more vendor specific functions, this is almost
>> an exact copy of xhci_check_intel_tier_policy().
> 
> Adding duplicate vendor related code is indeed a bit redundant.
> 
>> How about getting rid of both of those and use something like this instead (untested):
>>
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index 2b280beb0011..e9a25e4d99cf 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -4926,10 +4926,24 @@ static int xhci_check_tier_policy(struct xhci_hcd *xhci,
>>                  struct usb_device *udev,
>>                  enum usb3_link_state state)
>>   {
>> -       if (xhci->quirks & XHCI_INTEL_HOST)
>> -               return xhci_check_intel_tier_policy(udev, state);
>> -       else
>> -               return 0;
>> +       struct usb_device *parent = udev->parent;
>> +       int tier = 1; /* roothub is tier1 */
>> +
>> +       while (parent) {
>> +               parent = parent->parent;
>> +               tier++;
>> +       }
>> +
>> +       if (xhci->quirks & XHCI_INTEL_HOST && tier > 3)
>> +               goto fail;
>> +       if (xhci->quirks & XHCI_ZHAOXIN_HOST && tier > 2)
>> +               goto fail;
>> +
>> +       return 0;
>> +fail:
>> +       dev_dbg(&udev->dev, "Tier policy prevents U1/U2 LPM states for devices at tier %d\n",
>> +               tier);
>> +       return -E2BIG;
>>   }
> 
> These code looks very elegant. Could I resubmit patch using your code
> after testing pass on Intel and Zhaoxin platform.
> 

Yes, you can add Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Thanks
Mathias
