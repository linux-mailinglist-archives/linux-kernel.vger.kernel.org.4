Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1676866E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjBANaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjBAN3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:29:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D62964D88
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:29:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 861246179C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01B0C433EF;
        Wed,  1 Feb 2023 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675258187;
        bh=m5cOWjvGFnEbPHdMo+hVyURcA9Sf5AmPc4tPLsKg/K8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=q8RkUhlgMXaHZzAiSnftDSU99sAZsj7Yp/5aF3VmX+96F9vgWrrErveWzkHfYuqoQ
         FPbfUPOmxNQ1NoqoyW9aCHuePE3vygXckO1sinM1pWt2pzy5stb3C91rUngm46+NHi
         r3R1+P1H+HfI0y0ijIGfgWBC0RoypDh54zA1rGfGNzRLWTECEJh3WAmvNn5wm26UtA
         s4tuh/vg6KdRTlVz23PF3BDpdqiAO1OzMaNByKYPIgLBsbtP6vNiKCp+0vXL4vrxKX
         V2BfTzqnvu3UpGs4+DFCumXGrrOlomyvgd2GBmBruzCelpJD2b1zZYr3C9VXgIZgor
         gcKgx1MXNGJaA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v6 04/13] riscv/kprobe: Add common RVI and RVC
 instruction decoder code
In-Reply-To: <20230127130541.1250865-5-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
 <20230127130541.1250865-5-chenguokai17@mails.ucas.ac.cn>
Date:   Wed, 01 Feb 2023 14:29:44 +0100
Message-ID: <87y1phtsxj.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> From: Liao Chang <liaochang1@huawei.com>
>
> These RVI and RVC instruction decoder are used in the free register
> searching algorithm, each instruction of instrumented function needs to
> decode and test if it contains a free register to form AUIPC/JALR.
>
> For RVI instruction format, the position and length of rs1/rs2/rd/opcode
> parts are uniform [1], but RVC instruction formats are complicated, so
> it addresses a series of functions to decode rs1/rs2/rd for RVC [1].
>
> [1] https://github.com/riscv/riscv-isa-manual/releases
>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> ---
>  arch/riscv/include/asm/bug.h             |   5 +-
>  arch/riscv/kernel/probes/decode-insn.h   | 148 +++++++++++++++++++++++
>  arch/riscv/kernel/probes/simulate-insn.h |  42 +++++++
>  3 files changed, 194 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
> index 1aaea81fb141..9c33d3b58225 100644
> --- a/arch/riscv/include/asm/bug.h
> +++ b/arch/riscv/include/asm/bug.h
> @@ -19,11 +19,14 @@
>  #define __BUG_INSN_32	_UL(0x00100073) /* ebreak */
>  #define __BUG_INSN_16	_UL(0x9002) /* c.ebreak */
>=20=20
> +#define RVI_INSN_LEN	4UL
> +#define RVC_INSN_LEN	2UL
> +
>  #define GET_INSN_LENGTH(insn)						\
>  ({									\
>  	unsigned long __len;						\
>  	__len =3D ((insn & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_32) ?	\
> -		4UL : 2UL;						\
> +		RVI_INSN_LEN : RVC_INSN_LEN;				\
>  	__len;								\
>  })
>=20=20
> diff --git a/arch/riscv/kernel/probes/decode-insn.h b/arch/riscv/kernel/p=
robes/decode-insn.h
> index 42269a7d676d..785b023a62ea 100644
> --- a/arch/riscv/kernel/probes/decode-insn.h
> +++ b/arch/riscv/kernel/probes/decode-insn.h
> @@ -3,6 +3,7 @@
>  #ifndef _RISCV_KERNEL_KPROBES_DECODE_INSN_H
>  #define _RISCV_KERNEL_KPROBES_DECODE_INSN_H
>=20=20
> +#include <linux/bitops.h>
>  #include <asm/sections.h>
>  #include <asm/kprobes.h>
>=20=20
> @@ -15,4 +16,151 @@ enum probe_insn {
>  enum probe_insn __kprobes
>  riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *as=
i);
>=20=20
> +#ifdef CONFIG_KPROBES

No reason to hide the static inlines behind an ifdef; Leave it out, so
it's less likely that code breaks slip through.

I wonder if these functions below would make more sense in the
asm/insn.h, where riscv_insn_is_##name live (which you're using in later
patches). Heiko (Cc'd) recently did a big clean up there, which probably
apply to the code below.

> +
> +static inline u16 rvi_rs1(kprobe_opcode_t opcode)
> +{
> +	return (u16)((opcode >> 15) & 0x1f);
> +}
> +
> +static inline u16 rvi_rs2(kprobe_opcode_t opcode)
> +{
> +	return (u16)((opcode >> 20) & 0x1f);
> +}
> +
> +static inline u16 rvi_rd(kprobe_opcode_t opcode)
> +{
> +	return (u16)((opcode >> 7) & 0x1f);
> +}
> +
> +static inline s32 rvi_branch_imme(kprobe_opcode_t opcode)
> +{
> +	u32 imme =3D 0;
> +
> +	imme |=3D (((opcode >> 8)  & 0xf)   << 1)  |
> +		(((opcode >> 25) & 0x3f)  << 5)  |
> +		(((opcode >> 7)  & 0x1)   << 11) |
> +		(((opcode >> 31) & 0x1)   << 12);
> +
> +	return sign_extend32(imme, 13);
> +}
> +
> +static inline s32 rvi_jal_imme(kprobe_opcode_t opcode)
> +{
> +	u32 imme =3D 0;
> +
> +	imme |=3D (((opcode >> 21) & 0x3ff) << 1)  |
> +		(((opcode >> 20) & 0x1)   << 11) |
> +		(((opcode >> 12) & 0xff)  << 12) |
> +		(((opcode >> 31) & 0x1)   << 20);
> +
> +	return sign_extend32(imme, 21);
> +}
> +
> +#ifdef CONFIG_RISCV_ISA_C

Dito. Just get rid of the ifdef clutter.


Bj=C3=B6rn
