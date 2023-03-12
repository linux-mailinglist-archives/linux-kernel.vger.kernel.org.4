Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1816F6B6542
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCLLMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCLLMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:12:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D8851CB3;
        Sun, 12 Mar 2023 04:12:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-69-167-nat.elisa-mobile.fi [85.76.69.167])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D477814;
        Sun, 12 Mar 2023 12:12:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678619549;
        bh=nzyRSzra74PJHPo/sH4a43cb116x6GMk1jV1jx0Dxz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaEoGaSQ9wDlAJXSDIWgPWJqufeg9ysT7NzhdP0VJaoOuBXBEXk/NLpRmfyQpxXWP
         su9B4ezEWtZu9kCSA3VRDz5pV9Z8w8UWrl+6hN9V1NHoANdBED9WMrwTRf3kv6hj9x
         OErszh2XvW0U2zdQUxpneShgdhzAVCPnF0WiOjgk=
Date:   Sun, 12 Mar 2023 13:12:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v2 1/6] media: dt-bindings: Add bindings for JH7110
 Camera Subsystem
Message-ID: <20230312111228.GA2545@pendragon.ideasonboard.com>
References: <20230310120553.60586-1-jack.zhu@starfivetech.com>
 <20230310120553.60586-2-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310120553.60586-2-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

Thank you for the patch.

On Fri, Mar 10, 2023 at 08:05:48PM +0800, Jack Zhu wrote:
> Add the bindings documentation for Starfive JH7110 Camera Subsystem
> which is used for handing image sensor data.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---
>  .../bindings/media/starfive,jh7110-camss.yaml | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> new file mode 100644
> index 000000000000..3f348dd53441
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/starfive,jh7110-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Starfive SoC CAMSS ISP
> +
> +maintainers:
> +  - Jack Zhu <jack.zhu@starfivetech.com>
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> +
> +description:
> +  The Starfive CAMSS ISP is a Camera interface for Starfive JH7110 SoC.It

s/.It/. It/

> +  consists of a VIN controller(Video In Controller, a top-level control until)

s/(/ (/

> +  and an ISP.
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-camss
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: syscon
> +      - const: isp
> +
> +  clocks:
> +    maxItems: 7
> +
> +  clock-names:
> +    items:
> +      - const: apb_func
> +      - const: wrapper_clk_c
> +      - const: dvp_inv
> +      - const: axiwr
> +      - const: mipi_rx0_pxl
> +      - const: ispcore_2x
> +      - const: isp_axi
> +
> +  resets:
> +    maxItems: 6
> +
> +  reset-names:
> +    items:
> +      - const: wrapper_p
> +      - const: wrapper_c
> +      - const: axird
> +      - const: axiwr
> +      - const: isp_top_n
> +      - const: isp_top_axi
> +
> +  power-domains:
> +    items:
> +      - description: JH7110 ISP Power Domain Switch Controller.
> +
> +  interrupts:
> +    maxItems: 4
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@1:

Why port@1 if there is no port@0 ?

> +        $ref: /schemas/graph.yaml#/$defs/port-base

I think you can use

        $ref: /schemas/graph.yaml#/properties/port

here as you don't define any additional property for the port node.

> +        unevaluatedProperties: false
> +        description:
> +          Input port for receiving CSI data.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +    required:
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - power-domains
> +  - interrupts

The 'ports' node should be mandatory too.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    stfcamss: isp@19840000 {

You can drop the label as it's not used.

> +        compatible = "starfive,jh7110-camss";
> +        reg = <0x19840000 0x10000>,
> +              <0x19870000 0x30000>;
> +        reg-names = "syscon", "isp";
> +        clocks = <&ispcrg 0>,
> +                 <&ispcrg 13>,
> +                 <&ispcrg 2>,
> +                 <&ispcrg 12>,
> +                 <&ispcrg 1>,
> +                 <&syscrg 51>,
> +                 <&syscrg 52>;
> +        clock-names = "apb_func",
> +                      "wrapper_clk_c",
> +                      "dvp_inv",
> +                      "axiwr",
> +                      "mipi_rx0_pxl",
> +                      "ispcore_2x",
> +                      "isp_axi";
> +        resets = <&ispcrg 0>,
> +                 <&ispcrg 1>,
> +                 <&ispcrg 10>,
> +                 <&ispcrg 11>,
> +                 <&syscrg 41>,
> +                 <&syscrg 42>;
> +        reset-names = "wrapper_p",
> +                      "wrapper_c",
> +                      "axird",
> +                      "axiwr",
> +                      "isp_top_n",
> +                      "isp_top_axi";
> +        power-domains = <&pwrc 5>;
> +        interrupts = <92>, <87>, <88>, <90>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@1 {
> +                reg = <1>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                vin_from_csi2rx: endpoint {
> +                    remote-endpoint = <&csi2rx_to_vin>;
> +                };
> +            };
> +        };
> +    };

-- 
Regards,

Laurent Pinchart
