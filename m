Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D165F95D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjAFB7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjAFB7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:59:25 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3372A59F83;
        Thu,  5 Jan 2023 17:59:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Np62r3Y7Tz4xN4;
        Fri,  6 Jan 2023 12:59:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672970357;
        bh=fHg0J3grlxueGqOhYIRKBvLUU2L27+ymcNSDWIS66R4=;
        h=Date:From:To:Cc:Subject:From;
        b=NBG0mfALAVDSJEWokIbMn7+jlyRG/A86lizNupklmYCfq3udoN5gRd0FhfXp/1II8
         PlbfjHTCypTWoGQH5NYzCpxRvDumAzKcg/yu6zRkHg4WquwUSXaae6eMtuseGJvGR+
         GIVSV0/oq8yry1cFG70YDH/TZZ89tbSGHPlWxjkyGzmpBVDNg5/gQMZpucwjTbNnCm
         rc0FrV+DlaKCggAEXbICKm/P6L8In+CIdpybjKei1F9YcxB8SOakYlrR7zujHvsjq3
         EUbY++Z5ltn1m55rUG5Va4oXyQ5LJWRuqEfjiucHZfePxvN3KwfsghQ9pMxQKmRjsi
         B5S4I8JXqbpbQ==
Date:   Fri, 6 Jan 2023 12:59:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm tree with the cgroup tree
Message-ID: <20230106125915.60c8b547@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8Bz6eaKAcaVGWGnKR6K74s5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8Bz6eaKAcaVGWGnKR6K74s5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  Documentation/admin-guide/cgroup-v1/memory.rst

between commit:

  da3ad2e14f63 ("docs: cgroup-v1: add internal cross-references")

from the cgroup tree and commits:

  6cd7ad27c60f ("mm: memcontrol: deprecate charge moving")
  9bf9f4ba8bd5 ("mm-memcontrol-deprecate-charge-moving-fix")

from the mm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/admin-guide/cgroup-v1/memory.rst
index 27d89495ac88,258e45cc3b2d..000000000000
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@@ -725,10 -719,15 +727,17 @@@ If we want to change this to 1G, we ca
         It is recommended to set the soft limit always below the hard limi=
t,
         otherwise the hard limit will take precedence.
 =20
 +.. _cgroup-v1-memory-move-charges:
 +
- 8. Move charges at task migration
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ 8. Move charges at task migration (DEPRECATED!)
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=20
+ THIS IS DEPRECATED!
+=20
+ It's expensive and unreliable! It's better practice to launch workload
+ tasks directly from inside their target cgroup. Use dedicated workload
+ cgroups to allow fine-grained policy adjustments without having to
+ move physical pages between control domains.
 =20
  Users can move charges associated with a task along with task migration, =
that
  is, uncharge task's pages from the old cgroup and charge them to the new =
cgroup.

--Sig_/8Bz6eaKAcaVGWGnKR6K74s5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO3gHMACgkQAVBC80lX
0GyDkwf/SNfywJqZAw48DyGQE3faNgQVQBvKwOZIYQunabEqwlcQpz9VOEwEDHc7
0vuDILB2h1nA1B9Jn4I+82IBP6lw4uyQP/3EdwXvdhswIdhLocZb37B+83Oy5Hu/
U/RaNmR/kDUpNpPCWdNzlvy9/OW4WvObja2G0AxcV+T4zWJhnvjA5clT3CGXYwYA
L4lj8EftbNsFTpZyeVa7ncYG1jerpbcm2QsaulqBhVfD8Pj3azhRC0P7tNgSUfhP
u/ahT2fJiVIBL9VJHuRjHsgttYwrBZrJHNXzMkNOvqZGvD6P4NSJuT67LMNCp/LH
2EF0fr0iW0AJ3XhACXJLY6V15p6aUg==
=jGvc
-----END PGP SIGNATURE-----

--Sig_/8Bz6eaKAcaVGWGnKR6K74s5--
