Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4171B640C1A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiLBRYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiLBRYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:24:33 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B341183D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:24:32 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id b2so3470478iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ofFR/mVCsDKZj44lDEy/8k5d1m69ZQ2boKHQlr/3NdY=;
        b=NteYCFzY9P/RDwVHhhAOK1Uw483SNoVV17UFJtHDLJLYGlp3mGvBAvsBoUffOclc+M
         q5BSW5wje1nc5AdNtDN+njEC+3gXB/ZKqDonnXMFu5Nra059pO6/Cj3uI24f6cEXaAYp
         wvEqg8R+oeVO1abR93kTH6Kk/WRAgiCrjxOAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofFR/mVCsDKZj44lDEy/8k5d1m69ZQ2boKHQlr/3NdY=;
        b=EEwzNvGiEXV/dUufQDMqQNVffzUurYMCDkM/whzelN/Is4H/biXkNTlAJgJVS6waJ5
         ArVqPoWzhggxVG4x+rwNiH1DhxZteObttwTv9b8wI8sa62Nfnqz/5JEFyAyqDoHM3/wJ
         C/RWJpc86MNADq3CvquMtlFfftKD2Qss2zn1NVERtadTHW4SIAY26j2ye//FjT6p0mhO
         P+FOSFFHpxjwwg9aqaEs4NC4/nZvbU9mkfumTlSnlShdOP9aQkcSnsHdNmcb2LhpZ6Ka
         0zt+tDZxEKFvFuys64WTUIv+AL4DFawuEO8vkBcO/9Xc2Y/zuECvMG/ecTV2bVUhWECq
         GAVA==
X-Gm-Message-State: ANoB5plbmqs8TbPnIr3PuJbU9tWgHiaHXcY8sSrL0h5NGhOBR8Ou7N1Z
        TJqbEGCiXHiuAyA5SktCf+ZPaUjHXFTrBEwTpeI=
X-Google-Smtp-Source: AA0mqf4L9R9J3j4rYuwN/L2A04VKr1x0vQXOqQDcdZ7m/yiLWVhs795LR0vRcuRlbq7erSDxqiy4og==
X-Received: by 2002:a05:6638:3387:b0:375:3be7:2908 with SMTP id h7-20020a056638338700b003753be72908mr34791700jav.275.1670001871679;
        Fri, 02 Dec 2022 09:24:31 -0800 (PST)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id c1-20020a92c8c1000000b00302e09e0bb2sm2582311ilq.50.2022.12.02.09.24.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 09:24:30 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id h184so3351660iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:24:30 -0800 (PST)
X-Received: by 2002:a5e:c64a:0:b0:6cc:e295:7bde with SMTP id
 s10-20020a5ec64a000000b006cce2957bdemr24816919ioo.183.1670001870306; Fri, 02
 Dec 2022 09:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20221123-serial-clk-v3-0-49c516980ae0@chromium.org> <20221123-serial-clk-v3-1-49c516980ae0@chromium.org>
In-Reply-To: <20221123-serial-clk-v3-1-49c516980ae0@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 2 Dec 2022 18:24:19 +0100
X-Gmail-Original-Message-ID: <CANiDSCs-CdhdvZF1PsDWivWiTB-=66DK4XOrv5hzbgbC9Z=+Rg@mail.gmail.com>
Message-ID: <CANiDSCs-CdhdvZF1PsDWivWiTB-=66DK4XOrv5hzbgbC9Z=+Rg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] earlycon: Let users set the clock frequency
To:     Jonathan Corbet <corbet@lwn.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri

is there something else that I am missing here?

Thanks!

On Thu, 24 Nov 2022 at 13:39, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Some platforms, namely AMD Picasso, use non standard uart clocks (48M),
> witch makes it impossible to use with earlycon.
>
> Let the user select its own frequency.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a465d5242774..9efb6c3b0486 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1182,10 +1182,10 @@
>                         specified, the serial port must already be setup and
>                         configured.
>
> -               uart[8250],io,<addr>[,options]
> -               uart[8250],mmio,<addr>[,options]
> -               uart[8250],mmio32,<addr>[,options]
> -               uart[8250],mmio32be,<addr>[,options]
> +               uart[8250],io,<addr>[,options[,uartclk]]
> +               uart[8250],mmio,<addr>[,options[,uartclk]]
> +               uart[8250],mmio32,<addr>[,options[,uartclk]]
> +               uart[8250],mmio32be,<addr>[,options[,uartclk]]
>                 uart[8250],0x<addr>[,options]
>                         Start an early, polled-mode console on the 8250/16550
>                         UART at the specified I/O port or MMIO address.
> @@ -1194,7 +1194,9 @@
>                         If none of [io|mmio|mmio32|mmio32be], <addr> is assumed
>                         to be equivalent to 'mmio'. 'options' are specified
>                         in the same format described for "console=ttyS<n>"; if
> -                       unspecified, the h/w is not initialized.
> +                       unspecified, the h/w is not initialized. 'uartclk' is
> +                       the uart clock frequency; if unspecified, it is set
> +                       to 'BASE_BAUD' * 16.
>
>                 pl011,<addr>
>                 pl011,mmio32,<addr>
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index a5f380584cda..3a0c88419b6c 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -120,7 +120,13 @@ static int __init parse_options(struct earlycon_device *device, char *options)
>         }
>
>         if (options) {
> +               char *uartclk;
> +
>                 device->baud = simple_strtoul(options, NULL, 0);
> +               uartclk = strchr(options, ',');
> +               if (uartclk && kstrtouint(uartclk + 1, 0, &port->uartclk) < 0)
> +                       pr_warn("[%s] unsupported earlycon uart clkrate option\n",
> +                               options);
>                 length = min(strcspn(options, " ") + 1,
>                              (size_t)(sizeof(device->options)));
>                 strscpy(device->options, options, length);
> @@ -139,7 +145,8 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
>                 buf = NULL;
>
>         spin_lock_init(&port->lock);
> -       port->uartclk = BASE_BAUD * 16;
> +       if (!port->uartclk)
> +               port->uartclk = BASE_BAUD * 16;
>         if (port->mapbase)
>                 port->membase = earlycon_map(port->mapbase, 64);
>
>
> --
> b4 0.11.0-dev-d93f8



-- 
Ricardo Ribalda
