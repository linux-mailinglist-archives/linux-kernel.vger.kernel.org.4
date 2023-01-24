Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5F567A50C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjAXVgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjAXVgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:36:53 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C3474E1;
        Tue, 24 Jan 2023 13:36:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1gKF6vcRz4xGM;
        Wed, 25 Jan 2023 08:36:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674596210;
        bh=xnufTPKHa3vmJf7wDtYjWqadIpILZ6VitBo63kitCEM=;
        h=Date:From:To:Cc:Subject:From;
        b=QTjiyUijMYU+fSNRgOo3KJaGWNVvN5ZwdxRHyeyBKz5FnJb6QPBQGmkbtwVfgvzEy
         2G153f7OArknJNWgxlOV3zYr4LCU9SKVkBnG3fWKhrUfPeh+6vJvtpc9Bv6a9HVB6j
         MWyor9XNLWSVLP7xWdSVXglj8sIl/KP9DXZsrILP9s0tMSaezAQ/Nx4MP2xDsh+0Q8
         /V6zTsvMvGa2PfxZTTazHIH9wXtJ8G4gUsR36INy0boy+zMfjq4Bqcw6Ehit8WSzjq
         b7PHZWfEdoeGkdtqtgbSdIBszvyJIfB0df0IcQxznfMWTPDHuWphRtC/C+Nb6+jRKl
         orvwZTqEXWIdA==
Date:   Wed, 25 Jan 2023 08:36:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: linux-next: manual merge of the arm64 tree with Linus' tree
Message-ID: <20230125083647.34067ee1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7CXzZw5p_+EOu8ulKOWiDp0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7CXzZw5p_+EOu8ulKOWiDp0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm64 tree got a conflict in:

  arch/arm64/Kconfig

between commit:

  68a63a412d18 ("arm64: Fix build with CC=3Dclang, CONFIG_FTRACE=3Dy and CO=
NFIG_STACK_TRACER=3Dy")

from Linus' tree and commit:

  baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")

from the arm64 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/Kconfig
index c5ccca26a408,de052d935832..000000000000
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -184,6 -186,10 +186,8 @@@ config ARM6
  	select HAVE_DEBUG_KMEMLEAK
  	select HAVE_DMA_CONTIGUOUS
  	select HAVE_DYNAMIC_FTRACE
 -	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
 -		if $(cc-option,-fpatchable-function-entry=3D2)
+ 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
+ 		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG)
  	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
  		if DYNAMIC_FTRACE_WITH_ARGS
  	select HAVE_EFFICIENT_UNALIGNED_ACCESS

--Sig_/7CXzZw5p_+EOu8ulKOWiDp0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPQT28ACgkQAVBC80lX
0GxUhQgAiktfLFT2LlRTQRNafAY6itxNTpf1wQ9qVMycl7/8QqPjloAQ9axLKjQG
4kmYxFZox5USJ1ehnPoEEsupuFMIGW2pYu22LEQYTWW3DNr+fvVQVT5lREV0v/ad
/BazD8o6zJr7wrjACZqq/eR/rO3Wom4IeSzf86EeWuWDEquhZMShvkO+YyMQtLTC
fefwkOe9z/kFoMaCgS8A3ngcxSsETNCJpG2JtBZdmY4R4v0+LSjSwosVMECkFCcx
J9unyPCs8ebUAhdwsjM1TthMbIql1283uXs7CibygtFAh8SQbhePhws84nBec7Fo
9CBM4sSrRhg61gn4rvrPP8087Krdyw==
=J+L/
-----END PGP SIGNATURE-----

--Sig_/7CXzZw5p_+EOu8ulKOWiDp0--
