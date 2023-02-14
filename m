Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB1A697063
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjBNWDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjBNWCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:02:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E8330EBF;
        Tue, 14 Feb 2023 14:02:14 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 353E96602167;
        Tue, 14 Feb 2023 22:02:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676412133;
        bh=4Fs1CTHNwLdNQOTNd9vU7qtTg6rYGMVLPMaOXowrgmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UMa24GOVwA8dPGrUC6cp7XGKW4K8IiOoCELMidiTweZfpHRSgN2Wnu+ZN7x7St3hO
         eLPcHPrCxI2udMPhPVzuY4Brfju+MNPmwQ/1KZTkMix4bQMETko/Ny7is+zVUAsTqy
         Rwh9JgNZlz0W2p3mqj0LxzjHdi/8PLnvaullNXwhDO3DAKM9kv6bwYOX1iWEXbxBbv
         0ErWTz+e9E2VxEHbMe3mA/kuUZLp+AHpQyAhDvzeGtYKZuv2g0WL+KcPHPK/yc2inJ
         2BisrtGZ0nRZwB8YBQaRdNNwKuhdU5jOrFbslyUGdSY/+l2/DSM1FhFLR6fK8JquGW
         X1ySpiyFepnPA==
Received: by mercury (Postfix, from userid 1000)
        id 2691510603FE; Tue, 14 Feb 2023 23:02:10 +0100 (CET)
Date:   Tue, 14 Feb 2023 23:02:10 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: remove bogus do_div()
Message-ID: <20230214220210.cpviycsmcppylkgj@mercury.elektranox.org>
References: <20230214132052.1556699-1-arnd@kernel.org>
 <e55c4253-4c55-61cf-a5fd-4284fa164db8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hiuzcppypfku7ewl"
Content-Disposition: inline
In-Reply-To: <e55c4253-4c55-61cf-a5fd-4284fa164db8@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hiuzcppypfku7ewl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 14, 2023 at 02:36:03PM +0100, Konrad Dybcio wrote:
> On 14.02.2023 14:20, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > The argument to do_div() is a 32-bit integer, and it was read from a
> > 32-bit register so there is no point in doing a 64-bit division on it.
> >=20
> > On 32-bit arm, do_div() causes a compile-time warning here:
> >=20
> > include/asm-generic/div64.h:238:22: error: passing argument 1 of '__div=
64_32' from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
> >   238 |   __rem =3D __div64_32(&(n), __base); \
> >       |                      ^~~~
> >       |                      |
> >       |                      unsigned int *
> > drivers/power/supply/qcom_battmgr.c:1130:4: note: in expansion of macro=
 'do_div'
> >  1130 |    do_div(battmgr->status.percent, 100);
> >=20
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Needs to go through the Qualcomm tree:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> >  drivers/power/supply/qcom_battmgr.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply=
/qcom_battmgr.c
> > index ec31f887184f..de77df97b3a4 100644
> > --- a/drivers/power/supply/qcom_battmgr.c
> > +++ b/drivers/power/supply/qcom_battmgr.c
> > @@ -1126,8 +1126,7 @@ static void qcom_battmgr_sm8350_callback(struct q=
com_battmgr *battmgr,
> >  			battmgr->info.charge_type =3D le32_to_cpu(resp->intval.value);
> >  			break;
> >  		case BATT_CAPACITY:
> > -			battmgr->status.percent =3D le32_to_cpu(resp->intval.value);
> > -			do_div(battmgr->status.percent, 100);
> > +			battmgr->status.percent =3D le32_to_cpu(resp->intval.value) / 100;
> >  			break;
> >  		case BATT_VOLT_OCV:
> >  			battmgr->status.voltage_ocv =3D le32_to_cpu(resp->intval.value);

--hiuzcppypfku7ewl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPsBOEACgkQ2O7X88g7
+prd+A//X+1SPhbCa6f+5S3AeQuxbYdH/op6ISuu1PI6aAPY68xx5mtl6EeWCHx4
VqojYvoOcqeowDliEuoFtJgP4tlPXpSm8AVvdbmstqlYW8igFtmzgvgWx1eyaRrl
TuOxtDVR5LQHGsvFTxfUC9QZjjTJVzP3r6yeoPz+QCO3Y3EYfw3f3qZHrM95kYqC
rFMq3S3qUhxmxa9ss7v5WrLyAb+kOetK3a9FHiyC8v5VVkTCkm21mbMPEjpccCAG
L03gb7s9EdThr9t2UHqLvVrnvuuB2O5N/DaUuhuu7+qDwP45AOOQI2Y7c91qy2Ax
XUnP1hTbyskN2JiTyK87ptio1pj4KKbmM5ILCWgLiU1+SKpU3rbKum38gEfB6qmB
YMwveaRiMlCT/qYLFACD1O5gVKfqCy+gcsaOShhOsUXFhdszSBP8YxOFfBK6ytFT
vOX4jblL4HfYzMGiVkNpniXdqngo1cRcNohXYMuU6k1waWkBsgy3vdOuWrFutDY7
G13xALBCCX60wF3D3fRlwchdQXWVhSpwZSXjszRlJ1gnEY/bG0fgQE+BmZmN2di7
2+3A1dkLehiYgZMVS4YwiDmtYiOfzJIu5AO6PIwdxG6F2k1aUGJI/HZcy7YNy5g9
ByKgv9M2qTvlCQNzm+zkmHFqg8xCd+YAzkP87ZMdmc7lYLXCTZo=
=jdxv
-----END PGP SIGNATURE-----

--hiuzcppypfku7ewl--
