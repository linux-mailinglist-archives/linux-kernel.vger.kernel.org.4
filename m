Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FE57063F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjEQJUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEQJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:20:06 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A91738
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:20:05 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-453859b6b18so214153e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684315205; x=1686907205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1z6JwyPkuBQnQHgg+4VNBJ35/lYcbwh0Sg62z2NRT+U=;
        b=OMn8yVkzKvguth5GpSMqqfT/SzxEtin+BTD/DWZPAeZ+9l7+h+JHRC6jQI4U8ft3s0
         9wdv8186gztOWk3saitIunadHwWmEo072dejrRkfzpkS9dZW/HD5+1WrQpZUS0bOtgJp
         dkyOTyoWZeHIfv93i3AaBG4MHDCMF45pAMdRwmj2yNLi5fZcYk3afEYLGXkXlgmQrSnq
         C0r03cqZm1XsuwJoqrWU33ud3HVaTdhqq7MsaYt8S1dN1Z6B0kpva42Dkai7UwTJmxjg
         2NSacngp5QUR2fUFfzdWD0HcxZi7WW0sCFFuViIlu++a5Wz2DFjMLHloPW2sLzQNZcFu
         KGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684315205; x=1686907205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1z6JwyPkuBQnQHgg+4VNBJ35/lYcbwh0Sg62z2NRT+U=;
        b=S2ezPi3AfvXpIYCjf3J9aXL/zX0VOsQKLynOw/0ugLC55NYYEvALMvt1WJV7cchPpC
         gLHBsXSZX8zzWzdIxjMTRGgGT8To7YBv0ysGpgNOoG8mV+TBf+6jbmCeSQhuyXctr/uC
         Dp985pig5bI3UXgZCkLiYQHpdCn2LmOVm+7bPhQ0ijpNnMriBkcbjAP8JMnozn5FBRxP
         aD4XisztdzEWALjcwf5vrPrHGzou3iAIBCNSBLP2QrLmCTZ8DpsqYAOav2gOb1SLBC08
         oJH/0PFs88gsFhegAQPk424AQfsKrX6cC2AsljN/GbC486jdBk+RI4NHMpf4MVA95Gi1
         KzcQ==
X-Gm-Message-State: AC+VfDzV7vO5pRsd+SwaJ5QVO3BqfwHmfTUuN/1Xr35fKx1ZGwgUkNL7
        90pUfwwyQKp0QE6hhFNR5gVV5JXNb7mfEe6zX2OerA==
X-Google-Smtp-Source: ACHHUZ6+pXVpcwCQE5BBPiJ4eI2bOgEbeA1GLlYrdadAe9NQEmPYBg49CeSAh5bvdAVAhUPZOdYwdE9TLWXOfIGlVHo=
X-Received: by 2002:a1f:59c4:0:b0:44f:a955:aaac with SMTP id
 n187-20020a1f59c4000000b0044fa955aaacmr13186873vkb.6.1684315204764; Wed, 17
 May 2023 02:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230517054756.11119-1-zev@bewilderbeest.net>
In-Reply-To: <20230517054756.11119-1-zev@bewilderbeest.net>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 17 May 2023 11:19:53 +0200
Message-ID: <CAMRc=MfuFJu=AJu6=3S64TvYwAY2enUafqCFat-j9G8O58UM4A@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: Fix mode of debugfs files
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
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

On Wed, May 17, 2023 at 7:50=E2=80=AFAM Zev Weiss <zev@bewilderbeest.net> w=
rote:
>
> This driver's debugfs files have had a read operation since commit
> 2a9e27408e12 ("gpio: mockup: rework debugfs interface"), but were
> still being created with write-only mode bits.  Update them to
> indicate that the files can also be read.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Fixes: 2a9e27408e12 ("gpio: mockup: rework debugfs interface")
> Cc: stable@kernel.org # v5.1+
> ---
>  drivers/gpio/gpio-mockup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index e6a7049bef64..b32063ac845a 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -369,7 +369,7 @@ static void gpio_mockup_debugfs_setup(struct device *=
dev,
>                 priv->offset =3D i;
>                 priv->desc =3D gpiochip_get_desc(gc, i);
>
> -               debugfs_create_file(name, 0200, chip->dbg_dir, priv,
> +               debugfs_create_file(name, 0600, chip->dbg_dir, priv,
>                                     &gpio_mockup_debugfs_ops);
>         }
>  }
> --
> 2.40.1
>

Good catch, applied, thanks!

Bart
