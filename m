Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85176D15C9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCaDCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCaDB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:01:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88C11284E;
        Thu, 30 Mar 2023 20:01:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PnlSH5l6lz4xDp;
        Fri, 31 Mar 2023 14:01:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680231713;
        bh=WobWt6+cPCnb86h2wj5ceUTnO5z2lgo4ro4hmE0LsbE=;
        h=Date:From:To:Cc:Subject:From;
        b=atTJ0QlJJDTLbo3E1wIe0bMgohM2pR6DGfXBQLA5sFpR0Cx5x7anWkYS25QdcYfnt
         i1u28QlJumRdwbB9IxrrYSmAKeN98ZqXID0FzdyLhAm9Zb3DT0tMqsFNqg4dXXwpco
         Fu+57bh+QZlcL9cfB6FeN+vLkVNXE1pHbDOyScCX+lfP8PRt0fZ3WyFQ0kCXT7iMJa
         4ePVFZwea53ULc1U4XVV+TsnSgmMW+ffW1/4o4bOkiC/tI6tegnbrGebI0YmYEEZvl
         TWNF/zUva8kJsFShlqTBbKdIMETLoik5W3HAAnaXVmJPU8wWckTaSwSyYV+kVnyEgg
         wHlPqd1NAUKZA==
Date:   Fri, 31 Mar 2023 14:01:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Message-ID: <20230331140150.597576b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PD9HQ45B9J_2jzSgg+34+AH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PD9HQ45B9J_2jzSgg+34+AH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/usb/host/xhci-pci.c

between commit:

  8e77d3d59d7b ("Revert "usb: xhci-pci: Set PROBE_PREFER_ASYNCHRONOUS"")

from the usb.current tree and commit:

  130eac417085 ("xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditi=
onals")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/usb/host/xhci-pci.c
index 6db07ca419c3,bbbb01282038..000000000000
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@@ -771,11 -967,10 +967,9 @@@ static struct pci_driver xhci_pci_drive
  	/* suspend and resume implemented later */
 =20
  	.shutdown =3D 	usb_hcd_pci_shutdown,
- #ifdef CONFIG_PM
  	.driver =3D {
- 		.pm =3D &usb_hcd_pci_pm_ops
+ 		.pm =3D pm_ptr(&usb_hcd_pci_pm_ops),
 -		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
  	},
- #endif
  };
 =20
  static int __init xhci_pci_init(void)

--Sig_/PD9HQ45B9J_2jzSgg+34+AH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQmTR4ACgkQAVBC80lX
0GyDSQf/eocSA4U5XCWAbADJjFVKD4dsDnk8UhCdS8lRxrdDMk9vK2Gngs3s2D57
JtfV6crL/mXkh6vaTilhkvTWEdn6+l1CNh6QLtQQm71DR4uWl8AetiKcRwwCsiPT
HQaiK5u5ESnuGoPwOU2QXTxr8fs8pShDSxsgxu31Sj0CUpzu1wFrBS5ZIPhXWrLF
7h8SD534ePXyDSxo0FgH4RfJLK7YuqL4BRDw8Xg9RJFp2FevlCFvTyP+eGcqMXhp
4csPqPHDmOeNWWaPhjlCuYpVKK8/OhCTEAU8995dku0sCPpIQojn82mjuHwseMYA
NL0YyeJInQ4OBNS9JVUEMI9QROUxtg==
=c1y2
-----END PGP SIGNATURE-----

--Sig_/PD9HQ45B9J_2jzSgg+34+AH--
