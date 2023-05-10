Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025346FD35D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 02:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjEJAz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 20:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjEJAz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 20:55:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F2140CA;
        Tue,  9 May 2023 17:55:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGGmK6rv9z4x3g;
        Wed, 10 May 2023 10:55:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683680146;
        bh=DPDhdIgQcEPuwZiGR6setxixF8oqA1jCYFDPyD+OlL8=;
        h=Date:From:To:Cc:Subject:From;
        b=F3a1K0CL8lzM3t6AxcsULt+HfRqjXeytZMI/jGFkFHxFYqax5iZnEPmEQemey61rs
         xpXw4zZZOoAqLf9sDa4SUKKNBV0Bw160IHizxGFI8kXDMp4l5NUpf6+qwMFV7cHkeN
         U7qo9BFaXZC7uOfs+lgk+LWHzwWhGcKXBLtqu3P5YTIjNFcouso9hB1mMINhHCW5gm
         Jx/J/YUmjyThCJfBG8NXFDd9PnvScQzZGFIDINn/etcqv41y+lEjBMp/r7dKdwLBqL
         9Os/+zeGZ1HMkDjftY8BGin9NTAignL5nMc/ITLiU4HvaaNUQXWvh41C5Bp+C/2NMB
         /rTyCCQZeFAkQ==
Date:   Wed, 10 May 2023 10:55:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the vfs-idmapping
 tree
Message-ID: <20230510105543.165f102b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j/8SnGv4k5sgQbrHyxE3M0a";
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

--Sig_/j/8SnGv4k5sgQbrHyxE3M0a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/pipe.c

between commit:

  2b10649c2316 ("pipe: enable handling of IOCB_NOWAIT")

from the vfs-idmapping tree and commit:

  3f6ded8dd89d ("pipe: check for IOCB_NOWAIT alongside O_NONBLOCK")

from the block tree.

The former added

	const bool nonblock =3D iocb->ki_flags & IOCB_NOWAIT;

and then did

-		if (filp->f_flags & O_NONBLOCK) {
+		if (filp->f_flags & O_NONBLOCK || nonblock) {

while the latter just did

-		if (filp->f_flags & O_NONBLOCK) {
+		if (filp->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT) {

so I just used the former though I suspect that the former may be a
previous version of these changes?).

I fixed it up (see above) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/j/8SnGv4k5sgQbrHyxE3M0a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRa648ACgkQAVBC80lX
0GzFMwf9GywO9l1OBN5eJl56rHyirZpYR8M/C6C1+wwg+squH8GG7GX/7JoMaVqG
t2tcu1h8tmfc3+brim/YnTLXhl4tkbHjl7CjiNrCxIu7Xz20Qd7kcaLi4OxVJiJS
s9Oa5ZJ7RBVa7lEB597mR8xXz+p1uUT7Q53GDppl4QF7NyZg4tqRrfqJBXcDn7is
oWep6EzA7HMvREdRljjp3jIqHaGUKC2Q2wcyu3ylScviRX7xEp0zRzwlr0ECTQ0F
bN00TkyAuKk7kgHCSuVxPFIv3cipNMks6LCEDlDOb0De4rfLOSbOXHfc9S8mJYJB
mFORgYZ6eyToHan4g1UZCEUFeu//1Q==
=nxE1
-----END PGP SIGNATURE-----

--Sig_/j/8SnGv4k5sgQbrHyxE3M0a--
