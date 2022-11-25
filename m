Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B79C6381E6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 01:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKYAX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 19:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYAXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 19:23:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E94D827D7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 16:23:52 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7C3DA6602B30;
        Fri, 25 Nov 2022 00:23:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669335830;
        bh=Y3cDE74HL25LXJkc3Qvbxd5gs0avRP0bX6/Ee766gpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWiQw9HIKjSgAAU7YdxD+WPvPZ+7QLZXYdjA1ieL4yEm61m21iTTrtKppgpXFVlJQ
         US2llFy/ZcPQf9tTKjiTrON2PVwvNRGzbJUEtDCoBpvipHN+LAPGBbY4hVTTUZLmw3
         Km+TLvQZHTHo58Us/O93xrH0lOoH7AxlyiWG58mBuby05EID3g6MWePapFr4+YajfU
         Rv5Hld+wPJBGL+OYp+CIh31n//qwyJZn3uQgfCay43paLIAkC+9/831OhrFkmWPM8r
         T+FEHeeKR/HDEHzsro0jmstujAbkCj7s4KQN/nviexpRScdTNfYR/PDs+hBvNYqUNd
         HERoOxTQuRbEg==
Received: by mercury (Postfix, from userid 1000)
        id 49C141060933; Fri, 25 Nov 2022 01:23:47 +0100 (CET)
Date:   Fri, 25 Nov 2022 01:23:47 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yuan Can <yuancan@huawei.com>
Cc:     linmq006@gmail.com, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HSI: omap_ssi_core: Fix error handling in ssi_init()
Message-ID: <20221125002347.i2ftoscee43fcb2e@mercury.elektranox.org>
References: <20221124113332.71223-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i4twafufzcgedgco"
Content-Disposition: inline
In-Reply-To: <20221124113332.71223-1-yuancan@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i4twafufzcgedgco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 24, 2022 at 11:33:32AM +0000, Yuan Can wrote:
> The ssi_init() returns the platform_driver_register() directly without
> checking its return value, if platform_driver_register() failed, the
> ssi_pdriver is not unregistered.
> Fix by unregister ssi_pdriver when the last platform_driver_register()
> failed.
>=20
> Fixes: 0fae198988b8 ("HSI: omap_ssi: built omap_ssi and omap_ssi_port int=
o one module")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/hsi/controllers/omap_ssi_core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/contro=
llers/omap_ssi_core.c
> index 052cf3e92dd6..26f2c3c01297 100644
> --- a/drivers/hsi/controllers/omap_ssi_core.c
> +++ b/drivers/hsi/controllers/omap_ssi_core.c
> @@ -631,7 +631,13 @@ static int __init ssi_init(void) {
>  	if (ret)
>  		return ret;
> =20
> -	return platform_driver_register(&ssi_port_pdriver);
> +	ret =3D platform_driver_register(&ssi_port_pdriver);
> +	if (ret) {
> +		platform_driver_unregister(&ssi_pdriver);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  module_init(ssi_init);
> =20
> --=20
> 2.17.1
>=20

--i4twafufzcgedgco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOACw8ACgkQ2O7X88g7
+pqctg//Z9ZyhMv8Lh6EtqW/JHQTWdRcBWJun/60bLMUpNvFjTVfqzC7arpHi30D
OZLI277Ck+M0uJyYESA6J/EkZzTSpA6H9A2xvAolepBq3g9tPtAM2Lzve89fXXLL
8Dbs5JPlD66ZpLTDtA/72ahGzpH5+8UkS0rmHZUDmwb706Qv2fBUTSSmqzJOs5S9
o2zWlxXsPGX4oe7OXyoMQEXfNoc0bRbDc6Ce+9qc1YBUgscACxsN/0b08H9DK2Hh
mvRE0RlUdw1WZ7bAYQV0eqK71DVbeIQMXbkaNulvlsLrs1PeOlKF565OrjqZtR/E
mGE7tCmURugdjj9mfZrVphMVRL/mxOC3L9qHFAPWCZqgC1hKdbDf/acbuXqEhrRf
SIQf3Oo+Ctm46IjV8Dvrg7Azwk564WObhnds/nH/L8Ou2KQvPWyQlu/+mLJGvakM
5f+3KUcrQ7p73ejb+7xrgSnFqElKDx4eyJNiweCaYUpiQPNXtw1kPPnoE8lGjuQA
f5eWins8/Ce2/claP2yhZQ8lrk5DcvQk+6IM818Qr/NgrsmxNASNON66bKnB0Mqz
r16o6sU92s6roLJkOElulGXUhSknD8Jj8PLhvmLNSTMWZ+vebNOcizwijl2W3vIg
wWf8HQBSQrt4gZ3iro6AAy0hF5X24Mut2lilPorXo1JE0v2JBnM=
=Pa2a
-----END PGP SIGNATURE-----

--i4twafufzcgedgco--
