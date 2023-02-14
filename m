Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC81695F68
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjBNJkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjBNJj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:39:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E2B421B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:39:54 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so11065524wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GYSOqh+epggXyQJ84hoERRy0Xj7egAj9eOYVZ2BXBMY=;
        b=ju0PbuyOde5q/FGE/90fi1JGDicPBL3vuNd5Sau6YrZ8yaeDKmoBLlm9IAlCTCFddw
         py/lAMypvI5K+m1xGViTTLlYkbEE2ct1st0PJywVQFBJX21/Mfql5zQqxsIP0r3P9jds
         JDZDhNkxh02Zox8uknOVSFnABIMofe3aXXRbCs+2WQILLR+4mJnIkD0BZjIPJMF7mNGw
         c6ds31PjhsyRCtcYiRn4+PZzakMQejWGvHfXpvR4e9qPd4zIzHLIMpR5t1tjfqTe0u1d
         FCMsxS/U2m4AliBWBcfnSCF+iM14NaJmcMLnrsTGdDIaOqHuDwmjqB1mWBigbGSwFrrJ
         r9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYSOqh+epggXyQJ84hoERRy0Xj7egAj9eOYVZ2BXBMY=;
        b=UH6MA/L3Key8oEP4EuRUZyhlogJxBfkpwS80DuxWB89HAnowoylyP6MSsQ1H1xb2yU
         w5DoguldSomuuRw8JY3/RX0rc9KM7j4jF+Smn9jwK9BL8hqmie2QJYozjSNAuUoGPRl2
         K7t0WXpRFHPad0nQMgnaopPHPReRazIKGha18Dbq1155WJRZt5SklaumzcfLZEvLAgd1
         tms1PLtbQBDnA8lv0bqgXNYvEJbUj3U3hX1SzufhcuezYvaV7swarmDYwHTHRCRT/Rql
         aKWOJGbJPPNYGP556dM0WCq71LecLySRjZhFq7HTInMGKgaSe8zJ0tYfvfn+cgklJkwI
         Eqqg==
X-Gm-Message-State: AO0yUKUNkl76iHrxmKyfDxgthpZjR+kIa7Qz0+cP3TOHoK/8X5iY94CV
        FVO1dLZ6ONIXoPv+M9lU89DCzQ==
X-Google-Smtp-Source: AK7set+Zn6u6ABlGI2bSGcoAIHCIRY2YRaNvKZptdoJ3tI15YkFLwwFTvSisfVsjELcbaikAODPmxQ==
X-Received: by 2002:a05:600c:3084:b0:3e0:99:b59d with SMTP id g4-20020a05600c308400b003e00099b59dmr1476026wmn.21.1676367593155;
        Tue, 14 Feb 2023 01:39:53 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id p14-20020a1c544e000000b003db06493ee7sm20729991wmi.47.2023.02.14.01.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:39:52 -0800 (PST)
Date:   Tue, 14 Feb 2023 09:39:42 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 2/3] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <Y+tW3kxFeOMcELww@myrica>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
 <20230214064414.1038058-3-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214064414.1038058-3-jacob.jun.pan@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:44:13PM -0800, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> each mm_struct.
> 
> Future work would be to allow drivers using the SVA APIs to reserve global
> PASIDs from this IDA for their internal use, eg with the DMA API PASID
> support.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v2: minor fixes
> 	- let idxd driver use iommu.h for ioasid_t
> 	- return 0 after mm_pasid_set()
> ---
>  drivers/dma/idxd/idxd.h   |  1 +
>  drivers/iommu/iommu-sva.c | 53 +++++++++++----------------------------
>  drivers/iommu/iommu-sva.h |  3 ---
>  include/linux/sched/mm.h  |  8 +-----
>  4 files changed, 17 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 7ced8d283d98..417e602a46b6 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -13,6 +13,7 @@
>  #include <linux/ioasid.h>
>  #include <linux/bitmap.h>
>  #include <linux/perf_event.h>
> +#include <linux/iommu.h>

Unrelated 

>  #include <uapi/linux/idxd.h>
>  #include "registers.h"
>  
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 24bf9b2b58aa..8fb6f1867af3 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -9,24 +9,11 @@
>  #include "iommu-sva.h"
>  
>  static DEFINE_MUTEX(iommu_sva_lock);
> -static DECLARE_IOASID_SET(iommu_sva_pasid);
> +static DEFINE_IDA(iommu_global_pasid_ida);
>  
> -/**
> - * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> - * @mm: the mm
> - * @min: minimum PASID value (inclusive)
> - * @max: maximum PASID value (inclusive)
> - *
> - * Try to allocate a PASID for this mm, or take a reference to the existing one
> - * provided it fits within the [@min, @max] range. On success the PASID is
> - * available in mm->pasid and will be available for the lifetime of the mm.
> - *
> - * Returns 0 on success and < 0 on error.
> - */
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  {
> -	int ret = 0;
> -	ioasid_t pasid;
> +	int ret;
>  
>  	if (min == INVALID_IOASID || max == INVALID_IOASID ||
>  	    min == 0 || max < min)
> @@ -37,39 +24,29 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  	if (pasid_valid(mm->pasid)) {
>  		if (mm->pasid < min || mm->pasid >= max)
>  			ret = -EOVERFLOW;
> +		else
> +			ret = 0;
>  		goto out;
>  	}
>  
> -	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> -	if (!pasid_valid(pasid))
> -		ret = -ENOMEM;
> -	else
> -		mm_pasid_set(mm, pasid);
> +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
> +	if (ret < min)

Just check ret < 0

> +		goto out;
> +	mm_pasid_set(mm, ret);
> +	ret = 0;
>  out:
>  	mutex_unlock(&iommu_sva_lock);
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
>  
> -/* ioasid_find getter() requires a void * argument */
> -static bool __mmget_not_zero(void *mm)
> +void mm_pasid_drop(struct mm_struct *mm)
>  {
> -	return mmget_not_zero(mm);
> -}
> +	pr_alert("%s %d", __func__, mm->pasid);

Debug print

Thanks,
Jean

> +	if (likely(!pasid_valid(mm->pasid)))
> +		return;
>  
> -/**
> - * iommu_sva_find() - Find mm associated to the given PASID
> - * @pasid: Process Address Space ID assigned to the mm
> - *
> - * On success a reference to the mm is taken, and must be released with mmput().
> - *
> - * Returns the mm corresponding to this PASID, or an error if not found.
> - */
> -struct mm_struct *iommu_sva_find(ioasid_t pasid)
> -{
> -	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> +	ida_free(&iommu_global_pasid_ida, mm->pasid);
>  }
> -EXPORT_SYMBOL_GPL(iommu_sva_find);
>  
>  /**
>   * iommu_sva_bind_device() - Bind a process address space to a device
> diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
> index 7215a761b962..c22d0174ad61 100644
> --- a/drivers/iommu/iommu-sva.h
> +++ b/drivers/iommu/iommu-sva.h
> @@ -8,9 +8,6 @@
>  #include <linux/ioasid.h>
>  #include <linux/mm_types.h>
>  
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
> -struct mm_struct *iommu_sva_find(ioasid_t pasid);
> -
>  /* I/O Page fault */
>  struct device;
>  struct iommu_fault;
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 2a243616f222..cdc138086230 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -463,13 +463,7 @@ static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
>  	mm->pasid = pasid;
>  }
>  
> -static inline void mm_pasid_drop(struct mm_struct *mm)
> -{
> -	if (pasid_valid(mm->pasid)) {
> -		ioasid_free(mm->pasid);
> -		mm->pasid = INVALID_IOASID;
> -	}
> -}
> +void mm_pasid_drop(struct mm_struct *mm);
>  #else
>  static inline void mm_pasid_init(struct mm_struct *mm) {}
>  static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
> -- 
> 2.25.1
> 
