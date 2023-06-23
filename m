Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6527E73B777
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjFWMgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjFWMgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA888B7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687523717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOH7WzwTI4VChT7oNEuEyQV7U0mT1MDvKKV+43PfARA=;
        b=BHdygKPuwkEQvm9NofhaAU0hq/Kb24wXNiDy9L2Tyvj8P8auUdrSi6LSPwdYEzDzIJk7xk
        g2ijwrlM+A4IlZC82q2vM89lWtyowwojBBM3exarDwTMVzm4Mjm2RT9FPLKyS7DQA/7E3p
        7S6rBumCqDwRM3kL5SAGMogUoPz/J1w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-6o6D4Zt0PvSJbHSm74VnzQ-1; Fri, 23 Jun 2023 08:35:15 -0400
X-MC-Unique: 6o6D4Zt0PvSJbHSm74VnzQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f810b4903fso4336145e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687523713; x=1690115713;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOH7WzwTI4VChT7oNEuEyQV7U0mT1MDvKKV+43PfARA=;
        b=R7Yh1V8GD84bsXAwheAC/vhBFQb5Q4uIgy3jRXF4EWfrZzYJSIHSVMIxSDJxb2sjDB
         G442MfXZPxxiQFyUgdNLLIiXoCnuq65fQJorJBWbaAgLmU6Sn62FojVnTaH9Thcke6LB
         JYRAzK1mw8qj+zoS593AnE3jC6yUENhRVWZ4EZkhzhUB6AtD5P9sb4rE9YOew5GvhY/4
         gXoFrl14pGov1ptMb33k6umuoBn98rwmaD4ibuyaQb98C+94RgBJfHaeWRhYesNyGwjt
         KqacN9+poUwkwF+1KstwclwIu6BpZRc8bQgm2YG1vmwKLziLSjMu+J4jms0xtxTUUtSb
         V+Uw==
X-Gm-Message-State: AC+VfDzAFG2s721lv+G2uxaQXC66fvf3yT1VQc5/ZBlhVLnB0vIp583p
        GMGZDtLM3QwtcYZxWh5QJxGddCvdfJx6w9fEVAecn0bWbzrzv+ag/eqW5998JznHQEd90z4QtMD
        q9NimvYbY/vbnhzHe40fuFOMs
X-Received: by 2002:a05:600c:299:b0:3f9:ba2:5d19 with SMTP id 25-20020a05600c029900b003f90ba25d19mr12835823wmk.33.1687523713260;
        Fri, 23 Jun 2023 05:35:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Y0g/ua8drcZZs4ihly3xkcq6phAdx3XddFTb5zM1PH+jlNfkw8ytfERFImOnmq5MJYMecVQ==
X-Received: by 2002:a05:600c:299:b0:3f9:ba2:5d19 with SMTP id 25-20020a05600c029900b003f90ba25d19mr12835796wmk.33.1687523712888;
        Fri, 23 Jun 2023 05:35:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:1700:9783:58ba:9db:1221? (p200300cbc7291700978358ba09db1221.dip0.t-ipconnect.de. [2003:cb:c729:1700:9783:58ba:9db:1221])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003f7e4639aabsm2310854wma.10.2023.06.23.05.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 05:35:12 -0700 (PDT)
Message-ID: <c0f51e0e-63ba-2cd2-fb07-a924a081a3fe@redhat.com>
Date:   Fri, 23 Jun 2023 14:35:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] mm/memory_hotplug: Allow an override for the
 memmap_on_memory param
Content-Language: en-US
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
 <20230613-vv-kmem_memmap-v1-1-f6de9c6af2c6@intel.com>
 <87mt0qy3j9.fsf@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87mt0qy3j9.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.23 10:40, Aneesh Kumar K.V wrote:
> Vishal Verma <vishal.l.verma@intel.com> writes:
> 
>> For memory hotplug to consider MHP_MEMMAP_ON_MEMORY behavior, the
>> 'memmap_on_memory' module parameter was a hard requirement.
>>
>> In preparation for the dax/kmem driver to use memmap_on_memory
>> semantics, arrange for the module parameter check to be bypassed via the
>> appropriate mhp_flag.
>>
>> Recall that the kmem driver could contribute huge amounts of hotplugged
>> memory originating from special purposes devices such as CXL memory
>> expanders. In some cases memmap_on_memory may be the /only/ way this new
>> memory can be hotplugged. Hence it makes sense for kmem to have a way to
>> force memmap_on_memory without depending on a module param, if all the
>> other conditions for it are met.
>>
>> The only other user of this interface is acpi/acpi_memoryhotplug.c,
>> which only enables the mhp_flag if an initial
>> mhp_supports_memmap_on_memory() test passes. Maintain the existing
>> behavior and semantics for this by performing the initial check from
>> acpi without the MHP_MEMMAP_ON_MEMORY flag, so its decision falls back
>> to the module parameter.
>>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
>> ---
>>   include/linux/memory_hotplug.h |  2 +-
>>   drivers/acpi/acpi_memhotplug.c |  2 +-
>>   mm/memory_hotplug.c            | 24 ++++++++++++++++--------
>>   3 files changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>> index 9fcbf5706595..c9ddcd3cad70 100644
>> --- a/include/linux/memory_hotplug.h
>> +++ b/include/linux/memory_hotplug.h
>> @@ -358,7 +358,7 @@ extern struct zone *zone_for_pfn_range(int online_type, int nid,
>>   extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
>>   				      struct mhp_params *params);
>>   void arch_remove_linear_mapping(u64 start, u64 size);
>> -extern bool mhp_supports_memmap_on_memory(unsigned long size);
>> +extern bool mhp_supports_memmap_on_memory(unsigned long size, mhp_t mhp_flags);
>>   #endif /* CONFIG_MEMORY_HOTPLUG */
>>   
>>   #endif /* __LINUX_MEMORY_HOTPLUG_H */
>> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
>> index 24f662d8bd39..119d3bb49753 100644
>> --- a/drivers/acpi/acpi_memhotplug.c
>> +++ b/drivers/acpi/acpi_memhotplug.c
>> @@ -211,7 +211,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>>   		if (!info->length)
>>   			continue;
>>   
>> -		if (mhp_supports_memmap_on_memory(info->length))
>> +		if (mhp_supports_memmap_on_memory(info->length, 0))
>>   			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
>>   		result = __add_memory(mgid, info->start_addr, info->length,
>>   				      mhp_flags);
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 8e0fa209d533..bb3845830922 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1283,15 +1283,21 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>>   	return device_online(&mem->dev);
>>   }
>>   
>> -bool mhp_supports_memmap_on_memory(unsigned long size)
>> +bool mhp_supports_memmap_on_memory(unsigned long size, mhp_t mhp_flags)
>>   {
>>   	unsigned long nr_vmemmap_pages = size / PAGE_SIZE;
>>   	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
>>   	unsigned long remaining_size = size - vmemmap_size;
>>   
>>   	/*
>> -	 * Besides having arch support and the feature enabled at runtime, we
>> -	 * need a few more assumptions to hold true:
>> +	 * The MHP_MEMMAP_ON_MEMORY flag indicates a caller that wants to force
>> +	 * memmap_on_memory (if other conditions are met), regardless of the
>> +	 * module parameter. drivers/dax/kmem.c is an example, where large
>> +	 * amounts of hotplug memory may come from, and the only option to
>> +	 * successfully online all of it is to place the memmap on this memory.
>> +	 *
>> +	 * Besides having arch support and the feature enabled at runtime or
>> +	 * via the mhp_flag, we need a few more assumptions to hold true:
>>   	 *
>>   	 * a) We span a single memory block: memory onlining/offlinin;g happens
>>   	 *    in memory block granularity. We don't want the vmemmap of online
>> @@ -1315,10 +1321,12 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
>>   	 *       altmap as an alternative source of memory, and we do not exactly
>>   	 *       populate a single PMD.
>>   	 */
>> -	return mhp_memmap_on_memory() &&
>> -	       size == memory_block_size_bytes() &&
>> -	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
>> -	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
>> +
>> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) || mhp_memmap_on_memory())
>> +		return size == memory_block_size_bytes() &&
>> +		       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
>> +		       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
>> +	return false;
>>   }
>>   
>>   /*
>> @@ -1375,7 +1383,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>>   	 * Self hosted memmap array
>>   	 */
>>   	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
>> -		if (!mhp_supports_memmap_on_memory(size)) {
>> +		if (!mhp_supports_memmap_on_memory(size, mhp_flags)) {
>>   			ret = -EINVAL;
>>   			goto error;
>>   		}
>>
> 
> I was working on enabling memmap_on_memory for ppc64 and came across
> this. Can we do this as below?
> 
> commit d55eddf71032cad3e057d8fa4c61ad2b8e05aaa8
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Date:   Fri Jun 23 12:11:31 2023 +0530
> 
>      mm/hotplug: Allow to force enable memmap on memory
>      
>      In some cases like DAX kmem, we want to enable memmap on memory
>      even if we have memory_hotplug.memmap_on_memory disabled. This
>      patch enables such usage. DAX kmem can use MHP_MEMMAP_ON_MEMORY
>      directly to request for memmap on memory.
>      
>      Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 24f662d8bd39..4d0096fc4cc2 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -211,8 +211,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>   		if (!info->length)
>   			continue;
>   
> -		if (mhp_supports_memmap_on_memory(info->length))
> -			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
> +		mhp_flags |= get_memmap_on_memory_flags();
>   		result = __add_memory(mgid, info->start_addr, info->length,
>   				      mhp_flags);
>   
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 9fcbf5706595..f7f534084393 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -359,6 +359,13 @@ extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
>   				      struct mhp_params *params);
>   void arch_remove_linear_mapping(u64 start, u64 size);
>   extern bool mhp_supports_memmap_on_memory(unsigned long size);
> +bool mhp_memmap_on_memory(void);
>   #endif /* CONFIG_MEMORY_HOTPLUG */
>   
> +static inline unsigned long get_memmap_on_memory_flags(void)
> +{
> +	if (mhp_memmap_on_memory())
> +		return MHP_MEMMAP_ON_MEMORY;
> +	return 0;
> +}
>   #endif /* __LINUX_MEMORY_HOTPLUG_H */
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index eb18d1ac7e84..85d29909fd89 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -50,7 +50,7 @@ static bool memmap_on_memory __ro_after_init;
>   module_param(memmap_on_memory, bool, 0444);
>   MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
>   
> -static inline bool mhp_memmap_on_memory(void)
> +bool mhp_memmap_on_memory(void)
>   {
>   	return memmap_on_memory;
>   }
> @@ -1316,10 +1316,9 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
>   	 *       altmap as an alternative source of memory, and we do not exactly
>   	 *       populate a single PMD.
>   	 */
> -	return mhp_memmap_on_memory() &&
> -	       size == memory_block_size_bytes() &&
> -	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> -	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
> +	return size == memory_block_size_bytes() &&
> +		IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> +		IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
>   }
>   
>   /*
> 

Any forced enablement will have to cleanly handle try_remove_memory() as 
well.

memmap_on_memory needs a doc update then, and even the "forced 
enablement" has to still be explicitly enabled by the admin.

... but I'm still not convinced that memmap_on_memory should be 
overridden. Needs good justification.

-- 
Cheers,

David / dhildenb

