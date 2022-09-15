Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D985BA291
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIOWFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIOWFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:05:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3017C46D94;
        Thu, 15 Sep 2022 15:05:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MTB8S2PyKz4x1T;
        Fri, 16 Sep 2022 08:05:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663279513;
        bh=g2lRrfc+ipUqMgCDu/ebew79wbtTs6dEfUbKvYiwa4U=;
        h=Date:From:To:Cc:Subject:From;
        b=UYTUYi5dImAQ9n0mN2uS2OnJcEBQvc3VNlQb57/th+7tqsrt5djV26rzA9yC23GqT
         MJStj/p08JGk6SGWBZb/YyRLkZerdWuxLjq1E6f0uh1UQoFwDle3SDR++d6DCGt6dm
         9uJLl75Hb2t6DhLp7XUOSj1RuqPOI7aSTd9RnBis8oWaFzI+4Z1eftypODgytHV6OQ
         +orVTf/lI1hUz03I0WHj5P+HG5XmKHH9oYXKl3ZIM6bXnJhy4oUPT0uwGaUxTF+0Ib
         SlYAL9MTBkqNBaZe13JpkwmnIachv7ktk7ZQs/QPXCPzJSWkSYHJcZetQufTe2HXnc
         HyiJUBOH0PA4Q==
Date:   Fri, 16 Sep 2022 08:05:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Steven Price <steven.price@arm.com>,
        Vladimir Isaev <vladimir.isaev@syntacore.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: linux-next: manual merge of the risc-v-fixes tree with Linus' tree
Message-ID: <20220916080510.359a8e3a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+a=Ie7xUWXT/D=PInVtkAU7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+a=Ie7xUWXT/D=PInVtkAU7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v-fixes tree got a conflict in:

  arch/riscv/mm/pageattr.c

between commit:

  8782fb61cc84 ("mm: pagewalk: Fix race between unmap and page walker")

from Linus' tree and commit:

  92c5738923f9 ("riscv: Fix permissions for all mm's during mm init")

from the risc-v-fixes tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/mm/pageattr.c
index 86c56616e5de,74b8107ac743..000000000000
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@@ -115,6 -115,55 +115,55 @@@ static int __set_memory_mm(struct mm_st
  		.clear_mask =3D clear_mask
  	};
 =20
 -	mmap_read_lock(mm);
++	mmap_write_lock(mm);
+ 	ret =3D walk_page_range_novma(mm, start, end, &pageattr_ops, NULL,
+ 				    &masks);
 -	mmap_read_unlock(mm);
++	mmap_write_unlock(mm);
+=20
+ 	return ret;
+ }
+=20
+ void fix_kernel_mem_early(char *startp, char *endp, pgprot_t set_mask,
+ 			  pgprot_t clear_mask)
+ {
+ 	struct task_struct *t, *s;
+=20
+ 	unsigned long start =3D (unsigned long)startp;
+ 	unsigned long end =3D PAGE_ALIGN((unsigned long)endp);
+=20
+ 	/*
+ 	 * In the SYSTEM_FREEING_INITMEM state we expect that all async code
+ 	 * is done and no new userspace task can be created.
+ 	 * So rcu_read_lock() should be enough here.
+ 	 */
+ 	WARN_ON(system_state !=3D SYSTEM_FREEING_INITMEM);
+=20
+ 	__set_memory_mm(current->active_mm, start, end, set_mask, clear_mask);
+ 	__set_memory_mm(&init_mm, start, end, set_mask, clear_mask);
+=20
+ 	rcu_read_lock();
+ 	for_each_process(t) {
+ 		if (t->flags & PF_KTHREAD)
+ 			continue;
+ 		for_each_thread(t, s) {
+ 			if (s->mm) {
+ 				__set_memory_mm(s->mm, start, end, set_mask,
+ 						clear_mask);
+ 			}
+ 		}
+ 	}
+ 	rcu_read_unlock();
+=20
+ 	flush_tlb_kernel_range(start, end);
+ }
+=20
+ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_ma=
sk,
+ 			pgprot_t clear_mask)
+ {
+ 	int ret;
+ 	unsigned long start =3D addr;
+ 	unsigned long end =3D start + PAGE_SIZE * numpages;
+=20
  	if (!numpages)
  		return 0;
 =20

--Sig_/+a=Ie7xUWXT/D=PInVtkAU7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMjoZYACgkQAVBC80lX
0GyaCgf/eXd6HYw9pjBMNRRUH/p67g02tyUtk1TEntWOq+85OVgSgXXvYRRLl2Da
KRwjda2t1+l95B69/EaX9iiBeCUCzoLai49j2z22HS5gN0GhQHnbQopfGTus2kh2
0oRhkWFn30M3RHGD1TrJiZn7WtrADu6MHDvaDE8amqnX+jqglJrTj5paY8pswJYD
W1ZePpVQT74SRdywtuqPEBjS7icZDaJo+iptYG81z+YrkHQPOchs8Bz8jWY3KN4m
zswL4S3jS6sXYpI3nojMQwPzgZcDgFq8IXn7e7fPG8YnUb0CR7tcLWO16Qwkvrvs
TN5j2fINRhFw2ePL8KCoqjWHW30srw==
=rOE8
-----END PGP SIGNATURE-----

--Sig_/+a=Ie7xUWXT/D=PInVtkAU7--
