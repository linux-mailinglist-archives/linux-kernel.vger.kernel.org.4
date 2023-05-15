Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F947021C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbjEOCgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjEOCge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:36:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA6911B;
        Sun, 14 May 2023 19:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684118193; x=1715654193;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lmvigu2LVD+dyp7F4wMiiB3aqm5KVe5Jfon5GleiNWg=;
  b=T2PebQbJ4IriMenf/0kWckndoCsKS6A5oQgp3t0j7oIHE8feG4FHbiwh
   FN4WY1912P94YbpSM+UMvbptlavajmYJYrUMRg216s4PI39wJj/luELOp
   WeuZfCkhz0qEcEccarTB+9+tc85kiizOIp/uj29vH6AOvYN5CZAimWlkI
   Ryq0JDDAJvmFrrMsBxI/4nUfpz66rPSY+9X2HusZtc9DaZiebit2OfY6q
   o/tDJvh957PFdzoY1I2pVXYzQMMy1P2GFWGZ7CL34cnLlE7j8VK7qiFbf
   TIP4LwXy+GF3IFUAFdl2I/4k4cCOFxJfqlRsyxDdYqPZltrlTVLaBkLRg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="351128680"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="351128680"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 19:36:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="733697378"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="733697378"
Received: from jiaqingz-mobl.ccr.corp.intel.com (HELO [10.254.210.235]) ([10.254.210.235])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 19:36:32 -0700
Message-ID: <188db6e4-d1de-6643-f6e1-5cb3807b28ee@linux.intel.com>
Date:   Mon, 15 May 2023 10:36:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] serial: 8250_pci: remove unreachable code for ASIX
 devices
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230510142855.256658-1-jiaqing.zhao@linux.intel.com>
 <2023051343-cringing-junction-54f7@gregkh>
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
In-Reply-To: <2023051343-cringing-junction-54f7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-13 18:28, Greg Kroah-Hartman wrote:
> On Wed, May 10, 2023 at 02:28:56PM +0000, Jiaqing Zhao wrote:
>> PCI_VENDOR_ID_ASIX (0x9710) is the same as PCI_VENDOR_ID_NETMOS. In
>> pci_serial_quirks array, the NetMos entry always takes precedence over
>> the ASIX entry. So the code for ASIX devices is always unreachable,
>> even when it was initially merged. Since the NetMos vendor driver
>> doesn't mention such FIFO bug, it's safe to remove the code.
>>
>> This reverts commit eb26dfe8aa7e ("8250: add support for ASIX devices
>> with a FIFO bug").
>>
>> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
> 
> Please follow the documented Intel kernel developer requirements before
> you submit this again, based on the changes that process will require.
> 
> thanks,
> 
> greg k-h

Sorry I am unable to find this "Intel kernel developer requirements". Is
there any link or contact where I can find this information? Thank you.
