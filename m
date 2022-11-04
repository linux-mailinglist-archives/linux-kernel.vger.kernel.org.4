Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF64619BD3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiKDPgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiKDPgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:36:11 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490992BB3B;
        Fri,  4 Nov 2022 08:36:10 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id j12so5221233plj.5;
        Fri, 04 Nov 2022 08:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfPMTNxKfH1Iwjv44Zoz/84tOu0bbhe77Q2FXcd9ysg=;
        b=Tqfe3l9Drf9DDLG+iCs8NyBYy8ZsN0YouR1+u8vLjqvu6vVr5guZ4A63R8OExGMWPa
         fLXooKJLJv01EIg7KlZMrevERVHxFjhVvbjAeze9p64ATgZeoUpFUkd/M/2bjzBcz/rW
         nFOtsHptEgxsRrnyRnepp8cwCY/QHiiw3n8SxFmVWo022P/lHVh6hrFaUqwfn+XT3wev
         FZXrcL0yfPxpH54ealgMjhr6dCkaTvyopLeZhGP+OlLAbns+y6iP29GfsDfef96B+L+q
         sz/gaNSx6VMbykRFTU/X10khiPPn2fY9nSy/wPwSO5HKQ0GQang0O1nD33qrAnl5E5Sf
         FmWQ==
X-Gm-Message-State: ACrzQf3zX65tZKk/rG1WxvGTw9NUrnoBhH8rX/czSbM00rAj5kXNiN1O
        4JyuPvIIQ8goMtJn/rj4KesbDxVpbGNR+2EQirCaF7PTshg=
X-Google-Smtp-Source: AMsMyM6pkkAMAWeBioVp9IyUuLSTBM+J57o9fHZJ68LAVPMLmQ0K8N5/b2o6RkA32SeJJa79ErsrkV6/gI4iqaneRfw=
X-Received: by 2002:a17:90b:4ac3:b0:213:3918:f276 with SMTP id
 mh3-20020a17090b4ac300b002133918f276mr52894280pjb.19.1667576169351; Fri, 04
 Nov 2022 08:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr> <20221104115211.533zif7ip4f5tvky@pengutronix.de>
In-Reply-To: <20221104115211.533zif7ip4f5tvky@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 5 Nov 2022 00:35:57 +0900
Message-ID: <CAMZ6RqL864PFLOq1Wo3XV=kpAP0tVtd7Zj46oWw-pTr9rR=XiA@mail.gmail.com>
Subject: Re: [PATCH] can: etas_es58x: report the firmware version through ethtool
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 4 nov. 2022 at 21:06, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 04.11.2022 16:36:59, Vincent Mailhol wrote:
> > ES58x devices report below information in their usb product info
> > string:
> >
> >   * the firmware version
> >   * the bootloader version
> >   * the hardware revision
> >
> > Report the firmware version through ethtool_drvinfo::fw_version.
> > Because struct ethtool_drvinfo has no fields to report the boatloader
> > version nor the hardware revision, continue to print these in the
> > kernel log (c.f. es58x_print_product_info()).
> >
> > While doing so, bump up copyright year of each modified files.
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >  drivers/net/can/usb/etas_es58x/es581_4.c    |   5 +-
> >  drivers/net/can/usb/etas_es58x/es58x_core.c | 140 +++++++++++++-------
> >  drivers/net/can/usb/etas_es58x/es58x_core.h |  11 +-
> >  drivers/net/can/usb/etas_es58x/es58x_fd.c   |   5 +-
> >  4 files changed, 108 insertions(+), 53 deletions(-)
> >
> > diff --git a/drivers/net/can/usb/etas_es58x/es581_4.c b/drivers/net/can/usb/etas_es58x/es581_4.c
> > index 1bcdcece5ec7..1d6ae7b279cf 100644
> > --- a/drivers/net/can/usb/etas_es58x/es581_4.c
> > +++ b/drivers/net/can/usb/etas_es58x/es581_4.c
> > @@ -6,7 +6,7 @@
> >   *
> >   * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
> >   * Copyright (c) 2020 ETAS K.K.. All rights reserved.
> > - * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > + * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >   */
> >
> >  #include <linux/kernel.h>
> > @@ -492,7 +492,8 @@ const struct es58x_parameters es581_4_param = {
> >       .tx_bulk_max = ES581_4_TX_BULK_MAX,
> >       .urb_cmd_header_len = ES581_4_URB_CMD_HEADER_LEN,
> >       .rx_urb_max = ES58X_RX_URBS_MAX,
> > -     .tx_urb_max = ES58X_TX_URBS_MAX
> > +     .tx_urb_max = ES58X_TX_URBS_MAX,
> > +     .prod_info_delim = ','
>
> Nitpick: you can add a trailing "," here, makes the diff smaller on the
> next change :)

ACK.

> >  };
> >
> >  const struct es58x_operators es581_4_ops = {
> > diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> > index 51294b717040..7c20a73169f3 100644
> > --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> > +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> > @@ -7,7 +7,7 @@
> >   *
> >   * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
> >   * Copyright (c) 2020 ETAS K.K.. All rights reserved.
> > - * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > + * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >   */
> >
> >  #include <linux/ethtool.h>
> > @@ -1978,10 +1978,6 @@ static const struct net_device_ops es58x_netdev_ops = {
> >       .ndo_eth_ioctl = can_eth_ioctl_hwts,
> >  };
> >
> > -static const struct ethtool_ops es58x_ethtool_ops = {
> > -     .get_ts_info = can_ethtool_op_get_ts_info_hwts,
> > -};
> > -
> >  /**
> >   * es58x_set_mode() - Change network device mode.
> >   * @netdev: CAN network device.
> > @@ -2062,6 +2058,96 @@ static void es58x_init_priv(struct es58x_device *es58x_dev,
> >       can->do_set_mode = es58x_set_mode;
> >  }
> >
> > +/**
> > + * es58x_get_product_info() - Get the product information.
> > + * @es58x_dev: ES58X device.
> > + * @prod_info: Buffer where to store the product information.
> > + * @prod_info_len: Length of @prod_info.
> > + *
> > + * Do a synchronous call to get the product information.
> > + *
> > + * Return: zero on success, errno when any error occurs.
> > + */
> > +static int es58x_get_product_info(struct es58x_device *es58x_dev,
> > +                               char *prod_info, size_t prod_info_len)
> > +{
> > +     struct usb_device *udev = es58x_dev->udev;
> > +     const int es58x_prod_info_idx = 6;
> > +     int ret;
> > +
> > +     ret = usb_string(udev, es58x_prod_info_idx, prod_info, prod_info_len);
> > +     if (ret < 0) {
> > +             dev_err(es58x_dev->dev,
> > +                     "%s: Could not read the product info: %pe\n",
> > +                     __func__, ERR_PTR(ret));
> > +             return ret;
> > +     }
> > +     if (ret >= prod_info_len - 1) {
> > +             dev_warn(es58x_dev->dev,
> > +                      "%s: Buffer is too small, result might be truncated\n",
> > +                      __func__);
> > +     }
>
> You can use usb_cache_string() that puts the requested string into a
> kmalloc()ed buffer:
>
> | https://elixir.bootlin.com/linux/v6.0/source/drivers/usb/core/message.c#L1018
>
> ...and avoids having the large stack frame.

I saw that one a long time ago, before I started sending patches on
the mailing list, but couldn't use it because it is not
EXPORT_SYMBOL_GPLed. I was also too shy to send a patch to change
it...

I guess I will add the export and use it.

> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * es58x_print_product_info() - Print the product information.
> > + * @es58x_dev: ES58X device.
> > + *
> > + * Return: zero on success, errno when any error occurs.
> > + */
> > +static int es58x_print_product_info(struct es58x_device *es58x_dev)
> > +{
> > +     char prod_info[ES58X_USB_STRING_SIZE];
>
> Stack size in the kernel is limited.

'make checkstack' tels me:
  0x00000000000008300 es58x_get_drvinfo []:        448
  0x00000000000003ae0 es58x_print_product_info []:    448

My understanding is that anything under 512 is still acceptable. c.f.
  https://www.kernel.org/doc/html/v4.12/process/submit-checklist.html

Regardless, I agree that using usb_cache_string() is better.

> > +     int ret;
> > +
> > +     ret = es58x_get_product_info(es58x_dev, prod_info, sizeof(prod_info));
> > +     if (ret == 0)
> > +             dev_info(es58x_dev->dev, "Product info: %s\n", prod_info);
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * es58x_get_drvinfo() - Get the driver name and firmware version.
> > + * @netdev: CAN network device.
> > + * @drvinfo: Driver information.
> > + *
> > + * Populate @drvinfo with the driver name and the firwmware version.
> > + */
> > +static void es58x_get_drvinfo(struct net_device *netdev,
> > +                           struct ethtool_drvinfo *drvinfo)
> > +{
> > +     struct es58x_device *es58x_dev = es58x_priv(netdev)->es58x_dev;
> > +     char prod_info[ES58X_USB_STRING_SIZE];
> > +     char *start, *end;
> > +
> > +     strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> > +
> > +     if (es58x_get_product_info(es58x_dev, prod_info, sizeof(prod_info)) < 0)
> > +             return;
> > +
> > +     /* The firmware prefix is either "FW_V" or "FW:" */
> > +     start = strstr(prod_info, "FW");
> > +     if (!start)
> > +             return;
> > +     /* Go to first digit */
> > +     while (!isdigit(*start))
> > +             start++;
>
> Don't trust the input. Check for end of string before accessing it.

You are right. Now I feel ashamed of making this mistake.

> > +
> > +     end = strchr(start, es58x_dev->param->prod_info_delim);
> > +     if (!end || end - start >= sizeof(drvinfo->fw_version))
> > +             return;
> > +
> > +     strscpy(drvinfo->fw_version, start, end - start + 1);
>
> Are you misusing strscpy() here? The last parameter should be the size
> of the dest buffer, not the src buffer.

Indeed, the documentation clearly specifies that it should be the size
of the destination. I will use strncpy() instead. I already checked
that (end - start) is strictly smaller than the destination size above
so it will be fine.

Yours sincerely,
Vincent Mailhol
