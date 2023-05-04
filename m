Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B836F6A24
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjEDLhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjEDLhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:37:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F7B525C;
        Thu,  4 May 2023 04:37:24 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-61b5a653df7so3974166d6.0;
        Thu, 04 May 2023 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683200243; x=1685792243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ73yQgZAyw0p9GcsWx42xQ32St/jppP+dAk3fxqzLQ=;
        b=f5hcVuAsIfjqy8FnJFAXQDbxH3zk4ifK6P4UWPNLJyHWo3JM8AqdzkeBuaQI8Ypa0M
         dBxoVMymL8c0/aaucDkJrw+2a7t2oxRQ5LKuNgVokkNMr3DL6QdmtDnu8G0bgOv3f2CG
         p583IFhdKo8bvvSJJ6zg4TajCdzFesRLyWFMhh6lNsojtWg01N0vhPIXghv8aQhbCG35
         AL2hSJ3r87mqxArlb4XANX2/ekTnO9tqVoQUA3lT5QeeEnDbeyviNkxGP3iQo36lB8qH
         dQ/vtfVDR5j2iQrBMNBWtvl6J16vClcnJXeepSHhIBYUcScGnaeo/rruPNx7QP/C3MxY
         J5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683200243; x=1685792243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQ73yQgZAyw0p9GcsWx42xQ32St/jppP+dAk3fxqzLQ=;
        b=MqxHtra92auA2YV/0thKm2l4/PiEZ6+iyuG8dvToVIm2DtZXZr3dbZM8XuveTvcRmE
         6ME2WRai4BU73FVpzVkuZIWDjVBvO+kkAA5aJ9nzGgorIQR1nPXVTl5CnM4mkMm0+Crs
         n/oqvgX7h+yHaGmca8YJBZKlBU72wBQ0Lepk182aLt+6GZ01wA26wQH3j3VVZ7V4os9b
         vPpBO07J+pIU7plNPCzJR7CJU0Z1he7RYMCKj5bKOuCNFZpqRakE7rE0SBVQv/psKS9J
         mmefwsVVLfSRpALlNe8cRAlEQ4t4QBtdFq3lsP+PFHxGr0cyDf/fFflBQ9grvm4OR9rk
         CAtw==
X-Gm-Message-State: AC+VfDxG+IQBYf1I8lR6CzOOjzG7r1wE4wa66i9jYLA/Ne+mea00E/M8
        NpLYj5DiTSjo4NcC4igzfhXiNF6fiJ70WLzpsnn422qwz6/tng==
X-Google-Smtp-Source: ACHHUZ61wW7lWgUWvYJuag34DWWQ2HBHkUSQAQ6w4D+UJOL799Vs8Z0b30TSfS11yEtXLw0q/j3hFjUr6UpJEDkpQ+4=
X-Received: by 2002:ad4:5baa:0:b0:5c5:1a25:edf0 with SMTP id
 10-20020ad45baa000000b005c51a25edf0mr12524535qvq.26.1683200243496; Thu, 04
 May 2023 04:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <202304232146.7M89pwCz-lkp@intel.com> <KL1PR01MB5448327326B6EDA8001AF714E6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
 <ZEk4YNQeYohEwnSg@surfacebook> <KL1PR01MB544880BE86B3890E33609C5AE66D9@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
In-Reply-To: <KL1PR01MB544880BE86B3890E33609C5AE66D9@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 May 2023 14:36:46 +0300
Message-ID: <CAHp75VdFqL4e=awSg0pxnzEYLvWRenTYohRfZ5p-ZOc2B5Lzgg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: gpiolib: clear the array_info's memory space
To:     Yan Wang <rk.code@outlook.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 12:38=E2=80=AFPM Yan Wang <rk.code@outlook.com> wrot=
e:
> On 4/26/2023 10:42 PM, andy.shevchenko@gmail.com wrote:
> > Sun, Apr 23, 2023 at 09:59:43PM +0800, Yan Wang kirjoitti:
> >> if hardware number different to array index,it needs to clear to point=
s
> >> memory space if the array_info have been assigned a value.
> > Can you explain a bit more what's going on there?

...

> I use gpiod_get_array() to get a gpio array form the node of DTS.
>
> the node is as follows:
> ...
> gpios =3D <&gpio1 0 0>, <&gpio1 10 0>;
> ...
>
> First scan pin-0 of gpio1,its index and hardware number are 0,
>
> if (descs->ndescs =3D=3D 0 && gpio_chip_hwgpio(desc) =3D=3D 0) {
>      ...
>      descs->info =3D array_info.
> }
>
> Then scan pin-10 , its index is 1 ,but hardware number is 10 .
>
> if (gpio_chip_hwgpio(desc) !=3D descs->ndescs) {
>      array_info =3D NULL;
> }
> just set array_info =3D NULL, Should the array_info point to memory be
> cleared ?

This is a good question. The entire algorithm is a bit difficult to
understand from the first glance. I need some time to check it myself.

> if not cleared ,I use the gpiod_set_array_value_cansleep() to pull up or
> down pin-10 is invalid.

I'm not sure I follow. The array operations are against the given
array of the descriptors. If you ask to have that operation done, the
all descriptors in the array should be considered.

> I found that the set_mask and get_mask vlaues of descs->info are seted
> 0x03 in gpiod_get_array(),

Yes, this mask is for the argument. The 0x03 is the correct one.

> I think 0x401 is their correct value.

No. You have an array of two elements, and not 11.

> >> if (bitmap_full(array_info->get_mask, descs->ndescs)) {
> >> + /*clear descs->info*/
> >> + memset(array_info, 0, sizeof(struct gpio_array));
> >> array_info =3D NULL;
> >> }


--=20
With Best Regards,
Andy Shevchenko
