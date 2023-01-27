Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D677867DD4E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjA0F7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjA0F7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:59:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD85711D;
        Thu, 26 Jan 2023 21:59:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P36N142Nfz4xG5;
        Fri, 27 Jan 2023 16:59:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674799154;
        bh=Ck6Be101RtVBJuKF2I1ibL3tg7TgcOeUV3osohnIE0Q=;
        h=Date:From:To:Cc:Subject:From;
        b=EAi15LClgQ5MXdkwqGCxROxtSicvcH2AVlsXZxsJZ+VGL4dDV5YeKgc4X5FnmSOuL
         9JklcTB1TreEGfPyNLP+vOMib1z58nxyxKYCmZhNqYFHUQHaz+ioe48Xad2lt1NKRM
         rJb5yza8ymOMsPxYKCfZs0Bd1iqRdWjGRrCJRJs5d8Mihn4xVKUC/uF6xh+skRwInL
         jt2qvcbCfI3YdqfNXhNsgKuBu/crc6CtqsYrOv5B8LuFczo2dFKVCn0l8WIdPvXl16
         d2c2hLkuJLLgL2UosfJ5m88Liw1vtIjSu3nKctuqyQfcRIuQo3NQvW8lojoy61GpXH
         JnQMvJEscURkQ==
Date:   Fri, 27 Jan 2023 16:59:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230127165912.0e4a7b66@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=7GPvUOezSJh5rbsvqJwpqX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=7GPvUOezSJh5rbsvqJwpqX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/udf/inode.c: In function 'udf_writepages':
fs/udf/inode.c:211:48: error: passing argument 3 of 'write_cache_pages' fro=
m incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  211 |         return write_cache_pages(mapping, wbc, udf_adinicb_writepag=
e, NULL);
      |                                                ^~~~~~~~~~~~~~~~~~~~~
      |                                                |
      |                                                int (*)(struct page =
*, struct writeback_control *, void *)
In file included from fs/udf/inode.c:36:
include/linux/writeback.h:375:66: note: expected 'writepage_t' {aka 'int (*=
)(struct folio *, struct writeback_control *, void *)'} but argument is of =
type 'int (*)(struct page *, struct writeback_control *, void *)'
  375 |                       struct writeback_control *wbc, writepage_t wr=
itepage,
      |                                                      ~~~~~~~~~~~~^~=
~~~~~~~

Caused by commit

  a36a897cc496 ("fs: convert writepage_t callback to pass a folio")

interacting with commit

  79d3c6dbada4 ("udf: Convert in-ICB files to use udf_writepages()")

from the ext3 tree.

I have applied the following merge fix patch (I wasn't sure what to do
with the PageLocked()).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 27 Jan 2023 16:50:34 +1100
Subject: [PATCH] udf: fix up for "fs: convert writepage_t callback to pass =
a folio"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/udf/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 3b2adf4cbc57..b47bf9c73f4d 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -185,16 +185,17 @@ static void udf_write_failed(struct address_space *ma=
pping, loff_t to)
 	}
 }
=20
-static int udf_adinicb_writepage(struct page *page,
+static int udf_adinicb_writepage(struct folio *folio,
 				 struct writeback_control *wbc, void *data)
 {
+	struct page *page =3D &folio->page;
 	struct inode *inode =3D page->mapping->host;
 	struct udf_inode_info *iinfo =3D UDF_I(inode);
=20
-	BUG_ON(!PageLocked(page));
+//	BUG_ON(!PageLocked(page));
 	memcpy_to_page(page, 0, iinfo->i_data + iinfo->i_lenEAttr,
 		       i_size_read(inode));
-	unlock_page(page);
+	folio_unlock(folio);
 	mark_inode_dirty(inode);
=20
 	return 0;
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/=7GPvUOezSJh5rbsvqJwpqX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTaDAACgkQAVBC80lX
0Gyyfgf/XHSYtaP+GfUyGBTQrri2vR6FkNQBlrVnx4b6YED5P5JVH39sAIvYfAd1
ysqSURKKmZTvMBn2dNWvMjDOb/2tC8Rzh/uLMhAktINPpEsTTRKy5ohTFDuLlYLD
W2OaojMQGMrtZUmV2S9njSDobSbrFH5sicbqeLw03sksfTVezNqNKDTOH/jK6Ber
uO8jvaI4R/aGVF13PVERIBuEnlneHoIWqtYbLKg0pZw9w8At2LV6tLVdHPPgOMFR
yanUXcn4TcDI2HI0W7oqyudMtyicpqTh7ZrAxEl6rrm2G/a8XNLAPwxMjJBCxTna
w8pvqZwWcUo09azkFtDmYIw8pjLc9Q==
=U+wC
-----END PGP SIGNATURE-----

--Sig_/=7GPvUOezSJh5rbsvqJwpqX--
