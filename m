Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019A765E222
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjAEBDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAEBCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:02:40 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAE012D35
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:02:39 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NnSR7612czRqtm;
        Thu,  5 Jan 2023 08:44:35 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 5 Jan 2023 08:46:08 +0800
Message-ID: <4062e65d-f411-bc01-d789-afee3c4b5b99@huawei.com>
Date:   Thu, 5 Jan 2023 08:46:07 +0800
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
 <088ed826-59a8-37a3-401e-2ed022a4a097@huawei.com>
 <87sfgqr7d4.fsf@all.your.base.are.belong.to.us>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <87sfgqr7d4.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/4 17:12, Björn Töpel 写道:
> "liaochang (A)" <liaochang1@huawei.com> writes:
> 
>>>> +SYM_ENTRY(optprobe_template_insn, SYM_L_GLOBAL, SYM_A_NONE)
>>>> +	/*
>>>> +	 * Step3:
>>>> +	 * NOPS will be replaced by the probed instruction, at worst case 3 RVC
>>>> +	 * and 1 RVI instructions is about to execute out of line.
>>>> +	 */
>>>> +	nop
>>>
>>> A nop here will be either a compressed nop or a non-compressed,
>>> depending on the build (C-enabled or not), right? Maybe be explicit to
>>> the assembler what you want?
>>>
>>
>> You are right, if CONFIG_RISCV_ISA_C is disabled, two NOP is enough for 2 RVI execute out of line,
>> if CONFIG_RISCV_ISA_C is enabled, it needs eight C.NOP here for the worst case (3 RVC + 1 RVI).
>>
>> I will use {C}.NOP explicitly for different configure in next revision, thanks.
> 
> What I meant was that "nop" can expand to compressed instructions, and
> you should be explicit. So you know how it's expanded by the
> compiler/assembler.
> 
> An example:
> 
> $ cat bar.S
> 	.text
> bar:
> 	nop
> 	nop
> $ riscv64-linux-gnu-gcc -O2 -o bar.o -c bar.S && riscv64-linux-gnu-objdump -M no-aliases -d bar.o
> 
> bar.o:     file format elf64-littleriscv
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <bar>:
>    0:	0001                	c.addi	zero,0
>    2:	0001                	c.addi	zero,0
> 
> 
> vs
> 
> $ cat foo.S
> 	.text
> foo:
> 	.option norvc
> 	nop
> 	nop
> 
> $ riscv64-linux-gnu-gcc -O2 -o foo.o -c foo.S && riscv64-linux-gnu-objdump -M no-aliases -d foo.o
> 
> foo.o:     file format elf64-littleriscv
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <foo>:
>    0:	00000013          	addi	zero,zero,0
>    4:	00000013          	addi	zero,zero,0

Above examples are very clear, i will use these expaned instructions in next revision, thanks.

> 
> 
> Björn

-- 
BR,
Liao, Chang
