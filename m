Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F23E69EF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjBVHIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjBVHIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:08:30 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6A29161
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:08:28 -0800 (PST)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PM6dY3m1XzKpx7;
        Wed, 22 Feb 2023 15:06:25 +0800 (CST)
Received: from [10.67.111.232] (10.67.111.232) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Wed, 22 Feb 2023 15:08:17 +0800
Message-ID: <b6f596c9-b246-e1d8-0020-64e9b56c3914@huawei.com>
Date:   Wed, 22 Feb 2023 15:08:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] arm64: Optimize the comparison of unsigned
 expressions to avoid compiling error
To:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
        <kristina.martsenko@arm.com>, <james.morse@arm.com>,
        <maz@kernel.org>, <samitolvanen@google.com>,
        <andreyknvl@gmail.com>, <masahiroy@kernel.org>,
        <joey.gouly@arm.com>, <anshuman.khandual@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghai38@huawei.com>
References: <20230221012740.2929481-1-linyujun809@huawei.com>
 <Y/SewFthY/rGct7C@FVFF77S0Q05N>
 <CAMj1kXHyv1_56-CdX-egQTxnJn5ob15=TrfSOGmp+s019EfT2w@mail.gmail.com>
From:   "linyujun (C)" <linyujun809@huawei.com>
In-Reply-To: <CAMj1kXHyv1_56-CdX-egQTxnJn5ob15=TrfSOGmp+s019EfT2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.232]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500026.china.huawei.com (7.221.188.247)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your advice


在 2023/2/21 23:10, Ard Biesheuvel 写道:
> On Tue, 21 Feb 2023 at 11:37, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Tue, Feb 21, 2023 at 09:27:40AM +0800, Lin Yujun wrote:
>>> while compile arch/arm64/include/asm/cpufeature.h with
>>> -Werror=type-limits enabled, errors shown as below:
>>>
>>> ./arch/arm64/include/asm/cpufeature.h: In function 'system_supports_4kb_granule':
>>> ./arch/arm64/include/asm/cpufeature.h:653:14: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
>>>    return (val >= ID_AA64MMFR0_TGRAN4_SUPPORTED_MIN) &&
>>>                ^~
>>> ./arch/arm64/include/asm/cpufeature.h: In function 'system_supports_64kb_granule':
>>> ./arch/arm64/include/asm/cpufeature.h:666:14: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
>>>    return (val >= ID_AA64MMFR0_TGRAN64_SUPPORTED_MIN) &&
>>>                ^~
> The usefulness of this diagnostic is debatable even when the right
> hand is a literal '0' but warning about symbolic constants like this
> is actively evil.
>
> In general, preprocessor #defined values can depend on Kconfig
> settings or other build configuration switches, and this warning
> encourages us to remove the expression altogether, which could mean
> introducing a bug if the macro may assume values >0 in other
> configurations.
>
> Ergo, we must ignore -Wtype-limits until it is fixed, and can at least
> distinguish literal 0 constants from ones instantiated by a CPP macro.
>
>
>> When is the `-Werror=type-limits` flag enabled by the build system?
>>
>> We have patterns like this all over the kernel, and I don't think this is
>> indicative of a real problem, and I don't think that we need to change code to
>> make this warning disappear.
>>
>>> Modify the return judgment statement, use
>>> "((val - min) < (val - max - 1))" to confirm that returns
>>> true in “min <= val <= max” cases, false in other cases.
>> That expression is far less clear than the existing code, so I do not think
>> that is a good idea.
>>
>>> Fixes: 79d82cbcbb3d ("arm64/kexec: Test page size support with new TGRAN range values")
>> What functional error does this fix?
>>
>> What configuration is broken?
>>
>> Thanks,
>> Mark.
>>
>>> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
>>> ---
>>>   arch/arm64/include/asm/cpufeature.h | 18 ++++++++++++------
>>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>>> index 03d1c9d7af82..0a6bda025141 100644
>>> --- a/arch/arm64/include/asm/cpufeature.h
>>> +++ b/arch/arm64/include/asm/cpufeature.h
>>> @@ -54,6 +54,9 @@ enum ftr_type {
>>>   #define FTR_VISIBLE_IF_IS_ENABLED(config)            \
>>>        (IS_ENABLED(config) ? FTR_VISIBLE : FTR_HIDDEN)
>>>
>>> +#define IN_RANGE_INCLUSIVE(val, min, max)            \
>>> +     (((val) - (min)) < ((val) - (max) - 1))
>>> +
>>>   struct arm64_ftr_bits {
>>>        bool            sign;   /* Value is signed ? */
>>>        bool            visible;
>>> @@ -693,8 +696,9 @@ static inline bool system_supports_4kb_granule(void)
>>>        val = cpuid_feature_extract_unsigned_field(mmfr0,
>>>                                                ID_AA64MMFR0_EL1_TGRAN4_SHIFT);
>>>
>>> -     return (val >= ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN) &&
>>> -            (val <= ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX);
>>> +     return IN_RANGE_INCLUSIVE(val,
>>> +             ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN,
>>> +             ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX);
>>>   }
>>>
>>>   static inline bool system_supports_64kb_granule(void)
>>> @@ -706,8 +710,9 @@ static inline bool system_supports_64kb_granule(void)
>>>        val = cpuid_feature_extract_unsigned_field(mmfr0,
>>>                                                ID_AA64MMFR0_EL1_TGRAN64_SHIFT);
>>>
>>> -     return (val >= ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN) &&
>>> -            (val <= ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX);
>>> +     return IN_RANGE_INCLUSIVE(val,
>>> +             ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN,
>>> +             ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX);
>>>   }
>>>
>>>   static inline bool system_supports_16kb_granule(void)
>>> @@ -719,8 +724,9 @@ static inline bool system_supports_16kb_granule(void)
>>>        val = cpuid_feature_extract_unsigned_field(mmfr0,
>>>                                                ID_AA64MMFR0_EL1_TGRAN16_SHIFT);
>>>
>>> -     return (val >= ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN) &&
>>> -            (val <= ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX);
>>> +     return IN_RANGE_INCLUSIVE(val,
>>> +             ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN,
>>> +             ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX);
>>>   }
>>>
>>>   static inline bool system_supports_mixed_endian_el0(void)
>>> --
>>> 2.34.1
>>>
> .
