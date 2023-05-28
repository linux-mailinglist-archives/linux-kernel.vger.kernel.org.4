Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EC67138D0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 11:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjE1JAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 05:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE1JAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 05:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3D2C7
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 02:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1307860EBC
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 09:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C73CC433D2;
        Sun, 28 May 2023 09:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685264417;
        bh=Xm6vx64mC8HigjICbwNyiOMxNFRarHp9ZLsMOMe/4YY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtBUoJkw7+t/3rgmPmuLuhDlvH++zj4Lg90YxKTDRLtVvq1kUQ9OdFk7xwnbI6pUS
         QgTDZOTftsAWRsySYZUEa090zw+LkFfwohn1hujWWJ3H5pwYIIA0y73JeJc2sFI6kx
         VEp7dZCfT5Rz2IbPF8ttJXEMeBv/J2ARQLqEynJs=
Date:   Sun, 28 May 2023 10:00:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prathu Baronia <prathubaronia2011@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: Re: [PATCH v4 2/3] axis-fifo: use devm_kasprintf() for allocating
 formatted strings
Message-ID: <2023052847-festival-moistness-9a14@gregkh>
References: <ZHHE/H2p4Go/Igc/@redkillpc>
 <20230527115101.47569-1-prathubaronia2011@gmail.com>
 <20230527115101.47569-2-prathubaronia2011@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527115101.47569-2-prathubaronia2011@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 05:20:59PM +0530, Prathu Baronia wrote:
> In various places, string buffers of a fixed size are allocated, and
> filled using snprintf() with the same fixed size, which is error-prone.
> 
> Replace this by calling devm_kasprintf() instead, which always uses the
> appropriate size.
> 
> Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index 271cab805cad..d71bdc6dd961 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -816,10 +816,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  	 * ----------------------------
>  	 */
>  
> -	device_name = devm_kzalloc(dev, 32, GFP_KERNEL);
> -	if (!device_name)
> -		return -ENOMEM;
> -
>  	/* allocate device wrapper memory */
>  	fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
>  	if (!fifo)
> @@ -857,7 +853,11 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
>  
>  	/* create unique device name */
> -	snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
> +	device_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%pa", DRIVER_NAME, &r_mem->start);

we should not be using a kernel address as a device name, please fix
this up to just use a unique number instead.

thanks,

greg k-h
