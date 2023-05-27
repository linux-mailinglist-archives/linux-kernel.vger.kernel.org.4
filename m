Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A63F7135CF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjE0QyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 12:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjE0QyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 12:54:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1AAB4
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 09:54:23 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8897566032BE;
        Sat, 27 May 2023 17:54:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685206461;
        bh=qn0ML4/wiO4AHpUtAb0UYv1mXk/9b5GJLYRXKstcQ9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZor8Ntd/bcOqHd8iTiIrZy2BNlsBSo7hisWrxdQLv/eV1cgVFGaznb4Qwvx8tk1v
         OWZTawVg60FcAPLg9J59tQ8F4hHM2JzL+qvk24QZefXOAEx+At88BGTNrC6yiqF+Cj
         GvndkYE2Rpn+thu0rPuEhk8UL0HSufADGOf+tkXJOVRb1rJP0m8Rzbpgomapi05CXW
         aFEDngvWosgB0IPW13GOUdG9hLke6vt0pIJ78TKeSyqKYQeU1z6rYIhHbS1N7WkGC7
         3P9L5L53rRIPIV2S+4rx79rR25njKHab8OEQ30zzw1TrT7cBySR6CA3T+/HXkiyS/6
         jBxCOtDyOVQ0w==
Received: by mercury (Postfix, from userid 1000)
        id 2BA4910673D7; Sat, 27 May 2023 18:54:19 +0200 (CEST)
Date:   Sat, 27 May 2023 18:54:19 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     jinpu.wang@ionos.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omap_ssi_port.c: Drop error checking for
 debugfs_create_dir
Message-ID: <20230527165419.a36qup5bsjrthtsb@mercury.elektranox.org>
References: <20230525153837.13198-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ib4dvrbqklh6mkn7"
Content-Disposition: inline
In-Reply-To: <20230525153837.13198-1-osmtendev@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ib4dvrbqklh6mkn7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 25, 2023 at 08:38:37PM +0500, Osama Muhammad wrote:
> This patch fixes the error checking in spi-dw-core.c in
> omap_ssi_port.c. The DebugFS kernel API is developed in
> a way that the caller can safely ignore the errors that
> occur during the creation of DebugFS nodes.
>=20
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/hsi/controllers/omap_ssi_port.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/contro=
llers/omap_ssi_port.c
> index 7ad41599baa5..8feb91d256fd 100644
> --- a/drivers/hsi/controllers/omap_ssi_port.c
> +++ b/drivers/hsi/controllers/omap_ssi_port.c
> @@ -151,23 +151,20 @@ static int ssi_div_set(void *data, u64 val)
> =20
>  DEFINE_DEBUGFS_ATTRIBUTE(ssi_sst_div_fops, ssi_div_get, ssi_div_set, "%l=
lu\n");
> =20
> -static int ssi_debug_add_port(struct omap_ssi_port *omap_port,
> +static void ssi_debug_add_port(struct omap_ssi_port *omap_port,
>  				     struct dentry *dir)
>  {
>  	struct hsi_port *port =3D to_hsi_port(omap_port->dev);
> =20
>  	dir =3D debugfs_create_dir(dev_name(omap_port->dev), dir);
> -	if (IS_ERR(dir))
> -		return -ENOMEM;
> +
>  	omap_port->dir =3D dir;
>  	debugfs_create_file("regs", S_IRUGO, dir, port, &ssi_port_regs_fops);
>  	dir =3D debugfs_create_dir("sst", dir);
> -	if (IS_ERR(dir))
> -		return -ENOMEM;
> +
>  	debugfs_create_file_unsafe("divisor", 0644, dir, port,
>  				   &ssi_sst_div_fops);
> =20
> -	return 0;
>  }
>  #endif
> =20
> @@ -1217,11 +1214,8 @@ static int ssi_port_probe(struct platform_device *=
pd)
>  	pm_runtime_enable(omap_port->pdev);
> =20
>  #ifdef CONFIG_DEBUG_FS
> -	err =3D ssi_debug_add_port(omap_port, omap_ssi->dir);
> -	if (err < 0) {
> -		pm_runtime_disable(omap_port->pdev);
> -		goto error;
> -	}
> +	 ssi_debug_add_port(omap_port, omap_ssi->dir);
> +
>  #endif
> =20
>  	hsi_add_clients_from_dt(port, np);
> --=20
> 2.34.1
>=20

--ib4dvrbqklh6mkn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRyNbcACgkQ2O7X88g7
+poa2g//USA64K3GRrQoXtqCMlawfoSiF5fSRQ5KXlZtOjUY/WbIUyyklybj77Vi
0jSonUZdQo43Qg+s4R+pDbVX3Nv+ch1XGjQc11ZAlzYb9O9ff/WXdrJINiD6EXTZ
mEjUWzfZc5Oqrgsp+W901OZfNbKus8POrckG0uTGdkRPM3FGmU2A/352piIg3jxj
ElKMF8tK7Dl3xLE4ZQaX3N8OqLephlVRgQC1uLubk4XRFeMbfI3LBvin8fBm708X
e4dJiXcGxXFZa1QVr4pR3r+1m3/JY0S5mw+yNC9FwSBGmEB+QvuJmdE7jtSa2Rja
9bSIB1xdq8CMn7ILLuKRiRk1KIA5o+1JCDoN2TDhXprPGY2PfHcFxib0XnRDAJ5v
F5F64gQC9etHaoiHBN4LJaSt/RA+7ZIynhB6zURv5L/GPxQySljaG8KXdYh0nQpM
IoHIk3kOmm8aP/qaat4BqHGf0bi2If0ISDvfVYvvBgH0iiWelSgNouPML7BtOg+s
RZZDc64f2CpdeBmlBJKSM0gFPifK76TaIyuP0XYjbMuvLtNdRGnnpRTGWnuLHyLl
wLhq9lZ01dF/Jy7pfA9FkRA3mR4lJhYYHOeWGgjG+CDvumqkKicWClbYl4YJOIta
+pwlSUy3eLzaaaaeTxL2EA/u/hK+7IDweBZAbZgxhWfnyEB7EuQ=
=IosC
-----END PGP SIGNATURE-----

--ib4dvrbqklh6mkn7--
