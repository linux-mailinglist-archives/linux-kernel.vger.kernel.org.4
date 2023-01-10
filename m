Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90C663A70
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjAJIGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjAJIF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:05:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E04B42625;
        Tue, 10 Jan 2023 00:05:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AF50AD7;
        Tue, 10 Jan 2023 00:06:37 -0800 (PST)
Received: from [10.162.42.6] (unknown [10.162.42.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26F9A3F67D;
        Tue, 10 Jan 2023 00:05:48 -0800 (PST)
Message-ID: <1c555737-b2a6-cde0-8690-0278a75aa572@arm.com>
Date:   Tue, 10 Jan 2023 13:35:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 3/8] arm64/sysreg: Convert SPE registers to automatic
 generation
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>
References: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
 <20220825-arm-spe-v8-7-v4-3-327f860daf28@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220825-arm-spe-v8-7-v4-3-327f860daf28@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/23 00:56, Rob Herring wrote:
> Convert all the SPE register defines to automatic generation. No
> functional changes.
> 
> New registers and fields for SPEv1.2 are added with the conversion.
> 
> Some of the PMBSR MSS field defines are kept as the automatic generation
> has no way to create multiple names for the same register bits. The
> meaning of the MSS field depends on other bits.
> 
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> v4:
>  - Rebase on v6.2-rc1
> v3:
>  - Make some fields enums and add some missing fields
> v2:
>  - New patch
> ---
>  arch/arm64/include/asm/sysreg.h |  91 ++------------------------
>  arch/arm64/tools/sysreg         | 139 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 144 insertions(+), 86 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index dbb0e8e22cf4..db269eda7c1c 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -216,99 +216,18 @@
>  #define SYS_PAR_EL1_FST			GENMASK(6, 1)
>  
>  /*** Statistical Profiling Extension ***/
> -/* ID registers */
> -#define SYS_PMSIDR_EL1			sys_reg(3, 0, 9, 9, 7)
> -#define PMSIDR_EL1_FE_SHIFT		0
> -#define PMSIDR_EL1_FT_SHIFT		1
> -#define PMSIDR_EL1_FL_SHIFT		2
> -#define PMSIDR_EL1_ARCHINST_SHIFT	3
> -#define PMSIDR_EL1_LDS_SHIFT	4
> -#define PMSIDR_EL1_ERND_SHIFT	5
> -#define PMSIDR_EL1_INTERVAL_SHIFT	8
> -#define PMSIDR_EL1_INTERVAL_MASK	GENMASK_ULL(11, 8)
> -#define PMSIDR_EL1_MAXSIZE_SHIFT	12
> -#define PMSIDR_EL1_MAXSIZE_MASK		GENMASK_ULL(15, 12)
> -#define PMSIDR_EL1_COUNTSIZE_SHIFT	16
> -#define PMSIDR_EL1_COUNTSIZE_MASK	GENMASK_ULL(19, 16)
> -
> -#define SYS_PMBIDR_EL1			sys_reg(3, 0, 9, 10, 7)
> -#define PMBIDR_EL1_ALIGN_SHIFT		0
> -#define PMBIDR_EL1_ALIGN_MASK		0xfU
> -#define PMBIDR_EL1_P_SHIFT		4
> -#define PMBIDR_EL1_F_SHIFT		5
> -
> -/* Sampling controls */
> -#define SYS_PMSCR_EL1			sys_reg(3, 0, 9, 9, 0)
> -#define PMSCR_EL1_E0SPE_SHIFT		0
> -#define PMSCR_EL1_E1SPE_SHIFT		1
> -#define PMSCR_EL1_CX_SHIFT		3
> -#define PMSCR_EL1_PA_SHIFT		4
> -#define PMSCR_EL1_TS_SHIFT		5
> -#define PMSCR_EL1_PCT_SHIFT		6
> -
> -#define SYS_PMSCR_EL2			sys_reg(3, 4, 9, 9, 0)
> -#define PMSCR_EL2_E0HSPE_SHIFT		0
> -#define PMSCR_EL2_E2SPE_SHIFT		1
> -#define PMSCR_EL2_CX_SHIFT		3
> -#define PMSCR_EL2_PA_SHIFT		4
> -#define PMSCR_EL2_TS_SHIFT		5
> -#define PMSCR_EL2_PCT_SHIFT		6
> -
> -#define SYS_PMSICR_EL1			sys_reg(3, 0, 9, 9, 2)
> -
> -#define SYS_PMSIRR_EL1			sys_reg(3, 0, 9, 9, 3)
> -#define PMSIRR_EL1_RND_SHIFT		0
> -#define PMSIRR_EL1_INTERVAL_SHIFT	8
> -#define PMSIRR_EL1_INTERVAL_MASK	GENMASK_ULL(31, 8)
> -
> -/* Filtering controls */
> -#define SYS_PMSNEVFR_EL1		sys_reg(3, 0, 9, 9, 1)
> -
> -#define SYS_PMSFCR_EL1			sys_reg(3, 0, 9, 9, 4)
> -#define PMSFCR_EL1_FE_SHIFT		0
> -#define PMSFCR_EL1_FT_SHIFT		1
> -#define PMSFCR_EL1_FL_SHIFT		2
> -#define PMSFCR_EL1_B_SHIFT		16
> -#define PMSFCR_EL1_LD_SHIFT		17
> -#define PMSFCR_EL1_ST_SHIFT		18
> -
> -#define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
>  #define PMSEVFR_EL1_RES0_IMP	\
>  	(GENMASK_ULL(47, 32) | GENMASK_ULL(23, 16) | GENMASK_ULL(11, 8) |\
>  	 BIT_ULL(6) | BIT_ULL(4) | BIT_ULL(2) | BIT_ULL(0))
>  #define PMSEVFR_EL1_RES0_V1P1	\
>  	(PMSEVFR_EL1_RES0_IMP & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
>  
> -#define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
> -#define PMSLATFR_EL1_MINLAT_SHIFT	0
> -
> -/* Buffer controls */
> -#define SYS_PMBLIMITR_EL1		sys_reg(3, 0, 9, 10, 0)
> -#define PMBLIMITR_EL1_E_SHIFT		0
> -#define PMBLIMITR_EL1_FM_SHIFT		1
> -#define PMBLIMITR_EL1_FM_MASK	GENMASK_ULL(2, 1)
> -#define PMBLIMITR_EL1_FM_STOP_IRQ	0
> -
> -#define SYS_PMBPTR_EL1			sys_reg(3, 0, 9, 10, 1)
> -
>  /* Buffer error reporting */
> -#define SYS_PMBSR_EL1			sys_reg(3, 0, 9, 10, 3)
> -#define PMBSR_EL1_COLL_SHIFT		16
> -#define PMBSR_EL1_S_SHIFT		17
> -#define PMBSR_EL1_EA_SHIFT		18
> -#define PMBSR_EL1_DL_SHIFT		19
> -#define PMBSR_EL1_EC_SHIFT		26
> -#define PMBSR_EL1_EC_MASK		GENMASK_ULL(31, 26)
> -
> -#define PMBSR_EL1_EC_BUF		0x0UL
> -#define PMBSR_EL1_EC_FAULT_S1		0x24UL
> -#define PMBSR_EL1_EC_FAULT_S2		0x25UL
> -
> -#define PMBSR_EL1_FAULT_FSC_SHIFT	0
> -#define PMBSR_EL1_FAULT_FSC_MASK	0x3fUL
> -
> -#define PMBSR_EL1_BUF_BSC_SHIFT		0
> -#define PMBSR_EL1_BUF_BSC_MASK		0x3fUL
> +#define PMBSR_EL1_FAULT_FSC_SHIFT	PMBSR_EL1_MSS_SHIFT
> +#define PMBSR_EL1_FAULT_FSC_MASK	PMBSR_EL1_MSS_MASK
> +
> +#define PMBSR_EL1_BUF_BSC_SHIFT		PMBSR_EL1_MSS_SHIFT
> +#define PMBSR_EL1_BUF_BSC_MASK		PMBSR_EL1_MSS_MASK
>  
>  #define PMBSR_EL1_BUF_BSC_FULL		0x1UL
>  
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 184e58fd5631..c323833cf235 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1618,6 +1618,130 @@ Sysreg	FAR_EL1	3	0	6	0	0
>  Field	63:0	ADDR
>  EndSysreg
>  
> +Sysreg	PMSCR_EL1	3	0	9	9	0
> +Res0	63:8
> +Field	7:6	PCT
> +Field	5	TS
> +Field	4	PA
> +Field	3	CX
> +Res0	2
> +Field	1	E1SPE
> +Field	0	E0SPE
> +EndSysreg
> +
> +Sysreg	PMSNEVFR_EL1	3	0	9	9	1
> +Field	63:0	E
> +EndSysreg
> +
> +Sysreg	PMSICR_EL1	3	0	9	9	2
> +Field	63:56	ECOUNT
> +Res0	55:32
> +Field	31:0	COUNT
> +EndSysreg
> +
> +Sysreg	PMSIRR_EL1	3	0	9	9	3
> +Res0	63:32
> +Field	31:8	INTERVAL
> +Res0	7:1
> +Field	0	RND
> +EndSysreg
> +
> +Sysreg	PMSFCR_EL1	3	0	9	9	4
> +Res0	63:19
> +Field	18	ST
> +Field	17	LD
> +Field	16	B
> +Res0	15:4
> +Field	3	FnE
> +Field	2	FL
> +Field	1	FT
> +Field	0	FE
> +EndSysreg
> +
> +Sysreg	PMSEVFR_EL1	3	0	9	9	5
> +Field	63:0	E
> +EndSysreg
> +
> +Sysreg	PMSLATFR_EL1	3	0	9	9	6
> +Res0	63:16
> +Field	15:0	MINLAT
> +EndSysreg
> +
> +Sysreg	PMSIDR_EL1	3	0	9	9	7
> +Res0	63:25
> +Field	24	PBT
> +Field	23:20	FORMAT
> +Enum	19:16	COUNTSIZE
> +	0b0010	12_BIT_SAT
> +	0b0011	16_BIT_SAT
> +EndEnum
> +Field	15:12	MAXSIZE
> +Enum	11:8	INTERVAL
> +	0b0000	256
> +	0b0010	512
> +	0b0011	768
> +	0b0100	1024
> +	0b0101	1536
> +	0b0110	2048
> +	0b0111	3072
> +	0b1000	4096
> +EndEnum
> +Res0	7
> +Field	6	FnE
> +Field	5	ERND
> +Field	4	LDS
> +Field	3	ARCHINST
> +Field	2	FL
> +Field	1	FT
> +Field	0	FE
> +EndSysreg
> +
> +Sysreg	PMBLIMITR_EL1	3	0	9	10	0
> +Field	63:12	LIMIT
> +Res0	11:6
> +Field	5	PMFZ
> +Res0	4:3
> +Enum	2:1	FM
> +	0b00	FILL
> +	0b10	DISCARD
> +EndEnum
> +Field	0	E
> +EndSysreg
> +
> +Sysreg	PMBPTR_EL1	3	0	9	10	1
> +Field	63:0	PTR
> +EndSysreg
> +
> +Sysreg	PMBSR_EL1	3	0	9	10	3
> +Res0	63:32
> +Enum	31:26	EC
> +	0b000000	BUF
> +	0b100100	FAULT_S1
> +	0b100101	FAULT_S2
> +	0b011110	FAULT_GPC
> +	0b011111	IMP_DEF
> +EndEnum
> +Res0	25:20
> +Field	19	DL
> +Field	18	EA
> +Field	17	S
> +Field	16	COLL
> +Field	15:0	MSS
> +EndSysreg
> +
> +Sysreg	PMBIDR_EL1	3	0	9	10	7
> +Res0	63:12
> +Enum	11:8	EA
> +	0b0000	NotDescribed
> +	0b0001	Ignored
> +	0b0010	SError
> +EndEnum
> +Res0	7:6
> +Field	5	F
> +Field	4	P
> +Field	3:0	ALIGN
> +EndSysreg
> +
>  SysregFields	CONTEXTIDR_ELx
>  Res0	63:32
>  Field	31:0	PROCID
> @@ -1772,6 +1896,21 @@ Sysreg	FAR_EL2	3	4	6	0	0
>  Field	63:0	ADDR
>  EndSysreg
>  
> +Sysreg	PMSCR_EL2	3	4	9	9	0
> +Res0	63:8
> +Enum	7:6	PCT
> +	0b00	VIRT
> +	0b01	PHYS
> +	0b11	GUEST
> +EndEnum
> +Field	5	TS
> +Field	4	PA
> +Field	3	CX
> +Res0	2
> +Field	1	E2SPE
> +Field	0	E0HSPE
> +EndSysreg
> +
>  Sysreg	CONTEXTIDR_EL2	3	4	13	0	1
>  Fields	CONTEXTIDR_ELx
>  EndSysreg
> 
