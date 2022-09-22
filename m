Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EB75E61E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiIVMA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiIVMAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D63B774C;
        Thu, 22 Sep 2022 05:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF3160A69;
        Thu, 22 Sep 2022 12:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02025C433C1;
        Thu, 22 Sep 2022 12:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663848019;
        bh=5fCXJLvYDQcpKwWgLwdXuoVu9a9+BgW/1T/mDq3Sa74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PuIlBZEwHEEWj8lkLtJIqrP22o5/KGC59oNMa68fAkTpKECRUg2qw547udDvRZBlf
         jqoMa8O+q2gW1WGAzXbshYXGx3jDhbO9Y4j5O+q0LDezrypr1jbbartqljzXvwiN+r
         DvNZajgZrg3i4542Bwv25U9J2laZGuMBTIJai45Y=
Date:   Thu, 22 Sep 2022 14:00:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being
 a V0.96 controller
Message-ID: <YyxOUCE35G8q+6nA@kroah.com>
References: <20220830160035.10333-1-jens.glathe@oldschoolsolutions.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830160035.10333-1-jens.glathe@oldschoolsolutions.biz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 06:00:35PM +0200, Jens Glathe wrote:
> only if it reports as a V0.96 XHCI controller. Appears to fix the errors
> "xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of current TD ep_index 2 comp_code 13"
> that appear spuriously (or pretty often) when using a r8152 USB3 ethernet adapter with integrated hub.
> ---
>  drivers/usb/host/xhci-pci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index dce6c0ec8d34..035229bc6d29 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -306,8 +306,14 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  	}
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
> -		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
> +		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
> +    /* try to tame the ASMedia 1042 controller which is 0.96 
> +    */
> +	  if (xhci->hci_version == 0x96) {
> +      xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
> +    }
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
> +	}
>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
>  		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI) {
>  		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
> -- 
> 2.25.1
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
