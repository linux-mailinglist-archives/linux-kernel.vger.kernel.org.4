Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21CA64058D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiLBLMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiLBLMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:12:40 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE43BB3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:12:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z4so7313848wrr.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 03:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=DRk7iSUgBPOPq0AnYz+tjk1PeV5gzHd+xhAJ8/gUP6I=;
        b=TsWacH5QPgrxqfhbR8F1bFy3sSwGlGVZ5GlEd3pYRy30X/fuS0w9YEAUW/xuD9OLyZ
         n83q3x/1pwNijGE3VkYnVWDtTHUC3rZlZmil1h5bDE2ARIREovGTJzOcEXV8IHn7HJ+G
         PAGVU67QBv91GrI5QnsMWlP9j3q1ZixbZrfki0WCEi6ybl7pQXzcXf+bJtZBlVRsRXLU
         wwvXHWROSczmvMgx6Tn1fKWvELlPfP2asuKieruoqUgfszrPEunPCrfrMtDlYl8Anydy
         hLjiWPCjve6u7bCvAcdKZqkbvcpMlE8EqBlDSCuxDX1VgDCsll0I3XjI0ep3cclT5F7/
         6lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRk7iSUgBPOPq0AnYz+tjk1PeV5gzHd+xhAJ8/gUP6I=;
        b=ReCfFY6WOsQBhLPsDtr5M8LxkvmzJs9gx1qHCsv00T/0ZHHbehpggYonCmCvRlbJSb
         HHsJ/KHVLyaCLEH5vK2JTdiRtqYtrBOj7Rc9KXD3Q+iLrpBdHVvqz2ZqGdXhvQOK819J
         OpPkYbw810Y4fWnXr/STx26SIH7Mr/wVX45BrRtJWPWEyXNdLZWvXCkLrpaPu9P5/RzH
         gFBjOOZm6YI2JjtP3WX0cXWI+bYy8koB1cxOylXhCnggu8yXl7Y37UvjROSnk8ZuS7NG
         EK4Xh7fc+HXQdpZiPgfDyjLL8i3k2E+VXDEVA2f7pJRqn5iUj4WMoV31p3AEXbh4vCoA
         MCmg==
X-Gm-Message-State: ANoB5pmKVKRpkaDKsW8fepoj5tqXK1ke97v4ByvDcIduk4vXyBj810Jx
        sXXq2/lUymjB/2gLG0qZESgsaA==
X-Google-Smtp-Source: AA0mqf6CJ0Nq4WNROawcXMo7bkkqOnn9O6L0g9XsexL0OqiIeoS3ax8GhKvs5bLlSV0xilyT/wZc5w==
X-Received: by 2002:adf:d228:0:b0:242:fa5:ce81 with SMTP id k8-20020adfd228000000b002420fa5ce81mr18777470wrh.50.1669979556815;
        Fri, 02 Dec 2022 03:12:36 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm13012454wmq.1.2022.12.02.03.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:12:36 -0800 (PST)
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-2-ddrokosov@sberdevices.ru>
User-agent: mu4e 1.8.10; emacs 28.2
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
Subject: Re: [PATCH v8 01/11] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Date:   Fri, 02 Dec 2022 12:11:53 +0100
In-reply-to: <20221201225703.6507-2-ddrokosov@sberdevices.ru>
Message-ID: <1jbkom83fg.fsf@starbuckisacylon.baylibre.com>
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


On Fri 02 Dec 2022 at 01:56, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> From: Jian Hu <jian.hu@amlogic.com>
>
> Add the documentation to support Amlogic A1 PLL clock driver,
> and add A1 PLL clock controller bindings.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 52 +++++++++++++++++++
>  include/dt-bindings/clock/a1-pll-clkc.h       | 16 ++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
>
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> new file mode 100644
> index 000000000000..d67250fbeece
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/amlogic,a1-pll-clkc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson A/C serials PLL Clock Control Unit Device Tree Bindings
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Jian Hu <jian.hu@jian.hu.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a1-pll-clkc
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +     - description: input xtal_fixpll
> +     - description: input xtal_hifipll
> +
> +  clock-names:
> +    items:
> +      - const: xtal_fixpll
> +      - const: xtal_hifipll

Do we really need the "xtal_" prefix ?

Seems like the clock is the PLL, not the xtal

> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clkc_pll: pll-clock-controller@7c80 {
> +                compatible = "amlogic,a1-pll-clkc";
> +                reg = <0 0x7c80 0 0x18c>;
> +                #clock-cells = <1>;
> +                clocks = <&clkc_periphs 1>,
> +                         <&clkc_periphs 4>;
> +                clock-names = "xtal_fixpll", "xtal_hifipll";
> +    };
> diff --git a/include/dt-bindings/clock/a1-pll-clkc.h b/include/dt-bindings/clock/a1-pll-clkc.h
> new file mode 100644
> index 000000000000..58eae237e503
> --- /dev/null
> +++ b/include/dt-bindings/clock/a1-pll-clkc.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __A1_PLL_CLKC_H
> +#define __A1_PLL_CLKC_H
> +
> +#define CLKID_FIXED_PLL				1
> +#define CLKID_FCLK_DIV2				6
> +#define CLKID_FCLK_DIV3				7
> +#define CLKID_FCLK_DIV5				8
> +#define CLKID_FCLK_DIV7				9
> +#define CLKID_HIFI_PLL				10
> +
> +#endif /* __A1_PLL_CLKC_H */

