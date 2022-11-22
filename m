Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF1263391D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiKVJzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiKVJy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:54:59 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D659B19003;
        Tue, 22 Nov 2022 01:54:58 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id 8so9868820qka.1;
        Tue, 22 Nov 2022 01:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wn85hJe4YJD3JoALwodoe0B1HoCXIOwjbx5dJ3CB4vM=;
        b=3dzhIeWO7X2M96j0MZrTCKTWwMYZmqe+5mL/ggxLbZyIjcJ5Ip96NKM5nIlgMvaopj
         szYZtTx8O+gPB0yLXTLi/6HojfCTa4y5fDJt5LtqvqDJFSkXeYq7sMm0VXqzOrZPmh20
         yzK1Wb30z6Eakmep/1VwJ5uBMrYwoKpsXa0QuwTGAe7GiWGuY5HEZZBlESqcUcz57ZPy
         ua0aQmixn5qjX6wMVH1Rz1ONKf+8vrqrzLI9Tbf9yulBaVwl87xsislmhmtXQgK8pvdZ
         7EciwTsLO8ZtBCE1QY10g8AZT67DLRpaOjuvDy3G7Oz9uHpaqM6syIuO+sRE95o5+ac7
         J87w==
X-Gm-Message-State: ANoB5pmuCgZL6EnHs0t1BuQ4RIcj5zxECdUmU2rSe4dL31IRP5pTUDBR
        Z2SW4Lt6Yua7WW3ubI2g4BirpAV6o1VEUQ==
X-Google-Smtp-Source: AA0mqf5yq9cgv2D+lkgzq0eLjdk/cgP0h8W7urXDuXSABNN9b90M2p4DxRgwTf9Ig9hLbgCcc4f1mw==
X-Received: by 2002:a37:aa51:0:b0:6ee:f54d:e17 with SMTP id t78-20020a37aa51000000b006eef54d0e17mr8318619qke.63.1669110897586;
        Tue, 22 Nov 2022 01:54:57 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id k1-20020a05620a414100b006eea4b5abcesm9853516qko.89.2022.11.22.01.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 01:54:57 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3876f88d320so139287337b3.6;
        Tue, 22 Nov 2022 01:54:56 -0800 (PST)
X-Received: by 2002:a05:690c:b81:b0:37e:6806:a5f9 with SMTP id
 ck1-20020a05690c0b8100b0037e6806a5f9mr5601587ywb.47.1669110896451; Tue, 22
 Nov 2022 01:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20221118145512.509950-1-gsomlo@gmail.com> <20221118145512.509950-13-gsomlo@gmail.com>
 <abb7d87a-46c7-fe7f-f943-4287d15a537f@kernel.org> <Y3vIi2OF5t4IrCS1@errol.ini.cmu.edu>
 <8dd90e39-087e-984c-c289-dbfa766359a8@kernel.org>
In-Reply-To: <8dd90e39-087e-984c-c289-dbfa766359a8@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Nov 2022 10:54:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV3_YhF454J3ixRjOgWzJhL_Qr_XqxtSqxjF0qxGotFQw@mail.gmail.com>
Message-ID: <CAMuHMdV3_YhF454J3ixRjOgWzJhL_Qr_XqxtSqxjF0qxGotFQw@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] serial: liteuart: add IRQ support for the RX path
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     "Gabriel L. Somlo" <gsomlo@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        ilpo.jarvinen@linux.intel.com
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

On Tue, Nov 22, 2022 at 8:44 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> On 21. 11. 22, 19:50, Gabriel L. Somlo wrote:
> >>>    static void liteuart_timer(struct timer_list *t)
> >>>    {
> >>>     struct liteuart_port *uart = from_timer(uart, t, timer);
> >>>     struct uart_port *port = &uart->port;
> >>> -   liteuart_rx_chars(port);
> >>> -
> >>> +   liteuart_interrupt(0, port);
> >>
> >> Are you sure spin_lock() is safe from this path? I assume so, but have you
> >> thought about it?
> >
> > I checked and at that point `in_serving_softirq()` is true.
> >
> > *However*, after studying spin_lock() and friends for a while, I'm
> > not quite clear on whether that unequivocally translates
> > to "yes, we're safe" :)
>
> Depends whether some hard irq context is grabbing the port lock too. If
> it does, it will spin forever waiting for this soft irq to finish (never
> happens as it was interrupted).
>
> > As such, I'm inclined to switch to `spin_lock_irqsave()` and
> > `spin_unlock_irqrestore()` even in the interrupt handler, which is
> > explicitly stated to be "safe from any context":
> > https://www.kernel.org/doc/html/v4.15/kernel-hacking/locking.html#cheat-sheet-for-locking
>
>
>
> > The alternative could be to set `TIMER_IRQSAFE` in `timer_setup()`,
> > but no other tty driver seems to be doing that, so I'd be a bit off
> > the beaten path there... :)
>
> Ah, no.
>
> > Please do let me know what you think about this, particularly if you
> > consider going the spin_lock_irqsave-everywhere-just-to-be-safe route
> > overkill... :)
>
> If you are unsure about the other contexts, irqsave/restore is the way
> to go. It can be lifted later, if someone investigates harder.

Inside the interrupt handler, plain spin_lock() should be OK.
Inside the timer handler, I think you need to use spin_lock_irqsave(),
as e.g. liteuart_set_termios() (and lots of code in serial_core.c)
already uses spin_lock_irqsave().
Besides, on non-SMP, spin_lock() doesn't do anything, so you need
to rely on disabling the local interrupt.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
