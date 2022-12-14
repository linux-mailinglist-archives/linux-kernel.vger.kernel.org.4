Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D79C64C20B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 02:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiLNByO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 20:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLNByJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 20:54:09 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4721929B;
        Tue, 13 Dec 2022 17:54:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWz1Q0Y37z4xGR;
        Wed, 14 Dec 2022 12:54:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670982842;
        bh=252P/s/ixhig3mKeQC15/bbwsT78w5/CwttH+iKD2GI=;
        h=Date:From:To:Cc:Subject:From;
        b=D5Y+hetVAcMX5vzh+/cZVkhsDLlxAXIkjXcIdHqJ4ZQzgMQirFbCGzH7ZdVqS1x9C
         0N5SU/3z2X47zTHXLd49Olj+eF1M26u03/lNteBLGSz5Q88rgbss+IJfgMpwSYzusa
         xsouHzis3DyW+JAzyLLFd1xA8HD3rhx4bgFuQHPg4BI6XRBhydalaoXgd/W9IOk35g
         i7maFKTvfp0kHgk9RAKLawG9rn+COuzv0Crn4vue7Uo53JpMfQtek/+GYLAXzYDgio
         FBHQKSHjpWJKh4ToxwGCPV5Tj/S6+19UAgZm0ffUFseHDJzSdJid0n5DPTaatPPKlZ
         Ano5VNnte9t7w==
Date:   Wed, 14 Dec 2022 12:53:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the random tree
Message-ID: <20221214125359.147f33fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zycg8heAWHYFDfEL2MBzzlS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Zycg8heAWHYFDfEL2MBzzlS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the random tree, today's linux-next build (x86_64
allmodconfig) failed like this:

arch/x86/mm/cpu_entry_area.c: In function 'init_cea_offsets':
arch/x86/mm/cpu_entry_area.c:39:23: error: implicit declaration of function=
 'prandom_u32_max'; did you mean 'prandom_u32_state'? [-Werror=3Dimplicit-f=
unction-declaration]
   39 |                 cea =3D prandom_u32_max(max_cea);
      |                       ^~~~~~~~~~~~~~~
      |                       prandom_u32_state
net/ipv4/tcp_plb.c: In function 'tcp_plb_update_state_upon_rto':
net/ipv4/tcp_plb.c:100:18: error: implicit declaration of function 'prandom=
_u32_max'; did you mean 'prandom_u32_state'? [-Werror=3Dimplicit-function-d=
eclaration]
  100 |         pause +=3D prandom_u32_max(pause);
      |                  ^~~~~~~~~~~~~~~
      |                  prandom_u32_state

Caused by commit

  1effd020f82d ("prandom: remove prandom_u32_max()")

interacting with some new usages.  Why not leave this removal until
just after -rc1 has been released?

I have reverted this commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Zycg8heAWHYFDfEL2MBzzlS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOZLLgACgkQAVBC80lX
0GxnmAf+MkgLad/Z3ZvAGC0PnQQrSaAdtCk1zEsZ5FpiZfoMl0W6JQbMvGPsgH1I
rV7Z03LM5GnJo/+jkp2wAWGnjIjeZItouxHmu5UT/LG615Fp43jrvGCbNORrNhBq
6PuidWVMCe1rVj5ROmM887KzTq+CyWvAoBHkmWUcQ2r/JlmogfawHORArEqjd2EL
aoL4nyBtlO6nm8GZbRYSh1BtcBhx/OktcQJpbuRbLau8oWwidzMoXR3vOeYyq8pV
1fPfAocHr66Y7o5FeZsZKSdaHr7/8NmwqVgNcism0UEjFSAwmPqMqMAT7uiHBbkN
ieKVVAthXy+TCAzBQ5IgoVJGzTO6QA==
=XhvW
-----END PGP SIGNATURE-----

--Sig_/Zycg8heAWHYFDfEL2MBzzlS--
