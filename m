Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65657728D20
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbjFIBef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbjFIBed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:34:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDA430E6;
        Thu,  8 Jun 2023 18:34:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QckBz42pXz4x3y;
        Fri,  9 Jun 2023 11:34:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686274460;
        bh=ED31x0GBE6AUoxKq0mTBJaL5CwwJEO4lrowDNq71OlI=;
        h=Date:From:To:Cc:Subject:From;
        b=QDlrhHGymehfMXiliOjDuDZDsurMFdLpI8BswjR4/+ykA25hUUGqnWaU2E7+Nbuxe
         QH0j/j32dPbMbzf0Pc4TlPoLMeEQpkYU5Y/pLXpqK1/0820+O2yOxSCq6Eja0lvvhA
         FKnEFhCNFOC5ZwKYIPoRfhJfT+dFCLQjkvRiLeHn5zCm89BS0J/rYmFbmtNP/2KgQH
         znl4FZ9GIHN3a7iGdsVeRR35numHca8sJFhsrK4g5CP8eOITHgKGoDLf8aqJdCUbrd
         Axnp9u8GjqAUEdDCDZksLltfISyJgJu6gLoV2tTX1V8TuQVNAVlWCAabjNX95DU9QG
         k3LLBxMYNa+hA==
Date:   Fri, 9 Jun 2023 11:34:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mmc tree
Message-ID: <20230609113418.4044d159@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Hg.TORrdUmj3WNjplz275F6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hg.TORrdUmj3WNjplz275F6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mmc tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from drivers/mmc/host/mtk-sd.c:38:
drivers/mmc/host/mtk-sd.c: In function 'msdc_cqe_cit_cal':
drivers/mmc/host/cqhci.h:27:41: error: implicit declaration of function 'FI=
ELD_GET' [-Werror=3Dimplicit-function-declaration]
   27 | #define CQHCI_ITCFMUL(x)                FIELD_GET(CQHCI_CAP_ITCFMUL=
, (x))
      |                                         ^~~~~~~~~
drivers/mmc/host/mtk-sd.c:2468:19: note: in expansion of macro 'CQHCI_ITCFM=
UL'
 2468 |         itcfmul =3D CQHCI_ITCFMUL(cqhci_readl(cq_host, CQHCI_CAP));
      |                   ^~~~~~~~~~~~~

Caused by commit

  364dae3e80a4 ("mmc: mtk-sd: reduce CIT for better performance")

I have used the mmc tree from next-20230608 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Hg.TORrdUmj3WNjplz275F6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSCgZoACgkQAVBC80lX
0GxyYQf/ZX/3IZYjl+8QzRym6fxaEF5aHMBuZwhVcW7s3ejFs8hgCTu97bQy4ull
JFI69VZOZG7jvMpBUoVx5WhXsXcxi4wc6hmgGRnkdCVtuFdTeK36NhWZRZYk/3ne
RQiEYFKdKYx7VMpGsLX8QUKWRdjRLqE9LTvPpEayC38X4VDL+orzvi0QzVsrNQEa
0w1tuHUDbYP4JyARtoM6MxB2Odq4XveWkEiu1JEyyOu38Bs1ter1GL16gEgztLzD
yevdO+YZmRrWrSbtMbpYkzlxmUBi1jf8Qb+AeWDKfF87/SxCo2y7Ewtc+FpzHhJx
uFgSH7647xcIRoIUlufkpCa20/0rzw==
=0Wbu
-----END PGP SIGNATURE-----

--Sig_/Hg.TORrdUmj3WNjplz275F6--
