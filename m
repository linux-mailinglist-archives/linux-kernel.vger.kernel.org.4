Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C31267F655
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjA1IbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjA1Ia7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:30:59 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0581A94C;
        Sat, 28 Jan 2023 00:30:57 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 75D425A9;
        Sat, 28 Jan 2023 09:30:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674894654;
        bh=wolM+608me0k0hqUe79z1fi5itONTQkt1Jp0TVlaS7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdQSf4XYaOHQCkcjWzaZfjvllh6Yb02bprrrtGbhWkmYDfh/BYK6MyiFYz/LFGakU
         LiJcLrlFIFrtfoN1pbKRaKE9fymWGvw+yJXmkZ0fvewqwg/I5RjRe8bx88WYJF9RfU
         rXIJN5E/t0QImHk4SHiQGGr6XL6qFTffpMcyn1Pk=
Date:   Sat, 28 Jan 2023 10:30:51 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: bridge: sil,sii8620: convert to
 dtschema
Message-ID: <Y9TdO9MeNxkesIQE@pendragon.ideasonboard.com>
References: <20230127203525.198295-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230127203525.198295-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the patch.

On Fri, Jan 27, 2023 at 09:35:25PM +0100, Krzysztof Kozlowski wrote:
> Convert the Silicon Image SiI8620 HDMI/MHL bridge bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/display/bridge/sil,sii8620.yaml  | 107 ++++++++++++++++++
>  .../bindings/display/bridge/sil-sii8620.txt   |  33 ------
>  2 files changed, 107 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml b/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
> new file mode 100644
> index 000000000000..90532bb99161
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/sil,sii8620.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silicon Image SiI8620 HDMI/MHL bridge
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: sil,sii8620
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: xtal
> +
> +  cvcc10-supply:
> +    description: Digital Core Supply Voltage (1.0V)
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  iovcc18-supply:
> +    description: I/O Supply Voltage (1.8V)
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    unevaluatedProperties: false
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Video port for HDMI (encoder) input
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          MHL to connector port
> +
> +    required:
> +      - port@0

Why port@0 only ?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - cvcc10-supply
> +  - interrupts
> +  - iovcc18-supply
> +  - reset-gpios
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bridge@39 {
> +            reg = <0x39>;
> +            compatible = "sil,sii8620";
> +            cvcc10-supply = <&ldo36_reg>;
> +            iovcc18-supply = <&ldo34_reg>;
> +            interrupt-parent = <&gpf0>;
> +            interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +            reset-gpios = <&gpv7 0 GPIO_ACTIVE_LOW>;
> +            clocks = <&pmu_system_controller 0>;
> +            clock-names = "xtal";
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    mhl_to_hdmi: endpoint {
> +                        remote-endpoint = <&hdmi_to_mhl>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    mhl_to_musb_con: endpoint {
> +                        remote-endpoint = <&musb_con_to_mhl>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt b/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> deleted file mode 100644
> index b05052f7d62f..000000000000
> --- a/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -Silicon Image SiI8620 HDMI/MHL bridge bindings
> -
> -Required properties:
> -	- compatible: "sil,sii8620"
> -	- reg: i2c address of the bridge
> -	- cvcc10-supply: Digital Core Supply Voltage (1.0V)
> -	- iovcc18-supply: I/O Supply Voltage (1.8V)
> -	- interrupts: interrupt specifier of INT pin
> -	- reset-gpios: gpio specifier of RESET pin
> -	- clocks, clock-names: specification and name of "xtal" clock
> -	- video interfaces: Device node can contain video interface port
> -			    node for HDMI encoder according to [1].
> -
> -[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> -
> -Example:
> -	sii8620@39 {
> -		reg = <0x39>;
> -		compatible = "sil,sii8620";
> -		cvcc10-supply = <&ldo36_reg>;
> -		iovcc18-supply = <&ldo34_reg>;
> -		interrupt-parent = <&gpf0>;
> -		interrupts = <2 0>;
> -		reset-gpio = <&gpv7 0 0>;
> -		clocks = <&pmu_system_controller 0>;
> -		clock-names = "xtal";
> -
> -		port {
> -			mhl_to_hdmi: endpoint {
> -				remote-endpoint = <&hdmi_to_mhl>;
> -			};
> -		};
> -	};

-- 
Regards,

Laurent Pinchart
