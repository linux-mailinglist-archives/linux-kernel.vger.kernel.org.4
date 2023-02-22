Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73AF69EEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 07:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBVGP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 01:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBVGPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 01:15:24 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0920311DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 22:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677046523; x=1708582523;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZeXJ7DB5YT2ntkxG4DK0XkeNPwdLeW8BHoIQ2ji0wqc=;
  b=OiHME6xm6FpkkuV6GAK7KLRjVzRI7asdWMkiCOGSqGyWBgHlxiUKtsP2
   0FAhIB0V0Uoqqy2btG7KVMFlXAWxCAEWzCPI30U1Wm9kp3uGHqqBv6Ku5
   /eEY1b77YQUSOYrUEXJd4D78mRqpPVK0AY69Aqs4SpvpEft8EH/s25Nxi
   Xt5fOLCjCSR0c5M2XN35PqJUwzXx1J1rbD/widQSdhsqQbyJt7dfn/LfD
   hZXbkwYu7AeKyflw/SjxdjGmYlNaVdvo4iJC9AgtGAAqbR4HtSgQGdvYF
   TuQBmw5PoMw/arWmsPwA2y42XhkRqqAstjkjI6zn2S2V6ndnl9b/gZHnp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334210576"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="334210576"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 22:15:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="1000881310"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="1000881310"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 22:15:21 -0800
Date:   Tue, 21 Feb 2023 22:19:05 -0800
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
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "X86 Kernel" <x86@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 3/5] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230221221905.4759b2ac@jacob-builder>
In-Reply-To: <BN9PR11MB5276EC1F0926256D0E8F05F58CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
        <20230216235951.3573059-4-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276EC1F0926256D0E8F05F58CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Wed, 22 Feb 2023 02:22:48 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Friday, February 17, 2023 8:00 AM
> >
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > GFP_KERNEL);
> > +	if (ret < min)
> > +		goto out;  
> 
> ioasid_alloc() currently uses GFP_ATOMIC.
> 
> since this is kind of a replacement w/o functional impact, it'd be cleaner
> from bisect p.o.v. to have a separate patch changing GFP_ATOMIC
> to GFP_KERNEL in ioasid_alloc() and then this patch.
> 
makes sense,

Thanks,

Jacob
