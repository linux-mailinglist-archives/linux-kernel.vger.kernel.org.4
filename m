Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20262704253
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245668AbjEPAeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjEPAeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:34:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9E883E2;
        Mon, 15 May 2023 17:34:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKy0l0Rgnz4x1f;
        Tue, 16 May 2023 10:34:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684197256;
        bh=jJKZfJCxepyKL6BZvZjgIYbio3EXugpuplEPBrwz7/Y=;
        h=Date:From:To:Cc:Subject:From;
        b=WWO0CnVk0k6VJayG5o4Sv3TbIU/5ZXEQQzJSavQX2T7EmQlR3lcDOy0ymGMIp918O
         wc1oK56AvvO4UHxn5e4SrQaT1tDy7Lo2DmhLigXzt5tPfMWgBsAi2WLcl8i6OPz9gX
         74iFmCpmQVi0wWI5nI/+vjTEbV9iFErdh030Uj5Y1BmwelK45jz5KYS3KAsDOpBnVw
         HTyJMWaM/iE7lDhdbd6rVRlQdqET9ZMPzhAz1o9hlCSI/dNslZL6OiHsYSZvtqd6/R
         8z2Ar/7T0eyjHMFLModSI7+st1BjQFtnC0kNP5n67eORsEtPoio219A8nL2eQothrT
         HtVaPJDgTVhPQ==
Date:   Tue, 16 May 2023 10:34:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: linux-next: manual merge of the tip tree with the perf tree
Message-ID: <20230516103413.21e34bb6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9XmPjZAkgv_9cK5=I92F2ve";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9XmPjZAkgv_9cK5=I92F2ve
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got conflicts in:

  tools/perf/arch/x86/include/arch-tests.h
  tools/perf/arch/x86/tests/arch-tests.c

between commit:

  ae4aa00a1a93 ("perf test: Move x86 hybrid tests to arch/x86")

from the perf tree and commit:

  78075d947534 ("perf test: Add selftest to test IBS invocation via core pm=
u events")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/perf/arch/x86/include/arch-tests.h
index 33d39c1d3e64,93d3b8877baa..000000000000
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@@ -11,7 -11,7 +11,8 @@@ int test__intel_pt_pkt_decoder(struct t
  int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
  int test__bp_modify(struct test_suite *test, int subtest);
  int test__x86_sample_parsing(struct test_suite *test, int subtest);
 +int test__hybrid(struct test_suite *test, int subtest);
+ int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
 =20
  extern struct test_suite *arch_tests[];
 =20
diff --cc tools/perf/arch/x86/tests/arch-tests.c
index 147ad0638bbb,b5c85ab8d92e..000000000000
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@@ -22,15 -22,7 +22,16 @@@ struct test_suite suite__intel_pt =3D=20
  DEFINE_SUITE("x86 bp modify", bp_modify);
  #endif
  DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
 +static struct test_case hybrid_tests[] =3D {
 +	TEST_CASE_REASON("x86 hybrid event parsing", hybrid, "not hybrid"),
 +	{ .name =3D NULL, }
 +};
 +
 +struct test_suite suite__hybrid =3D {
 +	.desc =3D "x86 hybrid",
 +	.test_cases =3D hybrid_tests,
 +};
+ DEFINE_SUITE("AMD IBS via core pmu", amd_ibs_via_core_pmu);
 =20
  struct test_suite *arch_tests[] =3D {
  #ifdef HAVE_DWARF_UNWIND_SUPPORT
@@@ -44,6 -36,6 +45,7 @@@
  	&suite__bp_modify,
  #endif
  	&suite__x86_sample_parsing,
 +	&suite__hybrid,
+ 	&suite__amd_ibs_via_core_pmu,
  	NULL,
  };

--Sig_/9XmPjZAkgv_9cK5=I92F2ve
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRiz4UACgkQAVBC80lX
0Gx9uQf9HAgAsNAks3QIleoDP1VicNEYP+pSm+QqukYQm/DfRe55vkNrJ/x1I2Zm
l5NQuX+UsSzhekf4kdwujDBm4aNwPpU6zotWLdsyFkF9hMq4K5UeKKxF4/ku2nIp
iHS/q0qsC6IkqmTQIrM2zs1NPegDSul32omImwYi5BAIv+3et4t5NzxMgIsSXr88
7AZT79qw5Pg0tLgpyyC0h5HMyN0chMCrWqRo1Mp7bxv+QeJRyAz38CyJNd+Asjpv
Fe2nWp32fzmySckGjEPQzzzm1l58Gk0dG0WEaF+va4NTx6IUiKTedWfWgN4HZe0i
trQuj24XqSnFbuobyoZBNIp5CWpqsw==
=iGU2
-----END PGP SIGNATURE-----

--Sig_/9XmPjZAkgv_9cK5=I92F2ve--
