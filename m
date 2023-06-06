Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483437234DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjFFBu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjFFBus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:50:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919F9E54;
        Mon,  5 Jun 2023 18:50:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZtgs2hWWz4x1f;
        Tue,  6 Jun 2023 11:49:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686016170;
        bh=9XXm/QR5J7nxa7/gwe/mYjN3Je4hD6qAuS55zZUHYAU=;
        h=Date:From:To:Cc:Subject:From;
        b=CdNHa2ki9JcNnl7r8mitNMwcyXFXWyiAIqDWB96i/9d/FmJ11o2JVrWRh3tJa4Zzh
         tyDmC5mueCDPHMZw/LaD5l8vqGGNjzr2BB3TnHPT//Xrki8LkDFYO8heX/J8vF/sLb
         mkDuckw2QKTJQrEqky3FAFskE365eK9XCxyM1w8ryPr5p2l3wTClDUiQRgJDN4CKP1
         QCts/y+YMi1QhHymSjBTwFFGfCIq7qTaBKNLtnyCavZK1BDYDV2+VSBm59F7m2VJXS
         eSVwsWxhV44v0KrLuXvUu4meXM49G2nXDu7mdDixK5Jd5pJ3o4dhGV/+wxD6yJbX5C
         RB26o5dtEU4rg==
Date:   Tue, 6 Jun 2023 11:49:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20230606114927.227a66a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XVrtAiSNcUo33DlqVi4Wb7U";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XVrtAiSNcUo33DlqVi4Wb7U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kernel/cpufeature.c

between commits:

  b7564127ffcb ("arm64: mops: detect and enable FEAT_MOPS")
  c1fa32c8f189 ("arm64: cpufeature: add TCR2 cpucap")
  b5a8e35236ee ("arm64: cpufeature: add Permission Indirection Extension cp=
ucap")

from the arm64 tree and commit:

  c876c3f182a5 ("KVM: arm64: Relax trapping of CTR_EL0 when FEAT_EVT is ava=
ilable")

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

diff --cc arch/arm64/kernel/cpufeature.c
index a74f41c7280f,4a2ab3f366de..000000000000
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@@ -2662,35 -2641,17 +2662,46 @@@ static const struct arm64_cpu_capabilit
  		.cpu_enable =3D cpu_enable_dit,
  		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, DIT, IMP)
  	},
 +	{
 +		.desc =3D "Memory Copy and Memory Set instructions",
 +		.capability =3D ARM64_HAS_MOPS,
 +		.type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
 +		.matches =3D has_cpuid_feature,
 +		.cpu_enable =3D cpu_enable_mops,
 +		ARM64_CPUID_FIELDS(ID_AA64ISAR2_EL1, MOPS, IMP)
 +	},
 +	{
 +		.capability =3D ARM64_HAS_TCR2,
 +		.type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
 +		.sys_reg =3D SYS_ID_AA64MMFR3_EL1,
 +		.sign =3D FTR_UNSIGNED,
 +		.field_pos =3D ID_AA64MMFR3_EL1_TCRX_SHIFT,
 +		.field_width =3D 4,
 +		.min_field_value =3D ID_AA64MMFR3_EL1_TCRX_IMP,
 +		.matches =3D has_cpuid_feature,
 +	},
 +	{
 +		.desc =3D "Stage-1 Permission Indirection Extension (S1PIE)",
 +		.capability =3D ARM64_HAS_S1PIE,
 +		.type =3D ARM64_CPUCAP_BOOT_CPU_FEATURE,
 +		.sys_reg =3D SYS_ID_AA64MMFR3_EL1,
 +		.sign =3D FTR_UNSIGNED,
 +		.field_pos =3D ID_AA64MMFR3_EL1_S1PIE_SHIFT,
 +		.field_width =3D 4,
 +		.min_field_value =3D ID_AA64MMFR3_EL1_S1PIE_IMP,
 +		.matches =3D has_cpuid_feature,
 +	},
+ 	{
+ 		.desc =3D "Enhanced Virtualization Traps",
+ 		.capability =3D ARM64_HAS_EVT,
+ 		.type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
+ 		.sys_reg =3D SYS_ID_AA64MMFR2_EL1,
+ 		.sign =3D FTR_UNSIGNED,
+ 		.field_pos =3D ID_AA64MMFR2_EL1_EVT_SHIFT,
+ 		.field_width =3D 4,
+ 		.min_field_value =3D ID_AA64MMFR2_EL1_EVT_IMP,
+ 		.matches =3D has_cpuid_feature,
+ 	},
  	{},
  };
 =20

--Sig_/XVrtAiSNcUo33DlqVi4Wb7U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR+kKgACgkQAVBC80lX
0GwiKQf/RKdM/u5wDeJWseb42r8Jmcimgfz0r9wAk1+7DEo15PbpfEevML0j1XTW
I7t+2lL68XKxU+3yMMQE+CmCKSH53W3tcKElcdwHN+4ldDZZzOLil9cPdG6r6k6U
nEenIylKLzVZBJsLOE2IXg9DCX6gL8KiKTf8zhOMfDNBQKwheD2dtqhkSXgm4ITf
D9LHrM+caPRE2CuZfGSMouZfkW3clLmC0q5U6+UrI/ExUhC1mZGC6XTtzSZTNNBu
dmANQMAP+szei4vIeWtAAqYYTvnNEvHiveJOaYQqt73qmmJhpMu8drmp98i+dAsU
ncn2+FjuNlP8Jdw9owxqkgjmZJCvXQ==
=yJEb
-----END PGP SIGNATURE-----

--Sig_/XVrtAiSNcUo33DlqVi4Wb7U--
