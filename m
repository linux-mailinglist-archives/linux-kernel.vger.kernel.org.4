Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B600B732958
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbjFPHz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245440AbjFPHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F47294A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686902067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCwXsPaPd7Dj5AMUAfbDa6LnAHzyeLCA6sw8/b3X0Ho=;
        b=TrBVdBrw/YqjDI3ib3UBG5Sx/cN+fM2sHSwk6JlKLCJdqhWKEAPRynstg1/wmmFVt43Lqf
        h3ubpcYwDlX3RM1InXjUT6XIFUDiByeePsU+vnABcOnP2o5B/GTyCqZ+Kb3iSLvhm3NEz5
        s/TJEdr0McVcKYU+UBh5/vBaoYt5A6I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-bZ28bRPvORe0zKw9bPGWvw-1; Fri, 16 Jun 2023 03:54:25 -0400
X-MC-Unique: bZ28bRPvORe0zKw9bPGWvw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7e8c24a92so1327055e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686902064; x=1689494064;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCwXsPaPd7Dj5AMUAfbDa6LnAHzyeLCA6sw8/b3X0Ho=;
        b=ZBPfqCMMDZssQGuMl28Y/gSPkij36M79Csi3FHuc97P8ICwR8wNyLL8DtS91iEKs8n
         d/0STc6mfff0ub1vURF6Nw7Y7UYhAc33SBL2tY0iIogRoiBJXwPPCkilH+5atklZn+B5
         v4Fw/haW4VDwkNnm2ASoReErrcOcaFa2KnkxaInlR6AjPXQmRX2wsRQoxapm6gDItS0I
         lpKnNlBdXIOZCYvIh8ZtQNWETq4nLToTdqdJzisW7iSjer1R6FDdAVJyc2B/wr8xl5/3
         Oy0nWxb7y6YsxehLStB7JI2h/Kv/9jdsESeUfwRBgcCm2jvUXCPvsTiyrsQ1wT0oDeFs
         RSjQ==
X-Gm-Message-State: AC+VfDw4Q871kDwHzce2STr+gneIEXUKzh8k3u2uZxarp5A7MZFBe6xL
        Jk1cbevEJBq0JY0/JtUVFZFQJBr/tPHwrQehUahnybyaqSpe6sXXsrXOJv8vtbDlNIPIPgCvWRo
        n29MG9OFqnZzktRNwapCh+O2M
X-Received: by 2002:a7b:ce85:0:b0:3f8:c5a6:7a8d with SMTP id q5-20020a7bce85000000b003f8c5a67a8dmr1006467wmj.12.1686902064528;
        Fri, 16 Jun 2023 00:54:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ57hUFJkB9ARA1uPg7u8sBxFriDIGC6XvjqrvDb1WUHap8aii1g0Wt8HyS0VoMZ5iYl6OcUQw==
X-Received: by 2002:a7b:ce85:0:b0:3f8:c5a6:7a8d with SMTP id q5-20020a7bce85000000b003f8c5a67a8dmr1006449wmj.12.1686902064164;
        Fri, 16 Jun 2023 00:54:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c378800b003f195d540d9sm1431039wmr.14.2023.06.16.00.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:54:23 -0700 (PDT)
Message-ID: <aadbedeb-424d-a146-392d-d56680263691@redhat.com>
Date:   Fri, 16 Jun 2023 09:54:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Vishal Verma <vishal.l.verma@intel.com>,
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
 <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
In-Reply-To: <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.23 00:00, Vishal Verma wrote:
> With DAX memory regions originating from CXL memory expanders or
> NVDIMMs, the kmem driver may be hot-adding huge amounts of system memory
> on a system without enough 'regular' main memory to support the memmap
> for it. To avoid this, ensure that all kmem managed hotplugged memory is
> added with the MHP_MEMMAP_ON_MEMORY flag to place the memmap on the
> new memory region being hot added.
> 
> To do this, call add_memory() in chunks of memory_block_size_bytes() as
> that is a requirement for memmap_on_memory. Additionally, Use the
> mhp_flag to force the memmap_on_memory checks regardless of the
> respective module parameter setting.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>   drivers/dax/kmem.c | 49 ++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 36 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 7b36db6f1cbd..0751346193ef 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -12,6 +12,7 @@
>   #include <linux/mm.h>
>   #include <linux/mman.h>
>   #include <linux/memory-tiers.h>
> +#include <linux/memory_hotplug.h>
>   #include "dax-private.h"
>   #include "bus.h"
>   
> @@ -105,6 +106,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>   	data->mgid = rc;
>   
>   	for (i = 0; i < dev_dax->nr_range; i++) {
> +		u64 cur_start, cur_len, remaining;
>   		struct resource *res;
>   		struct range range;
>   
> @@ -137,21 +139,42 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>   		res->flags = IORESOURCE_SYSTEM_RAM;
>   
>   		/*
> -		 * Ensure that future kexec'd kernels will not treat
> -		 * this as RAM automatically.
> +		 * Add memory in chunks of memory_block_size_bytes() so that
> +		 * it is considered for MHP_MEMMAP_ON_MEMORY
> +		 * @range has already been aligned to memory_block_size_bytes(),
> +		 * so the following loop will always break it down cleanly.
>   		 */
> -		rc = add_memory_driver_managed(data->mgid, range.start,
> -				range_len(&range), kmem_name, MHP_NID_IS_MGID);
> +		cur_start = range.start;
> +		cur_len = memory_block_size_bytes();
> +		remaining = range_len(&range);
> +		while (remaining) {
> +			mhp_t mhp_flags = MHP_NID_IS_MGID;
>   
> -		if (rc) {
> -			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
> -					i, range.start, range.end);
> -			remove_resource(res);
> -			kfree(res);
> -			data->res[i] = NULL;
> -			if (mapped)
> -				continue;
> -			goto err_request_mem;
> +			if (mhp_supports_memmap_on_memory(cur_len,
> +							  MHP_MEMMAP_ON_MEMORY))
> +				mhp_flags |= MHP_MEMMAP_ON_MEMORY;
> +			/*
> +			 * Ensure that future kexec'd kernels will not treat
> +			 * this as RAM automatically.
> +			 */
> +			rc = add_memory_driver_managed(data->mgid, cur_start,
> +						       cur_len, kmem_name,
> +						       mhp_flags);
> +
> +			if (rc) {
> +				dev_warn(dev,
> +					 "mapping%d: %#llx-%#llx memory add failed\n",
> +					 i, cur_start, cur_start + cur_len - 1);
> +				remove_resource(res);
> +				kfree(res);
> +				data->res[i] = NULL;
> +				if (mapped)
> +					continue;
> +				goto err_request_mem;
> +			}
> +
> +			cur_start += cur_len;
> +			remaining -= cur_len;
>   		}
>   		mapped++;
>   	}
> 

Maybe the better alternative is teach 
add_memory_resource()/try_remove_memory() to do that internally.

In the add_memory_resource() case, it might be a loop around that 
memmap_on_memory + arch_add_memory code path (well, and the error path 
also needs adjustment):

	/*
	 * Self hosted memmap array
	 */
	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
		if (!mhp_supports_memmap_on_memory(size)) {
			ret = -EINVAL;
			goto error;
		}
		mhp_altmap.free = PHYS_PFN(size);
		mhp_altmap.base_pfn = PHYS_PFN(start);
		params.altmap = &mhp_altmap;
	}

	/* call arch's memory hotadd */
	ret = arch_add_memory(nid, start, size, &params);
	if (ret < 0)
		goto error;


Note that we want to handle that on a per memory-block basis, because we 
don't want the vmemmap of memory block #2 to end up on memory block #1. 
It all gets messy with memory onlining/offlining etc otherwise ...

-- 
Cheers,

David / dhildenb

