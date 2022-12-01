Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92F463E691
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLAAgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiLAAgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:36:32 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CC355CA7;
        Wed, 30 Nov 2022 16:36:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMxvw1kDFz4xG6;
        Thu,  1 Dec 2022 11:36:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669854988;
        bh=SLjICF9IfdBG1Y4U6HqYzaBkaeg32WihSlG0tu9lwe4=;
        h=Date:From:To:Cc:Subject:From;
        b=hpF9rJ7X0gr3lxGP3cUh2Vh5y5JD688h6U2T5xCCwn1+6ZX3bQ/LQGIugXcKodzJ0
         FWWi/ndH0uz2CL0Igrx0iszjKt598Su+00vyQdnJQjG1aI+rTSFQbtkpJAnbSo5iMJ
         EE44rtA4ihszoouQRf5E4d2GIBwtrXz7cRwYygOIpxVJkZCNez6Z3vu9Tn59s99hDn
         xd4c2X4ytkjGUXi2g5V+l3CW/Kfx72TRTwwgW65Lkzt5DpYV6eJdvU77/YaeaQIP+T
         zCvcyJzhnC2wUEA2VD+TfGXt9YEG6fRk6HS2dZxqTi6NzFxuHE17VHZgybIYVx8gcZ
         +R274Su4NuhaQ==
Date:   Thu, 1 Dec 2022 11:36:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Sean Christopherson <seanjc@google.com>
Subject: linux-next: manual merge of the kvm-arm tree with the kvm tree
Message-ID: <20221201113626.438f13c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uHOnl3PB=7.zkPqMFFXrMJn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uHOnl3PB=7.zkPqMFFXrMJn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got conflicts in:

  tools/testing/selftests/kvm/Makefile
  tools/testing/selftests/kvm/demand_paging_test.c

between commit:

  7812d80c0f89 ("KVM: selftests: Rename perf_test_util symbols to memstress=
")
  7046638192d5 ("KVM: selftests: Consolidate common code for populating uca=
ll struct")

from the kvm tree and commit:

  a93871d0ea9f ("KVM: selftests: Add a userfaultfd library")

from the kvm-arm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/kvm/Makefile
index 2275ba861e0e,1d85b8e218a0..000000000000
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@@ -47,7 -47,7 +47,8 @@@ LIBKVM +=3D lib/memstress.
  LIBKVM +=3D lib/rbtree.c
  LIBKVM +=3D lib/sparsebit.c
  LIBKVM +=3D lib/test_util.c
 +LIBKVM +=3D lib/ucall_common.c
+ LIBKVM +=3D lib/userfaultfd_util.c
 =20
  LIBKVM_STRING +=3D lib/string_override.c
 =20
diff --cc tools/testing/selftests/kvm/demand_paging_test.c
index 3a977ddf07b2,8e1fe4ffcccd..000000000000
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@@ -20,8 -20,9 +20,9 @@@
 =20
  #include "kvm_util.h"
  #include "test_util.h"
 -#include "perf_test_util.h"
 +#include "memstress.h"
  #include "guest_modes.h"
+ #include "userfaultfd_util.h"
 =20
  #ifdef __NR_userfaultfd
 =20
@@@ -270,22 -129,13 +129,13 @@@ static void prefault_mem(void *alias, u
  static void run_test(enum vm_guest_mode mode, void *arg)
  {
  	struct test_params *p =3D arg;
- 	pthread_t *uffd_handler_threads =3D NULL;
- 	struct uffd_handler_args *uffd_args =3D NULL;
+ 	struct uffd_desc **uffd_descs =3D NULL;
  	struct timespec start;
  	struct timespec ts_diff;
- 	int *pipefds =3D NULL;
  	struct kvm_vm *vm;
- 	int r, i;
+ 	int i;
 =20
 -	vm =3D perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size, 1,
 +	vm =3D memstress_create_vm(mode, nr_vcpus, guest_percpu_mem_size, 1,
  				 p->src_type, p->partition_vcpu_memory_access);
 =20
  	demand_paging_size =3D get_backing_src_pagesz(p->src_type);
@@@ -296,18 -146,11 +146,11 @@@
  	memset(guest_data_prototype, 0xAB, demand_paging_size);
 =20
  	if (p->uffd_mode) {
- 		uffd_handler_threads =3D
- 			malloc(nr_vcpus * sizeof(*uffd_handler_threads));
- 		TEST_ASSERT(uffd_handler_threads, "Memory allocation failed");
-=20
- 		uffd_args =3D malloc(nr_vcpus * sizeof(*uffd_args));
- 		TEST_ASSERT(uffd_args, "Memory allocation failed");
-=20
- 		pipefds =3D malloc(sizeof(int) * nr_vcpus * 2);
- 		TEST_ASSERT(pipefds, "Unable to allocate memory for pipefd");
+ 		uffd_descs =3D malloc(nr_vcpus * sizeof(struct uffd_desc *));
+ 		TEST_ASSERT(uffd_descs, "Memory allocation failed");
 =20
  		for (i =3D 0; i < nr_vcpus; i++) {
 -			struct perf_test_vcpu_args *vcpu_args;
 +			struct memstress_vcpu_args *vcpu_args;
  			void *vcpu_hva;
  			void *vcpu_alias;
 =20
@@@ -321,15 -167,10 +167,10 @@@
  			 * Set up user fault fd to handle demand paging
  			 * requests.
  			 */
- 			r =3D pipe2(&pipefds[i * 2],
- 				  O_CLOEXEC | O_NONBLOCK);
- 			TEST_ASSERT(!r, "Failed to set up pipefd");
-=20
- 			setup_demand_paging(vm, &uffd_handler_threads[i],
- 					    pipefds[i * 2], p->uffd_mode,
- 					    p->uffd_delay, &uffd_args[i],
- 					    vcpu_hva, vcpu_alias,
- 					    vcpu_args->pages * memstress_args.guest_page_size);
+ 			uffd_descs[i] =3D uffd_setup_demand_paging(
+ 				p->uffd_mode, p->uffd_delay, vcpu_hva,
 -				vcpu_args->pages * perf_test_args.guest_page_size,
++				vcpu_args->pages * memstress_args.guest_page_size,
+ 				&handle_uffd_page_request);
  		}
  	}
 =20
@@@ -358,17 -193,14 +193,14 @@@
  	pr_info("Total guest execution time: %ld.%.9lds\n",
  		ts_diff.tv_sec, ts_diff.tv_nsec);
  	pr_info("Overall demand paging rate: %f pgs/sec\n",
 -		perf_test_args.vcpu_args[0].pages * nr_vcpus /
 +		memstress_args.vcpu_args[0].pages * nr_vcpus /
  		((double)ts_diff.tv_sec + (double)ts_diff.tv_nsec / 100000000.0));
 =20
 -	perf_test_destroy_vm(vm);
 +	memstress_destroy_vm(vm);
 =20
  	free(guest_data_prototype);
- 	if (p->uffd_mode) {
- 		free(uffd_handler_threads);
- 		free(uffd_args);
- 		free(pipefds);
- 	}
+ 	if (p->uffd_mode)
+ 		free(uffd_descs);
  }
 =20
  static void help(char *name)

--Sig_/uHOnl3PB=7.zkPqMFFXrMJn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOH9woACgkQAVBC80lX
0GwWMgf/XhaffMVs4kbw9HVsjME89hH2KB/2NKBA0AB877YBYhzLSqb4UyD9ERdB
BGOQ50V16R1tr4OzFP38ToTISxMZhcLsoXi76dB5WMsMa9ao3l7Idz9LUkBD9mn+
GA1cfDjbnCwsO9fpzxs5dtdmB62qBPDgRouaNQhTdhmj60Ve9uXZlUI7bm6LMJCy
FbaajxoKYOiLCC1nWg3rZy/z0OiSRPtOLj45rQbRMLhv/kdm3Vl8u73fFcXixqWn
WypNMiu/VQepjM5iE5Vq9m7Ix6IP5JWmUV9Hd369B/CCOaWQxzU7dbKZT2+DY+aL
NFSUX1MoY7hpqegu/yEH9VMPUeqOaw==
=AVri
-----END PGP SIGNATURE-----

--Sig_/uHOnl3PB=7.zkPqMFFXrMJn--
