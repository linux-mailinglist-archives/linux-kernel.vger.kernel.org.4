Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E23603A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJSHIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJSHIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:08:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E8675CF7;
        Wed, 19 Oct 2022 00:08:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mshf91X2Kz4xFy;
        Wed, 19 Oct 2022 18:08:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666163314;
        bh=n25CEvRMNJkl4mDH2lWKsRxa6pWT3sbqAZJPl0HaR3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nse+/gMcIVXhvkj+nw23JSEeP0t/zlnBUXT+8M2s+IbFGI4929qxwP0k0u17ueXUs
         t6S97fo0g7rweW1R0B93QgvhG+6M+x1GrtliRG5C1/9GmAuDnkFhvl3eHpL8WQ7dQg
         r9d94d8UnIXLSbfkkf1BHVmpAFFCiYHeKcmJVyiQEFMG4EaWi/ThYbWoxG+O41jyeM
         IpsZEcDzbiWyKJ8CoOV5u6lO03dWNiuUUgaG7Kvpul9q9jQtqcnMW0PThgPVdl/l8p
         40l5cp+o/zTVpAH50z2TyuSkyZMuzr4f0D8KmA4flfzG3/1pPk3l+jk08J+1Sp/2NK
         6zeg6fyy/TfHA==
Date:   Wed, 19 Oct 2022 18:08:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: linux-next: manual merge of the mtd tree with the mtd-fixes
 tree
Message-ID: <20221019180807.6dac24a0@canb.auug.org.au>
In-Reply-To: <23d311953ef13608be2283a05b2e853d@milecki.pl>
References: <20221019092812.7d370b06@canb.auug.org.au>
        <23d311953ef13608be2283a05b2e853d@milecki.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/acxa4UYAYwanTHlWK5gyvXR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/acxa4UYAYwanTHlWK5gyvXR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Rafa=C5=82,

On Wed, 19 Oct 2022 07:31:57 +0200 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.p=
l> wrote:
>
> this isn't exactly the correct fix, of_node_get() is still needed.
>=20
> I'll make sure we let Linus know about this conflict (and solution) when
> sending 6.2 pull request.
>=20
>=20
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 07249af4f890..20fcedc3021e 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -559,7 +559,7 @@ static void mtd_check_of_node(struct mtd_info *mtd)
>   	if (!mtd_is_partition(mtd))
>   		return;
>=20
> -	parent_dn =3D mtd_get_of_node(mtd->parent);
> +	parent_dn =3D of_node_get(mtd_get_of_node(mtd->parent));
>   	if (!parent_dn)
>   		return;
>=20


Thanks for checking.  I have added that to my resolution for tomorrow
onward.
--=20
Cheers,
Stephen Rothwell

--Sig_/acxa4UYAYwanTHlWK5gyvXR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNPolcACgkQAVBC80lX
0GwjOgf/SohKt6ThX8qtlr+cShV31thykLnj7Tz9Gz8EDxs2c7gOkoOLAt5I3ofG
2qy5uthAsavJ6hQX/AhnOSqCrzvUGC8Z6cu2zVcUtETNlJI8wrGd3fciWTjNDGWW
IGbqquYnp+aiZNSbRkDCH8VmAactJOfi82Y56ljfg94guEG8ZaTFEp+UM5ZziI0P
s0lMgoB2hDuvAXJDNoLc82jHkLRIz4JsY9aTwvplXRqDcK4n13thPB+WTNFOiHZI
1C9SuEEDRjAb9lAA9M2/fxLg1mZAe39dvIKpzIFnpFkMwsQZiIW+KxSn9jnJIqGU
FccNZuVIxUuuTlp0hPFwTtt2ydwM+g==
=tL7r
-----END PGP SIGNATURE-----

--Sig_/acxa4UYAYwanTHlWK5gyvXR--
