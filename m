Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E2770D759
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjEWIZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbjEWIYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:24:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C3711FC3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:21:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7BF9139F;
        Tue, 23 May 2023 01:22:32 -0700 (PDT)
Received: from [10.162.42.7] (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF07C3F762;
        Tue, 23 May 2023 01:21:44 -0700 (PDT)
Message-ID: <e92b10d3-27bb-e326-e7f2-d6095b756fac@arm.com>
Date:   Tue, 23 May 2023 13:51:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] arm64/sysreg: Convert OSLAR_EL1 to automatic
 generation
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>,
        Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20230419-arm64-syreg-gen-v1-0-936cd769cb9e@kernel.org>
 <20230419-arm64-syreg-gen-v1-5-936cd769cb9e@kernel.org>
 <ZGx1jT4nQ9HEVWSE@linux.dev>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZGx1jT4nQ9HEVWSE@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 13:43, Oliver Upton wrote:
> On Mon, May 22, 2023 at 05:22:44PM +0100, Mark Brown wrote:
>> Convert OSLAR_EL1 to automatic generation as per DDI0601 2023-03. No
>> functional change.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> ---
>>  arch/arm64/include/asm/sysreg.h | 3 ---
>>  arch/arm64/tools/sysreg         | 5 +++++
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 09de958e79ed..3b51e532caa9 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -140,9 +140,6 @@
>>  #define SYS_DBGWCRn_EL1(n)		sys_reg(2, 0, 0, n, 7)
>>  #define SYS_MDRAR_EL1			sys_reg(2, 0, 1, 0, 0)
>>  
>> -#define SYS_OSLAR_EL1			sys_reg(2, 0, 1, 0, 4)
>> -#define OSLAR_EL1_OSLK			BIT(0)
>> -
>>  #define SYS_OSLSR_EL1			sys_reg(2, 0, 1, 1, 4)
>>  #define OSLSR_EL1_OSLM_MASK		(BIT(3) | BIT(0))
>>  #define OSLSR_EL1_OSLM_NI		0
> 
> Should the OSLSR_EL1 definitions be rolled over to the generated scheme
> as well?

Agreed, was about to ask the same question :) Any reason it got skipped ?

> 
>> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
>> index a5ae0e19fc9f..84df0b7feb45 100644
>> --- a/arch/arm64/tools/sysreg
>> +++ b/arch/arm64/tools/sysreg
>> @@ -83,6 +83,11 @@ Res0	5:1
>>  Field	0	SS
>>  EndSysreg
>>  
>> +Sysreg	OSLAR_EL1	2	0	1	0	4
>> +Res0	63:1
>> +Field	0	OSLK
>> +EndSysreg
>> +
>>  Sysreg ID_PFR0_EL1	3	0	0	1	0
>>  Res0	63:32
>>  UnsignedEnum	31:28	RAS
>>
>> -- 
>> 2.30.2
>>
> 
