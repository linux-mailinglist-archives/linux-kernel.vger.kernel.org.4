Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2376D906E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjDFH2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjDFH2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:28:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 506AF6E88
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:28:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1CA316F8;
        Thu,  6 Apr 2023 00:29:29 -0700 (PDT)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B173A3F73F;
        Thu,  6 Apr 2023 00:28:42 -0700 (PDT)
Message-ID: <d368e1b5-8094-ee30-9812-3a321e8bedb7@arm.com>
Date:   Thu, 6 Apr 2023 09:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] cacheinfo: Add use_arch[|_cache]_info field/function
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Gavin Shan <gshan@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230327115953.788244-1-pierre.gondois@arm.com>
 <20230327115953.788244-4-pierre.gondois@arm.com>
 <20230327121734.GB31342@willie-the-truck>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230327121734.GB31342@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Will,

On 3/27/23 14:17, Will Deacon wrote:
> On Mon, Mar 27, 2023 at 01:59:51PM +0200, Pierre Gondois wrote:
>> The cache information can be extracted from either a Device
>> Tree (DT), the PPTT ACPI table, or arch registers (clidr_el1
>> for arm64).
>>
>> The clidr_el1 register is used only if DT/ACPI information is not
>> available. It does not states how caches are shared among CPUs.
>>
>> Add a use_arch_cache_info field/function to identify when the
>> DT/ACPI doesn't provide cache information. Use this information
>> to assume L1 caches are privates and L2 and higher are shared among
>> all CPUs.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   arch/arm64/kernel/cacheinfo.c |  5 +++++
>>   drivers/base/cacheinfo.c      | 20 ++++++++++++++++++--
>>   include/linux/cacheinfo.h     |  2 ++
>>   3 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
>> index c307f69e9b55..b6306cda0fa7 100644
>> --- a/arch/arm64/kernel/cacheinfo.c
>> +++ b/arch/arm64/kernel/cacheinfo.c
>> @@ -96,3 +96,8 @@ int populate_cache_leaves(unsigned int cpu)
>>   	}
>>   	return 0;
>>   }
>> +
>> +bool use_arch_cache_info(unsigned int cpu)
>> +{
>> +	return true;
>> +}
> 
> It would be a lot nicer if this was a static inline function in a header
> rather than a weak symbol.

I am not sure I see where the static inline function should be added.
Do you prefer to have function like the following in
include/linux/cacheinfo.h ?

static inline bool use_arch_cache_info(unsigned int cpu)
{
#if defined(CONFIG_ARM64)
	return true;
#else
	return false;
#endif
}

Regards,
Pierre

> 
> Will
