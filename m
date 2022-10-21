Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1106076DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJUM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJUM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:26:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E99924C971;
        Fri, 21 Oct 2022 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666355188; x=1697891188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3qxDgWjz7WhDR7p1gpy2Yx6ovUUtnsHE9EkR/x054u8=;
  b=Bk79VNhENJtrqNCHi2pQPvEuG3LVDwx4yM0CWxT8ILPV5eCH54zzxE0e
   /LaZiSdpfK+LSwGzLvo7+HkrR42xpoxvhpR1hAZvQA7PKjMcr1+I1GVNb
   Y1uIMhmpV6wcwFoWQeIvGAknbcsXb0MeV+tqTzrl7lctTFtl9q/W6jH8i
   zPv7ycMFsVDyE9IvzeFn4qu0Gqx3NVh9pEn6sm1bh+2I6s6Xvqo1GmFiB
   o9NMU+MGiI7Zi4qPZo8ZculPerA7YEMtFfMWvjH4cZommHop0J4vBF6IA
   ozzXPMFNvJEkNsGQ/6/bxh3F1au5AcQlqPFRfu4hTqfLsAwdcQUIgB/ny
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="393292249"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="393292249"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 05:26:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="630466609"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="630466609"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 21 Oct 2022 05:26:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olr6W-00B9Nk-0c;
        Fri, 21 Oct 2022 15:26:24 +0300
Date:   Fri, 21 Oct 2022 15:26:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v4 1/5] spi: pxa2xx: Respect Intel SSP type given by a
 property
Message-ID: <Y1KP7xYRAmDppvZG@smile.fi.intel.com>
References: <20221020194500.10225-1-andriy.shevchenko@linux.intel.com>
 <20221020194500.10225-2-andriy.shevchenko@linux.intel.com>
 <Y1KNgS6xQ1VhMjo1@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1KNgS6xQ1VhMjo1@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:16:01PM +0100, Mark Brown wrote:
> On Thu, Oct 20, 2022 at 10:44:56PM +0300, Andy Shevchenko wrote:
> 
> > Allow to set the Intel SSP type by reading the property.
> > Only apply this to the known MFD enumerated devices.
> 
> > +	/* For MFD enumerated devices always ask for a property */
> > +	mfd_enumerated = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv");
> > +	if (mfd_enumerated) {
> > +		status = device_property_read_u32(dev, "intel,spi-pxa2xx-type", &value);
> > +		if (status)
> > +			return ERR_PTR(status);
> > +	}
> > +
> >  	if (pcidev)
> >  		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match, pcidev);
> >  
> >  	match = device_get_match_data(&pdev->dev);
> >  	if (match)
> >  		type = (enum pxa_ssp_type)match;
> > +	else if (value > SSP_UNDEFINED && value < SSP_MAX)
> > +		type = (enum pxa_ssp_type)value;
> 
> This is quite hard to follow, partly because value isn't exactly a clear
> variable name and partly because the initialisation to SSP_UNDEFINED,
> the attempt to read via device property and this if/else chain are split
> up and not clearly joined up with each other.  This is partly an issue
> with the existing code but the extra layer of spreading things
> throughout the function being added amplifies things a bit.

The next patch removes the PCI part in this equation, at the end there is
no "new" complexity on top of the existing one. But I'm all ears on how
to simplify the existing code.

-- 
With Best Regards,
Andy Shevchenko


