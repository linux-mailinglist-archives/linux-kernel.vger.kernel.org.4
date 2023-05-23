Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FE470D71E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjEWIS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjEWISM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:18:12 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283C2E5D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:16:07 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-456d241fcdcso1904658e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684829766; x=1687421766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekkX5ovoO1DzJHorTtfGF/BFqQaZlWm6jALsPFR/4AA=;
        b=e9R6QFUt8iG4VMgXDNLKpBFcZWuvpjp8djRXoItHJYGP9mbhrfLBweV3gxtM8JcVC/
         2I1MbkIiIY2DoxsigjupTNGZJ6jq1gC5LWd7XJthhipFE9b1NTLi0nXkO4oyMPJWslUd
         R+43UM2TydbecRvpGyeDxsJRtURNcjwwdXxTl0AYHNf2zAbM202PEF/TZy1xoyWzpiJK
         Bm7ELQzbbzEcWAJ6JvW+GaJ9x2gdplkbuxndVNpNypYlMODVZIyBOtzxs7hmm22HwLCZ
         TEaPmcNLWcHYTJAoM7lShNgU2yZ1vDL36m+22YE58HanHBziQIrs3ce0JiYm9fdNuopb
         HkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684829766; x=1687421766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekkX5ovoO1DzJHorTtfGF/BFqQaZlWm6jALsPFR/4AA=;
        b=lItP/kIGoYy7Q6z9yMi+fkLI9wsNA6qmcYXxjlhFptbAIzK88cxTQJz/jwmXbvlAUX
         ON6bEs4l6Sy2nlrZwvRe+QDqCYQ+CanfAVwQoU+muziX8edxfZ9orjmxTsD+7KKJpaPf
         UD32hYv/RyLM7r6Nnk/WAvzZhpf+bS0KL8mFAXl/4XabHfiPH9xZZr92Flezxqka5vb+
         Z0+O06xFzEVcpl1SY6VNjwr71YC8FQ5CqX8RFyfAiXJ21XMArng971q87CDZrjnLL/JY
         bd/pPGvZGPNtPvj5V+B2NIs61bzI4lx/5r2iGJPucpvY2vVYmxtXPWJ+CQfu+9fMmCuv
         KbFA==
X-Gm-Message-State: AC+VfDx6InE+2vTEPTlqakVpaw4966kpr41TTm1n2qXynW643IOfFThD
        IATHf4FMcp2sEJdhQyjyrE/GJoocf81JfWPOtWFX4w==
X-Google-Smtp-Source: ACHHUZ6tnPKQXddjF+yPByGlNbu2YK50eEvYLu3XkRm64FzUYKCXda3es1LXLHr8GrVyAxXwsfYYq1upmKF1RmkKZOY=
X-Received: by 2002:a1f:6046:0:b0:456:ffb8:8901 with SMTP id
 u67-20020a1f6046000000b00456ffb88901mr4334382vkb.15.1684829766186; Tue, 23
 May 2023 01:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230522105049.1467313-1-schnelle@linux.ibm.com> <20230522105049.1467313-12-schnelle@linux.ibm.com>
In-Reply-To: <20230522105049.1467313-12-schnelle@linux.ibm.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 23 May 2023 10:15:55 +0200
Message-ID: <CAMRc=Md9Mzfh58OW+PTWoxySUY9YCL+LEpwebQ-wcmpQLAkWQg@mail.gmail.com>
Subject: Re: [PATCH v5 11/44] gpio: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 12:51=E2=80=AFPM Niklas Schnelle <schnelle@linux.ib=
m.com> wrote:
>
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/gpio/Kconfig | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 5521f060d58e..a470ec8d617b 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -704,18 +704,6 @@ config GPIO_VISCONTI
>         help
>           Say yes here to support GPIO on Tohisba Visconti.
>
> -config GPIO_VX855
> -       tristate "VIA VX855/VX875 GPIO"
> -       depends on (X86 || COMPILE_TEST) && PCI
> -       select MFD_CORE
> -       select MFD_VX855
> -       help
> -         Support access to the VX855/VX875 GPIO lines through the GPIO l=
ibrary.
> -
> -         This driver provides common support for accessing the device.
> -         Additional drivers must be enabled in order to use the
> -         functionality of the device.
> -
>  config GPIO_WCD934X
>         tristate "Qualcomm Technologies Inc WCD9340/WCD9341 GPIO controll=
er driver"
>         depends on MFD_WCD934X && OF_GPIO
> @@ -835,7 +823,19 @@ config GPIO_IDT3243X
>  endmenu
>
>  menu "Port-mapped I/O GPIO drivers"
> -       depends on X86 # Unconditional I/O space access
> +       depends on X86 && HAS_IOPORT # I/O space access
> +
> +config GPIO_VX855
> +       tristate "VIA VX855/VX875 GPIO"
> +       depends on PCI
> +       select MFD_CORE
> +       select MFD_VX855
> +       help
> +         Support access to the VX855/VX875 GPIO lines through the GPIO l=
ibrary.
> +
> +         This driver provides common support for accessing the device.
> +         Additional drivers must be enabled in order to use the
> +         functionality of the device.
>
>  config GPIO_I8255
>         tristate
> --
> 2.39.2
>

I already applied v4. Has this changed since the last version? If not,
then you can drop it now from your series.

Bart
