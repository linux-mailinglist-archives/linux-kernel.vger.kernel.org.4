Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBDC72515D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbjFGBFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjFGBFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:05:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6BF10EA;
        Tue,  6 Jun 2023 18:05:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QbTfX3SCNz4x3y;
        Wed,  7 Jun 2023 11:05:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686099925;
        bh=e4oZlAfw52y9JGXr735f5Rbf2RXrsy8Vp7qSQsJEEt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bXqLtneUEW8i9LgqjEDQqK6GnOO4/BaU6zwyv0uEyn1TAJbZN+Vc/1bxvW+qZ3AIZ
         lzXfWViMxw8Ig3zLouGpcB80bo+dpwJoj4QN5NluB/GmHzQe9MlvKmxNb8D82XlHG9
         5cYu/tPPlRzNjjYzp/9bLQra5+rpz0i6OkyknzeqmJ52fHl3eKR5h83VDccCyvhPcY
         JtGgulsWjflkNvS0q9KOWaNiGJzHtYvFyl7YikZO1+KlcWEyS0l359QGx+TQ7Vmcof
         KLTOriz9DqT9V4zbkRrhgisaQPzxtgw/gv2ICVjuYqoeNFm3yDZReS3x5weN3W1XaD
         EKEL4Gl3162Jg==
Date:   Wed, 7 Jun 2023 11:05:21 +1000
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
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64
 tree
Message-ID: <20230607110521.442280f9@canb.auug.org.au>
In-Reply-To: <20230606114927.227a66a5@canb.auug.org.au>
References: <20230606114927.227a66a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b+2pJYc_b01Vegx//5E+E+a";
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

--Sig_/b+2pJYc_b01Vegx//5E+E+a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 6 Jun 2023 11:49:27 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the kvm-arm tree got a conflict in:
>=20
>   arch/arm64/kernel/cpufeature.c
>=20
> between commits:
>=20
>   b7564127ffcb ("arm64: mops: detect and enable FEAT_MOPS")
>   c1fa32c8f189 ("arm64: cpufeature: add TCR2 cpucap")
>   b5a8e35236ee ("arm64: cpufeature: add Permission Indirection Extension =
cpucap")
>=20
> from the arm64 tree and commit:
>=20
>   c876c3f182a5 ("KVM: arm64: Relax trapping of CTR_EL0 when FEAT_EVT is a=
vailable")
>=20
> from the kvm-arm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Commit b5a8e35236ee changed a bit, so the new resolution is below.
--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/kernel/cpufeature.c
index c3bdb14bb4bd,4a2ab3f366de..000000000000
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@@ -2662,27 -2641,17 +2662,38 @@@ static const struct arm64_cpu_capabilit
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
  	{},
  };
 =20

--Sig_/b+2pJYc_b01Vegx//5E+E+a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR/19EACgkQAVBC80lX
0GwnEwf9GJrMfL66JdX4Ojy8XtbbvCpzsCeQNgb5Vf7879jZO3u5iYcU8qcDTsuf
nu73SAB0PfZfDeN190wXB/lcKmrIYg3S3++QkVRf3SH3RWUwBJQN3it+qJyDoQIi
wNTGBCwtsmwgQNSf8jnprpk2P2N1GG5F9LiZTfetlFv+euxXy4R8321cOUFgnugp
J5pbEeiJr4SjWyPkQDbkPShZVelIcY4EfLwYs5agESyIg8mkuyMI4nWTqQ0piihz
BLdj2U37zxJkhT6N5lFmOh5LOkjRvAg9EE1EhaqVUuWHzSwXcKSKzxxDT2c4QnDJ
M0wNS1KOerCkaw8SFvDyUTRkHbjZ0A==
=kLt6
-----END PGP SIGNATURE-----

--Sig_/b+2pJYc_b01Vegx//5E+E+a--
