Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7AF63CCEC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 02:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiK3BjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 20:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiK3BjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 20:39:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867AD419AB;
        Tue, 29 Nov 2022 17:38:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMMLR4ZbGz4xN1;
        Wed, 30 Nov 2022 12:38:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669772335;
        bh=S09qSTxVAeYLa+bEiTStg2a5aihdhW/RVjbfsQ+wyNI=;
        h=Date:From:To:Cc:Subject:From;
        b=gRriNOGprfi16fxiwu57dQvOm049aXL2lGf/6kCDLjp4i7alGJypfwsDEPKE6csmq
         dWx35fEKydCB8CdLsFxbCsEaWlSRcZWFzW+cwUJLqpRYfDKvrdRM05cgeMWYp0yhYH
         YY6C16LbQypoNnm0ofoP7FDkmVtGVFUy/Xcj0OHAVwBbiJgeVYo2BIislB7KSeMuYc
         VtA1obHrrEK6DwXL5ySdIm99R5uAfISfhjYhSUmuryrtvXvVQ+i5SXcMukMU06wz17
         Vqv+wS0v4FEylfJKXB9/XVE4hUW1B/K225NuCQerlAH3Xf7RCoJXx7sOPQ1XztRn9X
         M+E/vfmauDRXw==
Date:   Wed, 30 Nov 2022 12:38:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the driver-core tree
Message-ID: <20221130123851.6a9f2242@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VB85lSD9ypfr+.h9aNp6B8k";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VB85lSD9ypfr+.h9aNp6B8k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/scsi/cxlflash/main.c: In function 'cxlflash_class_init':
drivers/scsi/cxlflash/main.c:3890:33: error: assignment to 'char * (*)(cons=
t struct device *, umode_t *)' {aka 'char * (*)(const struct device *, shor=
t unsigned int *)'} from incompatible pointer type 'char * (*)(struct devic=
e *, umode_t *)' {aka 'char * (*)(struct device *, short unsigned int *)'} =
[-Werror=3Dincompatible-pointer-types]
 3890 |         cxlflash_class->devnode =3D cxlflash_devnode;
      |                                 ^

Caused by commit

  ff62b8e6588f ("driver core: make struct class.devnode() take a const *")

I have applied the following patch for today (please add it to your tree).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 30 Nov 2022 12:13:00 +1100
Subject: [PATCH] driver core: fix up missed scsi/cxlflash class.devnode() c=
onversion.

Fixes: ff62b8e6588f ("driver core: make struct class.devnode() take a const=
 *")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/scsi/cxlflash/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index cd1324ec742d..395b00b942f7 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -3857,7 +3857,7 @@ static void cxlflash_pci_resume(struct pci_dev *pdev)
  *
  * Return: Allocated string describing the devtmpfs structure.
  */
-static char *cxlflash_devnode(struct device *dev, umode_t *mode)
+static char *cxlflash_devnode(const struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "cxlflash/%s", dev_name(dev));
 }
--=20
2.35.1

I also added the following (found using
git grep '(struct device\s*\*[^,]*,\s*umode_t[^,]*)'
- please also add this):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 30 Nov 2022 12:32:57 +1100
Subject: [PATCH] driver core: fix up missed drivers/s390/char/hmcdrv_dev.c =
class.devnode() conversion.

Fixes: ff62b8e6588f ("driver core: make struct class.devnode() take a const=
 *")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/s390/char/hmcdrv_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/hmcdrv_dev.c b/drivers/s390/char/hmcdrv_dev.c
index 20e9cd542e03..cb8fdf057eca 100644
--- a/drivers/s390/char/hmcdrv_dev.c
+++ b/drivers/s390/char/hmcdrv_dev.c
@@ -90,7 +90,7 @@ static dev_t hmcdrv_dev_no; /* device number (major/minor=
) */
  *
  * Return: recommended device file name in /dev
  */
-static char *hmcdrv_dev_name(struct device *dev, umode_t *mode)
+static char *hmcdrv_dev_name(const struct device *dev, umode_t *mode)
 {
 	char *nodename =3D NULL;
 	const char *devname =3D dev_name(dev); /* kernel device name */
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/VB85lSD9ypfr+.h9aNp6B8k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOGtCwACgkQAVBC80lX
0Gy+WAgAhJYjCPCHHfrlMMnwpwRix4aAtHp/0QmOAqCWesSYhhH/b3eRLpTLkbPc
HCYyf9Yq69sWt8tswjjXC39IkFEDN34TBQAfAGHZCQbMfQX2z1DyblLy9BYHd5A3
L80ei5Ja1dVblR+XyrG2yVXl8gw+FDhrwHJWs7FG+b3G5/12bzomFBt9wPijhFra
pFoWBo+jFP/Z44Vheq6MbpV05T7vfNjPGMJ5zp5CK2YYsEANUNdsEwssTWlRA93/
ValkkaQBsv1ODw3cawzN4E3wGezAULPOSNRZwIYNsrE/3gPowG6kB6fNvydqDvZJ
b5ALWCjNr01klURdELdxp05IgixUoQ==
=B0HT
-----END PGP SIGNATURE-----

--Sig_/VB85lSD9ypfr+.h9aNp6B8k--
