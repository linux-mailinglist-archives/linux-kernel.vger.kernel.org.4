Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AD07322C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbjFOWbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjFOWbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:31:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A40D1FD4;
        Thu, 15 Jun 2023 15:30:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qhxp35sPpz4wjD;
        Fri, 16 Jun 2023 08:30:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686868252;
        bh=ueCWAMDvwOyDbW7uXq2ByaTQQcg7zZajxDowPF71drk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kqwB6eJXu3saeKNgTPpum8C3qUWyIykeiA4B7Ivi4FdA2gjZKCuPwERzfLJgfaEys
         stcNJNDsK9CeGXtS0h8pD31g2eAVHpcmOcLmPx6DKoR2rCJtaoVFZ+XrFEPidHJX86
         wH1L7jVqX7ujJgAY5EGPHpC5OOU6owNdRdu9QRdA75L7l1peWH7TpdCILRGmzQMlFU
         HbYrdTntUl9fqkJMUXKiRt20uchN5xpLIYf1IiTJ3yniDejY1oXHlKspaoyVJYHXR+
         sTf24ybvQ/gLuCIaV7fDIQQcglk5Ppyhgv2gvyhaRXyh0ry13vUyIwTGwKVSJ0nS5q
         qh4sucWZbc2Pg==
Date:   Fri, 16 Jun 2023 08:30:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20230616083033.748f2def@canb.auug.org.au>
In-Reply-To: <20230613164639.164b2991@canb.auug.org.au>
References: <20230613164639.164b2991@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z9AlY.W8SK3_1+irWRBzsR7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z9AlY.W8SK3_1+irWRBzsR7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 13 Jun 2023 16:46:39 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the net-next tree, today's linux-next build (sparc64
> defconfig) failed like this:
>=20
> drivers/net/ethernet/sun/sunvnet_common.c: In function 'vnet_handle_offlo=
ads':
> drivers/net/ethernet/sun/sunvnet_common.c:1277:16: error: implicit declar=
ation of function 'skb_gso_segment'; did you mean 'skb_gso_reset'? [-Werror=
=3Dimplicit-function-declaration]
>  1277 |         segs =3D skb_gso_segment(skb, dev->features & ~NETIF_F_TS=
O);
>       |                ^~~~~~~~~~~~~~~
>       |                skb_gso_reset
> drivers/net/ethernet/sun/sunvnet_common.c:1277:14: warning: assignment to=
 'struct sk_buff *' from 'int' makes pointer from integer without a cast [-=
Wint-conversion]
>  1277 |         segs =3D skb_gso_segment(skb, dev->features & ~NETIF_F_TS=
O);
>       |              ^
>=20
> Caused by commit
>=20
>   d457a0e329b0 ("net: move gso declarations and functions to their own fi=
les")
>=20
> I have applied the following patch for today.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 13 Jun 2023 16:38:10 +1000
> Subject: [PATCH] Fix a sparc64 use of the gso functions
>=20
> This was missed when they were moved.
>=20
> Fixes: d457a0e329b0 ("net: move gso declarations and functions to their o=
wn files")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/ethernet/sun/sunvnet_common.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethe=
rnet/sun/sunvnet_common.c
> index a6211b95ed17..3525d5c0d694 100644
> --- a/drivers/net/ethernet/sun/sunvnet_common.c
> +++ b/drivers/net/ethernet/sun/sunvnet_common.c
> @@ -25,6 +25,7 @@
>  #endif
> =20
>  #include <net/ip.h>
> +#include <net/gso.h>
>  #include <net/icmp.h>
>  #include <net/route.h>
> =20

I am still applying that patch to the net-next tree merge.
--=20
Cheers,
Stephen Rothwell

--Sig_/Z9AlY.W8SK3_1+irWRBzsR7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSLkQkACgkQAVBC80lX
0Gz8cwf/cJV2+T+zzPzWXRjPvHb88fVcdoDJa5Sxdpfa7XWOoa2nm/XfRlNS1bEV
C/0eVhQ7K45f9Lt6U1xbzlIaqH6KeQcfd+waRz4l38x2sSKz+U3B6vXEaqCy+2HU
rKCifxxrtd6uNlKxB0AZZdkfJVDM8s5GWWL8wQBZSR5U1SMQ4TD8BVOmDwJd8Fx3
K1WB3bksf6dEBGr89cx2NAhJmjc73DdwzPMfraM4Tn9dcmfaJcDD2j1u/fRDHrYp
oYW7jrakdxV/B7iurOUDZVKpXR8h76D89ebxfv9qb3SFWDUUFftoE6T6eYrLv4Ad
9BM0soKEknVg2JnjejflPVEC8H3Tkg==
=tTtV
-----END PGP SIGNATURE-----

--Sig_/Z9AlY.W8SK3_1+irWRBzsR7--
