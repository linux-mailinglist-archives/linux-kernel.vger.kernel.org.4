Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EFA620B75
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiKHIqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiKHIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:46:35 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F886328;
        Tue,  8 Nov 2022 00:46:35 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id g10so8697775qkl.6;
        Tue, 08 Nov 2022 00:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFaOixIsnZB6xQs+v+v1PC0UnPOGoBPbA99XLP2d//4=;
        b=r1BvGxGhsEKJ0CtZAyIY3Oklp5eBfkr221XBOxriBIAaTtpe02QtuPCCAdqKVdAZ53
         yWTPljVS235e7FYabNmxgpMiD0NbcEtrqPafqan7LVg3S49iOrpVEeacglhPZI1/3rHT
         VgHw7Yup/AfiPMromzkHAyl+V2DQPIGYRO/qOnIlSpPzMH9ijHCegI3dh2f98na+v6tV
         D7C5S/vI05Sjvj2KVIW3+VJDpKAeZWPZDQEF7tpaGYyO8xZqvllF1My5ogXU3DX9tDIw
         TJCDbPx+nxca960kKbmOWbL6oy+QLwXuESG9YVbGofoGiNxP/5VrOtlzAP/dyyc7+Lpx
         nzcg==
X-Gm-Message-State: ANoB5pmjsBapCdT5WEBOh8xpqur8gIJmVoCvKIBnjElbbO/OBTfZCs9T
        UDAGYO62p5Q5+lFe6zKgQmIARlWQvQf347rV
X-Google-Smtp-Source: AA0mqf7JVMnD9YVCtiPej7HiTR2ho/IJ0963D9akB9Oxol1Lnn4D0t/2KVeYaN8+aiT1QO+t2L0Cag==
X-Received: by 2002:ae9:f008:0:b0:6fa:d7db:72b4 with SMTP id l8-20020ae9f008000000b006fad7db72b4mr6818918qkg.473.1667897194205;
        Tue, 08 Nov 2022 00:46:34 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a084c00b006fa4cefccd6sm8643966qku.13.2022.11.08.00.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 00:46:32 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 131so12189162ybl.3;
        Tue, 08 Nov 2022 00:46:31 -0800 (PST)
X-Received: by 2002:a05:6902:503:b0:6cf:c510:6a23 with SMTP id
 x3-20020a056902050300b006cfc5106a23mr34694308ybs.380.1667897191488; Tue, 08
 Nov 2022 00:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20221107141638.3790965-1-john.ogness@linutronix.de> <20221107141638.3790965-24-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-24-john.ogness@linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 09:46:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXuBh1PznFggpwSanBtHu9=ngJkVCRzdZVnjxWs2+cbxw@mail.gmail.com>
Message-ID: <CAMuHMdXuBh1PznFggpwSanBtHu9=ngJkVCRzdZVnjxWs2+cbxw@mail.gmail.com>
Subject: Re: [PATCH printk v3 23/40] serial_core: replace uart_console_enabled()
 with uart_console_registered()
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tony Lindgren <tony@atomide.com>,
        Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Mon, Nov 7, 2022 at 3:16 PM John Ogness <john.ogness@linutronix.de> wrote:
> All users of uart_console_enabled() really want to know if a console
> is registered. It is not reliable to check for CON_ENABLED in order
> to identify if a console is registered. Use console_is_registered()
> instead.
>
> A _locked() variant is provided because uart_set_options() is always
> called with the console_list_lock held and must check if a console
> is registered in order to synchronize with kgdboc.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -743,9 +743,20 @@ static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;
>  static inline int setup_earlycon(char *buf) { return 0; }
>  #endif
>
> -static inline bool uart_console_enabled(struct uart_port *port)
> +/* Variant of uart_console_registered() when the console_list_lock is held. */
> +static inline bool uart_console_registered_locked(struct uart_port *port)
>  {
> -       return uart_console(port) && (port->cons->flags & CON_ENABLED);
> +       return uart_console(port) && console_is_registered_locked(port->cons);
> +}
> +
> +static inline bool uart_console_registered(struct uart_port *port)
> +{
> +       bool ret;
> +
> +       console_list_lock();
> +       ret = uart_console_registered_locked(port);
> +       console_list_unlock();
> +       return ret;

Perhaps

    return uart_console(port) && console_is_registered();

to avoid locking the list when the first condition is not true?

>  }


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
