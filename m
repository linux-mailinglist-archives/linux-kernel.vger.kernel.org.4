Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F62A736262
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjFTDzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjFTDzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:55:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1B019A;
        Mon, 19 Jun 2023 20:55:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QlXpy6HHFz4x09;
        Tue, 20 Jun 2023 13:55:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687233339;
        bh=H0D72pDX88zY6XJY90Z9rgzpbpZsOV6cMUGsZheQV0w=;
        h=Date:From:To:Cc:Subject:From;
        b=MZ/JQ0j6kXnn3OjM33VEcgppIkvCzddZZPBRtvdLbN9benaiKWBoqRs5PZl9KxFlF
         lhEX+bO11KbA6lVFvhvayvqehh7NLVVewc5Zolj/jB9I8IIyJHhVfYyd8++Xgw8S1u
         cnmGosMgEPOsZwsSburVIVqQxjS/SgPgYuqGw9tKmqq45JNwR9UY2KNXqm/8FbZT27
         O5PSTo0upNXXNc27huWimwInopsHidi9BcamIeWAVVHSYWzgZUt7hiyMXJVNlvHxCa
         L0EZmIn9am5S3g7mzzh61FBQDqi5NHRE/v8j63Hm2T2wwVtZ5GvD5ZYpPjYjRCtSfo
         o8dNC/TvL1bjQ==
Date:   Tue, 20 Jun 2023 13:55:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the landlock tree with the tip tree
Message-ID: <20230620135536.1f820a48@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rVzvofnNsXH6DkvE.1SuJkO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rVzvofnNsXH6DkvE.1SuJkO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the landlock tree got a conflict in:

  arch/um/Kconfig

between commit:

  9349b5cd0908 ("um/cpu: Switch to arch_cpu_finalize_init()")

from the tip tree and commit:

  74ce793bcbde ("hostfs: Fix ephemeral inodes")

from the landlock tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/um/Kconfig
index 887cfb636c26,4057d5267c6a..000000000000
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@@ -5,8 -5,6 +5,7 @@@ menu "UML-specific options
  config UML
  	bool
  	default y
- 	select ARCH_EPHEMERAL_INODES
 +	select ARCH_HAS_CPU_FINALIZE_INIT
  	select ARCH_HAS_FORTIFY_SOURCE
  	select ARCH_HAS_GCOV_PROFILE_ALL
  	select ARCH_HAS_KCOV

--Sig_/rVzvofnNsXH6DkvE.1SuJkO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSRIzgACgkQAVBC80lX
0GzSKAf/cYoafs/G3UmkOMMPzX/p88kJVqsttnjtYGoHCGuM2DTjNGjy3vsQ17dp
EVzsH/ZWmkuHXVoEdBmFGjCpkd1gwEycyJZYxuKZK+9sP/U1pPILstJZvzj8+A2+
f4DVOE2FUWh0ni7vE2MeD/Kv/wcmYMhzaRkhyiyOW+tnPEpul7k6Ma3TLaeYL9HS
e6JLhw+ZHUD0KGADxCzIX3bzfsUGnoFcm65NPapg4FrOKaP7H2dL92JslrEe8pkI
2AXPZPpLoxIBh5hSarO7If/EZY5/SGi+3tWGkM6S9LElntHqRJoskZLz0kBZ97t/
VYpHNK67qJomV/LzDSWK6VIw4vchnw==
=kuWi
-----END PGP SIGNATURE-----

--Sig_/rVzvofnNsXH6DkvE.1SuJkO--
