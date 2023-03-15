Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1746BA985
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjCOHku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjCOHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:40:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2201E5D764;
        Wed, 15 Mar 2023 00:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90D08B81CCE;
        Wed, 15 Mar 2023 07:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D956FC433EF;
        Wed, 15 Mar 2023 07:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678865986;
        bh=dzJZVX7qXok/wVkIoDDwcPhllpR8Nts/9I1KfQjODTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CsCCP1Bs3BR1yeSflXsHMQWLyZtp1zOzoFigrQiGKq8OWEmQIiJX1n9g1qanRbqo4
         0ehihlw+8vPNigx9yglrYQDHBdg1iYrKXlngXVjv5u5B3K5/sGaDWHDFpvffopb3o1
         +c01Bu/uK2o32GlvmYDr/tIOq8bYUkt9nRhq56Ok=
Date:   Wed, 15 Mar 2023 08:39:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     jirislaby@kernel.org, robh@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] tty: serdev: serdev-ttyport: set correct tty->dev for
 serdev framework
Message-ID: <ZBF2Pyd4VSZq3HoA@kroah.com>
References: <20230315072143.7815-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315072143.7815-1-sherry.sun@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 03:21:43PM +0800, Sherry Sun wrote:
> ttyport_open() calls tty_init_dev() to initialize a tty device, but
> tty_get_device() cannot get the correct tty->dev for serdev tty in
> alloc_tty_struct(), because serdev framework does not set tty_class, so
> class_find_device_by_devt(tty_class, devt) may always return NULL.
> 
> For serdev framework, we need to assign the correct ctrl->dev to
> tty->dev.
> 
> Fixes: bed35c6dfa6a ("serdev: add a tty port controller driver")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serdev/serdev-ttyport.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index d367803e2044..bba37ab90215 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -112,6 +112,7 @@ static int ttyport_open(struct serdev_controller *ctrl)
>  	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
>  	if (IS_ERR(tty))
>  		return PTR_ERR(tty);
> +	tty->dev = &ctrl->dev;

What in-kernel driver needs this change?  How has it not been a problem
so far?

And why are you saving off a reference counted pointer without
incrementing the reference to the pointer?

thanks,

greg k-h
