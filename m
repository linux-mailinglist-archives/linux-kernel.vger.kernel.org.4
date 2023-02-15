Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38BB698767
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBOVdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBOVdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:33:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0CC769C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676496797; x=1708032797;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lPohpjnYjmGKBqI3h/hmynytkCJLxEoHHjxFGeTY3OM=;
  b=g+AojqM0UyCMO/it0Yqhdyh6J9ycPExXztefV2S3cFPOilqVyjkp14ig
   kKYu2Y//oV6uiR6EjUhKUZqInbCVq6a5fJen0ZAu2m7nkybMZyDMnPznh
   sClRzZGn5vWSVidB1VL1rCSkphXNNZLDa4DXB224HHn4hH2K/KqMoQrOa
   qcqgyKSTXWLYymU67N3WWTS29ZHnolq/939Es9WAsKjOZtudzFEKArW4J
   nFI7OKfn8xHB/0jgS1bBuxvF690S2G5uXVaSnDG6px8j4CfsmMND3r4AA
   uMUnuHnRW1ZGRakxGdx3MD3mLBXCV8E/tGJnTf6cDgSu9p/vxyaZ6jbrX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="331545728"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="331545728"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 13:33:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="700187439"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="700187439"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 13:33:10 -0800
Date:   Wed, 15 Feb 2023 13:36:51 -0800
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
Subject: Re: [PATCH v2 2/3] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230215133651.776a1553@jacob-builder>
In-Reply-To: <Y+tW3kxFeOMcELww@myrica>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
        <20230214064414.1038058-3-jacob.jun.pan@linux.intel.com>
        <Y+tW3kxFeOMcELww@myrica>
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

On Tue, 14 Feb 2023 09:39:42 +0000, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Mon, Feb 13, 2023 at 10:44:13PM -0800, Jacob Pan wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> > each mm_struct.
> > 
> > Future work would be to allow drivers using the SVA APIs to reserve
> > global PASIDs from this IDA for their internal use, eg with the DMA API
> > PASID support.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v2: minor fixes
> > 	- let idxd driver use iommu.h for ioasid_t
> > 	- return 0 after mm_pasid_set()
> > ---
> >  drivers/dma/idxd/idxd.h   |  1 +
> >  drivers/iommu/iommu-sva.c | 53 +++++++++++----------------------------
> >  drivers/iommu/iommu-sva.h |  3 ---
> >  include/linux/sched/mm.h  |  8 +-----
> >  4 files changed, 17 insertions(+), 48 deletions(-)
> > 
> > diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> > index 7ced8d283d98..417e602a46b6 100644
> > --- a/drivers/dma/idxd/idxd.h
> > +++ b/drivers/dma/idxd/idxd.h
> > @@ -13,6 +13,7 @@
> >  #include <linux/ioasid.h>
> >  #include <linux/bitmap.h>
> >  #include <linux/perf_event.h>
> > +#include <linux/iommu.h>  
> 
> Unrelated 
this is for ioasid_t, won't compile without it 

> >  #include <uapi/linux/idxd.h>
> >  #include "registers.h"
> >  
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index 24bf9b2b58aa..8fb6f1867af3 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -9,24 +9,11 @@
> >  #include "iommu-sva.h"
> >  
> >  static DEFINE_MUTEX(iommu_sva_lock);
> > -static DECLARE_IOASID_SET(iommu_sva_pasid);
> > +static DEFINE_IDA(iommu_global_pasid_ida);
> >  
> > -/**
> > - * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> > - * @mm: the mm
> > - * @min: minimum PASID value (inclusive)
> > - * @max: maximum PASID value (inclusive)
> > - *
> > - * Try to allocate a PASID for this mm, or take a reference to the
> > existing one
> > - * provided it fits within the [@min, @max] range. On success the
> > PASID is
> > - * available in mm->pasid and will be available for the lifetime of
> > the mm.
> > - *
> > - * Returns 0 on success and < 0 on error.
> > - */
> > -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
> > max) +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t
> > min, ioasid_t max) {
> > -	int ret = 0;
> > -	ioasid_t pasid;
> > +	int ret;
> >  
> >  	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> >  	    min == 0 || max < min)
> > @@ -37,39 +24,29 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm,
> > ioasid_t min, ioasid_t max) if (pasid_valid(mm->pasid)) {
> >  		if (mm->pasid < min || mm->pasid >= max)
> >  			ret = -EOVERFLOW;
> > +		else
> > +			ret = 0;
> >  		goto out;
> >  	}
> >  
> > -	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> > -	if (!pasid_valid(pasid))
> > -		ret = -ENOMEM;
> > -	else
> > -		mm_pasid_set(mm, pasid);
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > GFP_KERNEL);
> > +	if (ret < min)  
> 
> Just check ret < 0
yes, but i thought < min is safe too. 

> > +		goto out;
> > +	mm_pasid_set(mm, ret);
> > +	ret = 0;
> >  out:
> >  	mutex_unlock(&iommu_sva_lock);
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
> >  
> > -/* ioasid_find getter() requires a void * argument */
> > -static bool __mmget_not_zero(void *mm)
> > +void mm_pasid_drop(struct mm_struct *mm)
> >  {
> > -	return mmget_not_zero(mm);
> > -}
> > +	pr_alert("%s %d", __func__, mm->pasid);  
> 
> Debug print
will remove,
Thanks a lot!


Jacob
