Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA35FC20C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJLIdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJLIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:33:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BBFB56DA;
        Wed, 12 Oct 2022 01:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665563556; x=1697099556;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=DuXD8ucJt2DdGp6CHFp73VpIU4Jxz4O81xCzRVaMxF4=;
  b=Ni/0f077sS8TnmJITNOzW0VTPJQBvOUpoIxoIgI+qDfj9R53azu/yw2f
   bxWw7k1x3Ut/oxAox23B0nwsD+UhFTnjspc/ObQ/h3Igo1x19E1Wiq2vu
   HqpyDzsHA97bt32ZwukfXc6tA6NV9XNEAIMCNR7NjgI956G4K+/3ynPe9
   FfaI0zpSUf3oQZ7so2ZpqgR3BF8BtS0B3UhdKMMA2ldOe+ul/KyWwzSE2
   JzisXGLBwn/zg/SrP9YpENUuPC/XCrwemIoOfKwI4W1Ki7g3mvZ9fUvSy
   RkCHkjlGK/H553kLANjW79lHAcxZqUSFWf7IVHoh7+qc0KxVhah86MmI5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="288003485"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="288003485"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 01:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="626684693"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="626684693"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga002.jf.intel.com with ESMTP; 12 Oct 2022 01:32:34 -0700
Message-ID: <7df4a91d-6829-5ebf-18ca-c0783c03f443@linux.intel.com>
Date:   Wed, 12 Oct 2022 11:34:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221010160022.647-1-mario.limonciello@amd.com>
 <Y0T68lC6bUY7dg7D@black.fi.intel.com>
 <7c08c4c8-562d-553f-e513-c925080300a7@linux.intel.com>
 <MN0PR12MB6101ECEA1CCED9B65667031DE2239@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v3] xhci-pci: Set runtime PM as default policy on all xHC
 1.2 or later devices
In-Reply-To: <MN0PR12MB6101ECEA1CCED9B65667031DE2239@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2022 19.46, Limonciello, Mario wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Mathias Nyman <mathias.nyman@linux.intel.com>
>> Sent: Tuesday, October 11, 2022 08:16
>> To: Mika Westerberg <mika.westerberg@linux.intel.com>; Limonciello,
>> Mario <Mario.Limonciello@amd.com>
>> Cc: Mathias Nyman <mathias.nyman@intel.com>; Mehta, Sanju
>> <Sanju.Mehta@amd.com>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH v3] xhci-pci: Set runtime PM as default policy on all xHC
>> 1.2 or later devices
>>
>> On 11.10.2022 8.11, Mika Westerberg wrote:
>>> On Mon, Oct 10, 2022 at 11:00:21AM -0500, Mario Limonciello wrote:
>>>> For optimal power consumption of USB4 routers the XHCI PCIe endpoint
>>>> used for tunneling must be in D3.  Historically this is accomplished
>>>> by a long list of PCIe IDs that correspond to these endpoints because
>>>> the xhci_hcd driver will not default to allowing runtime PM for all
>>>> devices.
>>>>
>>>> As both AMD and Intel have released new products with new XHCI
>> controllers
>>>> this list continues to grow. In reviewing the XHCI specification v1.2 on
>>>> page 607 there is already a requirement that the PCI power management
>>>> states D3hot and D3cold must be supported.
>>>>
>>>> In the quirk list, use this to indicate that runtime PM should be allowed
>>>> on XHCI controllers. The following controllers are known to be xHC 1.2 and
>>>> dropped explicitly:
>>>> * AMD Yellow Carp
>>>> * Intel Alder Lake
>>>> * Intel Meteor Lake
>>>> * Intel Raptor Lake
>>>>
>>>> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>> Link:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fww
>> w.intel.com%2Fcontent%2Fdam%2Fwww%2Fpublic%2Fus%2Fen%2Fdocum
>> ents%2Ftechnical-specifications%2Fextensible-host-controler-interface-usb-
>> xhci.pdf&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cb286e9c
>> 63e9e4c3a1a3708daab8a9b23%7C3dd8961fe4884e608e11a82d994e183d%7C0
>> %7C0%7C638010909687542135%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
>> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
>> 7C%7C%7C&amp;sdata=CetIs1VuAqj8nNBoLnXaGncw6Sl4JcImYY67JpVxyjg%
>> 3D&amp;reserved=0
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> Thanks, added to queue
> 
> Thanks!
> For my own clarity - is this something you'll still take to 6.1, or are you meaning
> 6.2 queue at this point?

Was planning on sending it to usb-next after 6.1-rc1 is out, so ending up in 6.2
But if there's some benefit in having this already in 6.1 then I don't object that either.

> 
> This thread originated from enabling Pink Sardine.  Wherever it lands after it's
> baked for $long_enough I would like to bring it back to stable eventually too.
> If you think it's too risky for stable later on, can we do separate set of commits
> that adds and then removes the IDs for pink sardine that can go to stable?  This
> would at least mirror more closely what has been done historically for the other
> USB4 products.

I think we can add this to stable. It's fine for Intel xHCI 1.2 hosts.

Thanks
-Mathias
