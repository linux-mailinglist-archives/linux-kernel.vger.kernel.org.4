Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE79600A58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiJQJVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiJQJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:20:42 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1B2564D2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1665998359; bh=v44ikWgg3v6USRMa7ut40fJdxCgpB9At39IV4AILK28=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kxQPOJ4nM5uFk7j1SAKkHuaslzyNSwN+W3YDGKnrFpNpwQ5VKm83B0gRKR3aZEA5k
         rhDSmzKHKBp5DF6HKniAbxa+hYGrTbuae3lB06BOryrSdLClJn0p5ogtYr7mVjWIn4
         6F+IxqQAlK8Xo9NHpMu3ee6h8PACeE0ypNt9/TBc=
Received: from [100.100.57.122] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id ED9566008C;
        Mon, 17 Oct 2022 17:19:18 +0800 (CST)
Message-ID: <832d0a38-790f-fd2c-040f-533af22c5548@xen0n.name>
Date:   Mon, 17 Oct 2022 17:19:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:107.0)
 Gecko/20100101 Thunderbird/107.0a1
Subject: Re: [PATCH V2] LoongArch: Add unaligned access support
Content-Language: en-US
To:     Rui Wang <wangrui@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
References: <20221017022330.2383060-1-chenhuacai@loongson.cn>
 <CAHirt9jRBV_Err56c8TZXk2EkQHXmLayPHvRANinY-cXyvww=g@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAHirt9jRBV_Err56c8TZXk2EkQHXmLayPHvRANinY-cXyvww=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/17 16:59, Rui Wang wrote:
>> +void emulate_load_store_insn(struct pt_regs *regs, void __user *addr, unsigned int *pc)
>> +{
>> +       bool user = user_mode(regs);
>> +       unsigned int res;
>> +       unsigned long origpc;
>> +       unsigned long origra;
>> +       unsigned long value = 0;
>> +       union loongarch_instruction insn;
>> +
>> +       origpc = (unsigned long)pc;
>> +       origra = regs->regs[1];
>> +
>> +       perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, 0);
>> +
>> +       /*
>> +        * This load never faults.
>> +        */
>> +       __get_inst(&insn.word, pc, user);
>> +       if (user && !access_ok(addr, 8))
>> +               goto sigbus;
>> +
>> +       if (insn.reg2i12_format.opcode == ldd_op ||
>> +               insn.reg2i14_format.opcode == ldptrd_op ||
>> +               insn.reg3_format.opcode == ldxd_op) {
>> +               res = unaligned_read(addr, &value, 8, 1);
>> +               if (res)
>> +                       goto fault;
>> +               regs->regs[insn.reg2i12_format.rd] = value;
>> +       } else if (insn.reg2i12_format.opcode == ldw_op ||
>> +               insn.reg2i14_format.opcode == ldptrw_op ||
>> +               insn.reg3_format.opcode == ldxw_op) {
>> +               res = unaligned_read(addr, &value, 4, 1);
>> +               if (res)
>> +                       goto fault;
>> +               regs->regs[insn.reg2i12_format.rd] = value;
>> +       } else if (insn.reg2i12_format.opcode == ldwu_op ||
>> +               insn.reg3_format.opcode == ldxwu_op) {
>> +               res = unaligned_read(addr, &value, 4, 0);
>> +               if (res)
>> +                       goto fault;
>> +               regs->regs[insn.reg2i12_format.rd] = value;
>> +       } else if (insn.reg2i12_format.opcode == ldh_op ||
>> +               insn.reg3_format.opcode == ldxh_op) {
>> +               res = unaligned_read(addr, &value, 2, 1);
>> +               if (res)
>> +                       goto fault;
>> +               regs->regs[insn.reg2i12_format.rd] = value;
>> +       } else if (insn.reg2i12_format.opcode == ldhu_op ||
>> +               insn.reg3_format.opcode == ldxhu_op) {
>> +               res = unaligned_read(addr, &value, 2, 0);
>> +               if (res)
>> +                       goto fault;
>> +               regs->regs[insn.reg2i12_format.rd] = value;
>> +       } else if (insn.reg2i12_format.opcode == std_op ||
>> +               insn.reg2i14_format.opcode == stptrd_op ||
>> +               insn.reg3_format.opcode == stxd_op) {
>> +               value = regs->regs[insn.reg2i12_format.rd];
>> +               res = unaligned_write(addr, value, 8);
>> +               if (res)
>> +                       goto fault;
>> +       } else if (insn.reg2i12_format.opcode == stw_op ||
>> +               insn.reg2i14_format.opcode == stptrw_op ||
>> +               insn.reg3_format.opcode == stxw_op) {
>> +               value = regs->regs[insn.reg2i12_format.rd];
>> +               res = unaligned_write(addr, value, 4);
>> +               if (res)
>> +                       goto fault;
>> +       } else if (insn.reg2i12_format.opcode == sth_op ||
>> +               insn.reg3_format.opcode == stxh_op) {
>> +               value = regs->regs[insn.reg2i12_format.rd];
>> +               res = unaligned_write(addr, value, 2);
>> +               if (res)
>> +                       goto fault;
>> +       } else if (insn.reg2i12_format.opcode == fldd_op ||
>> +               insn.reg3_format.opcode == fldxd_op) {
>> +               res = unaligned_read(addr, &value, 8, 1);
>> +               if (res)
>> +                       goto fault;
>> +               write_fpr(insn.reg2i12_format.rd, value);
>> +       } else if (insn.reg2i12_format.opcode == flds_op ||
>> +               insn.reg3_format.opcode == fldxs_op) {
>> +               res = unaligned_read(addr, &value, 4, 1);
>> +               if (res)
>> +                       goto fault;
>> +               write_fpr(insn.reg2i12_format.rd, value);
>> +       } else if (insn.reg2i12_format.opcode == fstd_op ||
>> +               insn.reg3_format.opcode == fstxd_op) {
>> +               value = read_fpr(insn.reg2i12_format.rd);
>> +               res = unaligned_write(addr, value, 8);
>> +               if (res)
>> +                       goto fault;
>> +       } else if (insn.reg2i12_format.opcode == fsts_op ||
>> +               insn.reg3_format.opcode == fstxs_op) {
>> +               value = read_fpr(insn.reg2i12_format.rd);
>> +               res = unaligned_write(addr, value, 4);
>> +               if (res)
>> +                       goto fault;
>> +       } else
>> +               goto sigbus;
> 
> So many condtional branches for linear instruction matching, use
> switch case is better?
> 
> 0000000000000238 <emulate_load_store_insn>:
> ...
>   35c:    1470180f     lu12i.w         $t3, 229568(0x380c0)
>   360:    580141af     beq             $t1, $t3, 320(0x140)    # 4a0
> <emulate_load_store_insn+0x268>
>   364:    1451000f     lu12i.w         $t3, 165888(0x28800)
>   368:    5801dd8f     beq             $t0, $t3, 476(0x1dc)    # 544
> [snip]

The code structure here is basically several switches intermingled with 
each other, each matching opcodes for one insn format, but sharing much 
code once matched. Quite difficult to express with C without some kind 
of code duplication.

But we can try:

{
	int size;
	bool is_read, is_signed;

	switch (insn.reg2i12_format.opcode) {
	case ldd_op:
		size = 8;
		is_read = true;
		is_signed = true;
		break;

	case std_op:
		size = 8;
		is_read = false;
		value = regs->regs[insn.reg2i12_format.rd];
		break;

	case ldw_op:
		size = 4;
		is_read = true;
		is_signed = true;
		break;

	case ldwu_op:
		size = 4;
		is_read = true;
		is_signed = false;
		break;

	/* other opcodes */

	default:
		/* not 2RI12 */
		break;
	}

	switch (insn.reg2i14_format.opcode) {
	case ldptrd_op:
		size = 8;
		is_read = true;
		is_signed = true;
		break;

	case ldptrw_op:
		size = 4;
		is_read = true;
		is_signed = true;
		break;

	// ...
	}

	// other formats

	if (!size) {
		/* no match */
		goto sigbus;
	}

	if (is_read)
		res = unaligned_read(addr, &value, size, is_signed);
	else
		res = unaligned_write(addr, value, size);

	if (res)
		goto fault;

	// ...
}

This way at least the data flow is clearer, and probably the codegen 
quality would benefit as well due to the clearer switch-case structures. 
(It's okay if this is not the case, it's not performance-critical anyway 
because if we ever hit this at all, performance would have already tanked.)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

