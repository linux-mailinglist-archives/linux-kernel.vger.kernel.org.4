Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD69763CC80
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiK3AaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiK3AaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:30:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8C86DCE1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669768221; x=1701304221;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1GWWc4Tc75XYzHefA3rY5s7nAsU8WGJ5jGlKkeOVvf4=;
  b=dtpD9i3CW+w6PsAFLKmprf+CV2nXNNZ48cKVtJ8ni9pPyuHLMTB6vCQ4
   xmghF/RzYE2pn1ONbxM77kwihK0KK+lgQa3jMefXhXIACjfb2f18VsVA8
   MTEc2Vl8b6FxBbLjAwPUsojxe5g0ZxjK5ZVe58QxwPqZZ+1VLRHevDDoL
   wAzpKFxdxpD56p8J3SI9Dim9fcU/6L0PtFSGmIDESWp9z/YeHqpoIQI3t
   Qo0i96b00M3mymRUOvIVK4ChBumVEhG/tY6g+AFYuK8zycinGYAPinzy4
   bSFYRlRq0xrvRuynOhwF6j22r42ZHW+x1dRI2h8Xawuej/SMHjq1YzPuY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="313961647"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="313961647"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 16:30:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="889074941"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="889074941"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 16:30:20 -0800
Date:   Tue, 29 Nov 2022 16:34:12 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Yuzhang Luo <yuzhang.luo@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
Message-ID: <20221129163412.15da3081@jacob-builder>
In-Reply-To: <9fd4bf6c-5525-c209-28b6-492558c1dd35@linux.intel.com>
References: <20221128170410.3830605-1-jacob.jun.pan@linux.intel.com>
        <9fd4bf6c-5525-c209-28b6-492558c1dd35@linux.intel.com>
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

Hi Baolu,

On Wed, 30 Nov 2022 08:10:55 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1396,6 +1396,23 @@ static void domain_update_iotlb(struct
> > dmar_domain *domain) spin_unlock_irqrestore(&domain->lock, flags);
> >   }
> >   
> > +/*
> > + * Impacted QAT device IDs ranging from 0x4940 to 0x4943.
> > + * This quirk is exempted from risky_device() check because it applies
> > only
> > + * to the built-in QAT devices.
> > + */  
> 
> How about adding:
> 
> "This quirk is exempted from risky_device() check because it doesn't
> effectively grant additional privileges."
sounds good.

Thanks,

Jacob
