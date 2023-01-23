Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6189677ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjAWPLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjAWPK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:10:59 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E28022A2E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:10:58 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id k6so13221850vsk.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MSTeF4AD/TCqkmt4+n+FwyprF1UzqWNEBlBaNmQU3f8=;
        b=2WGGAjVqpUARb+tCJkVD1RicUIUMBaedPFyBrJUsw3o+C3oot3OGVDWKD9me0EM70h
         fZ/9w89H/5tBDspiP3vs/asey/L3kJm+wRc14MhK8aslLOhHu7RkCWsZskoycAnN3Su8
         NUN6jVvd0jZPzSjSjTcYJNZoRBGNeFFreQp2wiYNlU3nlj/ojMJDVA+2VFFQt0XOaG/H
         bOOdYYXZPoWlvTlgnE7voCGEpr0weoDHXQRlk7t/Op4h412/eGl64amzy9D8QdrOdSam
         K+jv4a+havoZCPZtypNuEPh9k6I4GEYUeo0WlGNIM+JIiSy7AIejLXMPjHPTCb506Xqe
         SNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSTeF4AD/TCqkmt4+n+FwyprF1UzqWNEBlBaNmQU3f8=;
        b=Gzoz2uTSnluCqP9wogK61IZVfVwn+O1Ndh90zdpI04UMReVsD4xEIB+oaNSw7BIAiJ
         WnR5exyzgNJqTqxBots1brLf0ix+7pOOnU3b3Zir/Ome4T1K/SAiP4WGhCNo4dvazJxb
         kAYCus30rkXikg+5nxt7lwt2HglCArHvlvEifzB7Xxb99N4fBU3JZwmJqdxQ438R8bGL
         h007wpqZxy+4vdo4v6jofIYOUGT/SiG+Mc1R243mvWEHNgdFZ5w5r4j7AIXJQ8+cmmTU
         JKpQQQDsq8a0p2v5IhMiVpR0+4DK/Ni8CQTTmWF2RAMjMQw6PWzLkCoSJkH9rjBGBaeU
         S6Uw==
X-Gm-Message-State: AFqh2kqU03eO0aUPP0wiBRp2LcftfxGowfTzU002Oh4bpBHAcG/UEv0/
        JFHXZGoPJC6+6+CgV+m8S5My2ZYD82w5qLL3rLct4lQQ0kUvLQ==
X-Google-Smtp-Source: AMrXdXtn4ifMqXCmD01CaAEteO1OfBwpSN4Ang7Ze+ebLtoy1xJ6zzmPXQJWXL9WKy4fqmcu4nwk8336GaykDbHz10Q=
X-Received: by 2002:a67:f2da:0:b0:3d3:d90c:5ef2 with SMTP id
 a26-20020a67f2da000000b003d3d90c5ef2mr3977791vsn.17.1674486657309; Mon, 23
 Jan 2023 07:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20230121001845.32592-1-pierluigi.p@variscite.com>
In-Reply-To: <20230121001845.32592-1-pierluigi.p@variscite.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 23 Jan 2023 16:10:46 +0100
Message-ID: <CAMRc=MfXDeV7gus97Ba4FeuaP4sKtF87DrV4gCbiBR+rGFY6XA@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: fix linker errors when GPIOLIB is disabled
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     linus.walleij@linaro.org, yamada.masahiro@socionext.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        eran.m@variscite.com, nate.d@variscite.com,
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

On Sat, Jan 21, 2023 at 1:19 AM Pierluigi Passaro
<pierluigi.p@variscite.com> wrote:
>
> Both the functions gpiochip_request_own_desc and
> gpiochip_free_own_desc are exported from
>     drivers/gpio/gpiolib.c
> but this file is compiled only when CONFIG_GPIOLIB is enabled.
> Move the protototypes under "#ifdef CONFIG_GPIOLIB" and provide
> reasonable definitions in the "#else" branch.
>
> Fixes: 9091373ab7ea ("gpio: remove less important #ifdef around declarations")
> Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---

Applied, thanks. In the future please list changes between patch
versions when submitting new iterations.

Bart

>  include/linux/gpio/driver.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 44783fc16125..ed77c6fc0beb 100644
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
> @@ -776,6 +776,22 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc);
>
>  #else /* CONFIG_GPIOLIB */
>
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
> 2.37.2
>
