Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886AC65CE68
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjADIff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjADIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:35:07 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB257186AA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:35:05 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nn2q45Xy6zqTLw;
        Wed,  4 Jan 2023 16:30:24 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 16:35:03 +0800
Message-ID: <ab66152d-0ae1-3edb-4f1d-01ab49edc25d@huawei.com>
Date:   Wed, 4 Jan 2023 16:35:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 4/9] riscv/kprobe: Add common RVI and RVC instruction
 decoder code
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-5-chenguokai17@mails.ucas.ac.cn>
 <87tu18vmnx.fsf@all.your.base.are.belong.to.us>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <87tu18vmnx.fsf@all.your.base.are.belong.to.us>
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



在 2023/1/3 2:03, Björn Töpel 写道:
> Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:
> 
>> From: Liao Chang <liaochang1@huawei.com>
> 
>> diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
>> index cb6ff7dccb92..74d8c1ba9064 100644
>> --- a/arch/riscv/kernel/probes/simulate-insn.h
>> +++ b/arch/riscv/kernel/probes/simulate-insn.h
>> @@ -37,6 +37,40 @@ __RISCV_INSN_FUNCS(c_jalr,	0xf007, 0x9002);
>>  __RISCV_INSN_FUNCS(c_beqz,	0xe003, 0xc001);
>>  __RISCV_INSN_FUNCS(c_bnez,	0xe003, 0xe001);
>>  __RISCV_INSN_FUNCS(c_ebreak,	0xffff, 0x9002);
>> +/* RVC(S) instructions contain rs1 and rs2 */
>> +__RISCV_INSN_FUNCS(c_sq,	0xe003, 0xa000);
>> +__RISCV_INSN_FUNCS(c_sw,	0xe003, 0xc000);
>> +__RISCV_INSN_FUNCS(c_sd,	0xe003, 0xe000);
>> +/* RVC(A) instructions contain rs1 and rs2 */
>> +__RISCV_INSN_FUNCS(c_sub,	0xfc03, 0x8c01);
> 
> Incorrect mask.

Thanks for checking, i study the opcode of C_SUB [1], the correct mask should be 0xFC63.

      15 14 13 12 | 11 10  9  8 | 7 6 5 4 | 3 2  1 0
c.sub:       1  0  0  0 |  1  1  rs1'/rd' 0 0   rs2'   0 1
mask:           F |           C |       6 |        3
value:          8 |           C |       0 |        1

> 
>> +__RISCV_INSN_FUNCS(c_subw,	0xfc43, 0x9c01);
>> +/* RVC(L) instructions contain rs1 */
>> +__RISCV_INSN_FUNCS(c_lq,	0xe003, 0x2000);
>> +__RISCV_INSN_FUNCS(c_lw,	0xe003, 0x4000);
>> +__RISCV_INSN_FUNCS(c_ld,	0xe003, 0x6000);
>> +/* RVC(I) instructions contain rs1 */
>> +__RISCV_INSN_FUNCS(c_addi,	0xe003, 0x0001);
>> +__RISCV_INSN_FUNCS(c_addiw,	0xe003, 0x2001);
>> +__RISCV_INSN_FUNCS(c_addi16sp,	0xe183, 0x6101);
>> +__RISCV_INSN_FUNCS(c_slli,	0xe003, 0x0002);
>> +/* RVC(B) instructions contain rs1 */
>> +__RISCV_INSN_FUNCS(c_sri,	0xe803, 0x8001);
>> +__RISCV_INSN_FUNCS(c_andi,	0xec03, 0x8801);
>> +/* RVC(SS) instructions contain rs2 */
>> +__RISCV_INSN_FUNCS(c_sqsp,	0xe003, 0xa002);
>> +__RISCV_INSN_FUNCS(c_swsp,	0xe003, 0xc002);
>> +__RISCV_INSN_FUNCS(c_sdsp,	0xe003, 0xe002);
>> +/* RVC(R) instructions contain rs2 and rd */
>> +__RISCV_INSN_FUNCS(c_mv,	0xe003, 0x8002);
> 
> Shouldn't the mask be 0xf003?

Actually, the mask should be 0xf003 indeedly, but it also bring another problem that
it can't tell C.MV and C.JR via the mask and value parts. Look opcodes below:

      15 14 13 12 | 11 10  9  8 | 7 6 5 4 | 3 2  1 0
C.JR:  1  0  0  0 |             rs1           0  1 0
C.MV:  1  0  0  0 |              rd         rs2  1 0

The only differece between C.MV and C.JR is the bits[2~6], these bitfield of C.JR is zero,
the ones of C.MV is rs2 which never be zero. In order to tell C.MV and C.JR correclty, it
is better to adjust the mask of C.JR to be 0xf07f as your patch(riscv, kprobe: Stricter c.jr/c.jalr decoding)

Looking forward to your feedback.

> 
> 
> Björn


[1] https://github.com/riscv/riscv-isa-manual/releases

-- 
BR,
Liao, Chang
