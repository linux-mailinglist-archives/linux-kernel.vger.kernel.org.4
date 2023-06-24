Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B0673CC7C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 20:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjFXSzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjFXSzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 14:55:11 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3910510C1;
        Sat, 24 Jun 2023 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1687632909;
        bh=oo6VmKW0AOTDXj8uyzFXInC7kU3r7LeBNtZEkPWntsw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aHiBj05YaEhpfOsbFJ3nN1slNomy2D3xL//GZz9GuDUEj0fYrrruvMNhRU8c88ByC
         H74ORg9kq5QkCCbZP7V7rKkyJw2X4TgZpKPk5kh6DNdyAQau+mSjV1XbdF6zmU1Red
         2IXXgDqfzWKpgJBTsVWc/qobPlKXxTDaqSb+EZyE=
Received: from [IPv6:240e:358:11d2:6c00:dc73:854d:832e:2] (unknown [IPv6:240e:358:11d2:6c00:dc73:854d:832e:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 2D2CE65EC2;
        Sat, 24 Jun 2023 14:55:05 -0400 (EDT)
Message-ID: <bb4c5746bba9c96f083cbff0ced4185f88bef33a.camel@xry111.site>
Subject: Re: [PATCH v2 5/9] LoongArch: Simplify the invtlb wrappers
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
Date:   Sun, 25 Jun 2023 02:55:01 +0800
In-Reply-To: <20230624184055.3000636-6-kernel@xen0n.name>
References: <20230624184055.3000636-1-kernel@xen0n.name>
         <20230624184055.3000636-6-kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-06-25 at 02:40 +0800, WANG Xuerui wrote:
> From: WANG Xuerui <git@xen0n.name>
>=20
> The invtlb instruction has been supported by upstream LoongArch
> toolchains from day one, so ditch the raw opcode trickery and just use
> plain inline asm for it.
>=20
> While at it, also make the invtlb asm statements barriers, for proper
> modeling of the side effects.
>=20
> The signature of the other more specific invtlb wrappers contain unused
> arguments right now, but these are not removed right away in order for
> the patch to be focused. In the meantime, assertions are added to ensure
> no accidental misuse happens before the refactor. (The more specific
> wrappers cannot re-use the generic invtlb wrapper, because the ISA
> manual says $zero shall be used in case a particular op does not take
> the respective argument: re-using the generic wrapper would mean losing
> control over the register usage.)
>=20
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
> =C2=A0arch/loongarch/include/asm/tlb.h | 39 ++++++++++++++++-------------=
---
> =C2=A01 file changed, 19 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/loongarch/include/asm/tlb.h b/arch/loongarch/include/as=
m/tlb.h
> index 0dc9ee2b05d2..15750900540c 100644
> --- a/arch/loongarch/include/asm/tlb.h
> +++ b/arch/loongarch/include/asm/tlb.h
> @@ -88,52 +88,51 @@ enum invtlb_ops {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INVTLB_GID_ADDR =3D 0x16,
> =C2=A0};
> =C2=A0
> -/*
> - * invtlb op info addr
> - * (0x1 << 26) | (0x24 << 20) | (0x13 << 15) |
> - * (addr << 10) | (info << 5) | op
> - */
> =C2=A0static inline void invtlb(u32 op, u32 info, u64 addr)

Oh, technically these wrappers should be __always_inline, not only
inline because they don't work at all if not inlined.  Should we change
them to __always_inline in this patch by the way?

> =C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BUILD_BUG_ON(!__builtin_consta=
nt_p(op));

Hmm, I guess it's redundant.  If op is not a compile-time constant, it
won't satisfy the "i" constraint then the compiler will complain anyway.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__asm__ __volatile__(
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0"parse_r addr,%0\n\t"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0"parse_r info,%1\n\t"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0".word ((0x6498000) | (addr << 10) | (info << 5) | %2)\n\=
t"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0: "r"(addr), "r"(info), "i"(op)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0"invtlb %0, %1, %2\n\t"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0: "i"(op), "r"(info), "r"(addr)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0: "memory"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0);
> =C2=A0}

Likewise for other wrappers.

/* snip */

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
