Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4D0624B34
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiKJUHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKJUHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:07:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882FA2C67A;
        Thu, 10 Nov 2022 12:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668110852; x=1699646852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XMCPCA1iwhiwEmRKQ5eEAZ8oTjY1Alafexj9ZcyNpxo=;
  b=REqO4eNGSUaKU87IT9GX8Fo6vO5bRz3HblyINfR4kdRBNpMyC5bLJC3x
   n7yfEPkrk9SCFG6VIekqhx+Q3zd7ZqgWkEeLE3ns2GPR0vw/L4/aFyehg
   izJGDX/JtU9SeTQ/HQFObw+6B23ekoREYDnnA/xFYKGhIT2gUs91g0l4l
   5fZpcTkFVogmezcfY51Lmrz8WmSiETvwEg2gDd+UFc1owPSbyCh4FVFCG
   wcwqKXugye+BYY0wtCFh4DnoV6XXY0Bd7bfg8FP/V/DEzovLxN2YFqGYB
   zaJEKZtBx6PrzVcnuzJ3wXl7CBqyU+fGDfEe8Wsm/P2S2S9SSwxuCJqyP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="298934535"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="298934535"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 12:07:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="706285378"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="706285378"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2022 12:07:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otDpe-00AK6n-37;
        Thu, 10 Nov 2022 22:07:26 +0200
Date:   Thu, 10 Nov 2022 22:07:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, "David E . Box" <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: don't unconditionally attach Intel PMC
 when virtualized
Message-ID: <Y21Z/r0btEPl8rtF@smile.fi.intel.com>
References: <20221110163145.80374-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221110163145.80374-1-roger.pau@citrix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:31:44PM +0100, Roger Pau Monne wrote:
> The current logic in the Intel PMC driver will forcefully attach it
> when detecting any CPU on the intel_pmc_core_platform_ids array,
> even if the matching ACPI device is not present.
> 
> There's no checking in pmc_core_probe() to assert that the PMC device
> is present, and hence on virtualized environments the PMC device
> probes successfully, even if the underlying registers are not present.
> Previous to 21ae43570940 the driver would check for the presence of a
> specific PCI device, and that prevented the driver from attaching when
> running virtualized.
> 
> Fix by only forcefully attaching the PMC device when not running
> virtualized.  Note that virtualized platforms can still get the device
> to load if the appropriate ACPI device is present on the tables
> provided to the VM.
> 
> Make an exception for the Xen initial domain, which does have full
> hardware access, and hence can attach to the PMC if present.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 21ae43570940 ('platform/x86: intel_pmc_core: Substitute PCI with CPUID enumeration')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> Acked-by: David E. Box <david.e.box@linux.intel.com>
> ---
> Changes since v2:
>  - Don't split condition line.
> 
> Changes since v1:
>  - Use cpu_feature_enabled() instead of boot_cpu_has().
> ---
>  drivers/platform/x86/intel/pmc/pltdrv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/pltdrv.c b/drivers/platform/x86/intel/pmc/pltdrv.c
> index 15ca8afdd973..ddfba38c2104 100644
> --- a/drivers/platform/x86/intel/pmc/pltdrv.c
> +++ b/drivers/platform/x86/intel/pmc/pltdrv.c
> @@ -18,6 +18,8 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  
> +#include <xen/xen.h>
> +
>  static void intel_pmc_core_release(struct device *dev)
>  {
>  	kfree(dev);
> @@ -53,6 +55,13 @@ static int __init pmc_core_platform_init(void)
>  	if (acpi_dev_present("INT33A1", NULL, -1))
>  		return -ENODEV;
>  
> +	/*
> +	 * Skip forcefully attaching the device for VMs. Make an exception for
> +	 * Xen dom0, which does have full hardware access.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !xen_initial_domain())
> +		return -ENODEV;
> +
>  	if (!x86_match_cpu(intel_pmc_core_platform_ids))
>  		return -ENODEV;
>  
> -- 
> 2.37.3
> 

-- 
With Best Regards,
Andy Shevchenko


