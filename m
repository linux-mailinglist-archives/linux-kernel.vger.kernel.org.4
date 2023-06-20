Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE2A7361A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjFTCpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFTCpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:45:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBF310C1;
        Mon, 19 Jun 2023 19:45:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QlWG70ZxGz4wgn;
        Tue, 20 Jun 2023 12:45:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687229136;
        bh=WyVTCXi2M4ockHdssmMw4QkwO3NRemhqMisvdiRWy6A=;
        h=Date:From:To:Cc:Subject:From;
        b=RHnFnrXGv6jrHeCCYLLT7QmdNfBxDnfxOYsAC6v5NgNlHws2YBp+BCYC8kakwhknh
         qcD2IhTtmgtr+NUFGk/7MW79WyTi/ChfPqq1MHfvAqH9grZdrbFXnih4oioc17m3C3
         6FHSALF7xkJn76BUZjXY58JCnyoBb6w7is0HZdbF6roQdgEpVU1+F0ZpzDjdgYdWB6
         uQykGa75o8FL8UZcMYOuDpM/uGFiWC5poqIz3ESVvtogPuCra01C6QrNKTPyFK3YXW
         MOIw6aA4vAnmtg+HN8XIMKadiD8OhfgPxcjWuyjZnYt2oJtUdBxLX5zE08qgn5XitJ
         MzvxnJNcsmruw==
Date:   Tue, 20 Jun 2023 12:45:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>
Cc:     Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: linux-next: manual merge of the kvm-riscv tree with the risc-v tree
Message-ID: <20230620124533.45c18fee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PjyC9NhbwDykvFby/Tjgm_O";
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

--Sig_/PjyC9NhbwDykvFby/Tjgm_O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-riscv tree got a conflict in:

  arch/riscv/include/uapi/asm/kvm.h

between commit:

  bf78f1ea6e51 ("riscv: kvm: Add V extension to KVM ISA")

from the risc-v tree and commit:

  3177011788ee ("RISC-V: KVM: Allow Svnapot extension for Guest/VM")

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
index 855c047e86d4,a1ca18408bbd..000000000000
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@@ -121,7 -122,7 +122,8 @@@ enum KVM_RISCV_ISA_EXT_ID=20
  	KVM_RISCV_ISA_EXT_ZICBOZ,
  	KVM_RISCV_ISA_EXT_ZBB,
  	KVM_RISCV_ISA_EXT_SSAIA,
 +	KVM_RISCV_ISA_EXT_V,
+ 	KVM_RISCV_ISA_EXT_SVNAPOT,
  	KVM_RISCV_ISA_EXT_MAX,
  };
 =20
@@@ -204,13 -205,77 +206,84 @@@ enum KVM_RISCV_SBI_EXT_ID=20
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

--Sig_/PjyC9NhbwDykvFby/Tjgm_O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSREs0ACgkQAVBC80lX
0GxfBAf/SsCxNDBA9KNLA6Qn9rIoC1x2Ai23E5rORkX07RTcer9V21RQj0Whd2TS
EovPsWVipIVuCIUzDCr74caogm1zgdaXQbuATDuthq4D3jTN63jiA77p3flqQ9FE
z0CgJdLq+bVXOXOgcsDvWpXGrr0j+CB3vwgKlCC8qjCSTmRn0crC+X1oRccww9xl
9fYphLOPhjGBTKJzXut9N3uZfT+DfBa0wePzcQaY+aHNM8+Y3Wb1rfDFRw3V4duW
dvrXtBnxzMKyuDQ6REYF/1/IBoMOCtnBTHEMQqiQ7nL3p3fBW3B9/L+SU0NbF0xb
JMhOgl6LFEbbuxRdcGAGOOpqlypBPQ==
=LLTa
-----END PGP SIGNATURE-----

--Sig_/PjyC9NhbwDykvFby/Tjgm_O--
