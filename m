Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F576005F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 06:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJQEWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 00:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJQEWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 00:22:10 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 996024A123
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:22:08 -0700 (PDT)
Received: from [10.136.12.12] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx32tp2ExjT2cwAA--.33832S3;
        Mon, 17 Oct 2022 12:22:02 +0800 (CST)
Subject: Re: [PATCH V2] LoongArch: Add unaligned access support
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
References: <20221017022330.2383060-1-chenhuacai@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <67d9acd0-692f-95d4-2c92-4e43e1d0100c@loongson.cn>
Date:   Mon, 17 Oct 2022 12:22:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221017022330.2383060-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bx32tp2ExjT2cwAA--.33832S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4UWw1fCw15Kr1kKFWfZrb_yoW8Wr4Upa
        yrGa4DKa9FqryxZF1UJw1Dt34FgrnrJr9IkrsxJrZ8Zr18CFnavFyfur1xXrsxKr9rWF1Y
        qa4aq3yfur4DKFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUU
        U==
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai,


On 2022/10/17 上午10:23, Huacai Chen wrote:
> [...]
> +	default:
> +		panic("unexpected fd '%d'", fd);
Due to the optimization of gcc, the panic() is unused actually and leave
the symbol 'read/write_fpr' in vmlinux. Maybe we can use unreachable() and

always_inline.

> [...]
> +
> +fault:
> +	/* roll back jump/branch */
> +	regs->csr_era = origpc;
> +	regs->regs[1] = origra;

I'm not sure where the csr_era and regs[1] was damaged...

> [...]
>
> +/*
> + * unsigned long unaligned_read(void *addr, void *value, unsigned long n, bool sign)
> + *
> + * a0: addr
> + * a1: value
> + * a2: n
> + * a3: sign
> + */
> +SYM_FUNC_START(unaligned_read)
> +	beqz	a2, 5f
> +
> +	li.w	t1, 8
IMHO we can avoid the constant reg t1.
> +	li.w	t2, 0
> +
> +	addi.d	t0, a2, -1
> +	mul.d	t1, t0, t1
> +	add.d 	a0, a0, t0
> +
> +	beq	a3, zero, 2f
beqz
> +1:	ld.b	t3, a0, 0
> +	b	3f
> +
> +2:	ld.bu	t3, a0, 0
> +3:	sll.d	t3, t3, t1
> +	or	t2, t2, t3
> +	addi.d	t1, t1, -8
> +	addi.d	a0, a0, -1
> +	addi.d	a2, a2, -1
> +	bgt	a2, zero, 2b
bgtz
> +4:	st.d	t2, a1, 0
> +
> +	move	a0, a2
> +	jr	ra
> +
> +5:	li.w    a0, -EFAULT
> +	jr	ra
> +
> +	fixup_ex 1, 6, 1
> +	fixup_ex 2, 6, 0
> +	fixup_ex 4, 6, 0
> +SYM_FUNC_END(unaligned_read)
> +
> +/*
> + * unsigned long unaligned_write(void *addr, unsigned long value, unsigned long n)
> + *
> + * a0: addr
> + * a1: value
> + * a2: n
> + */
> +SYM_FUNC_START(unaligned_write)
> +	beqz	a2, 3f
> +
> +	li.w	t0, 0
> +1:	srl.d	t1, a1, t0
> +2:	st.b	t1, a0, 0
> +	addi.d	t0, t0, 8
> +	addi.d	a2, a2, -1
> +	addi.d	a0, a0, 1
> +	bgt	a2, zero, 1b
bgtz
> +
> +	move	a0, a2
> +	jr	ra
> +
> +3:	li.w    a0, -EFAULT
> +	jr	ra
> +
> +	fixup_ex 2, 4, 1
> +SYM_FUNC_END(unaligned_write)

Thanks,

Jinyang

