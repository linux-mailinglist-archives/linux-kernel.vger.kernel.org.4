Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601D665BC30
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbjACI0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjACI01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:26:27 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8331145;
        Tue,  3 Jan 2023 00:26:26 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id x11so24023023qtv.13;
        Tue, 03 Jan 2023 00:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxY7lYagEltChXxjXpBI7TNvNH+bp0AemQt8uZEkx4g=;
        b=WU9iVXYQB3f+21qGwwO6qq6QQcuE0MTy5AXxBp58A7Kqiq3D3nxenRYOU55KNG4Haz
         hxpze0FK9/BpxerOrppratUXs9SeftOAhYedp1zicx/8HbhvFT1JL78Q29gdNvTdVeya
         Fz5YB6R09/5HOInBNtImxR+mURxaOXk4ekLUWf+AjRdVbdjxdpHBgMhyJSnd+Acp3DPe
         ExHZ+zkZwSQ7MT5fLKiiyCgrJAzPd96yT9OpzEe36GV0e0t7nn8a01yxN6DH75HEQ+6j
         xsHPRaGOwe2obeMRIslvLyYy2F/bRz370JufE37p5GrzlbnIADSLF4aLGeIGOCFVEn4N
         Q22A==
X-Gm-Message-State: AFqh2kopLq2u4jzQoWH6Tl2bvp/kihZiF/tExQbA/II4auO52PQA5iyO
        X2l78PupZHuAHNtRJt2Z8L7mo16FMMb5qA==
X-Google-Smtp-Source: AMrXdXsX5bpUtOjavY/iBODyUrtNmbXYW102JwUKMI3uk9w8FTabk1Brmvz93rhFuq3A83+K7R8S/w==
X-Received: by 2002:ac8:7ef7:0:b0:3a8:1bae:4cc with SMTP id r23-20020ac87ef7000000b003a81bae04ccmr60310636qtc.55.1672734385720;
        Tue, 03 Jan 2023 00:26:25 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id m16-20020a05620a291000b007056237b41bsm1715551qkp.67.2023.01.03.00.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 00:26:25 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-45c11d1bfc8so427191537b3.9;
        Tue, 03 Jan 2023 00:26:25 -0800 (PST)
X-Received: by 2002:a81:1b0a:0:b0:37e:6806:a5f9 with SMTP id
 b10-20020a811b0a000000b0037e6806a5f9mr5025447ywb.47.1672734384919; Tue, 03
 Jan 2023 00:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com> <20221221210917.458537-5-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221221210917.458537-5-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Jan 2023 09:26:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUv41kssEnat9PFTcb11sYCP3_9p=5hQFAVRqRa-G7gSg@mail.gmail.com>
Message-ID: <CAMuHMdUv41kssEnat9PFTcb11sYCP3_9p=5hQFAVRqRa-G7gSg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] power: reset: Add new driver for RZ/V2M PWC poweroff
To:     fabrizio.castro.jz@renesas.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Wed, Dec 21, 2022 at 10:09 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The RZ/V2M PWC IP controls external power supplies and therefore
> can turn the power supplies off when powering down the system.
>
> Add driver to poweroff the system.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>
> v1->v2: Dropped OF match table and syscon as a result of the change in
>         DT model

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/power/reset/rzv2m-pwc-poweroff.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + *
> + * Reset driver for Renesas RZ/V2M External Power Sequence Controller (PWC)
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include "../../mfd/rzv2m-pwc.h"
> +
> +#define PWC_PWCRST_RSTSOFTAX           0x1
> +#define PWC_PWCCKEN_ENGCKMAIN          0x1
> +#define PWC_PWCCTL_PWOFF               0x1
> +
> +struct rzv2m_pwc_poweroff_priv {
> +       void __iomem *base;
> +       struct device *dev;
> +};
> +
> +static int rzv2m_pwc_poweroff(struct sys_off_data *data)
> +{
> +       struct rzv2m_pwc_poweroff_priv *priv =
> +               (struct rzv2m_pwc_poweroff_priv *)data->cb_data;

No need for this cast.

> +
> +       writel(PWC_PWCRST_RSTSOFTAX, priv->base + PWC_PWCRST);
> +       writel(PWC_PWCCKEN_ENGCKMAIN, priv->base + PWC_PWCCKEN);
> +       writel(PWC_PWCCTL_PWOFF, priv->base + PWC_PWCCTL);
> +
> +       mdelay(150);
> +
> +       dev_err(priv->dev, "Failed to power off the system");
> +
> +       return NOTIFY_DONE;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
