Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1202966374A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbjAJCZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbjAJCZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:25:30 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7573138AF4;
        Mon,  9 Jan 2023 18:25:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NrZR41Brdz4wgv;
        Tue, 10 Jan 2023 13:25:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673317520;
        bh=VNlfUO1rXO4iRBrNPbagdMHbioCHAXMQmUU9VlJrdow=;
        h=Date:From:To:Cc:Subject:From;
        b=qHPQhJVSxk5vIhsOMEGK1HXni0nT+R6Itho5c5skXL8Uh9GZ7w3TKZYWT4jlgVZ2C
         k7hInp6LxrMmEaJTaSerp5Ta/1guxQ5N5PCL7fV0htBV6AN2OWgwmQSuYvjAJH1/Bu
         qNuM6PiRXgBXSzRMoOuKyfWuZfXp8cJRglJJsmfkLEOUIUjMl3BDdTD24YObd0QVZQ
         StalHN0Pt5ggf9VPWVCvoNNF3ZTDMwcV8GINlVTO5dYWqqy+6X4JjJGFtneUP2KQaU
         BD2rGnStG5n/0EfiPLygjNYrRmmT/r+q2QngYbjnwfNnUtwfxr0mzCmkF17Ped6Sz/
         gLN7oX9ymx8Ow==
Date:   Tue, 10 Jan 2023 13:25:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: linux-next: manual merge of the mm tree with the fsverity tree
Message-ID: <20230110132519.72181341@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yxlrN0x=rC1z0c0CljXqphX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yxlrN0x=rC1z0c0CljXqphX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  fs/buffer.c

between commit:

  2a042de143b2 ("fs/buffer.c: support fsverity in block_read_full_folio()")

from the fsverity tree and commit:

  a0ab20df28e6 ("buffer: replace obvious uses of b_page with b_folio")

from the mm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/buffer.c
index 2e65ba2b3919,7e42d67bcaad..000000000000
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@@ -352,24 -319,15 +352,24 @@@ static void decrypt_bh(struct work_stru
   */
  static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
  {
- 	struct inode *inode =3D bh->b_page->mapping->host;
 -	/* Decrypt if needed */
 -	if (uptodate &&
 -	    fscrypt_inode_uses_fs_layer_crypto(bh->b_folio->mapping->host)) {
 -		struct decrypt_bh_ctx *ctx =3D kmalloc(sizeof(*ctx), GFP_ATOMIC);
++	struct inode *inode =3D bh->b_folio->mapping->host;
 +	bool decrypt =3D fscrypt_inode_uses_fs_layer_crypto(inode);
 +	bool verify =3D need_fsverity(bh);
 +
 +	/* Decrypt (with fscrypt) and/or verify (with fsverity) if needed. */
 +	if (uptodate && (decrypt || verify)) {
 +		struct postprocess_bh_ctx *ctx =3D
 +			kmalloc(sizeof(*ctx), GFP_ATOMIC);
 =20
  		if (ctx) {
 -			INIT_WORK(&ctx->work, decrypt_bh);
  			ctx->bh =3D bh;
 -			fscrypt_enqueue_decrypt_work(&ctx->work);
 +			if (decrypt) {
 +				INIT_WORK(&ctx->work, decrypt_bh);
 +				fscrypt_enqueue_decrypt_work(&ctx->work);
 +			} else {
 +				INIT_WORK(&ctx->work, verify_bh);
 +				fsverity_enqueue_verify_work(&ctx->work);
 +			}
  			return;
  		}
  		uptodate =3D 0;

--Sig_/yxlrN0x=rC1z0c0CljXqphX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO8zI8ACgkQAVBC80lX
0GyFggf9GhYmucGold1xYlzsEqMfmpG/7ufWmD8VnI955/RzFmydJjHz1VfRmQqP
+yLWQ38C3VcZ+khFaCG2QBq0mR6qbUz7fjkmM1PoqSAJGieNilVsAUNlPyTXKyzv
6VTzhuQUyyZxusNW6y/7oe0DpdQlyRehifHhaFpNGzNHaID0c1twH2GrOtjcTNk4
TnnH42k+9HFQQyDYGiK6qvhr7Uj5xuIb4oThwsOoY8zlZ6Pp+M0CXWXRv1KNnEDh
cRY/XtyzOmpi0Gs2deWvzwt1Oeiro4UoA5jjZLequXzJ8AnyMJJu5eMPGf5KU/9x
bBRf6RUKbHNBIT5OxBwijJgriwu4ag==
=4AxL
-----END PGP SIGNATURE-----

--Sig_/yxlrN0x=rC1z0c0CljXqphX--
