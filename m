Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D241F68B3F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBFBpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFBo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:44:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7119F28;
        Sun,  5 Feb 2023 17:44:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P98Fw5dwLz4x1d;
        Mon,  6 Feb 2023 12:44:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675647893;
        bh=CzV4pf5p8FlgcWCqtH6KBBJgrPVgee8EJCd9EengFhw=;
        h=Date:From:To:Cc:Subject:From;
        b=lWoH79UJm0HxpmsUSKyF0xM9ly8TfHLeBvAYxMCetwOBpiMWuOyMlIEIBS1t8hCYU
         GEsEvhfLLpd91Anvqm0bzNsJk0m25/f+dRi8hEDMtl+UWoVrpKMPkNBxFdlW95PkZg
         AwkQoID0FXtujF9U+TaVDXyEgu0dn1dleM86jcaOgzOxZLqgdFqshNsknaw4qItm2w
         /4oTviSw33AieeA6gG0C64b4a1Evsp9gofYAB1YYJ9JeUaR4HrGVDRCUeLrAjPo06l
         ogUBxMGL7OEkpp8kRmIApZuBUzuJdVgbEqow6tGrxOro67PZe4aFXlLWVJ3vcB2e35
         28vAmIbUx4+vw==
Date:   Mon, 6 Feb 2023 12:44:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Quentin Perret <qperret@google.com>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20230206124451.11532a04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YM1OQPo2J0H+.jV1QoQRJEL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YM1OQPo2J0H+.jV1QoQRJEL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kernel/hyp-stub.S

between commit:

  f122576f3533 ("arm64/sme: Enable host kernel to access ZT0")

from the arm64 tree and commit:

  e2d4f5ae1771 ("KVM: arm64: Introduce finalise_el2_state macro")

from the kvm-arm tree.

I fixed it up (the code modified by the former was moved by the latter,
so I applied the following merge fix patch) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

I hope I got this right :-)

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 6 Feb 2023 12:40:16 +1100
Subject: [PATCH] fix up for "KVM: arm64: Introduce finalise_el2_state macro"

interacting with "arm64/sme: Enable host kernel to access ZT0"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm64/include/asm/el2_setup.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el=
2_setup.h
index 0bd6ed77e4a5..5f821e5c52a9 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -269,6 +269,12 @@
 	orr	x0, x0, SMCR_ELx_FA64_MASK
 .Lskip_sme_fa64_\@:
=20
+	// ZT0 available?
+	__check_override id_aa64smfr0 ID_AA64SMFR0_EL1_SMEver_SHIFT 4 .Linit_sme_=
zt0_\@ .Lskip_sme_zt0_\@
+.Linit_sme_zt0_\@:
+	orr	x0, x0, SMCR_ELx_EZT0_MASK
+.Lskip_sme_zt0_\@:
+
 	orr	x0, x0, #SMCR_ELx_LEN_MASK	// Enable full SME vector
 	msr_s	SYS_SMCR_EL2, x0		// length for EL1.
=20
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/YM1OQPo2J0H+.jV1QoQRJEL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgW5MACgkQAVBC80lX
0GzTegf+K4QEBDJ2BmAUVUN20bblJFGfuoAqyj9Pyqxf5KwNc/sZX0qbs+M/7pdg
yr49Cx67ayihXiHVkouvAVpmG+6EFj6qT18wyGOrS3kQHfaICkpN2vrdlCmvhCiQ
nGxMH1GJ9O6avc9T3pHNEUZZ94Y250uCR8TI5Ij3J/zxJk/xVlW8Dl8R3SYFc5Q7
j+TM3VMamQZ1eJKKsBd47J/raEYi1gTNENZqKYgBjArNpvrGHNHiUtwqE+4UHUpa
OlzlG1ZzwsnykUVfx3lXfHZKqAumfqhYnnapEh6+uvGW4JLkp2LPjW2BPugPL5Wj
fsdGWbSZaeDE7hGhTzOdKKv/oBhLLQ==
=eSLO
-----END PGP SIGNATURE-----

--Sig_/YM1OQPo2J0H+.jV1QoQRJEL--
