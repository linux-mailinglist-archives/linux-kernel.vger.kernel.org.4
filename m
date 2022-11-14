Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0F628AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiKNUvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbiKNUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:51:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA74117436
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:51:05 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 43C426602995;
        Mon, 14 Nov 2022 20:51:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668459064;
        bh=uXNLHCM03aLMa7/FfCkVUlyKlGAWdJgaKkAtZ5+yamc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFFAu+PEl3Vb9n7w76jCn/xAQq3eXQ+ZK7zW86I9NZhntTvflgLz7M3PGP8oVQSGN
         h/eTDEOjeQZFaL4LQ/bXI6MCw59aRwF57o5L51hs2IQ1M+j86mDJnEOVm4sGZCpMUK
         bFjX0pZzAeKKZkLt5Z93GXB2urcF0pnS28dRYFxF4g67kebBuOxGWqTM0RtvkgIUis
         gPY8UbTk0NolC9J8dZNpu9ajj4zih4ftoz4cE/0otBbF5W1CbiERTZZTU/7lP4/nvM
         Tx/rmoA0H5K1FbJbm8ZXOGcJetB6PkS6xmXbeUPXOFgr4dJoZ+H+xzz+t9+oP8oLm0
         gp5DW2kxjIsVA==
Received: by mercury (Postfix, from userid 1000)
        id 91E87106D188; Mon, 14 Nov 2022 21:51:01 +0100 (CET)
Date:   Mon, 14 Nov 2022 21:51:01 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, carlos.chinea@nokia.com,
        ivo.g.dimitrov.75@gmail.com
Subject: Re: [PATCH] HSI: omap_ssi_core: fix possible memory leak in
 ssi_probe()
Message-ID: <20221114205101.g2jsa2yqfvkyfop7@mercury.elektranox.org>
References: <20221031074337.3712723-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3e4lwatknqhpoyb"
Content-Disposition: inline
In-Reply-To: <20221031074337.3712723-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3e4lwatknqhpoyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 31, 2022 at 03:43:37PM +0800, Yang Yingliang wrote:
> If ssi_add_controller() returns error, it should call hsi_put_controller()
> to give up the reference that was set in hsi_alloc_controller(), so that
> it can call hsi_controller_release() to free controller and ports that
> allocated in hsi_alloc_controller().
>=20
> Fixes: b209e047bc74 ("HSI: Introduce OMAP SSI driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/hsi/controllers/omap_ssi_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/contro=
llers/omap_ssi_core.c
> index eb9820158318..80bf09bc5d15 100644
> --- a/drivers/hsi/controllers/omap_ssi_core.c
> +++ b/drivers/hsi/controllers/omap_ssi_core.c
> @@ -502,8 +502,10 @@ static int ssi_probe(struct platform_device *pd)
>  	platform_set_drvdata(pd, ssi);
> =20
>  	err =3D ssi_add_controller(ssi, pd);
> -	if (err < 0)
> +	if (err < 0) {
> +		hsi_put_controller(ssi);
>  		goto out1;
> +	}
> =20
>  	pm_runtime_enable(&pd->dev);
> =20
> --=20
> 2.25.1
>=20

--u3e4lwatknqhpoyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNyqjAACgkQ2O7X88g7
+poBVw/+MdUgsgBluBEprLrYQKGPuz3jkc9wEi4u3xbtY7iXrKEDXm2mnd9gGuJ2
E9ZtwaxXPIn9F75VLKub4owShXOj0nGWc2HEy2UJIJr5AfZ6NEHYhNT4qghENp1U
IgL4KECiQiCNmbZTyM3hZcKUIAxfafGBrHzPsQyfQ6WqYWa1vnuldJUrMwXsE9wg
qks0TmtX+nty27vI1ZPrLQ7szyOcV73E2FeLWIKhmbj9Mq+H+S2Pd2QDvNs8f9/q
M9BNUn6RvHCHFH7Wci5MYSdk15QurjEiXlFTDnlJYZxrTo2Sblgz8XYT8mndmvWG
VrMKdE2qffG301GjW9v6g+JtGB8gjUzAhC1r517r1PvJ1MIyHSCX2futwrXJF6cC
ITtbsJ1CnDj+NUETuBxmgUisLxnTmZT+RRpWZ0ZSZddR762Y29J3sy4hnZw2/Rqm
QrmR7ZX2fKGoAdsKV8xVpGd5xFA64JbbyJUloubXBQcmquIPEUiBQq8CFlohCuol
OXlIDekPsjiaDjttfdUVrDNafbZsqX9A1rQbXygYiP0I5KA7gxHkXEQJjcfayERw
k9lfNNub+FY96HHaOOzQOa9Y9LcLRhAVL7Pl4+XsLB0u6ZMu/FLtJg4fhs4DGCLv
CKvM77Kxqe57HOahQk3xbNV1sHVRNXFY/RT8RlUn3x96r6mrTjs=
=xtjX
-----END PGP SIGNATURE-----

--u3e4lwatknqhpoyb--
