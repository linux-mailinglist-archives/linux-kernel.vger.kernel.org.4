Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C163D73756D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjFTTyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjFTTyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:54:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BECD173B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:54:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b52d14df27so23888485ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687290886; x=1689882886;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RsIaqKRLY/w55XA5LB9E3AHeTBdImbhhaSspjOmTz+k=;
        b=vQNccOY1KmXZzmbpNdP7pNP+MGN+VFDpqBaXrFLe4BPVoy0GqRf5L1qcnF3R5mR1ar
         iRa5MKJp0hqSDMwuMZ+jX5hc6S2Vrhbhb9mDzX0xgrvK9X0d4dQjwNDHpcguTuZZB/XU
         SXfdhzPvzMURg2rHJk+8bx2kuVIJkLQ4E6jQ65u3IU1r0qna5Z1dgE+LVQ460QQ/erb2
         4GK1smNIW1+qGDi80nQD7j/Va9D5gMPABFXJ8e9rfIlgiShEgzPu11pUvvnSDB1Ibia/
         GXn6gE/uw6JtBS3YAuWOZI/C93SRIP0kbb5rGKdr9MFt2JO/353px5ga5qz2LqtS6tu3
         lqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290886; x=1689882886;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsIaqKRLY/w55XA5LB9E3AHeTBdImbhhaSspjOmTz+k=;
        b=RUgY4N5DkNIzyzFh7K/2lLMArfD0eImIF8fLibqpQXfySYoha3r4R85tyhkjmdNwSR
         yjOGoJI9RGaWXfIGZF7QMsWLRmyH+756uc+pMKKNQP/az3Wu+w3Yry52A/PBtjqLQ69X
         xezpHWfjitfDRhAfTNU8i4zWmbAiPocT5viTgWrHnXmkru+/nVP4BmrwY724A89Sj7lY
         uf5ix7FDgMXu/Jh+Bdr/zlXGQcfP3HFK3rQxIS6H5j4+N455wkduKsw0TUYGxh4FrI4z
         xaC+xn36dRKwBHW5ZaeCSSbOZ0hawyripOM0kePYwU4K2dOI8pSDkf1E4cBZKcuUomx6
         IpXw==
X-Gm-Message-State: AC+VfDzvx98vnZHqosZatAQdKGnIwpEkGpSeNT3TKIUQzPFUqLkPgEqV
        DqCyGLmqpJ85g5Og8ZImxSCIRw==
X-Google-Smtp-Source: ACHHUZ4Kpx293K87FtkleDrYAYa0rwjXy2nPbgIEJGuxBo6nVZF7ASkOQcfG7zuhiqz3kJZ1Xdj1hQ==
X-Received: by 2002:a17:902:e884:b0:1b5:16f2:a4e3 with SMTP id w4-20020a170902e88400b001b516f2a4e3mr9879390plg.30.1687290885633;
        Tue, 20 Jun 2023 12:54:45 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id n21-20020a170902969500b001b016313b1esm2010616plp.82.2023.06.20.12.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:54:44 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:54:44 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Jun 2023 12:54:05 PDT (-0700)
Subject:     Re: [PATCH v11 5/8] riscv: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
In-Reply-To: <20230608215834.729cfda2@gandalf.local.home>
CC:     pengdonglin@sangfor.com.cn, mhiramat@kernel.org,
        linux@armlinux.org.uk, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rmk+kernel@armlinux.org.uk,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
        hpa@zytor.com, chenhuacai@kernel.org, zhangqing@loongson.cn,
        kernel@xen0n.name, mingo@redhat.com, peterz@infradead.org,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rostedt@goodmis.org
Message-ID: <mhng-672b0efa-aeba-4cb2-808d-6ef271844449@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2023 18:58:34 PDT (-0700), rostedt@goodmis.org wrote:
>
> Can I get an ack from a RISC-V maintainer?

Sorry I missed this.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

>
> -- Steve
>
>
> On Sat,  8 Apr 2023 05:42:19 -0700
> Donglin Peng <pengdonglin@sangfor.com.cn> wrote:
>
>> The previous patch ("function_graph: Support recording and printing
>> the return value of function") has laid the groundwork for the for
>> the funcgraph-retval, and this modification makes it available on
>> the RISC-V platform.
>>
>> We introduce a new structure called fgraph_ret_regs for the RISC-V
>> platform to hold return registers and the frame pointer. We then
>> fill its content in the return_to_handler and pass its address to
>> the function ftrace_return_to_handler to record the return value.
>>
>> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
>> ---
>> v10:
>>  - Use CONFIG_FUNCTION_GRAPH_TRACER to control fgraph_ret_regs definition
>>
>> v9:
>>  - Update the commit message
>>
>> v8:
>>  - Modify the control range of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
>> ---
>>  arch/riscv/Kconfig              |  1 +
>>  arch/riscv/include/asm/ftrace.h | 21 +++++++++++++++++++++
>>  arch/riscv/kernel/mcount.S      |  7 +------
>>  3 files changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index eb7f29a412f8..108538815309 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -139,6 +139,7 @@ config RISCV
>>  	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
>>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>> +	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>>  	select HAVE_FUNCTION_GRAPH_TRACER
>>  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
>>
>> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
>> index d47d87c2d7e3..740a979171e5 100644
>> --- a/arch/riscv/include/asm/ftrace.h
>> +++ b/arch/riscv/include/asm/ftrace.h
>> @@ -111,4 +111,25 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>>
>>  #endif /* CONFIG_DYNAMIC_FTRACE */
>>
>> +#ifndef __ASSEMBLY__
>> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>> +struct fgraph_ret_regs {
>> +	unsigned long a1;
>> +	unsigned long a0;
>> +	unsigned long s0;
>> +	unsigned long ra;
>> +};
>> +
>> +static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
>> +{
>> +	return ret_regs->a0;
>> +}
>> +
>> +static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
>> +{
>> +	return ret_regs->s0;
>> +}
>> +#endif /* ifdef CONFIG_FUNCTION_GRAPH_TRACER */
>> +#endif
>> +
>>  #endif /* _ASM_RISCV_FTRACE_H */
>> diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
>> index 30102aadc4d7..8a6e5a9e842a 100644
>> --- a/arch/riscv/kernel/mcount.S
>> +++ b/arch/riscv/kernel/mcount.S
>> @@ -65,13 +65,8 @@ ENTRY(return_to_handler)
>>   * So alternatively we check the *old* frame pointer position, that is, the
>>   * value stored in -16(s0) on entry, and the s0 on return.
>>   */
>> -#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
>> -	mv	t6, s0
>> -#endif
>>  	SAVE_RET_ABI_STATE
>> -#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
>> -	mv	a0, t6
>> -#endif
>> +	mv	a0, sp
>>  	call	ftrace_return_to_handler
>>  	mv	a2, a0
>>  	RESTORE_RET_ABI_STATE

