Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FA467478F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjASXyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjASXyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:54:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54412222F6;
        Thu, 19 Jan 2023 15:54:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nyfby70Jzz4xyB;
        Fri, 20 Jan 2023 10:54:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674172449;
        bh=0xcnlkFe3M6zy+rnHW8YRwzOnflzHVA09QB3OhVXngw=;
        h=Date:From:To:Cc:Subject:From;
        b=Du78+wGIqWrfuvoEubdVks5MZMAW+itRLgm/v4dG6IfmV2rMg9yXtn/Vype3kQRP+
         LdJQEPss6X4Jih7+xY+TeqauADSe9g/nAk12gYA57U62X52ZHg7Sy51exHUOjytJVu
         OOjvf+C7+JQ9P8MMF9RMmmLTAWOqG+CDfu3kuAmSsfR1zJRRqg5CMWrMhXjBpm8HSN
         Rm+kXxlMzaavrzxb4Dv58C9uNx6HNJbAS1Ln+3kqqzFcj2Mpewg1kyNHBjeXTgZMSf
         TWSFfky+9SIMqM2xd64yg1pB/afb6xEYY5LbuOjhvgS3KGnGwni7JaJuPOttLZi366
         ZORcoOHV8/FNg==
Date:   Fri, 20 Jan 2023 10:54:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jim Mattson <jmattson@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Xin Li <xin3.li@intel.com>
Subject: linux-next: manual merge of the kvm-x86 tree with the tip tree
Message-ID: <20230120105405.14f3c4e4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PDN.6vXQj08SDg6qOrUujWG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PDN.6vXQj08SDg6qOrUujWG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-x86 tree got a conflict in:

  arch/x86/include/asm/cpufeatures.h

between commits:

  a018d2e3d4b1 ("x86/cpufeatures: Add Architectural PerfMon Extension bit")
  660569472dd7 ("x86/cpufeature: Add the CPU feature bit for LKGS")

from the tip tree and commit:

  751b1e1ee8e9 ("x86/cpufeatures: Add macros for Intel's new fast rep strin=
g features")

from the kvm-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/include/asm/cpufeatures.h
index 7b319acda31a,cdb7e1492311..000000000000
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@@ -312,8 -312,9 +312,11 @@@
  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
  #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructio=
ns */
  #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instru=
ctions */
 +#define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* "" Intel Architectural=
 PerfMon Extension */
+ #define X86_FEATURE_FZRM		(12*32+10) /* "" Fast zero-length REP MOVSB */
+ #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
+ #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
 +#define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
  #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
  #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMA=
DD52[H,L]UQ */
 =20

--Sig_/PDN.6vXQj08SDg6qOrUujWG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPJ2B0ACgkQAVBC80lX
0GyIkQgAlltw466NNRoIK+Qn6sEFD2DQ2nPnG4yOmKsau0HcX7nYfupek5paSpZn
fbKfRKXTFePfFUvVgKiXZJswtPnqGkl3veDmqI487sm106awLI28tdN6dXNx7Fff
ex7D0A0CS3sT5M+pJD1XkJ5RdkYr3TwdsYQelfO4q06f6saSpUDGt0ZuYdr3C6rU
yUZVs/2ODtv6zvphRHFWOd8jwFxwLqAAf2r8v/G4/7So6SLCT0OOzZuETbC+hgHr
P4qYc4SFCaeL1HukhmazmGNPWxJyi0kGN/8Ey8AutZj7/RLDyZfDPvBvWO7rA03+
/j/5gaDH03GO3xRARTlHUsIxF2nEEA==
=+QdR
-----END PGP SIGNATURE-----

--Sig_/PDN.6vXQj08SDg6qOrUujWG--
