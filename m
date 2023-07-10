Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B174DCDE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjGJR5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGJR5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:57:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC611B;
        Mon, 10 Jul 2023 10:57:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5359D6117A;
        Mon, 10 Jul 2023 17:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A8BC433C7;
        Mon, 10 Jul 2023 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689011820;
        bh=Px7QK0/CIhxyfFoDIS5WoyTBeFeYYT4CZjAXRojlvr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5WSKl2QJCawfVz0mI2LQ3iM6ykcZAPrC4ZYoJ6NSX3c2uGhqbQGKGTUloALL+lbo
         33xaWsLy3gwx3c2CHtDmmM52fzr4aUauxQWOU8uGhsI1p+tPSMB1g42o69EuX+nLf4
         TTz2gxm+OBuSXKW+ncijFQu5kUH2BRAw7lMciCaezZ3d9JTbcGc6koTenOTIHFX45P
         aUi85m2narwsC/MCxa27q4Gf8/axd6ETd19twX/NzF566cUECYTZVWyNvtl7DxGk1T
         HF3w55otnCNeeRnNb8V6WE6O2gPntxC59BmmSMeJ5p3jmI+OTRV0xJTvMO0Lc2PYWx
         dS8aM9sV3I2MQ==
Date:   Mon, 10 Jul 2023 18:56:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: Convert Omnivision OV7251 to DT
 schema
Message-ID: <20230710-underling-angelfish-c47d363a59f5@spud>
References: <20230707210646.868758-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PyGC2IQryHzgfMSp"
Content-Disposition: inline
In-Reply-To: <20230707210646.868758-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PyGC2IQryHzgfMSp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2023 at 03:06:46PM -0600, Rob Herring wrote:
> Convert the OmniVision OV7251 Image Sensor binding to DT schema format.
>=20
> vddd-supply was listed as required, but the example and actual user
> don't have it. Also, the data brief says it has an internal regulator,
> so perhaps it is truly optional.

ov7251.c:
	ov7251->core_regulator =3D devm_regulator_get(dev, "vddd");
	if (IS_ERR(ov7251->core_regulator)) {
		dev_err(dev, "cannot get core regulator\n");
		return PTR_ERR(ov7251->core_regulator);
	}

Looks like the driver's probe function disagrees?
I was going to ask how it worked, but the one user has
status =3D "disabled"...

/shrug, what's here looks fine to me, whatever Qualcomm person cares
about the driver can make sure it works for them I guess.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/media/i2c/ov7251.txt  |  52 ---------
>  .../bindings/media/i2c/ovti,ov7251.yaml       | 105 ++++++++++++++++++
>  2 files changed, 105 insertions(+), 52 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov7251.txt
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov72=
51.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov7251.txt b/Doc=
umentation/devicetree/bindings/media/i2c/ov7251.txt
> deleted file mode 100644
> index 8281151f7493..000000000000
> --- a/Documentation/devicetree/bindings/media/i2c/ov7251.txt
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -* Omnivision 1/7.5-Inch B&W VGA CMOS Digital Image Sensor
> -
> -The Omnivision OV7251 is a 1/7.5-Inch CMOS active pixel digital image se=
nsor
> -with an active array size of 640H x 480V. It is programmable through a s=
erial
> -I2C interface.
> -
> -Required Properties:
> -- compatible: Value should be "ovti,ov7251".
> -- clocks: Reference to the xclk clock.
> -- clock-names: Should be "xclk".
> -- clock-frequency: Frequency of the xclk clock.
> -- enable-gpios: Chip enable GPIO. Polarity is GPIO_ACTIVE_HIGH. This cor=
responds
> -  to the hardware pin XSHUTDOWN which is physically active low.
> -- vdddo-supply: Chip digital IO regulator.
> -- vdda-supply: Chip analog regulator.
> -- vddd-supply: Chip digital core regulator.
> -
> -The device node shall contain one 'port' child node with a single 'endpo=
int'
> -subnode for its digital output video port, in accordance with the video
> -interface bindings defined in
> -Documentation/devicetree/bindings/media/video-interfaces.txt.
> -
> -Example:
> -
> -	&i2c1 {
> -		...
> -
> -		ov7251: camera-sensor@60 {
> -			compatible =3D "ovti,ov7251";
> -			reg =3D <0x60>;
> -
> -			enable-gpios =3D <&gpio1 6 GPIO_ACTIVE_HIGH>;
> -			pinctrl-names =3D "default";
> -			pinctrl-0 =3D <&camera_bw_default>;
> -
> -			clocks =3D <&clks 200>;
> -			clock-names =3D "xclk";
> -			clock-frequency =3D <24000000>;
> -
> -			vdddo-supply =3D <&camera_dovdd_1v8>;
> -			vdda-supply =3D <&camera_avdd_2v8>;
> -			vddd-supply =3D <&camera_dvdd_1v2>;
> -
> -			port {
> -				ov7251_ep: endpoint {
> -					clock-lanes =3D <1>;
> -					data-lanes =3D <0>;
> -					remote-endpoint =3D <&csi0_ep>;
> -				};
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov7251.yaml=
 b/Documentation/devicetree/bindings/media/i2c/ovti,ov7251.yaml
> new file mode 100644
> index 000000000000..8d939858d950
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov7251.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OmniVision OV7251 Image Sensor
> +
> +description:
> +  The Omnivision OV7251 is a 1/7.5-Inch CMOS active pixel digital image =
sensor
> +  with an active array size of 640H x 480V. It is programmable through a=
 serial
> +  I2C interface.
> +
> +maintainers:
> +  - Todor Tomov <todor.too@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: ovti,ov7251
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: XCLK Input Clock
> +
> +  clock-names:
> +    const: xclk
> +
> +  clock-frequency:
> +    description: Frequency of the xclk clock in Hz.
> +
> +  vdda-supply:
> +    description: Analog voltage supply, 2.8 volts
> +
> +  vddd-supply:
> +    description: Digital core voltage supply, 1.2 volts
> +
> +  vdddo-supply:
> +    description: Digital I/O voltage supply, 1.8 volts
> +
> +  enable-gpios:
> +    maxItems: 1
> +    description:
> +      Reference to the GPIO connected to the XSHUTDOWN pin, if any. Pola=
rity
> +      is GPIO_ACTIVE_HIGH.
> +
> +  port:
> +    description: Digital Output Port
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          clock-lanes:
> +            maximum: 1
> +
> +          data-lanes:
> +            maxItems: 1
> +
> +        required:
> +          - data-lanes
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - vdddo-supply
> +  - vdda-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        camera@3c {
> +            compatible =3D "ovti,ov7251";
> +            reg =3D <0x3c>;
> +            clocks =3D <&clks 1>;
> +            clock-frequency =3D <24000000>;
> +            vdddo-supply =3D <&ov7251_vdddo_1v8>;
> +            vdda-supply =3D <&ov7251_vdda_2v8>;
> +            vddd-supply =3D <&ov7251_vddd_1v5>;
> +            enable-gpios =3D <&gpio1 19 GPIO_ACTIVE_HIGH>;
> +
> +            port {
> +                ov7251_ep: endpoint {
> +                    remote-endpoint =3D <&csi0_ep>;
> +                    clock-lanes =3D <1>;
> +                    data-lanes =3D <0>;
> +                };
> +            };
> +        };
> +    };
> +...
> --=20
> 2.40.1
>=20

--PyGC2IQryHzgfMSp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKxGaAAKCRB4tDGHoIJi
0o+TAQDMgP01G5qDmyjHDrR0Md9+bWv1tOgbiBNn2qOuo17xVwEAhPC40p7RB0rF
qg3uSSnzkBNHuXXYu9TlUA17W+ILDAM=
=Zopw
-----END PGP SIGNATURE-----

--PyGC2IQryHzgfMSp--
