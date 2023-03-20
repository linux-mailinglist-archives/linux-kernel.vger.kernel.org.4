Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9AD6C22B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCTUbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCTUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:31:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF767302B0;
        Mon, 20 Mar 2023 13:31:43 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D07766030C8;
        Mon, 20 Mar 2023 20:31:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679344302;
        bh=s7CYBvYyGNlo/VcMuF6h4dZdwwUmXoIDvCcA1AEGRkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqBF5cGXcyGt6P1z1sjHv+1wBSLhpJHmQ/LeqgOavK2dHc23vOIOHPif9yfQhVKro
         gCUF0tpetzmV5e/nJybYEbtUvaaQWMOjLFgKGCtBVALjICz2q9ExvRiUSZcuttHZit
         +PwNnVBUVrIB4++E9tRHBeVdqyJsNsnsv/uksJTGgwqRaJhpHnQiNItAPcK8xRgZJO
         Oh3bv9gfI5XvVu3tEnUOn0yuSWy4mmkN8Ky1jBezWWNdbUqqvo/ZNmargJ3ZE4MNoL
         g+0Z5o8EEaufYzisWhWeUyKEMj46ic+i94hsoOd5PWwVvYXzAQSZG4mcLfSxd1KoAS
         zchMZWwPp0lYQ==
Received: by mercury (Postfix, from userid 1000)
        id A9A561062101; Mon, 20 Mar 2023 21:31:39 +0100 (CET)
Date:   Mon, 20 Mar 2023 21:31:39 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
Subject: Re: [PATCH v2 3/3] usb: typec: tcpm: add get max power support
Message-ID: <20230320203139.quld3gmoo6esu56i@mercury.elektranox.org>
References: <20230320100711.3708-1-frank.wang@rock-chips.com>
 <20230320100711.3708-4-frank.wang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="66pi6y36yvyohmnf"
Content-Disposition: inline
In-Reply-To: <20230320100711.3708-4-frank.wang@rock-chips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--66pi6y36yvyohmnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 20, 2023 at 06:07:11PM +0800, Frank Wang wrote:
> Traverse fixed pdos to calculate the maximum power that the charger
> can provide, and it can be get by POWER_SUPPLY_PROP_INPUT_POWER_LIMIT
> property.
>=20
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 13830b5e2d09f..d6ad3cdf9e4af 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6320,6 +6320,27 @@ static int tcpm_psy_get_current_now(struct tcpm_po=
rt *port,
>  	return 0;
>  }
> =20
> +static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
> +					  union power_supply_propval *val)
> +{
> +	unsigned int src_mv, src_ma, max_src_mw =3D 0;
> +	unsigned int i, tmp;
> +
> +	for (i =3D 0; i < port->nr_source_caps; i++) {
> +		u32 pdo =3D port->source_caps[i];
> +
> +		if (pdo_type(pdo) =3D=3D PDO_TYPE_FIXED) {
> +			src_mv =3D pdo_fixed_voltage(pdo);
> +			src_ma =3D pdo_max_current(pdo);
> +			tmp =3D src_mv * src_ma / 1000;
> +			max_src_mw =3D tmp > max_src_mw ? tmp : max_src_mw;
> +		}
> +	}
> +
> +	val->intval =3D max_src_mw;

The power-supply subsystem expects Microwatts and not Milliwatts.

-- Sebastian

> +	return 0;
> +}
> +
>  static int tcpm_psy_get_prop(struct power_supply *psy,
>  			     enum power_supply_property psp,
>  			     union power_supply_propval *val)
> @@ -6349,6 +6370,9 @@ static int tcpm_psy_get_prop(struct power_supply *p=
sy,
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		ret =3D tcpm_psy_get_current_now(port, val);
>  		break;
> +	case POWER_SUPPLY_PROP_INPUT_POWER_LIMIT:
> +		tcpm_psy_get_input_power_limit(port, val);
> +		break;
>  	default:
>  		ret =3D -EINVAL;
>  		break;
> --=20
> 2.17.1
>=20

--66pi6y36yvyohmnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQYwqQACgkQ2O7X88g7
+pr4MA/+M+jXCp3I5L6jnFZlxxpp9QCdddeBXrwdLXCztKOERqlrsCkmlRZ8tFjo
HQF4ny3kByXQrN0fTO27zwfKG8eqUgAiRF3GRtT3PsDWlMNLcbW/VXDqmGU8LUU9
djzrLkoPkZqUiwdImfF1FiJguiVGmMFyxf4HZlvyIkQqLFTdb19xo0Mcfa+/7ynf
ptJe7w06AEvr1bsDfN5NB5TWM1V+AQNiwrHx43jVKIUzFqFq609/dPgOt60D1Zx6
T6wZ7HBiLDY6Ak/s1AhmoxX/3Mx2E/Ppi9SDebg6+n3kblU3JaXVHYSmck3y/VJF
zrjUajYfor6bc2kSSHN/iQumR4O8Cn23DCIKvJElDqNEvrtHZQXwLXLfXRxRpn0K
cV9bFz+UF5g5R4ASf8OeaRjEoEgiY4Qe9IPeus38haVm6fqzrjSUHe5IhrEJSErT
WjlvLhzJKBouPypxx32Xn9mSoyGv8JKuOJ70fgOsI+EIileRg8UpycY8q+imL8Ep
xu/yGYkHCt53AyPW1cTXye4YvKj+e8qqGOK4c7S34Bd5HyjVdZ2IHi0EMe3k7aEZ
6Vu7iL/ds1M/OQCl4QnQb7uRxn5SwEbB8jNf7YL6HB3M2piO3AE3JLyWDixT0sFB
RYQMpupJ+LwUyGVqoTXkXmMlwdYyOtu6CWjMgiwmDfVfghFs6Tk=
=S/7y
-----END PGP SIGNATURE-----

--66pi6y36yvyohmnf--
