Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41EF6954DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjBMXkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjBMXkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:40:13 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306B1CA2E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676331606; x=1707867606;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ixZ4bLVsafsO/qfHYxt6mrTGLCPfk7e2PfpXdYXUk7M=;
  b=KNvWEnFLX0ubFS4X6Ezgm+gUblh9hVdJpZDzZuDOAByfDjcjOawJA2EJ
   7RGWGTE5kMdCAD+rv5KvV+4z5gc56QfCleixdbufbNiAWFFkj2WNQqNFV
   yTrTvqOWaXQNlsKVUzV7pYYzdgWiH2nBRmvVnJb7eezGeEPFvghsiDS6H
   /+FCwrRvbuQy5Z4ZblwR8DYHno+IaY4JaJ+4vsltavx4ymUWZqEP5Csz2
   0BId4WscwkkEtPu4m2CQMY6vN+HXdwZ7F82iouccqtL21fBd3JZo6uB/C
   ENcQkkjjBTSlIVcI0J9dmQ3kj2JeepVc6jiCehKnsKaA8TrFteVtFjIIQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="311387946"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="311387946"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:40:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="701453131"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="701453131"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:40:05 -0800
Date:   Mon, 13 Feb 2023 15:43:45 -0800
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
Message-ID: <20230213154345.0f76eea1@jacob-builder>
In-Reply-To: <Y+rFW80DUHvf3hQP@nvidia.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
        <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
        <Y+pjTR80bnl9rMK1@myrica>
        <20230213103455.02f3ac37@jacob-builder>
        <Y+qR5zC8ZOkVphgv@nvidia.com>
        <20230213134402.194ed7fd@jacob-builder>
        <Y+rFW80DUHvf3hQP@nvidia.com>
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

Hi Jason,

On Mon, 13 Feb 2023 19:18:51 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Feb 13, 2023 at 01:44:02PM -0800, Jacob Pan wrote:
> > > Your DMA API PASID thing will simply need one new API to alloc/free a
> > > PASID from the iommu_global_pasid_ida  
> > It should satisfy what we need right now.
> > Just wondering if we were to do resource management of global PASIDs,
> > say with the new misc cgroup controller, do we plan to expand in iommu
> > sva code? If yes, do we keep DMA API PASID in a separate range/set?  
> 
> I would say all shared PASIDs held by userspace should be captured by
> by a resource limit, it doesn't matter if they are global PASIDs or
> device local shared PASIDs.
agreed, I was just thinking in-kernel DMA PASID is not held by userspace,
might be good to keep them in separate pool, thus keeping ioasid_set.

> So if a cgroup comes it is just a matter of putting charges in the
> right place which is auditable by looking at calls to attach pasid
> functions.
shouldn't we charge cg during allocation? Or it might be too early for
iommufd so we have to wait  until attach?

Thanks,

Jacob
