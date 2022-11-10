Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD716248C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiKJRzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJRzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:55:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5893643AC5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:55:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C539DB822A3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A77C433D6;
        Thu, 10 Nov 2022 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668102916;
        bh=fQFYkEa23fxI7TRj35/AbFk9uXutR/RVnNdiflFWyQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDHjQJT3ZCs8Bh5hRlxoJ6EzrM+XvnxwqdzHqny38CAkKZLND+LkSQkBCuUeSv2Mb
         qf+a+SPaAgrOcHsuYhFR976kwUBUTbcdrRbqZf7Pp/Yec9nfQjUiR+jI0o2hCi3fs/
         hA3e+mhRlJoz8Wxxtw01DL2u+BjrWm0UdFicgqN0=
Date:   Thu, 10 Nov 2022 18:55:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     soha@lohu.info
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        'Wende Tan' <twd2.me@gmail.com>
Subject: Re: [PATCH] platform: use fwnode_irq_get_byname instead of
 of_irq_get_byname to get irq
Message-ID: <Y207AeWA1LYvVKwI@kroah.com>
References: <0E39B15006ADC205+02a601d8d4f8$a00a09e0$e01e1da0$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E39B15006ADC205+02a601d8d4f8$a00a09e0$e01e1da0$@lohu.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 02:15:29AM +0800, soha@lohu.info wrote:
> >From 02df97f4d814b9893eef2c2118b85d2b4b9d61ae Mon Sep 17 00:00:00 2001
> From: Soha Jin <soha@lohu.info>
> Date: Sat, 1 Oct 2022 00:26:04 +0800
> Subject: [PATCH] platform: use fwnode_irq_get_byname instead of
>  of_irq_get_byname to get irq
> 
> Not only platform devices described by OF have named interrupts, but
> devices described by ACPI also have named interrupts. The fwnode is an
> abstraction to different standards, and using fwnode_irq_get_byname can
> support more devices.
> 
> Signed-off-by: Soha Jin <soha@lohu.info>
> Tested-by: Wende Tan <twd2.me@gmail.com>
> ---
>  drivers/base/platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 51bb22898..968f3d71e 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -441,8 +441,8 @@ static int __platform_get_irq_byname(struct platform_device *dev,
>  	struct resource *r;
>  	int ret;
>  
> -	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
> -		ret = of_irq_get_byname(dev->dev.of_node, name);
> +	if (!dev->dev.of_node || IS_ENABLED(CONFIG_OF_IRQ)) {
> +		ret = fwnode_irq_get_byname(dev_fwnode(&dev->dev), name);
>  		if (ret > 0 || ret == -EPROBE_DEFER)
>  			return ret;
>  	}
> -- 
> 2.30.2
> 
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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
