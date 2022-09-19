Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8525BC1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiISEFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISEFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:05:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819E010577;
        Sun, 18 Sep 2022 21:05:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MWB0s5NNZz4xG7;
        Mon, 19 Sep 2022 14:05:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663560334;
        bh=lGRg5H2auKhJCeXfKgpMtOR/iq9tTK4KJQgixZ3BfCc=;
        h=Date:From:To:Cc:Subject:From;
        b=c7mFWeDOkxbWkQrg1c5+MvAY5SD6+vOOUAl1y1R/31grkWHhBo5im9tI1kH/9T5gj
         U94mqEDHvwz00molAKlF28zqm48JAOP1DJAI4lyxWdSGXHphvE2nCwZxAAOCqyoahA
         v999SXv1MxZbuyNt3ol73aDnD51Efy5XsE8k6s1Vbrf1hxT4T4zIgtgf8O1IszwzXV
         6P/XM882eRL74nFzIGBkOR48pmKgXnh0yeS971MAe3qeQn4huoQ4pK2NNiQR+Hxb1T
         OcUl1XOB4fIx/9wdmBcCmSena+qsPk6Q6A0ebnwOQIsuOYVwg0xB25uO8qnIZhZCmK
         1YmgyIbFFUN3Q==
Date:   Mon, 19 Sep 2022 14:05:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20220919140531.3741d146@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JWkaPhG38BcMw7kEDLlHw8j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JWkaPhG38BcMw7kEDLlHw8j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kvm/sys_regs.c

between commit:

  55adc08d7e64 ("arm64/sysreg: Add _EL1 into ID_AA64PFR0_EL1 definition nam=
es")

from the arm64 tree and commit:

  cdd5036d048c ("KVM: arm64: Drop raz parameter from read_id_reg()")

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

diff --cc arch/arm64/kvm/sys_regs.c
index 2ef1121ab844,9569772cf09a..000000000000
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@@ -1208,9 -1210,9 +1210,9 @@@ static int set_id_aa64pfr0_el1(struct k
  		return -EINVAL;
 =20
  	/* We can only differ with CSV[23], and anything else is an error */
- 	val ^=3D read_id_reg(vcpu, rd, false);
+ 	val ^=3D read_id_reg(vcpu, rd);
 -	val &=3D ~((0xFUL << ID_AA64PFR0_CSV2_SHIFT) |
 -		 (0xFUL << ID_AA64PFR0_CSV3_SHIFT));
 +	val &=3D ~((0xFUL << ID_AA64PFR0_EL1_CSV2_SHIFT) |
 +		 (0xFUL << ID_AA64PFR0_EL1_CSV3_SHIFT));
  	if (val)
  		return -EINVAL;
 =20

--Sig_/JWkaPhG38BcMw7kEDLlHw8j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMn6osACgkQAVBC80lX
0Gxbbwf/W2GL/uhdDg7eRtozgyBJYSAWDm3DdsgjNBAGiHu9rF+q3USchGe92WR8
nREf+gDg5L/mP/r9dpfai2hr4IWwFXRaR2RU2d0MGIigXNANWV2hszIRVnT+UQHC
eG4fC555HM2FyCNDSHC5SZatPNm/1a52GN6NeCnLEVq1P2kFV5aQyGRLNN8jF2IP
sOtHO2H4Ym8Plo+F1N2l0eezuDA9yqFN7i392mnQgoTfbluIOjchmUSoDNjtwNlq
TckVifkoOh2rLldeWsp1jusqLzKpujXp6uSBFpTehAHnoiTqRGobQtTxPmhAJ1w6
p+KPyRVDdklgAxy//eiQIYqWHOo6Vw==
=x+BQ
-----END PGP SIGNATURE-----

--Sig_/JWkaPhG38BcMw7kEDLlHw8j--
