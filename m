Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313746238A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiKJBJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiKJBJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:09:11 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C8C20BFD;
        Wed,  9 Nov 2022 17:09:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r203-20020a1c44d4000000b003cfa97c05cdso661247wma.4;
        Wed, 09 Nov 2022 17:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ebjudc0xk5NVXJxUYmSH20jr0/rLogM7OLpL8FGFnok=;
        b=TdvYTT8ti5iSInXJNnadweZQKvALgiKhWYvKe5miRwBgFzGToG3kRZNeY0RX7B/vLz
         aqn1i908HzNiV8EAebHxaIps2YxXwdcz6iZviXESJWaQ7ajVIZ1sk2z2tEpx+lfH8HLw
         sdkVm8q1MPqwr3xCHcMsfy56HEXtGLmBw0Q/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ebjudc0xk5NVXJxUYmSH20jr0/rLogM7OLpL8FGFnok=;
        b=idabos/XC8zNpJFBumsVTclqYCTUfOTH5N8+8ziOBfeftaVdo8nxh/dYhFENqmLtDf
         kIlrCQcgK/KysL5fPOskSChcTGCusB/8jf8Av4NOlYJVYf8CzA7wKIo04RkYCbJ1EcB/
         YK5NILjFJRO3GFXxc9pVaFVB8gWsYCF75uv//Supmy4b20ZGcSvASb5QqzZuSwVyvKo/
         UKT8aGQStUzzyh2FZwdRljBZodktlnHPexOxQ+a5FXDTQm0MWRL1ZB8pccoUElO6bFEI
         /dUm09wWL68unwYVb1VTuNIGBN4Oqyht8lQqyOCMm0++8ks6kzfSpvsITyVZ5QyEqrnN
         mZSw==
X-Gm-Message-State: ACrzQf0bLkTQbJIxiL+SluLlFBCZt9rbdOAANZgC4oI7rN0FSY5wXKN6
        E8nlodzHEshdh/AntTgE/15xdy2joAomypi5g7U=
X-Google-Smtp-Source: AMsMyM76abUfA7ojnGGQAW6z7R4YqdD9zfvbEnHcFpwKcPeNaBowhQVABnv9R6b964QNEzs61VVLBNSmZb1SHiweICE=
X-Received: by 2002:a05:600c:a46:b0:3b9:9b97:9304 with SMTP id
 c6-20020a05600c0a4600b003b99b979304mr41636762wmq.34.1668042546700; Wed, 09
 Nov 2022 17:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20221107171500.2537938-1-gsomlo@gmail.com> <20221107171500.2537938-4-gsomlo@gmail.com>
In-Reply-To: <20221107171500.2537938-4-gsomlo@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Nov 2022 01:08:55 +0000
Message-ID: <CACPK8XePY_nYo5OduxOAdAyUqtXju+9vAb+iXZqi6rmvR7Fp=Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] serial: liteuart: add IRQ support
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 at 17:15, Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> Add support for IRQ-driven RX. The TX path remains "polling" based,
> which is fine since TX is synchronous.
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 65 +++++++++++++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 90a29ed79bff..47ce3ecc50f2 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/console.h>
> +#include <linux/interrupt.h>
>  #include <linux/litex.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -90,13 +91,27 @@ static void liteuart_rx_chars(struct uart_port *port)
>         tty_flip_buffer_push(&port->state->port);
>  }
>
> +static irqreturn_t liteuart_interrupt(int irq, void *data)
> +{
> +       struct uart_port *port = data;
> +       unsigned int isr;
> +
> +       isr = litex_read32(port->membase + OFF_EV_PENDING);
> +
> +       spin_lock(&port->lock);
> +       if (isr & EV_RX)
> +               liteuart_rx_chars(port);
> +       spin_unlock(&port->lock);
> +
> +       return IRQ_RETVAL(isr);

I don't follow this. If you've handled the RX IRQ, you want to return
IRQ_HANDLED. And if it's a different bit set you haven't handled it.

> +}
> +
>  static void liteuart_timer(struct timer_list *t)
>  {
>         struct liteuart_port *uart = from_timer(uart, t, timer);
>         struct uart_port *port = &uart->port;
>
> -       liteuart_rx_chars(port);
> -
> +       liteuart_interrupt(0, port);
>         mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
>  }
>
> @@ -165,19 +180,48 @@ static void liteuart_stop_rx(struct uart_port *port)
>  static int liteuart_startup(struct uart_port *port)
>  {
>         struct liteuart_port *uart = to_liteuart_port(port);
> +       unsigned long flags;
> +       int ret;
> +       u8 irq_mask = 0;
>
> -       /* disable events */
> -       litex_write8(port->membase + OFF_EV_ENABLE, 0);
> +       if (port->irq) {
> +               ret = request_irq(port->irq, liteuart_interrupt, 0,
> +                                 DRV_NAME, port);
> +               if (ret == 0) {
> +                       /* we only need interrupts on the rx path! */

Why not use the tx interrupts too?

> +                       irq_mask = EV_RX;
> +               } else {
> +                       pr_err(DRV_NAME ": can't attach LiteUART %d irq=%d; "
> +                              "switching to polling\n", port->line, port->irq);

put the string on the one line so it's grepable.

Take a look a the help for pr_fmt in include/linux/printk.h. This way
you get the driver name prefix for all pr_ messages.

> +                       port->irq = 0;
> +               }
> +       }
>
> -       /* prepare timer for polling */
> -       timer_setup(&uart->timer, liteuart_timer, 0);
> -       mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> +       if (!port->irq) {
> +               timer_setup(&uart->timer, liteuart_timer, 0);
> +               mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> +       }
> +
> +       spin_lock_irqsave(&port->lock, flags);

Are you sure we need to take a lock and disable interrupts here?

> +       litex_write8(port->membase + OFF_EV_ENABLE, irq_mask);
> +       spin_unlock_irqrestore(&port->lock, flags);
>
>         return 0;
>  }
>
>  static void liteuart_shutdown(struct uart_port *port)
>  {
> +       struct liteuart_port *uart = to_liteuart_port(port);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&port->lock, flags);

same as above. I think the reason for doing this might have been if
you had a set of registers to change inside the critical section that
you needed to appear atomic. But this hardware only has one register
to flip, so we can do without the locking.

> +       litex_write8(port->membase + OFF_EV_ENABLE, 0);
> +       spin_unlock_irqrestore(&port->lock, flags);
> +
> +       if (port->irq)
> +               free_irq(port->irq, port);
> +       else
> +               del_timer_sync(&uart->timer);
>  }
>
>  static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
> @@ -266,6 +310,13 @@ static int liteuart_probe(struct platform_device *pdev)
>                 goto err_erase_id;
>         }
>
> +       /* get irq */
> +       ret = platform_get_irq_optional(pdev, 0);
> +       if (ret < 0 && ret != -ENXIO)
> +               return ret;
> +       if (ret > 0)
> +               port->irq = ret;
> +
>         /* values not from device tree */
>         port->dev = &pdev->dev;
>         port->iotype = UPIO_MEM;
> --
> 2.37.3
>
