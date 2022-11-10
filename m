Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D0E624419
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiKJOUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKJOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:20:02 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33604165AF;
        Thu, 10 Nov 2022 06:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668090002; x=1699626002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RHhT2VxJ8li5Rw6AgHiZP5xYVQLOtbkBiRZO9kF6oZU=;
  b=dDLeYgTk8DQUz9CLxrOx7VRUrktJMEYFMI0iT9TMwSejT2In/ccUZgEy
   xtKFBk46lUboe2vCZDkw4PM19LQt/OSEZd9Bw8SKPrrcZT3z5PHpnZyUx
   ggmwBL85qOkM1zsUgXOpkk61431eUEo8ilE3a4ydDfOkGXmu1SYJpIgtX
   bkpm0ZA4BS+KlEth5TE6fvJLZFEQcwvXpwfqAOLNjIpgeZ3rMgEbqRLUw
   UA6ZKZz7ilkSSX3R7ub5HTXspZxUbYpScukZ+HDtfuAMD5kOLsTEDzZoU
   BMbtKsnmS/nn26x77ftrhjKcFUmaXOnb0EFU9z4dlyHCrJmzFPtSx6hTP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373437823"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="373437823"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 06:20:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="742868446"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="742868446"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 10 Nov 2022 06:19:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ot8PM-00ABIs-2K;
        Thu, 10 Nov 2022 16:19:56 +0200
Date:   Thu, 10 Nov 2022 16:19:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org,
        "David E . Box" <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        platform-driver-x86@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2] platform/x86: don't unconditionally attach Intel PMC
 when virtualized
Message-ID: <Y20IjBPSXE+kqOZS@smile.fi.intel.com>
References: <20221110133335.78442-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221110133335.78442-1-roger.pau@citrix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 02:33:35PM +0100, Roger Pau Monne wrote:
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
> 
> Fixes: 21ae43570940 ('platform/x86: intel_pmc_core: Substitute PCI with CPUID enumeration')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> Acked-by: David E. Box <david.e.box@linux.intel.com>

> Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
> Cc: David E Box <david.e.box@intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: xen-devel@lists.xenproject.org

You may use --cc to the sending tool, instead of polluting a commit message
with that. Moreover, the Cc list will be archived on lore.kernel.org anyway,
in case you really need it to be recorded.

...

> +	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) &&
> +	    !xen_initial_domain())

One line? It's 81 character only and we have no strong 80 here, IIRC.

> +		return -ENODEV;

-- 
With Best Regards,
Andy Shevchenko


