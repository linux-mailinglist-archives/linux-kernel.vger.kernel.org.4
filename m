Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5577327CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjFPGoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjFPGoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:44:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404302118;
        Thu, 15 Jun 2023 23:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686897856; x=1718433856;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=5hbSK8g7G9zu60nQd2Mz8toL8P7q0y+tNU5DH4UKOkY=;
  b=fOQRGsZD67CylTyErQUaZcEEc6A1fqejejPq+99rVpp67OXgi9V2htzH
   qqUhePrwreU03pOJ2C9yH9tZXN+ky+baVgWVhtuC9fvtY8TcDarn5ems9
   0tTqZ1TMYxVGT87J7NOkaGt6ZKYI5hGg8VJU5+H31j42KH/xMtFgsZ9/w
   barsH6rgOsB7+om+ZvOvoWRLDtjHpDNZgtPEicKtppnYEcGlz0jyG3nNN
   XxkXm+N3cDTQrswV7yskn/tOBUSbCbt6F2kORhF1UP8PRYziJ6zWWjLBR
   izpcMPxsyEDBNfoJ41pJPwjqWbDNV7aL5n9pIXzxzhiWwi4Rlqjn25qs5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425076498"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425076498"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802717338"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802717338"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:44:12 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <nvdimm@lists.linux.dev>,
        <linux-cxl@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
        <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com>
Date:   Fri, 16 Jun 2023 14:42:43 +0800
In-Reply-To: <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com> (Vishal
        Verma's message of "Thu, 15 Jun 2023 16:00:25 -0600")
Message-ID: <87zg4zewm4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Verma <vishal.l.verma@intel.com> writes:

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
>  drivers/dax/kmem.c | 49 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 7b36db6f1cbd..0751346193ef 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -12,6 +12,7 @@
>  #include <linux/mm.h>
>  #include <linux/mman.h>
>  #include <linux/memory-tiers.h>
> +#include <linux/memory_hotplug.h>
>  #include "dax-private.h"
>  #include "bus.h"
>  
> @@ -105,6 +106,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  	data->mgid = rc;
>  
>  	for (i = 0; i < dev_dax->nr_range; i++) {
> +		u64 cur_start, cur_len, remaining;
>  		struct resource *res;
>  		struct range range;
>  
> @@ -137,21 +139,42 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		res->flags = IORESOURCE_SYSTEM_RAM;
>  
>  		/*
> -		 * Ensure that future kexec'd kernels will not treat
> -		 * this as RAM automatically.
> +		 * Add memory in chunks of memory_block_size_bytes() so that
> +		 * it is considered for MHP_MEMMAP_ON_MEMORY
> +		 * @range has already been aligned to memory_block_size_bytes(),
> +		 * so the following loop will always break it down cleanly.
>  		 */
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
>  		}
>  		mapped++;
>  	}

It appears that we need to hot-remove memory in the granularity of
memory_block_size_bytes() too, according to try_remove_memory().  If so,
it seems better to allocate one dax_kmem_data.res[] element for each
memory block instead of dax region?

Best Regards,
Huang, Ying
