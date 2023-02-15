Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62F698391
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBOSic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBOSiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:38:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD953E0BE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676486243; x=1708022243;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xqpsHtcfNvJw/Y7dtWUa5FrDokwdID3lZj/BycG68iw=;
  b=DuaieiSz1qf4OwWH3GHf6mO/vJPVE2Q4SWDuwmr55Mrfo8dXvnmEaKaX
   bNycQWdFYbTNFIeY1q6lbWMO6G+5kLDIeYZMHxE5gnEJtumX8cx7Ll/Xc
   kuA974Y7w4ORyAuEe3eipqV7oqgKhDBIZer/uIBydf3uM/a3595BwCnfE
   9kgYZc4vZLj5InE9GKl2jQHOtNvn8yHyGt6zXVwXKOGRJPLtZfPeyEKf2
   p6VX5qoH/qNXoLLNBEONMcI1jm/ixEOiu4z0M7p1HLitlaK4bvOBN3ogK
   rZycjLguNUkyx/v2d7PFp48hg0KpqiuFlLwMZ/iQo8Cek7hie9tPEQzWO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="332821617"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="332821617"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 10:34:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="671783944"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="671783944"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 10:34:41 -0800
Date:   Wed, 15 Feb 2023 10:38:22 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 2/3] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230215103822.6235ada9@jacob-builder>
In-Reply-To: <BN9PR11MB527670F77FADCB351E41F8B78CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
        <20230214064414.1038058-3-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB527670F77FADCB351E41F8B78CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Wed, 15 Feb 2023 03:24:18 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, February 14, 2023 2:44 PM
> > 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> > each mm_struct.
> > 
> > Future work would be to allow drivers using the SVA APIs to reserve
> > global PASIDs from this IDA for their internal use, eg with the DMA API
> > PASID support.  
> 
> I think DMA API PASID will need new API around this IDA. SVA APIs should
> be just for SVA.
> 
> > +void mm_pasid_drop(struct mm_struct *mm)
> >  {
> > -	return mmget_not_zero(mm);
> > -}
> > +	pr_alert("%s %d", __func__, mm->pasid);
> > +	if (likely(!pasid_valid(mm->pasid)))
> > +		return;
> > 
> > -/**
> > - * iommu_sva_find() - Find mm associated to the given PASID
> > - * @pasid: Process Address Space ID assigned to the mm
> > - *
> > - * On success a reference to the mm is taken, and must be released with
> > mmput().
> > - *
> > - * Returns the mm corresponding to this PASID, or an error if not
> > found.
> > - */
> > -struct mm_struct *iommu_sva_find(ioasid_t pasid)
> > -{
> > -	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> > +	ida_free(&iommu_global_pasid_ida, mm->pasid);
> >  }  
> 
> when moving this function following line is missed:
> 
> 	mm->pasid = INVALID_IOASID;
> 
not needed, mm is gone by now.

> btw the current placement looks asymmetric. We now have
> mm_pasid_init() and mm_pasid_set() in mm.h while mm_pasid_drop()
> in iommu-sva.c.
> Is it cleaner to introduce a iommu_sva_free_pasid() helper and then
> call it from mm_pasid_drop() in mm.h?
That is what we had before, it seems logical to me. Jason?

Thanks,

Jacob
