Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753EF696AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjBNRDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjBNRCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:02:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1982FCDD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676394110; x=1707930110;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rHkT/RbGfsheQDr3YjEfh6cqT2t2MapjJ6gd+ij5Jn0=;
  b=VF/xaEDu3OXP4YamAc0Y7fwFb2L9J48D2H+7UYHHifxTE+Y7vbI2AtmT
   wiqcgq4FXKhLLiM7+5FxwLU3icT2KRUXSh5rslUExeXeLoPM0SrYIr5+Y
   CghKxjjaW2Xa4r39v+IlmF9N58XVZKb2iDiLpmqgvyf3kfDC1oz6eK63Z
   AwAM0OGvTxlBJnWQT8kEdKeWF2cv5wDMCh0nVf2cSi3Owd7KKxFt3jnXP
   r4Zt9hi+MQN6BDauZOgnonUzGvW5fkgvy/i0AFsvRl8Dfa5IermFXlJeo
   12i3bIG0t3C+3PLcT+eIyHOhe8DJqIhO0hUm99qmCyf7MCA74hhyWgs5J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="328919068"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="328919068"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:00:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812108253"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="812108253"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:00:57 -0800
Date:   Tue, 14 Feb 2023 09:04:37 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/3] iommu: Remove ioasid infrastructure
Message-ID: <20230214090437.5991644b@jacob-builder>
In-Reply-To: <Y+tVMRzRQbcc7Guz@myrica>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
        <20230214064414.1038058-4-jacob.jun.pan@linux.intel.com>
        <Y+tVMRzRQbcc7Guz@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,

On Tue, 14 Feb 2023 09:32:33 +0000, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Mon, Feb 13, 2023 at 10:44:14PM -0800, Jacob Pan wrote:
> > This has no use anymore, delete it all.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> Yes, a number of intended users haven't materialized yet. They can
> re-introduce the allocator when they need it.
> 
> > ---
> > v2:
> > 	- fix compile issue w/o CONFIG_IOMMU_SVA
> > 	- consolidate INVALID_IOASID w/ IOMMU_PASID_INVALID  
> 
> Why not rename ioasid_t as well?  Probably better to move all the renaming
> to a separate patch
> 
sounds good.
> > ---
> >  Documentation/x86/sva.rst   |   2 +-
> >  arch/x86/kernel/traps.c     |   5 +-
> >  drivers/dma/idxd/device.c   |   8 +-
> >  drivers/dma/idxd/idxd.h     |   1 -
> >  drivers/dma/idxd/init.c     |   2 +-
> >  drivers/dma/idxd/irq.c      |   2 +-
> >  drivers/iommu/intel/dmar.c  |   4 +-
> >  drivers/iommu/intel/iommu.c |   2 +-
> >  drivers/iommu/intel/iommu.h |   1 -
> >  drivers/iommu/intel/svm.c   |   3 +-
> >  drivers/iommu/ioasid.c      | 422 ------------------------------------
> >  drivers/iommu/iommu-sva.c   |   2 +-
> >  drivers/iommu/iommu-sva.h   |   1 -
> >  include/linux/ioasid.h      |  83 -------
> >  include/linux/iommu.h       |  11 +-
> >  include/linux/sched/mm.h    |   4 +-
> >  include/uapi/linux/iommu.h  |   1 +
> >  mm/init-mm.c                |   4 +-  
> 
> drivers/iommu/{Makefile,Kconfig} also need updates
> 
good catch!

> >  18 files changed, 29 insertions(+), 529 deletions(-)
> >  delete mode 100644 drivers/iommu/ioasid.c
> >  delete mode 100644 include/linux/ioasid.h  
> 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 46e1347bfa22..7cbcf37df8cd 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -13,7 +13,6 @@
> >  #include <linux/errno.h>
> >  #include <linux/err.h>
> >  #include <linux/of.h>
> > -#include <linux/ioasid.h>
> >  #include <uapi/linux/iommu.h>
> >  
> >  #define IOMMU_READ	(1 << 0)
> > @@ -192,8 +191,14 @@ enum iommu_dev_features {
> >  	IOMMU_DEV_FEAT_IOPF,
> >  };
> >  
> > -#define IOMMU_PASID_INVALID	(-1U)
> > -
> > +//#define IOMMU_PASID_INVALID	(-1U)  
> 
> Remove this
> 
will do
> > +typedef unsigned int ioasid_t;
> > +#ifdef CONFIG_IOMMU_SVA
> > +static inline bool pasid_valid(ioasid_t ioasid)
> > +{
> > +	return ioasid != IOMMU_PASID_INVALID;
> > +}
> > +#endif  
> 
> This isn't specific to SVA, doesn't need an ifdef
> 
until DMA API PASID support is in, this is SVA only? at least on x86?

> >  #ifdef CONFIG_IOMMU_API
> >  
> >  /**
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index cdc138086230..4c52835d3359 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -8,7 +8,7 @@
> >  #include <linux/mm_types.h>
> >  #include <linux/gfp.h>
> >  #include <linux/sync_core.h>
> > -#include <linux/ioasid.h>
> > +#include <uapi/linux/iommu.h>
> >  
> >  /*
> >   * Routines for handling mm_structs
> > @@ -454,7 +454,7 @@ static inline void
> > membarrier_update_current_mm(struct mm_struct *next_mm) #ifdef
> > CONFIG_IOMMU_SVA static inline void mm_pasid_init(struct mm_struct *mm)
> >  {
> > -	mm->pasid = INVALID_IOASID;
> > +	mm->pasid = IOMMU_PASID_INVALID;
> >  }
> >  
> >  /* Associate a PASID with an mm_struct: */
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 65d8b0234f69..a95f07f0c98c 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -157,5 +157,6 @@ struct iommu_page_response {
> >  	__u32	grpid;
> >  	__u32	code;
> >  };
> > +#define IOMMU_PASID_INVALID	(-1U)  
> 
> Why change UAPI?
I ran into circular #include problem if mm.h #include iommu.h, I guess I
could also create another header, e.g. iommu_defs.h to avoid it. any other
suggestions?
Don't we need this in uapi anyway?
> >  
> >  #endif /* _UAPI_IOMMU_H */
> > diff --git a/mm/init-mm.c b/mm/init-mm.c
> > index c9327abb771c..a084039f55d8 100644
> > --- a/mm/init-mm.c
> > +++ b/mm/init-mm.c
> > @@ -10,7 +10,7 @@
> >  
> >  #include <linux/atomic.h>
> >  #include <linux/user_namespace.h>
> > -#include <linux/ioasid.h>
> > +#include <linux/iommu.h>
> >  #include <asm/mmu.h>
> >  
> >  #ifndef INIT_MM_CONTEXT
> > @@ -40,7 +40,7 @@ struct mm_struct init_mm = {
> >  	.user_ns	= &init_user_ns,
> >  	.cpu_bitmap	= CPU_BITS_NONE,
> >  #ifdef CONFIG_IOMMU_SVA
> > -	.pasid		= INVALID_IOASID,
> > +	.pasid		= IOMMU_PASID_INVALID,
> >  #endif
> >  	INIT_MM_CONTEXT(init_mm)
> >  };
> > -- 
> > 2.25.1
> >   


Thanks,

Jacob
