Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6986BAC05
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCOJWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCOJWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:22:15 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2139322A29;
        Wed, 15 Mar 2023 02:22:06 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id o3so15582340qvr.1;
        Wed, 15 Mar 2023 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678872125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuSAEKhXkhSETKHtCkKJwTr2ISIUXtC69PU2XH68BTQ=;
        b=PQgCvXUQUy2u7OIwwz7IR3Q6+ULUjSBBOe90F1GKSFuBWKKGkHOqsTM09B+u8hYBYY
         cxATQUVwt8ktMEnJ/t8lMrL9bjCzG1/dfNlQaj/ZeQqIkFFHCXeNB8AvchGxOP0iz6Ux
         eBc29+Sptij08K/T7+E+B5ybQwGI71x7ReiiFTQ6KbBURkS/N1M4mCLitQFAcQeccJZ5
         yyHd76SNiQgJVi17IG5zyRgMqWv99Q5z3Adqv9ly5BTQI4nBrxBobxKsNyHt5Ww07rJ+
         DkqPMyPBuiyC1xUb6m+XxVfAA3GGgbrd4J+hLW8Hrr84E6pBrGitzPUVAJR/60cNlyvC
         YihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678872125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuSAEKhXkhSETKHtCkKJwTr2ISIUXtC69PU2XH68BTQ=;
        b=vbmruZ0bjNmmhCtvKOsqjz07+K5yTddgGXl1dQgmh6/dYM5y+uRcvXVtH1gwC+0rp5
         YKY8nOdu8K5CJs09iQfSDFZjUHs7P8BXA5wpHMe2+e4TjvqukUcEsogjIaDnDESgWaye
         +mTidL1Tfv1+V9L9E997IX82U3Pfkxnp/uOUH/EIri1eRAd6Cdl/KiIBvytu1zAvKhN7
         Rg/QQwDeWfJa6xfO37uCdFo7bMlZ1bbQsxLwgcwJ0TuvyNXfeoSwl2KFQDdWLqHR7hfo
         6dMtE+1E5J2ekA7JizhZ1peJgyEfpQeGbcxAnUi52H44NIhUc1zCljGPoymtJ9oLctk+
         I15w==
X-Gm-Message-State: AO0yUKWYm6t0z0dAFrxm+BrZ2QlyNBukQbeE8rrIMefmnNmox46PUf1E
        OM/RN5TkqZprWrfW5zSuEAhGlRBX4UPHZZNGpmM=
X-Google-Smtp-Source: AK7set+8nnuxLrTw5SXRUNxsTcQ1OqQmzZfoOzWhGCtBdWTkx2V8P50oyYG6hD6ORRqG3zidAc87X5GsaLG+oUaCpDw=
X-Received: by 2002:ad4:5505:0:b0:56f:6925:eb2c with SMTP id
 pz5-20020ad45505000000b0056f6925eb2cmr3176701qvb.10.1678872125203; Wed, 15
 Mar 2023 02:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230314221609.22433-1-asmaa@nvidia.com> <20230314221609.22433-3-asmaa@nvidia.com>
In-Reply-To: <20230314221609.22433-3-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Mar 2023 11:21:29 +0200
Message-ID: <CAHp75VeMWvywh1PmA5SxStqM17e4KjU1voPr2rdYCyZVdEsRPA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pinctrl: pinctrl-mlxbf: Add pinctrl driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        niyas.sait@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
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

On Wed, Mar 15, 2023 at 12:16=E2=80=AFAM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:
>
> NVIDIA BlueField-3 SoC has a few pins that can be used as GPIOs
> or take the default hardware functionality. Add a driver for
> the pin muxing.

...

>  drivers/pinctrl/pinctrl-mlxbf3.c | 318 +++++++++++++++++++++++++++++++

Ah, cool, so it's a typo in the GPIO driver then.

...

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>

+ err.h
+ types.h

...

> +struct mlxbf3_pinctrl {
> +       void __iomem *fw_ctrl_set0;
> +       void __iomem *fw_ctrl_clr0;
> +       void __iomem *fw_ctrl_set1;
> +       void __iomem *fw_ctrl_clr1;

> +       struct device *dev;
> +       struct pinctrl_dev *pctl;

Depending on what is used more often in the code you can shuffle the
order and save a few bytes in the generated code. You may play with
bloat-o-meter to check.

> +       struct pinctrl_gpio_range gpio_range;
> +};

...

> +static const char * const mlxbf3_pinctrl_single_group_names[] =3D {
> +       "gpio0", "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6=
", "gpio7",
> +       "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13", "gpio=
14", "gpio15",
> +       "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21", "gpio=
22", "gpio23",
> +       "gpio24", "gpio25", "gpio26", "gpio27", "gpio28", "gpio29", "gpio=
30", "gpio31",
> +       "gpio32", "gpio33", "gpio34", "gpio35", "gpio36", "gpio37", "gpio=
38", "gpio39",
> +       "gpio40", "gpio41", "gpio42", "gpio43", "gpio44", "gpio45", "gpio=
46", "gpio47",
> +       "gpio48", "gpio49", "gpio50", "gpio51", "gpio52", "gpio53", "gpio=
54", "gpio55"

You can leave the trailing comma.

> +};

--=20
With Best Regards,
Andy Shevchenko
