Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2177089F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjERU4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjERU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C1A110;
        Thu, 18 May 2023 13:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BFC661455;
        Thu, 18 May 2023 20:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B74C433D2;
        Thu, 18 May 2023 20:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684443408;
        bh=2kvhsQX3ua3F3nuiniINthxEYicobxtIUS0bjfwTDFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/WbYFpJcHfzazuvSLaBTUuEZf8dLJrrlKE+yolmEkDJZPqVJrIhqgaaYhTWlh45z
         jaBe9aoLXThELMzekfR2Torp01i9JFKzgIhKvtTckNsEN3psF4YeVEDpHB1KwRG4iu
         NfFcvpXFY2vblG+pAfQZhwXbkz4w5mHtVyRTpc2N0QbM/P810eY2ybGXu6ykdPlSOH
         umeAy1XNG6V9Ku/9jujma4Rqmx3rRkLLeG691nMJW36e7f0u+dLYbnq98KlKAgL0FW
         gcaDVtDFEHQUMgPEk7T2QrnttlBdGkvJoG9TdjpJY6PCSuOsGnBj4+xH24J7fXvGVS
         y+9ns56zuMP7A==
Date:   Thu, 18 May 2023 21:56:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, support.opensource@diasemi.com,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        conor+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: dialog,da7219: convert to dtschema
Message-ID: <20230518-voice-puppy-2a533ec28ac8@spud>
References: <20230518091449.17984-1-David.Rau.opensource@dm.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="POx6Lz9VgPmVxdU/"
Content-Disposition: inline
In-Reply-To: <20230518091449.17984-1-David.Rau.opensource@dm.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--POx6Lz9VgPmVxdU/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey David,

On Thu, May 18, 2023 at 09:14:49AM +0000, David Rau wrote:
> - Convert Dialog DA7219 bindings to DT schema format.
> - Add Jack insertion detection polarity selection.
> - Remove unused `dlg,ldo-lvl` parameter.

Could you please split this out, so that the conversion is done in a
patch of its own, with the addition separate (unless it is my
unfamiliarity with sound at play, and the addition is required as part
of the conversion).

> diff --git a/Documentation/devicetree/bindings/sound/dialog,da7219.yaml b/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
> new file mode 100644
> index 000000000000..32dfc4559052
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
> @@ -0,0 +1,240 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/dialog,da7219.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dialog Semiconductor DA7219 Audio Codec
> +
> +maintainers:
> +  - David Rau <David.Rau.opensource@dm.renesas.com>
> +
> +description:
> +  The DA7219 is an ultra low-power audio codec with
> +  in-built advanced accessory detection (AAD) for mobile
> +  computing and accessory applications, which supports
> +  sample rates up to 96 kHz at 24-bit resolution.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - dlg,da7219

This is just a const.

> +  reg:
> +    description:
> +      The I2C slave address of the DA7219.
> +    maxItems: 1

Drop the description please, it's stating the obvious IMO.

> +  interrupts:
> +    description:
> +      Interrupt for DA7219 IRQ line.
> +    maxItems: 1

Ditto here.

> +
> +  VDD-supply:
> +    description:
> +      VDD power supply for the device.

I would say and here, but there seem to be dozens of other similar
properties in sound.

> +
> +  VDDMIC-supply:
> +    description:
> +      VDDMIC power supply for the device.
> +
> +  VDDIO-supply:
> +    description:
> +      VDDIO power supply for the device.
> +
> +  interrupt-names:
> +    description:
> +      Name associated with interrupt line.
> +      Should be "wakeup" if interrupt is to be used to wake system,
> +      otherwise "irq" should be used.

Please encode these names using the items: field. + oneOf.

> +
> +  wakeup-source:

type: boolean

> +    description:
> +      Flag to indicate this device can wake system (suspend/resume).
> +
> +  "#clock-cells":
> +    description:
> +      Two clock sources provided.

Drop the description here please.

> +    const: 1
> +
> +  clock-output-names:
> +    description:
> +      Names given for DAI clock outputs (WCLK & BCLK).

Please encode these as items:

> +
> +  clocks:
> +    description:
> +      phandle and clock specifier for codec MCLK.

maxItems: 1 & given the clock name I think you can drop both
descriptions from here and clock-names.


> +  "da7219_aad":

Drop the quotes please.

> +      dlg,jack-ins-det-pty:
> +        enum: ["low", "high"]
> +        description:
> +          Polarity for jack insertion detection.
> +        $ref: /schemas/types.yaml#/definitions/string
> +        $ref: /schemas/types.yaml#/definitions/uint32

Yeah, please do the change from txt -> yaml as one patch and this as
another.

Cheers,
Conor.


--POx6Lz9VgPmVxdU/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGaRDAAKCRB4tDGHoIJi
0onwAP9JET5WHCuSIsy/Osee2vEftKPtKRv8yf7av6zgfkMa1AEA81M4t/QUZdmA
D1EW+0Z1W0eLENDipaCCK9PEXAD3Ogw=
=B/fJ
-----END PGP SIGNATURE-----

--POx6Lz9VgPmVxdU/--
