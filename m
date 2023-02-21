Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4744F69E37F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjBUPdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjBUPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:33:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF892B286
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:33:29 -0800 (PST)
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8BE363F58B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676993607;
        bh=L4Qq5cpBFpgwagp9AE1jw12RMdS+BYeFZ1I210i8/Rk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=iAkAiCHLbZ6H01fLXJYP+9TFuDzQE7FHQniBrfd2iZRqUAZ3dw3JC/90pWqh+p7HI
         M45G1s/eQz/Sb0O/xXUxEpLKwGy5mmmPfqfkRYvYI6osghaBRy44NswPKVYdmonoPU
         vxbPGVdM1l1xhfmygIUpPoBQK39NCObCs8XoxuYAVYwX31+WXFoIW4sNFnBHSjtk8L
         lSXYzxI3nxdr9a1tZPgVQ/F6N8QsyT59B5uQJB1hAsswRan0GCihcc2VUFi3EVobX0
         lvBAU2eDfWExY+M2iml4jXlloYo+hQ8OemxvC0TeTLd/a1y/GgURbRgmrt+chnq6pF
         LMcBz8J76UxsQ==
Received: by mail-qv1-f72.google.com with SMTP id fb18-20020ad44f12000000b0056ed45f262dso2032611qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4Qq5cpBFpgwagp9AE1jw12RMdS+BYeFZ1I210i8/Rk=;
        b=leoPIyXzBkDYez2mp3PC6bZqzFJNbqKRcVnnNmgEPeszXf2hVAv4t3rgdc2EB0TFcJ
         cWzwSGSHNtz0CBjPhORQFaIxfETpdVblz2hqmDHu4LATwf6POPg/BmimxlnGIdXRY4Vr
         MdaL04qFoTP7M51hoaUY7+QQqETpYIh+l2Iin6YtEleofjs3U4KWGWtQTSsK+UMFrvpJ
         9hkDmTmkNxy++HrdyFG3Ry4r5gKjIZopQhHYYykZfTEKWXpCY/uuJ8Jvr9F5Bu72xVLK
         hyMkGRDf3ttCoDxqi2wyEmbtQh0JslwRqY8uy1yYzEDbhf7IVtVWYwntG4whMDH5Ht6k
         krWw==
X-Gm-Message-State: AO0yUKUV2YTtgoIchMncjrnhviylnP4VMfDSrDry6yWn2Mu2dS9RQ1i+
        1iVZMh758YwFV2q2fn1bzaZTnwfT8Ghd5ZaGp8fWPXL8RapayUmDfUwd6R5Gd1EokgRtLlFBxx4
        n1ZfQQ6oundh+56jEAdQBgxgjI9bTv5sAeIZ1HMBnTouU3rEpDyY27JK+Tw==
X-Received: by 2002:a0c:d990:0:b0:570:fc87:4f2c with SMTP id y16-20020a0cd990000000b00570fc874f2cmr844746qvj.83.1676993605495;
        Tue, 21 Feb 2023 07:33:25 -0800 (PST)
X-Google-Smtp-Source: AK7set+eeC9t2mpELInJfxD7Yobd/u+LgOJZpX5mua0EuSfRFqXwkek8mhoYknpGc56WgnZGZ/ArALCDKxPQQlhlND4=
X-Received: by 2002:a0c:d990:0:b0:570:fc87:4f2c with SMTP id
 y16-20020a0cd990000000b00570fc874f2cmr844729qvj.83.1676993605220; Tue, 21 Feb
 2023 07:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20230221024645.127922-1-hal.feng@starfivetech.com> <20230221024645.127922-14-hal.feng@starfivetech.com>
In-Reply-To: <20230221024645.127922-14-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 21 Feb 2023 16:33:09 +0100
Message-ID: <CAJM55Z_O9K=sCRXga9pMOXk9YjXc1v_V0e5S-8xN9Mi8gvHzvg@mail.gmail.com>
Subject: Re: [PATCH v4 13/19] reset: starfive: Add StarFive JH7110 reset driver
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 at 03:47, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> Add auxiliary driver to support StarFive JH7110 system
> and always-on resets.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  drivers/reset/starfive/Kconfig                |  8 +++
>  drivers/reset/starfive/Makefile               |  1 +
>  .../reset/starfive/reset-starfive-jh7110.c    | 64 +++++++++++++++++++
>  .../reset/starfive/reset-starfive-jh71x0.h    |  6 ++
>  4 files changed, 79 insertions(+)
>  create mode 100644 drivers/reset/starfive/reset-starfive-jh7110.c
>
> diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
> index 9d15c4110e40..fab1a081af17 100644
> --- a/drivers/reset/starfive/Kconfig
> +++ b/drivers/reset/starfive/Kconfig
> @@ -10,3 +10,11 @@ config RESET_STARFIVE_JH7100
>         default SOC_STARFIVE
>         help
>           This enables the reset controller driver for the StarFive JH7100 SoC.
> +
> +config RESET_STARFIVE_JH7110
> +       bool "StarFive JH7110 Reset Driver"
> +       depends on AUXILIARY_BUS && CLK_STARFIVE_JH7110_SYS
> +       select RESET_STARFIVE_JH71X0
> +       default CLK_STARFIVE_JH7110_SYS
> +       help
> +         This enables the reset controller driver for the StarFive JH7110 SoC.
> diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
> index f6aa12466fad..7a44b66fb9d5 100644
> --- a/drivers/reset/starfive/Makefile
> +++ b/drivers/reset/starfive/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_RESET_STARFIVE_JH71X0)            += reset-starfive-jh71x0.o
>
>  obj-$(CONFIG_RESET_STARFIVE_JH7100)            += reset-starfive-jh7100.o
> +obj-$(CONFIG_RESET_STARFIVE_JH7110)            += reset-starfive-jh7110.o
> diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
> new file mode 100644
> index 000000000000..83577d1b7fc6
> --- /dev/null
> +++ b/drivers/reset/starfive/reset-starfive-jh7110.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Reset driver for the StarFive JH7110 SoC
> + *
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +
> +#include "reset-starfive-jh71x0.h"
> +
> +#include <dt-bindings/reset/starfive,jh7110-crg.h>
> +
> +static int jh7110_reset_probe(struct auxiliary_device *adev,
> +                             const struct auxiliary_device_id *id)
> +{
> +       struct reset_info *info = (struct reset_info *)(id->driver_data);
> +       void __iomem **base = (void __iomem **)dev_get_drvdata(adev->dev.parent);

Hi Hal,

I saw the kernel test robot complain about this, but I still wonder if
the extra level of indirection is really needed. Isn't it enough to
just add the explicit casts, so

dev_set_drvdata(priv->dev, (void *)priv->base);

in the clock drivers and here just

void __iomem *base = (void __iomem *)dev_get_drvdata(adev->dev.parent);

> +
> +       if (!info || !base)
> +               return -ENODEV;
> +
> +       return reset_starfive_jh71x0_register(&adev->dev, adev->dev.parent->of_node,
> +                                             *base + info->assert_offset,
> +                                             *base + info->status_offset,
> +                                             NULL,
> +                                             info->nr_resets,
> +                                             NULL);
> +}
> +
> +static const struct reset_info jh7110_sys_info = {
> +       .nr_resets = JH7110_SYSRST_END,
> +       .assert_offset = 0x2F8,
> +       .status_offset = 0x308,
> +};
> +
> +static const struct reset_info jh7110_aon_info = {
> +       .nr_resets = JH7110_AONRST_END,
> +       .assert_offset = 0x38,
> +       .status_offset = 0x3C,
> +};
> +
> +static const struct auxiliary_device_id jh7110_reset_ids[] = {
> +       {
> +               .name = "clk_starfive_jh71x0.reset-sys",
> +               .driver_data = (kernel_ulong_t)&jh7110_sys_info,
> +       },
> +       {
> +               .name = "clk_starfive_jh71x0.reset-aon",
> +               .driver_data = (kernel_ulong_t)&jh7110_aon_info,
> +       },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, jh7110_reset_ids);
> +
> +static struct auxiliary_driver jh7110_reset_driver = {
> +       .probe          = jh7110_reset_probe,
> +       .id_table       = jh7110_reset_ids,
> +};
> +module_auxiliary_driver(jh7110_reset_driver);
> +
> +MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
> +MODULE_DESCRIPTION("StarFive JH7110 reset driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/reset/starfive/reset-starfive-jh71x0.h
> index db7d39a87f87..e485472e1adc 100644
> --- a/drivers/reset/starfive/reset-starfive-jh71x0.h
> +++ b/drivers/reset/starfive/reset-starfive-jh71x0.h
> @@ -6,6 +6,12 @@
>  #ifndef __RESET_STARFIVE_JH71X0_H
>  #define __RESET_STARFIVE_JH71X0_H
>
> +struct reset_info {
> +       unsigned int nr_resets;
> +       unsigned int assert_offset;
> +       unsigned int status_offset;
> +};

As far as I can tell this struct isn't used anywhere but in
reset-starfive-jh7110.c. If so just move it there, and in any case
please call it something less generic like struct jh7110_reset_info.

> +
>  int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
>                                    void __iomem *assert, void __iomem *status,
>                                    const u32 *asserted, unsigned int nr_resets,
> --
> 2.38.1
>
