Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7A6AA49E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjCCWjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjCCWie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:38:34 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8DA2687E;
        Fri,  3 Mar 2023 14:37:00 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id g20so1350130qkm.7;
        Fri, 03 Mar 2023 14:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677882946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWmYmvWqv2e+ZMAago7nid1jl0Eit4QWu8dfpQ81Y6Q=;
        b=DwmWRCck+RNGXl8a2FNebxWFIJkoGT+qHGAXDK9hsr1uYkBgRT1uw60WnNw8BgL/r/
         GxGit0/rvVzz9rZO0ctWtVWSwqyjy39qEWX73fwLmYwkPDBgPIypYAbtjgEhe72pg/KK
         ujbIYYihzdRkaDQ+pAvng65tIWhxu8Hz8Qfo2L2PoKsJiRleL1psBB3vLbR4y0a6QtvL
         SyJ69CR7pX6sS73u7WVh6I+Lb2UIkBDZ2gatOaYQxnvZIBPzocdCmESSP1RwDIO6ACPA
         XHC2YyEuA6W6b6TioijJ2E3dwEDgeo6PkK/bwoZ4CFk/rc/3inL1mlFZTFVkO1udqYAm
         WpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677882946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWmYmvWqv2e+ZMAago7nid1jl0Eit4QWu8dfpQ81Y6Q=;
        b=ZmL66890XzI6SG1XR2prmh/XPyl+DOm4iYDk1oe5GumRt5DD9X9B8rFa1Yjq9JPwIx
         qwQuTMz41eHqUOHbFkpj1MdtJzdW6Uys/9yiD1WJJtGCewT4pxXKeZLBly/WInredoef
         WZz09AqpaCV9jVIpHVCEMtg8gTfq5dt9dkJFdqUEKYfmuNcpnEDAOjxMNdWBhC0spsBi
         6nr8p8SYcWC0YMK+94gzZta+fhXNxn+MxaNT5Nf/10zjzlEOSKtH8+BiREvsNX5bKXvT
         zUeln5sk8s+M9eKQKaujec4/bhaX1wQNUTFovonduil68T0OfXerJakD8SSYJ4oJksXV
         F4KQ==
X-Gm-Message-State: AO0yUKXR6ZZc8ss6P+Hs0LXqrX5HcvFcbSa6tezigZFbeOP09jWQ6owi
        Hy5CZXs8eSnM5NKlLfD0UNioN13P6yjCwDlJBAWBswk/wdrf+dZ0
X-Google-Smtp-Source: AK7set+DrRUZpLDxuhnfFMvl6AUFca3C1CfhUoVDT74sz7J1+LGY9VoWlteS7uHKFyTUAYMBixFi6kutBQELpCpZ8hY=
X-Received: by 2002:a05:620a:118a:b0:71f:b8ba:ff4c with SMTP id
 b10-20020a05620a118a00b0071fb8baff4cmr877042qkk.10.1677882945962; Fri, 03 Mar
 2023 14:35:45 -0800 (PST)
MIME-Version: 1.0
References: <20230303215814.24783-1-asmaa@nvidia.com>
In-Reply-To: <20230303215814.24783-1-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Mar 2023 00:35:09 +0200
Message-ID: <CAHp75VfpRVf3fzBf76mipu3dWDbwGCBFUOzyR-P=DLab3_y=Kw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 11:58=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:

Thanks for an update!
My comments below.

> bgpio_init() uses "sz" argument to populate ngpio, which is not
> accurate. Instead, read the "ngpios" property from the DT and if it
> doesn't exist, use the "sz" argument. With this change, drivers no
> longer need to overwrite the ngpio variable after calling bgpio_init.

You missed adding the () to the function name here.

...

First of all there should be two patches:
1) splitting out the new helper;
2) using it in the mmio driver.

...

> +       ret =3D gpiochip_get_ngpios(gc, dev);
> +       if (ret)
> +               gc->ngpio =3D gc->bgpio_bits;

But this doesn't update bgpio_bits in the success case. Can you
explain why it's not a problem (should be at least in the code as a
comment).

...

> +int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev)
> +{
> +       u32 ngpios =3D gc->ngpio;
> +       int ret;
> +
> +       if (ngpios =3D=3D 0) {

> +               ret =3D device_property_read_u32(dev, "ngpios", &ngpios);
> +               if (ret) {
> +                       chip_err(gc, "Failed to get ngpios property\n");
> +                       return -EINVAL;
> +               }

This is not an equivalent to what was in the GPIO library. Why is it so?

> +               gc->ngpio =3D ngpios;
> +       }
> +
> +       if (gc->ngpio > FASTPATH_NGPIO)
> +               chip_warn(gc, "line cnt %u is greater than fast path cnt =
%u\n",
> +                       gc->ngpio, FASTPATH_NGPIO);
> +
> +       return 0;
> +}

...

>                 pr_err("%s: GPIOs %d..%d (%s) failed to register, %d\n", =
__func__,
> -                      base, base + (int)ngpios - 1,
> +                      base, base + (int)gc->ngpio - 1,
>                        gc->label ? : "generic", ret);

AFAIU this will give a different result to what was previous in one of
the error cases.

--=20
With Best Regards,
Andy Shevchenko
