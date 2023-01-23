Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7DC677F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjAWPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjAWPO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:14:57 -0500
X-Greylist: delayed 21305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 07:14:12 PST
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC9B29417;
        Mon, 23 Jan 2023 07:14:11 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 803FE100064; Mon, 23 Jan 2023 15:13:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1674486820; bh=XBfeNcvL0gBZunmR/ouv0dm+YbS9YhQ7uTwZygr49mI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8HJ5Palc1WEhJWFAznvEyA2o4FVaNlYlwmdpNAy9F8X7Y55W33desX9ZCDFWGel0
         KBXsU5VPC8TpuzMwDi1VSPLXLuMAUKIXeO1OLOpZcTopUSg1JQjqeh51BVLOHdBivn
         ugZ5enmLNU0A2tqRkEw0B2jXP4atuyaeLO9+zky1pM4gA+QrOYsZO1m0gk5iCPUaq4
         2LKSpwNAHHEMXaNzkjMOrl0fRTcyQ1Z6Ws1krSVvZyHMMTo+AhrDP/+HiMBJ+fiN6H
         1627g+l4DyMlMFOT4l0+NOAIT70YeGXS1s63+/qv9XEF79V0ttsBx7OD63kTpySoWK
         csSlU/pGm7lRA==
Date:   Mon, 23 Jan 2023 15:13:40 +0000
From:   Sean Young <sean@mess.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-media@vger.kernel.org, maximlevitsky@gmail.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: rc: Fix use-after-free bugs caused by
 ene_tx_irqsim()
Message-ID: <Y86kJKofh+tLYl6A@gofer.mess.org>
References: <20230123142123.58870-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123142123.58870-1-duoming@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 10:21:23PM +0800, Duoming Zhou wrote:
> When the ene device is detaching, function ene_remove() will
> be called. But there is no function to cancel tx_sim_timer
> in ene_remove(), the timer handler ene_tx_irqsim() could race
> with ene_remove(). As a result, the UAF bugs could happen,
> the process is shown below.
> 
>     (cleanup routine)          |        (timer routine)
>                                | mod_timer(&dev->tx_sim_timer, ..)
> ene_remove()                   | (wait a time)
>   kfree(dev) //FREE            |
>                                | ene_tx_irqsim()
>                                |   dev->hw_lock //USE
>                                |   ene_tx_sample(dev) //USE
> 
> Fix by adding del_timer_sync(&dev->tx_sim_timer) in ene_remove(),
> The tx_sim_timer could stop before ene device is deallocated.
> 
> What's more, the timer can call ene_tx_sample() which can write
> to the io ports. So we should put rc_unregister_device() and
> del_timer_sync(&dev->tx_sim_timer) before release_region() in
> ene_remove().
> 
> Fixes: 9ea53b74df9c ("V4L/DVB: STAGING: remove lirc_ene0100 driver")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>   - Move rc_unregister_device() and del_timer_sync() before release_region().
> 
>  drivers/media/rc/ene_ir.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
> index e09270916fb..2864360af9e 100644
> --- a/drivers/media/rc/ene_ir.c
> +++ b/drivers/media/rc/ene_ir.c
> @@ -1112,8 +1112,9 @@ static void ene_remove(struct pnp_dev *pnp_dev)
>  	spin_unlock_irqrestore(&dev->hw_lock, flags);
>  
>  	free_irq(dev->irq, dev);
> -	release_region(dev->hw_io, ENE_IO_SIZE);
>  	rc_unregister_device(dev->rdev);
> +	del_timer_sync(&dev->tx_sim_timer);
> +	release_region(dev->hw_io, ENE_IO_SIZE);
>  	kfree(dev);
>  }

I'm sorry, I think there might be a problem there: the irq is freed before
the rc device is unregistered.

The rx receiver is disabled with ene_rx_disable() before rc_unregister_device()
is called, which means it can be enabled again if a process opens /dev/lirc0
between ene_rx_disable() and rc_unregister_device().

ene_remove() should call rc_unregister_device() and del_timer_sync() before
anything else.


Sean
