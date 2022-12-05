Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB464222B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 05:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiLEED0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 23:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiLEEDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:03:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158A4E0BE;
        Sun,  4 Dec 2022 20:03:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQVJk2lxBz4x1V;
        Mon,  5 Dec 2022 15:03:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670212999;
        bh=bn+Ynyqonbkxhlxq9RLq/EqIlQxsr9VMxyD6RntrAqU=;
        h=Date:From:To:Cc:Subject:From;
        b=moV6G4PPYlMrXZikQmQXGbAMs2IaAVZgfXBoQz12bjMla6cRPQHGQ9ZJ/1F+nQetC
         fcRpTUb/oMtctGpKVlEC9zliH+a0NTRagwugKpd4SjdT8wHNGaO+g0FOf3j3wcs/yU
         W0bcq66kcT5mVLcWch2KeGeaTluvT1FpRKLKOwoWZu4UPLaRwk4g3ov43Y9ph5jmkD
         2XjrRv6o3UkZavJkUO3j7P8A2v7zq9ux4fhsaaveFjJyWt4pb9pOD7BcLaVKEms5FX
         HKiA0FgZ9g9X+D1z4aPeqX5zk/r+zxGNX3fFJM7cVL47tHQjaJuqDeg+WhsMci9arL
         5ddiAUBJSMJQw==
Date:   Mon, 5 Dec 2022 15:03:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the v9fs tree
Message-ID: <20221205150316.6fac25f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K/gVDou+ok0MxDNaJnE=fl8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K/gVDou+ok0MxDNaJnE=fl8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v9fs tree, today's linux-next build (i386 defconfig)
failed like this:

In file included from include/linux/kernel.h:29,
                 from arch/x86/include/asm/percpu.h:27,
                 from arch/x86/include/asm/nospec-branch.h:14,
                 from arch/x86/include/asm/paravirt_types.h:27,
                 from arch/x86/include/asm/ptrace.h:97,
                 from arch/x86/include/asm/math_emu.h:5,
                 from arch/x86/include/asm/processor.h:13,
                 from arch/x86/include/asm/timex.h:5,
                 from include/linux/timex.h:67,
                 from include/linux/time32.h:13,
                 from include/linux/time.h:60,
                 from include/linux/stat.h:19,
                 from include/linux/module.h:13,
                 from net/9p/client.c:11:
net/9p/client.c: In function 'p9_check_errors':
include/linux/kern_levels.h:5:25: error: format '%ld' expects argument of t=
ype 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wer=
ror=3Dformat=3D]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
include/linux/printk.h:429:25: note: in definition of macro 'printk_index_w=
rap'
  429 |                 _p_func(_fmt, ##__VA_ARGS__);                      =
     \
      |                         ^~~~
include/linux/printk.h:500:9: note: in expansion of macro 'printk'
  500 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
   11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
      |                         ^~~~~~~~
include/linux/printk.h:500:16: note: in expansion of macro 'KERN_ERR'
  500 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |                ^~~~~~~~
net/9p/client.c:523:17: note: in expansion of macro 'pr_err'
  523 |                 pr_err(
      |                 ^~~~~~
cc1: all warnings being treated as errors

Caused by commit

  36cd2f80abf8 ("net/9p: fix response size check in p9_check_errors()")

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 5 Dec 2022 14:55:10 +1100
Subject: [PATCH] net/9p: use %zu to print size_t

Fixes: 36cd2f80abf8 ("net/9p: fix response size check in p9_check_errors()")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/9p/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index deb7baa178f3..6db5e0c55f9c 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -521,7 +521,7 @@ static int p9_check_errors(struct p9_client *c, struct =
p9_req_t *req)
 	err =3D p9_parse_header(&req->rc, NULL, &type, NULL, 0);
 	if (req->rc.size > req->rc.capacity && !req->rc.zc) {
 		pr_err(
-			 "requested packet size too big: %d does not fit %ld (type=3D%d)\n",
+			 "requested packet size too big: %d does not fit %zu (type=3D%d)\n",
 			 req->rc.size, req->rc.capacity, req->rc.id);
 		return -EIO;
 	}
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/K/gVDou+ok0MxDNaJnE=fl8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmONbYQACgkQAVBC80lX
0Gy/rwf/XJjnu0djTWhMmOlluPZjx+Ppnqm917cJ4FiUaquVBOE7xPaklkIpWUZV
eFAeeJuHzwHy8RESk7+Xmc9tJ5ZIfH7nGhiyQSsfNZq76pHZDrzX0u5yaoOknWjl
cvwlAHuWJ6Gt3LJRd8zHXahjkHc5588oiUDkuLB0triWSBGWjQC1XOgZbsfWlGxZ
8BHfkQgaKQDpHCu75gqG5+deuVAkClBBRrq7EhzKy+cTKOUaBvLYSuAcvbUDsjIn
FCa9fXxYy+RUMl/xwl6WzvHpJ7eLivNvdHnRKBmxz81qlkXU7qjm8qwJWTpv/XH9
vdQ7c1KXxp9Jrj1vhOmpRjs0MywF3g==
=OnM1
-----END PGP SIGNATURE-----

--Sig_/K/gVDou+ok0MxDNaJnE=fl8--
