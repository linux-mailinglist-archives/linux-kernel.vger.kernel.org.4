Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580766898FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjBCMq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCMq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:46:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6FF9AFEA;
        Fri,  3 Feb 2023 04:46:26 -0800 (PST)
Received: from mercury (unknown [37.81.13.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C1AAB6602F0F;
        Fri,  3 Feb 2023 12:46:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675428384;
        bh=eSr8KydWD2KO8r7TtN+Y+lpNdNVAYRGafaRB2qGXUTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkYYj+rFFgufgBiKAos8KdwI0MBVQmOCvulW0MQbnQ7azZzSoBzvzeCTcI7foLcHZ
         Iar22OQOWp3hZh241dgbYQRbpxwtqPdXmDP6ozRPgclv9FWa8+yaRYoQ0XOqJ6CaLR
         cIKanNrHRlbLvclE9cgOn/Ed2nzJEbnwWXIFSMkFE8RvXgBrzGgwlPoI0noHO6zDbk
         0gZoAly9b4L+EZQrG7HvM89q44ubC5P8HiFgeSuTTueFu6p/e7VFaucO2/lnDuN8qe
         kpODFfYBVFSqm2TGIVR52k++yglsrZ2ZD4XLPcAtwcqjSQGEwZ1gwFKOG3inzbzKK1
         6b5bEumTPk4mA==
Received: by mercury (Postfix, from userid 1000)
        id 083561060930; Fri,  3 Feb 2023 13:46:22 +0100 (CET)
Date:   Fri, 3 Feb 2023 13:46:22 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     yang.yang29@zte.com.cn
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] power: supply: test-power: use strscpy() to
 instead of? strncpy()
Message-ID: <20230203124622.fgvo2udbrto3grwv@mercury.elektranox.org>
References: <202212231042356202397@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zk4n2uiiwvyoynwj"
Content-Disposition: inline
In-Reply-To: <202212231042356202397@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zk4n2uiiwvyoynwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 23, 2022 at 10:42:35AM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
>=20
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
>=20
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/test_power.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index 5f510ddc946d..0d0a77584c5d 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -306,8 +306,7 @@ static int map_get_value(struct battery_property_map =
*map, const char *key,
>  	char buf[MAX_KEYLENGTH];
>  	int cr;
>=20
> -	strncpy(buf, key, MAX_KEYLENGTH);
> -	buf[MAX_KEYLENGTH-1] =3D '\0';
> +	strscpy(buf, key, MAX_KEYLENGTH);
>=20
>  	cr =3D strnlen(buf, MAX_KEYLENGTH) - 1;
>  	if (cr < 0)
> --=20
> 2.15.2

--zk4n2uiiwvyoynwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPdAh0ACgkQ2O7X88g7
+pq2xhAApLxSAyVBQTFenESoqlz0STQImWJtHJbcuSNHe9u2X3mii4USzEkToPxY
cTUHwwdrsMsGAxioVXhvjaXf/wNLc0yxVW8qYzxwPJes9BgyCfatVNJBpRwoCBos
n72VYGJ+F4wirBp4zHGs1MxFOJ4jRKiDnyYVzNi1NlHKkVIX2Z+jxuuEsHWnw5zf
7aS7bGwJhvYW4KXbWRoaHYu9ZgOxPJkdCko4sYSjs2BIIhpeZtgCAGAZGgFbZOeV
R8+NlRuHfe6HuVTbXAmBnuzAmEW5JCm1W3HE1equOsWK37mAlgd00KkyRv3G4+7H
yNlT56rGPDiPJf3MdwNAyMR6KYK0Z8NNbdqnWs1J/lDQMKv+kUFwZ7lUrMrwdYDo
TPZC7tg4KyFpkh2TF+xXwA++mtcm1dV/gDmfPf2W5mT4g9Pvie6DoDf981xa/tM7
AmtJXiQtLptriXJjuzVFa8c34O1tgr8J30AylBJXtVZcZzLTLq9/dOea+K7un3y3
tWoAS4H0zObO4GDqfU6fYCgFltQ2RQ0k4vNaBuVtA43DTFjg2frrT0LfEItRhxPr
7AF9xz17thDm+Fxdx0C7ABS8xKJFaMrjYMu+8fbQnE/OPDn7N3ZrulG9sAZg+f6T
aYXyz60p5QlRtSDgeAyAqRuL056yuHBCTYnjH2ieLXPWc9Hf2ZE=
=1m5F
-----END PGP SIGNATURE-----

--zk4n2uiiwvyoynwj--
