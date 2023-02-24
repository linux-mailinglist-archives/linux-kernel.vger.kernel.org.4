Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA326A15F8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 05:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjBXEkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 23:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBXEkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 23:40:16 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205F851935;
        Thu, 23 Feb 2023 20:40:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PNHHw1xHCz4x5Q;
        Fri, 24 Feb 2023 15:40:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677213612;
        bh=NZ3/SYeVWEig/atusUEvc12GDmgJF01Gbw8SEkZZh98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bEduvLlicQeXck8HJoRP/8E2Q7DT3IzfKrkZQNqdAdki4bEOu1Rhw+zK32pPxZ9Q1
         r3o/XoxIh5iGBkz+iazEaJJJRDBj/8m2artkhD3oozJBH/3Z6MG1AHT3XXSEk8yNqB
         LT2PHKwf5pINLO1ba0FJXStFgSaIIHx0Hl/38de+MeTiNVPo5F49Ynsz+/pMc5xeUV
         6Y7/A3qqHGwW9WKBDslgEHsoNQf8+VAFQR+AeMhBb/nB5p+qOODbfbWe5xyJaUod8o
         sKUtcDg0CbVmQ+Cycf9Seul/5qXbo1WfWzWu2HWF1oqCzFZCPOiwiMnVU95CD+a/Np
         26Ev0EsP3a95Q==
Date:   Fri, 24 Feb 2023 15:40:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20230224154010.17a5b949@canb.auug.org.au>
In-Reply-To: <20230201084741.0ca1c414@canb.auug.org.au>
References: <20230127165912.0e4a7b66@canb.auug.org.au>
        <20230127131142.yrlel7df3yvp56rx@quack3>
        <20230201084741.0ca1c414@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fhL3tZpomiy.k/wUlRdo9VK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fhL3tZpomiy.k/wUlRdo9VK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 1 Feb 2023 08:47:41 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi Jan,
>=20
> On Fri, 27 Jan 2023 14:11:42 +0100 Jan Kara <jack@suse.cz> wrote:
> >
> > Thanks for the fixup! The right function to replace PageLocked() with is
> > folio_test_locked(). Anyway, I'll prepare a suggested conflict resoluti=
on
> > for Linus when pushing the changes. =20
>=20
> Thanks for the hint.  This is what I am using now:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 27 Jan 2023 16:50:34 +1100
> Subject: [PATCH] udf: fix up for "fs: convert writepage_t callback to pas=
s a folio"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/udf/inode.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 3b2adf4cbc57..b47bf9c73f4d 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -185,16 +185,17 @@ static void udf_write_failed(struct address_space *=
mapping, loff_t to)
>  	}
>  }
> =20
> -static int udf_adinicb_writepage(struct page *page,
> +static int udf_adinicb_writepage(struct folio *folio,
>  				 struct writeback_control *wbc, void *data)
>  {
> +	struct page *page =3D &folio->page;
>  	struct inode *inode =3D page->mapping->host;
>  	struct udf_inode_info *iinfo =3D UDF_I(inode);
> =20
> -	BUG_ON(!PageLocked(page));
> +	BUG_ON(!folio_test_locked(folio));
>  	memcpy_to_page(page, 0, iinfo->i_data + iinfo->i_lenEAttr,
>  		       i_size_read(inode));
> -	unlock_page(page);
> +	folio_unlock(folio);
>  	mark_inode_dirty(inode);
> =20
>  	return 0;
> --=20
> 2.35.1

I think Linus may have missed the last 2 changes in this merge
resolution ...
--=20
Cheers,
Stephen Rothwell

--Sig_/fhL3tZpomiy.k/wUlRdo9VK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP4P6oACgkQAVBC80lX
0GzBMwf/fm+a2i+VahMHOZFwc73pIED0u3CUkTHG457UcYunMx9W6+fTqBBth8bi
IBEpMA9ILhqqeYpfoB0Y3wh5W9JrRIZBrjWw4wEMJsyEHyZUdLExUvbiJfFIIx3O
eUxsuMcZqSeb1KFd0QR/NUwVlZPqHgSkGce4IqpXZdR1Y3Bqlfyz25FcCiDysKM9
+rfzHrhYhWespw6wVQDJ6rs+os9Pozx3a5HTqVcAYSbZ68Z/AJVSrppUGnproDPX
WmJQccw6HsslloexN/PxFsDEhgn+plapHgMiClAltn/fg3PE0NlgoQre2TlVzMeK
stUqbPE73WKQhm5ZvQW/t6s0MPW3FA==
=dlPU
-----END PGP SIGNATURE-----

--Sig_/fhL3tZpomiy.k/wUlRdo9VK--
