Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD786DCE90
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 02:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDKAsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 20:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDKAs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 20:48:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBF5198A;
        Mon, 10 Apr 2023 17:48:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwRzC6564z4x1f;
        Tue, 11 Apr 2023 10:48:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681174104;
        bh=ywg2fVzqk9khmOJf29hM51/WhhNAKNDCX0Efwx+HTMk=;
        h=Date:From:To:Cc:Subject:From;
        b=kovxmryRSJ7/GhzYKkjWKpt6WH9qmy189UJlUY1guQX93iCfPTsqWOrVtXWEIbtaP
         FXuT5fmw/ukeaKfxfRLj58zd3XmM4TCIRuHF0DE1yuaHExIZhVODfZQ6QJ3Vf5D5FG
         BSKHVrkJ5lIsdDlNcOi+9+LCIQXBjIObcxa7eET6F/Rbc2jgGmRLr+3p5Bdg/9o/IK
         DPLvi6hT2k46+rntTmxZTjqxVYKKjcgdoZl+s+m4ZV7KDUGLv1BZqnyE5BOoUWlOqZ
         I0f/d0DP7DJ+ToWmJirPI3Kuohehyp+NATM2/5dSEhQTK62e+fcUJSfLqGKafYdlvJ
         vIdjH0hxZl8Vw==
Date:   Tue, 11 Apr 2023 10:48:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20230411104821.153702ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j0Zfh5j.2pCJI6PNJfwJZhw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j0Zfh5j.2pCJI6PNJfwJZhw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from <command-line>:
In function 'setup_crypt_desc',
    inlined from 'get_crypt_desc' at drivers/crypto/intel/ixp4xx/ixp4xx_cry=
pto.c:285:3:
include/linux/compiler_types.h:397:45: error: call to '__compiletime_assert=
_1010' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct cr=
ypt_ctl) !=3D 64
  397 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/compiler_types.h:378:25: note: in definition of macro '__comp=
iletime_assert'
  378 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
include/linux/compiler_types.h:397:9: note: in expansion of macro '_compile=
time_assert'
  397 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c:266:9: note: in expansion of ma=
cro 'BUILD_BUG_ON'
  266 |         BUILD_BUG_ON(sizeof(struct crypt_ctl) !=3D 64);
      |         ^~~~~~~~~~~~

Caused by commit

  1bc7fdbf2677 ("crypto: ixp4xx - Move driver to drivers/crypto/intel/ixp4x=
x")

Presumably the addition of COMPILE_TEST was a bit optimistic. :-(

I have used the crypto tree from next-20230406 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/j0Zfh5j.2pCJI6PNJfwJZhw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ0rlUACgkQAVBC80lX
0GyZzwf/Ukc0Kb2SMMWt4nsLyoh5pB5IbmhFBgzjzD/wyhO/36LUrHDVnbNu0yKl
wmOWeQOwlKitg0vphr8I1qzXLCZywH8xVi6DMC6zkp81xEBMVkSNbDaodN/gMqoT
Iz/mEz8b9R+nW1irC3rpOUMv9UDlsumwsqrsYi1ews45c4IFvJZMZhgm8bxFhrrL
jEN8fUPJGMcQLgYg1r6R+gX9Pyqz/L1Da/eAld5hUPyzyd76jnidQcW7XdCRLRfz
/tFGTSqoeVQlzAOKsjbfmTYwhlKCistPHOlp97Zb+XiqHup9z5q1G/+MGMT2Sole
qBvR0EajXnxFzIPAUQ6FTKvyThe/Tg==
=3N5K
-----END PGP SIGNATURE-----

--Sig_/j0Zfh5j.2pCJI6PNJfwJZhw--
