Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEE97282DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbjFHOhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbjFHOhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:37:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E412D65;
        Thu,  8 Jun 2023 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686235039; x=1717771039;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bTaSvUjOl+jGOHNJs8kSJm8AXOsFeR2LEFSNDnmyh0E=;
  b=aNe1q96JHPzT+VZ1T0bw2Lv3p6+yk2ubpFwp16ur/iSQQBl18UvxHda3
   cLLNZV/C8+e6FkVtl2tbQvihPVWR7p9Ju5xeAQObBSJR9nqdttPYR2VCt
   bBYh4ywzBxjceJKvSEQhSczRrZ30Cvc8Xcw42hfIZIK5ldqCpcAGlzUwq
   4G8ZRXbiaNmAFt7OMatMQVL1JxCmp2+2On2mdZ9xE26RGDE0GEneq0C/L
   brqLwAb3jWvn20/CRpZP8cD9gVsEv+25KNPVhrfEVbmfkgTGEmKvl5tWk
   Yt3SAB08zwjaFEkql7r5DYgA1TuQm+nE8dEax1fH7y5Ut56yWdjh6IpTG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="420899767"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="420899767"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 07:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="884215863"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="884215863"
Received: from moleneva-mobl1.ccr.corp.intel.com ([10.251.211.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 07:33:05 -0700
Date:   Thu, 8 Jun 2023 17:32:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, markgross@kernel.org,
        hdegoede@redhat.com, irenic.rajneesh@gmail.com,
        xi.pardee@intel.com, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V2 2/2] platform/x86/intel/pmc/mtl: Put devices in D3
 during resume
In-Reply-To: <20230607233849.239047-2-david.e.box@linux.intel.com>
Message-ID: <e414c9e2-b182-c2f-7ec6-4cca597e5c7e@linux.intel.com>
References: <20230607233849.239047-1-david.e.box@linux.intel.com> <20230607233849.239047-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-522452717-1686234787=:1997"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-522452717-1686234787=:1997
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 7 Jun 2023, David E. Box wrote:

> An earlier commit placed some driverless devices in D3 during boot so that
> they don't block package cstate entry on Meteor Lake. Also place these
> devices in D3 after resume from suspend.
> 
> Fixes: 336ba968d3e3 ("platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devices in D3")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> 
> V2 - rename mtl_fixup to mtl_d3_fixup. Call it from new mtl_resume
>      function, followed by the common resume. Suggested by Ilpo.
> 
>  drivers/platform/x86/intel/pmc/mtl.c | 29 ++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index e8cc156412ce..2b00ad9da621 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -68,16 +68,29 @@ static void mtl_set_device_d3(unsigned int device)
>  	}
>  }
>  
> -void mtl_core_init(struct pmc_dev *pmcdev)
> +/*
> + * Set power state of select devices that do not have drivers to D3
> + * so that they do not block Package C entry.
> + */
> +static void mtl_d3_fixup(void)
>  {
> -	pmcdev->map = &mtl_reg_map;
> -	pmcdev->core_configure = mtl_core_configure;
> -
> -	/*
> -	 * Set power state of select devices that do not have drivers to D3
> -	 * so that they do not block Package C entry.
> -	 */
>  	mtl_set_device_d3(MTL_GNA_PCI_DEV);
>  	mtl_set_device_d3(MTL_IPU_PCI_DEV);
>  	mtl_set_device_d3(MTL_VPU_PCI_DEV);
>  }
> +
> +static int mtl_resume(struct pmc_dev *pmcdev)
> +{
> +	mtl_d3_fixup();
> +	return pmc_core_resume_common(pmcdev);
> +}
> +
> +void mtl_core_init(struct pmc_dev *pmcdev)
> +{
> +	pmcdev->map = &mtl_reg_map;
> +	pmcdev->core_configure = mtl_core_configure;
> +
> +	mtl_d3_fixup();
> +
> +	pmcdev->resume = mtl_resume;
> +}

Thanks. Looks good now,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-522452717-1686234787=:1997--
