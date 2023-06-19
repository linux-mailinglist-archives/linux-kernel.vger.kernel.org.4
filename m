Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48272734A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 04:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjFSCdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 22:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFSCdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:33:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804EE1B4;
        Sun, 18 Jun 2023 19:33:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qkv2601YXz4x0B;
        Mon, 19 Jun 2023 12:33:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687141986;
        bh=t1l5GS/PuRN5cARlTbwzxa0sSs/zfPxD2hxKuKE13R8=;
        h=Date:From:To:Cc:Subject:From;
        b=BYfTRHJf+D2B56AZEtGjrO0GQ1RRFdocYxpx1ZoDpDKIVIhsKpkJB/h+LoEM9IwwO
         k0uqOMDCgsdnk6/EoEKBaVAuRneQDf3W5+naUpR3T8RoVe2YKc8O4me5kQEJM7MROm
         /ImsbdV8kSYhohDTkHnqlzJOXGdlpu0JI7kjHwq6wU8196InqEZATPxYkO1WRaqdkV
         rgKLNgFzo0jyhrzFFwboXjhu4q094MgA+oi+EDJcBlR4tm+l4LqkeyWjYW+DGe10ho
         dmM1WEApDtMWtuLkcil9f2RnjobJKlJM9/r4XuFPP4lbanFMTI9XKoOiYS84O5/+QE
         FevfzoiBXczrg==
Date:   Mon, 19 Jun 2023 12:33:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>
Cc:     Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: linux-next: manual merge of the kvm-riscv tree with the risc-v tree
Message-ID: <20230619123300.389e3dc9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=bB+dLl5ZRVFtXoRq8SiKYH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=bB+dLl5ZRVFtXoRq8SiKYH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-riscv tree got a conflict in:

  arch/riscv/include/uapi/asm/kvm.h

between commit:

  0f4b82579716 ("riscv: KVM: Add vector lazy save/restore support")

from the risc-v tree and commits:

  00f918f61c56 ("RISC-V: KVM: Skeletal in-kernel AIA irqchip support")
  89d01306e34d ("RISC-V: KVM: Implement device interface for AIA irqchip")
  289a007b98b0 ("RISC-V: KVM: Expose APLIC registers as attributes of AIA i=
rqchip")
  4fe9eadad83b ("RISC-V: KVM: Expose IMSIC registers as attributes of AIA i=
rqchip")

from the kvm-riscv tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/include/uapi/asm/kvm.h
index 855c047e86d4,61d7fecc4899..000000000000
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@@ -204,13 -204,77 +205,84 @@@ enum KVM_RISCV_SBI_EXT_ID=20
  #define KVM_REG_RISCV_SBI_MULTI_REG_LAST	\
  		KVM_REG_RISCV_SBI_MULTI_REG(KVM_RISCV_SBI_EXT_MAX - 1)
 =20
 +/* V extension registers are mapped as type 9 */
 +#define KVM_REG_RISCV_VECTOR		(0x09 << KVM_REG_RISCV_TYPE_SHIFT)
 +#define KVM_REG_RISCV_VECTOR_CSR_REG(name)	\
 +		(offsetof(struct __riscv_v_ext_state, name) / sizeof(unsigned long))
 +#define KVM_REG_RISCV_VECTOR_REG(n)	\
 +		((n) + sizeof(struct __riscv_v_ext_state) / sizeof(unsigned long))
 +
+ /* Device Control API: RISC-V AIA */
+ #define KVM_DEV_RISCV_APLIC_ALIGN		0x1000
+ #define KVM_DEV_RISCV_APLIC_SIZE		0x4000
+ #define KVM_DEV_RISCV_APLIC_MAX_HARTS		0x4000
+ #define KVM_DEV_RISCV_IMSIC_ALIGN		0x1000
+ #define KVM_DEV_RISCV_IMSIC_SIZE		0x1000
+=20
+ #define KVM_DEV_RISCV_AIA_GRP_CONFIG		0
+ #define KVM_DEV_RISCV_AIA_CONFIG_MODE		0
+ #define KVM_DEV_RISCV_AIA_CONFIG_IDS		1
+ #define KVM_DEV_RISCV_AIA_CONFIG_SRCS		2
+ #define KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS	3
+ #define KVM_DEV_RISCV_AIA_CONFIG_GROUP_SHIFT	4
+ #define KVM_DEV_RISCV_AIA_CONFIG_HART_BITS	5
+ #define KVM_DEV_RISCV_AIA_CONFIG_GUEST_BITS	6
+=20
+ /*
+  * Modes of RISC-V AIA device:
+  * 1) EMUL (aka Emulation): Trap-n-emulate IMSIC
+  * 2) HWACCEL (aka HW Acceleration): Virtualize IMSIC using IMSIC guest f=
iles
+  * 3) AUTO (aka Automatic): Virtualize IMSIC using IMSIC guest files when=
ever
+  *    available otherwise fallback to trap-n-emulation
+  */
+ #define KVM_DEV_RISCV_AIA_MODE_EMUL		0
+ #define KVM_DEV_RISCV_AIA_MODE_HWACCEL		1
+ #define KVM_DEV_RISCV_AIA_MODE_AUTO		2
+=20
+ #define KVM_DEV_RISCV_AIA_IDS_MIN		63
+ #define KVM_DEV_RISCV_AIA_IDS_MAX		2048
+ #define KVM_DEV_RISCV_AIA_SRCS_MAX		1024
+ #define KVM_DEV_RISCV_AIA_GROUP_BITS_MAX	8
+ #define KVM_DEV_RISCV_AIA_GROUP_SHIFT_MIN	24
+ #define KVM_DEV_RISCV_AIA_GROUP_SHIFT_MAX	56
+ #define KVM_DEV_RISCV_AIA_HART_BITS_MAX		16
+ #define KVM_DEV_RISCV_AIA_GUEST_BITS_MAX	8
+=20
+ #define KVM_DEV_RISCV_AIA_GRP_ADDR		1
+ #define KVM_DEV_RISCV_AIA_ADDR_APLIC		0
+ #define KVM_DEV_RISCV_AIA_ADDR_IMSIC(__vcpu)	(1 + (__vcpu))
+ #define KVM_DEV_RISCV_AIA_ADDR_MAX		\
+ 		(1 + KVM_DEV_RISCV_APLIC_MAX_HARTS)
+=20
+ #define KVM_DEV_RISCV_AIA_GRP_CTRL		2
+ #define KVM_DEV_RISCV_AIA_CTRL_INIT		0
+=20
+ /*
+  * The device attribute type contains the memory mapped offset of the
+  * APLIC register (range 0x0000-0x3FFF) and it must be 4-byte aligned.
+  */
+ #define KVM_DEV_RISCV_AIA_GRP_APLIC		3
+=20
+ /*
+  * The lower 12-bits of the device attribute type contains the iselect
+  * value of the IMSIC register (range 0x70-0xFF) whereas the higher order
+  * bits contains the VCPU id.
+  */
+ #define KVM_DEV_RISCV_AIA_GRP_IMSIC		4
+ #define KVM_DEV_RISCV_AIA_IMSIC_ISEL_BITS	12
+ #define KVM_DEV_RISCV_AIA_IMSIC_ISEL_MASK	\
+ 		((1U << KVM_DEV_RISCV_AIA_IMSIC_ISEL_BITS) - 1)
+ #define KVM_DEV_RISCV_AIA_IMSIC_MKATTR(__vcpu, __isel)	\
+ 		(((__vcpu) << KVM_DEV_RISCV_AIA_IMSIC_ISEL_BITS) | \
+ 		 ((__isel) & KVM_DEV_RISCV_AIA_IMSIC_ISEL_MASK))
+ #define KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(__attr)	\
+ 		((__attr) & KVM_DEV_RISCV_AIA_IMSIC_ISEL_MASK)
+ #define KVM_DEV_RISCV_AIA_IMSIC_GET_VCPU(__attr)	\
+ 		((__attr) >> KVM_DEV_RISCV_AIA_IMSIC_ISEL_BITS)
+=20
+ /* One single KVM irqchip, ie. the AIA */
+ #define KVM_NR_IRQCHIPS			1
+=20
  #endif
 =20
  #endif /* __LINUX_KVM_RISCV_H */

--Sig_/=bB+dLl5ZRVFtXoRq8SiKYH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSPvlwACgkQAVBC80lX
0GwdFQf/d9CCgkE0PrUDzkBr7r/4XMvFg6yGJyfFPG21dOLnKsfLV6ZJmE+CW3vT
ycKvWtX9MlCnVUrSdZUVU7MzxcIfDGwgif8pyx6ouBcJANTEVjt6of5isuGazuPY
lqSNGDImyQi8oqKvqk7i9xsDxMCY1VaBzAgsSIATbG9eN9KauopXk2av24bCdmAl
nQKX3ZGQirpg9fv/3Bd13SSyQDQ4Kxu8pDo2/+JTrEZp9YJeaRh8EtjC2mPUgSwt
yc4YhfieAx/6MEI2+BEWNLGgonWG+ObGmiP/BEZLE87Jm3ndjqPa7thf85MfmhMl
6snjJ5fcZmdPx2Pc4RmiQGde2SiqGA==
=mIfB
-----END PGP SIGNATURE-----

--Sig_/=bB+dLl5ZRVFtXoRq8SiKYH--
