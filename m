Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D837145AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjE2Hlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjE2Hlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:41:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095A9CA;
        Mon, 29 May 2023 00:41:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96fbe7fbdd4so556242666b.3;
        Mon, 29 May 2023 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685346086; x=1687938086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8AKvRuhZAAgYNyvkCPO3RgEAGqxsbL29QI7a0NawxI=;
        b=SRAUjFhpvWuvUifRrQRqGVrKGO5yvn6LaaTV8aJEWsJTTvyWSY7tpf197/cU0jtRnJ
         QajMF2nccPHD/s1LFH7ZYBuNqR9clIRKEYNwH07Nqey8UGuGZQHgXWNdgRbRMku3416M
         qAsw3OaKeYpm6Y8pYuCFy22p2iO8rV99jMhflL13CVI0exYWZXInu559voiCga6UCDN2
         xRriw8uO7lYtdoaVYCANVsYerA4+gJ0uBuVJSXt82K0SnkeEDzYINZKwT4Nffi8Av5mW
         7as0cZeeFz0Gz8fhK1pM+2ZL4OIGzI01ucg0CYhppnwpZV2DXggpKg/y80tX6UI1dvrv
         iPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685346086; x=1687938086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8AKvRuhZAAgYNyvkCPO3RgEAGqxsbL29QI7a0NawxI=;
        b=coyE+CjPXANA99FDVulJf6BAdkfCScSUOXTlzWHmxdWygNfE2kdq0ITfupsTPWsSOV
         G0XdTBUrWoAAp0+P8jTaptjAylM+XQxjP6qWf2x+1wFVD9/NF7So74GBDhU5V4dUz1lh
         6vFCl8weUk3v4bz6OqPq12DqK8DMkHs8/xfZxYj7Cycb8+WSxzO/E9eXcsva3nyc55fy
         I4/wvWvddYf08N9hWS7lnusRtw2bstX6BaFApU9w2yK4+AcwNBqlwSdOq0J6n0Ez666L
         f1Zi+fDNVOfuZaZNsAi2GGhJzvcgQZYWwpfZ6kNYR8rmxd8eFCr0wlZWQaNUQmDDpaBN
         CKXA==
X-Gm-Message-State: AC+VfDyFJKodrkCxVuGIsDSr19Ua3PniUDrbZz80scf5ZER92ca0sZ60
        3WIDHwpZSI197QC7J5OzVp4=
X-Google-Smtp-Source: ACHHUZ4WmH4FfsoTmJZpXUhL+/sUohMsGu35bnSlxqwOuHNCix7ho55/dZ666v7aJrq97Ll18gE2JQ==
X-Received: by 2002:a17:906:4fca:b0:94e:cefc:8df0 with SMTP id i10-20020a1709064fca00b0094ecefc8df0mr9460648ejw.61.1685346086140;
        Mon, 29 May 2023 00:41:26 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id d5-20020a170906640500b0094ef923a6ccsm5569778ejm.219.2023.05.29.00.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 00:41:25 -0700 (PDT)
Date:   Mon, 29 May 2023 09:41:23 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZHRXI6c7G3Sh03i9@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-2-tomm.merciai@gmail.com>
 <ZHPElYOeD2C1qo4R@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHPElYOeD2C1qo4R@kekkonen.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Sun, May 28, 2023 at 09:16:05PM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Fri, May 26, 2023 at 07:39:43PM +0200, Tommaso Merciai wrote:
> > Add documentation of device tree in YAML schema for the ALVIUM
> > Camera from Allied Vision Inc.
> > 
> > References:
> >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> > Changes since v1:
> >  - Fixed build error as suggested by RHerring bot
> > 
> >  .../media/i2c/alliedvision,alvium.yaml        | 115 ++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > new file mode 100644
> > index 000000000000..81e9e560c99d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > @@ -0,0 +1,115 @@
> > +# SPDX-License-Identifier: GPL-2.0
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
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: XCLK Input Clock
> > +
> > +  clock-names:
> > +    const: xclk
> 
> I'd also drop this as you have a single clock only: it's redundant.

Then you suggest also to drop devm_clk_get(dev, "xclk");
into the driver code and use devm_clk_get(&pdev->dev, NULL);
right?

> 
> > +
> > +  powerdown-gpios:
> > +    maxItems: 1
> > +    description: >
> > +      Reference to the GPIO connected to the powerdown pin, if any.
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description: >
> > +      Reference to the GPIO connected to the reset pin, if any.
> > +
> > +  streamon-delay:
> > +    maxItems: 1
> > +    description: >
> > +      Delay before camera start capturing frames in us.
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
> The driver can know this, no need to have it in DT, i.e. please drop it.

Oks.

> 
> > +          data-lanes:
> > +            minItems: 1
> > +            maxItems: 4
> > +          link-frequencies: true
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
> > +      #include <dt-bindings/gpio/gpio.h>
> > +      #include <dt-bindings/clock/imx8mp-clock.h>
> > +
> > +      i2c {
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +
> > +          camera: alvium@3c {
> > +              compatible = "alliedvision,alvium";
> > +              pinctrl-names = "default";
> > +              pinctrl-0 = <&pinctrl_csi0_pwn>, <&pinctrl_csi0_rst>, <&pinctrl_csi_mclk>;
> > +              reg = <0x3c>;
> > +              clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> > +              clock-names = "xclk";
> > +              assigned-clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> > +              assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
> > +              assigned-clock-rates = <24000000>;
> > +              streamon-delay = <20>;
> > +              powerdown-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> > +              reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> > +              status = "okay";
> > +
> > +              port {
> > +                  alvium_out: endpoint {
> > +                      remote-endpoint = <&mipi_csi_0_in>;
> > +                      data-lanes = <1 2 3 4>;
> > +                      link-frequencies = /bits/ 64 <681250000>;
> > +                      clock-lanes = <0>;
> > +                  };
> > +              };
> > +          };
> > +      };
> > +
> > +...

Thanks,
Tommaso

> 
> -- 
> Kind regards,
> 
> Sakari Ailus
