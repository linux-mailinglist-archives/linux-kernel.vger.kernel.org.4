Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD69971455F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjE2HWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjE2HWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:22:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10745A7;
        Mon, 29 May 2023 00:22:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f7bf29550so459229166b.3;
        Mon, 29 May 2023 00:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685344936; x=1687936936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjVWxXvSLXJuz7mSrEjAxP2mc1hCweJJgtd+gvyPVdE=;
        b=kVe635JkcprzHLEEUfko6c9PT0mWkz5Jyn0v4vAndxdy94y9UaQRS+r1GxSAo2nxx9
         ivCQxH/AmiVLkiOQKqLsYHMaDJXo5S2tQFrrYOA89L4MwJKK1wQZ5SzUkdtVeycRL3O+
         +7NtQovLgeBqUDAZTPi7SplWE6HdFqlcsXUH/EJTMzMIhmOakZqMc0gcTmtE+gX95eUL
         E2Dr7daOLjUFbP/FicrRKGQdWkrcrvc5ni9zgFRqxcZZXw6YdSGxBRhCGEHbiTkAH9wb
         BXtvunhN+bgs+F/Yn+v4tiJZISLtGk/Iu+glA3gRC19mmdpXCkKMykO25n81/DgcqTly
         3FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685344936; x=1687936936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjVWxXvSLXJuz7mSrEjAxP2mc1hCweJJgtd+gvyPVdE=;
        b=WdDtPpxbPHjCtMKkweC1mmOWZqNQLReB5tK7egRZ/3j3QLwQvPo+/UfqElfTl+NV7r
         HvEju2vBKWarF+Nv63gBgd2AOqTj/ycli2Zujivwpmqfd3micA5j+0ofr3To/h+MYhl6
         jRhqp+QIoAK1yn1FSXykUkdP9lD/93f2pg7P998KvCFinKCTxsCaI1DbcV56qCvxJgKR
         iJeFzQS4UZwkgzhefBzF5AYzgN6aV5qQONXJ8ekXxJCiItsWihxp80t3g0lIjANLbYIn
         +IBHGpjU+GGvMg40jBg0njkmFrZgtm/+++vRF/k6sHokRj9pR2hyPvW0sj9UKcXunFrX
         rhPQ==
X-Gm-Message-State: AC+VfDytWJe2PeaKx5AhclWWR1Ll4KLNCpMYfuGuPWff+kAWDdOrNQlV
        divtvIVbbVed4i/huinv2bw=
X-Google-Smtp-Source: ACHHUZ6YY3E5mk2A3FVTfi0Yo8id7xi0ZsdFs4CLIcREmEB0S703vR0wADO3DNzyoxj1iVN9oOlelA==
X-Received: by 2002:a17:907:7208:b0:971:9364:f8cd with SMTP id dr8-20020a170907720800b009719364f8cdmr9014493ejc.44.1685344936227;
        Mon, 29 May 2023 00:22:16 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id f26-20020a170906561a00b009664e25c425sm5608985ejq.95.2023.05.29.00.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 00:22:15 -0700 (PDT)
Date:   Mon, 29 May 2023 09:22:12 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Conor Dooley <conor@kernel.org>
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
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZHRSpP6P5wcgTYAX@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-2-tomm.merciai@gmail.com>
 <20230526-mural-expletive-76b9dd5db83b@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-mural-expletive-76b9dd5db83b@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,
Thanks for the review.

On Fri, May 26, 2023 at 08:00:05PM +0100, Conor Dooley wrote:
> Hey Tommaso,
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
> 
> No dual license?

Yep, agree. Thanks.

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
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: XCLK Input Clock
> 
> Description is a bit moot when you have the clock name and there's only
> one. No harm done I suppose.

Agree, we can drop description.

> 
> > +
> > +  clock-names:
> > +    const: xclk
> > +
> > +  powerdown-gpios:
> > +    maxItems: 1
> > +    description: >
> 
> You don't have any newlines, so you don't need a >

Thanks, I found the same ">" into ov5640 .yaml

> 
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
> 
> Could style this as enum: [0, 180], but I don't mind which you do.

For now this property is unused.
I'll drop this.

> 
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
> 
> Label does not seem to be used & the generic node name should probably
> be "camera", no?

What about using: "alvium: camera@3c {" ?
Like in some .yaml of ov sensors?

> 
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
> 
> Ditto here, drop the unused label?

I think we need this.



Thanks!

Regards,
Tommaso

> 
> Otherwise, looks grand to me.
> 
> Cheers,
> Conor.
> 
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
> > -- 
> > 2.34.1
> > 


