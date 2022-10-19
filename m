Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D1C60488F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiJSN6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiJSNyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:54:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3311CBAAB;
        Wed, 19 Oct 2022 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666186654; x=1697722654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gKxEzzB9eAPkRTriwHcgbwVQVyOO7fdrMwkIzMwaA3g=;
  b=e3gZxtaksfZ101v/mU3jtz8qeVXl8iOLa0LwfeIGMhnQkOaQgxNsPixf
   M/rqCNFkbgWsAZTLq5b8HMBiZ6ZG9wnKtOH4282AaRXq6DrXhnVJzYHF/
   sisKPttW8IMWLf9C58gOKi2O4KpVs5pGYUb8jATCca8SDbNLXX6WkgNTj
   zh4HCpCQKMUm/qtpYSiB+8Gni6ZprHB5eIKP+hmvG0GMbxeeFKEMPNpb5
   bcegFW6A6qevUatNV4b8H0nZIlGz31lZYaqgeKAprfFeeSB5bqm0xmt/l
   gel4NXoMCKMOU4jDnR3OGVSNl8871nIhYixIjz4PDtNFrHei5CF0bcknG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="307518550"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="307518550"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 06:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="958341131"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="958341131"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 19 Oct 2022 06:36:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ol9F0-009sZR-21;
        Wed, 19 Oct 2022 16:36:14 +0300
Date:   Wed, 19 Oct 2022 16:36:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     chengwei <foxfly.lai.tw@gmail.com>
Cc:     lee@kernel.org, broonie@kernel.org, rafael@kernel.org,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>
Subject: Re: [PATCH 4/5] GPIO ACPI: Add support to map GPIO resources to
 ranges
Message-ID: <Y0/9Tq71JLr+Le4N@smile.fi.intel.com>
References: <20221019022450.16851-1-larry.lai@yunjingtech.com>
 <20221019022450.16851-5-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019022450.16851-5-larry.lai@yunjingtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:24:49AM +0800, chengwei wrote:
> Add a function to gpiolib to facilitate registering a pin controller for
> a range of GPIO pins, but using ACPI resource references and without
> claiming the GPIO resource.

This is quite under explained.

First of all, why do you need all these?

Second, where is the link to ACPI DSDT excerpt of the device node
which needs that?

Third, is the BIOS for these platforms is already in wild or
can be amended?

...

> +		count = acpi_gpio_count_from_property(adev, propname);
>  		if (count > 0)
>  			break;

This part can be split to a separate change as a prerequisite.

-- 
With Best Regards,
Andy Shevchenko


