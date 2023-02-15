Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC14F6978DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjBOJYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjBOJYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:24:02 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3723E22021
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:23:57 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxTNqrpOxj4t8AAA--.2386S3;
        Wed, 15 Feb 2023 17:23:55 +0800 (CST)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxQuWppOxjVcczAA--.61403S3;
        Wed, 15 Feb 2023 17:23:54 +0800 (CST)
Subject: Re: [PATCH v2 1/3] LoongArch: Add hardware breakpoints/watchpoints
 support
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230210100906.16169-1-zhangqing@loongson.cn>
 <20230210100906.16169-2-zhangqing@loongson.cn>
 <011f18b2-26be-6104-24b1-f0c422138ce7@loongson.cn>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <5b66fd5f-2131-e361-9b69-e5de25de9a9b@loongson.cn>
Date:   Wed, 15 Feb 2023 17:23:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <011f18b2-26be-6104-24b1-f0c422138ce7@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxQuWppOxjVcczAA--.61403S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvAXoWfuFy5Ary8AFyDCFWrWw18Grg_yoWrXrykXo
        WUKF1rJr4rJr1UKr4UJryUXF15Jr1UCF1Dtr1UGryxZ3W8JFy5W3yUJrWjq3yUXr1kGr1U
        GF1UJryjvFy8Jr15n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2
        z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2
        IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
        YxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jinyang

On 2023/2/11 下午1:24, Jinyang He wrote:
> Hi, Qing,
> 
> 
> On 2023-02-10 18:09, Qing Zhang wrote:
>> Use perf framework to manage hardware instruction and data breakpoints.
>> LoongArch defines hardware watchpoint functions for instruction fetch
>> and load/store operations, after the software configures hardware 
>> watchpoints
>> for instruction fetch and load/store operations. The processor 
>> hardware will
>> monitor the access address of the instruction fetch and load/store 
>> operation,
>> and will trigger the exception of the watchpoint when it meets the 
>> conditions
>> set by the watchpoint.
>>
>> The hardware monitoring points for instruction fetching and load/store 
>> operations
>> each have a register for the overall configuration of all monitoring 
>> points,
>> a register for recording the status of all monitoring points, and four 
>> registers
>> required for configuration of each watchpoint individually.
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>> ---
>>   arch/loongarch/Kconfig                     |   1 +
>>   arch/loongarch/include/asm/hw_breakpoint.h | 145 ++++++
>>   arch/loongarch/include/asm/loongarch.h     |  32 +-
>>   arch/loongarch/include/asm/processor.h     |  11 +-
>>   arch/loongarch/include/asm/switch_to.h     |   1 +
>>   arch/loongarch/kernel/Makefile             |   1 +
>>   arch/loongarch/kernel/hw_breakpoint.c      | 517 +++++++++++++++++++++
>>   arch/loongarch/kernel/process.c            |   7 +
>>   arch/loongarch/kernel/traps.c              |  14 +-
>>   9 files changed, 708 insertions(+), 21 deletions(-)
>>   create mode 100644 arch/loongarch/include/asm/hw_breakpoint.h
>>   create mode 100644 arch/loongarch/kernel/hw_breakpoint.c
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 54bd3dbde1f2..e3eba2eb4b44 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -100,6 +100,7 @@ config LOONGARCH
>>       select HAVE_FUNCTION_GRAPH_TRACER
>>       select HAVE_FUNCTION_TRACER
>>       select HAVE_GENERIC_VDSO
>> +    select HAVE_HW_BREAKPOINT if PERF_EVENTS
>>       select HAVE_IOREMAP_PROT
>>       select HAVE_IRQ_EXIT_ON_IRQ_STACK
>>       select HAVE_IRQ_TIME_ACCOUNTING
>> diff --git a/arch/loongarch/include/asm/hw_breakpoint.h 
>> b/arch/loongarch/include/asm/hw_breakpoint.h
>> new file mode 100644
>> index 000000000000..44c109f0517f
>> --- /dev/null
>> +++ b/arch/loongarch/include/asm/hw_breakpoint.h
>> @@ -0,0 +1,145 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2022 Loongson Technology Corporation Limited
>> + */
>> +#ifndef __ASM_HW_BREAKPOINT_H
>> +#define __ASM_HW_BREAKPOINT_H
>> +
>> +#include <asm/loongarch.h>
>> +
>> +#ifdef __KERNEL__
>> +
>> +/* Breakpoint */
>> +#define LOONGARCH_BREAKPOINT_EXECUTE        (0 << 0)
>> +
>> +/* Watchpoints */
>> +#define LOONGARCH_BREAKPOINT_LOAD        (1 << 0)
>> +#define LOONGARCH_BREAKPOINT_STORE        (1 << 1)
>> +
>> +struct arch_hw_breakpoint_ctrl {
>> +    u32 __reserved1    : 28,
>> +    len        : 2,
>> +    type        : 2;
>> +};
>> +
>> +struct arch_hw_breakpoint {
>> +    u64 address;
>> +    u64 mask;
>> +    struct arch_hw_breakpoint_ctrl ctrl;
>> +};
>> +
>> +/* Lengths */
>> +#define LOONGARCH_BREAKPOINT_LEN_1    0b11
>> +#define LOONGARCH_BREAKPOINT_LEN_2    0b10
>> +#define LOONGARCH_BREAKPOINT_LEN_4    0b01
>> +#define LOONGARCH_BREAKPOINT_LEN_8    0b00
>> +
>> +/*
>> + * Limits.
>> + * Changing these will require modifications to the register accessors.
>> + */
>> +#define LOONGARCH_MAX_BRP        8
>> +#define LOONGARCH_MAX_WRP        8
>> +
>> +/* Virtual debug register bases. */
>> +#define CSR_CFG_ADDR    0
>> +#define CSR_CFG_MASK    (CSR_CFG_ADDR + LOONGARCH_MAX_BRP)
>> +#define CSR_CFG_CTRL    (CSR_CFG_MASK + LOONGARCH_MAX_BRP)
>> +#define CSR_CFG_ASID    (CSR_CFG_CTRL + LOONGARCH_MAX_WRP)
>> +
>> +/* Debug register names. */
>> +#define LOONGARCH_CSR_NAME_ADDR    ADDR
>> +#define LOONGARCH_CSR_NAME_MASK    MASK
>> +#define LOONGARCH_CSR_NAME_CTRL    CTRL
>> +#define LOONGARCH_CSR_NAME_ASID    ASID
>> +
>> +/* Accessor macros for the debug registers. */
>> +#define LOONGARCH_CSR_WATCH_READ(N, REG, T, VAL)            \
>> +do {                                \
>> +    if (T == 0)                        \
>> +        VAL = csr_read64(LOONGARCH_CSR_##IB##N##REG);    \
>> +    else                            \
>> +        VAL = csr_read64(LOONGARCH_CSR_##DB##N##REG);    \
>> +} while (0)
>> +
>> +#define LOONGARCH_CSR_WATCH_WRITE(N, REG, T, VAL)            \
>> +do {                                \
>> +    if (T == 0)                        \
>> +        csr_write64(VAL, LOONGARCH_CSR_##IB##N##REG);    \
>> +    else                            \
>> +        csr_write64(VAL, LOONGARCH_CSR_##DB##N##REG);    \
>> +} while (0)
>> +
>> +/* Exact number */
>> +#define CSR_FWPC_NUM 0x3f
>> +#define CSR_MWPC_NUM 0x3f
>> +
>> +static inline u32 encode_ctrl_reg(struct arch_hw_breakpoint_ctrl ctrl)
>> +{
>> +    u32 val = (ctrl.len << 10) | (ctrl.type << 8);
>> +
>> +    return val;
> 
> Just "return (ctrl.len << 10) | (ctrl.type << 8)".
> 
> And it is better to replace number with bits-macro.
> 
>> +}
>> +
>> +static inline void decode_ctrl_reg(u32 reg, struct 
>> arch_hw_breakpoint_ctrl *ctrl)
>> +{
>> +    reg >>= 8;
>> +    ctrl->type    = reg & 0x3;
>> +    reg >>= 2;
>> +    ctrl->len    = reg & 0x3;
> 
> Use macro, too.

> 
>> +}
>> +
>> +struct task_struct;
>> +struct notifier_block;
>> +struct perf_event_attr;
>> +struct perf_event;
>> +
>> +extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
>> +                  int *gen_len, int *gen_type, int *offset);
>> +extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
>> +extern int hw_breakpoint_arch_parse(struct perf_event *bp,
>> +                    const struct perf_event_attr *attr,
>> +                    struct arch_hw_breakpoint *hw);
>> +extern int hw_breakpoint_exceptions_notify(struct notifier_block 
>> *unused,
>> +                       unsigned long val, void *data);
>> +
>> +extern int arch_install_hw_breakpoint(struct perf_event *bp);
>> +extern void arch_uninstall_hw_breakpoint(struct perf_event *bp);
>> +extern void hw_breakpoint_pmu_read(struct perf_event *bp);
>> +extern int hw_breakpoint_slots(int type);
>> +
>> +int breakpoint_handler(struct pt_regs *regs);
>> +int watchpoint_handler(struct pt_regs *regs);
>> +
>> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
>> +extern void hw_breakpoint_thread_switch(struct task_struct *next);
>> +extern void ptrace_hw_copy_thread(struct task_struct *task);
>> +#else
>> +static inline void hw_breakpoint_thread_switch(struct task_struct *next)
>> +{
>> +}
>> +static inline void ptrace_hw_copy_thread(struct task_struct *task)
>> +{
>> +}
>> +#endif
>> +
>> +/* Determine number of BRP registers available. */
>> +static inline int get_num_brps(void)
>> +{
>> +    unsigned int ibcn;
>> +
>> +    ibcn = csr_read64(LOONGARCH_CSR_FWPC) & CSR_FWPC_NUM;
>> +    return ibcn;
> "return csr_read64..." for clearity.
>> +}
>> +
>> +/* Determine number of WRP registers available. */
>> +static inline int get_num_wrps(void)
>> +{
>> +    unsigned int dbcn;
>> +
>> +    dbcn = csr_read64(LOONGARCH_CSR_MWPC) & CSR_MWPC_NUM;
>> +    return dbcn;
> Ditto.
>> +}
>> +
>> +#endif    /* __KERNEL__ */
>> +#endif    /* __ASM_BREAKPOINT_H */
>> diff --git a/arch/loongarch/include/asm/loongarch.h 
>> b/arch/loongarch/include/asm/loongarch.h
>> index 7f8d57a61c8b..e9aed583a064 100644
>> --- a/arch/loongarch/include/asm/loongarch.h
>> +++ b/arch/loongarch/include/asm/loongarch.h
>> @@ -970,42 +970,42 @@ static __always_inline void iocsr_write64(u64 
>> val, u32 reg)
>>   #define LOONGARCH_CSR_DB0ADDR        0x310    /* data breakpoint 0 
>> address */
>>   #define LOONGARCH_CSR_DB0MASK        0x311    /* data breakpoint 0 
>> mask */
>> -#define LOONGARCH_CSR_DB0CTL        0x312    /* data breakpoint 0 
>> control */
>> +#define LOONGARCH_CSR_DB0CTRL        0x312    /* data breakpoint 0 
>> control */
>>   #define LOONGARCH_CSR_DB0ASID        0x313    /* data breakpoint 0 
>> asid */
>>   #define LOONGARCH_CSR_DB1ADDR        0x318    /* data breakpoint 1 
>> address */
>>   #define LOONGARCH_CSR_DB1MASK        0x319    /* data breakpoint 1 
>> mask */
>> -#define LOONGARCH_CSR_DB1CTL        0x31a    /* data breakpoint 1 
>> control */
>> +#define LOONGARCH_CSR_DB1CTRL        0x31a    /* data breakpoint 1 
>> control */
>>   #define LOONGARCH_CSR_DB1ASID        0x31b    /* data breakpoint 1 
>> asid */
>>   #define LOONGARCH_CSR_DB2ADDR        0x320    /* data breakpoint 2 
>> address */
>>   #define LOONGARCH_CSR_DB2MASK        0x321    /* data breakpoint 2 
>> mask */
>> -#define LOONGARCH_CSR_DB2CTL        0x322    /* data breakpoint 2 
>> control */
>> +#define LOONGARCH_CSR_DB2CTRL        0x322    /* data breakpoint 2 
>> control */
>>   #define LOONGARCH_CSR_DB2ASID        0x323    /* data breakpoint 2 
>> asid */
>>   #define LOONGARCH_CSR_DB3ADDR        0x328    /* data breakpoint 3 
>> address */
>>   #define LOONGARCH_CSR_DB3MASK        0x329    /* data breakpoint 3 
>> mask */
>> -#define LOONGARCH_CSR_DB3CTL        0x32a    /* data breakpoint 3 
>> control */
>> +#define LOONGARCH_CSR_DB3CTRL        0x32a    /* data breakpoint 3 
>> control */
>>   #define LOONGARCH_CSR_DB3ASID        0x32b    /* data breakpoint 3 
>> asid */
>>   #define LOONGARCH_CSR_DB4ADDR        0x330    /* data breakpoint 4 
>> address */
>>   #define LOONGARCH_CSR_DB4MASK        0x331    /* data breakpoint 4 
>> maks */
>> -#define LOONGARCH_CSR_DB4CTL        0x332    /* data breakpoint 4 
>> control */
>> +#define LOONGARCH_CSR_DB4CTRL        0x332    /* data breakpoint 4 
>> control */
>>   #define LOONGARCH_CSR_DB4ASID        0x333    /* data breakpoint 4 
>> asid */
>>   #define LOONGARCH_CSR_DB5ADDR        0x338    /* data breakpoint 5 
>> address */
>>   #define LOONGARCH_CSR_DB5MASK        0x339    /* data breakpoint 5 
>> mask */
>> -#define LOONGARCH_CSR_DB5CTL        0x33a    /* data breakpoint 5 
>> control */
>> +#define LOONGARCH_CSR_DB5CTRL        0x33a    /* data breakpoint 5 
>> control */
>>   #define LOONGARCH_CSR_DB5ASID        0x33b    /* data breakpoint 5 
>> asid */
>>   #define LOONGARCH_CSR_DB6ADDR        0x340    /* data breakpoint 6 
>> address */
>>   #define LOONGARCH_CSR_DB6MASK        0x341    /* data breakpoint 6 
>> mask */
>> -#define LOONGARCH_CSR_DB6CTL        0x342    /* data breakpoint 6 
>> control */
>> +#define LOONGARCH_CSR_DB6CTRL        0x342    /* data breakpoint 6 
>> control */
>>   #define LOONGARCH_CSR_DB6ASID        0x343    /* data breakpoint 6 
>> asid */
>>   #define LOONGARCH_CSR_DB7ADDR        0x348    /* data breakpoint 7 
>> address */
>>   #define LOONGARCH_CSR_DB7MASK        0x349    /* data breakpoint 7 
>> mask */
>> -#define LOONGARCH_CSR_DB7CTL        0x34a    /* data breakpoint 7 
>> control */
>> +#define LOONGARCH_CSR_DB7CTRL        0x34a    /* data breakpoint 7 
>> control */
>>   #define LOONGARCH_CSR_DB7ASID        0x34b    /* data breakpoint 7 
>> asid */
>>   #define LOONGARCH_CSR_FWPC        0x380    /* instruction breakpoint 
>> config */
>> @@ -1013,42 +1013,42 @@ static __always_inline void iocsr_write64(u64 
>> val, u32 reg)
>>   #define LOONGARCH_CSR_IB0ADDR        0x390    /* inst breakpoint 0 
>> address */
>>   #define LOONGARCH_CSR_IB0MASK        0x391    /* inst breakpoint 0 
>> mask */
>> -#define LOONGARCH_CSR_IB0CTL        0x392    /* inst breakpoint 0 
>> control */
>> +#define LOONGARCH_CSR_IB0CTRL        0x392    /* inst breakpoint 0 
>> control */
>>   #define LOONGARCH_CSR_IB0ASID        0x393    /* inst breakpoint 0 
>> asid */
>>   #define LOONGARCH_CSR_IB1ADDR        0x398    /* inst breakpoint 1 
>> address */
>>   #define LOONGARCH_CSR_IB1MASK        0x399    /* inst breakpoint 1 
>> mask */
>> -#define LOONGARCH_CSR_IB1CTL        0x39a    /* inst breakpoint 1 
>> control */
>> +#define LOONGARCH_CSR_IB1CTRL        0x39a    /* inst breakpoint 1 
>> control */
>>   #define LOONGARCH_CSR_IB1ASID        0x39b    /* inst breakpoint 1 
>> asid */
>>   #define LOONGARCH_CSR_IB2ADDR        0x3a0    /* inst breakpoint 2 
>> address */
>>   #define LOONGARCH_CSR_IB2MASK        0x3a1    /* inst breakpoint 2 
>> mask */
>> -#define LOONGARCH_CSR_IB2CTL        0x3a2    /* inst breakpoint 2 
>> control */
>> +#define LOONGARCH_CSR_IB2CTRL        0x3a2    /* inst breakpoint 2 
>> control */
>>   #define LOONGARCH_CSR_IB2ASID        0x3a3    /* inst breakpoint 2 
>> asid */
>>   #define LOONGARCH_CSR_IB3ADDR        0x3a8    /* inst breakpoint 3 
>> address */
>>   #define LOONGARCH_CSR_IB3MASK        0x3a9    /* breakpoint 3 mask */
>> -#define LOONGARCH_CSR_IB3CTL        0x3aa    /* inst breakpoint 3 
>> control */
>> +#define LOONGARCH_CSR_IB3CTRL        0x3aa    /* inst breakpoint 3 
>> control */
>>   #define LOONGARCH_CSR_IB3ASID        0x3ab    /* inst breakpoint 3 
>> asid */
>>   #define LOONGARCH_CSR_IB4ADDR        0x3b0    /* inst breakpoint 4 
>> address */
>>   #define LOONGARCH_CSR_IB4MASK        0x3b1    /* inst breakpoint 4 
>> mask */
>> -#define LOONGARCH_CSR_IB4CTL        0x3b2    /* inst breakpoint 4 
>> control */
>> +#define LOONGARCH_CSR_IB4CTRL        0x3b2    /* inst breakpoint 4 
>> control */
>>   #define LOONGARCH_CSR_IB4ASID        0x3b3    /* inst breakpoint 4 
>> asid */
>>   #define LOONGARCH_CSR_IB5ADDR        0x3b8    /* inst breakpoint 5 
>> address */
>>   #define LOONGARCH_CSR_IB5MASK        0x3b9    /* inst breakpoint 5 
>> mask */
>> -#define LOONGARCH_CSR_IB5CTL        0x3ba    /* inst breakpoint 5 
>> control */
>> +#define LOONGARCH_CSR_IB5CTRL        0x3ba    /* inst breakpoint 5 
>> control */
>>   #define LOONGARCH_CSR_IB5ASID        0x3bb    /* inst breakpoint 5 
>> asid */
>>   #define LOONGARCH_CSR_IB6ADDR        0x3c0    /* inst breakpoint 6 
>> address */
>>   #define LOONGARCH_CSR_IB6MASK        0x3c1    /* inst breakpoint 6 
>> mask */
>> -#define LOONGARCH_CSR_IB6CTL        0x3c2    /* inst breakpoint 6 
>> control */
>> +#define LOONGARCH_CSR_IB6CTRL        0x3c2    /* inst breakpoint 6 
>> control */
>>   #define LOONGARCH_CSR_IB6ASID        0x3c3    /* inst breakpoint 6 
>> asid */
>>   #define LOONGARCH_CSR_IB7ADDR        0x3c8    /* inst breakpoint 7 
>> address */
>>   #define LOONGARCH_CSR_IB7MASK        0x3c9    /* inst breakpoint 7 
>> mask */
>> -#define LOONGARCH_CSR_IB7CTL        0x3ca    /* inst breakpoint 7 
>> control */
>> +#define LOONGARCH_CSR_IB7CTRL        0x3ca    /* inst breakpoint 7 
>> control */
>>   #define LOONGARCH_CSR_IB7ASID        0x3cb    /* inst breakpoint 7 
>> asid */
>>   #define LOONGARCH_CSR_DEBUG        0x500    /* debug config */
>> diff --git a/arch/loongarch/include/asm/processor.h 
>> b/arch/loongarch/include/asm/processor.h
>> index 7184f1dc61f2..a62625af908b 100644
>> --- a/arch/loongarch/include/asm/processor.h
>> +++ b/arch/loongarch/include/asm/processor.h
>> @@ -11,6 +11,7 @@
>>   #include <asm/cpu.h>
>>   #include <asm/cpu-info.h>
>> +#include <asm/hw_breakpoint.h>
>>   #include <asm/loongarch.h>
>>   #include <asm/vdso/processor.h>
>>   #include <uapi/asm/ptrace.h>
>> @@ -131,6 +132,10 @@ struct thread_struct {
>>        * they are conditionally copied at fork().
>>        */
>>       struct loongarch_fpu fpu FPU_ALIGN;
>> +    /* Hardware breakpoints pinned to this task. */
>> +    struct perf_event    *hbp_break[LOONGARCH_MAX_BRP];
>> +    struct perf_event    *hbp_watch[LOONGARCH_MAX_WRP];
>> +    unsigned long single_step;
> As it is not used in this patch, should remove it?
>>   };
>>   #define thread_saved_ra(tsk)    (tsk->thread.sched_ra)
>> @@ -172,6 +177,8 @@ struct thread_struct {
>>           .fcc        = 0,                \
>>           .fpr        = {{{0,},},},            \
>>       },                            \
>> +    .hbp_break        = {0},                \
>> +    .hbp_watch        = {0},                \
> So if not remove single_step, it mismatch here.
>>   }
>>   struct task_struct;
>> @@ -184,10 +191,6 @@ extern unsigned long        
>> boot_option_idle_override;
>>    */
>>   extern void start_thread(struct pt_regs *regs, unsigned long pc, 
>> unsigned long sp);
>> -static inline void flush_thread(void)
>> -{
>> -}
>> -
>>   unsigned long __get_wchan(struct task_struct *p);
>>   #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
>> diff --git a/arch/loongarch/include/asm/switch_to.h 
>> b/arch/loongarch/include/asm/switch_to.h
>> index 43a5ab162d38..a98e1d212ba9 100644
>> --- a/arch/loongarch/include/asm/switch_to.h
>> +++ b/arch/loongarch/include/asm/switch_to.h
>> @@ -34,6 +34,7 @@ extern asmlinkage struct task_struct 
>> *__switch_to(struct task_struct *prev,
>>   #define switch_to(prev, next, last)                        \
>>   do {                                        \
>>       lose_fpu_inatomic(1, prev);                        \
>> +        hw_breakpoint_thread_switch(next);                \
> Redundant tab.
>>       (last) = __switch_to(prev, next, task_thread_info(next),        \
>>            __builtin_return_address(0), __builtin_frame_address(0));    \
>>   } while (0)
>> diff --git a/arch/loongarch/kernel/Makefile 
>> b/arch/loongarch/kernel/Makefile
>> index 45c78aea63ce..006c892f9be3 100644
>> --- a/arch/loongarch/kernel/Makefile
>> +++ b/arch/loongarch/kernel/Makefile
>> @@ -46,6 +46,7 @@ obj-$(CONFIG_UNWINDER_GUESS)    += unwind_guess.o
>>   obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
>>   obj-$(CONFIG_PERF_EVENTS)    += perf_event.o perf_regs.o
>> +obj-$(CONFIG_HAVE_HW_BREAKPOINT)        += hw_breakpoint.o
>>   obj-$(CONFIG_KPROBES)        += kprobes.o kprobes_trampoline.o
>> diff --git a/arch/loongarch/kernel/hw_breakpoint.c 
>> b/arch/loongarch/kernel/hw_breakpoint.c
>> new file mode 100644
>> index 000000000000..509af6c54bed
>> --- /dev/null
>> +++ b/arch/loongarch/kernel/hw_breakpoint.c
>> @@ -0,0 +1,517 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2022 Loongson Technology Corporation Limited
>> + */
>> +#define pr_fmt(fmt) "hw-breakpoint: " fmt
>> +
>> +#include <linux/hw_breakpoint.h>
>> +#include <linux/kprobes.h>
>> +#include <linux/perf_event.h>
>> +
>> +#include <asm/hw_breakpoint.h>
>> +
>> +/* Breakpoint currently in use for each BRP. */
>> +static DEFINE_PER_CPU(struct perf_event *, 
>> bp_on_reg[LOONGARCH_MAX_BRP]);
>> +
>> +/* Watchpoint currently in use for each WRP. */
>> +static DEFINE_PER_CPU(struct perf_event *, 
>> wp_on_reg[LOONGARCH_MAX_WRP]);
>> +
>> +/* Number of BRP/WRP registers on this CPU. */
>> +static int core_num_brps;
>> +static int core_num_wrps;
>> +
>> +int hw_breakpoint_slots(int type)
>> +{
>> +    /*
>> +     * We can be called early, so don't rely on
>> +     * our static variables being initialised.
>> +     */
>> +    switch (type) {
>> +    case TYPE_INST:
>> +        return get_num_brps();
>> +    case TYPE_DATA:
>> +        return get_num_wrps();
>> +    default:
>> +        pr_warn("unknown slot type: %d\n", type);
>> +        return 0;
>> +    }
>> +}
>> +
>> +#define READ_WB_REG_CASE(OFF, N, REG, T, VAL)        \
>> +    case (OFF + N):                    \
>> +        LOONGARCH_CSR_WATCH_READ(N, REG, T, VAL);    \
>> +        break
>> +
>> +#define WRITE_WB_REG_CASE(OFF, N, REG, T, VAL)        \
>> +    case (OFF + N):                    \
>> +        LOONGARCH_CSR_WATCH_WRITE(N, REG, T, VAL);    \
>> +        break
>> +
>> +#define GEN_READ_WB_REG_CASES(OFF, REG, T, VAL)        \
>> +    READ_WB_REG_CASE(OFF, 0, REG, T, VAL);        \
>> +    READ_WB_REG_CASE(OFF, 1, REG, T, VAL);        \
>> +    READ_WB_REG_CASE(OFF, 2, REG, T, VAL);        \
>> +    READ_WB_REG_CASE(OFF, 3, REG, T, VAL);        \
>> +    READ_WB_REG_CASE(OFF, 4, REG, T, VAL);        \
>> +    READ_WB_REG_CASE(OFF, 5, REG, T, VAL);        \
>> +    READ_WB_REG_CASE(OFF, 6, REG, T, VAL);        \
>> +    READ_WB_REG_CASE(OFF, 7, REG, T, VAL);
>> +
>> +#define GEN_WRITE_WB_REG_CASES(OFF, REG, T, VAL)    \
>> +    WRITE_WB_REG_CASE(OFF, 0, REG, T, VAL);        \
>> +    WRITE_WB_REG_CASE(OFF, 1, REG, T, VAL);        \
>> +    WRITE_WB_REG_CASE(OFF, 2, REG, T, VAL);        \
>> +    WRITE_WB_REG_CASE(OFF, 3, REG, T, VAL);        \
>> +    WRITE_WB_REG_CASE(OFF, 4, REG, T, VAL);        \
>> +    WRITE_WB_REG_CASE(OFF, 5, REG, T, VAL);        \
>> +    WRITE_WB_REG_CASE(OFF, 6, REG, T, VAL);        \
>> +    WRITE_WB_REG_CASE(OFF, 7, REG, T, VAL);
>> +
>> +static u64 read_wb_reg(int reg, int n, int t)
>> +{
>> +    u64 val = 0;
>> +
>> +    switch (reg + n) {
>> +    GEN_READ_WB_REG_CASES(CSR_CFG_ADDR, ADDR, t, val);
>> +    GEN_READ_WB_REG_CASES(CSR_CFG_MASK, MASK, t, val);
>> +    GEN_READ_WB_REG_CASES(CSR_CFG_CTRL, CTRL, t, val);
>> +    GEN_READ_WB_REG_CASES(CSR_CFG_ASID, ASID, t, val);
>> +    default:
>> +        pr_warn("attempt to read from unknown breakpoint register 
>> %d\n", n);
>> +    }
>> +
>> +    return val;
>> +}
>> +NOKPROBE_SYMBOL(read_wb_reg);
>> +
>> +static void write_wb_reg(int reg, int n, int t, u64 val)
>> +{
>> +    switch (reg + n) {
>> +    GEN_WRITE_WB_REG_CASES(CSR_CFG_ADDR, ADDR, t, val);
>> +    GEN_WRITE_WB_REG_CASES(CSR_CFG_MASK, MASK, t, val);
>> +    GEN_WRITE_WB_REG_CASES(CSR_CFG_CTRL, CTRL, t, val);
>> +    GEN_WRITE_WB_REG_CASES(CSR_CFG_ASID, ASID, t, val);
>> +    default:
>> +        pr_warn("attempt to write to unknown breakpoint register 
>> %d\n", n);
>> +    }
>> +}
>> +NOKPROBE_SYMBOL(write_wb_reg);
>> +
>> +enum hw_breakpoint_ops {
>> +    HW_BREAKPOINT_INSTALL,
>> +    HW_BREAKPOINT_UNINSTALL,
>> +};
>> +
>> +/**
>> + * hw_breakpoint_slot_setup - Find and setup a perf slot according to
>> + *                  operations
>> + *
>> + * @slots: pointer to array of slots
>> + * @max_slots: max number of slots
>> + * @bp: perf_event to setup
>> + * @ops: operation to be carried out on the slot
>> + *
>> + * Return:
>> + *    slot index on success
>> + *    -ENOSPC if no slot is available/matches
>> + *    -EINVAL on wrong operations parameter
>> + */
>> +
>> +static int hw_breakpoint_slot_setup(struct perf_event **slots, int 
>> max_slots,
>> +                    struct perf_event *bp,
>> +                    enum hw_breakpoint_ops ops)
>> +{
>> +    int i;
>> +    struct perf_event **slot;
>> +
>> +    for (i = 0; i < max_slots; ++i) {
>> +        slot = &slots[i];
>> +        switch (ops) {
>> +        case HW_BREAKPOINT_INSTALL:
>> +            if (!*slot) {
> 
> Actually use slots[i] here also is OK, I think.
> 
> I means the slot is a redundant variable, but it depends on you.
Yeah, but we should be consistent with other architectures.
> 
...
> 
> How to following,
> 
> static int hbp_len[] = {
>      [LOONGARCH_BREAKPOINT_LEN_1] = 1,
>      [LOONGARCH_BREAKPOINT_LEN_2] = 2,
>      [LOONGARCH_BREAKPOINT_LEN_4] = 4,
>      [LOONGARCH_BREAKPOINT_LEN_8] = 8,
> }; >
Same as above。
>> +
>> +/*
>> + * Check whether bp virtual address is in kernel space.
>> + */
>> +int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
>> +{
>> +    unsigned int len;
>> +    unsigned long va;
>> +
>> +    va = hw->address;
>> +    len = get_hbp_len(hw->ctrl.len);
>> +
>> +    return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
>> +}
>> +
>> +/*
>> + * Extract generic type and length encodings from an 
>> arch_hw_breakpoint_ctrl.
>> + * Hopefully this will disappear when ptrace can bypass the conversion
>> + * to generic breakpoint descriptions.
>> + */
>> +int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
>> +               int *gen_len, int *gen_type, int *offset)
>> +{
>> +    /* Type */
>> +    switch (ctrl.type) {
>> +    case LOONGARCH_BREAKPOINT_EXECUTE:
>> +        *gen_type = HW_BREAKPOINT_X;
>> +        break;
>> +    case LOONGARCH_BREAKPOINT_LOAD:
>> +        *gen_type = HW_BREAKPOINT_R;
>> +        break;
>> +    case LOONGARCH_BREAKPOINT_STORE:
>> +        *gen_type = HW_BREAKPOINT_W;
>> +        break;
>> +    case LOONGARCH_BREAKPOINT_LOAD | LOONGARCH_BREAKPOINT_STORE:
>> +        *gen_type = HW_BREAKPOINT_RW;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!ctrl.len)
>> +        return -EINVAL;
>> +    *offset = __ffs(ctrl.len);
>> +
>> +    /* Len */
>> +    switch (ctrl.len) {
>> +    case LOONGARCH_BREAKPOINT_LEN_1:
>> +        *gen_len = HW_BREAKPOINT_LEN_1;
>> +        break;
>> +    case LOONGARCH_BREAKPOINT_LEN_2:
>> +        *gen_len = HW_BREAKPOINT_LEN_2;
>> +        break;
>> +    case LOONGARCH_BREAKPOINT_LEN_4:
>> +        *gen_len = HW_BREAKPOINT_LEN_4;
>> +        break;
>> +    case LOONGARCH_BREAKPOINT_LEN_8:
>> +        *gen_len = HW_BREAKPOINT_LEN_8;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Construct an arch_hw_breakpoint from a perf_event.
>> + */
>> +static int arch_build_bp_info(struct perf_event *bp,
>> +                  const struct perf_event_attr *attr,
>> +                  struct arch_hw_breakpoint *hw)
>> +{
>> +    /* Type */
>> +    switch (attr->bp_type) {
>> +    case HW_BREAKPOINT_X:
>> +        hw->ctrl.type = LOONGARCH_BREAKPOINT_EXECUTE;
>> +        break;
>> +    case HW_BREAKPOINT_R:
>> +        hw->ctrl.type = LOONGARCH_BREAKPOINT_LOAD;
>> +        break;
>> +    case HW_BREAKPOINT_W:
>> +        hw->ctrl.type = LOONGARCH_BREAKPOINT_STORE;
>> +        break;
>> +    case HW_BREAKPOINT_RW:
>> +        hw->ctrl.type = LOONGARCH_BREAKPOINT_LOAD | 
>> LOONGARCH_BREAKPOINT_STORE;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Len */
>> +    switch (attr->bp_len) {
>> +    case HW_BREAKPOINT_LEN_1:
>> +        hw->ctrl.len = LOONGARCH_BREAKPOINT_LEN_1;
>> +        break;
>> +    case HW_BREAKPOINT_LEN_2:
>> +        hw->ctrl.len = LOONGARCH_BREAKPOINT_LEN_2;
>> +        break;
>> +    case HW_BREAKPOINT_LEN_4:
>> +        hw->ctrl.len = LOONGARCH_BREAKPOINT_LEN_4;
>> +        break;
>> +    case HW_BREAKPOINT_LEN_8:
>> +        hw->ctrl.len = LOONGARCH_BREAKPOINT_LEN_8;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Address */
>> +    hw->address = attr->bp_addr;
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Validate the arch-specific HW Breakpoint register settings.
>> + */
>> +int hw_breakpoint_arch_parse(struct perf_event *bp,
>> +                 const struct perf_event_attr *attr,
>> +                 struct arch_hw_breakpoint *hw)
>> +{
>> +    int ret;
>> +    u64 alignment_mask, offset;
>> +
>> +    /* Build the arch_hw_breakpoint. */
>> +    ret = arch_build_bp_info(bp, attr, hw);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (hw->ctrl.type != LOONGARCH_BREAKPOINT_EXECUTE)
>> +        alignment_mask = 0x7;
>> +    offset = hw->address & alignment_mask;
>> +
>> +    hw->address &= ~alignment_mask;
>> +    hw->ctrl.len <<= offset;
>> +    return 0;
>> +}
>> +
>> +static void update_bp_registers(struct pt_regs *regs, int enable)
>> +{
>> +    int i, max_slots;
>> +    u32 ctrl;
>> +    struct perf_event **slots;
>> +
>> +    if (csr_read64(LOONGARCH_CSR_FWPS) & 0xff) {
>> +        slots = this_cpu_ptr(bp_on_reg);
>> +        max_slots = core_num_brps;
>> +
> Redundant line.
>> +    } else if (csr_read64(LOONGARCH_CSR_MWPS) & 0xff) {
>> +        slots = this_cpu_ptr(wp_on_reg);
>> +        max_slots = core_num_wrps;
>> +    } else {
>> +        return;
>> +    }
>> +
>> +    for (i = 0; i < max_slots; ++i) {
>> +        if (!slots[i])
>> +            continue;
>> +
>> +        if (enable) {
>> +            if (csr_read64(LOONGARCH_CSR_MWPS) & 0xff) {
>> +                ctrl = read_wb_reg(CSR_CFG_CTRL, i, 1);
>> +                ctrl |= 0x1 << 8;
>> +                ctrl |= 0x1 << 9;
>> +                write_wb_reg(CSR_CFG_CTRL, i, 1, ctrl);
>> +            } else {
>> +                write_wb_reg(CSR_CFG_CTRL, i, 0, 0x1e);
>> +                    write_wb_reg(CSR_CFG_CTRL, i, 0, 0x1e);
> Macros and redundant tab.
>> +            }
>> +            regs->csr_prmd |= CSR_PRMD_PWE;
>> +        } else {
>> +            if (csr_read64(LOONGARCH_CSR_MWPS) & 0xff) {
>> +                ctrl = read_wb_reg(CSR_CFG_CTRL, i, 1);
>> +                ctrl = read_wb_reg(CSR_CFG_CTRL, i, 0);
>> +                ctrl &= ~0x1 << 8;
>> +                ctrl &= ~0x1 << 9;
>> +                write_wb_reg(CSR_CFG_CTRL, i, 1, ctrl);
>> +            } else {
>> +                write_wb_reg(CSR_CFG_CTRL, i, 0, 0);
>> +            }
>> +            regs->csr_prmd &= ~CSR_PRMD_PWE;
>> +        }
>> +    }
>> +}
>> +NOKPROBE_SYMBOL(update_bp_registers);
>> +
>> +/*
>> + * Debug exception handlers.
>> + */
>> +int breakpoint_handler(struct pt_regs *regs)
>> +{
>> +    int i;
>> +    struct perf_event *bp, **slots;
>> +
>> +    slots = this_cpu_ptr(bp_on_reg);
>> +
>> +    for (i = 0; i < core_num_brps; ++i) {
>> +        bp = slots[i];
>> +        if (bp == NULL)
>> +            continue;
>> +        perf_bp_event(bp, regs);
>> +    }
>> +
>> +    update_bp_registers(regs, 0);
>> +
>> +    return 0;
>> +}
>> +NOKPROBE_SYMBOL(breakpoint_handler);
>> +
>> +int watchpoint_handler(struct pt_regs *regs)
>> +{
>> +    int i;
>> +    struct perf_event *wp, **slots;
>> +
>> +    slots = this_cpu_ptr(wp_on_reg);
>> +
>> +    for (i = 0; i < core_num_wrps; ++i) {
>> +        wp = slots[i];
>> +        if (wp == NULL)
>> +            continue;
>> +        perf_bp_event(wp, regs);
>> +    }
>> +    update_bp_registers(regs, 0);
>> +
>> +    return 0;
>> +}
>> +NOKPROBE_SYMBOL(watchpoint_handler);
>> +
>> +/*
>> + * One-time initialisation.
>> + */
>> +static int __init arch_hw_breakpoint_init(void)
>> +{
>> +    core_num_brps = get_num_brps();
>> +    core_num_wrps = get_num_wrps();
>> +
>> +    pr_info("found %d breakpoint and %d watchpoint registers.\n",
>> +        core_num_brps, core_num_wrps);
>> +    return 0;
>> +}
>> +arch_initcall(arch_hw_breakpoint_init);
>> +
>> +void hw_breakpoint_thread_switch(struct task_struct *next)
>> +{
>> +    struct pt_regs *regs = task_pt_regs(next);
>> +
>> +    /* Update breakpoints/watchpoints. */
>> +    update_bp_registers(regs, 1);
>> +}
>> +
>> +void hw_breakpoint_pmu_read(struct perf_event *bp)
>> +{
>> +}
>> +
>> +/*
>> + * Dummy function to register with die_notifier.
>> + */
>> +int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
>> +                    unsigned long val, void *data)
>> +{
>> +    return NOTIFY_DONE;
>> +}
>> diff --git a/arch/loongarch/kernel/process.c 
>> b/arch/loongarch/kernel/process.c
>> index 9073fab1a487..6b53781c0b59 100644
>> --- a/arch/loongarch/kernel/process.c
>> +++ b/arch/loongarch/kernel/process.c
>> @@ -37,6 +37,7 @@
>>   #include <asm/cpu.h>
>>   #include <asm/elf.h>
>>   #include <asm/fpu.h>
>> +#include <linux/hw_breakpoint.h>
>>   #include <asm/io.h>
>>   #include <asm/irq.h>
>>   #include <asm/irq_regs.h>
>> @@ -100,6 +101,11 @@ void exit_thread(struct task_struct *tsk)
>>   {
>>   }
>> +void flush_thread(void)
>> +{
>> +    flush_ptrace_hw_breakpoint(current);
>> +}
>> +
>>   int arch_dup_task_struct(struct task_struct *dst, struct task_struct 
>> *src)
>>   {
>>       /*
>> @@ -186,6 +192,7 @@ int copy_thread(struct task_struct *p, const 
>> struct kernel_clone_args *args)
>>       if (clone_flags & CLONE_SETTLS)
>>           childregs->regs[2] = tls;
>> +    ptrace_hw_copy_thread(p);
>>   out:
>>       clear_tsk_thread_flag(p, TIF_USEDFPU);
>>       clear_tsk_thread_flag(p, TIF_USEDSIMD);
>> diff --git a/arch/loongarch/kernel/traps.c 
>> b/arch/loongarch/kernel/traps.c
>> index 4aa3901c5623..70085d83476d 100644
>> --- a/arch/loongarch/kernel/traps.c
>> +++ b/arch/loongarch/kernel/traps.c
>> @@ -508,7 +508,19 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>>   asmlinkage void noinstr do_watch(struct pt_regs *regs)
>>   {
>> -    pr_warn("Hardware watch point handler not implemented!\n");
>> +    enum ctx_state prev_state;
>> +
>> +    prev_state = exception_enter();
>> +
>> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
>> +    if (breakpoint_handler(regs))
>> +        return;
>> +    if (watchpoint_handler(regs))
>> +        return;
> 
> The breakpoint_handler and watchpoint_handler seems always return 0.
> 
> As breakpoint_handler is invoked firstly, the logic, you select read
> CSR.FWPS firstly, in update_bp_registers() is right. That means, if
> you call watchpoint_handler() firstly when ex_watch is triggered by
> breakpoint, then it invoke update_bp_registers, and last the condition
> "csr_read64(LOONGARCH_CSR_FWPS) & 0xff" is true, error occurs.
> Again, the current logic is right, but I think it is better to separate
> the breakpoint and watchpoint case. You can try pass a new arg to
> indicate it is breakpoint or watchpoint. Or separate it to two funcs.
> 
> And finnally, if breakpoint and watchpoint both triggered in same time,
> does this patch handle right? Is One of them triggered or are both of
> them triggered？
> e.g.
> 0x10000: "li.d $rj, 0x100"
> 0x10004: "ld.d $rd, $rj, 0"
> watch: 0x100, break: 0x10004
> 
> Thanks,
> When a watch exception is trigger, the current breakpoint_handler
to judgment load/store watchpoint, Trying to split into
two functions would make the code redundant, so choose
to add a new parameter type to the method to distinguish
the different cases. And the rest have all been fixed in V3.

Thanks,
-Qing
> Jinyang
> 
>> +#endif
>> +    force_sig(SIGTRAP);
>> +    exception_exit(prev_state);
>> +    return;
>>   }
>>   asmlinkage void noinstr do_ri(struct pt_regs *regs)
> 

