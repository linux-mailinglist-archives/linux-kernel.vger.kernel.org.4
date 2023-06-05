Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B610722510
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjFEMAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjFEMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:00:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C129C;
        Mon,  5 Jun 2023 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685966404; x=1717502404;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=p5/S5k7Qizlk2AVy9vIiaRFPNQhWyVQblWCerOYsPfI=;
  b=Od5PUG5dodEOVF18JxdxDFjkopxQ52D/ts5EObcNfNn4wxmUjGGZ3XCi
   LqZLHO3rLG84JlJs4ufuY5IzSeN3GJal+TNeWB3oQUrI6ejkJzpMH0WL6
   YTQCx+JLirp93iQ4XWhm0GS1teeJNYQgoQxYOr9os1NpQ2b+Syoq+VFRf
   Jz6s1ir8RAyRaGZpH0Q9mFGRsx83PCDZLve1gWO71iqwFoSG6c2QTQpiA
   hyFw2tP3FrOuzVtmUDKWrKi1NjdQ8wAbLPOiJi1HVq/BOvIvpHX43DeSh
   XbxuXZHazgyJmj7ep2VCQjA2IWhAvrrjg0t+Her/jNg01aG7uiXPy6Kz/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="422174161"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="422174161"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="702725735"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="702725735"
Received: from gfittedx-mobl.ger.corp.intel.com ([10.252.47.115])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:59:26 -0700
Date:   Mon, 5 Jun 2023 14:59:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     irenic.rajneesh@gmail.com, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] platform/x86/intel/pmc/mtl: Put devices in D3 during
 resume
In-Reply-To: <20230602232142.278155-2-david.e.box@linux.intel.com>
Message-ID: <9a45d987-6840-9c7a-b0b5-702cf3aba4f@linux.intel.com>
References: <20230602232142.278155-1-david.e.box@linux.intel.com> <20230602232142.278155-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023, David E. Box wrote:

> An earlier commit placed some driverless devices in D3 during boot so that
> they don't block package cstate entry. Also place these devices in D3 after
> resume from suspend.
> 
> Fixes: 336ba968d3e3 ("platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devices in D3")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/mtl.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index e8cc156412ce..d87c4597c6d4 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -68,11 +68,8 @@ static void mtl_set_device_d3(unsigned int device)
>  	}
>  }
>  
> -void mtl_core_init(struct pmc_dev *pmcdev)
> +static void mtl_fixup(void)
>  {
> -	pmcdev->map = &mtl_reg_map;
> -	pmcdev->core_configure = mtl_core_configure;
> -
>  	/*
>  	 * Set power state of select devices that do not have drivers to D3
>  	 * so that they do not block Package C entry.
> @@ -81,3 +78,13 @@ void mtl_core_init(struct pmc_dev *pmcdev)
>  	mtl_set_device_d3(MTL_IPU_PCI_DEV);
>  	mtl_set_device_d3(MTL_VPU_PCI_DEV);

I'd prefer the function be called something related to d3 / power state / 
or some along those lines rather than something obscure such as 
mtl_fixup(). And you can move the comment to be a function comment now.

>  }
> +
> +void mtl_core_init(struct pmc_dev *pmcdev)
> +{
> +	pmcdev->map = &mtl_reg_map;
> +	pmcdev->core_configure = mtl_core_configure;
> +
> +	mtl_fixup();
> +
> +	pmcdev->resume_fixup = mtl_fixup;

I'm a bit on the edge here whether this is a good approach in long-term or 
if it would be better to just provide a way for the platform file to 
replace entire .resume() (for this task it's obviously enough but it 
feels a bit hacky to hook into one fixed place on resume path).

static __maybe_unused int pmc_core_resume(struct device *dev)
{
	if (pmcdev->resume)
		return pmcdev->resume();
	else
		return pmc_core_resume_common();
}

where pmc_core_resume_common() contains the current pmc_core_resume() 
contents.

mtl_resume() would just call the d3 func and the common resume functions.


-- 
 i.

