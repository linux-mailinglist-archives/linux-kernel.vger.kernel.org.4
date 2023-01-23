Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4E3677744
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjAWJTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjAWJTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:19:08 -0500
X-Greylist: delayed 544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 01:19:07 PST
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8AD13D68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:19:07 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 467C6100064; Mon, 23 Jan 2023 09:10:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1674465001; bh=/b2WVrJNDLLQpiJcqhoKXqMkoxkhDRDzegq1+1WEz2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q84c1lVdBo0zuY1d2hey/opfrGWvcylgP/Zr0p1V9iFqbbUX7gtgEbVvrxhXrbXdH
         hddiAqoUyQZDHF4kDZZ1jcIdSs30Jpglca7Tl0JmZw+FsiahqG4U3Dq5TP/a9kkcAo
         VsgG4U3IbNcuXRo3wgJzO7I4wDkN58zJYZgHO+Nnn8K4bod54PDTarVlL3X4JR+V9k
         OFdhVcmf2ECvinQFByyfi9y5HYiFJJDAUtNX0y0VKVQrnqdpwrdoxHXwU/DL+CH0Ql
         4dYH+ObdnOEpvQL6YhLAlzFe03ngEeyyvlqcOFoQLIqhayHPfPPG9ZmIpMxCeGNeJA
         6RTNK49f6sFNQ==
Date:   Mon, 23 Jan 2023 09:10:01 +0000
From:   Sean Young <sean@mess.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        maximlevitsky@gmail.com, mchehab@kernel.org
Subject: Re: [PATCH] media: rc: Fix use-after-free bugs caused by
 ene_tx_irqsim()
Message-ID: <Y85O6XqiiyRZqHnE@gofer.mess.org>
References: <20230123011223.23804-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123011223.23804-1-duoming@zju.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:12:23AM +0800, Duoming Zhou wrote:
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
> This problem is found by static analysis.
> 
> Fixes: 9ea53b74df9c ("V4L/DVB: STAGING: remove lirc_ene0100 driver")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>  drivers/media/rc/ene_ir.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
> index e09270916fb..716b72a048f 100644
> --- a/drivers/media/rc/ene_ir.c
> +++ b/drivers/media/rc/ene_ir.c
> @@ -1114,6 +1114,7 @@ static void ene_remove(struct pnp_dev *pnp_dev)
>  	free_irq(dev->irq, dev);
>  	release_region(dev->hw_io, ENE_IO_SIZE);
>  	rc_unregister_device(dev->rdev);
> +	del_timer_sync(&dev->tx_sim_timer);

Great catch!

The timer can call ene_tx_sample() which can write to the io ports, so the
ordering still is not quite right. I think the rc_unregister_device() and
del_timer_sync() should be call first in ene_remove().


Sean
