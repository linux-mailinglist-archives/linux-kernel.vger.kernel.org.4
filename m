Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5676615795
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKBCa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiKBCay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:30:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BFD25E0;
        Tue,  1 Nov 2022 19:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40503B8206F;
        Wed,  2 Nov 2022 02:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29470C433C1;
        Wed,  2 Nov 2022 02:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667356250;
        bh=6hA+Dh9bbUrJYJncIJIqV/ZMA60zmxPIRFCVCtsAvK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTO165lz2zqPi7/J3x9wmFPdj/1UYsm8h65p1V8+M7wg9Zd7Le6c6sdtpmm+zb/3c
         GdksJNcRWI9SoVNFsKt0EZOGXZcPSPDHqVxyKxwecbjN6Fpp6y5S9EaZ6FLI6UsBYb
         D5iohCAAM3TaNIHKU5mjJwHTZsdS7IjTguIz3dY4=
Date:   Wed, 2 Nov 2022 03:31:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     gehao <gehao@kylinos.cn>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangwenmei168@163.com,
        xieming@kylinos.cn
Subject: Re: [RESEND PATCH] xhci: Remove iommu condition for Renesas PCIe
 controllers
Message-ID: <Y2HWkAnvNCRavAZt@kroah.com>
References: <20221102014340.129587-1-gehao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102014340.129587-1-gehao@kylinos.cn>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:43:40AM +0800, gehao wrote:
> When we use uPD720201 USB 3.0 Host Controller passthrough to VM
> guest os will report follow errors and it can not working.
> 
> xhci_hcd 0000:09:00.0: Host took too long to start, waited 16000
> microseconds.

No need to wrap this line.

> xhci_hcd 0000:09:00.0: startup error -19.
> 
> Renesas controllers preserve the top half of the address in internal,
> non visible registers,and end up with half the address coming from the
> kernel, and the other half coming from the firmware.
> 
> For guest os,although our dev->iommu_group = NULL,but we are still under
> iommu control.
> 
> This condition is not necessary,because for os with noiommu,doing
> anything when there is no iommu is definitely,and when our os with
> iommu,it is safe.
> 
> Signed-off-by: gehao <gehao@kylinos.cn>

I need a "full" name please, what you use to sign documents.

Also, your email fails to validate, so it looks like it was faked.
Please fix your email system to properly send validated emails.

> ---
>  drivers/usb/host/xhci.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 79d7931c048a..589d54ecd2a4 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -227,7 +227,6 @@ int xhci_reset(struct xhci_hcd *xhci, u64 timeout_us)
>  
>  static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
>  {
> -	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
>  	int err, i;
>  	u64 val;
>  	u32 intrs;
> @@ -241,12 +240,8 @@ static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
>  	 * changing the programming leads to extra accesses even if the
>  	 * controller is supposed to be halted. The controller ends up with
>  	 * a fatal fault, and is then ripe for being properly reset.
> -	 *
> -	 * Special care is taken to only apply this if the device is behind
> -	 * an iommu. Doing anything when there is no iommu is definitely
> -	 * unsafe...
>  	 */
> -	if (!(xhci->quirks & XHCI_ZERO_64B_REGS) || !device_iommu_mapped(dev))
> +	if (!(xhci->quirks & XHCI_ZERO_64B_REGS))

I thought this got rejected as it will break systems.  What changed from
that?

thanks,

greg k-h
