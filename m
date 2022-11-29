Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC9063BACB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiK2Her (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiK2Hem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:34:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631274AF16;
        Mon, 28 Nov 2022 23:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 089C3615B7;
        Tue, 29 Nov 2022 07:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F934C433C1;
        Tue, 29 Nov 2022 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669707279;
        bh=tECsQ2ZfxkV3bC+b6iryBrVJE0Vaq25uaQkwxanlCRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1/5RPRoVUoYxJuBAFwxOgZgr2PerUlLxDFto8NeSYjubJ/m2raYQ7Yi/yv4/FeN67
         NTD72Pq4gG9HAkXqECN94NAlvAXzNMVfDFT8jFP3I9Juw7aAVlt927QoIJDZ/dEhs7
         b4lJLfHDNq2U55xdEHQ9jzGzsGmSpj6RITbGG6eE=
Date:   Tue, 29 Nov 2022 08:34:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     linus.walleij@linaro.org, mailhol.vincent@wanadoo.fr,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: FHCI: fix error return code in of_fhci_probe()
Message-ID: <Y4W2DQGsZp2w2NpR@kroah.com>
References: <1669707158-43984-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669707158-43984-1-git-send-email-wangyufen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 03:32:38PM +0800, Wang Yufen wrote:
> Fix to return a negative error code of PTR_ERR(fhci->gpiods[i])
> instead of 0.
> 
> Fixes: a4efdb8a423b ("USB: FHCI: Switch to GPIO descriptors")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/usb/host/fhci-hcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
> index 95a4446..f84f1c8 100644
> --- a/drivers/usb/host/fhci-hcd.c
> +++ b/drivers/usb/host/fhci-hcd.c
> @@ -639,8 +639,8 @@ static int of_fhci_probe(struct platform_device *ofdev)
>  					NULL, i, GPIOD_OUT_LOW);
>  
>  		if (IS_ERR(fhci->gpiods[i])) {
> -			dev_err(dev, "incorrect GPIO%d: %ld\n",
> -				i, PTR_ERR(fhci->gpiods[i]));
> +			ret = PTR_ERR(fhci->gpiods[i]);
> +			dev_err(dev, "incorrect GPIO%d: %d\n", i, ret);
>  			goto err_gpios;
>  		}
>  		if (!fhci->gpiods[i]) {
> -- 
> 1.8.3.1
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
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
