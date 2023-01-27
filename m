Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E187867DD7F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjA0Ggs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjA0Ggq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:36:46 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5DB3A593;
        Thu, 26 Jan 2023 22:36:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P37CC2YJCz4xG5;
        Fri, 27 Jan 2023 17:36:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674801399;
        bh=0D9/wuucUN3al5u0QYFIz3YHGsy3IqhOwFctG87KHHE=;
        h=Date:From:To:Cc:Subject:From;
        b=iZdZnoGUM2uH4qGJToWufUtFQoehlawFdzjrv5TwRpSNfqVaYqQesbUREAVYwUtV2
         uGTS72OL1XvMdgFhE80Hf6NjXy1uVuBQsGpxFsCUImuoVT5h8B2Y0AQydeCd3uHkft
         7cHK4MK401Tsmo+hrI6K8+7eVmeWD5FYmurAueo8iqTHAcxUSDswi1nG3eX+sFMgtS
         n4PE4lEdmBTjODaAupwJNmMQqKw9nCLr/KbbvqP7rHx4TrTYGLSwlmukh1jaSPqdFX
         hc6A2RfM28j5F4+9Ozi64am6KMAaKCLBGDIaxRAPwm26KH+uKDA/2bEhibYH6tmARl
         DB85TXOSCT+gw==
Date:   Fri, 27 Jan 2023 17:36:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230127173638.1efbe423@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//PlG912SeyXUzU23jcVsYM/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//PlG912SeyXUzU23jcVsYM/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

fs/gfs2/log.c: In function 'gfs2_ail1_start_one':
fs/gfs2/log.c:143:55: error: passing argument 3 of 'write_cache_pages' from=
 incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  143 |                 ret =3D write_cache_pages(mapping, wbc, __gfs2_writ=
epage, mapping);
      |                                                       ^~~~~~~~~~~~~=
~~~
      |                                                       |
      |                                                       int (*)(struc=
t page *, struct writeback_control *, void *)
In file included from fs/gfs2/log.c:20:
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

  95ecbd0f162f ("Revert "gfs2: stop using generic_writepages in gfs2_ail1_s=
tart_one"")

from Linus' tree (post v6.2-rc4).

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 27 Jan 2023 17:26:08 +1100
Subject: [PATCH] gfs2: fix up for "fs: convert writepage_t callback to pass=
 a folio"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/gfs2/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 25fd21a9dec8..d750d1128bed 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -80,11 +80,11 @@ void gfs2_remove_from_ail(struct gfs2_bufdata *bd)
 	brelse(bd->bd_bh);
 }
=20
-static int __gfs2_writepage(struct page *page, struct writeback_control *w=
bc,
+static int __gfs2_writepage(struct folio *folio, struct writeback_control =
*wbc,
 		       void *data)
 {
 	struct address_space *mapping =3D data;
-	int ret =3D mapping->a_ops->writepage(page, wbc);
+	int ret =3D mapping->a_ops->writepage(&folio->page, wbc);
 	mapping_set_error(mapping, ret);
 	return ret;
 }
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_//PlG912SeyXUzU23jcVsYM/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTcPYACgkQAVBC80lX
0GzJZAf+MB8flyGipiV4uhrKg3juE2Jlexlimbr0fHZauvzr2RLn0xLUCNRoCloG
opxcaI3LxE3XudxC3DO7lA9xlD9HwoTy/4AQVh3SEjngNt/N9YwrYcYQx7wHUi6D
jMKTfabiQzl+1uKX01+19foniUInm6c2g01v9M3KEY7Bdx13T4O1jjZ6ptVRGV1M
dVQl34pxVdQ/qZAMElMLFuEm78KhPikpILGReWFfAgqNKksx/5H9OpZg5XwXd5Dl
qwdTM2EauoyZ4bP9OYFnWyHsEJuDjAbTHIrnP0SeEfYzlVOLqvm1Fg8Q8xvXTu7k
Sl0Lz8Mn7sr0PcwEda+CkQ3GKoIq2w==
=mdwY
-----END PGP SIGNATURE-----

--Sig_//PlG912SeyXUzU23jcVsYM/--
