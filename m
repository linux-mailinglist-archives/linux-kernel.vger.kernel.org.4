Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C636661FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjAKRbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbjAKR3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:29:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B510ECFA;
        Wed, 11 Jan 2023 09:26:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ED6761DA8;
        Wed, 11 Jan 2023 17:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBF8C433D2;
        Wed, 11 Jan 2023 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673457961;
        bh=NP2y6S++5x5+MUjd094n7ofaKtyxtCts0E9o4Nm2WhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fTRr1wKfHYmqMZ5v6bSHbTdMA2ka1a7Nnlw8K+fSSkbq5Nr2+xsgG8Vvz5DEPQD52
         XR2Cznr9+ibqxJEcnihsl/sg6Vh2djlx3pRKodDWjmQRIBlAKjzo7+kIlVPkgvQHMI
         yrw5+uzjR5x1ilAAvGAbjb6VtLqjULGI7zS64eanDyOLLjzf/PkwGczFQO7xcQqQjd
         FJmDKFouwNkx7lnnjYBz0EgNP2G6vmdBMkX0pkssT+PSVrx7K+jv8jWH2S94kyAu9L
         cBIRYZTienPKKu4yaJKGBFHwJd3LvTBTgHgoanYP7+r7vzXHHbGTegkozs3mIeN3J1
         y63M2Wkx05RMw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pFerW-00047W-B0; Wed, 11 Jan 2023 18:26:06 +0100
Date:   Wed, 11 Jan 2023 18:26:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Samuel Iglesias =?utf-8?Q?Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Lin <dtwlin@gmail.com>, Alex Elder <elder@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 07/13] tty: Convert ->dtr_rts() to take bool argument
Message-ID: <Y77xLmLCbldH1VOX@hovoldconsulting.com>
References: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
 <20230111142331.34518-8-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111142331.34518-8-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:23:25PM +0200, Ilpo Järvinen wrote:
> Convert the raise/on parameter in ->dtr_rts() to bool through the
> callchain. The parameter is used like bool. In USB serial, there
> remains a few implicit bool -> larger type conversions because some
> devices use u8 in their control messages.
> 
> In moxa_tiocmget(), dtr variable was reused for line status which
> requires int so use a separate variable for status.
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/char/pcmcia/synclink_cs.c    |  4 +--
>  drivers/mmc/core/sdio_uart.c         |  4 +--
>  drivers/staging/greybus/uart.c       |  2 +-
>  drivers/tty/amiserial.c              |  2 +-
>  drivers/tty/hvc/hvc_console.c        |  4 +--
>  drivers/tty/hvc/hvc_console.h        |  2 +-
>  drivers/tty/hvc/hvc_iucv.c           |  4 +--
>  drivers/tty/moxa.c                   | 54 ++++++++++++++--------------
>  drivers/tty/mxser.c                  |  2 +-
>  drivers/tty/n_gsm.c                  |  2 +-
>  drivers/tty/serial/serial_core.c     |  8 ++---
>  drivers/tty/synclink_gt.c            |  2 +-
>  drivers/tty/tty_port.c               |  4 +--
>  drivers/usb/class/cdc-acm.c          |  2 +-
>  drivers/usb/serial/ch341.c           |  2 +-
>  drivers/usb/serial/cp210x.c          |  4 +--
>  drivers/usb/serial/cypress_m8.c      |  6 ++--
>  drivers/usb/serial/digi_acceleport.c |  6 ++--
>  drivers/usb/serial/f81232.c          |  2 +-
>  drivers/usb/serial/f81534.c          |  2 +-
>  drivers/usb/serial/ftdi_sio.c        |  2 +-
>  drivers/usb/serial/ipw.c             |  2 +-
>  drivers/usb/serial/keyspan.c         |  2 +-
>  drivers/usb/serial/keyspan_pda.c     |  2 +-
>  drivers/usb/serial/mct_u232.c        |  4 +--
>  drivers/usb/serial/mxuport.c         |  2 +-
>  drivers/usb/serial/pl2303.c          |  2 +-
>  drivers/usb/serial/quatech2.c        |  2 +-
>  drivers/usb/serial/sierra.c          |  2 +-
>  drivers/usb/serial/spcp8x5.c         |  2 +-
>  drivers/usb/serial/ssu100.c          |  2 +-
>  drivers/usb/serial/upd78f0730.c      |  6 ++--
>  drivers/usb/serial/usb-serial.c      |  2 +-
>  drivers/usb/serial/usb-wwan.h        |  2 +-
>  drivers/usb/serial/usb_wwan.c        |  2 +-
>  drivers/usb/serial/xr_serial.c       |  6 ++--
>  include/linux/tty_port.h             |  4 +--
>  include/linux/usb/serial.h           |  2 +-
>  38 files changed, 84 insertions(+), 82 deletions(-)

Same here. No need to lump the tty-port changes with USB-serial changes.

Johan
