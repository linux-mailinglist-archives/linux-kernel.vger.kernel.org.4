Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA90D6E72DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjDSGId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDSGIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:08:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813549EF;
        Tue, 18 Apr 2023 23:08:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DE3CF12F;
        Wed, 19 Apr 2023 08:08:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681884499;
        bh=BMuAh48hQ/wFdNZhXvXHBCMn+wiSzNoNXIAnS+nXjVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDBlYgrCN3F3Jw60WYpl0fDDooucnkKGBWFy26e2hDO2R8A1deqiWO8bcLQKms65r
         4PjLfkrFtf+kohaYmva+aAu5bzpWv7XDJ2afHqSy88XQfEDjrslOnjc4T26iwuJGDW
         k/houurZ9TDO+Zz05XH2zPfNcwtGhuAgD7alhVmM=
Date:   Wed, 19 Apr 2023 09:08:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v4 1/8] media: dt-bindings: cadence-csi2rx: Convert to DT
 schema
Message-ID: <20230419060838.GA11679@pendragon.ideasonboard.com>
References: <20230413035541.62129-1-jack.zhu@starfivetech.com>
 <20230413035541.62129-2-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230413035541.62129-2-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

Thank you for the patch.

On Thu, Apr 13, 2023 at 11:55:34AM +0800, Jack Zhu wrote:
> Convert DT bindings document for Cadence MIPI-CSI2 RX controller to
> DT schema format.
> 
> For compatible, new compatibles should not be messed with conversion,
> but the original binding did not specify any SoC-specific compatible
> string, so add the StarFive compatible string.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../devicetree/bindings/media/cdns,csi2rx.txt | 100 ----------
>  .../bindings/media/cdns,csi2rx.yaml           | 177 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 178 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>  create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt b/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
> deleted file mode 100644
> index 6b02a0657ad9..000000000000
> --- a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
> +++ /dev/null
> @@ -1,100 +0,0 @@
> -Cadence MIPI-CSI2 RX controller
> -===============================
> -
> -The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
> -lanes in input, and 4 different pixel streams in output.
> -
> -Required properties:
> -  - compatible: must be set to "cdns,csi2rx" and an SoC-specific compatible
> -  - reg: base address and size of the memory mapped region
> -  - clocks: phandles to the clocks driving the controller
> -  - clock-names: must contain:
> -    * sys_clk: main clock
> -    * p_clk: register bank clock
> -    * pixel_if[0-3]_clk: pixel stream output clock, one for each stream
> -                         implemented in hardware, between 0 and 3
> -
> -Optional properties:
> -  - phys: phandle to the external D-PHY, phy-names must be provided
> -  - phy-names: must contain "dphy", if the implementation uses an
> -               external D-PHY
> -
> -Required subnodes:
> -  - ports: A ports node with one port child node per device input and output
> -           port, in accordance with the video interface bindings defined in
> -           Documentation/devicetree/bindings/media/video-interfaces.txt. The
> -           port nodes are numbered as follows:
> -
> -           Port Description
> -           -----------------------------
> -           0    CSI-2 input
> -           1    Stream 0 output
> -           2    Stream 1 output
> -           3    Stream 2 output
> -           4    Stream 3 output
> -
> -           The stream output port nodes are optional if they are not
> -           connected to anything at the hardware level or implemented
> -           in the design.Since there is only one endpoint per port,
> -           the endpoints are not numbered.
> -
> -
> -Example:
> -
> -csi2rx: csi-bridge@0d060000 {
> -	compatible = "cdns,csi2rx";
> -	reg = <0x0d060000 0x1000>;
> -	clocks = <&byteclock>, <&byteclock>
> -		 <&coreclock>, <&coreclock>,
> -		 <&coreclock>, <&coreclock>;
> -	clock-names = "sys_clk", "p_clk",
> -		      "pixel_if0_clk", "pixel_if1_clk",
> -		      "pixel_if2_clk", "pixel_if3_clk";
> -
> -	ports {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		port@0 {
> -			reg = <0>;
> -
> -			csi2rx_in_sensor: endpoint {
> -				remote-endpoint = <&sensor_out_csi2rx>;
> -				clock-lanes = <0>;
> -				data-lanes = <1 2>;
> -			};
> -		};
> -
> -		port@1 {
> -			reg = <1>;
> -
> -			csi2rx_out_grabber0: endpoint {
> -				remote-endpoint = <&grabber0_in_csi2rx>;
> -			};
> -		};
> -
> -		port@2 {
> -			reg = <2>;
> -
> -			csi2rx_out_grabber1: endpoint {
> -				remote-endpoint = <&grabber1_in_csi2rx>;
> -			};
> -		};
> -
> -		port@3 {
> -			reg = <3>;
> -
> -			csi2rx_out_grabber2: endpoint {
> -				remote-endpoint = <&grabber2_in_csi2rx>;
> -			};
> -		};
> -
> -		port@4 {
> -			reg = <4>;
> -
> -			csi2rx_out_grabber3: endpoint {
> -				remote-endpoint = <&grabber3_in_csi2rx>;
> -			};
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> new file mode 100644
> index 000000000000..aba1191b3e77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> @@ -0,0 +1,177 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence MIPI-CSI2 RX controller
> +
> +maintainers:
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +description:
> +  The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
> +  lanes in input, and 4 different pixel streams in output.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - starfive,jh7110-csi2rx
> +      - const: cdns,csi2rx
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: CSI2Rx system clock
> +      - description: Gated Register bank clock for APB interface
> +      - description: pixel Clock for Stream interface 0
> +      - description: pixel Clock for Stream interface 1
> +      - description: pixel Clock for Stream interface 2
> +      - description: pixel Clock for Stream interface 3
> +
> +  clock-names:
> +    items:
> +      - const: sys_clk
> +      - const: p_clk
> +      - const: pixel_if0_clk
> +      - const: pixel_if1_clk
> +      - const: pixel_if2_clk
> +      - const: pixel_if3_clk
> +
> +  phys:
> +    maxItems: 1
> +    description: MIPI D-PHY
> +
> +  phy-names:
> +    items:
> +      - const: dphy
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port node, single endpoint describing the CSI-2 transmitter.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              bus-type:
> +                const: 4
> +
> +              clock-lanes:
> +                const: 0
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  maximum: 4
> +
> +            required:
> +              - data-lanes
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Stream 0 Output port node
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Stream 1 Output port node
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Stream 2 Output port node
> +
> +      port@4:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Stream 3 Output port node
> +
> +    required:
> +      - port@0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    csi@d060000 {
> +        compatible = "starfive,jh7110-csi2rx", "cdns,csi2rx";
> +        reg = <0x0d060000 0x1000>;
> +        clocks = <&byteclock 7>, <&byteclock 6>,
> +                 <&coreclock 8>, <&coreclock 9>,
> +                 <&coreclock 10>, <&coreclock 11>;
> +        clock-names = "sys_clk", "p_clk",
> +                      "pixel_if0_clk", "pixel_if1_clk",
> +                      "pixel_if2_clk", "pixel_if3_clk";
> +        phys = <&csi_phy>;
> +        phy-names = "dphy";
> +
> +        ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +
> +                    csi2rx_in_sensor: endpoint {
> +                        remote-endpoint = <&sensor_out_csi2rx>;
> +                        clock-lanes = <0>;
> +                        data-lanes = <1 2>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +
> +                    csi2rx_out_grabber0: endpoint {
> +                        remote-endpoint = <&grabber0_in_csi2rx>;
> +                    };
> +                };
> +
> +                port@2 {
> +                    reg = <2>;
> +
> +                    csi2rx_out_grabber1: endpoint {
> +                        remote-endpoint = <&grabber1_in_csi2rx>;
> +                    };
> +                };
> +
> +                port@3 {
> +                    reg = <3>;
> +
> +                    csi2rx_out_grabber2: endpoint {
> +                        remote-endpoint = <&grabber2_in_csi2rx>;
> +                    };
> +                };
> +
> +                port@4 {
> +                    reg = <4>;
> +
> +                    csi2rx_out_grabber3: endpoint {
> +                        remote-endpoint = <&grabber3_in_csi2rx>;
> +                    };
> +                };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b6c811326355..bbb8b5c0187b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4495,6 +4495,7 @@ M:	Maxime Ripard <mripard@kernel.org>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/media/cdns,*.txt
> +F:	Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
>  F:	drivers/media/platform/cadence/cdns-csi2*
>  
>  CADENCE NAND DRIVER

-- 
Regards,

Laurent Pinchart
