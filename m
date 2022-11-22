Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4B6334BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiKVFgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiKVFgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:36:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C21EAF8;
        Mon, 21 Nov 2022 21:36:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NGY0M5s4kz4xDK;
        Tue, 22 Nov 2022 16:36:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669095396;
        bh=JqQ9CgyRJHSxjtcAH1X9laMKfyernqwh5/i4gYmo5+k=;
        h=Date:From:To:Cc:Subject:From;
        b=DldQNrumFhT1ad1iIOGAPYpEqy74Fv7puyPSLfsFX61Ph38HJMTKKkkby31BoseVJ
         6GTi+oLIWWS2GO2ngLy8liwuoR5qTO9XtKI5GsBnotQNJVU43obtG8ect0PW95Ub1G
         1mDij+DKidUIFt3zM1b5/UekivWqH7ik6cV302P8LtYrtfBoCp/8lLtO4mG8qvcBb5
         FMriPPsgZZ0Ms5M4+ARDNU1S/DIOPQ56REFI8KXVQ7NW5PxiOhQfVAqzv1coqLlKoM
         Ih2bxQsb3TYYS1WbDaoFVCJPJV30LmhbqGQFvGMJIgG/LILGDqFqWnHKaPGnwyrzDB
         2UEZabE3DuFug==
Date:   Tue, 22 Nov 2022 16:36:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vlastimil Babka <vbabka@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the slab tree with the percpu tree
Message-ID: <20221122163634.3b21cf71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HVnLKvjaj//AiJW5sgL/=Qu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HVnLKvjaj//AiJW5sgL/=Qu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  include/linux/percpu.h

between commit:

  d667c94962c1 ("mm/percpu: remove unused PERCPU_DYNAMIC_EARLY_SLOTS")

from the percpu tree and commit:

  e8753e416c7e ("percpu: adjust the value of PERCPU_DYNAMIC_EARLY_SIZE")

from the slab tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/percpu.h
index 70bc17db00a6,3dbb6fb70658..000000000000
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@@ -37,11 -37,12 +37,11 @@@
  /*
   * Percpu allocator can serve percpu allocations before slab is
   * initialized which allows slab to depend on the percpu allocator.
 - * The following two parameters decide how much resource to
 - * preallocate for this.  Keep PERCPU_DYNAMIC_RESERVE equal to or
 - * larger than PERCPU_DYNAMIC_EARLY_SIZE.
 + * The following parameter decide how much resource to preallocate
 + * for this.  Keep PERCPU_DYNAMIC_RESERVE equal to or larger than
 + * PERCPU_DYNAMIC_EARLY_SIZE.
   */
- #define PERCPU_DYNAMIC_EARLY_SIZE	(12 << 10)
 -#define PERCPU_DYNAMIC_EARLY_SLOTS	128
+ #define PERCPU_DYNAMIC_EARLY_SIZE	(20 << 10)
 =20
  /*
   * PERCPU_DYNAMIC_RESERVE indicates the amount of free area to piggy

--Sig_/HVnLKvjaj//AiJW5sgL/=Qu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN8X+IACgkQAVBC80lX
0Gwuwwf+MmKkAHNweQCJ2GFlttdLjewBfslEVZTp5F0/KKUzVOBqdxED5AzoGPId
0uG5QSx7RQaIC4PyFXALJ3Jq0wH916utiP37LOO1wJuWpkAxCI1uQvqs/tOgELTK
EwvCbsbvxYRqBGEVcQSTPIdPPCC5RirKD6oxJlY5lP3o2+69lZTkQ3+dQ4/rgQRj
XKgq/3SA94TZkgdMJc16ZYY0brs8f+y6RT9ZlmP/v82olpJlWTnEBNDs428BPHb6
XyLi85UUEzCAXLnEnfm1otCEPJbDOWVo4mG02zEU00SiSu9l/6N6IdiCu9XfHyyI
qNEsBB0JvdGn6LzbLSrlGbYGib2Mtw==
=36Mo
-----END PGP SIGNATURE-----

--Sig_/HVnLKvjaj//AiJW5sgL/=Qu--
