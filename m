Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122C76E4DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDQQFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjDQQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:05:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EE35BB3;
        Mon, 17 Apr 2023 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681747481; x=1713283481;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7tLU5hrc39P7zYp6lZlpanLIEtDU8xZ/pBPxVlbteKA=;
  b=AGvd9mVposJKAnjdLBuZ1dXZwws+SSwEd08NGOmqfrZ7TVyfekK2wi2m
   bjEb1GK9wu4mbQ3mGa7+cXhn/GYM0F7Zky5NGaKIuIrpzNFTS4OLo4kYY
   p39O2cKGmtilqRvbe+t9T3puI+zoysS/sSevcnuS/BtBPMi95m64l0l+A
   30F2TkDmmc0g3JKXSVQmAx+8L3lOtmVxtebIIDrq0UEFw1ALHj4MhE7a3
   ueIh6iX+0L9Sl/Lf+P9evSu2X7aCYpGpWdtJaMDpOTjZkopFp/u8O+YU+
   lnRUmUWahm6xi1RdSew8SRitpxWlkRoveEAy4/OAIcGCL+90RVmi6HsS7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="344927320"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="344927320"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 09:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="802172627"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="802172627"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 09:02:52 -0700
Date:   Mon, 17 Apr 2023 09:07:06 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 3/7] iommu: Support allocation of global PASIDs
 outside SVA
Message-ID: <20230417090706.3ac5f858@jacob-builder>
In-Reply-To: <BN9PR11MB5276D09F18BA65AD074777948C9A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
        <20230407180554.2784285-4-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276D09F18BA65AD074777948C9A9@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Tue, 11 Apr 2023 08:02:55 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, April 8, 2023 2:06 AM
> > @@ -28,8 +26,8 @@ static int iommu_sva_alloc_pasid(struct mm_struct
> > *mm, ioasid_t min, ioasid_t ma
> >  		goto out;
> >  	}
> > 
> > -	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > GFP_KERNEL);
> > -	if (ret < min)
> > +	ret = iommu_alloc_global_pasid(min, max);  
> 
> I wonder whether this can take a device pointer so dev->iommu->max_pasids
> is enforced inside the alloc function.
> 
> and do we even need the min/max parameters? With special pasids reserved
> then what driver needs is just to get a free pasid from the global space
> within dev->iommu->max_pasids constraint...
> 
> iommu_sva_alloc_pasid() can be reworked to avoid min/max by taking a 
> device pointer too.
I think that will work too albeit a philosophical change. It probably
should be called iommu_alloc_dev_global_pasid(dev).

But I feel the current approach is more flexible in that device drivers
can control the range if for some reason it does not want go max_pasid.


Thanks,

Jacob
