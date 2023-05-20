Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E294870A845
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 15:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjETNE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjETNE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 09:04:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68C0128;
        Sat, 20 May 2023 06:04:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A9816090A;
        Sat, 20 May 2023 13:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B9FC433D2;
        Sat, 20 May 2023 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684587865;
        bh=SlBNwWsoZQTmWwToBHVXmVeBerg4Ypq4FsxYRFihvNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GjZY2nN8bTyn0YjZehzFng2E/w99ZejSwXt+/sxAPrgWrDrVprX6xACcGSzOp+046
         az/a5ArkPZicIwIw78kCrogkhR8MnNEvEDdnVyRK5TDBiRp/Tf2ikbuM13dUnRxaJA
         TxClxVAWYwEWzBdGfNBHB89eQ8twPK1jaTU4FaZr4iigUbTkp9PsUw/706fV7++WDk
         pGRQjiuacn5+tJozd9SPjC26o+MS/aeMOZhKq37MdQ8rMGKfLb4Th+E6DMPD80EEEK
         TVYba5NVOEriLnSor6obQskVwxA1ZbzQ0rFOeBoFdKAho+opTY0h/dqTSwmMCjs9mb
         qyBFAgcvbSDGQ==
Date:   Sat, 20 May 2023 14:20:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230520142032.1dc7d593@jic23-huawei>
In-Reply-To: <20230519160145.44208-2-marius.cristea@microchip.com>
References: <20230519160145.44208-1-marius.cristea@microchip.com>
        <20230519160145.44208-2-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 19:01:44 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> This is the device tree schema for iio driver for
> Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> Delta-Sigma ADCs with an SPI interface.
>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>

Hi Marius,

A few comments inline=20
> ---
>  .../bindings/iio/adc/microchip,mcp3564.yaml   | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,m=
cp3564.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.=
yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> new file mode 100644
> index 000000000000..407a125e3776
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,mcp3564.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP346X and MCP356X ADC Family
> +
> +maintainers:
> +  - Marius Cristea <marius.cristea@microchip.com>
> +
> +description: |
> +   Bindings for the Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> +   Delta-Sigma ADCs with an SPI interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp3461
> +      - microchip,mcp3462
> +      - microchip,mcp3464
> +      - microchip,mcp3461r
> +      - microchip,mcp3462r
> +      - microchip,mcp3464r
> +      - microchip,mcp3561
> +      - microchip,mcp3562
> +      - microchip,mcp3564
> +      - microchip,mcp3561r
> +      - microchip,mcp3562r
> +      - microchip,mcp3564r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
If there is a device constraint on this (normally is) then good to enforce =
it
from the binding.  Naturally wiring / host side limits may constrain it mor=
e.

> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  vref-supply:
> +    description:
> +      Some devices have a specific reference voltage supplied on a diffe=
rent
> +      pin to the other supplies. Needed to be able to establish channel =
scaling
> +      unless there is also an internal reference available (e.g. mcp3564=
r)
> +

=46rom a quick glance at a random datasheet, looks like there additional powe=
r supplies
that should be required.

If this is required for some devices, I'd expect to see the binding enforce
that with some required entries conditioned on the compatibles rather than =
as
documentation. If there are devices where it isn't even optional then the b=
inding
should enforce that as well.

> +  microchip,hw-device-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +    description:
> +      The address is set on a per-device basis by fuses in the factory,
> +      configured on request. If not requested, the fuses are set for 0x1.
> +      The device address is part of the device markings to avoid
> +      potential confusion. This address is coded on two bits, so four po=
ssible
> +      addresses are available when multiple devices are present on the s=
ame
> +      SPI bus with only one Chip Select line for all devices.
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +dependencies:
> +  spi-cpol: [ spi-cpha ]
> +  spi-cpha: [ spi-cpol ]
> +
> +required:
> +  - compatible
> +  - microchip,hw-device-address
Supplies should also be required (unless optional like vref seems to someti=
mes
be for these parts - where it's required I expect the binding to enforce th=
at.)
> +
> +additionalProperties: false
For SPI devices, the newer way of providing standard SPI properties is:

allOf:
  - $ref: /schemas/spi/spi-peripheral-props.yaml#

unevaluatedProperties: false

https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/devicetree/b=
indings/iio/adc/adi,ad7298.yaml#L33
for example

> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "microchip,mcp3564r";
> +            reg =3D <0>;
> +            vref-supply =3D <&vref_reg>;
> +            spi-cpha;
> +            spi-cpol;
> +            spi-max-frequency =3D <10000000>;
> +            microchip,hw-device-address =3D <1>;
> +        };
> +    };
> +...

