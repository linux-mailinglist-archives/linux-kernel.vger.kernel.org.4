Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0BE70DCC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbjEWMlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbjEWMlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:41:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C837132;
        Tue, 23 May 2023 05:41:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC6DC631F6;
        Tue, 23 May 2023 12:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9F2C433EF;
        Tue, 23 May 2023 12:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684845687;
        bh=eUBl+ZnfzYeZ0g6XjgKIvOJMemP5JTgiBEpuJ7440Hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maNowJRK9Qh5A3qhRgIyp9jFenpldl102b9JSGZp9s4oECGdWln5gmVv2loSK3BYI
         vzeWe55TTWaF1qZIBkXzTdDHMma2zio8wmC3imoo7No7DFhwTB2fargizkolFokBsE
         UC6BWztRhrj+DjZiB4NcjrsDJg0F1gWhi9TkE8ZvOcMgU7an/39FhInIBWmd1HoJrM
         f0ynnXgIErxsaRhJJ2IAwwg7HXNaSzcnjUIDNWNsYaeA2iHFBKVe4e02hLpjkkqlnC
         s0RtBGX2VwfwQvXJIc0+OQuXemwNJSB87Hw2SyXhrv22qcahbSNQle0Nf6PD3KhePK
         VaxtWaar6NhUA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q1RKT-0003qL-V1; Tue, 23 May 2023 14:41:30 +0200
Date:   Tue, 23 May 2023 14:41:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Klaus Kudielka <klaus.kudielka@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: xhci: plat: remove error log for failure to get
 usb-phy
Message-ID: <ZGy0eTd708Yyx_z5@hovoldconsulting.com>
References: <20230510075129.28047-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510075129.28047-1-stanley_chang@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 03:51:29PM +0800, Stanley Chang wrote:
> Remove this log to avoid non-error conditions.
> If CONFIG_USB_PHY is disabled, the following error message appears:
> [    0.231609] xhci-hcd f10f0000.usb3: xhci_plat_probe get usb3phy fail (ret=-6)
> [    0.239716] xhci-hcd f10f8000.usb3: xhci_plat_probe get usb3phy fail (ret=-6)
> In this case, devm_usb_get_phy_by_phandle is declared static inline
> and returns -ENXIO.
> 
> It is easy to pinpoint the failure to get the usb-phy using the debug
> log in drivers/usb/phy/phy.c. Therefore, it can be removed.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>

This one fixes the annoying bogus error messages that started showing up
in 6.4-rc on the Lenovo X13s and other machines not using the legacy PHY
drivers:

Fixes: 9134c1fd0503 ("usb: xhci: plat: Add USB 3.0 phy support")
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Greg, I noticed you applied this one for 6.5; any chance we could get
this fixed already in 6.4 which has the offending commit?

> ---
>  drivers/usb/host/xhci-plat.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index b0c8e8efc43b..6a45ee431945 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -294,10 +294,6 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
>  		xhci->shared_hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev,
>  			    "usb-phy", 1);
>  		if (IS_ERR(xhci->shared_hcd->usb_phy)) {
> -			if (PTR_ERR(xhci->shared_hcd->usb_phy) != -ENODEV)
> -				dev_err(sysdev, "%s get usb3phy fail (ret=%d)\n",
> -					     __func__,
> -					    (int)PTR_ERR(xhci->shared_hcd->usb_phy));
>  			xhci->shared_hcd->usb_phy = NULL;
>  		} else {
>  			ret = usb_phy_init(xhci->shared_hcd->usb_phy);

Johan
