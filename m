Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CD974D207
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjGJJoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjGJJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:43:52 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EC12710
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:40:23 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-443628ee79dso1202550137.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688982019; x=1691574019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAyMQWACMiu7k7xvqQEAhqUIaKa81XxMwdWjQhOqnc0=;
        b=W3/SmPlMMBSFJMpfBbmWrrbGV5s2XxXcD5z26av+mGtwMfYetVOdgeR5zsR4/o3mSf
         tRxoITf6/dqCqz9dtK5ihB+46DlRhA0f/c4qAyoE4f0U3chS86j9PBaieFsS3K16v9/h
         R7SazJIdmjsAH95TgyQ4aVztxFjE+m84vg4C5x32HGcaHMB0j33uchSGK8UTLQSUmtiV
         b9u9I1/qSah088TeMcSD4g74khDVSoWgFGc4B50A34BW/NZMWleOqck+r1cO8CNNzNYG
         CviC7QWzyrQont5dDDdIyoL0wEEghN/gSDK4v7qs7u0lDqoH2kmqS6xf3wpDfYEkHGC+
         wYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982019; x=1691574019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAyMQWACMiu7k7xvqQEAhqUIaKa81XxMwdWjQhOqnc0=;
        b=dsLzXyL1LdttsB551I86HUs1vtA9rdF2+RVuk+CSS/uQGW6eDQN4jAjJTUMa5XRaiR
         ps1SZyJ6qFjGNEJsK0a3maBBzSfcB3ed8y76k83bdkhFXRFQQkmQWyMBxib4gNnVLGvb
         kk+G246h1ryCUU45aoaFKXCh8cRd/bUhfciulgHYBO3T9TTQyB9TCcM2JtnaXiYP7plS
         PFZ+FRjgBH4oVLDU1uEX76cYEn2rs/ylvr+T8OwWMvc5Nk95pwHxvg0n+2LO71jt61bg
         HsZbAa+T1bDzbLsRVIi4WomEz53I8WgF7HZBTOkG30eSQDoITi4PHcC08+3X2hHWUwVi
         b08w==
X-Gm-Message-State: ABy/qLZOPeX01qIR5HaA28J+FErH/iJU9dbZghh9zHJlEyD3XXOV404a
        9lXvT11+PYnm3nxqp+xbIqJDaSS0bzh5njN7Y2OPyw==
X-Google-Smtp-Source: APBJJlHx0SLN86EAAud2RiAr+LzT0y/R2/hQ6x5hh6eT2hO4ce0zhRokqsYDgEGjfUfQcAHKR1lxxGw/1931v+4bU3I=
X-Received: by 2002:a05:6102:2845:b0:443:874b:7d60 with SMTP id
 az5-20020a056102284500b00443874b7d60mr4973244vsb.26.1688982018888; Mon, 10
 Jul 2023 02:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230626172608.2978505-1-samuel.holland@sifive.com>
In-Reply-To: <20230626172608.2978505-1-samuel.holland@sifive.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Jul 2023 11:40:08 +0200
Message-ID: <CAMRc=Mc6vWmvD3=Z8-eBWT5a4BF2_OoYLvOT4TwH+TAxsY17-w@mail.gmail.com>
Subject: Re: [PATCH] gpio: sifive: Support IRQ wake
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 7:26=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Each pin drives a separate interrupt in the parent IRQ domain, so there
> is no need to set IRQCHIP_MASK_ON_SUSPEND.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  drivers/gpio/gpio-sifive.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
> index 98939cd4a71e..c2653313f3a2 100644
> --- a/drivers/gpio/gpio-sifive.c
> +++ b/drivers/gpio/gpio-sifive.c
> @@ -150,6 +150,7 @@ static const struct irq_chip sifive_gpio_irqchip =3D =
{
>         .irq_disable    =3D sifive_gpio_irq_disable,
>         .irq_eoi        =3D sifive_gpio_irq_eoi,
>         .irq_set_affinity =3D sifive_gpio_irq_set_affinity,
> +       .irq_set_wake   =3D irq_chip_set_wake_parent,
>         .flags          =3D IRQCHIP_IMMUTABLE,
>         GPIOCHIP_IRQ_RESOURCE_HELPERS,
>  };
> --
> 2.40.1
>

Applied, thanks!

Bart
