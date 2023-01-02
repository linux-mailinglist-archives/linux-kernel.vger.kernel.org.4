Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FCE65B62B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbjABSEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbjABSEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:04:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEA7C750
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:04:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F4C9B80DD6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F46C433F0;
        Mon,  2 Jan 2023 18:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672682661;
        bh=j7GhxuoC4d5Rgo238pOIh+9KGGQvHQFTsqT3DN6rD9k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mO6+7DMaE9SeMM1SEmk6PB0bL35j8ffcbmNIVqEpVqPTinU64GLKqLFZJJQFcbL+b
         TdQrQeOTQRsrQqWBGQSL6TzQfk1tWoQ85Q4zd/1lxSslQHysqJU6OMaPzDgGzwywi2
         khZBn6FRrTmbKDKXmcN4kNtwKwgdNfj7W5AnDymhDgNf9JyVTAo3SPt+wl5wjNsgCi
         lqnUxK8eCCGhJQ4Lym3beGAry2Pd8OcrYhSjGPB05sA1GcAD7O2pnZc43OTuDxWOxV
         EmZ15VRIrzcDfGPJWkQONCFEJL00SMtFskxuLe7xZtcryqGMi2vmCKnYbev3z6G+u2
         M0jSxCgaeDutw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v5 7/9] riscv/kprobe: Prepare detour buffer for
 optimized kprobe
In-Reply-To: <20221224114315.850130-8-chenguokai17@mails.ucas.ac.cn>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-8-chenguokai17@mails.ucas.ac.cn>
Date:   Mon, 02 Jan 2023 19:04:18 +0100
Message-ID: <87r0wcvmn1.fsf@all.your.base.are.belong.to.us>
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

> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/op=
t.c
> index 258a283c906d..bc232fce5b39 100644
> --- a/arch/riscv/kernel/probes/opt.c
> +++ b/arch/riscv/kernel/probes/opt.c
> @@ -11,9 +11,37 @@
>  #include <linux/kprobes.h>
>  #include <asm/kprobes.h>
>  #include <asm/patch.h>
> +#include <asm/asm-offsets.h>
>=20=20
>  #include "simulate-insn.h"
>  #include "decode-insn.h"
> +#include "../../net/bpf_jit.h"
> +
> +static void

Super-nit, but I really prefer *not* breaking function name and return
value, for grepability.

> diff --git a/arch/riscv/kernel/probes/opt_trampoline.S b/arch/riscv/kerne=
l/probes/opt_trampoline.S
> index 16160c4367ff..75e34e373cf2 100644
> --- a/arch/riscv/kernel/probes/opt_trampoline.S
> +++ b/arch/riscv/kernel/probes/opt_trampoline.S
> @@ -1,12 +1,137 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (C) 2022 Guokai Chen
> + * Copyright (C) 2022 Liao, Chang <liaochang1@huawei.com>
>   */
>=20=20
>  #include <linux/linkage.h>
>=20=20
> +#include <asm/asm.h>
>  #incldue <asm/csr.h>
>  #include <asm/asm-offsets.h>
>=20=20
>  SYM_ENTRY(optprobe_template_entry, SYM_L_GLOBAL, SYM_A_NONE)
> +	addi  sp, sp, -(PT_SIZE_ON_STACK)
> +	REG_S x1,  PT_RA(sp)
> +	REG_S x2,  PT_SP(sp)
> +	REG_S x3,  PT_GP(sp)
> +	REG_S x4,  PT_TP(sp)
> +	REG_S x5,  PT_T0(sp)
> +	REG_S x6,  PT_T1(sp)
> +	REG_S x7,  PT_T2(sp)
> +	REG_S x8,  PT_S0(sp)
> +	REG_S x9,  PT_S1(sp)
> +	REG_S x10, PT_A0(sp)
> +	REG_S x11, PT_A1(sp)
> +	REG_S x12, PT_A2(sp)
> +	REG_S x13, PT_A3(sp)
> +	REG_S x14, PT_A4(sp)
> +	REG_S x15, PT_A5(sp)
> +	REG_S x16, PT_A6(sp)
> +	REG_S x17, PT_A7(sp)
> +	REG_S x18, PT_S2(sp)
> +	REG_S x19, PT_S3(sp)
> +	REG_S x20, PT_S4(sp)
> +	REG_S x21, PT_S5(sp)
> +	REG_S x22, PT_S6(sp)
> +	REG_S x23, PT_S7(sp)
> +	REG_S x24, PT_S8(sp)
> +	REG_S x25, PT_S9(sp)
> +	REG_S x26, PT_S10(sp)
> +	REG_S x27, PT_S11(sp)
> +	REG_S x28, PT_T3(sp)
> +	REG_S x29, PT_T4(sp)
> +	REG_S x30, PT_T5(sp)
> +	REG_S x31, PT_T6(sp)
> +	/* Update fp is friendly for stacktrace */
> +	addi  s0, sp, (PT_SIZE_ON_STACK)
> +	j 1f
> +
> +SYM_ENTRY(optprobe_template_save, SYM_L_GLOBAL, SYM_A_NONE)
> +	/*
> +	 * Step1:
> +	 * Filled with the pointer to optimized_kprobe data
> +	 */
> +	.dword 0
> +1:
> +	/* Load optimize_kprobe pointer from .dword below */
> +	auipc a0, 0
> +	REG_L a0, -8(a0)
> +	add   a1, sp, x0
> +
> +SYM_ENTRY(optprobe_template_call, SYM_L_GLOBAL, SYM_A_NONE)
> +	/*
> +	 * Step2:
> +	 * <IMME> of AUIPC/JALR are modified to the offset to optimized_callback
> +	 * jump target is loaded from above .dword.
> +	 */
> +	auipc ra, 0
> +	jalr  ra, 0(ra)
> +
> +	REG_L x1,  PT_RA(sp)
> +	REG_L x3,  PT_GP(sp)
> +	REG_L x4,  PT_TP(sp)
> +	REG_L x5,  PT_T0(sp)
> +	REG_L x6,  PT_T1(sp)
> +	REG_L x7,  PT_T2(sp)
> +	REG_L x8,  PT_S0(sp)
> +	REG_L x9,  PT_S1(sp)
> +	REG_L x10, PT_A0(sp)
> +	REG_L x11, PT_A1(sp)
> +	REG_L x12, PT_A2(sp)
> +	REG_L x13, PT_A3(sp)
> +	REG_L x14, PT_A4(sp)
> +	REG_L x15, PT_A5(sp)
> +	REG_L x16, PT_A6(sp)
> +	REG_L x17, PT_A7(sp)
> +	REG_L x18, PT_S2(sp)
> +	REG_L x19, PT_S3(sp)
> +	REG_L x20, PT_S4(sp)
> +	REG_L x21, PT_S5(sp)
> +	REG_L x22, PT_S6(sp)
> +	REG_L x23, PT_S7(sp)
> +	REG_L x24, PT_S8(sp)
> +	REG_L x25, PT_S9(sp)
> +	REG_L x26, PT_S10(sp)
> +	REG_L x27, PT_S11(sp)
> +	REG_L x28, PT_T3(sp)
> +	REG_L x29, PT_T4(sp)
> +	REG_L x30, PT_T5(sp)
> +	REG_L x31, PT_T6(sp)
> +	REG_L x2,  PT_SP(sp)
> +	addi  sp, sp, (PT_SIZE_ON_STACK)
> +
> +SYM_ENTRY(optprobe_template_insn, SYM_L_GLOBAL, SYM_A_NONE)
> +	/*
> +	 * Step3:
> +	 * NOPS will be replaced by the probed instruction, at worst case 3 RVC
> +	 * and 1 RVI instructions is about to execute out of line.
> +	 */
> +	nop

A nop here will be either a compressed nop or a non-compressed,
depending on the build (C-enabled or not), right? Maybe be explicit to
the assembler what you want?


Bj=C3=B6rn
