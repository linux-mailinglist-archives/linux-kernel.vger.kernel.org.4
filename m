Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D75E60982F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJXCXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJXCXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:23:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8B972EED;
        Sun, 23 Oct 2022 19:23:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mwf4n4gDtz4xGG;
        Mon, 24 Oct 2022 13:23:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666578203;
        bh=/Tq9xRBdbj+40nhvqAduH8dkk6pDuOMySNItE+cAbTQ=;
        h=Date:From:To:Cc:Subject:From;
        b=geXXeI+LvuUptQOBfE23YjsBENA5txOHrxwJrTl1TyNBeLEJN7DFjKlqIHu949fuu
         FjkQ9TDZqGqMzb1TlATJhBkbs3jNPssm/F5y++HEyWuEMLdWCgWmhESaIpl26EtRRV
         ezkckF94BgrVDv8lVNdLJtK61IwJK4iDoERDoZ/m4VyfJSQwOvjFeWv6zuVOB76in0
         vNSQCmGh9p1jiIyAD10Q6+/Z6Mef9zl6AM8Cp5oiCiESq0k7ym79YjodBRqt28d6SM
         qCipC418Y4hjr+JefECeK5gBbrHIFytrE1P9Apcc3bgyGb38rlRNjCiaxfG3OQiSQR
         dYhZBa+pv2Zgg==
Date:   Mon, 24 Oct 2022 13:23:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the random tree
Message-ID: <20221024132319.4b3910ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kjMiFfxXq5vz7hr07onb.XL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kjMiFfxXq5vz7hr07onb.XL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the random tree, today's linux-next build (x86_64
allmodconfig) failed like this:

arch/x86/mm/cpu_entry_area.c: In function 'init_cea_offsets':
arch/x86/mm/cpu_entry_area.c:38:23: error: implicit declaration of function=
 'prandom_u32_max'; did you mean 'prandom_u32_state'? [-Werror=3Dimplicit-f=
unction-declaration]
   38 |                 cea =3D prandom_u32_max(max_cea);
      |                       ^~~~~~~~~~~~~~~
      |                       prandom_u32_state
cc1: all warnings being treated as errors

Caused by commit

  921b09c09fe7 ("prandom: remove prandom_u32_max()")

interacting with commit

  1248fb6a8201 ("x86/mm: Randomize per-cpu entry area")

from the tip tree.

I have applied the following fix up patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 24 Oct 2022 12:37:28 +1100
Subject: [PATCH] fix up for "prandom: remove prandom_u32_max()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/x86/mm/cpu_entry_area.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index ad1f750517a1..7a1b63fb80d3 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -35,7 +35,7 @@ static __init void init_cea_offsets(void)
 		unsigned int cea;
=20
 again:
-		cea =3D prandom_u32_max(max_cea);
+		cea =3D get_random_u32_below(max_cea);
=20
 		/* Make sure that no previous CPU shares the offset: */
 		for_each_possible_cpu(j) {
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/kjMiFfxXq5vz7hr07onb.XL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNV9xcACgkQAVBC80lX
0Gy/Jwf/Z/ih5yV0JUrnn3OGWk/tdDLXoDV4f3BroGrPAOs5y3gMYVSet3zRVW3H
9hjya8jsDqZd9gfjSVhzav2sHRndJ+mKVQToqZvBprZXH4PC3yZx1zaW+a1pwbv+
LhK8u3c6Q86exZc9FazgE9w6WEuNWZjv7Ngsqp3lJH5p/VeMP65JJ6x51z3CHUMy
4FMZZXs5sx/BkkXURDxy4CDsrnkWsPToTDvJyrdhnPCSwj3b42hqPl+Mrvf/xCBk
EsBKSbiULTXdQT85H8xG8cpggekI6qQwTT6c6ioOtYLnI3OLNsffUCaMiGBlwrWz
8llMOTjIeZ79CkXzFS4vcBCI0xDXnQ==
=HmRd
-----END PGP SIGNATURE-----

--Sig_/kjMiFfxXq5vz7hr07onb.XL--
