Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB296DF555
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDLMeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDLMeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:34:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A52B27DA8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:34:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80449D75;
        Wed, 12 Apr 2023 05:35:01 -0700 (PDT)
Received: from [10.34.100.129] (pierre123.nice.arm.com [10.34.100.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862C83F73F;
        Wed, 12 Apr 2023 05:34:15 -0700 (PDT)
Message-ID: <d7a36615-896b-0f13-a1f6-761715ce460f@arm.com>
Date:   Wed, 12 Apr 2023 14:34:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] cacheinfo: Check sib_leaf in
 cache_leaves_are_shared()
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        Jeremy Linton <jeremy.linton@arm.com>
References: <20230412071809.12670-1-pierre.gondois@arm.com>
 <20230412071809.12670-2-pierre.gondois@arm.com>
 <20230412-viewpoint-refutable-a31f3657093c@wendy>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230412-viewpoint-refutable-a31f3657093c@wendy>
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

Hello Conor,

On 4/12/23 13:27, Conor Dooley wrote:
> On Wed, Apr 12, 2023 at 09:18:04AM +0200, Pierre Gondois wrote:
>> If 'this_leaf' is a L2 cache (or higher) and 'sib_leaf' is a L1 cache,
>> the caches are detected as shared. Indeed, cache_leaves_are_shared()
>> only checks the cache level of 'this_leaf' when 'sib_leaf''s cache
>> level should also be checked.
> 
> I have to say, I'm a wee bit confused reading this patch - although it's
> likely that I have just confused myself here.
> 
> The comment reads "For non DT/ACPI systems, assume unique level 1 caches,
> system-wide shared caches for all other levels".
> Does this mean all level 1 caches are unique & all level N caches are
> shared with all other level N caches, but not with level M caches?
> (M != N; M, N > 1)

I think the real answer to your question is in the last paragraph,
but just in case:

Each CPU manages the list of cacheinfo struct it has access to,
and this list is per-CPU.
cache_shared_cpu_map_setup() checks whether two cacheinfo struct are
representing the same cache (for 2 CPU lists). If yes, their
shared_cpu_map is updated.

If there is DT/ACPI information, a cacheid/fw_token is associated
with each cacheinfo struct. This allows to easily check when two
struct are representing the same cache.

Otherwise it is assumed here that L1 caches are private (so not shared)
and other L2-N caches are shared, i.e. the interface below advertise the
cache as available from other CPUs.
/sys/devices/system/cpu/cpu0/cache/indexX/shared_cpu_list

> 
> Is this patches goal to make sure that if this_leaf is level 2 and
> sib_leaf is level 1 that these are not detected as shared, since level
> one caches are meant to be unique?

Yes exact.

> 
> The previous logic checked only this_leaf's level, and declared things
> shared if this_leaf is not a level 1 cache.
> What happens here if this_leaf->level == 1 and sib_leaf->level == 2?
> That'll be detected as shared, in a contradiction of the comment above
> it, no?

Yes, there is a contradiction. The condition should be '&&':
   (this_leaf->level != 1) && (sib_leaf->level != 1)
I made a bad rebase and the corrected code ended up in PATCH 3/3.
Sorry for that. I ll correct it in the v3.

Thanks for the review,
Regards,
Pierre

> 
> As you never state the actual problem with the current code, I'm not
> entirely sure if I am making a fool of myself or not here.
> 
> Probably making a fool, that's par for the course ;)
> 
> Thanks,
> Conor.
> 
>>
>> Check 'sib_leaf->level'. Also update the comment as the function is
>> called when populating 'shared_cpu_map'.
>>
>> Fixes: f16d1becf96f ("cacheinfo: Use cache identifiers to check if the caches are shared if available")
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/base/cacheinfo.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>> index f3903d002819..e7ad6aba5f97 100644
>> --- a/drivers/base/cacheinfo.c
>> +++ b/drivers/base/cacheinfo.c
>> @@ -38,11 +38,10 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
>>   {
>>   	/*
>>   	 * For non DT/ACPI systems, assume unique level 1 caches,
>> -	 * system-wide shared caches for all other levels. This will be used
>> -	 * only if arch specific code has not populated shared_cpu_map
>> +	 * system-wide shared caches for all other levels.
>>   	 */
>>   	if (!(IS_ENABLED(CONFIG_OF) || IS_ENABLED(CONFIG_ACPI)))
>> -		return !(this_leaf->level == 1);
>> +		return (this_leaf->level != 1) || (sib_leaf->level != 1);
>>   
>>   	if ((sib_leaf->attributes & CACHE_ID) &&
>>   	    (this_leaf->attributes & CACHE_ID))
>> -- 
>> 2.25.1
>>
