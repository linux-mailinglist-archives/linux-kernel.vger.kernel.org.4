Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14CB6735F8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjASKqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjASKq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:46:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A4D44BF5;
        Thu, 19 Jan 2023 02:46:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAD306150E;
        Thu, 19 Jan 2023 10:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BE3C433EF;
        Thu, 19 Jan 2023 10:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674125183;
        bh=qpyXLL/Rf+o5zDU8yK7JwFneqwZHvHMocnZnj4DcFMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcSm87FWVijyGcolTuRTchzoRQqrGIaiNtWpMRW8HAw4fjK10U+inBHAF0iabmfjm
         MrF5yXxlBAznW4p30/xXuXxgzslfWblEsYUeuHrFGA5so64Q5fuAcCZo5DSNDLXRAr
         466n4ulOvx79eKseouaQ4R3NTawwh9TlXsJ5ukRg=
Date:   Thu, 19 Jan 2023 11:46:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: Re: [PATCH V3 2/2] usb: gadget: u_ether: Don't warn in
 gether_setup_name_default()
Message-ID: <Y8kfdm9juBi58bnj@kroah.com>
References: <20230119102547.26698-1-jonathanh@nvidia.com>
 <20230119102547.26698-2-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119102547.26698-2-jonathanh@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:25:47AM +0000, Jon Hunter wrote:
> The function gether_setup_name_default() is called by various USB
> ethernet gadget drivers. Calling this function will select a random
> host and device MAC addresses. A properly working driver should be
> silent, so don't warn the user about default MAC addresses selection
> happening and convert the warnings into debug messages.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> V2 -> V3: Updated commit message.
> V1 -> V2: Changed print to debug instead of info.
> 
>  drivers/usb/gadget/function/u_ether.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index be8e7b448933..8feb40e38137 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char *netname)
>  	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
>  
>  	eth_random_addr(dev->dev_mac);
> -	pr_warn("using random self ethernet address %pM\n", dev->dev_mac);
> +	pr_debug("using random self ethernet address %pM\n", dev->dev_mac);
>  
>  	/* by default we always have a random MAC address */
>  	net->addr_assign_type = NET_ADDR_RANDOM;
>  
>  	eth_random_addr(dev->host_mac);
> -	pr_warn("using random host ethernet address %pM\n", dev->host_mac);
> +	pr_debug("using random host ethernet address %pM\n", dev->host_mac);

In looking at this further, you are right, the structures are not
initialized properly yet.

So move these to a different function entirely, they should be in
gether_register_netdev() instead, after the device is registered with
the system.

thanks,

greg k-h
