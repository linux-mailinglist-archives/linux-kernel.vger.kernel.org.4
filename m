Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EE170F5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjEXLwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjEXLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:52:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB58D9D;
        Wed, 24 May 2023 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684929134; x=1716465134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iaaZ5qDY8muwIMDjegGgpI3MOfMGeNUOA3jUMSF2XYk=;
  b=POu7T7tz9LHzOWA/87Jk2nREBaDfwQRru/ZR7CB+eNJJ03ajbYmyK9Ui
   U2v+r5z0/Tyv7qkm945tZGiJ3EveQxnrhwJ39YHAePbk9/SVjXQTYW357
   NHal8FoiCpSz4Rj8sqRLmii381gixLw3l/S/teH/WasoyO15SPiWCcf/o
   +7I8rwItI8lfKZr4xIG3gZyvMN8lA7hMWFVzipp8yZjxIeAwM7taKU6T7
   DJAaf265jI/A8v/32DGOMPY8++2n5Y8yAwhiSzPGcwCqdZr+EfBFAQYpU
   UZk7JX0Su7r4ou7Qq6LfPMT9b/VGt8pfWFArgJBLFIstt1gUOk9ixSZvy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="419252193"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="419252193"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 04:52:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="704316051"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="704316051"
Received: from jiaqingz-mobl.ccr.corp.intel.com (HELO [10.249.175.64]) ([10.249.175.64])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 04:52:13 -0700
Message-ID: <aee8ff85-5716-424e-3773-33700fd90dc2@linux.intel.com>
Date:   Wed, 24 May 2023 19:52:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] serial: 8250_pci: remove unreachable code for ASIX
 devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230510142855.256658-1-jiaqing.zhao@linux.intel.com>
 <2023051343-cringing-junction-54f7@gregkh>
 <188db6e4-d1de-6643-f6e1-5cb3807b28ee@linux.intel.com>
 <2023051533-harmonize-ozone-bc72@gregkh>
Content-Language: en-US
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
In-Reply-To: <2023051533-harmonize-ozone-bc72@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-15 11:49, Greg Kroah-Hartman wrote:
> On Mon, May 15, 2023 at 10:36:30AM +0800, Jiaqing Zhao wrote:
>>
>>
>> On 2023-05-13 18:28, Greg Kroah-Hartman wrote:
>>> On Wed, May 10, 2023 at 02:28:56PM +0000, Jiaqing Zhao wrote:
>>>> PCI_VENDOR_ID_ASIX (0x9710) is the same as PCI_VENDOR_ID_NETMOS. In
>>>> pci_serial_quirks array, the NetMos entry always takes precedence over
>>>> the ASIX entry. So the code for ASIX devices is always unreachable,
>>>> even when it was initially merged. Since the NetMos vendor driver
>>>> doesn't mention such FIFO bug, it's safe to remove the code.
>>>>
>>>> This reverts commit eb26dfe8aa7e ("8250: add support for ASIX devices
>>>> with a FIFO bug").
>>>>
>>>> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
>>>
>>> Please follow the documented Intel kernel developer requirements before
>>> you submit this again, based on the changes that process will require.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Sorry I am unable to find this "Intel kernel developer requirements". Is
>> there any link or contact where I can find this information? Thank you.
> 
> Contact the Intel Linux developer team and they will point you at them.
> This is a company-wide requirement, it is odd that your normal "Here is
> how you can contribute to Linux!" training at Intel did not cover it?
> 
> thanks,
> 
> greg k-h

I contacted them and there is no reply so far. Could you please tell me if
there is any general available docs about this or point out what I'm doing
wrong in this patch? Thank you very much.
