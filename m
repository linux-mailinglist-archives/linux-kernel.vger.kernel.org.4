Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5768C635B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbiKWLKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiKWLIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:08:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D62D226;
        Wed, 23 Nov 2022 03:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669201714; x=1700737714;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=nEqvAW5e5WrGa/oW+eUTBhZKa268bM9z28Wl13BAzN8=;
  b=WwFZ6zV8Het8yLzqrVEiyXemznlKs/UJ8Y1gFUsZBMJhNhLlppO3L/pI
   1j3IoHRhzh2ZH+Eu9MUCG5w5GPdDLSrHUvhP9UdojETOFzi7efYR4KrQJ
   nF/q2FNeEvEKOYQTpp0k4DTzP7/F3uOuvVmP37d1iIzIXgqEEmhLqkVeE
   fQQjWv35LCgZnQTTszqKk/Vb/WdaSFsJh4lVNmQW857Z0G82qUHgdZrjv
   bRpQ4qO4gRuC9e85IdxgaTJiIzZamfzR7FBcI0oPoPkpA/cnzLOgCf3f5
   qOE2z5CBGLD8ewgHZk6TmX4w0cLGFTxZhvlJz5A3vYMBW6gldvwV7HV9Q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="340920168"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="340920168"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 03:08:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="766683403"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="766683403"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2022 03:08:30 -0800
Message-ID: <a384d15d-c1df-160c-030b-fddd5d965996@linux.intel.com>
Date:   Wed, 23 Nov 2022 13:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20221118110116.20165-1-chunfeng.yun@mediatek.com>
Content-Language: en-US
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: host: xhci-mtk: omit shared hcd if either root hub
 has no ports
In-Reply-To: <20221118110116.20165-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.2022 13.01, Chunfeng Yun wrote:
> There is error log when add a usb3 root hub without ports:
> "hub 4-0:1.0: config failed, hub doesn't have any ports! (err -19)"
> 
> so omit the shared hcd if either of the root hubs has no ports, but
> usually there is no usb3 port.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   drivers/usb/host/xhci-mtk.c | 72 +++++++++++++++++++++++--------------
>   1 file changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index 01705e559c42..cff3c4aea036 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -485,6 +485,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>   	const struct hc_driver *driver;
>   	struct xhci_hcd *xhci;
>   	struct resource *res;
> +	struct usb_hcd *usb3_hcd;
>   	struct usb_hcd *hcd;
>   	int ret = -ENODEV;
>   	int wakeup_irq;
> @@ -593,6 +594,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>   
>   	xhci = hcd_to_xhci(hcd);
>   	xhci->main_hcd = hcd;
> +	xhci->allow_single_roothub = 1;
>   
>   	/*
>   	 * imod_interval is the interrupt moderation value in nanoseconds.
> @@ -602,24 +604,29 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>   	xhci->imod_interval = 5000;
>   	device_property_read_u32(dev, "imod-interval-ns", &xhci->imod_interval);
>   
> -	xhci->shared_hcd = usb_create_shared_hcd(driver, dev,
> -			dev_name(dev), hcd);
> -	if (!xhci->shared_hcd) {
> -		ret = -ENOMEM;
> -		goto disable_device_wakeup;
> -	}
> -
>   	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
>   	if (ret)
> -		goto put_usb3_hcd;
> +		goto disable_device_wakeup;
>   
> -	if (HCC_MAX_PSA(xhci->hcc_params) >= 4 &&
> +	if (!xhci_has_one_roothub(xhci)) {
> +		xhci->shared_hcd = usb_create_shared_hcd(driver, dev,
> +							 dev_name(dev), hcd);
> +		if (!xhci->shared_hcd) {
> +			ret = -ENOMEM;
> +			goto dealloc_usb2_hcd;
> +		}
> +	}
> +
> +	usb3_hcd = xhci_get_usb3_hcd(xhci);
> +	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4 &&
>   	    !(xhci->quirks & XHCI_BROKEN_STREAMS))
> -		xhci->shared_hcd->can_do_streams = 1;
> +		usb3_hcd->can_do_streams = 1;
>   
> -	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> -	if (ret)
> -		goto dealloc_usb2_hcd;
> +	if (xhci->shared_hcd) {
> +		ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> +		if (ret)
> +			goto put_usb3_hcd;
> +	}
>   
>   	if (wakeup_irq > 0) {
>   		ret = dev_pm_set_dedicated_wake_irq_reverse(dev, wakeup_irq);
	
dev_pm_set_dedicated_wake_irq_reverse() can be called with just one hcd, if it fails
it will goto dealloc_usb3_hcd:

dealloc_usb3_hcd:
	usb_remove_hcd(xhci->shared_hcd);   // xhci->shared_hcd may be null
	xhci->shared_hcd = NULL; // causes usb_put_hcd() issues if shared_hcd exists

put_usb3_hcd:
         usb_put_hcd(xhci->shared_hcd); // shared_hcd may be set NULL above

-Mathias
  
