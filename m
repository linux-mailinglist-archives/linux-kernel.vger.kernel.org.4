Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028BE5F073E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiI3JKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiI3JJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:09:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF722D1F2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664528993; x=1696064993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RgttYHD/5e60xzcRym0xXdUOCXXjBTvquAEuFpvrj0Q=;
  b=LRAgd3BEqVjU/Pzd8yGJ2puCI/v4MrFxz1koi2y5jl9QzNU8AsLPbDN+
   372PioGbryeT71WDbxDFNZi0eu7SVAbn+VfGDE0fDypKr8MYRJ0wpmJTm
   nmtumOyH41BUhyI/qINUTeY+ohwvMLe4wrzKKWyc8qAnVjw2z7Q+04F62
   dSlKOwGiEHdgGzqnp+FtzXDnj3RcDCHynmpI5BsQctLxKRVDNvWpqxaZV
   CFwbrVmmCPN6SZPNIt9Q34F6nL0SU7IwnxcDMvGOZVXl9s5VRIdD0IBj7
   Do9IPU+XI+KelmXGLk5bINin2nDUAnuexn/VysNxFPWgfP1suiorkgemi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303058973"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="303058973"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 02:09:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="867744686"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="867744686"
Received: from xlyu-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.169.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 02:09:50 -0700
Date:   Fri, 30 Sep 2022 17:09:48 +0800
From:   Yu Zhang <yu.c.zhang@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: remove useless parameter in iommu_bus_init().
Message-ID: <20220930090948.zgck6lbkzxqlft4g@linux.intel.com>
References: <20220930070202.105663-1-yu.c.zhang@linux.intel.com>
 <badfd899-aab1-9f47-9053-e05c6bedd668@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <badfd899-aab1-9f47-9053-e05c6bedd668@linux.intel.com>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:04:41PM +0800, Baolu Lu wrote:
> On 2022/9/30 15:02, Yu Zhang wrote:
> > Parameter 'ops' is no longer used by iommu_bus_init(), after
> > commit 8cec63e52966 ("iommu: Remove iommu_callback_data").
> > 
> > So just remove it.
> > 
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > ---
> >   drivers/iommu/iommu.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 3a808146b50f..bedda1e0f016 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1775,7 +1775,7 @@ int bus_iommu_probe(struct bus_type *bus)
> >   	return ret;
> >   }
> > -static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
> > +static int iommu_bus_init(struct bus_type *bus)
> >   {
> >   	struct notifier_block *nb;
> >   	int err;
> > @@ -1836,7 +1836,7 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
> >   	bus->iommu_ops = ops;
> >   	/* Do IOMMU specific setup for this bus-type */
> > -	err = iommu_bus_init(bus, ops);
> > +	err = iommu_bus_init(bus);
> >   	if (err)
> >   		bus->iommu_ops = NULL;
> 
> bus_set_iommu() has been retired. All patches are just queued in
> linux-next and will show up in v6.1-rc1.

Oh. Sorry for the disturbance.

B.R.
Yu
> 
> Best regards,
> baolu
