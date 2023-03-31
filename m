Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313376D14DE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 03:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCaBQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 21:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCaBPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 21:15:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B1B12CCA;
        Thu, 30 Mar 2023 18:15:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pnj5W0KBYz4xFd;
        Fri, 31 Mar 2023 12:15:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680225327;
        bh=KnXtwFXSsQTabF2IOwcexSqkQHCVNvjm/ExrY0v7QCo=;
        h=Date:From:To:Cc:Subject:From;
        b=ZyQ/Dtt6jBwhQCKKkV/CATYNqHT/QMKsfPIhUamXUd1DYNigxSW26CkQ5WG/Kkgcf
         uPH7znzVoErvKywq0snyxU5/RK6z7tCcfWJXBx+RBTcvkFGm0UsrNczo6bYiFLBzOd
         a2YgQJrVohM1FRGVavpQ18fb+zfnEkp9qDMfzHZHojCMIFSDrc2ulTdzdNTJbzQb0C
         FqdcLOZo0GuUktzfpb83E57mjMitjPKszyAMk2ocKDOxQYRcm58Mb24HCga7M6ztjw
         P5JsB7cufqkAVGmuH0Z8s5CNcXJnhp6Nqdv+BwmeLlDjjU8A57eSn8wm62wk9G0/Ir
         quz859Ujw+8PA==
Date:   Fri, 31 Mar 2023 12:15:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@kernel.org>,
        Min Li <min.li.xe@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mfd tree
Message-ID: <20230331121525.42c861fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tJ5DS1elNKOGT9f4AKlJi5E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tJ5DS1elNKOGT9f4AKlJi5E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mfd tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/mfd/rsmu_i2c.c:282:18: error: initialization of 'int (*)(struct i2c=
_client *)' from incompatible pointer type 'int (*)(struct i2c_client *, co=
nst struct i2c_device_id *)' [-Werror=3Dincompatible-pointer-types]
  282 |         .probe =3D rsmu_i2c_probe,
      |                  ^~~~~~~~~~~~~~
drivers/mfd/rsmu_i2c.c:282:18: note: (near initialization for 'rsmu_i2c_dri=
ver.<anonymous>.probe')

Caused by commit

  1b3b1d6c27cc ("mfd: rsmu: Support 32-bit address space")

interacting with commit

  03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")

from Linus' tree (v6.3-rc2).

I applied the following merge fix patch (which may not be right :-():

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 31 Mar 2023 12:05:44 +1100
Subject: [PATCH] fixup for "mfd: rsmu: Support 32-bit address space"

interacting with "i2c: Switch .probe() to not take an id parameter"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/mfd/rsmu_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
index 221023faaadf..26972a5aff45 100644
--- a/drivers/mfd/rsmu_i2c.c
+++ b/drivers/mfd/rsmu_i2c.c
@@ -201,9 +201,9 @@ static const struct regmap_config rsmu_sl_regmap_config=
 =3D {
 	.can_multi_write =3D true,
 };
=20
-static int rsmu_i2c_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+static int rsmu_i2c_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
 	const struct regmap_config *cfg;
 	struct rsmu_ddata *rsmu;
 	int ret;
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/tJ5DS1elNKOGT9f4AKlJi5E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQmNC0ACgkQAVBC80lX
0GwS3Af/Tk/8By0z+zLFHnOw/5R5qlYKmrFXQBWWBsxn5xpmve56oEYHUQEdfdKD
H1HKjlCp7AKoru4HqIPMJNPf4VoUEZsGLo8QwoThI8u87yQBAI6u75i5yS7RyVCo
wPHvNsLLWqF7jOfxb09CTza4E7ZxRfQJPhQjpMiYsc6Xjp++McQRY8WHkkl/ns7L
MhZrtc51KkyC4xIrvmiqVI674XqJR+f4eWRGywlM/OSky/9Y+Ae3PBH+9sE6742t
MkouWY1zn05sDW9KU1powEgj/jXPFlrexCfODTGPk8O02XQw3SNk2jIfEUVOZcXZ
j8JK2A1xyzIcbTUh3bOpRrlLGuXjuQ==
=hfnX
-----END PGP SIGNATURE-----

--Sig_/tJ5DS1elNKOGT9f4AKlJi5E--
