Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3359C5F6326
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiJFI5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiJFI5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:57:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BED97D4D;
        Thu,  6 Oct 2022 01:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665046626; x=1696582626;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=3/L+DOXlfRPicy2A9x/l+Scfuy0KkCrxy0UanPSXEM0=;
  b=UqisyU2dqumXZi/wuqcZ4x8wWkJFxbx9pGdCb4AwjIGwmd/r+oBhnLVy
   ig2V71Ktlp0teCj2yUuAopBq9tRG1GNxoZS2LowHiFENlmB1y/Z+CzlHq
   W3NDOA5J8krCRJbtL0x3RI2/JQIWw6INvAxe1vlezUfEMz3ryZGLEQ9wP
   B8+0IGlOetHNuKXDynFrqr5kIDa2SRytJhI2FULme/UAHQjkqiodGhllm
   HpvgQQBZEwLx5Sz8YUoL5rPoHAkVwpe6X59y0QM4H1mR2zzJOs9/nbG/+
   NevaGhYRzTOnR6rpAqzGhCsu9iGmEYw7Kt4N3cvgkeadUHo5R2s5iDxka
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="302107467"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="302107467"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 01:57:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="750081967"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="750081967"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 06 Oct 2022 01:57:03 -0700
Message-ID: <e98151a1-eb1d-df41-ba78-1c810aadd540@linux.intel.com>
Date:   Thu, 6 Oct 2022 11:58:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        mathias.nyman@intel.com, mika.westerberg@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     Sanju.Mehta@amd.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
References: <20221005202353.1269-1-mario.limonciello@amd.com>
 <20221005202353.1269-2-mario.limonciello@amd.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 1/4] USB: ACPI: Look for `usb4-host-interface` property
In-Reply-To: <20221005202353.1269-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 5.10.2022 23.23, Mario Limonciello wrote:
> For optimal power consumption of USB4 routers the XHCI PCIe endpoint
> used for tunneling must be in D3.  Historically this is accomplished
> by a long list of PCIe IDs that correspond to these endpoints.
> 
> The linux thunderbolt CM currently uses the `usb4-host-interface` ACPI
> property to create a device link between the USB4 host router PCIe
> endpoint and the XHCI PCIe endpoint.  The device link will move
> the devices in out of D3 together.
> 
> To avoid having to maintain this never ending list of PCIe IDs, use
> the existence of `usb4-host-interface` property on a USB port as a
> proxy to allow runtime PM for these controllers.  The device links
> will continue to be created when the CM initializes the USB4
> host router and also discovers this property.
> 

Agree that maintaining this list isn't a long term solution.

> Link: https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/usb4-acpi-requirements#port-mapping-_dsd-for-usb-3x-and-pcie
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> RFC v1->PATCH v1
>   * Move this detection from Thunderbolt CM into USB core
> ---
>   drivers/usb/core/usb-acpi.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
> index 6d93428432f13..f91ab4fd84cf8 100644
> --- a/drivers/usb/core/usb-acpi.c
> +++ b/drivers/usb/core/usb-acpi.c
> @@ -177,6 +177,15 @@ usb_acpi_find_companion_for_port(struct usb_port *port_dev)
>   		port_dev->connect_type = usb_acpi_get_connect_type(handle, pld);
>   		ACPI_FREE(pld);
>   	}
> +	if (!acpi_dev_get_property(adev, "usb4-host-interface",
> +				   ACPI_TYPE_ANY, NULL)) {
> +		struct device *dev = &port_dev->dev;
> +
> +		while (dev && !dev_is_pci(dev))
> +			dev = dev->parent;
> +		if (dev)
> +			pm_runtime_allow(dev);

This would enable runtime pm for usb hosts during usb_acpi_bus acpi companion finding.
I think host drivers should be the ones making this decision.

Maybe it's time to enable runtime pm as default for most new xHC controllers.
How about we enable it for all AMD and Intel PCI xHC hosts with version 1.2 or later?

If it causes un-fixable regression to some controller we can add it to a denylist.

Thanks
-Mathias
