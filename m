Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709C56CD109
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjC2EJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2EJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:09:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96589C4;
        Tue, 28 Mar 2023 21:09:00 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxxtjauSNk6IgTAA--.29875S3;
        Wed, 29 Mar 2023 12:08:58 +0800 (CST)
Received: from [10.130.0.102] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxeb3WuSNkgBcQAA--.10240S3;
        Wed, 29 Mar 2023 12:08:56 +0800 (CST)
Subject: Re: [PATCH v8 7/8] LoongArch: ftrace: Enable
 HAVE_FUNCTION_GRAPH_RETVAL
To:     Donglin Peng <pengdonglin@sangfor.com.cn>, mhiramat@kernel.org,
        rostedt@goodmis.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        chenhuacai@kernel.org, kernel@xen0n.name, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com
Cc:     linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230328134319.2185812-1-pengdonglin@sangfor.com.cn>
 <20230328134319.2185812-8-pengdonglin@sangfor.com.cn>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <28389252-4611-977f-ab80-baeca99d9080@loongson.cn>
Date:   Wed, 29 Mar 2023 12:08:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230328134319.2185812-8-pengdonglin@sangfor.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxeb3WuSNkgBcQAA--.10240S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF4UKrWUCr17WF43CFW5GFg_yoWrCryrpr
        ZrA3WkGrWvgFs3Cryav34rWr98Arn3G34a9F9rtr9YkrnIgr15uw10yryDXFyvq3y8GrWv
        9F4Fkr4aya1DXa7anT9S1TB71UUUU17qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jCMKZUUUUU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Donglin

On 2023/3/28 下午9:43, Donglin Peng wrote:
> The commit d4815c5d1bbd ("function_graph: Support recording and
> printing the return value of function") laid the groundwork for the
> for the funcgraph-retval, and this modification makes it available
> on the LoongArch platform.
> 
> We introduce a new structure called fgraph_ret_regs for the LoongArch
> platform to hold return registers and the frame pointer. We then fill
> its content in the return_to_handler and pass its address to the
> function ftrace_return_to_handler to record the return value.
> 
> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
> ---
> v8:
>   - Modify the control range of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
> ---
>   arch/loongarch/Kconfig              |  1 +
>   arch/loongarch/include/asm/ftrace.h | 18 ++++++++++++++++++
>   arch/loongarch/kernel/mcount.S      |  6 ++++--
>   arch/loongarch/kernel/mcount_dyn.S  |  7 ++++---
>   4 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 7fd51257e0ed..4bf60132869b 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -99,6 +99,7 @@ config LOONGARCH
>   	select HAVE_FAST_GUP
>   	select HAVE_FTRACE_MCOUNT_RECORD
>   	select HAVE_FUNCTION_ARG_ACCESS_API
> +	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>   	select HAVE_FUNCTION_GRAPH_TRACER
>   	select HAVE_FUNCTION_TRACER
>   	select HAVE_GENERIC_VDSO
> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
> index 3418d32d4fc7..433c6218888b 100644
> --- a/arch/loongarch/include/asm/ftrace.h
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -63,4 +63,22 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>   
>   #endif /* CONFIG_FUNCTION_TRACER */
>   
> +#ifndef __ASSEMBLY__
> +struct fgraph_ret_regs {
> +	unsigned long a0;
> +	unsigned long a1;
> +	unsigned long fp;
> +};

This overall looks good, but some places need attention:

This will need to be padded to 16 bytes, as within the kernel,
loongarch requires the SP to be aligned to 16 bytes at all time.
Please can you add an `__unused/padding` field to ensure.
> +
> +static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
> +{
> +	return ret_regs->a0;
> +}
> +
> +static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
> +{
> +	return ret_regs->fp;
> +}
> +#endif
> +
>   #endif /* _ASM_LOONGARCH_FTRACE_H */
> diff --git a/arch/loongarch/kernel/mcount.S b/arch/loongarch/kernel/mcount.S
> index 8cdc1563cd33..3e405c0212c0 100644
> --- a/arch/loongarch/kernel/mcount.S
> +++ b/arch/loongarch/kernel/mcount.S
> @@ -79,10 +79,12 @@ SYM_FUNC_START(ftrace_graph_caller)
>   SYM_FUNC_END(ftrace_graph_caller)
>   
>   SYM_FUNC_START(return_to_handler)
> -	PTR_ADDI	sp, sp, -2 * SZREG
> +	PTR_ADDI	sp, sp, -3 * SZREG
As above, this will need to be padded to keep the stack aligned to 16
bytes.
	PTR_ADDI	sp, sp, -4 * SZREG

>   	PTR_S		a0, sp, 0
>   	PTR_S		a1, sp, SZREG
> +	PTR_S		zero, sp, 2 * SZREG
>   
> +	move		a0, sp
>   	bl		ftrace_return_to_handler
>   
>   	/* Restore the real parent address: a0 -> ra */
> @@ -90,7 +92,7 @@ SYM_FUNC_START(return_to_handler)
>   
>   	PTR_L		a0, sp, 0
>   	PTR_L		a1, sp, SZREG
> -	PTR_ADDI	sp, sp, 2 * SZREG
> +	PTR_ADDI	sp, sp, 3 * SZREG
>   	jr		ra
>   SYM_FUNC_END(return_to_handler)
>   #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
> index bbabf06244c2..ab85a953c6d3 100644
> --- a/arch/loongarch/kernel/mcount_dyn.S
> +++ b/arch/loongarch/kernel/mcount_dyn.S
> @@ -131,18 +131,19 @@ SYM_CODE_END(ftrace_graph_caller)
>   
>   SYM_CODE_START(return_to_handler)
>   	/* Save return value regs */
> -	PTR_ADDI 	sp, sp, -2 * SZREG
> +	PTR_ADDI 	sp, sp, -3 * SZREG
as above.

Thanks,
- Qing
>   	PTR_S		a0, sp, 0
>   	PTR_S		a1, sp, SZREG
> +	PTR_S		zero, sp, 2 * SZREG
>   
> -	move		a0, zero
> +	move		a0, sp
>   	bl		ftrace_return_to_handler
>   	move		ra, a0
>   
>   	/* Restore return value regs */
>   	PTR_L		a0, sp, 0
>   	PTR_L		a1, sp, SZREG
> -	PTR_ADDI 	sp, sp, 2 * SZREG
> +	PTR_ADDI 	sp, sp, 3 * SZREG
>   
>   	jr		ra
>   SYM_CODE_END(return_to_handler)
> 

