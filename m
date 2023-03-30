Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2E6D018D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjC3Knz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjC3Knn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:43:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 214699762
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:43:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 185102F4;
        Thu, 30 Mar 2023 03:44:21 -0700 (PDT)
Received: from [10.57.54.254] (unknown [10.57.54.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 419A43F663;
        Thu, 30 Mar 2023 03:43:35 -0700 (PDT)
Message-ID: <068c45ae-dd60-7ab6-ee08-64f95a85f510@arm.com>
Date:   Thu, 30 Mar 2023 11:43:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] iommu: PGTABLE_LPAE is also for RISCV
Content-Language: en-GB
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, geert+renesas@glider.be
References: <20230330060105.29460-1-rdunlap@infradead.org>
 <e1b6f12a-899b-4985-8725-556bcb5d0991@spud>
 <CAMuHMdW2r1f7C_BdXn9BnDktLwHjBA_0Kvq6OeLJ1sZ7azhqkg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMuHMdW2r1f7C_BdXn9BnDktLwHjBA_0Kvq6OeLJ1sZ7azhqkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-30 08:31, Geert Uytterhoeven wrote:
> Hi Conor,
> 
> On Thu, Mar 30, 2023 at 8:25 AM Conor Dooley <conor.dooley@microchip.com> wrote:
>> On Wed, Mar 29, 2023 at 11:01:05PM -0700, Randy Dunlap wrote:
>>> On riscv64, linux-next-20233030 (and for several days earlier),
>>> there is a kconfig warning:
>>>
>>> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>>>    Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>>>    Selected by [y]:
>>>    - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>>>
>>> and build errors:
>>>
>>> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L140':
>>> io-pgtable-arm.c:(.init.text+0x1e8): undefined reference to `alloc_io_pgtable_ops'
>>> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L168':
>>> io-pgtable-arm.c:(.init.text+0xab0): undefined reference to `free_io_pgtable_ops'
>>> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L140':
>>> ipmmu-vmsa.c:(.text+0xbc4): undefined reference to `free_io_pgtable_ops'
>>> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L0 ':
>>> ipmmu-vmsa.c:(.text+0x145e): undefined reference to `alloc_io_pgtable_ops'
>>>
>>> Add RISCV as an allowed ARCH dependency to fix these problems.
>>>
>>> Fixes: d286a58bc8f4 ("iommu: Tidy up io-pgtable dependencies")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: iommu@lists.linux.dev
>>> Cc: Conor Dooley <conor@kernel.org>
>>> Cc: linux-riscv@lists.infradead.org
>>> ---
>>>   drivers/iommu/Kconfig |    2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>> --- a/drivers/iommu/Kconfig
>>> +++ b/drivers/iommu/Kconfig
>>> @@ -32,7 +32,7 @@ config IOMMU_IO_PGTABLE
>>>   config IOMMU_IO_PGTABLE_LPAE
>>>        bool "ARMv7/v8 Long Descriptor Format"
>>
>> I'm probably missing something here, but why would we want to enable
>> "ARMv7/v8 Long Descriptor Format" on RISC-V?
> 
> Indeed, we should not enable it, unless compile-testing.
> 
>> Would it not be better to make the Renesas depend on, rather than
>> select the option? It does seem highly arch specific, and I feel like
>> Geert previously mentioned that the RZ/Five (their RISC-V offering)
>> didn't use it.
> 
> I think the IPMMU_VMSA dependency should gain
> 
>          depends on ARM || ARM64 || COMPILE_TEST

Indeed, I thought we'd settled on something like that in the previous 
thread(s) on ARCH_RENESAS vs. RV32, but I guess nobody got round to 
actually respininng the patch (possibly since my refactoring here ended 
up papering over the immediate RV32 issue).

Cheers,
Robin.

>>>        select IOMMU_IO_PGTABLE
>>> -     depends on ARM || ARM64 || COMPILE_TEST
>>> +     depends on ARM || ARM64 || RISCV || COMPILE_TEST
>>>        depends on !GENERIC_ATOMIC64    # for cmpxchg64()
>>>        help
>>>          Enable support for the ARM long descriptor pagetable format.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
