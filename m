Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A0374E5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGKEJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKEJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:09:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B58B0;
        Mon, 10 Jul 2023 21:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9002C612CA;
        Tue, 11 Jul 2023 04:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CE1C433C8;
        Tue, 11 Jul 2023 04:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689048566;
        bh=1nMmpV3CVV4TbzRvPkAb9n7aZZSr8i4Jl6Q0Ss4Rmfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctoFXbYOCpWpvWu+Fh62F+//ohxNPdpGuO6F346FfP4zFgFe1RSL+5PLthQicXRiB
         mQ7ah+hR7xtWAiJN1pb5uBmTVNawA1SrnBCemjBGHcHtZz0HVIQ83i6hjwCHg8Gtai
         a4UasTNCoQwW+3o8VcIqvVvoD8p9M0rzli0t5N+c=
Date:   Tue, 11 Jul 2023 06:09:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wuyonggang001@208suo.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: usbhid: Fix use assignment in if condition
Message-ID: <2023071100-recoup-rebuild-c55a@gregkh>
References: <20230711014359.11991-1-zhanglibing@cdjrlc.com>
 <a4ca3852846e220cf378a664cf1c6213@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4ca3852846e220cf378a664cf1c6213@208suo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 09:47:06AM +0800, wuyonggang001@208suo.com wrote:
> Fix the following checkpatch error(s):
> 
> drivers/hid/usbhid/usbkbd.c:238:240:242:246: ERROR: do not use assignment in
> if condition
> 
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> ---
>  drivers/hid/usbhid/usbkbd.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
> index c439ed2f16db..cde7f82b7070 100644
> --- a/drivers/hid/usbhid/usbkbd.c
> +++ b/drivers/hid/usbhid/usbkbd.c
> @@ -235,15 +235,29 @@ static void usb_kbd_close(struct input_dev *dev)
> 
>  static int usb_kbd_alloc_mem(struct usb_device *dev, struct usb_kbd *kbd)
>  {
> -    if (!(kbd->irq = usb_alloc_urb(0, GFP_KERNEL)))
> +    kbd->irq = usb_alloc_urb(0, GFP_KERNEL)
> +
> +    if (!kbd->irq)
>          return -1;
> -    if (!(kbd->led = usb_alloc_urb(0, GFP_KERNEL)))
> +
> +    kbd->led = usb_alloc_urb(0, GFP_KERNEL)
> +
> +    if (!kbd->led)
>          return -1;
> -    if (!(kbd->new = usb_alloc_coherent(dev, 8, GFP_KERNEL,
> &kbd->new_dma)))
> +
> +    kbd->new = usb_alloc_coherent(dev, 8, GFP_KERNEL, &kbd->new_dma)
> +
> +    if (!kbd->new)
>          return -1;
> -    if (!(kbd->cr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL)))
> +
> +    kbd->cr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL)
> +
> +    if (!kbd->cr)
>          return -1;
> -    if (!(kbd->leds = usb_alloc_coherent(dev, 1, GFP_KERNEL,
> &kbd->leds_dma)))
> +
> +    kbd->leds = usb_alloc_coherent(dev, 1, GFP_KERNEL, &kbd->leds_dma)
> +
> +    if (!kbd->leds)
>          return -1;
> 
>      return 0;

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
