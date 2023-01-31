Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144C7682F71
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjAaOjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjAaOji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:39:38 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6355B95;
        Tue, 31 Jan 2023 06:39:36 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B19E4C000C;
        Tue, 31 Jan 2023 14:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675175974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGOCmZXkzDIr1SkQAHhEaNwnpysSKPubHEZh+d3fk54=;
        b=R/udLyfxLz6s+Ng61h8q3eqE6CLA/dMBIn6Qjrk7XvYFDPKMtCh8vs/fHyW34UqbdcsXyI
        7jm9OO3cXOKqEFiS24dXrpZ2Zrmeq3j85LKHaIne5mEhTiki6UUMlg0XvAXMVEKUgu5KMI
        eKvggYb/82AxFLcyVlCE/fqFGqpTe37tZBTnnoZq3NSsFDAYKEjEBURJDBxEu6Wj0qnUXi
        Dz5xUrnMoHHJFm4LDw1g+Q0tWV78IIzS8zVcnsFlfF07vxRnz5ssdboXqUaPTahRU4JCet
        o3EyLOhlawqulMLqBuWNkddv3SfFchHCnb9e3gBnjGJCn4cGPXFr9hg+R6y1eQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     =?utf-8?Q?Micha=C5=82?= Grzelak <mig@semihalf.com>,
        linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        mw@semihalf.com, upstream@semihalf.com, mchl.grzlk@gmail.com,
        =?utf-8?Q?Micha=C5=82?= Grzelak <mig@semihalf.com>
Subject: Re: [PATCH v3] ARM: dts: dove.dtsi: Move ethphy to fix schema error
In-Reply-To: <20221229180155.99303-1-mig@semihalf.com>
References: <20221229180155.99303-1-mig@semihalf.com>
Date:   Tue, 31 Jan 2023 15:39:28 +0100
Message-ID: <87o7qebwf3.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Micha=C5=82 Grzelak <mig@semihalf.com> writes:

> Running 'make dtbs_check' with schema in net/marvell,orion-mdio.yaml
> gives following warnings:
> mdio-bus@72004: Unevaluated properties are not allowed
> ('ethernet-phy' was unexpected)
> 	arch/arm/boot/dts/dove-cubox.dtb
> 	arch/arm/boot/dts/dove-cubox-es.dtb
> 	arch/arm/boot/dts/dove-d2plug.dtb
> 	arch/arm/boot/dts/dove-d2plug.dtb
> 	arch/arm/boot/dts/dove-dove-db.dtb
> 	arch/arm/boot/dts/dove-d3plug.dtb
> 	arch/arm/boot/dts/dove-sbc-a510.dtb
> As every subnode of mdio is expected to have an @X, ethernet-phy subnode
> in dove.dtsi doesn't have one. Fix these errors by moving ethernet-phy
> into relevant .dts files with correct @<reg address>.
>
> Signed-off-by: Micha=C5=82 Grzelak <mig@semihalf.com>

Applied on mvebu/dt

Thanks,

Gregory

> ---
> Changelog:
> v2->v3
> - edit commit message according to
>   https://lore.kernel.org/all/Y6zuJrb+8j+XCksN@lunn.ch/
>
> v1->v2
> - remove patternProperties: from .yaml
> - move ethphy from dove.dtsi into relevant .dts files
>
>  arch/arm/boot/dts/dove-cm-a510.dtsi | 14 +++++++++++---
>  arch/arm/boot/dts/dove-cubox.dts    | 15 +++++++++++----
>  arch/arm/boot/dts/dove.dtsi         |  5 -----
>  3 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dove-cm-a510.dtsi b/arch/arm/boot/dts/dove=
-cm-a510.dtsi
> index 9b9dfbe07be4..2f2f0a4bf004 100644
> --- a/arch/arm/boot/dts/dove-cm-a510.dtsi
> +++ b/arch/arm/boot/dts/dove-cm-a510.dtsi
> @@ -124,9 +124,17 @@ wifi_power: regulator@1 {
>  };
>=20=20
>  /* Optional RTL8211D GbE PHY on SMI address 0x03 */
> -&ethphy {
> -	reg =3D <3>;
> -	status =3D "disabled";
> +&mdio {
> +	ethphy: ethernet-phy@3 {
> +		reg =3D <3>;
> +		status =3D "disabled";
> +	};
> +};
> +
> +&eth {
> +	ethernet-port@0 {
> +		phy-handle =3D <&ethphy>;
> +	};
>  };
>=20=20
>  &i2c0 {
> diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cu=
box.dts
> index 2639b9fe0ab4..170c14d7f5c8 100644
> --- a/arch/arm/boot/dts/dove-cubox.dts
> +++ b/arch/arm/boot/dts/dove-cubox.dts
> @@ -72,11 +72,18 @@ gpu-subsystem {
>  &uart0 { status =3D "okay"; };
>  &sata0 { status =3D "okay"; };
>  &mdio { status =3D "okay"; };
> -&eth { status =3D "okay"; };
> +&eth {
> +	status =3D "okay";
> +	ethernet-port@0 {
> +		phy-handle =3D <&ethphy>;
> +	};
> +};
>=20=20
> -&ethphy {
> -	compatible =3D "marvell,88e1310";
> -	reg =3D <1>;
> +&mdio {
> +	ethphy: ethernet-phy@1 {
> +		compatible =3D "marvell,88e1310";
> +		reg =3D <1>;
> +	};
>  };
>=20=20
>  &gpu {
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 00a36fba2fd2..c7a3fa33c56e 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -382,7 +382,6 @@ ethernet-port@0 {
>  					interrupts =3D <29>;
>  					/* overwrite MAC address in bootloader */
>  					local-mac-address =3D [00 00 00 00 00 00];
> -					phy-handle =3D <&ethphy>;
>  				};
>  			};
>=20=20
> @@ -394,10 +393,6 @@ mdio: mdio-bus@72004 {
>  				interrupts =3D <30>;
>  				clocks =3D <&gate_clk 2>;
>  				status =3D "disabled";
> -
> -				ethphy: ethernet-phy {
> -					/* set phy address in board file */
> -				};
>  			};
>=20=20
>  			sdio0: sdio-host@92000 {
> --=20
> 2.34.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
