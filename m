Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F946C9A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 06:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjC0ErE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 00:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC0ErB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 00:47:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171494C39;
        Sun, 26 Mar 2023 21:47:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PlKzQ1VYgz4x7y;
        Mon, 27 Mar 2023 15:46:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679892418;
        bh=jrRfcG5Zjod8TfEOCSntQFkDHdEiZeUh7G8zxbO3qnQ=;
        h=Date:From:To:Cc:Subject:From;
        b=S83D+GpYhKC06R3Pm5NWIwbyJgnDZZBemyBoYtREqxg5NJwyxmXVKpJvm3yiVEzWt
         iUMMAbv+u9yxCs/GqCXzXK48YgTzlUvxn6sLeBUwq7RfH7K6X/XveurBRtWAts/Q8J
         GZPaMlCOWp2p52FYNmV9u5FrIxiOdCLMwl1Pvg2h3kyFv2vLJLDeh/Ubv766g4ZI1M
         pZwWFLqVZUqj+vTk16vO9Cps+QgEOMgcHgrtkyJT6FrdX0NanB0UY4/JES/imMHhc5
         4yQNDraf1CrZmZ1cwIuRIgxWq1tBNh9BOi7D8o8rYW24IeEDTO0nwx7sKJIHjx5EXX
         9B+glGrvK9pSA==
Date:   Mon, 27 Mar 2023 15:46:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the driver-core tree
Message-ID: <20230327154655.58dd627d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4lkzB.XAawV57U7A+8Z8xbU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4lkzB.XAawV57U7A+8Z8xbU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build
(s390-defconfig) failed like this:

drivers/s390/crypto/ap_bus.c:1596:20: error: initialization of 'ssize_t (*)=
(const struct bus_type *, char *)' {aka 'long int (*)(const struct bus_type=
 *, char *)'} from incompatible pointer type 'ssize_t (*)(struct bus_type *=
, char *)' {aka 'long int (*)(struct bus_type *, char *)'} [-Werror=3Dincom=
patible-pointer-types]

(reported here: http://kisskb.ellerman.id.au/kisskb/buildresult/14902509/)

Caused by commit

  75cff725d956 ("driver core: bus: mark the struct bus_type for sysfs callb=
acks as constant")

interacting with commit

  d7b1813af6a5 ("s390/ap: introduce new AP bus sysfs attribute features")

from the s390 tree.

I will apply the following (currently untested) merge fix up patch from
tomorrow:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 27 Mar 2023 15:42:41 +1100
Subject: [PATCH] fixup for "driver core: bus: mark the struct bus_type for =
sysfs callbacks as constant"

interacting with "s390/ap: introduce new AP bus sysfs attribute features"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/s390/crypto/ap_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 85bb0de15e76..8d6b9a52bf3c 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1570,7 +1570,7 @@ static ssize_t bindings_show(const struct bus_type *b=
us, char *buf)
=20
 static BUS_ATTR_RO(bindings);
=20
-static ssize_t features_show(struct bus_type *bus, char *buf)
+static ssize_t features_show(const struct bus_type *bus, char *buf)
 {
 	int n =3D 0;
=20
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/4lkzB.XAawV57U7A+8Z8xbU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQhH78ACgkQAVBC80lX
0GyuoAf9GJWWMegIH7/TVMT1210oHmIZCxIzUqFZRBe+/5lt0vZYn0qhJufB+Y4p
f83Nuw88Y7tI40xxQ9PRpDOPE6ZFlEjpN2vpmS/uDx5rcOyV/yDmeWXgsde/pJUr
E//JddN4AEW1nixh/4jPJVAlGluG0VUmt9EQPhmkp4cApauqcmecdnciOCeRj0ax
uPdGe750Z6y3wBDly4xQ4MVaT72xWXwiKvcbH0IOSUCA0mPIXtL/zBW42ILfGESA
42sR7m2wzx9xaqU2rn7ZUpjHj/O+CO3xwVp9mxeX3X6VIYouvRHRW3zBr1FNn3g6
7dOtHwTviDlUKJoZ9mtBsV3L7oOEhA==
=WhuF
-----END PGP SIGNATURE-----

--Sig_/4lkzB.XAawV57U7A+8Z8xbU--
