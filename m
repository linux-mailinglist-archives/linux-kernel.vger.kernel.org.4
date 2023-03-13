Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57FF6B7763
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjCMMZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCMMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:25:25 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E942160A95;
        Mon, 13 Mar 2023 05:25:24 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s12so12795317qtq.11;
        Mon, 13 Mar 2023 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678710324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h82fuy/Xe+ZNGMTcjSSICeQm5bCkEaKlx+5Bu+WICBI=;
        b=pGxacxUR96iVXxjWaCmxttADxxSrQltgRR0PnC9PI/J+h40kv2SJj8W7HZ1VCVnF2I
         fikiNSz4yLsThd860k494OtDWWcZRQWPgAZpCjiuKGchkwIzbIN5b+IwRoTi2lSlqAqC
         rXE2ezhC1LNrKF6L7qZLmD6K2orz4Q8BnviMDXKCMVuIyLIXh0OWV0R5utTTlbZOJAe5
         bKajmx2X8KUir7cLnNQ11tGf/8gSMoX4fkUu4u2t6EZLH1mWbqqhiaJqHYO+oXLMx5Dc
         41rgf3kcGdDbD3AHHpMgA2UEE4HRx0VevN7kZu0/UfdUPqcHLUqI3GFnwfBPvIDW3KKy
         eDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678710324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h82fuy/Xe+ZNGMTcjSSICeQm5bCkEaKlx+5Bu+WICBI=;
        b=Wm9dziA8FnbBTS5F0QliLdooIoHv9re3fyz2uQZ06woBfWZuMmL2A7Pweh3zciGdgJ
         KAee316JYUu0pkIGn5GOZayGyFPCM4RC/OttEaP8XJbqncpY5OD8h7QuN/z/5+m537pl
         qxi/rDqC7zPLL4vUhiJVV+ihaTN9obXcWB40kJGyRdvQKj/NXpeuqWuNcyKANscnTdWr
         3hQYHReQO+Los4q8eUDgfKmJoOQTw/kLIYp0PVxmW7oyUSHcibccv4zM4wKOQM3WMV5s
         sVqICtJ+lALeurT9DRn+YEJXiBHNLCsPeIByMuSPMKcThguBuoRLres1qIqqP8O7/Gp5
         aDiQ==
X-Gm-Message-State: AO0yUKWNIWqTmNG88gZnpLtImft8qbxaeXKJmQB3YzoClyIsmwPQjSLS
        07nHO3Oq8mWRYUACQ7Zxt0UpozSlkUVfN0Zogjk=
X-Google-Smtp-Source: AK7set8rFznMusOPXIFxOAv8d4dBTmfh57Iqr5vPJYLwoM3uJILFy9N3++dbJ6GMtncS++nlZkdAsnpP1Uh/odkNzaA=
X-Received: by 2002:a05:622a:18d:b0:3b8:57a7:7827 with SMTP id
 s13-20020a05622a018d00b003b857a77827mr10428711qtw.0.1678710323965; Mon, 13
 Mar 2023 05:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230313113308.157930-1-francesco@dolcini.it> <20230313113308.157930-3-francesco@dolcini.it>
In-Reply-To: <20230313113308.157930-3-francesco@dolcini.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Mar 2023 14:24:47 +0200
Message-ID: <CAHp75VePJ76nhwX-1cyo-uD=2+w4dbyGNhazJzKkkQOfDma6aQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: fxl6408: add I2C GPIO expander driver
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
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

On Mon, Mar 13, 2023 at 1:33=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> Add minimal driver for Fairchild FXL6408 8-bit I2C-controlled GPIO expand=
er
> using the generic regmap based GPIO driver (GPIO_REGMAP).
>
> The driver implements setting the GPIO direction, reading inputs
> and writing outputs.
>
> In addition to that the FXL6408 has the following functionalities:
> - allows to monitor input ports for data transitions with an interrupt pi=
n
> - all inputs can be configured with pull-up or pull-down resistors

Thank you for the update, my comments below.

...

+ Co-developed-by: your name + email ?

> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

...

> +config GPIO_FXL6408
> +       tristate "FXL6408 I2C GPIO expander"
> +       select GPIO_REGMAP

> +       select REGMAP_I2C

Somebody pointed out that this might require

    depends on I2C

being added as well.

...

> +#include <linux/gpio/regmap.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>

Missing kernel.h for ARRAY_SIZE(), but I prefer the array_size.h to
appear (nevertheless, the latter is out of scope of this one).
Missing err.h for error handling macros.

...

> +#define FXL6408_MAX_REGISTER           0x13

This is used as a range, but why? If we can have a proper name for
this register, why bother dumping all this or even having access to?

...

> +static int fxl6408_identify(struct device *dev, struct regmap *regmap)
> +{
> +       int val, ret;
> +
> +       ret =3D regmap_read(regmap, FXL6408_REG_DEVICE_ID, &val);
> +       if (ret) {
> +               dev_err(dev, "error %d reading DEVICE_ID\n", ret);
> +       } else if (val >> FXL6408_MF_SHIFT !=3D FXL6408_MF_FAIRCHILD) {
> +               dev_err(dev, "invalid device id 0x%02x\n", val);
> +               ret =3D -ENODEV;
> +       }
> +
> +       return ret;

This function is only used at ->probe(), you may refactor it like

       ret =3D regmap_read(regmap, FXL6408_REG_DEVICE_ID, &val);
       if (ret)
               return dev_err_probe(dev, ret, "error reading DEVICE_ID\n");
       if (val >> FXL6408_MF_SHIFT !=3D FXL6408_MF_FAIRCHILD)
               return dev_err_probe(dev, -ENODEV, "invalid device id
0x%02x\n", val);

       return 0;

> +}

--=20
With Best Regards,
Andy Shevchenko
