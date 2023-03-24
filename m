Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B9B6C7DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjCXMH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCXMH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:07:57 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF91690;
        Fri, 24 Mar 2023 05:07:54 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o82so393064qka.11;
        Fri, 24 Mar 2023 05:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679659674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uac8Kh/o+Tug0oTL30CPwJA5sImQaH1bVzzLo3Tmkqw=;
        b=dncRQqBm+KfBkOB06hQC6ieBgEVchNabJRNmbBUkrSqQR+7UiHq8RIAdH8nvJ/psZY
         0y6fzrdkEKRTCDAbgupyIc5cmm/RChXJw8vNW5lSSwuYZxo5uSOGPlfSaSWtcFJ0RBba
         hS80zJrycdrNmYtbZZihTHn9YhjA5ydUqrTWW+SK4fybpMpK4X5s2WJa6B5oJEumOnHb
         fdUF0TK+WMI4xxjq69D5E5bKaepcDleVDrhztzo3WHWmxh3pUy7+yjhynrRP1JhdAm/w
         TmnLQWUXw936jIFXeNwW4NqhdpSN/x/EioTKM7AlZhpisddISrEgeM1EhfFsODbBo7vM
         J03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679659674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uac8Kh/o+Tug0oTL30CPwJA5sImQaH1bVzzLo3Tmkqw=;
        b=lA12WOXHylVasPPNhPba21mGNGCghXEJnCbu/RnibufaK3Xtb9Z4CJkPQWslFmYvxn
         4wM/MtK7P6Xa9pU2n7lxqWj92mtG8+kJjzHZlGVlqjmKuPj6VJZoBGOdlsCWsfS5jR4G
         Ri0sySHDGJrxJHQeIPD6S6W/jPUo9AzkdQof4P/wogf0E0I/LeVtMUKnTTTxj7Yh2WOe
         xqpp8mhoUmer9xWKv4bgwWFT2NxysFDnnvkPGZWrT+WlbWUJ+xJ3Le7KqJeJP6rvF9hi
         zI3W5XM16v7wtm5NTf00ZjqBqR1FGJ6/ryL55oHoaYKW1XmiV7g1/ChDQyMSPA6K4IAl
         9tuA==
X-Gm-Message-State: AO0yUKUv2cwU25XevZltg37koAJ3l3eGFllj/F46FFAqxT/1SOy00Fqe
        ltp0SeEnfvvAv+9U/XJrRfCPq/nStncS5Gq56f3VEkkHACg=
X-Google-Smtp-Source: AK7set+hA7Md34qSQbqtlIEkKZTUuWiDtYN+rawC5fnaUMZCORcDxBVLBkigAd6PEhw0f/iEiqUOVqw6jStzk8oUPxI=
X-Received: by 2002:a05:620a:4154:b0:745:32ab:4d2a with SMTP id
 k20-20020a05620a415400b0074532ab4d2amr442790qko.14.1679659673937; Fri, 24 Mar
 2023 05:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230323205733.20763-1-asmaa@nvidia.com>
In-Reply-To: <20230323205733.20763-1-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Mar 2023 14:07:18 +0200
Message-ID: <CAHp75Vd4m79RhG-_KLRNzr0SPzphG07fOiTWwmGCfx8Lz=+6Vg@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: mmio: fix calculation of bgpio_bits
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:57=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:
>
> If the "ngpios" property is specified, bgpio_bits is calculated
> as the round up value of ngpio. At the moment, the only requirement
> specified is that the round up value must be a multiple of 8 but
> it should also be a power of 2 because we provide accessors based
> on the bank size in bgpio_setup_accessors().

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---
>  drivers/gpio/gpio-mmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
> index b52a3dd511ca..74fdf0d87b2c 100644
> --- a/drivers/gpio/gpio-mmio.c
> +++ b/drivers/gpio/gpio-mmio.c
> @@ -623,7 +623,7 @@ int bgpio_init(struct gpio_chip *gc, struct device *d=
ev,
>         if (ret)
>                 gc->ngpio =3D gc->bgpio_bits;
>         else
> -               gc->bgpio_bits =3D round_up(gc->ngpio, 8);
> +               gc->bgpio_bits =3D roundup_pow_of_two(round_up(gc->ngpio,=
 8));
>
>         ret =3D bgpio_setup_io(gc, dat, set, clr, flags);
>         if (ret)
> --
> 2.30.1
>


--=20
With Best Regards,
Andy Shevchenko
