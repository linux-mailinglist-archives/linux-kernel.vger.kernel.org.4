Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3584D65CE6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjADIfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjADIf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:35:26 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B8D193CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:35:25 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nn2v92wmTznV0M;
        Wed,  4 Jan 2023 16:33:57 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 16:35:23 +0800
Message-ID: <088ed826-59a8-37a3-401e-2ed022a4a097@huawei.com>
Date:   Wed, 4 Jan 2023 16:35:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 7/9] riscv/kprobe: Prepare detour buffer for optimized
 kprobe
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-8-chenguokai17@mails.ucas.ac.cn>
 <87r0wcvmn1.fsf@all.your.base.are.belong.to.us>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <87r0wcvmn1.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/3 2:04, Björn Töpel 写道:
> Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:
> 
>> From: Liao Chang <liaochang1@huawei.com>
> 
>> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
>> index 258a283c906d..bc232fce5b39 100644
>> --- a/arch/riscv/kernel/probes/opt.c
>> +++ b/arch/riscv/kernel/probes/opt.c
>> @@ -11,9 +11,37 @@
>>  #include <linux/kprobes.h>
>>  #include <asm/kprobes.h>
>>  #include <asm/patch.h>
>> +#include <asm/asm-offsets.h>
>>  
>>  #include "simulate-insn.h"
>>  #include "decode-insn.h"
>> +#include "../../net/bpf_jit.h"
>> +
>> +static void
> 
> Super-nit, but I really prefer *not* breaking function name and return
> value, for grepability.

OK, i will keep function name and return at the same line.

> 
>> diff --git a/arch/riscv/kernel/probes/opt_trampoline.S b/arch/riscv/kernel/probes/opt_trampoline.S
>> index 16160c4367ff..75e34e373cf2 100644
>> --- a/arch/riscv/kernel/probes/opt_trampoline.S
>> +++ b/arch/riscv/kernel/probes/opt_trampoline.S
>> @@ -1,12 +1,137 @@
>>  /* SPDX-License-Identifier: GPL-2.0-only */
>>  /*
>>   * Copyright (C) 2022 Guokai Chen
>> + * Copyright (C) 2022 Liao, Chang <liaochang1@huawei.com>
>>   */
>>  
>>  #include <linux/linkage.h>
>>  
>> +#include <asm/asm.h>
>>  #incldue <asm/csr.h>
>>  #include <asm/asm-offsets.h>
>>  
>>  SYM_ENTRY(optprobe_template_entry, SYM_L_GLOBAL, SYM_A_NONE)
>> +	addi  sp, sp, -(PT_SIZE_ON_STACK)
>> +	REG_S x1,  PT_RA(sp)
>> +	REG_S x2,  PT_SP(sp)
>> +	REG_S x3,  PT_GP(sp)
>> +	REG_S x4,  PT_TP(sp)
>> +	REG_S x5,  PT_T0(sp)
>> +	REG_S x6,  PT_T1(sp)
>> +	REG_S x7,  PT_T2(sp)
>> +	REG_S x8,  PT_S0(sp)
>> +	REG_S x9,  PT_S1(sp)
>> +	REG_S x10, PT_A0(sp)
>> +	REG_S x11, PT_A1(sp)
>> +	REG_S x12, PT_A2(sp)
>> +	REG_S x13, PT_A3(sp)
>> +	REG_S x14, PT_A4(sp)
>> +	REG_S x15, PT_A5(sp)
>> +	REG_S x16, PT_A6(sp)
>> +	REG_S x17, PT_A7(sp)
>> +	REG_S x18, PT_S2(sp)
>> +	REG_S x19, PT_S3(sp)
>> +	REG_S x20, PT_S4(sp)
>> +	REG_S x21, PT_S5(sp)
>> +	REG_S x22, PT_S6(sp)
>> +	REG_S x23, PT_S7(sp)
>> +	REG_S x24, PT_S8(sp)
>> +	REG_S x25, PT_S9(sp)
>> +	REG_S x26, PT_S10(sp)
>> +	REG_S x27, PT_S11(sp)
>> +	REG_S x28, PT_T3(sp)
>> +	REG_S x29, PT_T4(sp)
>> +	REG_S x30, PT_T5(sp)
>> +	REG_S x31, PT_T6(sp)
>> +	/* Update fp is friendly for stacktrace */
>> +	addi  s0, sp, (PT_SIZE_ON_STACK)
>> +	j 1f
>> +
>> +SYM_ENTRY(optprobe_template_save, SYM_L_GLOBAL, SYM_A_NONE)
>> +	/*
>> +	 * Step1:
>> +	 * Filled with the pointer to optimized_kprobe data
>> +	 */
>> +	.dword 0
>> +1:
>> +	/* Load optimize_kprobe pointer from .dword below */
>> +	auipc a0, 0
>> +	REG_L a0, -8(a0)
>> +	add   a1, sp, x0
>> +
>> +SYM_ENTRY(optprobe_template_call, SYM_L_GLOBAL, SYM_A_NONE)
>> +	/*
>> +	 * Step2:
>> +	 * <IMME> of AUIPC/JALR are modified to the offset to optimized_callback
>> +	 * jump target is loaded from above .dword.
>> +	 */
>> +	auipc ra, 0
>> +	jalr  ra, 0(ra)
>> +
>> +	REG_L x1,  PT_RA(sp)
>> +	REG_L x3,  PT_GP(sp)
>> +	REG_L x4,  PT_TP(sp)
>> +	REG_L x5,  PT_T0(sp)
>> +	REG_L x6,  PT_T1(sp)
>> +	REG_L x7,  PT_T2(sp)
>> +	REG_L x8,  PT_S0(sp)
>> +	REG_L x9,  PT_S1(sp)
>> +	REG_L x10, PT_A0(sp)
>> +	REG_L x11, PT_A1(sp)
>> +	REG_L x12, PT_A2(sp)
>> +	REG_L x13, PT_A3(sp)
>> +	REG_L x14, PT_A4(sp)
>> +	REG_L x15, PT_A5(sp)
>> +	REG_L x16, PT_A6(sp)
>> +	REG_L x17, PT_A7(sp)
>> +	REG_L x18, PT_S2(sp)
>> +	REG_L x19, PT_S3(sp)
>> +	REG_L x20, PT_S4(sp)
>> +	REG_L x21, PT_S5(sp)
>> +	REG_L x22, PT_S6(sp)
>> +	REG_L x23, PT_S7(sp)
>> +	REG_L x24, PT_S8(sp)
>> +	REG_L x25, PT_S9(sp)
>> +	REG_L x26, PT_S10(sp)
>> +	REG_L x27, PT_S11(sp)
>> +	REG_L x28, PT_T3(sp)
>> +	REG_L x29, PT_T4(sp)
>> +	REG_L x30, PT_T5(sp)
>> +	REG_L x31, PT_T6(sp)
>> +	REG_L x2,  PT_SP(sp)
>> +	addi  sp, sp, (PT_SIZE_ON_STACK)
>> +
>> +SYM_ENTRY(optprobe_template_insn, SYM_L_GLOBAL, SYM_A_NONE)
>> +	/*
>> +	 * Step3:
>> +	 * NOPS will be replaced by the probed instruction, at worst case 3 RVC
>> +	 * and 1 RVI instructions is about to execute out of line.
>> +	 */
>> +	nop
> 
> A nop here will be either a compressed nop or a non-compressed,
> depending on the build (C-enabled or not), right? Maybe be explicit to
> the assembler what you want?
> 

You are right, if CONFIG_RISCV_ISA_C is disabled, two NOP is enough for 2 RVI execute out of line,
if CONFIG_RISCV_ISA_C is enabled, it needs eight C.NOP here for the worst case (3 RVC + 1 RVI).

I will use {C}.NOP explicitly for different configure in next revision, thanks.

> 
> Björn

-- 
BR,
Liao, Chang
