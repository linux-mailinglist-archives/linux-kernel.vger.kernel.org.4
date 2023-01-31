Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5244C6838DC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjAaVrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjAaVrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:47:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D6C58652;
        Tue, 31 Jan 2023 13:47:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P5zDb4Cddz4x1d;
        Wed,  1 Feb 2023 08:47:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675201664;
        bh=8epdYgCJxp/PArxVL7MtcHLKth2MxetPd++/pLeHk4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e70gWkaAw5OPHQcyPKzFBU8fJG5IVjZpePc1BMjQ9vYdMUth4VJNuZ+D7gAynhcCr
         a3+9R1POjbpOjKq8cBTvQpXO079lTYkzR8v/v439bDvxoQxCw9b6h4p6VScbCKOg+b
         8cg0emsToXJwhoAFCMA97rpT5STqTHVI/6pE2/5W3nN4aTkJWoAEJemBGIy1hqfaf3
         D9k7QTwKqXlriblzlJRxzJn2/8KADiiZCyof8G+e+Q+Ch8SbzceU1Ox2fjxYWSEKHe
         rJF6+llam4jiikIycD930Q0QXJzwFyLYdPqPDx5JK3CjX/C4hHhCUpcV0a3p6nVq6Q
         Lf13WLosUf2vg==
Date:   Wed, 1 Feb 2023 08:47:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20230201084741.0ca1c414@canb.auug.org.au>
In-Reply-To: <20230127131142.yrlel7df3yvp56rx@quack3>
References: <20230127165912.0e4a7b66@canb.auug.org.au>
        <20230127131142.yrlel7df3yvp56rx@quack3>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l=5Bqvjy5XxfFIZzzJFs7+c";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/l=5Bqvjy5XxfFIZzzJFs7+c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Fri, 27 Jan 2023 14:11:42 +0100 Jan Kara <jack@suse.cz> wrote:
>
> Thanks for the fixup! The right function to replace PageLocked() with is
> folio_test_locked(). Anyway, I'll prepare a suggested conflict resolution
> for Linus when pushing the changes.

Thanks for the hint.  This is what I am using now:

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
+	BUG_ON(!folio_test_locked(folio));
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

--Sig_/l=5Bqvjy5XxfFIZzzJFs7+c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPZjH4ACgkQAVBC80lX
0GyLAgf8C2njO2jvMu41hKMiuuFdp1bNUMG/4YnS61Q4qeOMeFrcGCX2ZpSuWlsN
0h/xeTACREOek4R3PKlR/l6whHpJ2Jej2jAFQlsWCdXNgG1xCCJRyfAp3WxXMDO+
SVtp3npG9fXGSWyTgGCgt4WUZst3/R73Xi/hPao4SJwZGbjSYAicBGKmd2Xo/vqb
id6DtzgD7R4BuH0DTUrdFEHqeJmFUrLyykvShi+4iECS0hq/nRRw9p6M4r873Rb3
7xdZ/LFI7CrPg1U1+YqD29XwVmrD2GB7MXQq5hJYI5R6zkbCpDEt1fli8xiiIsF8
NA92yLOZLqNWxMjP5eWuY3i0PtEI5g==
=bex6
-----END PGP SIGNATURE-----

--Sig_/l=5Bqvjy5XxfFIZzzJFs7+c--
