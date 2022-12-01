Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387E163E7A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLACSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLACSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:18:30 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56D02872A;
        Wed, 30 Nov 2022 18:18:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NN09Z4my0z4xG6;
        Thu,  1 Dec 2022 13:18:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669861107;
        bh=kEd/xZARf6Mr8dAYiKlsLt6883mfgikoGzqEeJFFmT8=;
        h=Date:From:To:Cc:Subject:From;
        b=uWy8prUs1+224MpFaqu8Ev2Y62sxe1Ol0PjThnSnEVy2yB6Z6z6acA3/BOFWQfZmp
         FmcUspNlV3uER/N7VAKYdq3qCmYfFSKrl4V1JukwBn2CxTWH8DpuwwHrssqXKknX8w
         kpMesnuPI60FizQ9oe+HtcO/gD3LBxbD07mx/KQJY1kK5deSuwVHl2U68CRqBEWP4j
         6J6dgxyqGdBaDd9+NWBhhXrYjYWL8GOfjAjQmQfJNTQyZOfXiTNb7JOJhTPArGPW0n
         MIBAAkkIAE6mE1du0vPjSrt57qr8+/n8Wu28FTwnIdGjmn/tW0+H3QKIIEt/sQBzo/
         6GJPIIvB3pfxA==
Date:   Thu, 1 Dec 2022 13:18:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the driver-core tree
Message-ID: <20221201131825.701fb3f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.8EklvJ2jx7ZkOzHVWLYcUu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.8EklvJ2jx7ZkOzHVWLYcUu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/../../accel/drm_accel.c: In function 'accel_sysfs_init':
drivers/gpu/drm/../../accel/drm_accel.c:41:30: error: assignment to 'char *=
 (*)(const struct device *, umode_t *)' {aka 'char * (*)(const struct devic=
e *, short unsigned int *)'} from incompatible pointer type 'char * (*)(str=
uct device *, umode_t *)' {aka 'char * (*)(struct device *, short unsigned =
int *)'} [-Werror=3Dincompatible-pointer-types]
   41 |         accel_class->devnode =3D accel_devnode;
      |                              ^

Caused by commit

  ff62b8e6588f ("driver core: make struct class.devnode() take a const *")

interacting with commit

  8bf4889762a8 ("drivers/accel: define kconfig and register a new major")

from the drm tree.

I have applied the following merge resolution patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 1 Dec 2022 13:08:06 +1100
Subject: [PATCH] fix up for "drivers/accel: define kconfig and register a n=
ew major"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/accel/drm_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
index a5ee84a4017a..1b69824286fd 100644
--- a/drivers/accel/drm_accel.c
+++ b/drivers/accel/drm_accel.c
@@ -27,7 +27,7 @@ static struct device_type accel_sysfs_device_minor =3D {
 	.name =3D "accel_minor"
 };
=20
-static char *accel_devnode(struct device *dev, umode_t *mode)
+static char *accel_devnode(const struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "accel/%s", dev_name(dev));
 }
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/.8EklvJ2jx7ZkOzHVWLYcUu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOIDvEACgkQAVBC80lX
0Gxx2gf/XA+fAqxqjyAf1I4t3IUjS0OgCPGJGGg21g4mKcEtRS63zQAr/TM8z5Af
kR+vX9j3b+B/iUNy8WnlvEx/utkenW+qKZGckyBL7ryuihpjLoJkKztFcwz/tRe+
U5nfjM9sXlvX5WTQVPnZQrVryadA22SaU+PJvReqRJi0cqHkpoV82LAUSTuevr0C
jTYI2i0y5yIV/XJRj+dxoYTQYdgJTUjVGq1cTQJmnXq35tZcvCjxFRZKArE4jqMz
2qfXQKHLjQj8eAYdoT1zsMVawfHvLfgcJo0YlvZ2hT7DfeOdPRqoVrt0dAMlnTxD
bhTZfXnAXoi1wpF1oPb74Ow4ZCWyLA==
=ddvj
-----END PGP SIGNATURE-----

--Sig_/.8EklvJ2jx7ZkOzHVWLYcUu--
