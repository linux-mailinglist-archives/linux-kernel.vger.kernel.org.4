Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF1E622FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiKIQPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiKIQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:15:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75E36459;
        Wed,  9 Nov 2022 08:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668010527; x=1699546527;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kZC10f7fSVGcH04eIzQAsQzGAOCoZ7dwf+5x6YWkadk=;
  b=KLj+wGcRqgLgWs8DYTFdZ4UICQCYQPrLZJ2zjXlBWEHJK19R+6+rwAC/
   snkbcqlSpkLMKWA+H3jjct2jmEOhKVZtqmVj/kTg83MnoOuSTaXj/tNrh
   8wIRci9ubTCXeV7056bZ+7LbQb1nlW6lT3S+rVoYV5XkS+JGmaZfKlVkn
   X6xE8NfxQvXycmjifHrxE5CDF1rOFby1Nee/uHfD3mF5Lf2lKhaDgKYJ1
   AE3Bu1DxzdJbuRy755uXs0YCfDwrYwT0jNfKYIAG7Yjm+unZz32umTs2S
   CW/FTTezu6x6o+G35kluypnntaO05AYbubd3shUD3g/dx03MSsqjUuiJy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="298543599"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="298543599"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:15:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="761930600"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="761930600"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 09 Nov 2022 08:15:19 -0800
Received: from sookyeen-mobl2.amr.corp.intel.com (sookyeen-mobl2.amr.corp.intel.com [10.251.11.176])
        by linux.intel.com (Postfix) with ESMTP id 8FA7F580B0E;
        Wed,  9 Nov 2022 08:15:19 -0800 (PST)
Message-ID: <bc25b31f7af527511599145954615a0d0a6078cf.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: don't unconditionally attach Intel PMC
 when virtualized
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Date:   Wed, 09 Nov 2022 08:15:19 -0800
In-Reply-To: <20221109151632.71495-1-roger.pau@citrix.com>
References: <20221109151632.71495-1-roger.pau@citrix.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-09 at 16:16 +0100, Roger Pau Monne wrote:
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

Yeah, that PCI device was short lived. It was available on Skylake/Kabylake but
then removed on future generations. When this happened we changed the driver to
use ACPI binding instead. But there were several generations of ChromeOS/coreboo
t platforms (listed in intel_pmc_core_platform_ids) that did not have the ACPI
device present in their firmware. This file exists specifically to support those
platforms and uses the forced binding because (given that there's actual
silicon) we know the PMC will be there.

> 
> Fix by only forcefully attaching the PMC device when not running
> virtualized.  Note that virtualized platforms can still get the device
> to load if the appropriate ACPI device is present on the tables
> provided to the VM.
> 
> Make an exception for the Xen initial domain, which does have full
> hardware access, and hence can attach to the PMC if present.
> 
> Fixes: 21ae43570940 ('platform/x86: intel_pmc_core: Substitute PCI with CPUID
> enumeration')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
> Cc: David E Box <david.e.box@intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> ---
>  drivers/platform/x86/intel/pmc/pltdrv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/pltdrv.c
> b/drivers/platform/x86/intel/pmc/pltdrv.c
> index 15ca8afdd973..e284fd34ffdf 100644
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
> @@ -53,6 +55,14 @@ static int __init pmc_core_platform_init(void)
>  	if (acpi_dev_present("INT33A1", NULL, -1))
>  		return -ENODEV;
>  
> +	/*
> +	 * Skip forcefully attaching the device for VMs. Make an exception for
> +	 * Xen dom0, which does have full hardware access.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR) &&
> +	    !xen_initial_domain())
> +		return -ENODEV;
> +
>  	if (!x86_match_cpu(intel_pmc_core_platform_ids))
>  		return -ENODEV;
>  

Acked-by: David E. Box <david.e.box@linux.intel.com>

