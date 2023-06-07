Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D1772551D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbjFGHLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbjFGHLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:11:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02EE1BD3;
        Wed,  7 Jun 2023 00:11:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9745ba45cd1so914970266b.1;
        Wed, 07 Jun 2023 00:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686121864; x=1688713864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJzfy5eblmHMAnYTZMJdGzXUEHB9EWtkIYZ53Ch+qrk=;
        b=OfVEunsHbhVUrhNtpJyPKzsFqJE0SRmJ9ypLkN2J2AKtbwLVX8POS7eo+rrklus0us
         9frqZb8dEpv35aZBx6NSsVE6dMa/zv7SNztY8DMU2ZVrLOPJ+41Y3OuvRgSsBzZ/gDaK
         uqDJvByazmWJDdPefOuySagXrCZ9odZzyc8v6XWAyr4FFMOEIhuRYVN5ab20Rxe/aXyz
         c0j3S/6ZoO74UGD7Wk+L0a/HDgwUpWIdJdCL24qbotkaLqT8o8+pivxmSKWceC6Ad3/B
         LwEK78piyyveBJCoTIk6ih86NvviSGbroOrFO95J9rx4ZCyvwMsBwRXyHArd8BFgnta9
         qRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686121864; x=1688713864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJzfy5eblmHMAnYTZMJdGzXUEHB9EWtkIYZ53Ch+qrk=;
        b=i4N+0CaItMUQtnF8KqtpaMiPWACkTXE08xorq3LM1ROTjIieSWTxVj+B6sRo/6uRct
         7TzUmoO6BCLVm3mgrwurhNq4HlSqSmhn1iaIRL21gxw+vd+Cf0lItFSsEfHKXJslhPd+
         69hEkwsDm6q3WqUEfjb0lSnZys/8gStpGnzGj28ZcV5C5JN40/dBBuHjt3WItt+piYsv
         A2agCF5kBHv6HOhrGuAtUDBXXQQZ6KFkzXhkXc4s77zRgy62lJGUYRSSquvtoRQXCDjn
         Mow8MTNHzL6rLEDEvvvVCSmrDPR1Mn0wpLQHgsco7OaG3k8vOileV+hdmydErXHbPrT+
         FXaw==
X-Gm-Message-State: AC+VfDy4ymPxZvIgU4QL7ole9dreNDCtVB5+4Mk39crakR7rGs59gUSg
        Bz1wfmC8b948Vuj72Pmy1UgchsGyulexKg==
X-Google-Smtp-Source: ACHHUZ7PTdxwk71fUiJ1Q+HMBR9GLNOQDCtsn9d4EO3SY9wN59cnb4esRqGd8W9QLGdoPNtJvJUDpg==
X-Received: by 2002:a17:907:3f8f:b0:969:f54c:dee2 with SMTP id hr15-20020a1709073f8f00b00969f54cdee2mr5249112ejc.26.1686121863834;
        Wed, 07 Jun 2023 00:11:03 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id n19-20020a1709067b5300b00977fb2fb44asm2539374ejo.28.2023.06.07.00.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:11:03 -0700 (PDT)
Date:   Wed, 7 Jun 2023 09:11:00 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     jacopo.mondi@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZIAthFSk+RrRAeN0@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230606155416.260941-1-tomm.merciai@gmail.com>
 <20230606155416.260941-3-tomm.merciai@gmail.com>
 <20230606163656.GI25679@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606163656.GI25679@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Tue, Jun 06, 2023 at 07:36:56PM +0300, Laurent Pinchart wrote:
> Hi Tommaso,
> 
> Thank you for the patch.
> 
> On Tue, Jun 06, 2023 at 05:54:03PM +0200, Tommaso Merciai wrote:
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
> > Changes since v2:
> >  - Fixed License as suggested by KKozlowski/CDooley
> >  - Removed rotation property as suggested by CDooley/LPinchart
> >  - Fixed example node name as suggested by CDooley
> >  - Fixed title as suggested by LPinchart
> >  - Fixed compatible name as suggested by LPinchart
> >  - Removed clock as suggested by LPinchart
> >  - Removed gpios not as suggested by LPinchart
> >  - Renamed property name streamon-delay into alliedvision,lp2hs-delay-us
> >  - Fixed vendor prefix, unit append as suggested by KKozlowski
> >  - Fixed data-lanes
> >  - Fixed blank space + example indentation (from 6 -> 4 space) as suggested by KKozlowski
> >  - Dropped status into example  as suggested by KKozlowski
> >  - Added vcc-ext-in supply as suggested by LPinchart
> >  - Dropped pinctrl into example as suggested by LPinchart
> > 
> >  .../media/i2c/alliedvision,alvium-csi2.yaml   | 93 +++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > new file mode 100644
> > index 000000000000..191534e2f7bd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > @@ -0,0 +1,93 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allied Vision Alvium Camera
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
> > +    const: alliedvision,alvium-csi2
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vcc-ext-in-supply:
> > +    description:
> > +      Definition of the regulator used as interface power supply.
> 
>       The regulator that supplies power to the VCC_EXT_IN pins.

Oks. Ty.

> 
> > +
> > +  alliedvision,lp2hs-delay-us:
> > +    maxItems: 1
> > +    description:
> > +      Low power to high speed delay time in microseconds.
> 
> You can drop "in microseconds", that's implied by the suffix.

Oks.

> 
> > +      The purpose of this property is force a DPhy reset for the period
> > +      described by the microseconds on the property, before it starts
> > +      streaming. To be clear, with that value bigger than 0 the Alvium
> > +      forces a dphy-reset on all lanes for that period. That means all
> > +      lanes go up into low power state. This may help a csi2 rx ip to
> > +      reset if that IP can't deal with a continous clock.
> 
> I'd like to propose what I think is a clearer version:
> 
>     description: |
>       Low power to high speed delay time.
> 
>       If the value is larger than 0, the camera forces a reset of all
>       D-PHY lanes for the duration specified by this property. All lanes
>       will transition to the low-power state and back to the high-speed
>       state after the delay. Otherwise the lanes will transition to and
>       remain in the high-speed state immediately after power on.
> 
>       This is meant to help CSI-2 receivers synchronizing their D-PHY
>       RX.

Thanks!
I'll fix this in v4 :)

Regards,
Tommaso

> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
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
> > +          link-frequencies: true
> > +
> > +          data-lanes:
> > +            minItems: 1
> > +            items:
> > +              - const: 1
> > +              - const: 2
> > +              - const: 3
> > +              - const: 4
> > +
> > +        required:
> > +          - data-lanes
> > +          - link-frequencies
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vcc-ext-in-supply
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        alvium: camera@3c {
> > +            compatible = "alliedvision,alvium-csi2";
> > +            reg = <0x3c>;
> > +            vcc-ext-in-supply = <&reg_vcc_ext_in>;
> > +            alliedvision,lp2hs-delay-us = <20>;
> > +
> > +            port {
> > +                alvium_out: endpoint {
> > +                    remote-endpoint = <&mipi_csi_0_in>;
> > +                    data-lanes = <1 2 3 4>;
> > +                    link-frequencies = /bits/ 64 <681250000>;
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +...
> 
> -- 
> Regards,
> 
> Laurent Pinchart
