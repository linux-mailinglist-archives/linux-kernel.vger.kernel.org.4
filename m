Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A695BF37F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIUCbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIUCbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:31:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F2061DBC;
        Tue, 20 Sep 2022 19:31:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MXMqQ0znRz4xFs;
        Wed, 21 Sep 2022 12:31:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663727492;
        bh=cdHIJZOotuCS+2QMq1zTXu1a/G/bfHahkqRi0IV7SDg=;
        h=Date:From:To:Cc:Subject:From;
        b=MLbB0zRx+BamviS93M7JFEmqe/GOzeMh8+fN6DxZYA1MgqFdYUf4SkGzgyPAYxlFc
         k/Eq0DQacBImZPm1oZGUeG6FxGyDRh1hkb6gGlG0DyDtIlnOPAbogo0Z4yvE59XrEI
         6ZxJN6ZZHs7q7KAbVYzE7fKYkXXD1WgyY1BdrEoGlZILD2mD1agY4FTiODx2bMWLS0
         f6bxohtziTXxlZAHrXe58Rfod7FKjb7pRjlcxhgNP2C9pvcz5EjHuly9CdWVyDrA6q
         vlVF3i+ruM5loemQoRls19wGO108nfAIvD/sVF/J4WycBCIO4OF+gcR4AkO1xHHU1i
         BwSlXUT3N3vIw==
Date:   Wed, 21 Sep 2022 12:31:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Martin =?UTF-8?B?UG92acWhZXI=?= <povik+lin@cutebit.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20220921123128.689af098@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hNGMTUA85LxlbFZPa6LH8LD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hNGMTUA85LxlbFZPa6LH8LD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/soc/codecs/cs42l83-i2c.c:234:19: error: initialization of 'void (*)(s=
truct i2c_client *)' from incompatible pointer type 'int (*)(struct i2c_cli=
ent *)' [-Werror=3Dincompatible-pointer-types]
  234 |         .remove =3D cs42l83_i2c_remove,
      |                   ^~~~~~~~~~~~~~~~~~
sound/soc/codecs/cs42l83-i2c.c:234:19: note: (near initialization for 'cs42=
l83_i2c_driver.remove')

Caused by commit

  94d5f62a91aa ("ASoC: cs42l83: Extend CS42L42 support to new part")

interacting with commit

  ed5c2f5fd10d ("i2c: Make remove callback return void")

from the i2c tree.

I applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 21 Sep 2022 12:24:03 +1000
Subject: [PATCH] ASoC: cs42l83: fix up for "i2c: Make remove callback return
 void"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 sound/soc/codecs/cs42l83-i2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l83-i2c.c b/sound/soc/codecs/cs42l83-i2c.c
index ba8772aa51e1..f90d43996a51 100644
--- a/sound/soc/codecs/cs42l83-i2c.c
+++ b/sound/soc/codecs/cs42l83-i2c.c
@@ -192,13 +192,11 @@ static int cs42l83_i2c_probe(struct i2c_client *i2c_c=
lient)
 	return cs42l42_init(cs42l83);
 }
=20
-static int cs42l83_i2c_remove(struct i2c_client *i2c_client)
+static void cs42l83_i2c_remove(struct i2c_client *i2c_client)
 {
 	struct cs42l42_private *cs42l83 =3D dev_get_drvdata(&i2c_client->dev);
=20
 	cs42l42_common_remove(cs42l83);
-
-	return 0;
 }
=20
 static int __maybe_unused cs42l83_i2c_resume(struct device *dev)
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/hNGMTUA85LxlbFZPa6LH8LD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMqd4AACgkQAVBC80lX
0Gwh2gf/ZZC3I20StOvuZ/IXAR8i7hFojgvn9JgwTOS3m87dh+BQxSk5ZChmdKP4
PJ2SO22EFkuk+T0vdK2kOVzPd+1BltfksbtunKf4AoDNVcH0TMgkWmf5hO5k2MVc
oWTodp36R8HlZrS5JmFcXNsqMkBy+zPHC1BOVPN9SZD5LDMKOpPsN0VHYemHegop
aCszCFFkOYoNcFK96Y4MUtN6XP1BO0Qt2PeA5i5OplR18FNqEV9Z6uui8e9FbfCI
/8tTxkj+u5UYVDnPMf40hsUgZqO/X1wfxXjd2TZSwrMmXWvfGMPbMTDNpu/n6PiX
BrT6jbfg7Th4IfcC9Dn6Lhxmgd6oTQ==
=0Wfm
-----END PGP SIGNATURE-----

--Sig_/hNGMTUA85LxlbFZPa6LH8LD--
