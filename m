Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5FB639E72
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 01:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiK1AUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 19:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1AUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 19:20:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1A69FC2;
        Sun, 27 Nov 2022 16:20:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NL5j06dl0z4wgv;
        Mon, 28 Nov 2022 11:20:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669594840;
        bh=0bqHrDpysmRPVxGQph2SsFdrUJX7MC8AJfSrCa6DWVI=;
        h=Date:From:To:Cc:Subject:From;
        b=q/dddm+QDAAund+OUgGbSKCtNhlVaHf4OxxxC1HecRYnnifcvWTUQaWgLcU4qR06S
         aXARywvnpLxvrdwWY4rPEKkTxk+K1HtlesABp0qsBfX2BeVPdcjLncMlhJoliQcW1f
         FbCjacFq/PKTx592cxDyR1PZxDa2w9yAJp2otKY/ApI+pW4ourOTBIcXchPFneetOh
         AV1+3NaVgdYvsbkzHvVb513ACsZePrCb7mGbFtzvmHSQSwieaM8RYzyub4rzkpHPKE
         80AfcnOexzCtaNNXOJwfjm99wMilBlU0xVr6/cGAakf7sc3ZXqufmtRfqF36GlKQK8
         ExYfp6EZTmTvw==
Date:   Mon, 28 Nov 2022 11:20:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <20221128112034.54479360@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rzTBwtOvoROYAqMy+0m2x4m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rzTBwtOvoROYAqMy+0m2x4m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  io_uring/net.c

between commit:

  de4eda9de2d9 ("use less confusing names for iov_iter direction initialize=
rs")

from the vfs tree and commit:

  42385b02baad ("io_uring/net: move mm accounting to a slower path")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc io_uring/net.c
index 2818aeefea42,90342dcb6b1d..000000000000
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@@ -1087,7 -1095,8 +1095,8 @@@ int io_send_zc(struct io_kiocb *req, un
  			return ret;
  		msg.sg_from_iter =3D io_sg_from_iter;
  	} else {
+ 		io_notif_set_extended(zc->notif);
 -		ret =3D import_single_range(WRITE, zc->buf, zc->len, &iov,
 +		ret =3D import_single_range(ITER_SOURCE, zc->buf, zc->len, &iov,
  					  &msg.msg_iter);
  		if (unlikely(ret))
  			return ret;

--Sig_/rzTBwtOvoROYAqMy+0m2x4m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOD/tIACgkQAVBC80lX
0GwRIQf/eXLsxZnBgrO8YZ8PZgbjyWb8b6Z0xPmj7mjMJBvgTmSOnfGqAmgHBCMm
0+K/bi9TfnKiomuh1CUPkjwmFaN79zLrHS/xnQferTRGE6VdyBSY/NyL39ISdwzj
mivST3AXKM0Aqx/bbA/GJ6f09q5ongMo5Fjva8vk476nXzBgaKE8BMjQ4oiDZb/s
4WCx902AhxByWgh/IcXG/yl46UwwPHin4Z+6Cwp8A7zqWyuEMnlUISlU3gjiym0q
NXJX77OgYUD5ciaxAnx7Z6/79NLt+rEtHKnKyzGaM73LGMjp9tRTfaXlMGuTRml5
bvxYcFhf/G1DqriHWuGDcrMD1rL2Dw==
=Q6uT
-----END PGP SIGNATURE-----

--Sig_/rzTBwtOvoROYAqMy+0m2x4m--
