Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFB2620B91
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiKHIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiKHIxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:53:44 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623AC2E6B1;
        Tue,  8 Nov 2022 00:53:43 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id fz10so8320076qtb.3;
        Tue, 08 Nov 2022 00:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMUrTGbsuJBSNskypqc+l16xSCENjcN6xWIa6z6rntY=;
        b=1KfjDWT0uq6bdoX96LCib9Lnc4qVlUNpdog0kTSOiPg9EOkfKwwlwc9yoXkLG1CTvx
         Dax4mkNCvQAPqQjdAXOsVNH4BlIdKyr7cU2rwtDRMVTtv+BveVgx61QfX7blfjmGtP7I
         pVkn8SK9BeCKXPSH3QNmzSkVUAmYP5EIKxcxdxVUdC+0wl6z3DtSsKFassUcrSrzpfk4
         lGUlLpYWIfyI/Pl3do6Ex0w15MSkKWJm/nF5n7RYqAVQAauqNwNSm0qxlc4lM+FXQLaE
         8RxWdhwtGhtqUbKi3DsmdRqtDK5zXquwlbIyxl38QMkwlSlmCHLdEL1GhHXyyXJisBiu
         1OsA==
X-Gm-Message-State: ACrzQf3TYtgSzd5t4A+lmGYz8qv/Qz6uS6s5gWF8vQ1OLITHYGRrUbJX
        M6nM6qjrruWlcXTvMco8xKHDW6ufELINtPzC
X-Google-Smtp-Source: AMsMyM6zdhrGeW2yrJuK1+2Y3Wi9nIWwdegxGARtcMMB3b2UdZwNOW2l5Wu42LH8b4/kTBRrubASOA==
X-Received: by 2002:ac8:5ad1:0:b0:3a4:ffff:8c59 with SMTP id d17-20020ac85ad1000000b003a4ffff8c59mr41644037qtd.57.1667897622314;
        Tue, 08 Nov 2022 00:53:42 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id w10-20020ac843ca000000b003a4f2510e5dsm7706488qtn.24.2022.11.08.00.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 00:53:41 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-36ad4cf9132so127693027b3.6;
        Tue, 08 Nov 2022 00:53:41 -0800 (PST)
X-Received: by 2002:a0d:e301:0:b0:374:a8ba:99b0 with SMTP id
 m1-20020a0de301000000b00374a8ba99b0mr6095905ywe.358.1667897620819; Tue, 08
 Nov 2022 00:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20221107141638.3790965-1-john.ogness@linutronix.de> <20221107141638.3790965-41-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-41-john.ogness@linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 09:53:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXZnTaxbezvH=NBz7tbBgiXjj6H5YGv88tVHtYLFxKuag@mail.gmail.com>
Message-ID: <CAMuHMdXZnTaxbezvH=NBz7tbBgiXjj6H5YGv88tVHtYLFxKuag@mail.gmail.com>
Subject: Re: [PATCH printk v3 40/40] tty: serial: sh-sci: use setup() callback
 for early console
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

CC linux-sh (SH-specific code)
CC linux-renesas-soc (JFYI)

On Mon, Nov 7, 2022 at 3:20 PM John Ogness <john.ogness@linutronix.de> wrote:
> When setting up the early console, the setup() callback of the
> regular console is used. It is called manually before registering
> the early console instead of providing a setup() callback for the
> early console. This is probably because the early setup needs a
> different @options during the early stage.
>
> The issue here is that the setup() callback is called without the
> console_list_lock held and functions such as uart_set_options()
> expect that.
>
> Rather than manually calling the setup() function before registering,
> provide an early console setup() callback that will use the different
> early options. This ensures that the error checking, ordering, and
> locking context when setting up the early console are correct.
>
> Note that technically the current implementation works because it is
> only used in early boot. And since the early console setup is
> performed before registering, it cannot race with anything and thus
> does not need any locking. However, longterm maintenance is easier
> when drivers rely on the subsystem API rather than manually
> implementing steps that could cause breakage in the future.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3054,15 +3054,26 @@ static struct console serial_console = {
>  };
>
>  #ifdef CONFIG_SUPERH
> +static char early_serial_buf[32];
> +
> +static int early_serial_console_setup(struct console *co, char *options)
> +{
> +       WARN_ON(options);
> +       /*
> +        * Use @early_serial_buf because @options will always be
> +        * NULL at this early stage.
> +        */
> +       return serial_console_setup(co, early_serial_buf);
> +}
> +
>  static struct console early_serial_console = {
>         .name           = "early_ttySC",
>         .write          = serial_console_write,
> +       .setup          = early_serial_console_setup,
>         .flags          = CON_PRINTBUFFER,
>         .index          = -1,
>  };
>
> -static char early_serial_buf[32];
> -
>  static int sci_probe_earlyprintk(struct platform_device *pdev)
>  {
>         const struct plat_sci_port *cfg = dev_get_platdata(&pdev->dev);
> @@ -3074,8 +3085,6 @@ static int sci_probe_earlyprintk(struct platform_device *pdev)
>
>         sci_init_single(pdev, &sci_ports[pdev->id], pdev->id, cfg, true);
>
> -       serial_console_setup(&early_serial_console, early_serial_buf);
> -
>         if (!strstr(early_serial_buf, "keep"))
>                 early_serial_console.flags |= CON_BOOT;
>
> --
> 2.30.2

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
