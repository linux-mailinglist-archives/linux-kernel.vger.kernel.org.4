Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E29D5E8A40
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiIXIr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiIXIrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:47:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FA3E6A03;
        Sat, 24 Sep 2022 01:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E19FB80D28;
        Sat, 24 Sep 2022 08:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF38C433D6;
        Sat, 24 Sep 2022 08:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664009271;
        bh=/e2WeQ9/78pWIPbxuo0MNR+GqpBS8UnV+sPaX+AjYdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nn+bggOy2ZBmh0yqlQ1FxSXACHhP6wUEUwROkMZjkjAOshkQBhc28iq+XKfj0yWwl
         zBGAVeGGBXOE9uJGs9N7l71dWX0aBTy/QAZxSzoJrhx6loBzn5KMnpLEDWBRQNh70x
         JHcKXvLD2757lYPRwYUMpJGmor20AiXoFt8SBxmc=
Date:   Sat, 24 Sep 2022 10:47:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite
 being a V0.96 controller
Message-ID: <Yy7ENBX2Zo3vNgB1@kroah.com>
References: <em0b7a6682-2da4-4480-8801-1107ea9756dd@aea403bc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em0b7a6682-2da4-4480-8801-1107ea9756dd@aea403bc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 08:16:34AM +0000, Jens Glathe wrote:
> Hi there,
> 
> second try at a patch which was an actual pain with my Lenovo T500 notebook, augmented with an USB3 PCMCIA card that has an ASM1042 chip. Inspired by this email thread: https://markmail.org/thread/7vzqbe7t6du6qsw3
> 
> ASM1042 identifies as a 0x96 XHCI host, brings spurious transfer event errors with a r8152 (Realtek 8153a) USB3 enthernet adapter. Additionally setting quirk XHCI_SPURIOUS_SUCCESS seems to resolve this issue in this case.
> 
> with best regards
> 
> Jens Glathe
> 
> ---
> 
> v1->v2
> 
> intensive use of scripts/checkpatch.pl, reformatted the code
> reformatted the commit text for line wraps

> From ffb3a70a48b91b79943a0131ddd470e5f09c0f41 Mon Sep 17 00:00:00 2001
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Date: Sun, 28 Aug 2022 16:23:41 +0200
> Subject: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a
>  V0.96 controller
> 
> only if it reports as a V0.96 XHCI controller. Appears to fix the errors
> "xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of
> current TD ep_index 2 comp_code 13" that appear spuriously (or pretty
> often) when using a r8152 USB3 ethernet adapter with integrated hub.
> 
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>  drivers/usb/host/xhci-pci.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index dce6c0ec8d34..f8b3b34d257e 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -305,9 +305,13 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  		xhci->quirks |= XHCI_EP_CTX_BROKEN_DCS;
>  	}
>  
> -	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
> -		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
> -		xhci->quirks |= XHCI_BROKEN_STREAMS;
> +  if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
> +      pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
> +    /* try to tame the ASMedia 1042 controller which is 0.96 */
> +    if (xhci->hci_version == 0x96)
> +      xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
> +    xhci->quirks |= XHCI_BROKEN_STREAMS;
> +  }
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

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

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
