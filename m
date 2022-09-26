Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD55E9C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiIZIhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiIZIh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:37:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD1026100;
        Mon, 26 Sep 2022 01:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6595660D30;
        Mon, 26 Sep 2022 08:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742F4C433D6;
        Mon, 26 Sep 2022 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664181447;
        bh=zI8qHNaOY18LLbwfeFXaMcCgWpukAh0Af3TxvFFO574=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ub0qJLCe+iK1EBq9rcrKAP8gCoxRc6b9gcOJRvOAHfxVzwCqJPzgk2cuNlxhC5wv2
         hXAQvV95edfqIWjtF0pn8K/Ffj1Qk3iQ9oUDSgEU2gZTleLphyP0Nz5Mg5mKrspLm5
         XITnVC1V0/aGyfCPx4tMkP8jdgcw0MUauhxUVdvY=
Date:   Mon, 26 Sep 2022 10:37:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being
 a V0.96 controller
Message-ID: <YzFkxTrymw0Jiuyd@kroah.com>
References: <20220925172236.2288-1-jens.glathe@oldschoolsolutions.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925172236.2288-1-jens.glathe@oldschoolsolutions.biz>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 07:22:37PM +0200, Jens Glathe wrote:
> only if it reports as a V0.96 XHCI controller. Appears to fix the errors
> "xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of
> current TD ep_index 2 comp_code 13" that appear spuriously (or pretty
> often) when using a r8152 USB3 ethernet adapter with integrated hub.
> 
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>  drivers/usb/host/xhci-pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index dce6c0ec8d34..d1b8e7148dd1 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -306,8 +306,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  	}
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
> -		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
> +		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
> +		/* try to tame the ASMedia 1042 controller which is 0.96 */
> +		if (xhci->hci_version == 0x96)
> +			xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
> +	}
>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
>  		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI) {
>  		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
> -- 
> 2.25.1
> 
> ---
> Hi there, a "try again" with git send-email and the corrected patch. Hope this works now.
> 
> with best regards
> 
> Jens Glathe

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

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
