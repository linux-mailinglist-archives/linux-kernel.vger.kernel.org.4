Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D336238AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiKJBKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiKJBKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:10:13 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306CE20BFD;
        Wed,  9 Nov 2022 17:10:13 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id cl5so209880wrb.9;
        Wed, 09 Nov 2022 17:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A4BVg09/STu01lFVH/5ornDK9lnhrRi6lMKaTSST7mY=;
        b=OhEWGto4w919H51dq8VGsWY55Xa5sr9ra83dNKq9q2PHuJcIFEWhdLeu6Nmx4IKD78
         Pm0tEh//QsSxYdx/YMpvM54JdmjGnRfhppWVD4SMnO+YrchiWc3RWQqQX1eu9LQyocMC
         ywOy7zEu+E3CKhDhExA6UERqCVDHff3e6nGEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4BVg09/STu01lFVH/5ornDK9lnhrRi6lMKaTSST7mY=;
        b=iKFVltQur3Ob9lATaxM+RgGQARNVDi8iOKIa9h3bw6eWMQG/QhzwCa15SCGD7xciqs
         KfY3fyH9QyVEmL2Jfghz10wT4hFGIA4Z6y1Ebwl9ZwscvVvaPHgElm6UZFuOZROLxOK/
         462oJkkTNTg6clW53uAoKfEQAkoum0D7xHrbiws3FlXzuWLX8JqbwrTO6S/CMwYvjUS/
         V4nlgeDBKKu9S+mzyHDIcVwEhOJLA8PjbKFYHArkEfMkd7qqL370LPx7+il0sClE5aEf
         8CoxKvF33sn5tHkGfHVcifxCRxglCc/fkepEtsWRSdageOb6qalFd19dwjyzIBkOVtjC
         fD9w==
X-Gm-Message-State: ACrzQf3TE9Agyoo6416PQXFLusD1b2QJJYcbQaMf8al1xfJqamZzi3Me
        UfmKIc7IgbFY1CElxeuId2w/e/PVUq56O5Z1+8w=
X-Google-Smtp-Source: AMsMyM5LJOzcN7OYnZGg612UrhCC2fvKXD8pGOmgi9F+cP+iuoy+x5uJoVYfQmIT+MwA0acViOgoEFVUNteGj4XfT8U=
X-Received: by 2002:a05:6000:1008:b0:236:60e8:3d40 with SMTP id
 a8-20020a056000100800b0023660e83d40mr39546819wrx.3.1668042611623; Wed, 09 Nov
 2022 17:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20221107171500.2537938-1-gsomlo@gmail.com> <20221107171500.2537938-3-gsomlo@gmail.com>
In-Reply-To: <20221107171500.2537938-3-gsomlo@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Nov 2022 01:09:59 +0000
Message-ID: <CACPK8XdGpGUispRcfgaVyE=18Wwg8GFHH7QJ6bcQLA5XDikSiQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] serial: liteuart: separate RX loop from poll timer
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
> Move the character-receive (RX) loop to its own dedicated function,
> and (for now) call that from the poll timer, liteuart_timer().
>
> This is in preparation for adding IRQ support to the receive path.
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 4b9cca249828..90a29ed79bff 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -69,29 +69,34 @@ static struct uart_driver liteuart_driver = {
>  #endif
>  };
>
> -static void liteuart_timer(struct timer_list *t)
> +static void liteuart_rx_chars(struct uart_port *port)
>  {
> -       struct liteuart_port *uart = from_timer(uart, t, timer);
> -       struct uart_port *port = &uart->port;
>         unsigned char __iomem *membase = port->membase;
> -       unsigned int flg = TTY_NORMAL;
> -       int ch;
> -       unsigned long status;
> +       unsigned int status;
> +       unsigned char ch;

u32, u8, void __iomem * would be better kernel types to use here.

You've also changed ch from a signed 32 to an unsigned 8.

>
>         while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
>                 ch = litex_read8(membase + OFF_RXTX);
>                 port->icount.rx++;
>
>                 /* necessary for RXEMPTY to refresh its value */
> -               litex_write8(membase + OFF_EV_PENDING, EV_TX | EV_RX);
> +               litex_write8(membase + OFF_EV_PENDING, EV_RX);

You're no longer clearing EV_TX, but don't mention why (I understand
why with the context of the other changes, so perhaps add something to
this commit message).


>
>                 /* no overflow bits in status */
>                 if (!(uart_handle_sysrq_char(port, ch)))
> -                       uart_insert_char(port, status, 0, ch, flg);
> -
> -               tty_flip_buffer_push(&port->state->port);
> +                       uart_insert_char(port, status, 0, ch, TTY_NORMAL);
>         }
>
> +       tty_flip_buffer_push(&port->state->port);
> +}
> +
> +static void liteuart_timer(struct timer_list *t)
> +{
> +       struct liteuart_port *uart = from_timer(uart, t, timer);
> +       struct uart_port *port = &uart->port;
> +
> +       liteuart_rx_chars(port);
> +
>         mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
>  }
>
> --
> 2.37.3
>
