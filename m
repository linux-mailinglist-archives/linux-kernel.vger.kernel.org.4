Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4189D7406E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjF0XiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0XiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:38:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C3E1BE6;
        Tue, 27 Jun 2023 16:38:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QrLk60Qt1z4wb4;
        Wed, 28 Jun 2023 09:38:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687909087;
        bh=XoWxl7Am9taH1CIp0jQQrHNuR55WL3+yoPckVzeaPms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T7+fcx3BaEP+til7rwPErs97ymRqcKxLcdK7KonzLlFxRoKU5lxfbONUi+etP3k6Z
         zbAJtTrwpMVDUEaoRoIdmwJpxFw1RN8GgdvejrpbFfEUA7lbqVKbqZRqwt2X4A37/C
         hCD11lOKhE/TUQyyNcl1m6NE0BbeLQ/exT6NTd6d5k2TPKEVFKCZjYkpmInHXQdaBa
         OFJZxORPEVFZNazYIANuIDKGyDvYAAL0NgQTqJzN1MorzJqEuM771hwGaACaLj3uEU
         Zr/J+sBBsPqnBTqBtuH1adZuBIm3COzOj+RGx6gB2m6RFLCHAkG4e7H6HyVxm/6kEu
         9uVAwnV5e0ACA==
Date:   Wed, 28 Jun 2023 09:37:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the
 asm-generic tree
Message-ID: <20230628093744.3c5d2df5@canb.auug.org.au>
In-Reply-To: <7f77f31e-90ff-44ad-9646-9876f11eed13@app.fastmail.com>
References: <20230609104037.56648990@canb.auug.org.au>
        <7f77f31e-90ff-44ad-9646-9876f11eed13@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2.kN=8z/0uAbZl9XFZvkv1Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2.kN=8z/0uAbZl9XFZvkv1Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Fri, 09 Jun 2023 08:31:19 +0200 "Arnd Bergmann" <arnd@arndb.de> wrote:
>
> On Fri, Jun 9, 2023, at 02:40, Stephen Rothwell wrote:
> >
> > Today's linux-next merge of the net-next tree got a conflict in:
> >
> >   fs/netfs/iterator.c
> >
> > between commit:
> >
> >   ee5971613da3 ("netfs: Pass a pointer to virt_to_page()")
> >
> > from the asm-generic tree and commit:
> >
> >   f5f82cd18732 ("Move netfs_extract_iter_to_sg() to lib/scatterlist.c")
> >
> > from the net-next tree.
> >
> > I fixed it up (I used the file from the former and applied the patch
> > below) and can carry the fix as necessary. This is now fixed as far as
> > linux-next is concerned, but any non trivial conflicts should be mentio=
ned
> > to your upstream maintainer when your tree is submitted for merging.
> > You may also want to consider cooperating with the maintainer of the
> > conflicting tree to minimise any particularly complex conflicts.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Fri, 9 Jun 2023 10:35:56 +1000
> > Subject: [PATCH] fix up for "Move netfs_extract_iter_to_sg() to=20
> > lib/scatterlist.c"
> >
> > interacting with "netfs: Pass a pointer to virt_to_page()"
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  lib/scatterlist.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> > index e97d7060329e..e86231a44c3d 100644
> > --- a/lib/scatterlist.c
> > +++ b/lib/scatterlist.c
> > @@ -1237,7 +1237,7 @@ static ssize_t extract_kvec_to_sg(struct iov_iter=
 *iter,
> >  			if (is_vmalloc_or_module_addr((void *)kaddr))
> >  				page =3D vmalloc_to_page((void *)kaddr);
> >  			else
> > -				page =3D virt_to_page(kaddr);
> > +				page =3D virt_to_page((void *)kaddr);
> >=20
> >  			sg_set_page(sg, page, len, off);
> >  			sgtable->nents++; =20
>=20
> The fix is correct, but I think this should just get applied
> in net-next directly, on top of the f5f82cd18732 commit, it
> will have no effect there but avoid the conflict.

This did not happen, so Linus needs to be notified of this merge fix.

--=20
Cheers,
Stephen Rothwell

--Sig_/2.kN=8z/0uAbZl9XFZvkv1Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSbcsgACgkQAVBC80lX
0GyHTQf+IEtDljYhLnCISPmNvvKUfxxpFT+5PuRwCAbfSxONmf1XU/j1+tIyWaSp
rUUjNuOSXI3HGBwjIvSUXSsuW4CnImBEI2P23Q9FZ8F2O/y3oVZaQXcizR0pvdsq
Jr4HGX9DXwy6zrrlTtskBDLEfZheNIsbL/9HaHcYSnDUZwcugD9bvTCB+CYfCOGA
FDyiGxMxaxd6Q+icgCL40I+moNEcXfkcVLZ840Mp3kFqfOxbRP3/TPLxZGv+BYop
/IqOqhfFpDoC+pl9XCqIsxzpQSuvR6YqluAE2AjlGUEdy7Haa+dW2Nll+et662r9
Oye/iG5ojr394DtsssqmTA67NYkt/A==
=/qEy
-----END PGP SIGNATURE-----

--Sig_/2.kN=8z/0uAbZl9XFZvkv1Q--
