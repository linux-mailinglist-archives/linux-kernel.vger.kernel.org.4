Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565C166E197
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjAQPEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjAQPEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:04:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8418D3EFD8;
        Tue, 17 Jan 2023 07:04:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4A98B81647;
        Tue, 17 Jan 2023 15:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3DDC433D2;
        Tue, 17 Jan 2023 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673967848;
        bh=S1JjwQ5nbGWA6bNEpYTMJnz58OoPA/OyEPsUOGwp2Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmPxbNmf5TI/lBt6Muj3nlB0jYb6Ne610NBSaafeCKVoEm0my1HflEy0Z3BXou/XU
         XZwQ/iT0ZvvXgxz+Kwq7lrz5LhqZHU+QqFAnQNSV9lpzs4tDQ8r3DqUdgyr8UqvBDQ
         YDACesUabv8lezTBhHKYfIIQijcitIK5kgkDl0KA=
Date:   Tue, 17 Jan 2023 16:04:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: Re: [PATCH V2 1/2] usb: gadget: u_ether: Improve print in
 gether_setup_name_default()
Message-ID: <Y8a45WrjLUdCEHH+@kroah.com>
References: <20230116155545.101391-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116155545.101391-1-jonathanh@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 03:55:44PM +0000, Jon Hunter wrote:
> The print in in gether_setup_name_default() does not provide any useful
> information because a random MAC address will always be generated when
> calling this function. Rather than removing the print, update the print
> to show MAC address that is generated which is similar to other ethernet
> drivers.
> 
> Finally, given that the strings 'self' and 'host' are static we do not
> need to pass these strings as an arguments.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> V1 -> V2: Added this patch
> 
>  drivers/usb/gadget/function/u_ether.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 8f12f3f8f6ee..be8e7b448933 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char *netname)
>  	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
>  
>  	eth_random_addr(dev->dev_mac);
> -	pr_warn("using random %s ethernet address\n", "self");
> +	pr_warn("using random self ethernet address %pM\n", dev->dev_mac);

If you are going to fix these up, please use dev_warn() and friends,
don't use "raw" pr_* calls in a driver.

thanks,

greg k-h
