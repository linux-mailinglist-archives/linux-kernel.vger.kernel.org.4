Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0302973F8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjF0J3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjF0J3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:29:34 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F6931734;
        Tue, 27 Jun 2023 02:29:32 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8BxlfD6q5pkWgUDAA--.4775S3;
        Tue, 27 Jun 2023 17:29:30 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxniP5q5pkwcULAA--.7400S3;
        Tue, 27 Jun 2023 17:29:29 +0800 (CST)
Message-ID: <b0a6db96-1062-ce90-f8da-b9866b3c8166@loongson.cn>
Date:   Tue, 27 Jun 2023 17:29:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 5/8] LoongArch: Simplify the invtlb wrappers
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
References: <20230625095644.3156349-1-kernel@xen0n.name>
 <20230625095644.3156349-6-kernel@xen0n.name>
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <20230625095644.3156349-6-kernel@xen0n.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxniP5q5pkwcULAA--.7400S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr1UCr1xCw17JF4xCr17Arc_yoW5tw4fpF
        y3CF47KFs7tF1fWa97Jr1vvr43Jrn8G34SvF9IgFnYkF1DX340grs8Ar4qyry5Ja9YyrW7
        ZF4Yyry5uFsYv3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn
        UUUUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/25 17:56, WANG Xuerui 写道:
> From: WANG Xuerui <git@xen0n.name>
> 
> The invtlb instruction has been supported by upstream LoongArch
> toolchains from day one, so ditch the raw opcode trickery and just use
> plain inline asm for it.
> 
> While at it, also make the invtlb asm statements barriers, for proper
> modeling of the side effects. The functions are also marked as
> __always_inline instead of just "inline", because they cannot work at
> all if not inlined: the op argument will not be compile-time const in
> that case, thus failing to satisfy the "i" constraint.
> 
> The signature of the other more specific invtlb wrappers contain unused
> arguments right now, but these are not removed right away in order for
> the patch to be focused. In the meantime, assertions are added to ensure
> no accidental misuse happens before the refactor. (The more specific
> wrappers cannot re-use the generic invtlb wrapper, because the ISA
> manual says $zero shall be used in case a particular op does not take
> the respective argument: re-using the generic wrapper would mean losing
> control over the register usage.)
> 
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>  arch/loongarch/include/asm/tlb.h | 43 ++++++++++++++------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/tlb.h b/arch/loongarch/include/asm/tlb.h
> index 0dc9ee2b05d2..da7a3b5b9374 100644
> --- a/arch/loongarch/include/asm/tlb.h
> +++ b/arch/loongarch/include/asm/tlb.h
> @@ -88,52 +88,47 @@ enum invtlb_ops {
>  	INVTLB_GID_ADDR = 0x16,
>  };
>  
> -/*
> - * invtlb op info addr
> - * (0x1 << 26) | (0x24 << 20) | (0x13 << 15) |
> - * (addr << 10) | (info << 5) | op
> - */
> -static inline void invtlb(u32 op, u32 info, u64 addr)
> +static __always_inline void invtlb(u32 op, u32 info, u64 addr)
>  {
>  	__asm__ __volatile__(
> -		"parse_r addr,%0\n\t"
> -		"parse_r info,%1\n\t"
> -		".word ((0x6498000) | (addr << 10) | (info << 5) | %2)\n\t"
> -		:
> -		: "r"(addr), "r"(info), "i"(op)
> +		"invtlb %0, %1, %2\n\t"
>  		:
> +		: "i"(op), "r"(info), "r"(addr)
> +		: "memory"
>  		);
>  }
>  
> -static inline void invtlb_addr(u32 op, u32 info, u64 addr)
> +static __always_inline void invtlb_addr(u32 op, u32 info, u64 addr)
>  {
> +	BUILD_BUG_ON(!__builtin_constant_p(info) || info != 0);
>  	__asm__ __volatile__(
> -		"parse_r addr,%0\n\t"
> -		".word ((0x6498000) | (addr << 10) | (0 << 5) | %1)\n\t"
> -		:
> -		: "r"(addr), "i"(op)
> +		"invtlb %0, $zero, %1\n\t"
>  		:
> +		: "i"(op), "r"(addr)
> +		: "memory"
>  		);
>  }
>  
> -static inline void invtlb_info(u32 op, u32 info, u64 addr)
> +static __always_inline void invtlb_info(u32 op, u32 info, u64 addr)
>  {
> +	BUILD_BUG_ON(!__builtin_constant_p(addr) || addr != 0);
>  	__asm__ __volatile__(
> -		"parse_r info,%0\n\t"
> -		".word ((0x6498000) | (0 << 10) | (info << 5) | %1)\n\t"
> -		:
> -		: "r"(info), "i"(op)
> +		"invtlb %0, %1, $zero\n\t"
>  		:
> +		: "i"(op), "r"(info)
> +		: "memory"
>  		);
>  }
macro parse_r is not used here, and it is not used any more.
Can you remove definition of this macro also?

Regards
Bibo Mao

>  
> -static inline void invtlb_all(u32 op, u32 info, u64 addr)
> +static __always_inline void invtlb_all(u32 op, u32 info, u64 addr)
>  {
> +	BUILD_BUG_ON(!__builtin_constant_p(info) || info != 0);
> +	BUILD_BUG_ON(!__builtin_constant_p(addr) || addr != 0);
>  	__asm__ __volatile__(
> -		".word ((0x6498000) | (0 << 10) | (0 << 5) | %0)\n\t"
> +		"invtlb %0, $zero, $zero\n\t"
>  		:
>  		: "i"(op)
> -		:
> +		: "memory"
>  		);
>  }
>  

