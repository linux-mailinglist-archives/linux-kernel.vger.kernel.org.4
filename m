Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909B46D0B63
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjC3QeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjC3QeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:34:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073E6CC3E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=m8D/JQoBMm2jqOtesJ3nZ3JZ78jqPtB8Jc7muxKTPP8=; b=W9ZqHt6mOwQsZFEUIYww0z/wOr
        kaFA8c9eq2vSOaJ4g2HG18f81mRkDKej1QczX/q2YljhvEo5VcwmUpNw8/0Ne+5HkSK0umkpaEcMv
        7FrIGbv7mgCSXWLpg00r5u58JN6DQ6dqb8lMzM9kfpdhZY/OIGydOXplWCVYJe0Dbz1XXJABUq8lr
        TQYxtmWuOCSkQoVFIjuykgKFbgi+ox/NxSEutQc7uQ33H0KgWDonQ42k0ASBeXzHv2sx1+UavZ1S0
        b9kcarbrW6LPACobFCeMfRjo7eRw7pCZHNGjflkC8lsK7ctZ4E+KP6yugp9y/CctZU9H3D/cq+0Tv
        QZyqjy1w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phvDs-004UmK-18;
        Thu, 30 Mar 2023 16:34:00 +0000
Message-ID: <4dbba30e-9c7a-ec73-8a5b-deda182e7f08@infradead.org>
Date:   Thu, 30 Mar 2023 09:33:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] iommu: PGTABLE_LPAE is also for RISCV
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, geert+renesas@glider.be
References: <20230330060105.29460-1-rdunlap@infradead.org>
 <e1b6f12a-899b-4985-8725-556bcb5d0991@spud>
 <CAMuHMdW2r1f7C_BdXn9BnDktLwHjBA_0Kvq6OeLJ1sZ7azhqkg@mail.gmail.com>
 <b712f5c8-9486-8e4a-63cd-6b176572244f@infradead.org>
 <CAMuHMdX_=T9EB=rE_p9XO2-MtaV3jNkX76_PxYd9wi17NhaYHQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdX_=T9EB=rE_p9XO2-MtaV3jNkX76_PxYd9wi17NhaYHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/30/23 09:11, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Thu, Mar 30, 2023 at 5:48 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 3/30/23 00:31, Geert Uytterhoeven wrote:
>>> On Thu, Mar 30, 2023 at 8:25 AM Conor Dooley <conor.dooley@microchip.com> wrote:
>>>> On Wed, Mar 29, 2023 at 11:01:05PM -0700, Randy Dunlap wrote:
>>>>> On riscv64, linux-next-20233030 (and for several days earlier),
>>>>> there is a kconfig warning:
>>>>>
>>>>> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>>>>>   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>>>>>   Selected by [y]:
>>>>>   - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>>>>>
>>>>> and build errors:
>>>>>
>>>>> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L140':
>>>>> io-pgtable-arm.c:(.init.text+0x1e8): undefined reference to `alloc_io_pgtable_ops'
>>>>> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L168':
>>>>> io-pgtable-arm.c:(.init.text+0xab0): undefined reference to `free_io_pgtable_ops'
>>>>> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L140':
>>>>> ipmmu-vmsa.c:(.text+0xbc4): undefined reference to `free_io_pgtable_ops'
>>>>> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L0 ':
>>>>> ipmmu-vmsa.c:(.text+0x145e): undefined reference to `alloc_io_pgtable_ops'
>>>>>
>>>>> Add RISCV as an allowed ARCH dependency to fix these problems.
>>>>>
>>>>> Fixes: d286a58bc8f4 ("iommu: Tidy up io-pgtable dependencies")
>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>>> Cc: Joerg Roedel <joro@8bytes.org>
>>>>> Cc: Will Deacon <will@kernel.org>
>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>> Cc: iommu@lists.linux.dev
>>>>> Cc: Conor Dooley <conor@kernel.org>
>>>>> Cc: linux-riscv@lists.infradead.org
>>>>> ---
>>>>>  drivers/iommu/Kconfig |    2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>>> --- a/drivers/iommu/Kconfig
>>>>> +++ b/drivers/iommu/Kconfig
>>>>> @@ -32,7 +32,7 @@ config IOMMU_IO_PGTABLE
>>>>>  config IOMMU_IO_PGTABLE_LPAE
>>>>>       bool "ARMv7/v8 Long Descriptor Format"
>>>>
>>>> I'm probably missing something here, but why would we want to enable
>>>> "ARMv7/v8 Long Descriptor Format" on RISC-V?
>>>
>>> Indeed, we should not enable it, unless compile-testing.
>>>
>>>> Would it not be better to make the Renesas depend on, rather than
>>>> select the option? It does seem highly arch specific, and I feel like
>>>> Geert previously mentioned that the RZ/Five (their RISC-V offering)
>>>> didn't use it.
>>>
>>> I think the IPMMU_VMSA dependency should gain
>>>
>>>         depends on ARM || ARM64 || COMPILE_TEST
>>
>> so like this?
>> Or did you mean to drop the ARCH_RENESAS part also?
>>
>>
>>  config IPMMU_VMSA
>>         bool "Renesas VMSA-compatible IPMMU"
>> -       depends on ARCH_RENESAS || COMPILE_TEST
>> +       depends on ARCH_RENESAS || ARM || ARM64 || COMPILE_TEST
> 
> No, you want "depends on (ARCH_RENESAS && (ARM || ARM64)) || COMPILE_TEST",
> which is a bit hard to read.
> 
> Hence I really meant adding that line, i.e.:
> 
>      config IPMMU_VMSA
>            bool "Renesas VMSA-compatible IPMMU"
>            depends on ARCH_RENESAS || COMPILE_TEST
>     +      depends on ARM || ARM64 || COMPILE_TEST
> 

OK, that fixes the kconfig warning and the build errors.
I can read the first method easier that the second one, but I'll
go with your suggestion. Hopefully no one will come along and
"fix it up" but instead muck it up.

Thanks.
-- 
~Randy
