Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C75564734C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiLHPi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLHPiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:38:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C038233AE;
        Thu,  8 Dec 2022 07:37:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1413B82441;
        Thu,  8 Dec 2022 15:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8589C433D6;
        Thu,  8 Dec 2022 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670513837;
        bh=fT0IjqTMxFzX+YMMLQ3B66lyktKJPjkCFM8yEgHLOZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y80fjk7U86gQudJDLL4Camf9NNuasvyzkLzvARJKN8g7HO+KwKAWwPM0tfw4Gzisp
         BBB9M2Wshrw9/I4xV8PCgRWVFoY0OX94CokjvRS49TgNKmTkCDhcXBhEkZp288ptq+
         swCIN1t3tZluJcMwrz3Qajhlqy5DcLv/CUcVJww4=
Date:   Thu, 8 Dec 2022 16:37:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, chunfeng.yun@mediatek.com,
        matthias.bgg@gmail.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: mtu3: fix sleep-in-atomic-context bug caused by
 usleep_range()
Message-ID: <Y5IEqo8EeDiBnzwM@kroah.com>
References: <20221128063207.100596-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128063207.100596-1-duoming@zju.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:32:07PM +0800, Duoming Zhou wrote:
> The function zero_autoresume() is a timer handler that runs in
> atomic context. It is used to wake up the host connected to the
> gadget. when used by usb mtu3, the zero_autoresume() calls
> usleep_range() that can sleep. As a result, the sleep-in-atomic-
> context bug will happen. The process is shown below.
> 
>     (atomic context)
> zero_autoresume()
>   usb_gadget_wakeup()
>     mtu3_gadget_wakeup()
>       usleep_range() //sleep
> 
> This patch changes usleep_range(10000, 11000) to mdelay(10)
> in order to mitigate the bug.
> 
> Fixes: df2069acb005 ("usb: Add MediaTek USB3 DRD driver")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>  drivers/usb/mtu3/mtu3_gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
> index 80236e7b089..e366c4a97d7 100644
> --- a/drivers/usb/mtu3/mtu3_gadget.c
> +++ b/drivers/usb/mtu3/mtu3_gadget.c
> @@ -468,7 +468,7 @@ static int mtu3_gadget_wakeup(struct usb_gadget *gadget)
>  	} else {
>  		mtu3_setbits(mtu->mac_base, U3D_POWER_MANAGEMENT, RESUME);
>  		spin_unlock_irqrestore(&mtu->lock, flags);
> -		usleep_range(10000, 11000);
> +		mdelay(10);
>  		spin_lock_irqsave(&mtu->lock, flags);
>  		mtu3_clrbits(mtu->mac_base, U3D_POWER_MANAGEMENT, RESUME);
>  	}
> -- 
> 2.17.1
> 

Have you tested this on real hardware?  How come the original code does
not trigger any run-time warnings?  Does your change solve the runtime
issue?

thanks,

greg k-h
