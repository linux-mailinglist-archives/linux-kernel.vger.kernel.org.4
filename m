Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD97765CE69
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjADIfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjADIfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:35:19 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B917D1A042
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:35:18 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nn2tx0qM5zRqny;
        Wed,  4 Jan 2023 16:33:45 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 16:35:16 +0800
Message-ID: <a00f788b-3799-4dcd-0401-846159e151c4@huawei.com>
Date:   Wed, 4 Jan 2023 16:35:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 6/9] riscv/kprobe: Add code to check if kprobe can be
 optimized
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-7-chenguokai17@mails.ucas.ac.cn>
 <87sfgsvmnj.fsf@all.your.base.are.belong.to.us>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <87sfgsvmnj.fsf@all.your.base.are.belong.to.us>
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
>> index a0d2ab39e3fa..258a283c906d 100644
>> --- a/arch/riscv/kernel/probes/opt.c
>> +++ b/arch/riscv/kernel/probes/opt.c
>> @@ -271,15 +271,103 @@ static void find_free_registers(struct kprobe *kp, struct optimized_kprobe *op,
>>  	*ra = (kw == 1UL) ? 0 : __builtin_ctzl(kw & ~1UL);
>>  }
>>  
>> +static bool insn_jump_into_range(unsigned long addr, unsigned long start,
>> +				 unsigned long end)
>> +{
>> +	kprobe_opcode_t insn = *(kprobe_opcode_t *)addr;
>> +	unsigned long target, offset = GET_INSN_LENGTH(insn);
>> +
>> +#ifdef CONFIG_RISCV_ISA_C
>> +	if (offset == RVC_INSN_LEN) {
>> +		if (riscv_insn_is_c_beqz(insn) || riscv_insn_is_c_bnez(insn))
>> +			target = addr + rvc_branch_imme(insn);
>> +		else if (riscv_insn_is_c_jal(insn) || riscv_insn_is_c_j(insn))
>> +			target = addr + rvc_jal_imme(insn);
>> +		else
>> +			target = 0;
>> +		return (target >= start) && (target < end);
>> +	}
>> +#endif
>> +
>> +	if (riscv_insn_is_branch(insn))
>> +		target = addr + rvi_branch_imme(insn);
>> +	else if (riscv_insn_is_jal(insn))
>> +		target = addr + rvi_jal_imme(insn);
>> +	else
>> +		target = 0;
>> +	return (target >= start) && (target < end);
>> +}
>> +
>> +static int search_copied_insn(unsigned long paddr, struct optimized_kprobe *op)
>> +{
>> +	int i =  1;
>> +	unsigned long offset = GET_INSN_LENGTH(*(kprobe_opcode_t *)paddr);
>> +
>> +	while ((i++ < MAX_COPIED_INSN) && (offset < 2 * RVI_INSN_LEN)) {
>> +		if (riscv_probe_decode_insn((probe_opcode_t *)paddr + offset,
>> +					    NULL) != INSN_GOOD)
> 
> If the second argument is NULL, and the insn is auipc, we'll splat with
> NULL-ptr exception.

Good catch, it is my fault to ignore the access to second argument in macro RISCV_INSN_SET_SIMULATE.

> 
> Hmm, probe_opcode_t is u32, right? And GET_INSN_LENGTH() returns 4 or 2
> ...then the pointer arithmetic will be a mess?

Hmm, This pointer arithemtic does make no sense here, i had debugged this function on QEMU step by step,
and it work well. Anyway, i will go through this function again, thanks.

> 
> 
> Björn

-- 
BR,
Liao, Chang
