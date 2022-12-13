Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639F364BF01
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbiLMWCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbiLMWBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:01:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F13EB;
        Tue, 13 Dec 2022 14:00:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWsrC2Dlkz4xYQ;
        Wed, 14 Dec 2022 09:00:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670968844;
        bh=dnKDY1oXjcC0Tv/ElhCbaTcvHEJsm3IIOdeK96sWOaY=;
        h=Date:From:To:Cc:Subject:From;
        b=KOjC+qxk0SniGC3699LJGn3Mg13cGc6AbZqjHItVe0afRcsZhGlepkXm823jdSow3
         fxDbJxNyhhACD9dP+5wteSajpQeL4k2s1CPW2IPz8c3ss2A1VrA+67Lt9qpIoyDqal
         HmD7qTWzBAQXGL7kMDaaLDMuSSBcT8erlr39fryDQcqWma+kPbPqoj0m9uiSWWeSPK
         gZtzXJwFRZUpKeLryTkoQ3DKE4IsWd2iwiJ4wdo5Yo+Mj0f2csW+0lmYao+19FAhME
         7s8OUbl+9wwmHuxBc/gm/KmpMek204qf5H4Id/wkIdjU1eZFc2k+XqoWuhPx7TdC4L
         C078cxdVu37Dw==
Date:   Wed, 14 Dec 2022 09:00:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm-misc-fixes tree with Linus'
 tree
Message-ID: <20221214090042.1da0da04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Yyb61wh00qLWsTl=2x39==M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Yyb61wh00qLWsTl=2x39==M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc-fixes tree got a conflict in:

  drivers/dma-buf/dma-buf.c

between commit:

  28743e25fa1c ("dma-buf: Remove obsoleted internal lock")

from Linus' tree and commit:

  f728a5ea27c9 ("dma-buf: fix dma_buf_export init order v2")

from the drm-misc-fixes tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/dma-buf/dma-buf.c
index b6c36914e7c6,eb6b59363c4f..000000000000
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@@ -658,23 -655,24 +660,23 @@@ struct dma_buf *dma_buf_export(const st
  	init_waitqueue_head(&dmabuf->poll);
  	dmabuf->cb_in.poll =3D dmabuf->cb_out.poll =3D &dmabuf->poll;
  	dmabuf->cb_in.active =3D dmabuf->cb_out.active =3D 0;
 -	mutex_init(&dmabuf->lock);
+ 	INIT_LIST_HEAD(&dmabuf->attachments);
 =20
  	if (!resv) {
- 		resv =3D (struct dma_resv *)&dmabuf[1];
- 		dma_resv_init(resv);
+ 		dmabuf->resv =3D (struct dma_resv *)&dmabuf[1];
+ 		dma_resv_init(dmabuf->resv);
+ 	} else {
+ 		dmabuf->resv =3D resv;
  	}
- 	dmabuf->resv =3D resv;
 =20
- 	file =3D dma_buf_getfile(dmabuf, exp_info->flags);
- 	if (IS_ERR(file)) {
- 		ret =3D PTR_ERR(file);
+ 	ret =3D dma_buf_stats_setup(dmabuf, file);
+ 	if (ret)
  		goto err_dmabuf;
- 	}
 =20
+ 	file->private_data =3D dmabuf;
+ 	file->f_path.dentry->d_fsdata =3D dmabuf;
  	dmabuf->file =3D file;
 =20
- 	INIT_LIST_HEAD(&dmabuf->attachments);
-=20
  	mutex_lock(&db_list.lock);
  	list_add(&dmabuf->list_node, &db_list.head);
  	mutex_unlock(&db_list.lock);

--Sig_/Yyb61wh00qLWsTl=2x39==M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOY9goACgkQAVBC80lX
0GxE4wf/YfEkxbiaehvNd37ZMtx4/2ICMz4VIuMhpjRmPrbP99hv6PHome3nja0A
4ZVm0zvHSQmrDzNEMQnONhqqZ1kxc9WW5/6Nz0yos/mUUCnAxv6TiadvmxSpOivL
uV2KW/dorfwLYkmjkycrCq/YYBN9boB3eTShqyBAY/cx4XWc7+klNd0uv+IuNgxN
/HMZAv2m6C8Lb5W4HbUhUKp99xKRh4Wf08tZu8Gxe8MDwMA4xP/gW3ZBj6EflRT0
MFm+yvyf3Fmpb8zFAAY+b4tnUyGakJDiX8OX+o4Djtu4jIf40IFE/8ZmcmCQ+B2V
XWVlge0T8cQ+WrnZ3cXQE+sMhqTacQ==
=fKvB
-----END PGP SIGNATURE-----

--Sig_/Yyb61wh00qLWsTl=2x39==M--
