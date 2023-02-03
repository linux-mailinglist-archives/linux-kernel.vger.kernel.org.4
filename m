Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5AB6898DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjBCMeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBCMee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:34:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8769EE37;
        Fri,  3 Feb 2023 04:33:44 -0800 (PST)
Received: from mercury (unknown [37.81.13.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 800736602F05;
        Fri,  3 Feb 2023 12:33:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675427618;
        bh=FXhmCB/bIqk1+N0Akm0M8iDI1Ss4sOhqHLlhUKQTBUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=buiGKPxVt3plZFQwScvsDiN7Sk3PJO6XnCQcO+WoN/cb2To82L5QSRBCDAkX+Nz2U
         2jOSNBD4jHyb84LQ1FIly4aU+IdL+2jyS2gmGhYi9y5zDqO8zS/OMVFuvbZLI3tjSC
         Chaeuzy4aF8y8K8a33L3pPt0uhCGYNZyhBND4Liufdk6j0Jtke1+ONhjWomGmW/UMg
         yN3qDX1XaZzv2xc/nycSCcl1ZXJFkvdMiXX4H56ISZRPFOU7umKrBtDWbzyWHxRcPA
         HrtK+rYHW342gutxKxh+uuxMxSaiWkFycI/GV/b3j2l2daYE3xEnvZiqVdRlPVRhz8
         DZwWQdXaWQ/Pw==
Received: by mercury (Postfix, from userid 1000)
        id 1DD991060930; Fri,  3 Feb 2023 13:33:35 +0100 (CET)
Date:   Fri, 3 Feb 2023 13:33:35 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hermes Zhang <chenhuiz@axis.com>
Cc:     kernel@axis.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: bq256xx: Init ichg/vbat value with
 chip default value
Message-ID: <20230203123335.rhtanjy5rqdyoewc@mercury.elektranox.org>
References: <20230110024746.2701738-1-chenhuiz@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iolignvmx77gsz3g"
Content-Disposition: inline
In-Reply-To: <20230110024746.2701738-1-chenhuiz@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iolignvmx77gsz3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 10, 2023 at 10:47:46AM +0800, Hermes Zhang wrote:
> Init the ichg/vbat reg with chip default value instead of the max value
> used now. The max value set in driver will result an unsafe case (e.g.
> battery is over charging when in a hot environment) if no user space
> update the value later.
>=20
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---

Thanks, queued.

-- Sebastian

>=20
> Notes:
>     V2
>=20
>  drivers/power/supply/bq256xx_charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/suppl=
y/bq256xx_charger.c
> index 01ad84fd147c..6b5435bf2ed4 100644
> --- a/drivers/power/supply/bq256xx_charger.c
> +++ b/drivers/power/supply/bq256xx_charger.c
> @@ -1563,7 +1563,7 @@ static int bq256xx_hw_init(struct bq256xx_device *b=
q)
>  		return ret;
> =20
>  	ret =3D bq->chip_info->bq256xx_set_ichg(bq,
> -				bat_info->constant_charge_current_max_ua);
> +				bq->chip_info->bq256xx_def_ichg);
>  	if (ret)
>  		return ret;
> =20
> @@ -1573,7 +1573,7 @@ static int bq256xx_hw_init(struct bq256xx_device *b=
q)
>  		return ret;
> =20
>  	ret =3D bq->chip_info->bq256xx_set_vbatreg(bq,
> -				bat_info->constant_charge_voltage_max_uv);
> +				bq->chip_info->bq256xx_def_vbatreg);
>  	if (ret)
>  		return ret;
> =20
> --=20
> 2.30.2
>=20

--iolignvmx77gsz3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPc/x4ACgkQ2O7X88g7
+progw//f45fmq1nosutthvXXaW2A6Fj9IYDo89hAKo2OSVsi8ynMXsu3qVwZk5T
mFlrcGy8zxyNKQNkDbXNJcZugPvNz6S1STK1KThu3tJsu5u/cDQYC9mVzAX4YgLk
zCEEemiS1GEtMGtw/GLPHrIQ3svvAn5DaWJEpgw+CtRrM+XPNRehSsy1U11hmv9K
o/CexVBQCYY5asT5oWO4X1RtXDzSYu/1wFbFQ6Yrm7kagcRxk53Fn5ANRx1sZq+7
fjzFTD/jMgrrO/uj9yUYdQgxHjjNdExBd7HPnBBg2pI2vZBBk46dmUgSITQWhnlN
NUeVfkSM4yKgyTN0FIGNbS59uy55hLjAQpbX7AhnUtrAuF2YPyIb2wisJ0JNj/Rw
CKS1vxlu0/g/7N6dYHxYMJvsOmHi7Va79pAqVLUrHmuLwaooKYHUI/B4ooIBlXrh
8yFbhs/wqeAZDRek8URvo2D4LyGUTIWXvb9a1zV9d58txyit9VCKbstAiROhIcaF
SInSsvC2MJKNg4VgOYxVdq40+GE36/q8IGPsjytQszAUjHoN4xraj+lE9Ixkpr60
INsxDOLMam742prOO6dTcwMvRprYLiBjG2WlVVqfI+LATb99+jST9UcxibeZ2A51
SH9hkrSQxIRkgCwxICJao2JfwhNdSeiBEbu0Yut3yP4ZAj8KCTA=
=Slk1
-----END PGP SIGNATURE-----

--iolignvmx77gsz3g--
