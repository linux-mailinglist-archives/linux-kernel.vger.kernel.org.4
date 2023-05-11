Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F146D6FEC63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjEKHJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbjEKHIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:08:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E17EE7;
        Thu, 11 May 2023 00:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A00386373D;
        Thu, 11 May 2023 07:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E37C433EF;
        Thu, 11 May 2023 07:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683788928;
        bh=zuPvQjQoQD9hdY08fQaldTDPx+NyuNEmOMzEhWVsa0Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iUPZPR4WqDkAiew9KPB230+noVury3/Swjtl0kW77vKyHy021g6wvAZc23kZxsK4i
         NhSGLhKmbmVoxtzTVSdccMFwIMXZfSyy3Xc8Jyo/K42OVTQqiPUAYKAu+dYoTlA1Ht
         MDkkcWbQozmVeD/oVJuqWk3wSLlQFdVZZNN77uufN+4c2tVz0tYtDWO4Pu0FTgHs3C
         IY7hTIR5VNuIvOjajBT8CF1eC6IpAw/VqqxrxDK9XAsUET/yEaekBWgOv3ZnNnA2GA
         CyWfc/JptBe5UZJL3azM/ZUCeYu8IUIZUB3pKErthF3k3FR4UiApfh2/FKRjYZU5zs
         d0dXIV1nRBuDA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Song Shuai <suagrfillet@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, guoren@kernel.org,
        suagrfillet@gmail.com, jszhang@kernel.org, e.shatokhin@yadro.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH V9 2/4] riscv: ftrace: Add ftrace_graph_func
In-Reply-To: <20230510101857.2953955-3-suagrfillet@gmail.com>
References: <20230510101857.2953955-1-suagrfillet@gmail.com>
 <20230510101857.2953955-3-suagrfillet@gmail.com>
Date:   Thu, 11 May 2023 09:08:45 +0200
Message-ID: <87zg6bjqf6.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Shuai <suagrfillet@gmail.com> writes:

> Here implements ftrace_graph_func as the function graph tracing function
> with FTRACE_WITH_REGS defined.
>
> function_graph_func gets the point of the parent IP and the frame pointer
> from fregs and call prepare_ftrace_return for function graph tracing.
>
> If FTRACE_WITH_REGS isn't defined, the enable/disable helpers of
> ftrace_graph_[regs]_call are revised for serving only ftrace_graph_call
> in the !FTRACE_WITH_REGS version ftrace_caller.
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>

[...]

> +
> +	// always save the ABI regs
> +
> +	REG_S x10, PT_A0(sp)
> +	REG_S x11, PT_A1(sp)
> +	REG_S x12, PT_A2(sp)
> +	REG_S x13, PT_A3(sp)
> +	REG_S x14, PT_A4(sp)
> +	REG_S x15, PT_A5(sp)
> +	REG_S x16, PT_A6(sp)
> +	REG_S x17, PT_A7(sp)

Really a nit/more general comment; the RISC-V assembly files is a bit
all over the place in terms of style; When doing changes, try to
prettify it with proper tabs, and maybe we'll have eventual
consistency. ;-)

No tabs ^^^...

> +
> +	// save the leftover regs
> +
> +	.if \all =3D=3D 1
>  	REG_S x2,  PT_SP(sp)
>  	REG_S x3,  PT_GP(sp)
>  	REG_S x4,  PT_TP(sp)
>  	REG_S x5,  PT_T0(sp)
> -	save_from_x6_to_x31
> +	REG_S x6,  PT_T1(sp)
> +	REG_S x7,  PT_T2(sp)
> +	REG_S x8,  PT_S0(sp)
> +	REG_S x9,  PT_S1(sp)
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
> +
> +	// save s0 if FP_TEST defined
> +
> +	.else
> +#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> +	REG_S x8,  PT_S0(sp)
> +#endif
> +	.endif
>  	.endm
>=20=20
> -	.macro RESTORE_ALL
> +	.macro RESTORE_ABI_REGS, all=3D0
> +	REG_L t0,  PT_EPC(sp)
>  	REG_L x1,  PT_RA(sp)
> +	REG_L x10, PT_A0(sp)
> +	REG_L x11, PT_A1(sp)
> +	REG_L x12, PT_A2(sp)
> +	REG_L x13, PT_A3(sp)
> +	REG_L x14, PT_A4(sp)
> +	REG_L x15, PT_A5(sp)
> +	REG_L x16, PT_A6(sp)
> +	REG_L x17, PT_A7(sp)
> +
> +	.if \all =3D=3D 1
>  	REG_L x2,  PT_SP(sp)
>  	REG_L x3,  PT_GP(sp)
>  	REG_L x4,  PT_TP(sp)
> -	/* Restore t0 with PT_EPC */
> -	REG_L x5,  PT_EPC(sp)
> -	restore_from_x6_to_x31
> +	REG_L x6,  PT_T1(sp)
> +	REG_L x7,  PT_T2(sp)
> +	REG_L x8,  PT_S0(sp)
> +	REG_L x9,  PT_S1(sp)
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
>=20=20
> +	.else
> +#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> +	REG_L x8,  PT_S0(sp)
> +#endif
> +	.endif
>  	addi	sp, sp, PT_SIZE_ON_STACK
>  	.endm
> +
> +	.macro PREPARE_ARGS
> +	addi	a0, t0, -FENTRY_RA_OFFSET	// ip
> +	la	a1, function_trace_op
> +	REG_L	a2, 0(a1)			// op
> +	mv	a1, ra				// parent_ip
> +	mv	a3, sp				// fregs
> +	.endm

...but here...

> +
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>=20=20
> +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  ENTRY(ftrace_caller)
>  	SAVE_ABI
>=20=20
> @@ -110,33 +229,28 @@ ftrace_graph_call:
>  	jr t0
>  ENDPROC(ftrace_caller)
>=20=20
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  ENTRY(ftrace_regs_caller)
> -	SAVE_ALL
> -
> -	addi	a0, t0, -FENTRY_RA_OFFSET
> -	la	a1, function_trace_op
> -	REG_L	a2, 0(a1)
> -	mv	a1, ra
> -	mv	a3, sp
> +	SAVE_ABI_REGS 1
> +	PREPARE_ARGS
>=20=20
>  ftrace_regs_call:
>  	.global ftrace_regs_call
>  	call	ftrace_stub
>=20=20
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -	addi	a0, sp, PT_RA
> -	REG_L	a1, PT_EPC(sp)
> -	addi	a1, a1, -FENTRY_RA_OFFSET
> -#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> -	mv	a2, s0
> -#endif
> -ftrace_graph_regs_call:
> -	.global ftrace_graph_regs_call
> +	RESTORE_ABI_REGS 1
> +	jr t0

...and not here.

Not a biggie! Nice cleanup!

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
