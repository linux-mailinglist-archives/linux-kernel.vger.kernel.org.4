Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE236DD091
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDKD5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjDKD5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:57:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F6A2683;
        Mon, 10 Apr 2023 20:57:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwX9Q1P7qz4xD5;
        Tue, 11 Apr 2023 13:57:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681185451;
        bh=TuqiUlN1/UdfMhPLkBN3ZC9EuXuba2PpjuEIRG7lxaU=;
        h=Date:From:To:Cc:Subject:From;
        b=tABfIYGFXcmZQtCo+8wdZ2B0awu8NEuoCA/bDj+NEvTsp+jw70vuPyv9LPbXq6YWL
         5uKNlZl2MZQZXEDb5azml3A9G1BwCE+1ezmKWbd37m/utDtHCwtdLATmFrx+Q5Zo6r
         eZt061pidNhyQlenAMs4nbQ1CdlH36p7ovXoyRuYKauFCYA1JX5a5AhzBOrxuOyp1S
         4U8uGijeKhZNJzBpSBXBhtS4EjR2z0fkbCNcNWweG3CcMysHmnmdHOjdodOWlWMrrP
         xkVQd2o47BtezRzeTbEl1O8WSJZwutKla0/ZLWh4YPMBNcAd7tlSTRKesEhxY85kFC
         iA2BwXjeSdhVA==
Date:   Tue, 11 Apr 2023 13:57:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robherring2@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: linux-next: manual merge of the char-misc tree with the devicetree
 tree
Message-ID: <20230411135728.07539d81@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+1=qpEmb_zakdLBx7VGzoDz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+1=qpEmb_zakdLBx7VGzoDz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  drivers/of/Makefile

between commit:

  bac06718990c ("of: Move CPU node related functions to their own file")

from the devicetree tree and commit:

  bd7a7ed774af ("of: Move of_modalias() to module.c")

from the char-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/of/Makefile
index 10f704592561,ae9923fd2940..000000000000
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@@ -1,5 -1,5 +1,5 @@@
  # SPDX-License-Identifier: GPL-2.0
- obj-y =3D base.o cpu.o device.o platform.o property.o
 -obj-y =3D base.o device.o module.o platform.o property.o
++obj-y =3D base.o cpu.o device.o module.o platform.o property.o
  obj-$(CONFIG_OF_KOBJ) +=3D kobj.o
  obj-$(CONFIG_OF_DYNAMIC) +=3D dynamic.o
  obj-$(CONFIG_OF_FLATTREE) +=3D fdt.o

--Sig_/+1=qpEmb_zakdLBx7VGzoDz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ02qgACgkQAVBC80lX
0Gz0eAf9HceJZFa0zfssWzAPKiTo7VN/Zen2kWPHaaP5ZtQPxoICMunQzphusIw/
3psQQwjId+I+QLlqXExHQGO2o264gH3VvALP7Xexb3t1+izq+gm3jkuWQyipxPNr
GNSrNNVExUSzy/vYI383g7RLVrl1MGBICcVOVAqnppnK08AFrxBcz/hsZZDADrN3
VXvfvamHDoosORRAnGHbZGirTNHDKDTVs4S804YTqH7psUQ+6iPSpRY3IdOyT2Ut
CaZr5b2QvlIQWTRdx/YJRjQ1abWCLj9XEdJv13DKqoN69+1vrFtCXPjhIPv1pg6w
2QmmdM5PhiFo0DrhSP5u6H+Hh19Y6g==
=sUWK
-----END PGP SIGNATURE-----

--Sig_/+1=qpEmb_zakdLBx7VGzoDz--
