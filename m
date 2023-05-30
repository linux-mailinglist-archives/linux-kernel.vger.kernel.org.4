Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5950C7169CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjE3Qgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjE3Qgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:36:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CED28F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:36:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C3D816F2;
        Tue, 30 May 2023 09:37:13 -0700 (PDT)
Received: from [10.1.34.168] (e126864.cambridge.arm.com [10.1.34.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75F7D3F663;
        Tue, 30 May 2023 09:36:24 -0700 (PDT)
Message-ID: <64701978-1b11-3dec-c0e4-57f1a0eee1fe@arm.com>
Date:   Tue, 30 May 2023 17:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 07/11] arm64: mops: handle MOPS exceptions
Content-Language: en-US
To:     Colton Lewis <coltonlewis@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
References: <gsnta5xsb36u.fsf@coltonlewis-kvm.c.googlers.com>
From:   Kristina Martsenko <kristina.martsenko@arm.com>
In-Reply-To: <gsnta5xsb36u.fsf@coltonlewis-kvm.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2023 20:50, Colton Lewis wrote:
>> +    if (esr & ESR_ELx_MOPS_ISS_MEM_INST) {
>> +        /* SET* instruction */
>> +        if (option_a ^ wrong_option) {
>> +            /* Format is from Option A; forward set */
>> +            pt_regs_write_reg(regs, dstreg, dst + size);
>> +            pt_regs_write_reg(regs, sizereg, -size);
>> +        }
>> +    } else {
>> +        /* CPY* instruction */
>> +        if (!(option_a ^ wrong_option)) {
>> +            /* Format is from Option B */
>> +            if (regs->pstate & PSR_N_BIT) {
>> +                /* Backward copy */
>> +                pt_regs_write_reg(regs, dstreg, dst - size);
>> +                pt_regs_write_reg(regs, srcreg, src - size);
>> +            }
>> +        } else {
>> +            /* Format is from Option A */
>> +            if (size & BIT(63)) {
>> +                /* Forward copy */
>> +                pt_regs_write_reg(regs, dstreg, dst + size);
>> +                pt_regs_write_reg(regs, srcreg, src + size);
>> +                pt_regs_write_reg(regs, sizereg, -size);
>> +            }
>> +        }
>> +    }
> 
> I can see an argument for styling things closely to the ARM manual as
> you have done here, but Linux style recommends against deep nesting. In
> this case it is unneeded. I believe this can be written as a single
> if-else chain and that makes it easier to distinguish the three options.
> 
> if ((esr & ESR_ELx_MOPS_ISS_MEM_INST) && (option_a ^ wrong_option)) {
>     /* Format is from Option A; forward set */
>     pt_regs_write_reg(regs, dstreg, dst + size);
>     pt_regs_write_reg(regs, sizereg, -size);
> } else if ((option_a ^ wrong_option) && (size & BIT(63)) {
>     /* Forward copy */
>     pt_regs_write_reg(regs, dstreg, dst + size);
>     pt_regs_write_reg(regs, srcreg, src + size);
>     pt_regs_write_reg(regs, sizereg, -size);
> } else if (regs-pstate & PSR_N_BIT) {
>     /* Backward copy */
>     pt_regs_write_reg(regs, dstreg, dst - size);
>     pt_regs_write_reg(regs, srcreg, src - size);
> }

Yeah, the nesting gets a bit deep here, but there are 6 cases in total, ie 6 
ways the hardware can set up the registers and pstate (in 3 of them the kernel
doesn't need to modify the registers), and I think the current structure makes
it clearer what the 6 are, so I'd prefer to keep it as it is for now.

Thanks,
Kristina

