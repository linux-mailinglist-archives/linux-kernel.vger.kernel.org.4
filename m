Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F194702478
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbjEOGW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjEOGW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:22:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F6FF1FE8;
        Sun, 14 May 2023 23:22:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6CA2F4;
        Sun, 14 May 2023 23:23:02 -0700 (PDT)
Received: from [10.163.71.10] (unknown [10.163.71.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 769EE3F7BD;
        Sun, 14 May 2023 23:22:12 -0700 (PDT)
Message-ID: <168e26b3-e995-88ad-b0a0-d917313956c8@arm.com>
Date:   Mon, 15 May 2023 11:52:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V9 02/10] arm64/perf: Add BRBE registers and fields
To:     Yang Shen <shenyang39@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230315051444.1683170-1-anshuman.khandual@arm.com>
 <20230315051444.1683170-3-anshuman.khandual@arm.com>
 <3a8ae180-5a0f-7996-58de-edb0e370e4f5@huawei.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <3a8ae180-5a0f-7996-58de-edb0e370e4f5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/23 14:02, Yang Shen wrote:
> 
> 
> 在 2023/3/15 13:14, Anshuman Khandual 写道:
>> This adds BRBE related register definitions and various other related field
>> macros there in. These will be used subsequently in a BRBE driver which is
>> being added later on.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/arm64/include/asm/sysreg.h | 103 +++++++++++++++++++++
>>   arch/arm64/tools/sysreg         | 159 ++++++++++++++++++++++++++++++++
>>   2 files changed, 262 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 9e3ecba3c4e6..b3bc03ee22bd 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -165,6 +165,109 @@
>>   #define SYS_DBGDTRTX_EL0        sys_reg(2, 3, 0, 5, 0)
>>   #define SYS_DBGVCR32_EL2        sys_reg(2, 4, 0, 7, 0)
>>   +#define __SYS_BRBINFO(n)        sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 0))
>> +#define __SYS_BRBSRC(n)            sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 1))
>> +#define __SYS_BRBTGT(n)            sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 2))
>> +
>> +#define SYS_BRBINF0_EL1            __SYS_BRBINFO(0)
>> +#define SYS_BRBINF1_EL1            __SYS_BRBINFO(1)
>> +#define SYS_BRBINF2_EL1            __SYS_BRBINFO(2)
>> +#define SYS_BRBINF3_EL1            __SYS_BRBINFO(3)
>> +#define SYS_BRBINF4_EL1            __SYS_BRBINFO(4)
>> +#define SYS_BRBINF5_EL1            __SYS_BRBINFO(5)
>> +#define SYS_BRBINF6_EL1            __SYS_BRBINFO(6)
>> +#define SYS_BRBINF7_EL1            __SYS_BRBINFO(7)
>> +#define SYS_BRBINF8_EL1            __SYS_BRBINFO(8)
>> +#define SYS_BRBINF9_EL1            __SYS_BRBINFO(9)
>> +#define SYS_BRBINF10_EL1        __SYS_BRBINFO(10)
>> +#define SYS_BRBINF11_EL1        __SYS_BRBINFO(11)
>> +#define SYS_BRBINF12_EL1        __SYS_BRBINFO(12)
>> +#define SYS_BRBINF13_EL1        __SYS_BRBINFO(13)
>> +#define SYS_BRBINF14_EL1        __SYS_BRBINFO(14)
>> +#define SYS_BRBINF15_EL1        __SYS_BRBINFO(15)
>> +#define SYS_BRBINF16_EL1        __SYS_BRBINFO(16)
>> +#define SYS_BRBINF17_EL1        __SYS_BRBINFO(17)
>> +#define SYS_BRBINF18_EL1        __SYS_BRBINFO(18)
>> +#define SYS_BRBINF19_EL1        __SYS_BRBINFO(19)
>> +#define SYS_BRBINF20_EL1        __SYS_BRBINFO(20)
>> +#define SYS_BRBINF21_EL1        __SYS_BRBINFO(21)
>> +#define SYS_BRBINF22_EL1        __SYS_BRBINFO(22)
>> +#define SYS_BRBINF23_EL1        __SYS_BRBINFO(23)
>> +#define SYS_BRBINF24_EL1        __SYS_BRBINFO(24)
>> +#define SYS_BRBINF25_EL1        __SYS_BRBINFO(25)
>> +#define SYS_BRBINF26_EL1        __SYS_BRBINFO(26)
>> +#define SYS_BRBINF27_EL1        __SYS_BRBINFO(27)
>> +#define SYS_BRBINF28_EL1        __SYS_BRBINFO(28)
>> +#define SYS_BRBINF29_EL1        __SYS_BRBINFO(29)
>> +#define SYS_BRBINF30_EL1        __SYS_BRBINFO(30)
>> +#define SYS_BRBINF31_EL1        __SYS_BRBINFO(31)
>> +
>> +#define SYS_BRBSRC0_EL1            __SYS_BRBSRC(0)
>> +#define SYS_BRBSRC1_EL1            __SYS_BRBSRC(1)
>> +#define SYS_BRBSRC2_EL1            __SYS_BRBSRC(2)
>> +#define SYS_BRBSRC3_EL1            __SYS_BRBSRC(3)
>> +#define SYS_BRBSRC4_EL1            __SYS_BRBSRC(4)
>> +#define SYS_BRBSRC5_EL1            __SYS_BRBSRC(5)
>> +#define SYS_BRBSRC6_EL1            __SYS_BRBSRC(6)
>> +#define SYS_BRBSRC7_EL1            __SYS_BRBSRC(7)
>> +#define SYS_BRBSRC8_EL1            __SYS_BRBSRC(8)
>> +#define SYS_BRBSRC9_EL1            __SYS_BRBSRC(9)
>> +#define SYS_BRBSRC10_EL1        __SYS_BRBSRC(10)
>> +#define SYS_BRBSRC11_EL1        __SYS_BRBSRC(11)
>> +#define SYS_BRBSRC12_EL1        __SYS_BRBSRC(12)
>> +#define SYS_BRBSRC13_EL1        __SYS_BRBSRC(13)
>> +#define SYS_BRBSRC14_EL1        __SYS_BRBSRC(14)
>> +#define SYS_BRBSRC15_EL1        __SYS_BRBSRC(15)
>> +#define SYS_BRBSRC16_EL1        __SYS_BRBSRC(16)
>> +#define SYS_BRBSRC17_EL1        __SYS_BRBSRC(17)
>> +#define SYS_BRBSRC18_EL1        __SYS_BRBSRC(18)
>> +#define SYS_BRBSRC19_EL1        __SYS_BRBSRC(19)
>> +#define SYS_BRBSRC20_EL1        __SYS_BRBSRC(20)
>> +#define SYS_BRBSRC21_EL1        __SYS_BRBSRC(21)
>> +#define SYS_BRBSRC22_EL1        __SYS_BRBSRC(22)
>> +#define SYS_BRBSRC23_EL1        __SYS_BRBSRC(23)
>> +#define SYS_BRBSRC24_EL1        __SYS_BRBSRC(24)
>> +#define SYS_BRBSRC25_EL1        __SYS_BRBSRC(25)
>> +#define SYS_BRBSRC26_EL1        __SYS_BRBSRC(26)
>> +#define SYS_BRBSRC27_EL1        __SYS_BRBSRC(27)
>> +#define SYS_BRBSRC28_EL1        __SYS_BRBSRC(28)
>> +#define SYS_BRBSRC29_EL1        __SYS_BRBSRC(29)
>> +#define SYS_BRBSRC30_EL1        __SYS_BRBSRC(30)
>> +#define SYS_BRBSRC31_EL1        __SYS_BRBSRC(31)
>> +
>> +#define SYS_BRBTGT0_EL1            __SYS_BRBTGT(0)
>> +#define SYS_BRBTGT1_EL1            __SYS_BRBTGT(1)
>> +#define SYS_BRBTGT2_EL1            __SYS_BRBTGT(2)
>> +#define SYS_BRBTGT3_EL1            __SYS_BRBTGT(3)
>> +#define SYS_BRBTGT4_EL1            __SYS_BRBTGT(4)
>> +#define SYS_BRBTGT5_EL1            __SYS_BRBTGT(5)
>> +#define SYS_BRBTGT6_EL1            __SYS_BRBTGT(6)
>> +#define SYS_BRBTGT7_EL1            __SYS_BRBTGT(7)
>> +#define SYS_BRBTGT8_EL1            __SYS_BRBTGT(8)
>> +#define SYS_BRBTGT9_EL1            __SYS_BRBTGT(9)
>> +#define SYS_BRBTGT10_EL1        __SYS_BRBTGT(10)
>> +#define SYS_BRBTGT11_EL1        __SYS_BRBTGT(11)
>> +#define SYS_BRBTGT12_EL1        __SYS_BRBTGT(12)
>> +#define SYS_BRBTGT13_EL1        __SYS_BRBTGT(13)
>> +#define SYS_BRBTGT14_EL1        __SYS_BRBTGT(14)
>> +#define SYS_BRBTGT15_EL1        __SYS_BRBTGT(15)
>> +#define SYS_BRBTGT16_EL1        __SYS_BRBTGT(16)
>> +#define SYS_BRBTGT17_EL1        __SYS_BRBTGT(17)
>> +#define SYS_BRBTGT18_EL1        __SYS_BRBTGT(18)
>> +#define SYS_BRBTGT19_EL1        __SYS_BRBTGT(19)
>> +#define SYS_BRBTGT20_EL1        __SYS_BRBTGT(20)
>> +#define SYS_BRBTGT21_EL1        __SYS_BRBTGT(21)
>> +#define SYS_BRBTGT22_EL1        __SYS_BRBTGT(22)
>> +#define SYS_BRBTGT23_EL1        __SYS_BRBTGT(23)
>> +#define SYS_BRBTGT24_EL1        __SYS_BRBTGT(24)
>> +#define SYS_BRBTGT25_EL1        __SYS_BRBTGT(25)
>> +#define SYS_BRBTGT26_EL1        __SYS_BRBTGT(26)
>> +#define SYS_BRBTGT27_EL1        __SYS_BRBTGT(27)
>> +#define SYS_BRBTGT28_EL1        __SYS_BRBTGT(28)
>> +#define SYS_BRBTGT29_EL1        __SYS_BRBTGT(29)
>> +#define SYS_BRBTGT30_EL1        __SYS_BRBTGT(30)
>> +#define SYS_BRBTGT31_EL1        __SYS_BRBTGT(31)
>> +
>>   #define SYS_MIDR_EL1            sys_reg(3, 0, 0, 0, 0)
>>   #define SYS_MPIDR_EL1            sys_reg(3, 0, 0, 0, 5)
>>   #define SYS_REVIDR_EL1            sys_reg(3, 0, 0, 0, 6)
>> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
>> index dd5a9c7e310f..d74d9dbe18a7 100644
>> --- a/arch/arm64/tools/sysreg
>> +++ b/arch/arm64/tools/sysreg
>> @@ -924,6 +924,165 @@ UnsignedEnum    3:0    BT
>>   EndEnum
>>   EndSysreg
>>   +
>> +SysregFields BRBINFx_EL1
>> +Res0    63:47
>> +Field    46    CCU
>> +Field    45:32    CC
>> +Res0    31:18
>> +Field    17    LASTFAILED
>> +Field    16    T
>> +Res0    15:14
>> +Enum    13:8        TYPE
> 
> Hi Anshuman,
> 
> I met a problem when built kernel which was based on 6.3-rc1. Here is the error log:
>     GEN     Makefile
>     GEN     arch/arm64/include/generated/asm/sysreg-defs.h
> Error at 936: unexpected Enum (inside SysregFields)
> 
> I think this is because the 'SysregFields' doesn't support the 'Enum' type region.
> And this problem can be fixed when I roll back this part to v7.
> 
> Do I need to apply some patches or do some other configures?

Yes, the following patch was required, but it's now merged mainline.

https://lore.kernel.org/all/20230306114836.2575432-1-mark.rutland@arm.com/
