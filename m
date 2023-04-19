Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A796E8142
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjDSS36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjDSS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:29:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4862D70;
        Wed, 19 Apr 2023 11:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA5BF63999;
        Wed, 19 Apr 2023 18:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526D2C433D2;
        Wed, 19 Apr 2023 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681928994;
        bh=vMXfRaz6Lvtcg+eyS+REMKN/wpTcy7NYyfkAUOR0zJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MjGLzzXjq3WtVQOhNBbkXl6tYCYtPzO7X4nxU4kRLw1P2i7DNLZMHGATgULoqm3nh
         w39+dRh5X6znik+W2DQw3jNpX9NOmBuh2kcSemVX0FQgnpmtDPVuLBRrVuUMr1L2rp
         rVz9e09h+sUvI8vvmV31wNWfqW7ZhNW8ruqcw9VqsjB8s9x2+tq7qWqNxcfXgo2D6e
         RRQ3yOAnfaoMuIKJ1CvsjXCZ1Oq6i50w2SC1KazzvkRHIEG9QXLP/guBTV56kmY1m+
         IPktL+tnHi8Q3VgoSq5K8yId0fDO/QIJ8EmFHNc+YKV5kcd4ieOj7xvv8bY7Ei4ri8
         PYOONAfsqpnbg==
Date:   Wed, 19 Apr 2023 19:29:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Message-ID: <20230419-labored-camper-644d51a7ca96@spud>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-2-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WQONS9/NxbuziPoO"
Content-Disposition: inline
In-Reply-To: <20230419035646.43702-2-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WQONS9/NxbuziPoO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Changhuang, DT/PHY folks,

On Tue, Apr 18, 2023 at 08:56:41PM -0700, Changhuang Liang wrote:
> Add AON PMU for StarFive JH7110 SoC, it can be used to turn on/off DPHY
> rx/tx power switch, and it don't need the properties of reg and
> interrupts.

Putting this here since the DT guys are more likely to see it this way..
Given how the implementation of the code driving this new
power-controller and the code driving the existing one are rather
different (you've basically re-written the entire driver in this series),
should the dphy driver implement its own power-controller?

I know originally Changuang had tried something along those lines:
https://lore.kernel.org/linux-riscv/5dc4ddc2-9d15-ebb2-38bc-8a544ca67e0d@st=
arfivetech.com/

I see that that was shut down pretty much, partly due to the
non-standard property, hence this series adding the dphy power domain to
the existing driver.

If it was done by looking up the pmu with a
of_find_compatible_node(NULL, "power-controller", "starfive,jh7110-aon-pmu")
type thing, would that make sense? Although, maybe that is not a
question for you, and this series may actually have been better entirely
bundled with the dphy series so the whole thing can be reviewed as a
unit. I've added=20

IOW, don't change this patch, or the dts patch, but move all of the
code back into the phy driver..

Sorry for not asking this sooner Changhuang,
Conor.

(hopefully this didn't get sent twice, mutt complained of a bad email
addr during sending the first time)

>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/power/starfive,jh7110-pmu.yaml       | 15 +++++++++++++--
>  include/dt-bindings/power/starfive,jh7110-pmu.h   |  3 +++
>  2 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.=
yaml b/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> index 98eb8b4110e7..c50507c38e14 100644
> --- a/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> +++ b/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> @@ -8,6 +8,7 @@ title: StarFive JH7110 Power Management Unit
> =20
>  maintainers:
>    - Walker Chen <walker.chen@starfivetech.com>
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> =20
>  description: |
>    StarFive JH7110 SoC includes support for multiple power domains which =
can be
> @@ -17,6 +18,7 @@ properties:
>    compatible:
>      enum:
>        - starfive,jh7110-pmu
> +      - starfive,jh7110-aon-pmu
> =20
>    reg:
>      maxItems: 1
> @@ -29,10 +31,19 @@ properties:
> =20
>  required:
>    - compatible
> -  - reg
> -  - interrupts
>    - "#power-domain-cells"
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: starfive,jh7110-pmu
> +    then:
> +      required:
> +        - reg
> +        - interrupts
> +
>  additionalProperties: false
> =20
>  examples:
> diff --git a/include/dt-bindings/power/starfive,jh7110-pmu.h b/include/dt=
-bindings/power/starfive,jh7110-pmu.h
> index 132bfe401fc8..0bfd6700c144 100644
> --- a/include/dt-bindings/power/starfive,jh7110-pmu.h
> +++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
> @@ -14,4 +14,7 @@
>  #define JH7110_PD_ISP		5
>  #define JH7110_PD_VENC		6
> =20
> +#define JH7110_PD_DPHY_TX	0
> +#define JH7110_PD_DPHY_RX	1
> +
>  #endif
> --=20
> 2.25.1
>=20

--WQONS9/NxbuziPoO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEAzHAAKCRB4tDGHoIJi
0u+LAQDoC/J42sKvykFP5qu+R/A4l+E/risoiAZPqG87amq8hAEAu8g9zCq2G8zr
mxK73nG/PSMv3yXlgoY53l0N+kWSgw8=
=pKPl
-----END PGP SIGNATURE-----

--WQONS9/NxbuziPoO--
