Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E87696B68
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjBNR1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBNR13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:27:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387DF11145
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676395648; x=1707931648;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rv87gnisD7YRSMFeXq2zOsCtQDGq3mGZG3/TmZDN+bc=;
  b=XLu69nYsKiSoSJZtJmPJaxEUwKTUrkF94Mubi1PNEfQpL6UkaSsEPk3b
   2sGJ4vtghx9Hf+bbUOvjztBfHszq3VCV2XPIsk54ytKAKq3Jz34aXjvnF
   +/Pe2QyQGY+AdJbSdU8yPzUPrJnAF45E4NfeKhbHw/ZYFXw02fBjoW5hL
   ir6QZFhhviziHLfrL5kPqIGiJHlUOFo+zfWy+g7v1E0TvqOcYLiL9/rbt
   41/GgndQZwjMLbqAwXr5HKvaDDPvGpuicbTPUaaieQBxMNBWveovZa1wN
   yFNZ7qsKj2dY7tqZCUJ70uuknm4JPwXMatiIvYbCZJPORr0916HUG2Ilx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="332526423"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="332526423"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:27:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="778431181"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="778431181"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:27:27 -0800
Date:   Tue, 14 Feb 2023 09:31:07 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
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
Message-ID: <20230214093107.323d7e76@jacob-builder>
In-Reply-To: <Y+uHSry/tpgGNr/b@nvidia.com>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
        <20230214064414.1038058-4-jacob.jun.pan@linux.intel.com>
        <Y+tVMRzRQbcc7Guz@myrica>
        <Y+uHSry/tpgGNr/b@nvidia.com>
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

Hi Jason,

On Tue, 14 Feb 2023 09:06:18 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Feb 14, 2023 at 09:32:33AM +0000, Jean-Philippe Brucker wrote:
> > > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > > index 65d8b0234f69..a95f07f0c98c 100644
> > > --- a/include/uapi/linux/iommu.h
> > > +++ b/include/uapi/linux/iommu.h
> > > @@ -157,5 +157,6 @@ struct iommu_page_response {
> > >  	__u32	grpid;
> > >  	__u32	code;
> > >  };
> > > +#define IOMMU_PASID_INVALID	(-1U)  
> > 
> > Why change UAPI?  
> 
> There is no uapi, this whole file needs to be deleted too
> 
ok. another clean up.

As I also replied to Jean, I ran into a circular #include problem if mm.h
#include iommu.h, I guess I could also create another header, e.g.
iommu_defs.h to avoid it. any other suggestions?


Thanks,

Jacob
