Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD07609C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJXIOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJXIOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:14:09 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5346E62921;
        Mon, 24 Oct 2022 01:14:08 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DFAF44000B;
        Mon, 24 Oct 2022 08:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666599246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJ2Uq0NyxzuaWyEmbQxVmt9Il2FZcKMezY49DsTSY68=;
        b=XAZzC+3mpg3EsrnLzoi2mgunIwj1VEdiJkVtswJZzRsDg8x5TPmcL7ybK82o1XEpNLdXwl
        to0tMKSBxlLFNwUGIg8sNKOciq0xeKGdnDfkPu5sbhSEcke97sp+yfeq1VddYoeMMlV+mI
        0T8ouo7MW8sMtmjR2V0jB9bquFMw5ioU2WAwrAk4Nb8BO0oQLOXmO9i46Z+9JZ9gws0Jk4
        +l3/9Ncdnxc4o6xNEGpG5Zboi6W48dV3rG6xpwi2RTofTzDItpIlWHB9zoUWIWaGl72NaL
        gxsmWuZwqPfplWDh6OWLbQ2xxTY/aJJr/WNBuDkngd9ED/+Pdw9H9EvJqzOU9w==
Date:   Mon, 24 Oct 2022 10:14:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory-controllers: arm,pl353-smc: Extend
 to support 'arm,pl354' SMC
Message-ID: <20221024101405.3c2e163a@xps-13>
In-Reply-To: <20221021203928.286169-1-robh@kernel.org>
References: <20221021203928.286169-1-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Fri, 21 Oct 2022 15:39:28 -0500:

> Add support for the Arm PL354 static memory controller to the existing
> Arm PL353 binding. Both are different configurations of the same IP with
> support for different types of memory interfaces.
>=20
> The 'arm,pl354' binding has already been in use upstream for a long time
> in Arm development boards. The existing users have only the controller
> without any child devices, so drop the required address properties
> (ranges, #address-cells, #size-cells). The schema for 'ranges' is too
> constrained as the order is not important and the PL354 has 8
> chipselects (And the PL353 actually has up to 8 too).

I'm not convinced the ranges constraint should be soften. For me
the order was important (and the description in the yaml useful, but
that's a personal opinion). What makes you think the ranges order is
not relevant on PL353?

Thanks,
Miqu=C3=A8l

> The clocks aren't really correct in either case. There's 1 bus clock and
> then a clock for each of the 2 memory interfaces.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  ...{arm,pl353-smc.yaml =3D> arm,pl35x-smc.yaml} | 80 ++++++++++++-------
>  1 file changed, 53 insertions(+), 27 deletions(-)
>  rename Documentation/devicetree/bindings/memory-controllers/{arm,pl353-s=
mc.yaml =3D> arm,pl35x-smc.yaml} (65%)
>=20
> diff --git a/Documentation/devicetree/bindings/memory-controllers/arm,pl3=
53-smc.yaml b/Documentation/devicetree/bindings/memory-controllers/arm,pl35=
x-smc.yaml
> similarity index 65%
> rename from Documentation/devicetree/bindings/memory-controllers/arm,pl35=
3-smc.yaml
> rename to Documentation/devicetree/bindings/memory-controllers/arm,pl35x-=
smc.yaml
> index 01c9acf9275d..bd23257fe021 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.=
yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc.=
yaml
> @@ -1,26 +1,31 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/memory-controllers/arm,pl353-smc.yaml#
> +$id: http://devicetree.org/schemas/memory-controllers/arm,pl35x-smc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: ARM PL353 Static Memory Controller (SMC) device-tree bindings
> +title: Arm PL35x Series Static Memory Controller (SMC)
> =20
>  maintainers:
>    - Miquel Raynal <miquel.raynal@bootlin.com>
>    - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> =20
> -description:
> -  The PL353 Static Memory Controller is a bus where you can connect two =
kinds
> +description: |
> +  The PL35x Static Memory Controller is a bus where you can connect two =
kinds
>    of memory interfaces, which are NAND and memory mapped interfaces (suc=
h as
> -  SRAM or NOR).
> +  SRAM or NOR) depending on the specific configuration.
> +
> +  The TRM is available here:
> +  https://documentation-service.arm.com/static/5e8e2524fd977155116a58aa
> =20
>  # We need a select here so we don't match all nodes with 'arm,primecell'
>  select:
>    properties:
>      compatible:
>        contains:
> -        const: arm,pl353-smc-r2p1
> +        enum:
> +          - arm,pl353-smc-r2p1
> +          - arm,pl354
>    required:
>      - compatible
> =20
> @@ -30,7 +35,9 @@ properties:
> =20
>    compatible:
>      items:
> -      - const: arm,pl353-smc-r2p1
> +      - enum:
> +          - arm,pl353-smc-r2p1
> +          - arm,pl354
>        - const: arm,primecell
> =20
>    "#address-cells":
> @@ -46,30 +53,25 @@ properties:
>            The three chip select regions are defined in 'ranges'.
> =20
>    clocks:
> -    items:
> -      - description: clock for the memory device bus
> -      - description: main clock of the SMC
> +    minItems: 1
> +    maxItems: 2
> =20
>    clock-names:
> -    items:
> -      - const: memclk
> -      - const: apb_pclk
> +    minItems: 1
> +    maxItems: 2
> =20
>    ranges:
>      minItems: 1
> -    description: |
> -      Memory bus areas for interacting with the devices. Reflects
> -      the memory layout with four integer values following:
> -      <cs-number> 0 <offset> <size>
> -    items:
> -      - description: NAND bank 0
> -      - description: NOR/SRAM bank 0
> -      - description: NOR/SRAM bank 1
> +    maxItems: 8
> =20
> -  interrupts: true
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: Combined or Memory interface 0 IRQ
> +      - description: Memory interface 1 IRQ
> =20
>  patternProperties:
> -  "@[0-3],[a-f0-9]+$":
> +  "@[0-7],[a-f0-9]+$":
>      type: object
>      description: |
>        The child device node represents the controller connected to the S=
MC
> @@ -87,7 +89,7 @@ patternProperties:
>                - description: |
>                    Chip-select ID, as in the parent range property.
>                  minimum: 0
> -                maximum: 2
> +                maximum: 7
>                - description: |
>                    Offset of the memory region requested by the device.
>                - description: |
> @@ -102,12 +104,36 @@ required:
>    - reg
>    - clock-names
>    - clocks
> -  - "#address-cells"
> -  - "#size-cells"
> -  - ranges
> =20
>  additionalProperties: false
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: arm,pl354
> +    then:
> +      properties:
> +        clocks:
> +          # According to TRM, really should be 3 clocks
> +          maxItems: 1
> +
> +        clock-names:
> +          const: apb_pclk
> +
> +    else:
> +      properties:
> +        clocks:
> +          items:
> +            - description: clock for the memory device bus
> +            - description: main clock of the SMC
> +
> +        clock-names:
> +          items:
> +            - const: memclk
> +            - const: apb_pclk
> +
>  examples:
>    - |
>      smcc: memory-controller@e000e000 {
