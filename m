Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697D97339FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346246AbjFPTf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346193AbjFPTfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:35:25 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C2235A0;
        Fri, 16 Jun 2023 12:35:23 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 213431C0E70; Fri, 16 Jun 2023 21:35:22 +0200 (CEST)
Date:   Fri, 16 Jun 2023 21:35:21 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        krzysztof.kozlowski@linaro.org, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 4/6] nfcsim.c: Fix error checking for
 debugfs_create_dir
Message-ID: <ZIy5ecuHQUP1wUu2@duo.ucw.cz>
References: <20230615114016.649846-1-sashal@kernel.org>
 <20230615114016.649846-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pxvocpSbgigqWfO6"
Content-Disposition: inline
In-Reply-To: <20230615114016.649846-4-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pxvocpSbgigqWfO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 9b9e46aa07273ceb96866b2e812b46f1ee0b8d2f ]
>=20
> This patch fixes the error checking in nfcsim.c.
> The DebugFS kernel API is developed in
> a way that the caller can safely ignore the errors that
> occur during the creation of DebugFS nodes.

I don't think this is good idea; user will wonder why he can't see
debugfs files, and pr_err() is quite suitable way to handle this.

Anyway, this does not really fix a bug, so we should not be putting it
into stable.

Best regards,
								Pavel

>  drivers/nfc/nfcsim.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
> index 533e3aa6275cd..cf07b366500e9 100644
> --- a/drivers/nfc/nfcsim.c
> +++ b/drivers/nfc/nfcsim.c
> @@ -345,10 +345,6 @@ static struct dentry *nfcsim_debugfs_root;
>  static void nfcsim_debugfs_init(void)
>  {
>  	nfcsim_debugfs_root =3D debugfs_create_dir("nfcsim", NULL);
> -
> -	if (!nfcsim_debugfs_root)
> -		pr_err("Could not create debugfs entry\n");
> -
>  }
> =20
>  static void nfcsim_debugfs_remove(void)

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pxvocpSbgigqWfO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy5eQAKCRAw5/Bqldv6
8leTAJ0ThYWaZ8JRFKMl8B8izHMZGm82CQCgjlPLfPVE1r8QIS26e8qGShfD+CU=
=Onr6
-----END PGP SIGNATURE-----

--pxvocpSbgigqWfO6--
