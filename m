Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC2723F87
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbjFFKcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbjFFKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1EBE42;
        Tue,  6 Jun 2023 03:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A87461844;
        Tue,  6 Jun 2023 10:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D26CC433EF;
        Tue,  6 Jun 2023 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686047518;
        bh=gpDuOpx+nxrFPOdv8X2ISo414UJ+j+5QJAYnzeQ8Wsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPtuI7OUy5TSzpyXlTaG6TGHJ2VFsPhBbN992kwU6q4RWcmj9Y/4dpHUI262fxQiz
         1PZbt4q2RRbxkeb7KPYidJ33HjekMuFZHDLfCL6mdQE07zZO4wWiYtyA0hoABKZmv7
         FsZwLvP5ndxsEqLpRvlRwC8BxaoZttHofpIr5Ifs=
Date:   Tue, 6 Jun 2023 12:31:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
Cc:     b-liu@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: usb: musb: musb_gadget: Removed unneeded code
Message-ID: <2023060639-thinner-moonlit-617f@gregkh>
References: <20230606102058.1010324-1-neelchakrabortykernelwork@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606102058.1010324-1-neelchakrabortykernelwork@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 03:50:58PM +0530, Neel Chakraborty wrote:
> Removed the static int musb_gadget_vbus_session function as it was
> doing nothing.It has reduced 13 lines of code
> 
> Signed-off-by: Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
> ---
>  drivers/usb/musb/musb_gadget.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 31c44325e828..3cb7fc4c84ed 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -1612,19 +1612,6 @@ static void musb_pullup(struct musb *musb, int is_on)
>  	musb_writeb(musb->mregs, MUSB_POWER, power);
>  }
>  
> -#if 0
> -static int musb_gadget_vbus_session(struct usb_gadget *gadget, int is_active)
> -{
> -	musb_dbg(musb, "<= %s =>\n", __func__);
> -
> -	/*
> -	 * FIXME iff driver's softconnect flag is set (as it is during probe,
> -	 * though that can clear it), just musb_pullup().
> -	 */
> -
> -	return -EINVAL;
> -}
> -#endif
>  
>  static int musb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
>  {
> -- 
> 2.40.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
