Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3245D66A9B2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 07:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjANGlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 01:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjANGkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 01:40:43 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BE984694
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 22:40:32 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8CxYvBeTsJjtpoBAA--.5628S3;
        Sat, 14 Jan 2023 14:40:30 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxjb5cTsJjIk0ZAA--.50993S3;
        Sat, 14 Jan 2023 14:40:29 +0800 (CST)
Subject: Re: [PATCH 2/4] LoongArch: Add JUMP_LINK_ADDR macro implementation to
 avoid using la.abs
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <1673255274-18238-1-git-send-email-tangyouling@loongson.cn>
 <1673255274-18238-3-git-send-email-tangyouling@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <c54bc8ac-fcc2-1cd4-56bc-167b094aec45@loongson.cn>
Date:   Sat, 14 Jan 2023 14:40:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1673255274-18238-3-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxjb5cTsJjIk0ZAA--.50993S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ur1Dtw4DAw47Zw1ktF4Utwb_yoW8Kw1rpr
        n0vF1kGa18WFs7AFy5Kw17ur4DX3Z7Ca1ag3Zrt34Ikr4aqryvvw10kr4DXF1Dt3yrGr40
        9F1Sgw4Sqa1UJa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-01-09 17:07, Youling Tang wrote:
> Add JUMP_LINK_ADDR macro implementation to avoid using la.abs.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>   arch/loongarch/include/asm/stackframe.h |  8 ++++++++
>   arch/loongarch/kernel/head.S            | 10 ++++------
>   arch/loongarch/power/suspend_asm.S      |  5 ++---
>   3 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
> index 96c94035b5d0..f538b3a6d680 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -216,4 +216,12 @@
>   	RESTORE_SP_AND_RET \docfi
>   	.endm
>   
> +/* Jump to the virtual address of the link. */
> +	.macro JUMP_LINK_ADDR

Hi, Youling


IMHO the JUMP_CACHE_ADDR is more suitable. And it not clear higt bits,
although the result always true currently. Lastly, this macro clobbers
t0 and t1, I'd suggest pass them in as args.


Thanks,

Jinyang

> +	li.d	t0, CACHE_BASE
> +	pcaddi	t1, 0
> +	or	t0, t0, t1
> +	jirl	zero, t0, 0xc
> +	.endm
> +
>   #endif /* _ASM_STACKFRAME_H */
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index aa6181714ec3..e8a4bf9d7599 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -52,9 +52,8 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
>   
>   	/* We might not get launched at the address the kernel is linked to,
>   	   so we jump there.  */
> -	la.abs		t0, 0f
> -	jr		t0
> -0:
> +	JUMP_LINK_ADDR
> +
>   	/* Enable PG */
>   	li.w		t0, 0xb0		# PLV=0, IE=0, PG=1
>   	csrwr		t0, LOONGARCH_CSR_CRMD
> @@ -106,9 +105,8 @@ SYM_CODE_START(smpboot_entry)
>   	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
>   	csrwr		t0, LOONGARCH_CSR_DMWIN1
>   
> -	la.abs		t0, 0f
> -	jr		t0
> -0:
> +	JUMP_LINK_ADDR
> +
>   	/* Enable PG */
>   	li.w		t0, 0xb0		# PLV=0, IE=0, PG=1
>   	csrwr		t0, LOONGARCH_CSR_CRMD
> diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/suspend_asm.S
> index eb2675642f9f..596a682a7924 100644
> --- a/arch/loongarch/power/suspend_asm.S
> +++ b/arch/loongarch/power/suspend_asm.S
> @@ -78,9 +78,8 @@ SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
>   	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
>   	csrwr		t0, LOONGARCH_CSR_DMWIN1
>   
> -	la.abs		t0, 0f
> -	jr		t0
> -0:
> +	JUMP_LINK_ADDR
> +
>   	la.pcrel	t0, acpi_saved_sp
>   	ld.d		sp, t0, 0
>   	SETUP_WAKEUP

