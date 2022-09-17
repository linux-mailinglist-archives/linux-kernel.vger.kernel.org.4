Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25F15BBAF3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 01:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiIQXHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 19:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIQXHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 19:07:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FBC1C920;
        Sat, 17 Sep 2022 16:07:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B672E415;
        Sun, 18 Sep 2022 01:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663456023;
        bh=xXOC9Hvy+1yChMtVh2/44Mg49dOFOxxcHPt9npGQ08M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Soo4FPc3wECDlBOI8P2GWP5sLnVRSoZKcZFGcYc1W3wgr0v/Za9x49js23N3dSnCq
         UhjDRIAS5/4460a59oHrFkdK7EBaclAxJD+FWP+B+zQHI1lSsuuU57NdOdW6d1oXBd
         3Y85dlhnTC6vRbL7xGAgSl8nX1FVc4IdoIBugSMM=
Date:   Sun, 18 Sep 2022 02:06:50 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
        jacopo@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 3/4] media: dt-bindings: add bindings for Toshiba
 TC358746
Message-ID: <YyZTCsflWtUbo2ld@pendragon.ideasonboard.com>
References: <20220916134535.128131-1-m.felsch@pengutronix.de>
 <20220916134535.128131-4-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220916134535.128131-4-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Thank you for the patch.

On Fri, Sep 16, 2022 at 03:45:34PM +0200, Marco Felsch wrote:
> Add the bindings for the Toshiba TC358746 Parallel <-> MIPI-CSI bridge
> driver.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changelog:
> 
> v2:
> - addded Robs r-b
> - s/than/then/
> - added hsync/vsync/bus-type, make hsync/vsync required
> - fix example indent
> 
>  .../bindings/media/i2c/toshiba,tc358746.yaml  | 179 ++++++++++++++++++
>  1 file changed, 179 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml b/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> new file mode 100644
> index 000000000000..1fa574400bc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> @@ -0,0 +1,179 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/toshiba,tc358746.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba TC358746 Parallel to MIPI CSI2 Bridge
> +
> +maintainers:
> +  - Marco Felsch <kernel@pengutronix.de>
> +
> +description: |-
> +  The Toshiba TC358746 converts a parallel video stream into a MIPI CSI-2
> +  stream. The direction can be either parallel-in -> csi-out or csi-in ->
> +  parallel-out The chip is programmable trough I2C and SPI but the SPI
> +  interface is only supported in parallel-in -> csi-out mode.
> +
> +  Note that the current device tree bindings only support the
> +  parallel-in -> csi-out path.
> +
> +properties:
> +  compatible:
> +    const: toshiba,tc358746
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      The phandle to the reference clock source. This corresponds to the
> +      hardware pin REFCLK.
> +    maxItems: 1
> +
> +  clock-names:
> +    const: refclk
> +
> +# The bridge can act as clock provider for the sensor. To enable this support
> +# #clock-cells must be specified. Attention if this feature is used then the
> +# mclk rate must be at least: (2 * link-frequency) / 8
> +#                             `------------------´   ^
> +#                             internal PLL rate   smallest possible mclk-div
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-output-names:
> +    description:
> +      The clock name of the MCLK output, the default name is tc358746-mclk.
> +    maxItems: 1
> +
> +  vddc-supply:
> +    description: Digital core voltage supply, 1.2 volts
> +
> +  vddio-supply:
> +    description: Digital I/O voltage supply, 1.8 volts
> +
> +  vddmipi-supply:
> +    description: MIPI CSI phy voltage supply, 1.2 volts
> +
> +  reset-gpios:
> +    description:
> +      The phandle and specifier for the GPIO that controls the chip reset.
> +      This corresponds to the hardware pin RESX which is physically active low.
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: Input port
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              hsync-active:
> +                enum:
> +                  - 0 # Hvalid active high
> +              vsync-active:
> +                enum:
> +                  - 0 # Vvalid active high
> +              bus-type:
> +                enum:
> +                  - 5 # Parallel
> +
> +            required:
> +              - hsync-active
> +              - vsync-active

Let's make bus-type required too, to prepare for BT.656 support.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: Output port
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +              clock-noncontinuous: true
> +              link-frequencies: true
> +
> +            required:
> +              - data-lanes
> +              - link-frequencies
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - vddc-supply
> +  - vddio-supply
> +  - vddmipi-supply
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      csi-bridge@e {
> +        compatible = "toshiba,tc358746";
> +        reg = <0xe>;
> +
> +        clocks = <&refclk>;
> +        clock-names = "refclk";
> +
> +        reset-gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
> +
> +        vddc-supply = <&v1_2d>;
> +        vddio-supply = <&v1_8d>;
> +        vddmipi-supply = <&v1_2d>;
> +
> +        /* sensor mclk provider */
> +        #clock-cells = <0>;
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          /* Input */
> +          port@0 {
> +            reg = <0>;
> +            tc358746_in: endpoint {
> +              remote-endpoint = <&sensor_out>;
> +              hsync-active = <0>;
> +              vsync-active = <0>;
> +            };
> +          };
> +
> +          /* Output */
> +          port@1 {
> +            reg = <1>;
> +            tc358746_out: endpoint {
> +              remote-endpoint = <&mipi_csi2_in>;
> +              data-lanes = <1 2>;
> +              clock-noncontinuous;
> +              link-frequencies = /bits/ 64 <216000000>;
> +            };
> +          };
> +        };
> +      };
> +    };

-- 
Regards,

Laurent Pinchart
