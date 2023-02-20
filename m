Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B169D55F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjBTUzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBTUzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:55:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7D493D0;
        Mon, 20 Feb 2023 12:55:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLF6c221tz4x7W;
        Tue, 21 Feb 2023 07:55:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676926504;
        bh=TN9MnTzTcDjAtzsjk2SmyoubrMs0S99INEPuVp4NPsw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZD4I3AiuBJeGBrud2+0PKq0uB1HLw22UM//USZFx576j1t4Vwzpi04JlR/b8/FErL
         /iPWBnv3REnmKegfoW5y5aRy/V952cyT8k7RCzx44vAUPNUAaJvRQ7Dtxb5b5wR6NJ
         K/N9yXSledcn0PlUhwwuEJ51YqrUSP6huFf67qR5zAtDfy13jSDvLFw6rs7Zzsottn
         pvnjaVVDtGdeWJJHXSzrb8hKK4MnezRsDx9G4QgwdkLjMPs8ixbJED2OxGH3u1NB0t
         KHhBGRmod6BLqoNo+4ZvXaB+3Op7Nu+kLF05mHAiOV6c53b+PXxlPB0armeF+hqs/c
         z+U1t/cBbI7vA==
Date:   Mon, 20 Feb 2023 19:01:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs
 tree
Message-ID: <20230220190157.3b43b9a7@canb.auug.org.au>
In-Reply-To: <Y/N8hVWeR3AjssUC@casper.infradead.org>
References: <20230220152933.1ab8fa4a@canb.auug.org.au>
        <Y/N8hVWeR3AjssUC@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mcxutnz+Nri4DIGkdhyuEcP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mcxutnz+Nri4DIGkdhyuEcP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Mon, 20 Feb 2023 13:58:29 +0000 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> On Mon, Feb 20, 2023 at 03:29:33PM +1100, Stephen Rothwell wrote:
> >=20
> > Today's linux-next merge of the mm-stable tree got a conflict in:
> >=20
> >   fs/cifs/file.c
> >=20
> > between commit:
> >=20
> >   c8859bc0c129 ("cifs: Remove unused code")
> >=20
> > from the cifs tree and commits:
> >=20
> >   4cda80f3a7a5 ("cifs: convert wdata_alloc_and_fillpages() to use filem=
ap_get_folios_tag()")
> >   d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")
> >=20
> > from the mm-stable tree.
> >=20
> > This is a real mess :-( =20
>=20
> Doesn't look too bad to me.  Dave's commit is just removing the
> functions, so it doesn't matter how they're being changed.

The problem I see is that an earlier commit in the cifs tree moves the
use of find_get_pages_range_tag() to another function and 4cda80f3a7a5
then removes find_get_pages_range_tag().

> The real question in my mind is why for-next is being updated two days
> before the merge window with new patches.  What's the point in -next
> if patches are being added at this late point?

Indeed :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/mcxutnz+Nri4DIGkdhyuEcP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPzKPYACgkQAVBC80lX
0GwqTwf+KApjbSG8Xl0o4C2w6Cocc1UIV5YOnL1S8wBaNEAZi3XSqlqsiuWAAhHj
Sho7KctHIKcMujrLlXeO0A//saPymvT111x8OGsE6EaxsuF9YHACMhwI7LG7TNfd
ZJpjZOewr+DBTvE1FLJN+KCeo+0/vvrkDtY2Q0wGxLicTvAVZ3ChjujVLuEkmYY2
QMV4rg0UYRPti3QXi10R2nvOKUWVAy6EGxG4V3tVBwVBH0jmedMAK5SSOKErZtHa
TJyivJ80+e6kKcWRA71Bkt+RgMgbI8dETQeJ0Msesiw2F2XC/6w7E614wYvNwLg9
BAQwb8HJctuUHaRoMqKxOo3azPHkQg==
=1Jt9
-----END PGP SIGNATURE-----

--Sig_/mcxutnz+Nri4DIGkdhyuEcP--
