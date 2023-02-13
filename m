Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F77C695347
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjBMVlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBMVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:41:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFA55275
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676324468; x=1707860468;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fjiKvrHISbinyt7S0bRErJ7/aoSEHDwLa1AouQtc4WM=;
  b=HwH+g6anoSOATLGmAVxmG4hcSMizoWu0HSpvWM6Ao1rjxnKhMtmSm5Cc
   lCyK+ixTKEgK7LjIr+D5yeadGoWsTwZ/YFcU2m6+OaEbqPQCY2hfhWL3l
   5ZWisA7shy5/J4vERcOFCH4MnrFQ69EaDSDEG9J0EU4jW4AEr+VglGYV2
   crpN3tQZAHsB5/lXSOFXQWUoG3LNbPsq/07IbsOCxJ26h/BQ6+K6yA0yw
   k7GN6foETMVDjC2be1Q/dJXIdvkUGAtXgLbaxHs46hC97MGZoPX8DUL9s
   VKBA+PFdCefzeMs6dwCrZkSx3f1OS03Cs0MVIcnA/U93napryDY3Sn2MB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="314652770"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="314652770"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 13:40:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="646534746"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="646534746"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 13:40:22 -0800
Date:   Mon, 13 Feb 2023 13:44:02 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <20230213134402.194ed7fd@jacob-builder>
In-Reply-To: <Y+qR5zC8ZOkVphgv@nvidia.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
        <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
        <Y+pjTR80bnl9rMK1@myrica>
        <20230213103455.02f3ac37@jacob-builder>
        <Y+qR5zC8ZOkVphgv@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, 13 Feb 2023 15:39:19 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Feb 13, 2023 at 10:34:55AM -0800, Jacob Pan wrote:
> > Hi Jean-Philippe,
> > 
> > On Mon, 13 Feb 2023 16:20:29 +0000, Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> >   
> > > On Fri, Feb 10, 2023 at 03:02:06PM -0800, Jacob Pan wrote:  
> > > > Custom allocator feature was introduced to support VT-d's virtual
> > > > command, an enlightened interface designed for VMs to allocate
> > > > PASIDs from the host.
> > > > 
> > > > As we remove/withdraw the VT-d virtual command feature, the sole
> > > > user of custom allocator, we can safely remove the custom allocator
> > > > as well. Effectively, this will return IOASID core to the original
> > > > simple global namespace allocator.
> > > > 
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>    
> > > 
> > > You can also drop the spinlock.h include. With that:
> > >   
> > good catch, thanks  
> > > Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > 
> > > On a related note, it looks like 100b8a14a370 ("iommu/vt-d: Add pasid
> > > private data helpers") removed the last user of ioasid_set_data(). I
> > > guess that could be dropped too, unless you plan to still use it?
> > >   
> > You are right, will remove.
> > I was planning on the other way around which will convert VT-d's private
> > pasid data helpers to common ioasid code, but when I look closer the
> > private pasid xa is just holding a list of pasid/mm which could be per
> > iommu not global. Another cleanup I suppose.  
> 
> Please lets just delete this entire ioasid thing, it has no purpose
> anymore at all.
> 
> I did a sketch on how it do it here:
> 
> https://github.com/jgunthorpe/linux/commits/iommu_remove_ioasid
> 
> I wasn't very careful or elegant with the last patch, can you tidy it
> up and repost this as your v2?
> 
yes, will do.
> Your DMA API PASID thing will simply need one new API to alloc/free a
> PASID from the iommu_global_pasid_ida
It should satisfy what we need right now.
Just wondering if we were to do resource management of global PASIDs, say
with the new misc cgroup controller, do we plan to expand in iommu sva code?
If yes, do we keep DMA API PASID in a separate range/set?


Thanks,

Jacob
