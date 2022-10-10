Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738B95F9FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJJNzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJJNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:55:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CD61705D;
        Mon, 10 Oct 2022 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665410139; x=1696946139;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=63AqhZ1NN7VkSoHrngZpGWaoS9MDx7lPInsGe5LmJzg=;
  b=iQiVJtUI/HK0HyaqtnyzqGKb75+85SW2WZ0EgU+1tcKbF9yDe+CiORBQ
   m60DqF9fzRNSxw1KcbW0N1eXTIdbh8amyVHt5LrI4BijFtA6WPBAmc9Mq
   93wnCAAfX/M+m5OqjK4p1Pt8yA3WcRK/M4n0zm18JNfMeAD7D9HSTN9Gm
   s5SgSnoTM7too7Np7x0/qXWABylMmz7vNvDoGCyHJMmNao0o+Zy9LtJ2w
   Q5wW7MQEQRVeFDMROpSWLzT6ZBnngrj0MBaTThGYzIxrVvWTWSCM6pDSW
   5UPW1zfQXxj8zGda/VNwte4mGxVVbAK8H2ln3k+pfVxMjs7j0aMlvHpxV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="366194028"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="366194028"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 06:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="871107137"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="871107137"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga006.fm.intel.com with ESMTP; 10 Oct 2022 06:55:36 -0700
Message-ID: <a4849cea-c49f-06a1-4dc2-d619f106bbc9@intel.com>
Date:   Mon, 10 Oct 2022 16:57:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] xhci-pci: Set runtime PM as default policy on all
 xHC 1.2 or later devices
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221006211529.1858-1-mario.limonciello@amd.com>
 <20221006211529.1858-2-mario.limonciello@amd.com>
 <Yz/3eeVjx8v6/MJe@black.fi.intel.com>
 <MN0PR12MB61013B3B55D21A49C2450B1AE25F9@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
In-Reply-To: <MN0PR12MB61013B3B55D21A49C2450B1AE25F9@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.10.2022 19.42, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Sent: Friday, October 7, 2022 04:55
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: Mathias Nyman <mathias.nyman@intel.com>; Mehta, Sanju
>> <Sanju.Mehta@amd.com>; Mathias Nyman
>> <mathias.nyman@linux.intel.com>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH v2 1/2] xhci-pci: Set runtime PM as default policy on all
>> xHC 1.2 or later devices
>>
>> On Thu, Oct 06, 2022 at 04:15:28PM -0500, Mario Limonciello wrote:
>>> -	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
>>> -	    (pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1 ||
>>> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2 ||
>>> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3 ||
>>> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4 ||
>>> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5 ||
>>> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6 ||
>>> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_7 ||
>>> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_8))
>>
>> Can you add a comment here explaining why this is OK? I think it is
>> easier that way to find out why this is here in the future instead of
>> going through the git blame history.
> 
> Sure, no problem.
> 
> I'll hold off sending a v3 though until you and Mathias can double check
> everything in patch 2/2 is OK to take out and agree with that secondary logic
> change.
> 
>>
>>> +	if (xhci->hci_version >= 0x102)

Shouldn't this be ">= 0x120"

Thanks
Mathias
