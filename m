Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987155F8588
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 16:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJHOGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiJHOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 10:06:48 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B7A476F9
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 07:06:45 -0700 (PDT)
Received: from [192.168.1.101] (95.49.30.238.neoplus.adsl.tpnet.pl [95.49.30.238])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C41BA3F321;
        Sat,  8 Oct 2022 16:06:41 +0200 (CEST)
Message-ID: <45b9c3f6-af45-e22b-06e6-ae2a2e5bba7a@somainline.org>
Date:   Sat, 8 Oct 2022 16:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
To:     Sven Peter <sven@svenpeter.dev>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221007200022.22844-3-konrad.dybcio@somainline.org>
 <65B38F6C-4E97-49CE-84F6-22CC9929B14B@svenpeter.dev>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <65B38F6C-4E97-49CE-84F6-22CC9929B14B@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.10.2022 11:33, Sven Peter wrote:
> 
> Hi,
> 
>> On 7. Oct 2022, at 22:00, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>>
>> ﻿Add support for A7-A11 SoCs by if-ing out some features only present
>> on A11 & newer (implementation-defined IPI & UNCORE registers).
>>
>> Also, annotate IPI regs support in the aic struct so that the driver
>> can tell whether the SoC supports these, as they are written to,
>> even if fast IPI is disabled.
> 
> No.
> 
>> This in turn causes a crash on older
>> platforms, as the implemention-defined registers either do
>> something else or are not supposed to be touched - definitely not a
>> NOP though.
> 
> This entire description needs to be rewritten. All you want to do is guard both fastipi and uncore reg access on pre-A11.
> 
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>> Changes since v3:
>> - Replace use_fast_ipi with has_uncore_ipi_regs in aic_init_cpu
>> (logic error, this was written to regardless of FIPI usage before,
>> but touching Sn_... regs on SoCs that don't explicitly use them for
>> IPIs makes them sepuku..)
>> - Drop A11 compatible
>>
>> drivers/irqchip/irq-apple-aic.c | 47 ++++++++++++++++++++++-----------
>> 1 file changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
>> index 1c2813ad8bbe..2609d6b60487 100644
>> --- a/drivers/irqchip/irq-apple-aic.c
>> +++ b/drivers/irqchip/irq-apple-aic.c
>> @@ -230,6 +230,9 @@
>>
>> static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
>>
>> +/* True if UNCORE/UNCORE2 and Sn_... IPI registers are present (A11+) */
>> +static DEFINE_STATIC_KEY_TRUE(has_uncore_ipi_regs);
>> +
>> struct aic_info {
>>    int version;
>>
>> @@ -246,6 +249,7 @@ struct aic_info {
>>
>>    /* Features */
>>    bool fast_ipi;
>> +    bool uncore_ipi_regs;
> 
> Why two flags? Didn’t we come to the conclusion last time that fastipi and uncore were introduced at the same time? Below you also either have both true or both false so there’s really no need to track both of them.
> 
> 
>> };
>>
>> static const struct aic_info aic1_info = {
>> @@ -261,6 +265,7 @@ static const struct aic_info aic1_fipi_info = {
>>    .event        = AIC_EVENT,
>>    .target_cpu    = AIC_TARGET_CPU,
>>
>> +    .uncore_ipi_regs    = true,
>>    .fast_ipi    = true,
>> };
>>
>> @@ -269,6 +274,7 @@ static const struct aic_info aic2_info = {
>>
>>    .irq_cfg    = AIC2_IRQ_CFG,
>>
>> +    .uncore_ipi_regs    = true,
>>    .fast_ipi    = true,
>> };
>>
>> @@ -524,12 +530,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
>>     * we check for everything here, even things we don't support yet.
>>     */
>>
>> -    if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
>> -        if (static_branch_likely(&use_fast_ipi)) {
>> -            aic_handle_ipi(regs);
>> -        } else {
>> -            pr_err_ratelimited("Fast IPI fired. Acking.\n");
>> -            write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>> +    if (static_branch_likely(&has_uncore_ipi_regs)) {
>> +        if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
>> +            if (static_branch_likely(&use_fast_ipi)) {
>> +                aic_handle_ipi(regs);
>> +            } else {
>> +                pr_err_ratelimited("Fast IPI fired. Acking.\n");
>> +                write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> 
> This still can’t be reached because both static branches will always have the same value. Didn’t we also realize a version or two ago that this can just be dropped?
> 
Ok, so I didn't realize you wanted this to become a single variable - I thought it would have
been useful to keep them separate, as A7-A10 *should* use fast IPIs as far as I'm aware, but
they don't use the impl-defined registers for that (or at least not the same ones).

For the sake of this patch, I can squash it into one as all known users to date set both in the
current form. Also, before this patch, "apple,aic" used to essentially be has_uncore_ipi_regs=true,
use_fast_ipi=false, but since there are no users, I assume that combination is not useful to keep
around?

Konrad

>> +            }
>>        }
>>    }
>>
>> @@ -566,12 +574,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
>>                      AIC_FIQ_HWIRQ(irq));
>>    }
>>
>> -    if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
>> -            (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
>> -        /* Same story with uncore PMCs */
>> -        pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
>> -        sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>> -                   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
>> +    if (static_branch_likely(&has_uncore_ipi_regs)) {
>> +        if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) ==
>> +            UPMCR0_IMODE_FIQ && (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
>> +            /* Same story with uncore PMCs */
>> +            pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
>> +            sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>> +                    FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
>> +        }
>>    }
>> }
>>
>> @@ -944,7 +954,8 @@ static int aic_init_cpu(unsigned int cpu)
>>    /* Mask all hard-wired per-CPU IRQ/FIQ sources */
>>
>>    /* Pending Fast IPI FIQs */
>> -    write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>> +    if (static_branch_likely(&has_uncore_ipi_regs))
>> +        write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>>
>>    /* Timer FIQs */
>>    sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
>> @@ -965,8 +976,9 @@ static int aic_init_cpu(unsigned int cpu)
>>               FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
>>
>>    /* Uncore PMC FIQ */
>> -    sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>> -               FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
>> +    if (static_branch_likely(&has_uncore_ipi_regs))
>> +        sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>> +                   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
>>
>>    /* Commit all of the above */
>>    isb();
>> @@ -1125,6 +1137,11 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
>>    else
>>        static_branch_disable(&use_fast_ipi);
>>
>> +    if (irqc->info.uncore_ipi_regs)
>> +        static_branch_enable(&has_uncore_ipi_regs);
>> +    else
>> +        static_branch_disable(&has_uncore_ipi_regs);
>> +
>>    irqc->info.die_stride = off - start_off;
>>
>>    irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
>> -- 
>> 2.37.3
> 
> 
> Sven
> 
