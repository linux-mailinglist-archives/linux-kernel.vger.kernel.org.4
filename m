Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783015F401B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJDJoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiJDJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:43:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA8D2B1B8;
        Tue,  4 Oct 2022 02:40:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhXkL3GnHz4xGc;
        Tue,  4 Oct 2022 20:40:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664876426;
        bh=w2kuGEV/YvrEJc0RZCY9v7PrU9QfbsLR7Qi5e2WiR/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=A6jM/eD8feZxmz8dTja1IAnS8+YeXxOYbDxY4GqVmUmKd5K/IMf2qh9rTcg5SgdC3
         wMJaWGd88n+BCibECrr0Eb8hnpa7lHshEKvX13iZ16sYtYUIT/QA3WloO3U/DcFJ4/
         ifRCdudR1Oe+xNKpsyrLqjo4ab7QqlHecsRYM/HTP/JLN7ZX5KPWVzZDnEuIaIYrLy
         jBM5i6v9Ck2YWQO8DY8N45fM1VeOxyOcwCCkz6Ax2V6bgf4kB2pyP+iSteoVeCtte2
         aRNvtTZoFEv1XkhoECcDHbV3t02OJDN6q/nOVSntOBtKRWdkQNZABZCGSw1a6V7WZf
         tH9TVk1QTExcQ==
Date:   Tue, 4 Oct 2022 20:40:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm-stable tree with the kspp tree
Message-ID: <20221004204025.7be8a3be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6KqjqoIEX21PNN6ZDGZOfuo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6KqjqoIEX21PNN6ZDGZOfuo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  include/linux/fortify-string.h

between commit:

  9f7d69c5cd23 ("fortify: Convert to struct vs member helpers")

from the kspp tree and commit:

  ff901d80fff6 ("x86: kmsan: use __msan_ string functions where possible.")

from the mm-stable tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/fortify-string.h
index b62c90cfafaf,6c8a1a29d0b6..000000000000
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@@ -325,11 -282,13 +325,13 @@@ __FORTIFY_INLINE void fortify_memset_ch
  })
 =20
  /*
 - * __builtin_object_size() must be captured here to avoid evaluating argu=
ment
 - * side-effects further into the macro layers.
 + * __struct_size() vs __member_size() must be captured here to avoid
 + * evaluating argument side-effects further into the macro layers.
   */
+ #ifndef CONFIG_KMSAN
  #define memset(p, c, s) __fortify_memset_chk(p, c, s,			\
 -		__builtin_object_size(p, 0), __builtin_object_size(p, 1))
 +		__struct_size(p), __member_size(p))
+ #endif
 =20
  /*
   * To make sure the compiler can enforce protection against buffer overfl=
ows,

--Sig_/6KqjqoIEX21PNN6ZDGZOfuo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7/4kACgkQAVBC80lX
0Gx2xwf+O+5/lPFttzn6ykSEIZ33GeDcFcXJlOxXEHqrdmAiMLoR7JTG7zdoHMRK
FWR6Pogs5X5ZvP+BrPzcI9hOqQGPg1vOZRoKWPEzNDDLtoHzNGPNJAXP6+hQv+vd
+GCscgesVaYPRyEWIsDx/+Waloxpem+4FDkk6/DO2Oi6y+Tx0exkgD8IoFweutxJ
Gc6BkWxNcZkHIlxAfoGCDQKhtNi8nul3mCWvcSihpRCEURED2FIWM8N2sglIBN2m
mZhI785BoJliFpSMwKOgEvxkw6VFj/jDgEvVNlGGB8AUSKnUSghSVbNfYiTyFynC
dk1tesum4NHV+WPvaGLYVhfFFSqYBw==
=0ELm
-----END PGP SIGNATURE-----

--Sig_/6KqjqoIEX21PNN6ZDGZOfuo--
