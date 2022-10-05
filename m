Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CDD5F4CFF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 02:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJEAWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 20:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJEAWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 20:22:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF0C56032;
        Tue,  4 Oct 2022 17:22:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhwHg6TT0z4wgv;
        Wed,  5 Oct 2022 11:22:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664929328;
        bh=yLtOUsfBar2oPaHNfrjTpcB5fZUSsPBErmNnrTCd0+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hoaPn45c1Iap2YdXM+GccC5fQDXtiWg/8K72d62sQ81sAya9yq0Dcytjl8Df+yf6g
         Xa272b3Az1dLTSKFrHD4Y6YxpdvbtyJ5v59/AbaEDz7R7gi6SouD+EywBWUyKtuZ6K
         rYioSOCRTvxZcon7iOjK8q5cx5VHq/Dkh3z7z1juji82pD+6aPjPj8xzg6Fk25xuvF
         z1aqB5bgnW1AI2UJhwtUgx0aXeO6FAf/1yxI5wah95crlYcn76rQfdjEuPcaI8Q9yP
         narx57OnDcE7ZhSxL+Dl04jgooni2M3GNAVitjLtV+xJ8CKD8h30khaQhLhkL+QRQm
         jmOy+PEbvcLmA==
Date:   Wed, 5 Oct 2022 11:22:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     broonie@kernel.org, Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: linux-next: manual merge of the kspp tree with the arm64 tree
Message-ID: <20221005112206.09278b2f@canb.auug.org.au>
In-Reply-To: <20220927185911.512737-1-broonie@kernel.org>
References: <20220927185911.512737-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jGMgEiQh_H21JiOUzJUoqXD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jGMgEiQh_H21JiOUzJUoqXD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 27 Sep 2022 19:59:11 +0100 broonie@kernel.org wrote:
>=20
> Today's linux-next merge of the kspp tree got a conflict in:
>=20
>   arch/arm64/kernel/alternative.c
>=20
> between commit:
>=20
>   b723edf3a12a2 ("arm64: alternatives: make alt_region const")
>=20
> from the arm64 tree and commit:
>=20
>   5f20997c194e8 ("arm64: Drop unneeded __nocfi attributes")
>=20
> from the kspp tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc arch/arm64/kernel/alternative.c
> index 64045e3ef03a9,d2c66507398d7..0000000000000
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@@ -139,9 -133,8 +139,9 @@@ static void clean_dcache_range_nopatch(
>   	} while (cur +=3D d_size, cur < end);
>   }
>  =20
> - static void __nocfi __apply_alternatives(const struct alt_region *regio=
n,
> - 					 bool is_module,
> - 					 unsigned long *feature_mask)
>  -static void __apply_alternatives(struct alt_region *region, bool is_mod=
ule,
> ++static void __apply_alternatives(const struct alt_region *region,
> ++				 bool is_module,
> + 				 unsigned long *feature_mask)
>   {
>   	struct alt_instr *alt;
>   	__le32 *origptr, *updptr;

This is now a conflict between the arm64 tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/jGMgEiQh_H21JiOUzJUoqXD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM8zi4ACgkQAVBC80lX
0GzsiQgAnpGvw88K5JmTGXQUv/1YBcKCO43RdhTTDqYBfGFN9c+NZiynnUMczE4A
08PWx3/layXa0Xa/1d6GZnehKdhDNnjg8Zykk13Bh+V2qP1uvm1Xj/G8DLzrVQaE
q3W9R4d206DyADPaqwzaeY5rOkJ+oVn4q6DuWYpV3b5QiKlSPSeO7PhNpqZVYDIx
l1TXNp9+XHlp0/TiRVFP4uJndoWalrYeN26z+oQCYspuCzUTc+f+J6P+d4sgJNiM
1XELn9R205bN9k/PXOD5z2deiVFljWGu2NrQDSaXeLG/Rnap+1jWeH0BryESIFfW
R4ObP6pXmI9/ZkRjtM/Har0yk9E8xQ==
=jqr6
-----END PGP SIGNATURE-----

--Sig_/jGMgEiQh_H21JiOUzJUoqXD--
