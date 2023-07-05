Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA824747E07
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGEHQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGEHQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:16:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C91A1A1;
        Wed,  5 Jul 2023 00:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1242F61450;
        Wed,  5 Jul 2023 07:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B7BC433C8;
        Wed,  5 Jul 2023 07:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688541380;
        bh=o58/JqrKgnTTM59z0X9VKVpJhnUEaXu99mh7Van6qxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=miagon6woTT1uw7fg/JNoEkEawgoRNFkjSS6kH++z2O8gB6wAsrWi7STLDEuM5dVK
         EtPAQHC4Vt0OHyYBrU77zZjCdFl+axL9cwmwUiLQycc8KCR3wVRUBpkhIxlceko5Yc
         qzgoYBe+EhhPREPEhZEZOBeTWkbDH7oFKpxaBiDA=
Date:   Wed, 5 Jul 2023 08:16:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Hao <yhao016@ucr.edu>
Cc:     chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: mtu3: Fix possible use-before-initialization bug
Message-ID: <2023070559-removable-emotion-70f1@gregkh>
References: <CA+UBctDxfb6+70+hzuXJ-gwb65E0uoNzXYEhpJT92sXr2CE7OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+UBctDxfb6+70+hzuXJ-gwb65E0uoNzXYEhpJT92sXr2CE7OA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 04:25:50PM -0700, Yu Hao wrote:
> The struct usb_ctrlrequest setup should be initialized in the function
> ep0_read_setup(mtu, &setup). However, inside that function,
> the variable count could be 0 and the struct usb_ctrlrequest setup
> is not initialized. But there is a read for setup.bRequestType.
> 
> Signed-off-by: Yu Hao <yhao016@ucr.edu>
> ---
>  drivers/usb/mtu3/mtu3_gadget_ep0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> index e4fd1bb14a55..67034fa515d0 100644
> --- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> +++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> @@ -638,7 +638,7 @@ static int ep0_handle_setup(struct mtu3 *mtu)
>  __releases(mtu->lock)
>  __acquires(mtu->lock)
>  {
> -   struct usb_ctrlrequest setup;
> +   struct usb_ctrlrequest setup = {};
>     struct mtu3_request *mreq;
>     int handled = 0;
> 
> -- 
> 2.34.1

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
