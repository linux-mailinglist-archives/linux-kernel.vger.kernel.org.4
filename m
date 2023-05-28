Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E3F7138CF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 10:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjE1I7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 04:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1I7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 04:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6168AC3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 01:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E572A60B8F
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 08:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A141BC433D2;
        Sun, 28 May 2023 08:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685264371;
        bh=1bcyegoixc2lffmeeEozrOPkCJkoAIG0nh4u/jbtUw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEwCMGxhXeSj3PpmiHhppuuANzDQ16hf8zUDIbQ6ewsYzmHfcLZCfjZ5MXY2i09XB
         aJfNYotWyVunKT0ULFLoxSboGmZm0VpH91QT5ktRwORv0lGBaaoecgn24CaS1GK8MZ
         AnMAyf71ZtvGpq7at9Z30GpZpLcqAh62jHqNSz5E=
Date:   Sun, 28 May 2023 09:59:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prathu Baronia <prathubaronia2011@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: Re: [PATCH v4 1/3] axis-fifo: fix smatch warning for format specifier
Message-ID: <2023052814-savage-culprit-2096@gregkh>
References: <ZHHE/H2p4Go/Igc/@redkillpc>
 <20230527115101.47569-1-prathubaronia2011@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527115101.47569-1-prathubaronia2011@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 05:20:58PM +0530, Prathu Baronia wrote:
> Fix an old smatch warning reported by lkp introduced by commit
> d2d7aa53891e. In the mentioned commit we had used "%pa" format specifier
> for a void* type and hence smatch complained about its use instead of
> "%p".
> 
> Fixes: d2d7aa53891e ("staging: axis-fifo: convert to use miscdevice")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202305150358.nt1BkbXz-lkp@intel.com/
> Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
> ---
> V3 -> V4: Split into warning fixing and cleanup commits
> V2 -> V3: Fix smatch warnings from kernel test robot
> V1 -> V2: Split into logical commits and fix commit message
> 
>  drivers/staging/axis-fifo/axis-fifo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index 7a21f2423204..271cab805cad 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -906,8 +906,8 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  	if (rc < 0)
>  		goto err_initial;
>  
> -	dev_info(fifo->dt_device, "axis-fifo created at %pa mapped to 0x%pa, irq=%i\n",
> -		 &r_mem->start, &fifo->base_addr, fifo->irq);
> +	dev_info(fifo->dt_device, "axis-fifo created at %pa mapped to 0x%p, irq=%i\n",
> +		 &r_mem->start, fifo->base_addr, fifo->irq);

In looking at this further, this whole dev_info() line should just be
removed.  When drivers work properly, they are quiet, otherwise the
kernel log would look even worse than it currently is.

So please just remove this entirely.  Also, attempting to print memory
addresses to the kernel log is very suspect and generally frowned apon,
which is another reason this shouldn't be done.

thanks,

greg k-h
