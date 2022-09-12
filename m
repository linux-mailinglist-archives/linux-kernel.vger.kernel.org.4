Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5EB5B5BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiILOFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiILOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:05:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BC31D0DC;
        Mon, 12 Sep 2022 07:05:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16D55611DE;
        Mon, 12 Sep 2022 14:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5DDC433C1;
        Mon, 12 Sep 2022 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662991515;
        bh=3aWjrgOM+tw/gSgzjaITIjqDMzYsveoZMHJ7NWF5AxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vNBwjp/i90vMIZLytHqYzaGD+wKWDYciVhHyb4dhfxvHt26N4r6wetVbKa+oKV2OS
         1YFYjONDjqCgya8x0u7pQZ2bS85t8CjQeLt3I4ve8XJpkvs5UwjwXedve+ieO0fusq
         KNaeNgWGdHKhVL9WobpC86g8PJDCvXd2lOjXLx3Q=
Date:   Mon, 12 Sep 2022 16:05:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] USB: serial: ftdi_sio: remove the unneeded
 result variable
Message-ID: <Yx88s4TwEEt6luPY@kroah.com>
References: <20220912133826.18517-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912133826.18517-1-xu.panda@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 01:38:27PM +0000, cgel.zte@gmail.com wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> Return the value usb_control_msg() directly instead of storing
> it in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---
>  drivers/usb/serial/ftdi_sio.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index 0a1da579ead5..f02dcef69cb9 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -1394,7 +1394,6 @@ static int change_speed(struct tty_struct *tty, struct usb_serial_port *port)
>         u16 value;
>         u16 index;
>         u32 index_value;
> -       int rv;
> 
>         index_value = get_ftdi_divisor(tty, port);
>         value = (u16)index_value;
> @@ -1407,13 +1406,12 @@ static int change_speed(struct tty_struct *tty, struct usb_serial_port *port)
>                 index = (u16)((index << 8) | priv->interface);
>         }
> 
> -       rv = usb_control_msg(port->serial->dev,
> -                           usb_sndctrlpipe(port->serial->dev, 0),
> -                           FTDI_SIO_SET_BAUDRATE_REQUEST,
> -                           FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE,
> -                           value, index,
> -                           NULL, 0, WDR_SHORT_TIMEOUT);
> -       return rv;
> +       return usb_control_msg(port->serial->dev,
> +                              usb_sndctrlpipe(port->serial->dev, 0),
> +                              FTDI_SIO_SET_BAUDRATE_REQUEST,
> +                              FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE,
> +                              value, index,
> +                              NULL, 0, WDR_SHORT_TIMEOUT);
>  }

That's really not the correct use of the return value of
usb_control_msg().  Can you fix this up to properly handle the return
value, or better yet, use the usb_control_msg_send() call?

thanks,

greg k-h
