Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB8614223
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 01:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiKAAJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 20:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiKAAIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:08:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E7915FFB;
        Mon, 31 Oct 2022 17:08:36 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7BCC366015AC;
        Tue,  1 Nov 2022 00:08:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667261315;
        bh=sIMxUPfqJGh8LEp6SOaWCrB1Uu3hHBT4c08tadHon8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PgubL0ZbBjXBUBmDW7nbZiJcoNQguhntNvQOylREzDEToHAym6DQDyYFP7eW5zqd/
         zCV9heCfvBq828qqT8p3+/YHiP8XJXDT1JfVAURlXOJiWl48nGqWe/3sfrqzlLw65y
         rrwKL10BT6NqyuTmD74eGO8owv22XrsvDQDCQwk9ysGkmkiNCybz/0kHarcVja879j
         GYsdfsYWfWNNfwd89MYJjyf2YOV5N0Nldqk+G8IyvXuHCq2P9QoLTnFfTFBA6p1S5i
         PEfzVrwlSBF2z/UYSryR94XX4Vu0U+4RckkoDvzegM+o2sLoUM95t4M/PxYWeVs0v4
         ya8lRSkgVjwXQ==
Received: by mercury (Postfix, from userid 1000)
        id 5083B1061C6F; Tue,  1 Nov 2022 01:08:33 +0100 (CET)
Date:   Tue, 1 Nov 2022 01:08:33 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Ondrej Jirman <megi@xff.cz>,
        "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] power: supply: ip5xxx: Fix integer overflow in
 current_now calculation
Message-ID: <20221101000833.hwuhc7ki6b33fnhf@mercury.elektranox.org>
References: <20221028224052.293693-1-megi@xff.cz>
 <6b23af14-340d-b7b5-7d20-14fae03f724c@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7sslbaiyftedhb4w"
Content-Disposition: inline
In-Reply-To: <6b23af14-340d-b7b5-7d20-14fae03f724c@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7sslbaiyftedhb4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 28, 2022 at 06:06:07PM -0500, Samuel Holland wrote:
> On 10/28/22 17:40, Ondrej Jirman wrote:
> > When current is larger than ~2A, the multiplication in current_now
> > property overflows and the kernel reports invalid negative current
> > value. Change the numerator and denominator while preserving their
> > ratio to allow up to +-6A before the overflow.
> >=20
> > Fixes: 75853406fa27 ("power: supply: Add a driver for Injoinic power ba=
nk ICs")
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
>=20
> Reviewed-by: Samuel Holland <samuel@sholland.org>
>=20
> > ---
> >  drivers/power/supply/ip5xxx_power.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply=
/ip5xxx_power.c
> > index 02ee4d252a3e..f39cb2f7aa11 100644
> > --- a/drivers/power/supply/ip5xxx_power.c
> > +++ b/drivers/power/supply/ip5xxx_power.c
> > @@ -398,7 +398,7 @@ static int ip5xxx_battery_get_property(struct power=
_supply *psy,
> >  		ret =3D ip5xxx_battery_read_adc(ip5xxx, IP5XXX_BATIADC_DAT0,
> >  					      IP5XXX_BATIADC_DAT1, &raw);
> > =20
> > -		val->intval =3D DIV_ROUND_CLOSEST(raw * 745985, 1000);
> > +		val->intval =3D DIV_ROUND_CLOSEST(raw * 261095, 350);
>=20
> DIV_ROUND_CLOSEST(raw * 149197, 200) would be marginally more accurate,
> but it doesn't matter in practice.

Thanks, I queued it with that change included.

-- Sebastian

>=20
> >  		return 0;
> > =20
> >  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>=20

--7sslbaiyftedhb4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNgY4AACgkQ2O7X88g7
+prRfA//dU4GytovELqDppXXyxa26eg1cfkrNdYZcsa/z1LZkgKuHF6cdG620W8M
Tmnna2OU9L5JIdsgx0Ub6qsemzWUBlCuUUNzJxVjir0TkxliAttV5W5tBIC23YKp
X0h2Nw63lf4kFpq6RG8KPMKbdgtVvN8JNiuffner4xE0dg0Xc8Tew2XjvPzXpItL
pwvkeT9wef3m5k3ZX1U8hWfMot3PJiUiMftRHuAtgPBiWi1QECxNRWUXOWSEFhIW
b9ghREIpay4RqMXVJssRw4b/eyvSqTvpImswCF8jelyyQEgdDrwsiUyd/3MGwRql
ABawQyUc8J2A1opOWmCQyXfqXqhA1pEXfhwgJWc9Ooz0lI2YSVWxZlMR4XNoOkzM
hWSrSWOiKfEHJ3dL56F6Dv1a6unmmMpj8kCjyWXHbgYU/eFTOJmGv23L0Yq+MrCG
ZDnIDHP4Q6D2HeSOywLDwrqexSFj8lg8JsZZMPI2ZBoFl+bbCE97hmnoTSoDhEAA
zuayfSbnAPsIubAS/c6gi+cp9/iGXVOCqHDuNkivKG+543wZSJKrX2jsSXy/iFLl
8RSZQr3c0u537Ae+MWy1MBkPGYbja/kYxkxesCJ0GrmSNM3BKfOF4KWBAaiJAHyL
p7plxduZcTGsglePNcMfBvDvliyOddUH0TvundPoUlgvZIN9FxU=
=s9pm
-----END PGP SIGNATURE-----

--7sslbaiyftedhb4w--
