Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AC6710C95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbjEYM5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjEYM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFAE183
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 562D564081
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAA9C4339E;
        Thu, 25 May 2023 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685019409;
        bh=i3jmjwyZnPca93skmInUGTJwx36Md+4xOabqF4P++OY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRn4F7j1tJpKrKZOaStMoXT8YSXv13bpe0LG2jUZjUpXA7icJrWEDYyLHlnWnKFm6
         VvB08fs/6eeFUt1hZRk7LnqJ4YlNpgjvT78EDBapulwnRMR0+wf3ubSoqVm9x5ucKM
         eNkgfGIb0RhJAWWJJ2RsYT18Yq9nt7IC1R4ty7evr9HGjbhLISz06KtWnFse72glYY
         a08FG2YBOq9M2I5NOHKqmW2tYlyDMtbAQEz1wic5RPcySFBN0H5VtlYIxN0nYnqguP
         h+JYwhIlxJKQuj+7mKgYoNPobL4eQx1tVsVlUW9skxtXeRzoQ7SC0AHnu1B6UYPB4S
         ZBL8KZi88zvvQ==
Received: by mercury (Postfix, from userid 1000)
        id A2D381060A3F; Thu, 25 May 2023 14:56:46 +0200 (CEST)
Date:   Thu, 25 May 2023 14:56:46 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     jinpu.wang@ionos.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omap_ssi_port.c: Fix error checking for
 debugfs_create_dir
Message-ID: <20230525125646.f4rfjb2limbtuh2c@mercury.elektranox.org>
References: <20230523172434.13477-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="thqsfdjzhqzzc6kc"
Content-Disposition: inline
In-Reply-To: <20230523172434.13477-1-osmtendev@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--thqsfdjzhqzzc6kc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 23, 2023 at 10:24:34PM +0500, Osama Muhammad wrote:
> This patch fixes the error checking in omap_ssi_port.c in
> debugfs_create_dir. The correct way to check if an error occurred
> is 'IS_ERR' inline function.
>=20
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---

This masks the error code. But the proper fix is to just ignore any
errors as the help text for debugfs_create_dir() explains. Please send
a new patch removing the 'if (!dir) return -ENOMEM;'. Also the
function can be changed to be of type void afterwards.

Thanks,

-- Sebastian

>  drivers/hsi/controllers/omap_ssi_port.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/contro=
llers/omap_ssi_port.c
> index b9495b720f1b..7ad41599baa5 100644
> --- a/drivers/hsi/controllers/omap_ssi_port.c
> +++ b/drivers/hsi/controllers/omap_ssi_port.c
> @@ -157,12 +157,12 @@ static int ssi_debug_add_port(struct omap_ssi_port =
*omap_port,
>  	struct hsi_port *port =3D to_hsi_port(omap_port->dev);
> =20
>  	dir =3D debugfs_create_dir(dev_name(omap_port->dev), dir);
> -	if (!dir)
> +	if (IS_ERR(dir))
>  		return -ENOMEM;
>  	omap_port->dir =3D dir;
>  	debugfs_create_file("regs", S_IRUGO, dir, port, &ssi_port_regs_fops);
>  	dir =3D debugfs_create_dir("sst", dir);
> -	if (!dir)
> +	if (IS_ERR(dir))
>  		return -ENOMEM;
>  	debugfs_create_file_unsafe("divisor", 0644, dir, port,
>  				   &ssi_sst_div_fops);
> --=20
> 2.34.1
>=20

--thqsfdjzhqzzc6kc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRvWwEACgkQ2O7X88g7
+ppt8hAAk2PTNjGFlYd6h3hSQhJ8lwjxNdtDToPXUdXukbpQw74/bSUFDGVjUEZf
y/IzRmFtQFHYyd9ax+4FfHhFyw8Wnm9LXuVrO+ugrpNm8riqRmhC4tBEhDanyhI6
B1opsYj+n8vt8gVphI87Nv6ZIkuYiRXzXmcm9vBxxYj9cOBqqBc3uWjZ3zmPnyMK
+CJaoJgtz4HYEGMRBSte3iQQ3LXoVItnY6NkKPRdp4W6GQs8jcJDzsqQEbM+D5cm
/3xd1gPDZ8OfR2DFyHJCMwC0GTuFMpsjbFaxkX70h5rkIHnXfKPwr84wMMM82dQA
D8NoeRUTMWOvKNukiqONOT9zXdMYQCJ+CczM5+YAQYV/RDLGTM0LqBJQshjuWYXn
qCAV2FD5GcRbVXDzxUgLnEtoW9EO+eYICjks5vQLAkhHMjc1DQdCGIPipgurzFi1
1gVjn5F0PzoqXkE9dOjnM2k3zgFXjc8bsBl7pna8zpOeYC25AICvOrBhvf3AfaSL
+1Tyy09RrPu+jo6f0EY53kJP1/nw0JwRXkKBcSYOzjCDEEWs37zZft5aFH2nCp2Q
AiYsHTIAqat9ecTPAQRiDwB6f1ku5xLPkkj5VDRY6h5AMycn8G5xeJ9aYVUHqhPg
k1UPP8gjhhZpuWT2EdTeZWovJYfiHIWLMcIUBhR0cRqRKpwDiQo=
=rPGM
-----END PGP SIGNATURE-----

--thqsfdjzhqzzc6kc--
