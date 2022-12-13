Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5CC64AE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiLMDTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLMDTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:19:11 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E6318347;
        Mon, 12 Dec 2022 19:19:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWNy34Zn0z4xN0;
        Tue, 13 Dec 2022 14:19:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670901547;
        bh=7i+F/j8tgdCmSwl1APwZStjI1w64NYOTY/5r9oWqk8k=;
        h=Date:From:To:Cc:Subject:From;
        b=QdX9bLvS+pnDz3pa/UD8gl06Y3rsjN9t/oel1PeTDZTDq/+Vs8M6qWw1vcGdS22Fn
         F2IiAMiQWwVSqDnoz02L0H6EiQDzRJ2KEe2nZZqKqY67QQfkYymbiNxewB3gVYW9iW
         CZf+R6tcdkO3PCNGcG7vvojsuMN8qWvaK7/mMOc2bwYSIHURqjVKJvKkPZ5SaHihDf
         CYr1vyu2AUdMSgkPThbmNYtJ45KQT4jgdPNTkN69rhkSGk56xfsQVnMvCH5rXGiuVH
         vxvsw+CpD4FL9Tq3xPCL+MFNoPZ6rcd66IpmXiVSMnun9KxvyhjZ/h49UJuMAQbIe4
         FK8rux9RDUOUg==
Date:   Tue, 13 Dec 2022 14:19:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: linux-next: manual merge of the efi tree with Linus' tree
Message-ID: <20221213141906.566003ba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yaMa7a.s6GRSk9lYnu1w2mo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yaMa7a.s6GRSk9lYnu1w2mo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the efi tree got a conflict in:

  arch/arm64/kernel/stacktrace.c

between commit:

  0fbcd8abf337 ("arm64: Prohibit instrumentation on arch_stack_walk()")

from Linus' tree and commit:

  c2530a04a73e ("arm64: efi: Account for the EFI runtime stack in stack unw=
inder")

from the efi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/kernel/stacktrace.c
index 117e2c180f3c,ee9fd2018cd7..000000000000
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@@ -186,7 -188,14 +188,14 @@@ void show_stack(struct task_struct *tsk
  			: stackinfo_get_unknown();		\
  	})
 =20
+ #define STACKINFO_EFI						\
+ 	({							\
+ 		((task =3D=3D current) && current_in_efi())		\
+ 			? stackinfo_get_efi()			\
+ 			: stackinfo_get_unknown();		\
+ 	})
+=20
 -noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entr=
y,
 +noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entr=
y,
  			      void *cookie, struct task_struct *task,
  			      struct pt_regs *regs)
  {

--Sig_/yaMa7a.s6GRSk9lYnu1w2mo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOX7yoACgkQAVBC80lX
0Gw38Af9Ep2Gpy2DZ+TlHtM9ukFgmVeJS7QVrZ6YU2xtscRc8dEvxMedqvU5C975
4NtJwOGxKqV36Se6WGyWKhiscAmW0y9OZEUeUvh6KKica70qdT9vLxXK/xzSATkY
UJtMPc4A79Yk60nK6uw1+X8Fxc8HgyxN9ZSBU1tIUz1D1QILkiHjFLH/MrKXWolW
hs+9m6/HdERE6nofDZYg8kH199lxNJkR5B3hImbUzIjzoTeaHZrK6M7uMbwG1QKk
/627hSMCAVkkq7eKReHUFYd05NGde4GLwtYnl2eEr6fAx0f+xxifxAwYQRStey6/
wAlEf4ATsdORjz7fuO35T2V/1AxO3A==
=tmn0
-----END PGP SIGNATURE-----

--Sig_/yaMa7a.s6GRSk9lYnu1w2mo--
