Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B692695F41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjBNJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjBNJct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:32:49 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F3C3AB8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:32:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r2so14930218wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=feQgqf0TlS1+YtPXugmH99WSVIfKoWnBpS+qs1gtI/s=;
        b=gPgxou4tJOJTYCemcLXdASH3TKfmjwXcQS1SKUsHTJY1Bytj6hQo6kg2lpcbjLe0G8
         IxHKSWsJrjF65FDyRz9dmtVBOTmJGIPHpUWZzpJdzvwmP4heiSLRiCdsqPK/lW3sHEnE
         qyk9q8Uwvl0MlTPHdj0QFaswubfQJy3Y01tTdvuPW9up92JDE+cCwQztZ6Glw6YhzRND
         OsfJLmtiXwZSgBDpHJStK0y7qcN6vj3sbLvIv6AuHt9BgV5HGxRO0mjkLNbpMX9z0qet
         KHTaGghKH9zsoh8gGvmNnjKFd27ueFu6hPIXHd3octKYHWImhrFcuZKQnjfkHYnMNO/m
         5JEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feQgqf0TlS1+YtPXugmH99WSVIfKoWnBpS+qs1gtI/s=;
        b=7vkbOoqW29RRF7WeEgzjnV0T+8h1/+kIo60JTm6oAMXUC5WLeyAVacjHTZh5kT/SX1
         fJhvmZcamZcqqe6L6BdOWTh3wTkV8X8rNTDl+0FlS6M3gGt3YuWaDguYhSNFFCvVY6SP
         uck67sgaMkNCCXN+5IpoUuSgQGhgVvL8xq+/wvw4LU+QvT5HLX6VTG2X96O0VhaXrOwb
         eBwGLLWssSC2L7Q9KLGRapWx/7rT0CR2MIgolqmMM3Z/2tZX7DSQ3ctf/ZJPwr256bow
         KRduEWj9lbyoGkMUTBPG5tBudUfzy+2wBZ/9y8pPU/ROP8BamnYP/oI6TQ+0gzYlbdyR
         PqZA==
X-Gm-Message-State: AO0yUKX7NqY+SsvClAANj3sZwMQBZbIamOMXUBCFEewgqM6rt9LdjLit
        yk4KGeH1ARBxnStUrfPPCb9oALVv+sKrCF+y
X-Google-Smtp-Source: AK7set/WC01x4imaV87XB8VanV8Br1rNMOtMY5b40aLGEMbxfKvI9jownVsV6Mha6mc8AexhODk/4A==
X-Received: by 2002:a5d:63cc:0:b0:2c5:594a:a4f0 with SMTP id c12-20020a5d63cc000000b002c5594aa4f0mr1586282wrw.58.1676367164673;
        Tue, 14 Feb 2023 01:32:44 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id i20-20020a1c5414000000b003dc53217e07sm16874606wmb.16.2023.02.14.01.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:32:44 -0800 (PST)
Date:   Tue, 14 Feb 2023 09:32:33 +0000
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
Subject: Re: [PATCH v2 3/3] iommu: Remove ioasid infrastructure
Message-ID: <Y+tVMRzRQbcc7Guz@myrica>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
 <20230214064414.1038058-4-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214064414.1038058-4-jacob.jun.pan@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:44:14PM -0800, Jacob Pan wrote:
> This has no use anymore, delete it all.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Yes, a number of intended users haven't materialized yet. They can
re-introduce the allocator when they need it.

> ---
> v2:
> 	- fix compile issue w/o CONFIG_IOMMU_SVA
> 	- consolidate INVALID_IOASID w/ IOMMU_PASID_INVALID

Why not rename ioasid_t as well?  Probably better to move all the renaming
to a separate patch

> ---
>  Documentation/x86/sva.rst   |   2 +-
>  arch/x86/kernel/traps.c     |   5 +-
>  drivers/dma/idxd/device.c   |   8 +-
>  drivers/dma/idxd/idxd.h     |   1 -
>  drivers/dma/idxd/init.c     |   2 +-
>  drivers/dma/idxd/irq.c      |   2 +-
>  drivers/iommu/intel/dmar.c  |   4 +-
>  drivers/iommu/intel/iommu.c |   2 +-
>  drivers/iommu/intel/iommu.h |   1 -
>  drivers/iommu/intel/svm.c   |   3 +-
>  drivers/iommu/ioasid.c      | 422 ------------------------------------
>  drivers/iommu/iommu-sva.c   |   2 +-
>  drivers/iommu/iommu-sva.h   |   1 -
>  include/linux/ioasid.h      |  83 -------
>  include/linux/iommu.h       |  11 +-
>  include/linux/sched/mm.h    |   4 +-
>  include/uapi/linux/iommu.h  |   1 +
>  mm/init-mm.c                |   4 +-

drivers/iommu/{Makefile,Kconfig} also need updates

>  18 files changed, 29 insertions(+), 529 deletions(-)
>  delete mode 100644 drivers/iommu/ioasid.c
>  delete mode 100644 include/linux/ioasid.h

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 46e1347bfa22..7cbcf37df8cd 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -13,7 +13,6 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> -#include <linux/ioasid.h>
>  #include <uapi/linux/iommu.h>
>  
>  #define IOMMU_READ	(1 << 0)
> @@ -192,8 +191,14 @@ enum iommu_dev_features {
>  	IOMMU_DEV_FEAT_IOPF,
>  };
>  
> -#define IOMMU_PASID_INVALID	(-1U)
> -
> +//#define IOMMU_PASID_INVALID	(-1U)

Remove this

> +typedef unsigned int ioasid_t;
> +#ifdef CONFIG_IOMMU_SVA
> +static inline bool pasid_valid(ioasid_t ioasid)
> +{
> +	return ioasid != IOMMU_PASID_INVALID;
> +}
> +#endif

This isn't specific to SVA, doesn't need an ifdef

>  #ifdef CONFIG_IOMMU_API
>  
>  /**
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index cdc138086230..4c52835d3359 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -8,7 +8,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/gfp.h>
>  #include <linux/sync_core.h>
> -#include <linux/ioasid.h>
> +#include <uapi/linux/iommu.h>
>  
>  /*
>   * Routines for handling mm_structs
> @@ -454,7 +454,7 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
>  #ifdef CONFIG_IOMMU_SVA
>  static inline void mm_pasid_init(struct mm_struct *mm)
>  {
> -	mm->pasid = INVALID_IOASID;
> +	mm->pasid = IOMMU_PASID_INVALID;
>  }
>  
>  /* Associate a PASID with an mm_struct: */
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 65d8b0234f69..a95f07f0c98c 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -157,5 +157,6 @@ struct iommu_page_response {
>  	__u32	grpid;
>  	__u32	code;
>  };
> +#define IOMMU_PASID_INVALID	(-1U)

Why change UAPI?

Thanks,
Jean

>  
>  #endif /* _UAPI_IOMMU_H */
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index c9327abb771c..a084039f55d8 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -10,7 +10,7 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/user_namespace.h>
> -#include <linux/ioasid.h>
> +#include <linux/iommu.h>
>  #include <asm/mmu.h>
>  
>  #ifndef INIT_MM_CONTEXT
> @@ -40,7 +40,7 @@ struct mm_struct init_mm = {
>  	.user_ns	= &init_user_ns,
>  	.cpu_bitmap	= CPU_BITS_NONE,
>  #ifdef CONFIG_IOMMU_SVA
> -	.pasid		= INVALID_IOASID,
> +	.pasid		= IOMMU_PASID_INVALID,
>  #endif
>  	INIT_MM_CONTEXT(init_mm)
>  };
> -- 
> 2.25.1
> 
