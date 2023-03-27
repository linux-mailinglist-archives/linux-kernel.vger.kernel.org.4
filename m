Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2166C9939
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 03:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjC0BAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 21:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjC0BAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 21:00:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D835744A7;
        Sun, 26 Mar 2023 18:00:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PlDxw0L7fz4x7v;
        Mon, 27 Mar 2023 12:00:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679878820;
        bh=4ZdFjsJE52VY1dPlf7jl1aXuq9mZ4eYO/H9bwuRAlQs=;
        h=Date:From:To:Cc:Subject:From;
        b=o8jyV+ngkdeYo32TjoY4ch1vqe7hTCMUv/su3fvIqRL3CR7dSXszlqmCtx21EgXoo
         pYTpxQL08g+N/Td6VZYbSQMgNIefQijwvGL5mH/cRW9AG51qFNjS/kUzRxh/sOZh4M
         6LA9+ztj2v9EO6dS3uWPKJ2RYA2iXxzT9neNuSt62Gp4UQUpIYrcSVjIgKVo7IPISZ
         VkOKhpE0dkeeppq42Vpkd0IgxoJrcetqs3ae6w04FuHAscR1Q4TaF0VfVgNO52tC2+
         IzzKAlszOteDUFbIxBADaMeVeJh0O/Z/cugoYhq0WMeIa6IgQ3R58Ipu1wPJCvV1f+
         FueTnqB0n/cAA==
Date:   Mon, 27 Mar 2023 12:00:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the block tree
Message-ID: <20230327120017.6bb826d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_V_FGOTC7zekxDUGiOwcOOr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_V_FGOTC7zekxDUGiOwcOOr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allnoconfig) produced these warnings:

lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x0: redundant UACC=
ESS d
isable
lib/iov_iter.o: warning: objtool: iovec_from_user.part.0+0xc7: call to copy=
_comp
at_iovec_from_user.part.0() with UACCESS enabled
lib/iov_iter.o: warning: objtool: __import_iovec+0x21d: call to copy_compat=
_iovec_from_user.part.0() with UACCESS enabled

Presumably introduced by commit

  6376ce56feb6 ("iov_iter: import single vector iovecs as ITER_UBUF")

--=20
Cheers,
Stephen Rothwell

--Sig_/_V_FGOTC7zekxDUGiOwcOOr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQg6qEACgkQAVBC80lX
0GyP5Af+JSpy8vuEuKq9A9qBH9mGV7dGMa1JqlKPP6dMDJ6gDBGKWBNFRGC+OxTr
h4W1soJF1gG7FxYiHme5vZlHboxQNJsST34pzjrCWa+FdyKrgQSdURkUk+M8qeYn
yXQp5DV40oMSRzxw60tXM9mJPheJTYo29EbfVwvlpVrNSe+eH0tk8Yyb0Q40FRW0
wO/OVKLqHNnHmi2PizoBDkRh1HH9cHFnuH/kbwHdkq8G19CdnutHiJeUzygOWn7S
uE3E183CC1lj+O9ffuNThBhpsaOCruFDW1dt6CXmE7wo8vXMCjKGGEG/DNkveybc
M7QzeE8JTTY4CRfJl52PLJOiSFSZmg==
=KovJ
-----END PGP SIGNATURE-----

--Sig_/_V_FGOTC7zekxDUGiOwcOOr--
