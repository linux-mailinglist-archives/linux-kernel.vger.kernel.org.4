Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169095EA707
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiIZNXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiIZNWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:22:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FCD1D2D0E;
        Mon, 26 Sep 2022 04:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664192932; x=1695728932;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=b4AUHkHBIJtM3cvf7DpZ9BuRMcZzG3oNVVfyV6opb2s=;
  b=Fy9U71MA/UE1EWELYPzupcTtBWN3WFgHJiZXUtt0f2cZvsO+HrFLPk3P
   AtqHu+KCsI8n2mFQKAU+gjPXQoEYRCjoYUDy1BbuH6JsiV/DK2NBxfbf3
   MJ4593HpHZiodTx5xgwrtXGhivRTc/LBsgTj2GZlpnLZEmO+LW1GxkWgC
   XG8kgdng6ldQIEJ5DIcVS8ZS2asnqsYZEDCfAqRIQhKjv3CB9+E3Vtm8n
   RD+IkJp+9slTOYMiH0WitUpZ1o4Rd6koHHIrTZsa+8DAXSJisAgRSzbxF
   xjN2Nj6uUwP0f2eo6blvab44uYSgVidMb9UWE4w3MT/mn9X0A9RKMaOxN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="280728890"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="280728890"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 04:30:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="616367645"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="616367645"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga007.jf.intel.com with ESMTP; 26 Sep 2022 04:30:18 -0700
Message-ID: <c1857a88-2303-43d7-5539-37afd2401a12@linux.intel.com>
Date:   Mon, 26 Sep 2022 14:31:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Content-Language: en-US
To:     Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        mathias.nyman@intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220925172236.2288-1-jens.glathe@oldschoolsolutions.biz>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a
 V0.96 controller
In-Reply-To: <20220925172236.2288-1-jens.glathe@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Thanks for the patch, some small changes still needed:

Include subsystem in subject line, something like
usb: xhci: Add XHCI_SPURIOUS...

On 25.9.2022 20.22, Jens Glathe wrote:
> only if it reports as a V0.96 XHCI controller. Appears to fix the errors
> "xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of
> current TD ep_index 2 comp_code 13" that appear spuriously (or pretty
> often) when using a r8152 USB3 ethernet adapter with integrated hub.
> 
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>   drivers/usb/host/xhci-pci.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index dce6c0ec8d34..d1b8e7148dd1 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -306,8 +306,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>   	}
>   
>   	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
> -		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
> +		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
> +		/* try to tame the ASMedia 1042 controller which is 0.96 */
> +		if (xhci->hci_version == 0x96)

Do we need this 0x96 check? It's anyway set for 1.0 and newer controllers

> +			xhci->quirks |= XHCI_SPURIOUS_SUCCESS;

This reminds me that I should get rid of this quirk.

If we get a short transfers event for a TRB mid TD, then xhci hosts version 1.0 and later
should send a second event for the last TRB in the TD

so this is default behavior for modern xHCI, not a spurious event.

But your patch is anyways needed for stable kernels.

Thanks
-Mathias
