Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B877645AB8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiLGNVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLGNV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:21:28 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E49C58022
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:21:26 -0800 (PST)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EFA4A4166B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670419285;
        bh=5Fy8+G52z4/CaDFZeawpURrDotSj/z5PeZad0B3CFd8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=sA+Tahxh3nX1vDKzBo+AIshYBkBn5Uf39K95irWs6aXv5MPqekElxPEh//x0/nN7J
         ax7WWXo8hw14dDy3f65N266IINrM/6k/OWA63Ah+vSLQGoQlBie049gZarNOnx5IZr
         PR61DCPe0gprrkuzUg6kgkHCsHJm014JgV5xiFf/AL7TTsAV7OmHz+sPk2FW5OalXM
         mlMCPIQfY85xjuGxX66U+SlkDhAjlMq0oevlQF8tbCi3xMSIlW3VUJm63yogxg01vw
         k0Nglb9sbU0Ka30IzlYbv2Igh1ebwi3BFg3M678rc4caDI0hSPJJbLk69h7KgjVewA
         AdHxpAb9BedAw==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-3d2994e2d7dso185118277b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 05:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Fy8+G52z4/CaDFZeawpURrDotSj/z5PeZad0B3CFd8=;
        b=VT5AjaddZl8evZWCWMVZzthuVzAsJa+ghtIT+uvOBMDyuhVFP8FP6QG18xYCfr6c1M
         TCxKYQnYBt7p4cMm2R6FKIMP1q3MLMYcbM2W1Fhc3DIFnp/SjFcMyrLe7PZu73rdURJ6
         DMcsIctvUD5mraYEINmfL+p6zQ657EL/zvdz2WldXGHMoTpJN5ZtyG6BD9eQdfUgX1ll
         dI/O5LPVsHYzhC2BZpXdIo1VmsxjFuAP3R6HxTFJs85i47TpJn3L0EuRWe4+QA3KhqNa
         qBx6eMCBEIz11VLwtebrVncObSB7x9DOukbzxXyzWSRV+fz9tyzYuv9Pji2dM2kdvEFl
         X1bg==
X-Gm-Message-State: ANoB5pmgCpu4Z+STdF+UXzAJ5j/HO/fjOqjtuVsYUxIPeI+M2/lCW7Nq
        7Ubo7q+5BRQ1eLYGIbLc6Gv2ewHAz7LKzokmqyeLI6apb8hsabUn38hSeIeBk0KnvRskHhlJJd4
        4GdTAeEZ22nEkW9HDIbZ1LB7FuO2TBqISXUUSn4Z/EPc5e6X584GlyxBTqg==
X-Received: by 2002:a05:690c:851:b0:378:5e3a:8fad with SMTP id bz17-20020a05690c085100b003785e3a8fadmr3504069ywb.78.1670419283342;
        Wed, 07 Dec 2022 05:21:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4dEsAOszSDho0u8YfNbcHyL/Cu47ytTETp59tYZGKkZJLswpRhnp6pWtRXOnnDD2vLgF89Nbs4i2sLQZ086ds=
X-Received: by 2002:a05:690c:851:b0:378:5e3a:8fad with SMTP id
 bz17-20020a05690c085100b003785e3a8fadmr3504041ywb.78.1670419283074; Wed, 07
 Dec 2022 05:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20221118011108.70715-1-hal.feng@starfivetech.com>
 <20221118011108.70715-4-hal.feng@starfivetech.com> <7f78e57a-d9be-b1e9-d161-40b1f66e3804@linaro.org>
 <05ade4a9-6ae2-6e3a-5223-270b24e6ea24@starfivetech.com>
In-Reply-To: <05ade4a9-6ae2-6e3a-5223-270b24e6ea24@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 7 Dec 2022 14:21:06 +0100
Message-ID: <CAJM55Z_Cr1ynK0oZ+p6EaLtc1OiZQTTbgx3N6SrM6eOt5rYrGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: pinctrl: Add StarFive JH7110 aon pinctrl
To:     Jianlong Huang <jianlong.huang@starfivetech.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
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

On Mon, 28 Nov 2022 at 02:15, Jianlong Huang
<jianlong.huang@starfivetech.com> wrote:
>
> On Mon, 21 Nov 2022 09:44:00 +0100, Krzysztof Kozlowski wrote:
> > On 18/11/2022 02:11, Hal Feng wrote:
> >> From: Jianlong Huang <jianlong.huang@starfivetech.com>
> >>
> >> Add pinctrl bindings for StarFive JH7110 SoC aon pinctrl controller.
> >>
> >> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> >> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> >> ---
> >>  .../pinctrl/starfive,jh7110-aon-pinctrl.yaml  | 134 ++++++++++++++++++
> >>  1 file changed, 134 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
> >> new file mode 100644
> >> index 000000000000..1dd000e1f614
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
> >> @@ -0,0 +1,134 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/pinctrl/starfive,jh7110-aon-pinctrl.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: StarFive JH7110 Aon Pin Controller
> >> +
> >> +description: |
> >> +  Bindings for the JH7110 RISC-V SoC from StarFive Technology Ltd.
> >> +
> >> +  Out of the SoC's many pins only the ones named PAD_GPIO0 to PAD_GPIO4
> >> +  can be multiplexed and have configurable bias, drive strength,
> >> +  schmitt trigger etc.
> >> +  Some peripherals have their I/O go through the 4 "GPIOs". This also
> >> +  includes PWM.
> >> +
> >> +maintainers:
> >> +  - Jianlong Huang <jianlong.huang@starfivetech.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: starfive,jh7110-aon-pinctrl
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  reg-names:
> >> +    items:
> >> +      - const: control

Again this doesn't seem necessary when you only have 1 memory range.

> >> +
> >> +  clocks:
> >> +    maxItems: 1
> >> +
> >> +  resets:
> >> +    maxItems: 1
> >> +
> >> +  gpio-controller: true
> >> +
> >> +  "#gpio-cells":
> >> +    const: 2
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +    description: The GPIO parent interrupt.
> >
> > Same comments apply plus one more.
>
> Will fix, drop this description.
>
> >
> >> +
> >> +  interrupt-controller: true
> >> +
> >> +  "#interrupt-cells":
> >> +    const: 2
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - reg-names
> >> +  - gpio-controller
> >> +  - "#gpio-cells"
> >> +  - interrupts
> >> +  - interrupt-controller
> >> +  - "#interrupt-cells"
> >
> > "required:" goes after patternProperties.
>
> Will fix.
>
> >
> >> +
> >> +patternProperties:
> >> +  '-[0-9]+$':
> >
> > Same comment.
>
> Will fix.
> Keep consistent quotes, use '
>
> >
> >> +    type: object
> >> +    patternProperties:
> >> +      '-pins$':
> >> +        type: object
> >> +        description: |
> >> +          A pinctrl node should contain at least one subnode representing the
> >> +          pinctrl groups available on the machine. Each subnode will list the
> >> +          pins it needs, and how they should be configured, with regard to
> >> +          muxer configuration, system signal configuration, pin groups for
> >> +          vin/vout module, pin voltage, mux functions for output, mux functions
> >> +          for output enable, mux functions for input.
> >> +
> >> +        properties:
> >> +          pinmux:
> >> +            description: |
> >> +              The list of GPIOs and their mux settings that properties in the
> >> +              node apply to. This should be set using the GPIOMUX macro.
> >> +            $ref: "/schemas/pinctrl/pinmux-node.yaml#/properties/pinmux"
> >> +
> >> +          bias-disable: true
> >> +
> >> +          bias-pull-up:
> >> +            type: boolean
> >> +
> >> +          bias-pull-down:
> >> +            type: boolean
> >> +
> >> +          drive-strength:
> >> +            enum: [ 2, 4, 8, 12 ]
> >> +
> >> +          input-enable: true
> >> +
> >> +          input-disable: true
> >> +
> >> +          input-schmitt-enable: true
> >> +
> >> +          input-schmitt-disable: true
> >> +
> >> +          slew-rate:
> >> +            maximum: 1
> >> +
> >> +        additionalProperties: false
> >> +
> >> +    additionalProperties: false
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/clock/starfive-jh7110.h>
> >> +    #include <dt-bindings/reset/starfive-jh7110.h>
> >> +    #include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
> >> +
> >> +        soc {
> >> +                #address-cells = <2>;
> >> +                #size-cells = <2>;

Again these two lines can be dropped..

> >
> > Same comment.
>
> Will fix.
> Use 4 spaces for example indentation.
>
> >
> >> +
> >> +                gpioa: gpio@17020000 {
> >> +                        compatible = "starfive,jh7110-aon-pinctrl";
> >> +                        reg = <0x0 0x17020000 0x0 0x10000>;

..if you just change this to
reg = <0x17020000 0x10000>;

> >> +                        reg-names = "control";
> >> +                        resets = <&aoncrg_rst JH7110_AONRST_AON_IOMUX>;
> >> +                        interrupts = <85>;
> >> +                        interrupt-controller;
> >> +                        #interrupt-cells = <2>;
> >> +                        #gpio-cells = <2>;
> >> +                        gpio-controller;
> >> +                };
> >> +        };
> >> +
> >> +...
> >
>
> Best regards,
> Jianlong Huang
>
>
