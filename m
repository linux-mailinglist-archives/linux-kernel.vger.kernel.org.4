Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168D66ABE3D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjCFLeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCFLeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:34:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE40A25E1E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:34:26 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h11so8450066wrm.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678102465;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=kcFkvrShXbF2CFhK0/oJaKpo0rIrr4/wjiECE0Ry774=;
        b=w1ITZjrGW/QOH32dwqCBDCxbtVTjziYE7WXm8LKh5W3RyN04hODHg58PYm+qGhBm98
         ZX94ZnRvLkMhEHtTk4PGs8bNgjdjz4+8wRevETdd5TCQnCtxpDm9W9sxjiz+nhwhJIv9
         jvhqKHdo4nikaFKjxUUgaYRH0kynXpx9QB8OvqEroBhhGNvyPp2Ga45vNO6R0WzwiPDQ
         WHop+Pb18kIW5pYCmdtGfjjreG3LJaVE6oYvg5JY6g9H+Rfs1WM2SK87tkQb3EPm1Du5
         /hJVZOH8gm0+OnikKifQFmUQGjbgH65+mGDLmjJuuMMQtuLciIVqOpDbaiaBFTrMrcRi
         m1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678102465;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcFkvrShXbF2CFhK0/oJaKpo0rIrr4/wjiECE0Ry774=;
        b=sX94qwCq9XIXDH4KBT1s2q98SSeDJbxZnffceVAXhGEQSBTW3Wr8bAYWmy2qas/y5z
         kbl97ZBpCfAZovBfDmGCUQOnGSTw3eQt+7cLU0iSmlOe0KVbiIB/rNOGYDL8Dy3PRglO
         EsHwUInDhdQICuurB5ArW+wk7F2hNWmon0FoobCnTyby3ZE5MiaCVy+BpzAALpRYmTVF
         PeOpZ222WyWswUsK2pKR2vc0edXbADAOoznrGFrj+VH8L3Q9YuX0UyYnKzyUmGQZdQ2/
         x7lXNd38JiB9bUc6hdRjhy9FGsTYJ6yvkxNTMkcUsvDsAhaUeEo+7yaL5Uho3bH7vBJ8
         5plg==
X-Gm-Message-State: AO0yUKWRfmT6xSAHEKd6gt625sOtbFP1G9QWMMGQjdE8/V0KaBcav0yj
        TkxKX5/CmA8TanGXEovA1vbnx4aQ7Oz61zYFi6g=
X-Google-Smtp-Source: AK7set9UafAXr/9TyjNLehZsI8q6PEwZzOGc97MEuj36r9xw0jHrushT4+jS9PqptIjPrV+Y8RSHyg==
X-Received: by 2002:adf:eb87:0:b0:2ce:43c3:2fd with SMTP id t7-20020adfeb87000000b002ce43c302fdmr7064354wrn.4.1678102464886;
        Mon, 06 Mar 2023 03:34:24 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e13-20020adff34d000000b002c53cc7504csm9525832wrp.78.2023.03.06.03.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 03:34:24 -0800 (PST)
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-4-ddrokosov@sberdevices.ru>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 3/5] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Date:   Mon, 06 Mar 2023 12:33:48 +0100
In-reply-to: <20230301183759.16163-4-ddrokosov@sberdevices.ru>
Message-ID: <1jmt4qazb3.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 01 Mar 2023 at 21:37, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> Add the documentation for Amlogic A1 PLL clock driver, and A1 PLL
> clock controller bindings.
> Also include new A1 clock controller dt bindings to MAINTAINERS.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

patch order is wrong.
Bindings before drivers please.

> ---
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 59 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  include/dt-bindings/clock/a1-pll-clkc.h       | 20 +++++++
>  3 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
>
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> new file mode 100644
> index 000000000000..8bd2c948df86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson A/C serials PLL Clock Control Unit
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Jian Hu <jian.hu@jian.hu.com>
> +  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a1-pll-clkc
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: input fixpll_in
> +      - description: input hifipll_in
> +
> +  clock-names:
> +    items:
> +      - const: fixpll_in
> +      - const: hifipll_in
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/a1-clkc.h>
> +    apb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@7c80 {
> +            compatible = "amlogic,a1-pll-clkc";
> +            reg = <0 0x7c80 0 0x18c>;
> +            #clock-cells = <1>;
> +            clocks = <&clkc_periphs CLKID_FIXPLL_IN>,
> +                     <&clkc_periphs CLKID_HIFIPLL_IN>;
> +            clock-names = "fixpll_in", "hifipll_in";
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39ff1a717625..8438bc9bd636 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1895,6 +1895,7 @@ L:	linux-amlogic@lists.infradead.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/amlogic*
>  F:	drivers/clk/meson/
> +F:	include/dt-bindings/clock/a1*
>  F:	include/dt-bindings/clock/gxbb*
>  F:	include/dt-bindings/clock/meson*
>  
> diff --git a/include/dt-bindings/clock/a1-pll-clkc.h b/include/dt-bindings/clock/a1-pll-clkc.h
> new file mode 100644
> index 000000000000..3a559518c6e6
> --- /dev/null
> +++ b/include/dt-bindings/clock/a1-pll-clkc.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + * Author: Jian Hu <jian.hu@amlogic.com>
> + *
> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> + */
> +
> +#ifndef __A1_PLL_CLKC_H
> +#define __A1_PLL_CLKC_H
> +
> +#define CLKID_FIXED_PLL		1
> +#define CLKID_FCLK_DIV2		6
> +#define CLKID_FCLK_DIV3		7
> +#define CLKID_FCLK_DIV5		8
> +#define CLKID_FCLK_DIV7		9
> +#define CLKID_HIFI_PLL		10
> +
> +#endif /* __A1_PLL_CLKC_H */

