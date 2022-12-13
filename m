Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C213064AE49
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiLMDg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLMDg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:36:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496AB30A;
        Mon, 12 Dec 2022 19:36:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWPKz5KBTz4xGH;
        Tue, 13 Dec 2022 14:36:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670902584;
        bh=0dpZOkMGtFQ5ouhxPQNugoBxiyajUF0B9/0jmQS7pD8=;
        h=Date:From:To:Cc:Subject:From;
        b=rWXzh+dzgZ7J/syomEKTY4Fc91svUswM2wBh/0awkjtbT4tM+HoIclPuXAYzAlHgS
         /JHid2mZf6dIqJzU7wT3Q+YbieBiAWS67WxKKcvLAuYaQfsb5bwnbqxoLHhx4tKqDv
         j0zLfUwa2hqKKDBXeWS+ylii/ZNXU++PyozagdYag5gkpasm0DhRnv4M7pTPU5Jrlq
         cj70TOJJBKY7ASDln2im6MI9zN35vic8D7JIPMxNVfpS8jxWEL36QBJvVg+zhJWdkw
         LCuO77ru+OZslarRk1jHgWXYpIJOdQla+ouw9x18MwYs/uMFrt+R0l42htQ1pOFw4d
         iEcEa5m2i0t+Q==
Date:   Tue, 13 Dec 2022 14:36:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the random tree
Message-ID: <20221213143622.5b2cde33@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/74ThfVkdR13hdIlLRWBFr+h";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/74ThfVkdR13hdIlLRWBFr+h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the random tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/char/hw_random/powernv-rng.c: In function 'powernv_rng_read':
drivers/char/hw_random/powernv-rng.c:26:17: error: implicit declaration of =
function 'pnv_get_random_long'; did you mean 'get_random_long'? [-Werror=3D=
implicit-function-declaration]
   26 |                 pnv_get_random_long(buf++);
      |                 ^~~~~~~~~~~~~~~~~~~
      |                 get_random_long
net/ipv4/tcp_plb.c: In function 'tcp_plb_update_state_upon_rto':
net/ipv4/tcp_plb.c:100:18: error: implicit declaration of function 'prandom=
_u32_max'; did you mean 'prandom_u32_state'? [-Werror=3Dimplicit-function-d=
eclaration]
  100 |         pause +=3D prandom_u32_max(pause);
      |                  ^~~~~~~~~~~~~~~
      |                  prandom_u32_state

The latter call has been added recently, but the former is presumably
caused by commit

  5d1056fb3dd8 ("random: do not include <asm/archrandom.h> from random.h")

I have used the random tree from next-20221208 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/74ThfVkdR13hdIlLRWBFr+h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOX8zYACgkQAVBC80lX
0GyA5gf/aGycVd8m8YJfK1julNDugbWyseoBYyHwjd4elFKDCt0BvBxa4B2gTTUp
FZGGMmPEBVj3Rw2gfimp+F620aI42K0V8zDk6gtawVRJILVMBYrYUDjFOarZOD5Q
nOaCpbnjwG/VOdCKOc5TrBu3jgrwmqtujZCLJ0x/Awu0snLB60YiybWNUfkEkXyb
yuvvVmZ8fpMmG6EuWjerypSwAibKDlarlQ169ppLquJCeHwQ/yCv+5MZJuAgnX2H
+yXcTSg6Bbz9gxsQcPyZQqumS00B+zESL6UxClE8XpKwTQeV06PaHG6/t7Q/3CAM
H/QuNim3mySW/ThCykhVmM9M2ZeiCA==
=YT6h
-----END PGP SIGNATURE-----

--Sig_/74ThfVkdR13hdIlLRWBFr+h--
