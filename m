Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758976DA7B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbjDGCaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDGCah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:30:37 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D59D07ED0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:30:34 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8AxJDRJgC9kI6sXAA--.37445S3;
        Fri, 07 Apr 2023 10:30:33 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxib1HgC9kU8UXAA--.21810S3;
        Fri, 07 Apr 2023 10:30:32 +0800 (CST)
Subject: Re: [RFC PATCH 2/3] LoongArch: Add larch_insn_gen_break() to generate
 break insn
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
References: <1680833701-1727-1-git-send-email-yangtiezhu@loongson.cn>
 <1680833701-1727-3-git-send-email-yangtiezhu@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <0d309725-3b91-6902-de67-08bda48ccf57@loongson.cn>
Date:   Fri, 7 Apr 2023 10:30:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1680833701-1727-3-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dxib1HgC9kU8UXAA--.21810S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWrZry8uw1UXr1xAFyDGrW3KFg_yoW8Jr4kpF
        nFyF1kXrs5WrykGr9rJw4DZr1Fqws5urWqga15C3yfCrW3XwsIqr92grZFyF90kw4qkay0
        qFnrWFW0v3WxAFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bO8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E
        6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWrMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7xRE6wZ7
        UUUUU==
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/* snip */

> diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
> index 08c78d2..a5c3712 100644
> --- a/arch/loongarch/kernel/kprobes.c
> +++ b/arch/loongarch/kernel/kprobes.c
> @@ -4,19 +4,8 @@
>  #include <linux/preempt.h>
>  #include <asm/break.h>
>
> -static const union loongarch_instruction breakpoint_insn = {
> -	.reg0i15_format = {
> -		.opcode = break_op,
> -		.immediate = BRK_KPROBE_BP,
> -	}
> -};
> -
> -static const union loongarch_instruction singlestep_insn = {
> -	.reg0i15_format = {
> -		.opcode = break_op,
> -		.immediate = BRK_KPROBE_SSTEPBP,
> -	}
> -};
> +#define breakpoint_insn larch_insn_gen_break(BRK_KPROBE_BP)
> +#define singlestep_insn larch_insn_gen_break(BRK_KPROBE_SSTEPBP)

IMO, Defined as KPROBE_BP_INSN, KPROBE_SSTEPBP_INSN may be better.

Youling.
>
>  DEFINE_PER_CPU(struct kprobe *, current_kprobe);
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> @@ -253,7 +242,7 @@ bool kprobe_breakpoint_handler(struct pt_regs *regs)
>  		}
>  	}
>
> -	if (addr->word != breakpoint_insn.word) {
> +	if (*addr != breakpoint_insn) {
>  		/*
>  		 * The breakpoint instruction was removed right
>  		 * after we hit it.  Another cpu has removed
>

