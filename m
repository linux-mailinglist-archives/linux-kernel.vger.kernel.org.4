Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC1A70417C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343579AbjEOXnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbjEOXnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:43:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E6B83C2;
        Mon, 15 May 2023 16:42:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKwsX54Htz4x3x;
        Tue, 16 May 2023 09:42:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684194177;
        bh=OrgdnrGF4v8mN+2U0+5f2NWgObxDsfRt21qDJiLrFeI=;
        h=Date:From:To:Cc:Subject:From;
        b=r5hCXrc6q2jBi8zEztQkisBbd/8qQczT6Upx7kVEvGdbUoMlEmvL9yRZQRkHWlJMU
         E8OkWyrgW4w3TbINrB01LgUVayOgyDMWwvvsiZAh1RNJjXCdiY1EK2JY5jh/+Y9IAh
         rvuE463jWeK5a4H/o9R2rwoiayP7QdaA/5rk2Z6sZs4JIzbOhQrcRZM3ReDNQ0PXlz
         NgLQf2Nvl/0Q3c4S9Jk1wdhcydLqTLzDjPB/bg3H2oCwZUzvXSOeS/RZo/9C0bFl3F
         5tsL3kSL6HzTKvpF2j77gcfxj1C/jJpJOoOsKkxNkXmtgEoy1sGpoM6hAM1Bi78Xmn
         dAWCpLVZOgwAQ==
Date:   Tue, 16 May 2023 09:42:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>
Cc:     Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20230516094254.0dce3596@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xReCTcQmM/+3dpFGl4YLIjz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xReCTcQmM/+3dpFGl4YLIjz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/freescale/fec_main.c

between commit:

  6ead9c98cafc ("net: fec: remove the xdp_return_frame when lack of tx BDs")

from the net tree and commit:

  144470c88c5d ("net: fec: using the standard return codes when xdp xmit er=
rors")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/freescale/fec_main.c
index 577d94821b3e,cd215ab20ff9..000000000000
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@@ -3798,7 -3798,8 +3798,7 @@@ static int fec_enet_txq_xmit_frame(stru
  	entries_free =3D fec_enet_get_free_txdesc_num(txq);
  	if (entries_free < MAX_SKB_FRAGS + 1) {
  		netdev_err(fep->netdev, "NOT enough BD for SG!\n");
- 		return NETDEV_TX_BUSY;
 -		xdp_return_frame(frame);
+ 		return -EBUSY;
  	}
 =20
  	/* Fill in a Tx ring entry */

--Sig_/xReCTcQmM/+3dpFGl4YLIjz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRiw34ACgkQAVBC80lX
0GxE3Qf/dQRSICKa/aXKnAipj0c64fKGFp4Mw3WVFWpEc2lYd8a60D5xp486j5Bl
ue91l7iejsnqZLZDj+5X8OYLtRYEpI5IEIFRcTaz1S0N2AYUB+huX4+3hMDWksEv
TaE9sx8fdsGjUEzKc78o7RRlRllx8pMRMRvWc+iGQyDNyXQyOdESZlDGzH0slQ7G
nMuU3jb31dXPA2hwdMzMit/yY2UqBIoMcw9G4qsiIqbtVKWk6sKPDioYs6mOf15j
2ZQSioN9KHYEmC6V/IKooZTFCso8zUX6tzu698dt1rRdHrcQuVAe2dRjIvWU0UGF
5equ57YPVGV2nrSFjpHkgGItvNrSAQ==
=+yrr
-----END PGP SIGNATURE-----

--Sig_/xReCTcQmM/+3dpFGl4YLIjz--
