Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246EA5B6BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiIMKp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiIMKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:45:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC43252FEA;
        Tue, 13 Sep 2022 03:45:51 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E566660201C;
        Tue, 13 Sep 2022 11:45:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663065950;
        bh=XWn2qZ896q9hiNdpJzo3kQstEZh6ow+Bn3ZdhaKw+ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxYSH/wwoOVu7eMsDEbZCJptFfclJd1uiCHQy7w/ifFfgHvtr4p2qQTH04DvcJw6E
         Z3GrA/gQGdoDc4amz9GXE8VtzqvnnYTluPrMzp8/lCOP74rvXVeRL66hkwbb+LSAoO
         ybL47dYOZJxZZGEMaPCHroXU4XK2pK4wbqU5OTaUeA4lumToYy+T4YZz1NKTqD3GKx
         4mozVf3zRlxy0rJHp0QApTSvQY3gANJR3hjXKW6c/So7ENXIBFKz3fLg86be/wBrqQ
         5rhDuooxBXe7odVCugfzWXnqmYpFXh7E24qY6vnSag0xmT3btzJOQMbE+ejqq3EoSn
         v52OSHcxqM0Ow==
Received: by mercury (Postfix, from userid 1000)
        id 3A2B7106084A; Tue, 13 Sep 2022 12:45:45 +0200 (CEST)
Date:   Tue, 13 Sep 2022 12:45:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lee Jones <lee@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] power: supply: Add Lenovo Yoga C630 EC driver
Message-ID: <20220913104545.2u6mcyy3bg4dp6ly@mercury.elektranox.org>
References: <20220810030500.2793882-1-bjorn.andersson@linaro.org>
 <20220810030500.2793882-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ur2qv5grzx22o5g"
Content-Disposition: inline
In-Reply-To: <20220810030500.2793882-3-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ur2qv5grzx22o5g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

[+Cc Lee Jones, DRI devel]

On Tue, Aug 09, 2022 at 10:05:00PM -0500, Bjorn Andersson wrote:
> The Qualcomm Snapdragon-based Lenovo Yoga C630 has some sort of EC
> providing AC-adapter and battery status, as well as USB Type-C altmode
> notifications for Displayport operation.
>=20
> The Yoga C630 ships with Windows, where these operations primarily are
> implemented in ACPI, but due to various issues with the hardware
> representation therein it's not possible to run Linux on this
> information. As such this is a best-effort re-implementation of these
> operations, based on the register map expressed in ACPI and a fair
> amount of trial and error.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> [...]
> +	val =3D yoga_c630_ec_read8(ec, LENOVO_EC_BAT_ATTRIBUTES);
> +	if (val < 0)
> +		goto out_unlock;
> +	ec->unit_ma =3D val & LENOVO_EC_BAT_ATTR_UNIT_IS_MA;
> +	if (!ec->unit_ma)
> +		ec->scale =3D 1000;
> +	else
> +		ec->scale =3D 1;

Since I'm not sure how much of information was gained by reverse
engineering: Is this really milliamps vs microamps and not milliamps
vs milliwatt? SBS batteries usually report either mA or mW.

> [...]
> +	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> +		val->strval =3D "05072018";
> +		break;

why is this hardcoded? :)

> [...]
> +	device_for_each_child_node(dev, fwnode) {
> +		ret =3D fwnode_property_read_u32(fwnode, "reg", &port);
> +		if (ret < 0)
> +			continue;
> +
> +		/* Got multiple ports, but altmode is only possible on port 1 */
> +		if (port !=3D 1)
> +			continue;
> +
> +		ec->bridge.funcs =3D &yoga_c630_ec_bridge_funcs;
> +		ec->bridge.of_node =3D to_of_node(fwnode);
> +		ec->bridge.ops =3D DRM_BRIDGE_OP_HPD;
> +		ec->bridge.type =3D DRM_MODE_CONNECTOR_USB;
> +
> +		ret =3D devm_drm_bridge_add(dev, &ec->bridge);
> +		if (ret) {
> +			dev_err(dev, "failed to register drm bridge\n");
> +			fwnode_handle_put(fwnode);
> +			return ret;
> +		}

I wonder if DRM people want to see this in drivers/gpu/drm/bridge.
Maybe it's better to make this a MFD driver?

> [...]

-- Sebastian

--6ur2qv5grzx22o5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMgX1QACgkQ2O7X88g7
+pr5vQ//fDjgrXSthbPeBloXcYtJikgwQMMWl0FwW5NYB29nx5TezAmEzspHNNIM
0gldgNtpsQeNWKmkjvXwdBAs2KaApf9kxIEZJx/CxLO1bgm8FtWmqkCVdevXMonr
Xyg+JF+nmbQsV9tYGNljoGsA/OxfjzKPEZKGSxZaA+8o9LPZYYssvJJFJ7BId+/8
HVc1Ac5ODJWSeNseyzM93BTQb62EsaQFj4Rvi01CCSGVQdEWkHPEirNlwlCx4IKf
8vZ5IHiELU7YwRJ9pTJHUvrioD49+n1UdewOAvVHdpo+jDpxIpSKotfsY1AaZw+n
Ls7mS8wPJRoy22+Ooo53FdrdYY5pRKLCMSJOoSnvuixkhBEL+2NTb5dDjDjIJ15x
M5fOQvWs5xavZbEjaiF63gXL+4dvzXVZ6hKhULrZYSPtEvjeg4ThND2HkzyO8M/x
MZ1qVYdFx9Ux86gBD6gEeFajnXpFqTDPq8zskHqZje3+5VmJUtX3wZJyhuixHfSb
0kThEoByuJsRjEpldK0kp5jnX4MNkBAMPDGKu0zdjUppJh1ixB6gqelNj/eUHdr0
iYm2KVlx6oLvMqmBTf7TgFZdAF6hjYee43eLnwBVN9UxLcT4CRgmQbll/MEDeuN8
OHK9qivKSMUQQ6q/dr7tUu3sAg6WOPfBFh8m4LdEjPIAVDkPd3c=
=jQoj
-----END PGP SIGNATURE-----

--6ur2qv5grzx22o5g--
