Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D75BF2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIUBce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiIUBcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:32:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6F16746E;
        Tue, 20 Sep 2022 18:32:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MXLWH4XnFz4xGH;
        Wed, 21 Sep 2022 11:32:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663723948;
        bh=rtB06E46ZFDnzfIW4+t0U6tLtHydrIYpLQpImBfUZTM=;
        h=Date:From:To:Cc:Subject:From;
        b=mCpyjTnvikXzGSL3O8whMnBzDfw9ROQraWkxX/goU4D9VI2XDs2d5lPmqJfMlf0QC
         +NWf2Jl26QNzKC+Cf8ItOOqCrmDIkXfDmQknK1OgWNuH6WgtwU5IQbtoZYTgE0llOq
         B9rV0gXgYP8C31PABgl0oTAWnMQSsD19J8RoQzHPXA3rb0EJcWIThGyLfeVHwztJg0
         Yap1Hfr0TqVexd9nxpigfrMgD8z7z2JS0E9/2wPE/MnFrVOP2QdjIDhUyx9g6c2yuQ
         h27LhuFWgL0+nNzSRyHZrpki4+Rp2pCjSIpgPzy9rBIr1KvUkqPSY0/ArNipO5k/qT
         9p1T8YA8vDC3A==
Date:   Wed, 21 Sep 2022 11:32:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Valentin Korenblit <vkorenblit@sequans.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the nand tree
Message-ID: <20220921113225.2f45ba3b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mV0zhHIdp9yzgxsaWmhIeqM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mV0zhHIdp9yzgxsaWmhIeqM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nand tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/mtd/nand/raw/cadence-nand-controller.c: In function 'cadence_nand_r=
ead_buf':
drivers/mtd/nand/raw/cadence-nand-controller.c:1893:25: error: implicit dec=
laration of function 'ioread64_rep'; did you mean 'ioread32_rep'? [-Werror=
=3Dimplicit-function-declaration]
 1893 |                         ioread64_rep(cdns_ctrl->io.virt, buf, len_i=
n_words);
      |                         ^~~~~~~~~~~~
      |                         ioread32_rep
drivers/mtd/nand/raw/cadence-nand-controller.c: In function 'cadence_nand_w=
rite_buf':
drivers/mtd/nand/raw/cadence-nand-controller.c:1962:25: error: implicit dec=
laration of function 'iowrite64_rep'; did you mean 'iowrite32_rep'? [-Werro=
r=3Dimplicit-function-declaration]
 1962 |                         iowrite64_rep(cdns_ctrl->io.virt, buf, len_=
in_words);
      |                         ^~~~~~~~~~~~~
      |                         iowrite32_rep

Caused by commit

  7e7dc04774b1 ("mtd: rawnand: cadence: support 64-bit slave dma interface")

I have used the nand tree from next-20220920 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/mV0zhHIdp9yzgxsaWmhIeqM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMqaakACgkQAVBC80lX
0Gy5XQf+MWO/M/4peK1DDUGLlp+njV45csSTsJERTPs/A2+ebjyrScPAx8RM3xR2
orZThO0eVmxjAZqA3tbBgeRLRHFYfsj2WJyQciOwqh1nywcH7jMF8Ju7T1lF1GK4
oWObhumowgydijvrRFuIuEkFvQ18RmbYtvgQ4k6D+cd+2UlBGMNm+7wDYM3KQTeL
eEOgNtM+Jz/1x7GB/Et6EOMnRpQXWqJewVFGk2gfsxPqrwvnzTJlokcq0tlRR3Y7
FCjNl1XwIs97E05Vww3g5UOIzc1zfhFk2I9oT8U3ZDW7bHaDxOKSMVk7+WpUcwV1
EwKpZJF6JGIEI13dlNPt/SW524qRJw==
=8yO8
-----END PGP SIGNATURE-----

--Sig_/mV0zhHIdp9yzgxsaWmhIeqM--
