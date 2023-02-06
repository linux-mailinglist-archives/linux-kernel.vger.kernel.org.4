Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B8768B4D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 05:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBFEVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 23:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFEVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 23:21:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD40917CEA;
        Sun,  5 Feb 2023 20:21:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P9Ckx6XXQz4xG5;
        Mon,  6 Feb 2023 15:21:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675657306;
        bh=kw6wLbZ4wZj4Hp+iPmvy19d2sW9nRxGaSQ/kP6wRUyk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sfs44GEO665Y4X+piZbyA1dLCirH7yEn3rSqF0SxbAPSiaqcCM4QtFqtSuNzBjcu5
         gguLQdcSk/oIF2XyJGxjT4k5XBULvT5eF494EPqgzAlS73IdlFrLv7v9e3nReq9ECj
         PSqPK6DzLGTdZwx1gcrEg5fbGblFJ5yvn51j9uVVbu1Q1K1qMpxF0ewGjul9zdWSzf
         e8OLcuVDhYIb8a9Whuqo459daytDeyZXCviz7FeazehUioqqTDt7LuxU0+tI82RztY
         m05n0SryfcwMNS8ol6fuzsqOQ9qcG8ho+A43RLM8P4xrKOIY1HuV5HMsK3iTailo5P
         OTWmr9AHVTZDg==
Date:   Mon, 6 Feb 2023 15:21:44 +1100
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
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64
 tree
Message-ID: <20230206152144.310d3fd1@canb.auug.org.au>
In-Reply-To: <20230206124451.11532a04@canb.auug.org.au>
References: <20230206124451.11532a04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y2Xrk1M2A/w5xxuSMB+x1SV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y2Xrk1M2A/w5xxuSMB+x1SV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 6 Feb 2023 12:44:51 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the kvm-arm tree got a conflict in:
>=20
>   arch/arm64/kernel/hyp-stub.S
>=20
> between commit:
>=20
>   f122576f3533 ("arm64/sme: Enable host kernel to access ZT0")
>=20
> from the arm64 tree and commit:
>=20
>   e2d4f5ae1771 ("KVM: arm64: Introduce finalise_el2_state macro")
>=20
> from the kvm-arm tree.
>=20
> I fixed it up (the code modified by the former was moved by the latter,
> so I applied the following merge fix patch) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>=20
> I hope I got this right :-)
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 6 Feb 2023 12:40:16 +1100
> Subject: [PATCH] fix up for "KVM: arm64: Introduce finalise_el2_state mac=
ro"
>=20
> interacting with "arm64/sme: Enable host kernel to access ZT0"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/arm64/include/asm/el2_setup.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/=
el2_setup.h
> index 0bd6ed77e4a5..5f821e5c52a9 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -269,6 +269,12 @@
>  	orr	x0, x0, SMCR_ELx_FA64_MASK
>  .Lskip_sme_fa64_\@:
> =20
> +	// ZT0 available?
> +	__check_override id_aa64smfr0 ID_AA64SMFR0_EL1_SMEver_SHIFT 4 .Linit_sm=
e_zt0_\@ .Lskip_sme_zt0_\@
> +.Linit_sme_zt0_\@:
> +	orr	x0, x0, SMCR_ELx_EZT0_MASK
> +.Lskip_sme_zt0_\@:
> +
>  	orr	x0, x0, #SMCR_ELx_LEN_MASK	// Enable full SME vector
>  	msr_s	SYS_SMCR_EL2, x0		// length for EL1.
> =20

I got it wrong, of course :-)

I have added the following fix up patch (and will combine the 2 from
tomorrow):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 6 Feb 2023 15:05:33 +1100
Subject: [PATCH] fix for "fix up for "KVM: arm64: Introduce finalise_el2_st=
ate macro""

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm64/include/asm/el2_setup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el=
2_setup.h
index 5f821e5c52a9..f5b608758741 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -270,7 +270,7 @@
 .Lskip_sme_fa64_\@:
=20
 	// ZT0 available?
-	__check_override id_aa64smfr0 ID_AA64SMFR0_EL1_SMEver_SHIFT 4 .Linit_sme_=
zt0_\@ .Lskip_sme_zt0_\@
+	__check_override id_aa64smfr0, ID_AA64SMFR0_EL1_SMEver_SHIFT, 4, .Linit_s=
me_zt0_\@, .Lskip_sme_zt0_\@, x1, x2
 .Linit_sme_zt0_\@:
 	orr	x0, x0, SMCR_ELx_EZT0_MASK
 .Lskip_sme_zt0_\@:
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/Y2Xrk1M2A/w5xxuSMB+x1SV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPggFgACgkQAVBC80lX
0GywFgf7BcBNTMCi8jRjZp8eJI6qAisK5tI6ThmcnXg1pfMn3MGjWiztYaXbTpWm
uWxTb8aEaz5dpurwN5W79pzengYLhBCMkWd98yfJCB5OotJ6TIQHS8uIcnMeSHOi
mRaoHQeQ4YrY5d4YLJRu7OjhqxwJ8DcpWFm+r6HPtdaEZiGjrjWUGavunuPxIsfN
wXertWw287fPu4mDkEDP17eKvywPZ/DBwSy4LUD2gve5OFJ+6MyBt6ibFk5F1Yu0
iyLTUxiTHCYyfSR+xDpWygCVEDoFvx2IJJu+OGPmhrn10T+iA54QDhZkHRFOMJPW
0BUTVz3OkeptaC1Bir4y1RRaRe6qYA==
=EDb2
-----END PGP SIGNATURE-----

--Sig_/Y2Xrk1M2A/w5xxuSMB+x1SV--
