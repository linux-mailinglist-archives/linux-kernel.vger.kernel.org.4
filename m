Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D985B3A84
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIIOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIIORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:17:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A0C112D574
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:17:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1676C165C;
        Fri,  9 Sep 2022 07:17:29 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E170B3F93E;
        Fri,  9 Sep 2022 07:17:20 -0700 (PDT)
Message-ID: <28b35935-4e7f-2bd5-dda5-ed81402a527e@arm.com>
Date:   Fri, 9 Sep 2022 15:17:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] Report support for optional ARMv8.2 half-precision
 floating point extension
Content-Language: en-GB
To:     George Pee <georgepee@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Austin Kim <austindh.kim@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220901141307.2361752-1-georgepee@gmail.com>
 <f765da5c-d484-adf2-e1bb-77011780dc0b@arm.com>
 <CAKj0CMv1EY5YCeQ4G6PnGP=XfELJkkN5BaN8W1TGe0fOTXfJBw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAKj0CMv1EY5YCeQ4G6PnGP=XfELJkkN5BaN8W1TGe0fOTXfJBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-09 14:34, George Pee wrote:
> Adding the hwcap was part of the diagnosis process-- I added it just
> to make sure that the cpu in question supported the optional
> extension.
> It seems like it could be useful to be able to check for support in
> /proc/cpuinfo.

Sure, but "support" is about more than just what happens to be present 
in hardware. Observe that you can build the 32-bit kernel with 
CONFIG_VFP=n, and it then does not report and VFP or NEON hwcaps, 
because those features will not be usable in that configuration, even if 
you know the hardware implements them.

Note that this looks different on arm64, since there we always expect to 
have FPSIMD hardware available, so support in the kernel is 
unconditional, plus that kernel support is also a lot simpler since we 
don't have a soft-float ABI with all the corresponding trapping stuff 
either.

It might just be the case here that the call_fpe logic needs a bit of 
tweaking to provide proper support, but I'm not sufficiently familiar 
with the ARM VFP code in general to be sure.

Thanks,
Robin.

> On Fri, Sep 9, 2022 at 7:46 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2022-09-01 15:13, george pee wrote:
>>> Report as fphp to be consistent with arm64
>>
>> Wasn't the original problem that the VFP support code doesn't understand
>> the new FP16 instruction encodings, so in practice they don't actually
>> work reliably? Exposing a hwcap to say they're functional doesn't
>> inherently make them functional - if there is already another patch
>> somewhere for that, it should be made clear that this depends on it.
>>
>> Robin.
>>
>>> Signed-off-by: george pee <georgepee@gmail.com>
>>> ---
>>>    arch/arm/include/uapi/asm/hwcap.h | 1 +
>>>    arch/arm/kernel/setup.c           | 1 +
>>>    arch/arm/vfp/vfpmodule.c          | 2 ++
>>>    3 files changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
>>> index 990199d8b7c6..f975845ce5d3 100644
>>> --- a/arch/arm/include/uapi/asm/hwcap.h
>>> +++ b/arch/arm/include/uapi/asm/hwcap.h
>>> @@ -28,6 +28,7 @@
>>>    #define HWCAP_IDIV  (HWCAP_IDIVA | HWCAP_IDIVT)
>>>    #define HWCAP_LPAE  (1 << 20)
>>>    #define HWCAP_EVTSTRM       (1 << 21)
>>> +#define HWCAP_FPHP   (1 << 22)
>>>
>>>    /*
>>>     * HWCAP2 flags - for elf_hwcap2 (in kernel) and AT_HWCAP2
>>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>>> index 1e8a50a97edf..6694ced0552a 100644
>>> --- a/arch/arm/kernel/setup.c
>>> +++ b/arch/arm/kernel/setup.c
>>> @@ -1249,6 +1249,7 @@ static const char *hwcap_str[] = {
>>>        "vfpd32",
>>>        "lpae",
>>>        "evtstrm",
>>> +     "fphp",
>>>        NULL
>>>    };
>>>
>>> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
>>> index 2cb355c1b5b7..cef8c64ce8bd 100644
>>> --- a/arch/arm/vfp/vfpmodule.c
>>> +++ b/arch/arm/vfp/vfpmodule.c
>>> @@ -831,6 +831,8 @@ static int __init vfp_init(void)
>>>
>>>                        if ((fmrx(MVFR1) & 0xf0000000) == 0x10000000)
>>>                                elf_hwcap |= HWCAP_VFPv4;
>>> +                     if ((fmrx(MVFR1) & 0x0f000000) == 0x03000000)
>>> +                             elf_hwcap |= HWCAP_FPHP;
>>>                }
>>>        /* Extract the architecture version on pre-cpuid scheme */
>>>        } else {
