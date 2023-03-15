Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703CA6BAEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCOLNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCOLNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:13:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5548B5CC0E;
        Wed, 15 Mar 2023 04:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA38BB81DE9;
        Wed, 15 Mar 2023 11:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598D3C433D2;
        Wed, 15 Mar 2023 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678878624;
        bh=71rF8rOVFv9FB+075jhoVdT0KO1/uKHB6uIBEc5iIFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdAjXbokuyajMcwx5+8Z52gXImqwePUI3TcarDof+2Jy/HhbJTxifewAOuJBigRLg
         l/5KxcPJcGZdLysI3nVKEwLXvxhE4Oi+UePG2sNF0GSuk3kD/dMSlw2pp11dH9Pd+U
         58rFKKE62zEZevO/SsNZxBWaSw4uEZwFPMCevGsE=
Date:   Wed, 15 Mar 2023 12:10:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     jirislaby@kernel.org, robh@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] tty: serdev: serdev-ttyport: add devt for ctrl->dev
Message-ID: <ZBGnniL7x5ENju6H@kroah.com>
References: <20230315105400.23426-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315105400.23426-1-sherry.sun@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 06:54:00PM +0800, Sherry Sun wrote:
> For serdev framework, the serdev_controller device is the tty device,
> which is also the child device of the uart_port device. If we don't set
> devt property for ctrl->dev, device_find_child(uport->dev, ...) may
> always return NULL in uart_suspend_port() function, which prevents us
> from properly handling uart port suspend, so fix it here.
> 
> Fixes: bed35c6dfa6a ("serdev: add a tty port controller driver")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serdev/serdev-ttyport.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index bba37ab90215..c58af8141380 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -268,6 +268,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
>  {
>  	struct serdev_controller *ctrl;
>  	struct serport *serport;
> +	dev_t devt = MKDEV(drv->major, drv->minor_start) + idx;
>  	int ret;
>  
>  	if (!port || !drv || !parent)
> @@ -282,6 +283,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
>  	serport->tty_idx = idx;
>  	serport->tty_drv = drv;
>  
> +	ctrl->dev.devt = devt;

This feels wrong as you can't just create a magic dev_t out of no where
and expect it to be handled properly.  Where now is this dev_t exposed?

Something else feels wrong here, sorry, I do not think this is correct.

thanks,

greg k-h
