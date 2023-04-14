Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941FC6E1D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDNHdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNHdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:33:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 985F944B2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:33:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B99FF2F4;
        Fri, 14 Apr 2023 00:34:05 -0700 (PDT)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C27643F6C4;
        Fri, 14 Apr 2023 00:33:18 -0700 (PDT)
Message-ID: <c58fa005-49a6-ef46-ded8-c9246d4a989b@arm.com>
Date:   Fri, 14 Apr 2023 09:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/4] cacheinfo: Check cache properties are present in
 DT
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
 <20230413091436.230134-3-pierre.gondois@arm.com>
 <4da53918-839b-4d28-0634-66fd7f38c8bd@gmail.com>
 <20230413195032.bw3yu7a6puqziinx@bogus>
 <d44baa58-8c39-407c-db94-390bc0d12dbe@gmail.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <d44baa58-8c39-407c-db94-390bc0d12dbe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/23 22:06, Florian Fainelli wrote:
> On 4/13/23 12:50, Sudeep Holla wrote:
>> On Thu, Apr 13, 2023 at 11:16:37AM -0700, Florian Fainelli wrote:
>>> On 4/13/23 02:14, Pierre Gondois wrote:
>>>> If a Device Tree (DT) is used, the presence of cache properties is
>>>> assumed. Not finding any is not considered. For arm64 platforms,
>>>> cache information can be fetched from the clidr_el1 register.
>>>> Checking whether cache information is available in the DT
>>>> allows to switch to using clidr_el1.
>>>>
>>>> init_of_cache_level()
>>>> \-of_count_cache_leaves()
>>>> will assume there a 2 cache leaves (L1 data/instruction caches), which
>>>> can be different from clidr_el1 information.
>>>>
>>>> cache_setup_of_node() tries to read cache properties in the DT.
>>>> If there are none, this is considered a success. Knowing no
>>>> information was available would allow to switch to using clidr_el1.
>>>>
>>>> Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count cache leaves")
>>>> Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>>> Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
>>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>>
>>> Humm, it would appear that the cache levels and topology is still provided,
>>> despite the lack of cache properties in the Device Tree which is intended by
>>> this patch set however we lost the size/ways/sets information, could we not
>>> complement the missing properties here?
>>>
>>
>> I am confused. How and from where the information was fetched before this
>> change ?
> 
> I applied Pierre's patches to my tree and then did the following:
> 
> - before means booting with the patches applied and the Device Tree
> providing cache information: {d,i}-cache-{size,line-size,sets} and
> next-level-cache
> 
> - after means removing all of those properties still with the patches
> applied
> 
> My expectation is that if we omit the properties in the Device Tree, we
> will fallback to reading that information out of clidr_el1. However as
> can be seen from the "before" and "after" outputs, there is loss of
> information, as we no longer have the cacheline size, number of
> sets/ways, the rest is valid though.
> 
> So my question is whether this is expected and in scope of what is being
> done here, or not.
> 
>>
>>> If this is out of the scope of what you are doing:
>>>
>>> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
>>>
>>
>> Just looking at the lscpu output before and after, it looks something is
>> broken. What am I missing here ?
>>
> 
> What is broken in the "before" output? It contains the entire set of
> possible information we know about the caches. As for the "after", well
> yes there is information missing, the whole point of my email actually...

I think this is the expected behaviour. There are other registers containing
cache information, like CCSIDR_EL1 and CCSIDR2_EL1.
However the information contained in CCSIDR_EL1 cannot really be trusted, cf [1]:
| You cannot make any inference about the actual sizes of caches based
| on these parametersand Arm spec.

and for CCSIDR2_EL1 I assume that knowing the number of cache sets is not a
crucial information.

So if there is no cache information in DT/ACPI, the only information extracted
from registers is the level/type of caches coming from CLIDR_EL1.

Regards,
Pierre

[1] https://lore.kernel.org/all/1489177945-8590-2-git-send-email-will.deacon@arm.com/
