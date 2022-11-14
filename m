Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1AB628AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbiKNUvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbiKNUva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:51:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412B17E00
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:51:28 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9BD5E6602995;
        Mon, 14 Nov 2022 20:51:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668459086;
        bh=dO6CtGXj7OOa61Ap9hNkeqI9UIZKPSJEtPjo1nMFcQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WkDl8CEy8QwIwYqgNdf8K4xpSq6Djn60F5df8r38A7hY/1Vqgf+hpYlE2YJ/ey2SA
         hW5fXq6SetrS6mIc7ihB1iLpPfj4gvmY26Z2fNqpKi2UaLc1rRSLEfWknUmKUnuOxI
         y0XMaSlVWeQYU6Wr15V3AoocB+7tzvM0lJ7D1ea14tFSfp/YzLbQFw2asLOWVTa3pI
         v3SLboMTNwU8oJIEnLrKkwZFP3UNfKzoMhxdPy45Pub8IdZGnPIfc2CvozGDS0Tpk4
         MBpNb3KJMm5BzQ65O8qqzBSPBb80p/zWLfVGFGCGMLoG8wBxxoGRH+IyhcGYR4uwYm
         LPcuiamW2/wYw==
Received: by mercury (Postfix, from userid 1000)
        id 2832D106D188; Mon, 14 Nov 2022 21:51:24 +0100 (CET)
Date:   Mon, 14 Nov 2022 21:51:24 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, carlos.chinea@nokia.com,
        ivo.g.dimitrov.75@gmail.com
Subject: Re: [PATCH] HSI: omap_ssi_core: fix unbalanced pm_runtime_disable()
Message-ID: <20221114205124.xqce2uz3ktegsqlk@mercury.elektranox.org>
References: <20221101034118.1331731-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r32vrrrwbwah6ro3"
Content-Disposition: inline
In-Reply-To: <20221101034118.1331731-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r32vrrrwbwah6ro3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 01, 2022 at 11:41:18AM +0800, Yang Yingliang wrote:
> In error label 'out1' path in ssi_probe(), the pm_runtime_enable()
> has not been called yet, so pm_runtime_disable() is not needed.
>=20
> Fixes: b209e047bc74 ("HSI: Introduce OMAP SSI driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/hsi/controllers/omap_ssi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/contro=
llers/omap_ssi_core.c
> index 80bf09bc5d15..052cf3e92dd6 100644
> --- a/drivers/hsi/controllers/omap_ssi_core.c
> +++ b/drivers/hsi/controllers/omap_ssi_core.c
> @@ -538,9 +538,9 @@ static int ssi_probe(struct platform_device *pd)
>  	device_for_each_child(&pd->dev, NULL, ssi_remove_ports);
>  out2:
>  	ssi_remove_controller(ssi);
> +	pm_runtime_disable(&pd->dev);
>  out1:
>  	platform_set_drvdata(pd, NULL);
> -	pm_runtime_disable(&pd->dev);
> =20
>  	return err;
>  }
> --=20
> 2.25.1
>=20

--r32vrrrwbwah6ro3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNyqkgACgkQ2O7X88g7
+pqh2Q/8DuFENbVzl47GIMroiMORBXZzZOaRmMWO6HYAG+4aDYFzfBGn7nH2TzKW
TaKQMp/ul8E4zTJHbp3C7u4N/XwKrNPE6FpPJr7JupRUQpE9VJBcXc7tUO1w+yhp
zAR9aCCw2mFVo+Vft0kvYyy8/qM0jVtbiwHwQpOzZil2uqluRftEQz5VYrJNya7z
xugmW0OQvJ/WkqnkeBqzaCd8Buv2qGwkYjvvWDLJOyj5VgPH4kDORwk0CwaB0qOc
+cuPkNOjCIM6BFGAbdoMrDDU8ycTNwAueWQj9c5JdTIZPR+ynpqBYM8S1gD8ycuD
tyAli2xyqAroW3ni48lQUki3CofGziWDDaQIEB/ihqXd8FzBcGV4JhkjeOU5SnqP
/g1sl64Xk4Lwn4K0rISwaQvxTvND2HrHejCoE0cJrr2dJr0EpU4CgppS2KAAKNca
gIv8JWJlA5zZumW4fJ/d2UJccewBRPmQnSYtBNYHzWDX4wXhil2aDHyrLaI6UdU9
yXE5QTH1f6Z/3xExtm6LaR86N/MBuIMJsQFPk3L7I66l7bC+4ob48x5O9CqaiA8M
8YHpgPHsy3KYC2sW3zQ/Fpj4YLrZDgJ6O1Cfgiqh3YHxA2MOkp9tmKDXfSv0Kcds
nkHMilbNUtgsbo1azlO2MpSOnDeDPpB51uI4SA0HCjCtvXLXiYM=
=2/5V
-----END PGP SIGNATURE-----

--r32vrrrwbwah6ro3--
