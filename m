Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714055F9F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJJNoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJJNoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:44:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338356DADD;
        Mon, 10 Oct 2022 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665409459; x=1696945459;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=BywnrqOJACxc9IvuSLmMQKkKOaV89CWVOUKLR/DYNjE=;
  b=WCUlmREao7ry8yaozT2hPokpElInSI7vmx+zw+mnn6D9khphe5jACv3t
   sBt8F/MezsUiGc6TBBdmHn/kZlUXpK9K79or5zR5Nse7HnZHMJX52IRjU
   +dD46Ei3NqdlSsO9xYhAWZNl8RNsyKWXQIucC3aCzLf01+FP7UaN+LD/o
   Bqtkey7Vo/TNiNcZupN5SQIkIeDc92f27AxVlmFEc3YYEVVKtubQMcKSx
   /5+8sGJuGCbwSO7SMKNpYWX/9osGtPUZgiDlJ1B6qITFXGTZJ+C5ai4HM
   D2YaoHZyO4twiByzjJXzgtdB9C70HcW0SoH032XZa4GiQ1hQrKj1If3Fx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="302965752"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="302965752"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 06:44:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="656934172"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="656934172"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga008.jf.intel.com with ESMTP; 10 Oct 2022 06:44:16 -0700
Message-ID: <5602aab5-17c9-67ba-9353-e3b14a5c2e54@linux.intel.com>
Date:   Mon, 10 Oct 2022 16:45:43 +0300
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
References: <20221006211529.1858-1-mario.limonciello@amd.com>
 <20221006211529.1858-2-mario.limonciello@amd.com>
 <Yz/3eeVjx8v6/MJe@black.fi.intel.com>
 <MN0PR12MB61013B3B55D21A49C2450B1AE25F9@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2 1/2] xhci-pci: Set runtime PM as default policy on all
 xHC 1.2 or later devices
In-Reply-To: <MN0PR12MB61013B3B55D21A49C2450B1AE25F9@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Lets only enable it for xHCI 1.2 and controllers for now.
Avoiding unnecessary regressions.

So on Intel side the ALDER_LAKE*, RAPTOR_LAKE and METEOR_LAKE can be removed.
I'll double check other Intel hosts before submitting it forward

Thanks
-Mathias
