Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B775679385
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjAXIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjAXIzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:55:07 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F204F38039
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:55:05 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id q125so15829053vsb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MAttpzueGAYsfaY0baImq0QHsztmrAcw7EcUju76EJQ=;
        b=fcSq88q+gQ5eVNKYLGRZEx6kB2ONx1zmeU1qez4U7QDuktWoB7lmK8aFdS8VEwL2sF
         PqRyzTb/krZQ/E6MNFy/FA1lmeSZrGz9OuE3hfzJnVAn5gjLStKs5nKjLskBjGNgEX+a
         YvZ9MCVRO7PQuFmEglWWmEmb+hxORUDq8tRkSeNdPH7F0BjUkaWHn6Jawxyx4gAJLIP0
         Ij2tlUSvYSzLMYiAISia27aJ0WyL94BUUrKb4PGOCcgfpDLtEspYmMKG1qAGRPPptmcI
         M97E6qQyMzqvnQ6Akhx5OuCGoLUCrExeCDmy7oGGhoaRbd8eJYxVyW0aIOi57DvFv1Cc
         PvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAttpzueGAYsfaY0baImq0QHsztmrAcw7EcUju76EJQ=;
        b=GuOjD4UMBsPGMGVHzXyVeMSV4/OZWaVycSEQQfqq6gDhHaM4W/1J08laaaPDV4vU9a
         4Bvd3mUw+KP9udc05Y8GlvS9Jy3gXbEc5c5Fepn5ob0OVF9AWFXUKzURMmLdidyrpws8
         NT5nV4fX1D1CYe+6grKGELMjaQjVX00laT3xBrQ2Le6v16sQwAHTMRY2+Muxi6l9MtmS
         oZ1BJQo34BnIcot3Gj0tx1lNROPnRdiGnaXt/evYxryT1Kn6M+VW31gadrLdyp+lWXzq
         RCzWj2cWEDfX1AKbZ+SbrUMKCZNZ43UyPQYDz2+1cMz5hD8X0FatiQeoh8Sifz9WuGpz
         TM9Q==
X-Gm-Message-State: AFqh2kqjv+4cLjziMcpT5MnJdlzo1yN2XrEwIqbsqNT2EQLs6d38Rl5A
        6YUlFEiWYlhO9PTNvdMa5/b5dxnWXKIZINbW18YeAw==
X-Google-Smtp-Source: AMrXdXuUoP42kHvOc0dUiqLBSTR/RBqOZsA4WwAH+/UWLlRHw2aHIpQhFqNrjzSKRhS4tuFWBcImWJSY29BLSdLdnhI=
X-Received: by 2002:a67:f2da:0:b0:3d3:d90c:5ef2 with SMTP id
 a26-20020a67f2da000000b003d3d90c5ef2mr4449498vsn.17.1674550505097; Tue, 24
 Jan 2023 00:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20230124013138.358595-1-pierluigi.p@variscite.com>
In-Reply-To: <20230124013138.358595-1-pierluigi.p@variscite.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 24 Jan 2023 09:54:54 +0100
Message-ID: <CAMRc=Mcf+PA-uhT+3Sq5AxHUMb-K_ogw=kBtGV6-wK00PtXGkw@mail.gmail.com>
Subject: Re: [PATCH v3] gpiolib: fix linker errors when GPIOLIB is disabled
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     linus.walleij@linaro.org, yamada.masahiro@socionext.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, eran.m@variscite.com, nate.d@variscite.com,
        francesco.f@variscite.com, pierluigi.passaro@gmail.com,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 2:31 AM Pierluigi Passaro
<pierluigi.p@variscite.com> wrote:
>
> Both the functions gpiochip_request_own_desc and
> gpiochip_free_own_desc are exported from
>     drivers/gpio/gpiolib.c
> but this file is compiled only when CONFIG_GPIOLIB is enabled.
> Move the prototypes under "#ifdef CONFIG_GPIOLIB" and provide
> reasonable definitions and includes in the "#else" branch.
>
> Fixes: 9091373ab7ea ("gpio: remove less important #ifdef around declarations")
> Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> Changes in v2:
> - add Fixes tag
> Changes in v3:
> - add includes to fix builds against x86_64-defconfig
>

Hey Pierluigi!

Thanks for the quick fix. When this happens - a bug report after a
patch was applied - please generally submit a fix based on what's
already in next, not another version. This time, I'll back it out of
next because I have some comments on this, so please do send a v4.

>  include/linux/gpio/driver.h | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 44783fc16125..e00eaba724dc 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -758,6 +758,8 @@ gpiochip_remove_pin_ranges(struct gpio_chip *gc)
>
>  #endif /* CONFIG_PINCTRL */
>
> +#ifdef CONFIG_GPIOLIB
> +
>  struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
>                                             unsigned int hwnum,
>                                             const char *label,
> @@ -765,8 +767,6 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
>                                             enum gpiod_flags dflags);
>  void gpiochip_free_own_desc(struct gpio_desc *desc);
>
> -#ifdef CONFIG_GPIOLIB
> -
>  /* lock/unlock as IRQ */
>  int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset);
>  void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offset);
> @@ -776,6 +776,25 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc);
>
>  #else /* CONFIG_GPIOLIB */
>
> +#include <linux/gpio/machine.h>
> +#include <linux/gpio/consumer.h>

Please move those headers to the top and arrange them alphabetically
with the rest of the <linux/ headers. Since you're now including
those, remove any forward declarations of the types in question.

Bart

> +
> +static inline struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
> +                                           unsigned int hwnum,
> +                                           const char *label,
> +                                           enum gpio_lookup_flags lflags,
> +                                           enum gpiod_flags dflags)
> +{
> +       /* GPIO can never have been requested */
> +       WARN_ON(1);
> +       return ERR_PTR(-ENODEV);
> +}
> +
> +static inline void gpiochip_free_own_desc(struct gpio_desc *desc)
> +{
> +       WARN_ON(1);
> +}
> +
>  static inline struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
>  {
>         /* GPIO can never have been requested */
> --
> 2.34.1
>
