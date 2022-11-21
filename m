Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84049631DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKUKQb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 05:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiKUKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:16:29 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5800831ECA;
        Mon, 21 Nov 2022 02:16:28 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id k4so7649664qkj.8;
        Mon, 21 Nov 2022 02:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AH7J2YAbJJnliv8tRtEf0xlMhNlRGV7PPaAW6p6F+x8=;
        b=iLW1NUG3h4ORAFxZ84wzc5LbPyJ6kpB9cPrZdF6eKlS2wNBOIkbzjBAPIN0QLn6x4C
         9mjjsjVrSLrf7XPczPicXBrU71xJlivC7Q55IY77y/LhQmAvmjuaXwiHvk3Tf0bFCv/E
         9/tK0zcm8sCVnpjIDGVO11Gdnvqu1eH745cl0leApnHvPoAIQhUvpx5/BRyeAMONOySJ
         Py2aokjIBYyIIYfW3Ga8x1ZvGZzjCdvn06+pYA6j3z8OnuZ50VaJKPhom6uuOICtMnVO
         6RENidr8dMoftJtMAbwCCphRBjuSPw4lY+r2C0hIsgLdZ1WXSuvFbnMUvoZwnXpbR8Ee
         gIiQ==
X-Gm-Message-State: ANoB5pkkDOz/SraxhFJXbjbNhoXq6W/jYnMIqNnR90C2a+16hmGpAvj6
        LVc+37VvKfRU/dfdKpHd08c+XIdul/TRdw==
X-Google-Smtp-Source: AA0mqf4EH63l2/yPwScD+AaqSL244ZfXdSlfGBBidsVgK56zipAgMRiiUFZXMw/lnFZeFr/3FTW59A==
X-Received: by 2002:a37:e20d:0:b0:6fa:8e8e:1ee5 with SMTP id g13-20020a37e20d000000b006fa8e8e1ee5mr15451922qki.45.1669025787304;
        Mon, 21 Nov 2022 02:16:27 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id s6-20020a05620a254600b006e07228ed53sm8094014qko.18.2022.11.21.02.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:16:26 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3704852322fso108795307b3.8;
        Mon, 21 Nov 2022 02:16:25 -0800 (PST)
X-Received: by 2002:a81:6cd2:0:b0:38d:5807:4b9b with SMTP id
 h201-20020a816cd2000000b0038d58074b9bmr6623722ywc.358.1669025785217; Mon, 21
 Nov 2022 02:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20221118145512.509950-1-gsomlo@gmail.com> <20221118145512.509950-11-gsomlo@gmail.com>
In-Reply-To: <20221118145512.509950-11-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Nov 2022 11:16:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVCc5xtnRoprtdgt_ZH42j=+ivS4aD+Uceg9pny-FpzYQ@mail.gmail.com>
Message-ID: <CAMuHMdVCc5xtnRoprtdgt_ZH42j=+ivS4aD+Uceg9pny-FpzYQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] serial: liteuart: separate rx loop from poll timer
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        ilpo.jarvinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Fri, Nov 18, 2022 at 3:57 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> Convert the rx loop into its own dedicated function, and (for now)
> call it from the poll timer. This is in preparation for adding irq
> support to the receive path.
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -68,10 +68,8 @@ static struct uart_driver liteuart_driver = {
>  #endif
>  };
>
> -static void liteuart_timer(struct timer_list *t)
> +static void liteuart_rx_chars(struct uart_port *port)

So first you spin this off into a separate function, so it can be
called from both the interrupt and polling paths.
Later, in "[PATCH v5 12/14] serial: liteuart: add IRQ support for the
RX path", you remove the call from the polling path...


>  {
> -       struct liteuart_port *uart = from_timer(uart, t, timer);
> -       struct uart_port *port = &uart->port;
>         unsigned char __iomem *membase = port->membase;
>         unsigned int status, ch;
>
> @@ -88,6 +86,14 @@ static void liteuart_timer(struct timer_list *t)
>         }
>
>         tty_flip_buffer_push(&port->state->port);
> +}
> +
> +static void liteuart_timer(struct timer_list *t)
> +{
> +       struct liteuart_port *uart = from_timer(uart, t, timer);
> +       struct uart_port *port = &uart->port;
> +
> +       liteuart_rx_chars(port);
>
>         mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
