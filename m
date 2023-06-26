Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60A73D613
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjFZDER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjFZDEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:04:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502A51A7;
        Sun, 25 Jun 2023 20:04:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqCNp1hgvz4wZv;
        Mon, 26 Jun 2023 13:04:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687748650;
        bh=nW+gk4tqRBDSjlpCVThkyz/Is6m0YP4thr/RaTzC5Tw=;
        h=Date:From:To:Cc:Subject:From;
        b=iPtnMJv9ZU5Lef7TGbo///iWdCz+amklWeLzzJmeSVNaNd6qrU827kqNnXDW1aTCp
         /wsQMOOotg2JJTCK+hKBeaR859X7uctmty522NDxUdVeO8Qdxlo2dszicaFOAoTvQr
         /Xyp9B3l+QgZgfKs7etT6qXNoex4/54Uy3waOm3cAJ0YRhOLrTHgMl7Jam3cefJ7oW
         iDvlIP9dDQEdGipiW7b3d0W6z7yEA3hd7t0wr64dOCLxNGeog5ABMkrm5MPTor2M76
         ejG1gbBuNSdpSEUVJSSXtt5bUi1RWzFuzVYwBGInBplv4vnfWKJfKe86V85ave1tZe
         lzUpBoobeAKNg==
Date:   Mon, 26 Jun 2023 13:04:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with Linus' tree
Message-ID: <20230626130409.1ae2b54e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bOHHKOyCXE1/DXONO1ubTfv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bOHHKOyCXE1/DXONO1ubTfv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  io_uring/net.c

between commit:

  78d0d2063bab ("io_uring/net: disable partial retries for recvmsg with cms=
g")

from Linus' tree and commit:

  88fc8b8463b0 ("io_uring/net: initalize msghdr->msg_inq to known value")

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
index 4b8e84768d2a,369167e45fa8..000000000000
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@@ -790,19 -794,17 +803,20 @@@ retry_multishot
  	flags =3D sr->msg_flags;
  	if (force_nonblock)
  		flags |=3D MSG_DONTWAIT;
 -	if (flags & MSG_WAITALL)
 -		min_ret =3D iov_iter_count(&kmsg->msg.msg_iter);
 =20
  	kmsg->msg.msg_get_inq =3D 1;
+ 	kmsg->msg.msg_inq =3D -1U;
 -	if (req->flags & REQ_F_APOLL_MULTISHOT)
 +	if (req->flags & REQ_F_APOLL_MULTISHOT) {
  		ret =3D io_recvmsg_multishot(sock, sr, kmsg, flags,
  					   &mshot_finished);
 -	else
 +	} else {
 +		/* disable partial retry for recvmsg with cmsg attached */
 +		if (flags & MSG_WAITALL && !kmsg->msg.msg_controllen)
 +			min_ret =3D iov_iter_count(&kmsg->msg.msg_iter);
 +
  		ret =3D __sys_recvmsg_sock(sock, &kmsg->msg, sr->umsg,
  					 kmsg->uaddr, flags);
 +	}
 =20
  	if (ret < min_ret) {
  		if (ret =3D=3D -EAGAIN && force_nonblock) {

--Sig_/bOHHKOyCXE1/DXONO1ubTfv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSZACkACgkQAVBC80lX
0Gxc0wgAixPa1rtWmoFbpvyRB0jZhW1fmPsfJZiVVoVwFQO9Ws9vNqOZdxBJg3vD
GqQHXaXx5O5+SF7QR8uCnPeeFSLXcFidtz1baGu4XOo7rc8BT39Ghjz4dDi4BXTJ
DqSPKhAU3R2fsvbeWnScDn+nMG+DwWuQXX2pMavVuawKyK8/ttsYKX3VxB2swJxz
PmxnoFGwSjZWTLEWejRjRiWJqe2WTiwCDbf7amZwiXUuF7mzAJ8iJan0ZBbzNMwL
gSP45bp0UBWbxlh/Et3MW7K/GuTaQyTdfZsZCyyG7SMT/4ZCfdC3TX73xR7EIWti
aZ/YwNfipXFFziR8pyUhJLQw/SOMeA==
=W4lm
-----END PGP SIGNATURE-----

--Sig_/bOHHKOyCXE1/DXONO1ubTfv--
