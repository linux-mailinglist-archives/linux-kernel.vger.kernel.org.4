Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A693A6898F1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjBCMhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBCMhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:37:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006113C1A;
        Fri,  3 Feb 2023 04:37:39 -0800 (PST)
Received: from mercury (unknown [37.81.13.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A4E126602F05;
        Fri,  3 Feb 2023 12:37:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675427858;
        bh=R9s6ESmW0Hm/K3UO+BncVs9Xz+j5lpVT7/EFb4N15L8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cyf18UrAigkJdHNrGRUzRxFVXMa4CPOnPHynGJuhhr0rU+POJnPuGzsLPegFV7DB9
         GRpZakfaj2A7+TGAUmHM9sNJ0fCXl3Rx8leAvkX4teMzLgpesPzhn9sV/n3gykc4wf
         8rmMEbsuCJ8X6dSLqtSTjiMQ+VkH1Eifro/Pt948lP7KRitcknFKu9dW79sz+O93ef
         +2B3huv5nOIvsUEzQQ8FhZa+otjuDgDOOWDpyIVikZDFJEMpXDJu2Yo041I8I/sYz5
         ayqRvBM1VxAiUYJo+TkzIk8oKJsQgkgDH3j8To5hA92ji3DGvhunFe/1YlDd4XD3FU
         pA2uUrnIlIzng==
Received: by mercury (Postfix, from userid 1000)
        id 34BBD1060930; Fri,  3 Feb 2023 13:37:35 +0100 (CET)
Date:   Fri, 3 Feb 2023 13:37:35 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     linux-pm@vger.kernel.org, pali@kernel.org, brauner@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] power: supply: bq27xxx: fix reporting critical level
Message-ID: <20230203123735.g727eokllnqxqxft@mercury.elektranox.org>
References: <20230102091326.3959978-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sxu4t5ja4ywc753r"
Content-Disposition: inline
In-Reply-To: <20230102091326.3959978-1-absicsz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sxu4t5ja4ywc753r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 02, 2023 at 11:13:26AM +0200, Sicelo A. Mhlongo wrote:
> The EDV1/SOC1 flag is set when the battery voltage drops below the
> threshold set in EEPROM. From observing the capacity_level reported by
> the driver, and reading the datasheet, EDV1 remains set even when
> EDVF/SOCF gets set. Thus, bq27xxx_battery_capacity_level() never reaches
> the CAPACITY_LEVEL_CRITICAL code path, since CAPACITY_LEVEL_LOW takes
> precedence.
>=20
> This commit fixes the issue by swapping the order in which the flags are
> tested. It was tested with bq27200 in the Nokia N900.
>=20
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 8bf048fbd36a..5ff6f44fd47b 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1917,10 +1917,10 @@ static int bq27xxx_battery_capacity_level(struct =
bq27xxx_device_info *di,
>  	if (di->opts & BQ27XXX_O_ZERO) {
>  		if (di->cache.flags & BQ27000_FLAG_FC)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> -		else if (di->cache.flags & BQ27000_FLAG_EDV1)
> -			level =3D POWER_SUPPLY_CAPACITY_LEVEL_LOW;
>  		else if (di->cache.flags & BQ27000_FLAG_EDVF)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
> +		else if (di->cache.flags & BQ27000_FLAG_EDV1)
> +			level =3D POWER_SUPPLY_CAPACITY_LEVEL_LOW;
>  		else
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
>  	} else if (di->opts & BQ27Z561_O_BITS) {
> @@ -1933,10 +1933,10 @@ static int bq27xxx_battery_capacity_level(struct =
bq27xxx_device_info *di,
>  	} else {
>  		if (di->cache.flags & BQ27XXX_FLAG_FC)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> -		else if (di->cache.flags & BQ27XXX_FLAG_SOC1)
> -			level =3D POWER_SUPPLY_CAPACITY_LEVEL_LOW;
>  		else if (di->cache.flags & BQ27XXX_FLAG_SOCF)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
> +		else if (di->cache.flags & BQ27XXX_FLAG_SOC1)
> +			level =3D POWER_SUPPLY_CAPACITY_LEVEL_LOW;
>  		else
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
>  	}
> --=20
> 2.39.0
>=20

--sxu4t5ja4ywc753r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPdAA4ACgkQ2O7X88g7
+popZg/7Bss64T/oszZI0vrXMH3RLROTdxaY+8wYzgCDIdLoNCZqY2ujbwgoFCsk
Hi+UQijNtLY+4wHw3Vo8SHL3BkNO/A2qPkzeMPwbsRzKuOQSFr114zswplup8Bny
yHwTPEdBOCyZVH3526oSsXoQjwnwPYb+R4nZ6eexbgFO1iNiiGQ5oXGsYS4aFWMB
u1eu5tPrUkXQjP7/pEeyAr/vSuFJosWnAyA0ndaGosxMADi69zCkrTBhKEneAO/8
L0LRS8nZmzrv+nmXJil8xK84BrSXtwLZJF71m1J9Ozm7oCYPNhdjpP+4St1tAqm1
VNcPA3A9Asxw/K4KQ6TATk7gKde8ln7fdRXU8c/T2NBkuDFuEw/nQY/FKGqhxVNs
1CGDRyt2EcoViTzrpnz6pZvJaxvypA90dQYM6C6/7rZmrfRiYb1QIeXnZ3lOXhbi
ml0aHhHnFGmAe8QCkZxWkthFyJPi8zzbNPHhAvxqPjlGlEnlNAB+HV4EcY24z5L5
AvZQx4tEy+BigP/gQHoJ3Xq6i6MAfk92aR1DAEN2+DIaNwfSGBf5VOGqJ4DmjNQF
ZMFWqRZhb5SCNdiUD8Gegf4Z7gpqfQVjzjVqls8c8yXoeQecFGT7qhHXHIyzVchp
lvd41E1h9wDxbs9oqiJUnZIsahZtmodTTtAWIRdRnATUWgqPqDs=
=J924
-----END PGP SIGNATURE-----

--sxu4t5ja4ywc753r--
