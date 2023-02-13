Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA8B694F63
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjBMSbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBMSbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:31:44 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E6EC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676313103; x=1707849103;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ctixiST2ow9yoUlfeU4eXd6rri6AYzsTWly0/plDjIk=;
  b=B9OMHz9yazT/HQlYJt3uSK1hcWFtKx1fkjcgVDKZFTF+nRHNfqPs/eRS
   uZFJzPLsJCRXNShHgKFYYOwxbpBNlMq6cLS4MyzmQcz3UYRZTufNWvymF
   rCOLYW5qL+IGRbc9T4lKlUj0CgAP0cFdZB5NBc73s1Pp3jSARRXlWyGMz
   s5TRmZi/tgcjlXiR1qGcV5T+MO1D3VhuBfVB03cLW+pmb271XlbTbd89V
   nGQ/RiGmrrXChIzvPz+bvS0rJKbRMFTDCxLIA7Zq4RsDJr9/3sMWed7CO
   TegC0WcfzS4ly4MrILLInKevDq05UsP3+9+XWZ7RQstIZezpcbkNAlwIz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="314602826"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="314602826"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:31:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="670917839"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="670917839"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:31:15 -0800
Date:   Mon, 13 Feb 2023 10:34:55 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <20230213103455.02f3ac37@jacob-builder>
In-Reply-To: <Y+pjTR80bnl9rMK1@myrica>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
        <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
        <Y+pjTR80bnl9rMK1@myrica>
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

Hi Jean-Philippe,

On Mon, 13 Feb 2023 16:20:29 +0000, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Fri, Feb 10, 2023 at 03:02:06PM -0800, Jacob Pan wrote:
> > Custom allocator feature was introduced to support VT-d's virtual
> > command, an enlightened interface designed for VMs to allocate PASIDs
> > from the host.
> > 
> > As we remove/withdraw the VT-d virtual command feature, the sole user
> > of custom allocator, we can safely remove the custom allocator as well.
> > Effectively, this will return IOASID core to the original simple global
> > namespace allocator.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> You can also drop the spinlock.h include. With that:
> 
good catch, thanks
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> On a related note, it looks like 100b8a14a370 ("iommu/vt-d: Add pasid
> private data helpers") removed the last user of ioasid_set_data(). I guess
> that could be dropped too, unless you plan to still use it?
> 
You are right, will remove.
I was planning on the other way around which will convert VT-d's private
pasid data helpers to common ioasid code, but when I look closer the
private pasid xa is just holding a list of pasid/mm which could be per iommu
not global. Another cleanup I suppose.

> We could also merge ioasid.c into iommu-sva.c at this point, since I
> haven't seen any interest for having multiple IOASID sets on Arm, but I'm
> not sure what the current plan is for vSVA on x86.
VT-d do plan to use global PASIDs for DMA API with PASIDs since the
work submited via ENQCMDS must use a PASID must != RIDPASID.
https://lore.kernel.org/lkml/20220518182120.1136715-1-jacob.jun.pan@linux.intel.com/T/

So I was thinking a separate ioasid_set for devices that allocates global
PASIDs for DMA API usage. ioasid_set will be useful here for limiting
lookup and resource management. e.g. PASIDs used under in-kernel DMA API
are not subject to cgroups.


> Thanks,
> Jean
> 
> 


Thanks,

Jacob
