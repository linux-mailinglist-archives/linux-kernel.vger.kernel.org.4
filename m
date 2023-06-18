Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19C473494C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 01:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjFRXYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 19:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRXYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 19:24:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05234E44;
        Sun, 18 Jun 2023 16:24:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qkpqx670Zz4wjD;
        Mon, 19 Jun 2023 09:23:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687130638;
        bh=tQxCQkiyao5+LPgHpUlD4eq7txYSIRHBDxuOjzVkzQk=;
        h=Date:From:To:Cc:Subject:From;
        b=TG5jNgm/Ffajk77yNl7fLWVm/S0d+EjqnBL1kLETDf7tgnqbdmjH9d2MPNkS759Yq
         zTwmkMQqJdiLrS8SqMJq04A8e7Q3r6Ocw46cYTzlud3kG7cz6LvvfitGRHcU8Jn7bK
         oMSbUBWRUpTsDxw576QIAgtPJF+57wha2U5UwrHHlq30DEWev/ODwbE7Be1OaeItfB
         oRrtrzYQ7LaLmijvvMr1KcQWVpIzCLsBCiJECQRV2PvLKR9AxC+56NIITotGVC8ETl
         EX5TQ4n3WAYKXr5coEKZQ/0nkJ81cX70mY5YfxqEhN4AuoR1rLWlXOvkZMNHSnPtJB
         ycLV7dzhQPgbg==
Date:   Mon, 19 Jun 2023 09:23:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20230619092355.133c5cdb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yTh=MXtZNF6gXeSWW98ArYD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yTh=MXtZNF6gXeSWW98ArYD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  mm/mmap.c

between commit:

  606c812eb1d5 ("mm/mmap: Fix error path in do_vmi_align_munmap()")

from the origin tree and commits:

  66106c364147 ("mm: change do_vmi_align_munmap() side tree index")
  47b1d8de18f5 ("mm/mmap: change vma iteration order in do_vmi_align_munmap=
()")

from the mm tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/mmap.c
index 98cda6f72605,474a0d856622..000000000000
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@@ -2398,15 -2409,27 +2396,29 @@@ do_vmi_align_munmap(struct vma_iterato
  			if (error)
  				goto end_split_failed;
  		}
 -		mas_set(&mas_detach, count);
 -		error =3D munmap_sidetree(next, &mas_detach);
 -		if (error)
 -			goto munmap_sidetree_failed;
 +		vma_start_write(next);
- 		mas_set_range(&mas_detach, next->vm_start, next->vm_end - 1);
 +		if (mas_store_gfp(&mas_detach, next, GFP_KERNEL))
 +			goto munmap_gather_failed;
 +		vma_mark_detached(next, true);
 +		if (next->vm_flags & VM_LOCKED)
 +			locked_vm +=3D vma_pages(next);
 =20
  		count++;
+ 		if (unlikely(uf)) {
+ 			/*
+ 			 * If userfaultfd_unmap_prep returns an error the vmas
+ 			 * will remain split, but userland will get a
+ 			 * highly unexpected error anyway. This is no
+ 			 * different than the case where the first of the two
+ 			 * __split_vma fails, but we don't undo the first
+ 			 * split, despite we could. This is unlikely enough
+ 			 * failure that it's not worth optimizing it for.
+ 			 */
+ 			error =3D userfaultfd_unmap_prep(next, start, end, uf);
+=20
+ 			if (error)
+ 				goto userfaultfd_error;
+ 		}
  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
  		BUG_ON(next->vm_start < start);
  		BUG_ON(next->vm_start > end);
@@@ -2454,14 -2455,18 +2444,20 @@@
  		BUG_ON(count !=3D test_count);
  	}
  #endif
- 	/* Point of no return */
 +	error =3D -ENOMEM;
- 	vma_iter_set(vmi, start);
+ 	while (vma_iter_addr(vmi) > start)
+ 		vma_iter_prev_range(vmi);
+=20
  	if (vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL))
 -		return -ENOMEM;
 +		goto clear_tree_failed;
 =20
 +	mm->locked_vm -=3D locked_vm;
  	mm->map_count -=3D count;
+ 	prev =3D vma_iter_prev_range(vmi);
+ 	next =3D vma_next(vmi);
+ 	if (next)
+ 		vma_iter_prev_range(vmi);
+=20
  	/*
  	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
  	 * VM_GROWSUP VMA. Such VMAs can change their size under

--Sig_/yTh=MXtZNF6gXeSWW98ArYD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSPkgsACgkQAVBC80lX
0GwKMgf8DWWJQY5lhGXLK0fj2/FYYNKFLXi6GeGbvJtxTN4rONqn1D5KhsQpOSqL
cBLQTQm6ZlWiD0BisFHULst5yyPUpW4jpHXPNDfI0JGV9OtOxbAYnOciyrHAVD89
mIIB5Ah9vpSTziN9jLKXEEa37eGrVKz1p7ZjIdVdOUyfVhTI1IAubgk7FCHTctup
bqph/yZShXWgtmRFw1X8RNHvYWC8eagHvRbM/Z6YTvj5yzH9hPotU8Y1j9+hPoWO
V9q04UkAAeiXpMalIz3t13WijbYfgBt8o2om4YMz+OTZ8EbjrZw1PRK5vvBMWKJC
99LcDivfNyY2yVlwkMLpcekg5itM+A==
=PQB2
-----END PGP SIGNATURE-----

--Sig_/yTh=MXtZNF6gXeSWW98ArYD--
