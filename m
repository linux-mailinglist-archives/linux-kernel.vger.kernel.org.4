Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25F5ED55F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiI1Gub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiI1Gt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:49:56 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E729F76E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:48:24 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id j8so7580361qvt.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qFJHGEbZ35EQDLsi52pANjw4oP+JX7MHEHKnoJo4Bm4=;
        b=ZP9Jeq6ih3GNj5gTwbjg0JGj6LULNjEaXBEVqkAbJOIOF9AQgjVeWPmbCRT1VXuyPY
         w730x3fU6/iCdzPZd6oVxzmLkFGzTblK2KHUWR4rdZcBk41P3Lcr+nWGZZtJpD9vIlEp
         z4d9pg1mb1EhLy/yU2K46YCC1V1FX3SnQLYbGUyPjFr0sP3BR4KePwT2dUibYejQJiJb
         R9q+CpuMCzhiLoiwVi2IehLpypfOeJegXSGxbC2JQ8Czs3sKyyfnn7dGjo77uBMt7DZO
         gxk/Jl3xu24JbQustygzMgQ2N3zN3IW1tdRgSYuXuUMCwYK0pFfwcBAtG1iuttCX5wGK
         47Bw==
X-Gm-Message-State: ACrzQf2XbQFkuH+BuxvgZ7ZaAKbfRnY8nmbZ7++Y2i5Xhb6D139InOxf
        sxRRpbxRVABHGFSKMIekAw7keVEYGpZi6Q==
X-Google-Smtp-Source: AMsMyM6UVLykFOWyREa/2G+0WQg4rfoOX3REeRdfPBYZhtfItmv2TycR8AKE2OIPqwxGoY7hnq6brw==
X-Received: by 2002:a0c:dd94:0:b0:4ad:4f0e:d660 with SMTP id v20-20020a0cdd94000000b004ad4f0ed660mr24103054qvk.118.1664347702591;
        Tue, 27 Sep 2022 23:48:22 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id i10-20020ac8764a000000b0035cdd7a42d0sm2451819qtr.22.2022.09.27.23.48.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 23:48:22 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id f189so14800756yba.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:48:21 -0700 (PDT)
X-Received: by 2002:a05:6902:45:b0:6ae:ce15:a08d with SMTP id
 m5-20020a056902004500b006aece15a08dmr28676369ybh.380.1664347701498; Tue, 27
 Sep 2022 23:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220818145616.3156379-1-arnd@kernel.org> <20220818145616.3156379-6-arnd@kernel.org>
 <CAMuHMdVL8TZ8vfdQT_9DA=JLX3O7YrP0v9AK87ALjmsvryZptw@mail.gmail.com> <0c368c7d-3130-46e6-8185-7270f58161a3@www.fastmail.com>
In-Reply-To: <0c368c7d-3130-46e6-8185-7270f58161a3@www.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Sep 2022 08:48:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWR61CJJ-J==3S6x9MX-i1maaJbjG5jS=vo6h_4Sr-45Q@mail.gmail.com>
Message-ID: <CAMuHMdWR61CJJ-J==3S6x9MX-i1maaJbjG5jS=vo6h_4Sr-45Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: make ARCH_MULTIPLATFORM user-visible
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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

Hi Arnd,

On Tue, Sep 27, 2022 at 10:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Sep 27, 2022, at 3:31 PM, Geert Uytterhoeven wrote:
> > On Thu, Aug 18, 2022 at 4:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >> --- a/arch/arm/Kconfig.debug
> >> +++ b/arch/arm/Kconfig.debug
> >> @@ -1904,6 +1904,7 @@ config DEBUG_UART_8250_PALMCHIP
> >>
> >>  config DEBUG_UNCOMPRESS
> >>         bool "Enable decompressor debugging via DEBUG_LL output"
> >> +       depends on !ARCH_MULTIPLATFORM
> >
> > Shouldn't DEBUG_LL itself depend on !ARCH_MULTIPLATFORM instead?
>
> That would also be possible, but I prefer to keep limiting only
> the DEBUG_UNCOMPRESS. The idea of DEBUG_LL is that while it's
> hardwired to a particular hardware address, it does not actually
> access this address unless you specify the 'earlyprintk'
> argument on the command line.

... or unless something goes really wrong, and the kernel tries to
inform the user using early_print()?

Note that the I/O region for the debug serial port is mapped regardless.
Any chance this can cause conflicts?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
