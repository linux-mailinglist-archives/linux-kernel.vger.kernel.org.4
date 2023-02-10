Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA369172F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjBJDig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjBJDif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:38:35 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7704E5CBFF;
        Thu,  9 Feb 2023 19:38:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PCfbC1gt9z4xNH;
        Fri, 10 Feb 2023 14:38:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676000311;
        bh=+0AIMDf9647rvs8+Q7dwAwQ6K6344eJt+hok2qkYWRk=;
        h=Date:From:To:Cc:Subject:From;
        b=g+gp30X+1eVZAf3ALMnwy+5TwI9VVpx1/qHMMQLyIrven4LKyhkhUXfHsVIsVYlyX
         mBw8zXLRp67XgvYWApIg5/DcKyo1go5ZR7Mq80q4a6m3ZUcPA8pQppFJd8g3kKIz2x
         LgnOFzl6JCR0WMhB0uSJ9wH7c85LpIWKBEeqcV8S2U0fqotvW4f0k7SBT9mujXbDac
         8CZmo6qfYt9Vk9BoclSjwbccmegFYhySwnpZpRiVNtqGKfEafCp6+O67jd5/uSCmRF
         3L3ILk+bBrBV8nbs6MVXdOJwVHII1Fc7V0vOCDXyH3joXeCaKpM6Sf6ZUYfpVdnuJW
         3cNyigMoNQ+TQ==
Date:   Fri, 10 Feb 2023 14:38:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the powerpc tree
Message-ID: <20230210143829.4ab676bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3jYrWzezKBrYae+EmJWEE1Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3jYrWzezKBrYae+EmJWEE1Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc tree, today's linux-next build (powerpc64
allnoconfig) failed like this:

arch/powerpc/kernel/setup_64.c: In function 'early_setup':
arch/powerpc/kernel/setup_64.c:400:34: error: 'struct thread_info' has no m=
ember named 'cpu'
  400 |         task_thread_info(current)->cpu =3D boot_cpuid; // fix task_=
cpu(current)
      |                                  ^~

Caused by commit

  0ecf51ca51e5 ("powerpc/64: Fix task_cpu in early boot when booting non-ze=
ro cpuid")

# CONFIG_SMP is not set

I applied the following fix up for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 10 Feb 2023 14:21:33 +1100
Subject: [PATCH] fixup for "powerpc/64: Fix task_cpu in early boot when boo=
ting non-zero cpuid"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/setup_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 78d8a105764b..b2e0d3ce4261 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -397,7 +397,9 @@ void __init early_setup(unsigned long dt_ptr)
 	setup_paca(paca_ptrs[boot_cpuid]); /* install the paca into registers */
 	// smp_processor_id() now reports boot_cpuid
=20
+#ifdef CONFIG_SMP
 	task_thread_info(current)->cpu =3D boot_cpuid; // fix task_cpu(current)
+#endif
=20
 	/*
 	 * Configure exception handlers. This include setting up trampolines
--=20
2.39.1

--=20
Cheers,
Stephen Rothwell

--Sig_/3jYrWzezKBrYae+EmJWEE1Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPlvDUACgkQAVBC80lX
0Gx5dQf9H1dUoqhzZt/F/WloAtElvaCyEa2JzUllu9ogsjUNxxIpJz6Org/LHfjK
RhDsoNYPHIt5umUxmmZ0ZcfFI+ZK6QrvPoGeZsDGWY0Y1zj3BVqfxpKri90Waxae
AHJDPHJBJcyyNcymykYRJ7/eoqit1d4yFTYyERifTwuY6pKPxdH2Dm5YUsw4LRhN
6kJqbNZb/QzfkGgsO2rsvWhGmhdS7nDIkLfIUpx9lMqwj3On7M8iOzYLI6Ey5acy
avQ0YoK2YZyhzejsqRzRo3NjuRn1+ocl5+1O67fJPEeFwuXb81KdL2fliPiaEIaX
aUC1RTm4t06F8+RuIKH8OeyJQtDdZA==
=idtf
-----END PGP SIGNATURE-----

--Sig_/3jYrWzezKBrYae+EmJWEE1Q--
