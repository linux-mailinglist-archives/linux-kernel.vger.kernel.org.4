Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2F061302D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 07:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJaGKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 02:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJaGKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:10:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6568F2DD2;
        Sun, 30 Oct 2022 23:10:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N12n226cFz4xFy;
        Mon, 31 Oct 2022 17:09:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667196598;
        bh=Iy+NcbbtfKfcj1OaC8AZXGNI5Dy79wNJ35iaLbsKO/U=;
        h=Date:From:To:Cc:Subject:From;
        b=d8++4rApKs+Wb4AFKLVynWb8XMVr0RRfV7W9C+aiUgMblQXzlEpEc/puYL5+1It+a
         GZbd9MuKOdd8bVBr7n9IadD+fc+QeOnEHDrIKC01GkWTp+Jloo4vSLkzVRYtEUZAk5
         GEAGyLTPVBlfCNM7i4rZZEhiJoKDJ9nd+5Iy0EFifDTJwjPMUxlTLO1rUDABM6icka
         nVCtN+FFd2+xvoQc9i34TG62T8BvgJtrpGwtC6un7+UHIumLtMsrsO5+haj2215cM8
         f/M5uwsIYCQa6C6Ng7uyPP5XTV2eFi83rXKdnsNvo8GFCHNMY9l9hgfk/IV9j+7d9I
         201IcWK1+wvTA==
Date:   Mon, 31 Oct 2022 17:09:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the random tree
Message-ID: <20221031170956.2cdf101a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NcMbPBvSTx/AAHr4G9._57S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NcMbPBvSTx/AAHr4G9._57S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the random tree, today's linux-next build (arm64 defconfig)
failed like this:

arch/arm64/kernel/pi/kaslr_early.c: In function 'kaslr_early_init':
arch/arm64/kernel/pi/kaslr_early.c:97:22: error: implicit declaration of fu=
nction '__early_cpu_has_rndr' [-Werror=3Dimplicit-function-declaration]
   97 |                 if (!__early_cpu_has_rndr() ||
      |                      ^~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Caused by commit

  70ae866ab6b3 ("random: remove early archrandom abstraction")

I have used the ramdom tree from next-20221028 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/NcMbPBvSTx/AAHr4G9._57S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNfZrQACgkQAVBC80lX
0GwzMgf+K63b3yP6dlffkiZ7whDFrbiD18CQ0xsXAk2SmmlujYoUgLV8Ca9XZ91Z
31f9qhPx8KInfNP9LbWvqjQZ0FRnHEdxW5Mov6oooa7z0sSQJw/kGWBLO6Iou4do
YiImRXOy+DWGePjU2+PQDLxrPxjU2nrb8lPe2f8rDTUs/Nv4YuQDBtmmAAOvvmv0
X5lcC0MZEcHAvBV5WM51Tk8TBdp/rtStK5MibpQcVYXjuzxH3XVenwD0tUBiHB0f
CxYc55rfSxqAgWsb3rU+zqe2b6s91ra1ZxOWleKKHFw6PGdYGeE67hN9+1eeTlXa
4ZotHs8moQBxy+DEi1Hw7b5uCdnfog==
=HuP6
-----END PGP SIGNATURE-----

--Sig_/NcMbPBvSTx/AAHr4G9._57S--
