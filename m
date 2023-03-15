Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E476BAF59
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjCOLef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjCOLeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:34:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD4D6E684;
        Wed, 15 Mar 2023 04:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F18DB818E7;
        Wed, 15 Mar 2023 11:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC011C4339C;
        Wed, 15 Mar 2023 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678880001;
        bh=d2exycdafMMG6CpW9HcLV7XdG3T6Bjc4TAN7D2+UIa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLue0dZ7BiNyq5XXc3gZg6GoNaJw36uXl4m1cJAaKAuvT3ZrbqZFgpHvXfJj1xEwN
         DrBsI6juRK/RKlvfdglLZaG7Y7Ewo4s0jlaS4nFsXfoEOyvGWHy0Pl0hQNrLrTGr6h
         chBa8MI53RBfK+RW4jJWiQunhjOIeVcGdA5yhJUA=
Date:   Wed, 15 Mar 2023 12:33:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] tty: serdev: serdev-ttyport: set correct tty->dev for
 serdev framework
Message-ID: <ZBGs/sWZGnIbqHbd@kroah.com>
References: <20230315072143.7815-1-sherry.sun@nxp.com>
 <ZBF2Pyd4VSZq3HoA@kroah.com>
 <AS8PR04MB840408DC92F4001AB440353292BF9@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB840408DC92F4001AB440353292BF9@AS8PR04MB8404.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 09:49:53AM +0000, Sherry Sun wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: 2023年3月15日 15:40
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: jirislaby@kernel.org; robh@kernel.org; linux-serial@vger.kernel.org;
> > linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH] tty: serdev: serdev-ttyport: set correct tty->dev for
> > serdev framework
> > 
> > On Wed, Mar 15, 2023 at 03:21:43PM +0800, Sherry Sun wrote:
> > > ttyport_open() calls tty_init_dev() to initialize a tty device, but
> > > tty_get_device() cannot get the correct tty->dev for serdev tty in
> > > alloc_tty_struct(), because serdev framework does not set tty_class,
> > > so class_find_device_by_devt(tty_class, devt) may always return NULL.
> > >
> > > For serdev framework, we need to assign the correct ctrl->dev to
> > > tty->dev.
> > >
> > > Fixes: bed35c6dfa6a ("serdev: add a tty port controller driver")
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/tty/serdev/serdev-ttyport.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/tty/serdev/serdev-ttyport.c
> > > b/drivers/tty/serdev/serdev-ttyport.c
> > > index d367803e2044..bba37ab90215 100644
> > > --- a/drivers/tty/serdev/serdev-ttyport.c
> > > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > > @@ -112,6 +112,7 @@ static int ttyport_open(struct serdev_controller
> > *ctrl)
> > >  	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
> > >  	if (IS_ERR(tty))
> > >  		return PTR_ERR(tty);
> > > +	tty->dev = &ctrl->dev;
> > 
> > What in-kernel driver needs this change?  How has it not been a problem so
> > far?
> > 
> 
> Hi Greg, I searched the users of tty->dev under serial floder, found the following drivers need it.
> drivers/tty/serial/stm32-usart.c:780:                   pm_wakeup_event(tport->tty->dev, 0);
> drivers/tty/serial/fsl_lpuart.c:3018:           tty_dev = tty->dev;
> drivers/tty/serial/st-asc.c:266:                pm_wakeup_event(tport->tty->dev, 0);
> 
> Actually this issue was found when I tested the nxp Bluetooth driver which use serdev framework along with fsl_lpuart.c driver, when system is suspending, the following NULL pointer kernel panic is observed.
> This is because lpuart driver will check the device_may_wakeup(tty->dev) to determine if wakeup register bits need to be enabled or not before suspend, it works well the the ldisc tty, but since serdev tty doesn't set correct tty->dev, so here cause the NULL pointer panic.
> 
> root@imx8ulpevk:~# echo mem > /sys/power/state
> [   42.657779] PM: suspend entry (deep)
> [   42.664333] Filesystems sync: 0.002 seconds
> [   42.717624] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [   42.727063] OOM killer disabled.
> [   42.730383] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [   42.753652] fec 29950000.ethernet eth0: Link is Down
> [   42.780681] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000dc
> [   42.789603] Mem abort info:
> [   42.792430]   ESR = 0x0000000096000004
> [   42.796242]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   42.801661]   SET = 0, FnV = 0
> ......
> 
> > And why are you saving off a reference counted pointer without
> > incrementing the reference to the pointer?
> 
> Sorry, forgive me I am not clearly understand the requirement here, do you mean we need to add the following changes?
>     get_device(&ctrl->dev);
>     tty->dev = &ctrl->dev;
>     put_device((&ctrl->dev);

Ick, no, only do put_device() when you are finished with the pointer and
are not going to access it anymore.

> And per my understanding, the reference count needs to be increased and decreased from the user side, here we only do a initialization for the tty->dev.

Then something is not set up properly here, sorry.

greg k-h
