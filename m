Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA32163FD13
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiLBAbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiLBAbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:31:16 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C794AF31;
        Thu,  1 Dec 2022 16:26:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NNYfK0zhDz4xFy;
        Fri,  2 Dec 2022 11:26:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669940810;
        bh=ugbbf+g7FOT3/DhiyoQYo3Jh4xdDh8TDWCJ3xQUbmFo=;
        h=Date:From:To:Cc:Subject:From;
        b=eRy4KME6mkbN+Zs+XRb1ipt9GDtDBEDNBwTSYmirGi2bNEOwLevAQEz/ijxNiWWQm
         f7PGAV9SDO6ikoY10n71k3jDUaI1OgwbgyK7y5t/U4znV7rM9rFQToxPXD3Bm3bl5h
         rxFEfE8Z3nAoE4o+hKTfUyCamx0bRqgDQu6yWABrlRbGmqNGf307ofrEWtH2NhOjnN
         FCy5MveKPOXlD8NYQWOhLUooXRY+Y/XyPMPo07+hELwaTGVjEWPC8wnyapfgrEcjTV
         XAtnGgIBw+BHcsguLKXWk2l6rzjRSg4j0jKiL7R+sBdK/lGIht0cvXvf2yUAuWCJQS
         VIkGYIySynPnQ==
Date:   Fri, 2 Dec 2022 11:26:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Gray <bgray@linux.ibm.com>,
        "Christopher M. Riedl" <cmr@bluescreens.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20221202112646.5813c34b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y+3=Ny4zt/XJbrXO8h=gy+i";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y+3=Ny4zt/XJbrXO8h=gy+i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/lib/code-patching.c: In function 'text_area_cpu_up_mm':
arch/powerpc/lib/code-patching.c:157:14: error: implicit declaration of fun=
ction 'copy_init_mm' [-Werror=3Dimplicit-function-declaration]
  157 |         mm =3D copy_init_mm();
      |              ^~~~~~~~~~~~

Caused by commit

  107b6828a7cd ("x86/mm: Use mm_alloc() in poking_init()")

interacting with commit

  55a02e6ea958 ("powerpc/code-patching: Use temporary mm for Radix MMU")

from the powerpc tree.

I partially reverted commit 107b6828a7cd - I left the change to
arch/x86/mm/init.c applied.  Though, I wonder if the powerpc tree should
use mm_alloc() instead of copy_init_mm() as well?  The tip tree commit
says:

    Instead of duplicating init_mm, allocate a fresh mm. The advantage is
    that mm_alloc() has much simpler dependencies. Additionally it makes
    more conceptual sense, init_mm has no (and must not have) user state
    to duplicate.

--=20
Cheers,
Stephen Rothwell

--Sig_/Y+3=Ny4zt/XJbrXO8h=gy+i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOJRkYACgkQAVBC80lX
0GyRJQf9FNRiyemVrBXmHbzEklHgNrDnYcojZAaBaQ3fDlII3K5YYgNmzzE2BnAj
mjcEPplhkgyL92H1zT+G62MVlKWzgPzythpJcExyGkd8hL7TXUm7HLHot2e2Up76
8kiaeKXeVhqaX8LGCO3LeTVENP6GaB3du7n7dLXFo6iE9XBTXhzVnIWK5vfmJGs4
25d1hiw24xIVLGz+KFMEHodG+qZ+0kbhsto42v11MZBWwl8RLJdm2I+GM7Fr4rdO
BJCsSYk5/4+/hlv3Jge6Z+oJ81hRVvcM51zcxZNoPiN0CV0NDF+ldDwcSY+62+v4
P5VuTIq3vz6nTqW8Ws7EfP1oud9D7A==
=+Mjg
-----END PGP SIGNATURE-----

--Sig_/Y+3=Ny4zt/XJbrXO8h=gy+i--
