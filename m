Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B4D6A83F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCBOGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBOGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:06:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2309F498A3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:06:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 096BB1FB;
        Thu,  2 Mar 2023 06:07:24 -0800 (PST)
Received: from [10.1.25.48] (FVFF763DQ05P.cambridge.arm.com [10.1.25.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F8143F587;
        Thu,  2 Mar 2023 06:06:38 -0800 (PST)
Message-ID: <f9b316ad-fe27-cb3a-493e-70f2ced8a6f7@arm.com>
Date:   Thu, 2 Mar 2023 14:06:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [RFC kvmtool 18/31] arm64: Populate initial realm contents
To:     Piotr Sawicki <piotr.sawickas@gmail.com>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joey Gouly <Joey.Gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, linux-coco@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
 <20230127113932.166089-1-suzuki.poulose@arm.com>
 <20230127113932.166089-19-suzuki.poulose@arm.com>
 <7a0e256d-3ce1-3218-c930-ed518a679b8b@gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <7a0e256d-3ce1-3218-c930-ed518a679b8b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr

On 02/03/2023 14:03, Piotr Sawicki wrote:
> Hi,
> 
>> From: Alexandru Elisei <alexandru.elisei@arm.com>
>>
>> Populate the realm memory with the initial contents, which include
>> the device tree blob, the kernel image, and initrd, if specified,
>> or the firmware image.
>>
>> Populating an image in the realm involves two steps:
>>   a) Mark the IPA area as RAM - INIT_IPA_REALM
>>   b) Load the contents into the IPA - POPULATE_REALM
>>
>> Wherever we know the actual size of an image in memory, we make
>> sure the "memory area" is initialised to RAM.
>> e.g., Linux kernel image size from the header which includes the bss etc.
>> The "file size" on disk for the Linux image is much smaller.
>> We mark the region of size Image.header.size as RAM (a), from the kernel
>> load address. And load the Image file into the memory (b) above.
>> At the moment we only detect the Arm64 Linux Image header format.
>>
>> Since we're already touching the code that copies the
>> initrd in guest memory, let's do a bit of cleaning and remove a
>> useless local variable.
>>
>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> [ Make sure the Linux kernel image area is marked as RAM ]
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>


>> diff --git a/arm/kvm.c b/arm/kvm.c
>> index acb627b2..57c5b5f7 100644
>> --- a/arm/kvm.c
>> +++ b/arm/kvm.c
>> @@ -6,6 +6,7 @@
>>   #include "kvm/fdt.h"
>>   #include "arm-common/gic.h"
>> +#include <asm/realm.h>
>>   #include <sys/resource.h>
>> @@ -167,6 +168,9 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, 
>> int fd_kernel, int fd_initrd,
>>       pr_debug("Loaded kernel to 0x%llx (%llu bytes)",
>>            kvm->arch.kern_guest_start, kvm->arch.kern_size);
> 
> 
> I've noticed that multiple calling of the measurement test from the 
> kvm-unit-tests suite results in different Realm Initial Measurements, 
> although the kernel image is always the same.
> 
> After short investigation, I've found that the RIM starts being 
> different while populating the last 4kB chunk of the kernel image.
> The issue occurs when the image size is not aligned to the page size (4kB).
> 
> After zeroing the unused area of the last chunk, the measurements become 
> repeatable.
> 

That is a good point. We could memset() the remaining bits of the 4K 
page to 0. I will make this change.

Suzuki

