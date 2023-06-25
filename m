Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728FE73CE3B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 05:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjFYDRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 23:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFYDRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 23:17:17 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F0DDE77;
        Sat, 24 Jun 2023 20:17:14 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8BxHMe2sZdkb2gBAA--.2135S3;
        Sun, 25 Jun 2023 11:17:10 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxWM22sZdknSQGAA--.30049S3;
        Sun, 25 Jun 2023 11:17:10 +0800 (CST)
Message-ID: <70dfa38f-7bb7-6d67-1a27-9e5eb30945b6@loongson.cn>
Date:   Sun, 25 Jun 2023 11:17:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/9] LoongArch: Simplify the invtlb wrappers
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
References: <20230624184055.3000636-1-kernel@xen0n.name>
 <20230624184055.3000636-6-kernel@xen0n.name>
Content-Language: en-US
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <20230624184055.3000636-6-kernel@xen0n.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxWM22sZdknSQGAA--.30049S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF13AF1kKFy3JF18GF1xWFX_yoW5Zw15pF
        9xCF4akF4ktF1fuF97Jr1vvr4ayr15Kw4SvF93KF9ayFnrXw1Iqrs8AF4qyry5JayrArW7
        XF4Yv3W5uFsYvwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
        CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALU
        UUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/25 02:40, WANG Xuerui 写道:
> From: WANG Xuerui <git@xen0n.name>
> 
> The invtlb instruction has been supported by upstream LoongArch
> toolchains from day one, so ditch the raw opcode trickery and just use
> plain inline asm for it.
> 
> While at it, also make the invtlb asm statements barriers, for proper
> modeling of the side effects.
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
>  arch/loongarch/include/asm/tlb.h | 39 ++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/tlb.h b/arch/loongarch/include/asm/tlb.h
> index 0dc9ee2b05d2..15750900540c 100644
> --- a/arch/loongarch/include/asm/tlb.h
> +++ b/arch/loongarch/include/asm/tlb.h
> @@ -88,52 +88,51 @@ enum invtlb_ops {
>  	INVTLB_GID_ADDR = 0x16,
>  };
>  
> -/*
> - * invtlb op info addr
> - * (0x1 << 26) | (0x24 << 20) | (0x13 << 15) |
> - * (addr << 10) | (info << 5) | op
> - */
>  static inline void invtlb(u32 op, u32 info, u64 addr)
>  {
inline function is not assured, it may be general function so op is
not constant in this situation. Had better define it as macro or change
inline as __always_inline.

Regards
Bibo Mao

> +	BUILD_BUG_ON(!__builtin_constant_p(op));
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
>  static inline void invtlb_addr(u32 op, u32 info, u64 addr)
>  {
> +	BUILD_BUG_ON(!__builtin_constant_p(op));
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
>  static inline void invtlb_info(u32 op, u32 info, u64 addr)
>  {
> +	BUILD_BUG_ON(!__builtin_constant_p(op));
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
>  
>  static inline void invtlb_all(u32 op, u32 info, u64 addr)
>  {
> +	BUILD_BUG_ON(!__builtin_constant_p(op));
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

