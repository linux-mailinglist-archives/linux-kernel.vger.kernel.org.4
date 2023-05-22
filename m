Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0CB70B29E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 02:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjEVAxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 20:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEVAxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 20:53:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623A6DB;
        Sun, 21 May 2023 17:53:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QPf7b1gR0z4x1N;
        Mon, 22 May 2023 10:52:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684716779;
        bh=IFZYqtHvmYjXWyTUb3u5yrGNdgE9k+C2KpTXNadRRfc=;
        h=Date:From:To:Cc:Subject:From;
        b=WvIsa8rX4BVKDXM9ObGvkekHGa2tqVL2CluTAGqKnXYKXkeTX91DQrhWd4UFkBpAP
         50A9cLjMa+Hk7X+eYPDTkn+0t2321Iy8JAu+dpHXT8O6b2qHvBqihN/RuG0gwehaJV
         knTX7ksD20z/VchTeOibNpJNdqZQoFWZHEc50c/9conRFP3DFGpiNIZd/GCSbSNTk9
         NHx6/bXYSU6u5uTnwXZsZIYBsiTL1tvlF/866+UXrNktK0VBy0R4jBGhqcALNc7aNa
         s4w/rlNRboa8RyM1TllUCXKScAxUxxQsi95gW3iIiKHrb5l0lHGJFj8xgOfbGSPEh7
         +PFNQ0cxb8mhQ==
Date:   Mon, 22 May 2023 10:52:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Huan Feng <huan.feng@starfivetech.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20230522105257.562cb1ec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rH6GA9i8=s+/RlhPx=6EfaR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rH6GA9i8=s+/RlhPx=6EfaR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/tty/serial/amba-pl011.c: In function 'pl011_sgbuf_init':
drivers/tty/serial/amba-pl011.c:379:30: error: implicit declaration of func=
tion 'phys_to_page'; did you mean 'pfn_to_page'? [-Werror=3Dimplicit-functi=
on-declaration]
  379 |         sg_set_page(&sg->sg, phys_to_page(dma_addr),
      |                              ^~~~~~~~~~~~
      |                              pfn_to_page
drivers/tty/serial/amba-pl011.c:379:30: error: passing argument 2 of 'sg_se=
t_page' makes pointer from integer without a cast [-Werror=3Dint-conversion]
  379 |         sg_set_page(&sg->sg, phys_to_page(dma_addr),
      |                              ^~~~~~~~~~~~~~~~~~~~~~
      |                              |
      |                              int
In file included from include/linux/kfifo.h:42,
                 from include/linux/tty_port.h:5,
                 from include/linux/tty.h:12,
                 from drivers/tty/serial/amba-pl011.c:25:
include/linux/scatterlist.h:136:69: note: expected 'struct page *' but argu=
ment is of type 'int'
  136 | static inline void sg_set_page(struct scatterlist *sg, struct page =
*page,
      |                                                        ~~~~~~~~~~~~=
~^~~~

Caused by commit

  42ef0e944b01 ("crypto: starfive - Add crypto engine support")

I applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 22 May 2023 10:47:38 +1000
Subject: [PATCH] fixup for "crypto: starfive - Add crypto engine support"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/crypto/starfive/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kcon=
fig
index be58d1473523..8795b2fddb4e 100644
--- a/drivers/crypto/starfive/Kconfig
+++ b/drivers/crypto/starfive/Kconfig
@@ -4,7 +4,7 @@
=20
 config CRYPTO_DEV_JH7110
 	tristate "StarFive JH7110 cryptographic engine driver"
-	depends on SOC_STARFIVE || COMPILE_TEST
+	depends on SOC_STARFIVE
 	select CRYPTO_ENGINE
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/rH6GA9i8=s+/RlhPx=6EfaR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRqvOkACgkQAVBC80lX
0Gx6eQf+NZo9fwOYsYiw+dWPKkZRU4o0Cgg3d9nGr18sc+SloIcXvcYJB48NC1WC
AQ0A8jaDK9JFLv/uD1RxjI2xLrzbyLhS0HWJqQLy384u2xpqK14+S7cirUZfOlyk
21OTxm36Br5hIjqsVd5d+c6Q5ORDFmJDeE++P53ag+j3NJRiVyR29JNt4nb2pOSc
bpk2POpyuU4V2/Jzhv5k4Gx5JUdpg7ltXj6t2PNXnK1FUIcPFBUmmVOJ8zcRBqGO
a7hRmuAt/UVFo1ZInyOtYfnziVrMw0ZxNWvUufFICBnislQMjQMH8MOwRYAU7LiV
/1HLeBnae2jG9DHGnv2QpT2MWwb7lg==
=jHMw
-----END PGP SIGNATURE-----

--Sig_/rH6GA9i8=s+/RlhPx=6EfaR--
