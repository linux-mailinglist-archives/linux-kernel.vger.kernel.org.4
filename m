Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0E1730D28
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbjFOCWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjFOCWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:22:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBF61FC7;
        Wed, 14 Jun 2023 19:22:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QhQzR4Z4Hz4wjC;
        Thu, 15 Jun 2023 12:22:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686795732;
        bh=p5xSfDyYnXJ+NMp12bUovs/UHMo9Iq6/3qEBP2aWE7s=;
        h=Date:From:To:Cc:Subject:From;
        b=rCpNaGSbO4cpZNaTh21tAn3S91BcEAONQo46e0iIl/PbYcrJdmWxQViCEfMJG28YZ
         MG98qO4dFB/m4z2+c6V6fW1iVE9HGQa/YkP8qRM5bFW2psfN8zcXVXD0URKY5pDP1O
         f1slJygyUmDY3+8fjun8nMXnT8BvlKOUa3ytzYgj4ULQt5lUfHISOC3ntRA8DMkMih
         uFrpoI4lyOLOSQEpiCqB8Fif2FxY2eytHH0b9chj+rrxHlKKR56PJJ/OD6KX2qGtDM
         viXpgr23LgkfexpTfyltvKiW+w+bPor7dvikpWAlcu57ObICdgmGYNyjsb2YAlwrkI
         fhRR9kXAgBJlg==
Date:   Thu, 15 Jun 2023 12:22:01 +1000
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
Message-ID: <20230615122201.75e36abd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YDgaohlJglxE.E7b+0=/EcN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YDgaohlJglxE.E7b+0=/EcN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kernel/cpufeature.c

between commits:

  b7564127ffcb ("arm64: mops: detect and enable FEAT_MOPS")
  2b760046a2d3 ("arm64: cpufeature: add TCR2 cpucap")
  e43454c44232 ("arm64: cpufeature: add Permission Indirection Extension cp=
ucap")

from the arm64 tree and commits:

  c876c3f182a5 ("KVM: arm64: Relax trapping of CTR_EL0 when FEAT_EVT is ava=
ilable")
  e2d6c906f0ac ("arm64: Add KVM_HVHE capability and has_hvhe() predicate")

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
index 6ea7f23b1287,f6e3598760f1..000000000000
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@@ -2662,27 -2656,23 +2677,44 @@@ static const struct arm64_cpu_capabilit
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
 +		.matches =3D has_cpuid_feature,
 +		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, TCRX, IMP)
 +	},
 +	{
 +		.desc =3D "Stage-1 Permission Indirection Extension (S1PIE)",
 +		.capability =3D ARM64_HAS_S1PIE,
 +		.type =3D ARM64_CPUCAP_BOOT_CPU_FEATURE,
 +		.matches =3D has_cpuid_feature,
 +		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, S1PIE, IMP)
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
+ 	{
+ 		.desc =3D "VHE for hypervisor only",
+ 		.capability =3D ARM64_KVM_HVHE,
+ 		.type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
+ 		.matches =3D hvhe_possible,
+ 	},
  	{},
  };
 =20

--Sig_/YDgaohlJglxE.E7b+0=/EcN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSKdckACgkQAVBC80lX
0Gyxbwf9EM1Q4AJs0bQKVpsZr7EyPW+1+VlJ5fQkrrg10sumaUrro+mmWzCPH6fi
PSf26S4yfznp4QF8DShD7q/16PPAC1QkYnIJs9oyO4uXL9iuxjwqewFJ5ALDiP1b
0XWhNjMDodTCg0vK6foogBTPK3m74C4BwBYP7VnDzpPfNQN+/rDcqy5FVIC6ZJwO
hbBSews+HJ5iPnFrvRhq3Bm6/pUH4L0JBee0y5L3jmucPyvUNfAr+dcSfopU6z/T
7Ewpu6iNPAf4+NUSwyq6yXy/E4Kn444PLIKaf3G8QfqHEMfLJa+93Ciw2r+h9jpK
OmgM4wEaWv5rpiXoNhrJZLa5n6Sjnw==
=4Nz4
-----END PGP SIGNATURE-----

--Sig_/YDgaohlJglxE.E7b+0=/EcN--
