Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C6B722046
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjFEH4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjFEHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:55:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9A8294;
        Mon,  5 Jun 2023 00:55:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11B16D75;
        Mon,  5 Jun 2023 00:56:18 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.24.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B0E43F793;
        Mon,  5 Jun 2023 00:55:30 -0700 (PDT)
Date:   Mon, 5 Jun 2023 08:55:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V11 02/10] arm64/perf: Add BRBE registers and fields
Message-ID: <ZH2U79ZP7HXNJctA@FVFF77S0Q05N>
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531040428.501523-3-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ANshuman,

This looks good to me, with some minor nits on enum value naming and field
formatting.

On Wed, May 31, 2023 at 09:34:20AM +0530, Anshuman Khandual wrote:
> This adds BRBE related register definitions and various other related field
> macros there in. These will be used subsequently in a BRBE driver which is
> being added later on.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Tested-by: James Clark <james.clark@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 103 +++++++++++++++++++++
>  arch/arm64/tools/sysreg         | 159 ++++++++++++++++++++++++++++++++
>  2 files changed, 262 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index e72d9aaab6b1..12419c55d3b7 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -165,6 +165,109 @@
>  #define SYS_DBGDTRTX_EL0		sys_reg(2, 3, 0, 5, 0)
>  #define SYS_DBGVCR32_EL2		sys_reg(2, 4, 0, 7, 0)
>  
> +#define __SYS_BRBINFO(n)		sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 0))
> +#define __SYS_BRBSRC(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 1))
> +#define __SYS_BRBTGT(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 2))

These look correct to me per ARM DDI 0487J.a

> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index c9a0d1fa3209..44745f42262f 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -947,6 +947,165 @@ UnsignedEnum	3:0	BT
>  EndEnum
>  EndSysreg
>  
> +
> +SysregFields BRBINFx_EL1
> +Res0	63:47
> +Field	46	CCU
> +Field	45:32	CC
> +Res0	31:18
> +Field	17	LASTFAILED
> +Field	16	T
> +Res0	15:14
> +Enum	13:8		TYPE
> +	0b000000	UNCOND_DIR
> +	0b000001	INDIR
> +	0b000010	DIR_LINK
> +	0b000011	INDIR_LINK

For clarity, I'd prefer that we use "DIRECT" and "INDIRECT" in full for each of
these, i.e.

	0b000000        UNCOND_DIRECT
	0b000001	INDIRECT
	0b000010	DIRECT_LINK
	0b000011	INDIRECT_LINK

> +	0b000101	RET_SUB
> +	0b000111	RET_EXCPT

Similarly, I'm not keen on the suffixes here.

I think these would be clearer as "RET" and "ERET", as those are short and
unambiguous, and I think the alternative of spelling out "RET_SUBROUTINE" and
"RET_EXCEPTION" is overly verbose.

> +	0b001000	COND_DIR

As with above, I'd prefer "COND_DIRECT" here.

> +	0b100001	DEBUG_HALT
> +	0b100010	CALL
> +	0b100011	TRAP
> +	0b100100	SERROR
> +	0b100110	INST_DEBUG

We generally use 'insn' rather than 'inst', so I'd prefer s/INST/INSN/ here.

> +	0b100111	DATA_DEBUG
> +	0b101010	ALGN_FAULT

s/ALGN/ALIGN/

> +	0b101011	INST_FAULT

As above, I'd prefer "INSN_FAULT" here, though I'm confused that the
architecture doesn't use "abort" naming for this.

> +	0b101100	DATA_FAULT
> +	0b101110	IRQ
> +	0b101111	FIQ
> +	0b111001	DEBUG_EXIT
> +EndEnum

[...]

+Sysreg	BRBCR_EL1	2	1	9	0	0
> +Res0	63:24
> +Field	23 	EXCEPTION
> +Field	22 	ERTN
> +Res0	21:9
> +Field	8 	FZP
> +Res0	7
> +Enum	6:5	TS
> +	0b01	VIRTUAL
> +	0b10	GST_PHYSICAL

s/GST/GUEST/

> +	0b11	PHYSICAL
> +EndEnum
> +Field	4	MPRED
> +Field	3	CC
> +Res0	2
> +Field	1	E1BRE
> +Field	0	E0BRE
> +EndSysreg

[...]

> +Sysreg	BRBINFINJ_EL1	2	1	9	1	0
> +Res0	63:47
> +Field	46	CCU
> +Field	45:32	CC
> +Res0	31:18
> +Field	17	LASTFAILED
> +Field	16	T
> +Res0	15:14
> +Enum	13:8		TYPE
> +	0b000000	UNCOND_DIR
> +	0b000001	INDIR
> +	0b000010	DIR_LINK
> +	0b000011	INDIR_LINK
> +	0b000100	RET_SUB
> +	0b000100	RET_SUB
> +	0b000111	RET_EXCPT
> +	0b001000	COND_DIR
> +	0b100001	DEBUG_HALT
> +	0b100010	CALL
> +	0b100011	TRAP
> +	0b100100	SERROR
> +	0b100110	INST_DEBUG
> +	0b100111	DATA_DEBUG
> +	0b101010	ALGN_FAULT
> +	0b101011	INST_FAULT
> +	0b101100	DATA_FAULT
> +	0b101110	IRQ
> +	0b101111	FIQ
> +	0b111001	DEBUG_EXIT
> +EndEnum

Same comments as for BRBINFx_EL1.TYPE

> +Enum	7:0		NUMREC
> +	0b1000		8
> +	0b10000		16
> +	0b100000	32
> +	0b1000000	64

Could we please pad these to the same width, i.e. have

	0b0001000	8
	0b0010000	16
	0b0100000	32
	0b1000000	64

That way it's much easier to see how these compare to one another, and it
matches the usual style.

Otherwise, I see the ARM ARM lists these in hex, and using that would also be
fine, e.g.

	0x08		8
	0x10		16
	0x20		32
	0x40		64

> +EndEnum
> +EndSysreg

Thanks,
Mark.
