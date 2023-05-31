Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21842717C48
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjEaJoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjEaJoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:44:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9265FA0;
        Wed, 31 May 2023 02:43:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so5206199a12.0;
        Wed, 31 May 2023 02:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685526237; x=1688118237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7EsGCmYgG1uVmQhWm7edBWDo73geGk5NCE6+eOOumnk=;
        b=Y33HdGdM+6nWEMAgvmpfiTXLDee6lvx93EsYLTou3Wkz+N7v3gLTJpvnIMezLJDtPy
         Z0Dy61gld22m9A1giOeAf2LCidPyZR6ztuvOeLO25fWsn0L/TWH7LIZMAZaO1CZ63XEx
         kfp+3alpIUBC83RdhujVBDp+MPIp1d/Dz5ZcKbo53HkijIp9Ng5Pr/C9HnoXWwQJJ/1a
         a9uau7eNLX1YtG8neMzdT0GPTxkLq1Y3Uin4VUxz1DzBsDUlYlp/3NlFuQ7SOk+GhmWH
         JlD3wfp157HgA+5brcsYTEnxBwQwUXTcEsb2+4vD7zjUDpzyYNkMn9Gzg7WN9i0HknMg
         ZRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526237; x=1688118237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EsGCmYgG1uVmQhWm7edBWDo73geGk5NCE6+eOOumnk=;
        b=CBCc1TiTvjvHrkJfZeruIzDAPhXiiSZhYyD2Znklz8tSVkOYTNfWOUp7mvoFa45yf7
         QwefMtaUK7tuIMQF5AYtyUXx8LvSPW3YjhLaT+rD8F5qN4fiylbovoSTpUPO+s8S64Hz
         a3PevKF9Rri01iMrE2Ho2zB/6SCS5bN9DV1n5hK1+q9EejuT9ZqlWuoX5pSUWCovn4CK
         aNbTAy/Cp/Kx8A8O9hwBB2LOWNszJjY47L2AV4YX9Qq9Tty3BUZXP+bWHFKoTbnuN/OW
         XYjHnoBps85BdPBzm+ttyAkoOggubu4awbQY54J96vywv3a0T+fgny/SKD3GkJmywV+L
         3Wrg==
X-Gm-Message-State: AC+VfDybTYdIw3PB2JwXy/oKW+nAUlT9dVc01uy/ErhmEC3puIpw8C9x
        soP/YjHwBaxvKNkrltIp0sg=
X-Google-Smtp-Source: ACHHUZ4MPuZTPd5SBIQa8gkDcRHQQN4rpa1rkBEpqgPXcZlbgh4Kuptiitdcb14/ilenLq9ENatajA==
X-Received: by 2002:a17:907:6d12:b0:96a:2b4:eb65 with SMTP id sa18-20020a1709076d1200b0096a02b4eb65mr4345741ejc.9.1685526236696;
        Wed, 31 May 2023 02:43:56 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906365400b0094e7d196aa4sm8640166ejb.160.2023.05.31.02.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:43:56 -0700 (PDT)
Date:   Wed, 31 May 2023 11:43:53 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: dt-bindings: alvium: add document YAML binding
Message-ID: <ZHcW2UTaMng88bVA@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230526103427.774226-1-tomm.merciai@gmail.com>
 <20230526103427.774226-2-tomm.merciai@gmail.com>
 <8835e826-2ef8-bc52-3248-bd347ba7e8c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8835e826-2ef8-bc52-3248-bd347ba7e8c1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On Tue, May 30, 2023 at 05:52:17PM +0200, Krzysztof Kozlowski wrote:
> On 26/05/2023 12:34, Tommaso Merciai wrote:
> > Add documentation of device tree in YAML schema for the ALVIUM
> > Camera from Allied Vision Inc.
> > 
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> 
> > References:
> >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> >  .../media/i2c/alliedvision,alvium.yaml        | 117 ++++++++++++++++++
> >  1 file changed, 117 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > new file mode 100644
> > index 000000000000..5385fe849ffd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > @@ -0,0 +1,117 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license please.
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
> 
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.
> 
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Alliedvision Alvium Camera
> > +
> > +maintainers:
> > +  - Tommaso Merciai <tomm.merciai@gmail.com>
> > +  - Martin Hecht <martin.hecht@avnet.eu>
> > +
> > +allOf:
> > +  - $ref: /schemas/media/video-interface-devices.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: alliedvision,alvium
> 
> Missing vendor prefix in vendor-prefixes.yaml
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: XCLK Input Clock
> 
> maxItems: 1
> 
> > +
> > +  clock-names:
> > +    const: xclk
> 
> Drop names, useless for one entry with generic name.
> 
> > +
> > +  powerdown-gpios:
> > +    maxItems: 1
> > +    description: >
> > +      Reference to the GPIO connected to the powerdown pin, if any.
> 
> Drop description, it's obvious.
> 
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description: >
> > +      Reference to the GPIO connected to the reset pin, if any.
> 
> Drop description, it's obvious.
> 
> 
> > +
> > +  streamon-delay:
> > +    maxItems: 1
> > +    description: >
> > +      Delay before camera start capturing frames in us.
> 
> Missing vendor prefix (unless it is a common property), missing units
> suffix in property name (-us). It's not a list. Why this should be a
> hardware property?
> 
> > +
> > +  rotation:
> > +    enum:
> > +      - 0
> > +      - 180
> > +
> > +  port:
> > +    description: Digital Output Port
> > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      endpoint:
> > +        $ref: /schemas/media/video-interfaces.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          clock-lanes:
> > +            const: 0
> 
> Blank line
> 
> > +          data-lanes:
> > +            minItems: 1
> > +            maxItems: 4
> 
> Four items and each 1 or 4? so <4>, <1>, and what else? Please provide
> example for this.
> 
> > +            items:
> > +              enum: [1, 4]
> > +          link-frequencies: true
> 
> Drop this one, should not be needed.
> 
> > +
> > +        required:
> > +          - data-lanes
> > +          - link-frequencies
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +      #include <dt-bindings/clock/imx6qdl-clock.h>
> > +      #include <dt-bindings/gpio/gpio.h>
> 
> Use 4 spaces for example indentation. Not 6.
> 
> > +
> > +      i2c {
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +
> > +          camera: alvium@3c {
> 
> Node names should be generic. See also explanation and list of examples
> in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> > +              compatible = "alliedvision,alvium";
> > +              reg = <0x3c>;
> > +              pinctrl-names = "default";
> > +              pinctrl-0 = <&pinctrl_csi0_pwn>, <&pinctrl_csi0_rst>, <&pinctrl_csi_mclk>;
> > +              clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> > +              clock-names = "xclk";
> > +              assigned-clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> > +              assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
> > +              assigned-clock-rates = <24000000>;
> > +              streamon-delay = <20>;
> > +              powerdown-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> > +              reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> > +              status = "okay";
> 
> Drop status
> 
> > +
> > +              port {
> > +                  alvium_out: endpoint {
> > +                      remote-endpoint = <&mipi_csi_0_in>;
> > +                      data-lanes = <1 2 3 4>;
> 
> OK, here is the example. You did not test it.

Thanks for your review.
I miss this on v2, mb.
I'll apply your hints on v3.

Regards,
Tommaso


> 
> 
> 
> Best regards,
> Krzysztof
> 
