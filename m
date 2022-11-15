Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E1B629A99
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiKONf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiKONfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:35:54 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E968813A;
        Tue, 15 Nov 2022 05:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668519353; x=1700055353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C7oMZsIFl/5+FvRA4B1+hWf/xguxUXGFdeyKjZpj6nQ=;
  b=Q5LbzeV2I5PUJwz0rRtk7F0/RJ7Qw0ZvaeexKt2Z719KzLHBhdWJhIPm
   fcBU4OEBrXF3ikq9jdPj05bcyxGgq6Wrzep3ajW1VGX0854vB5e/jADlU
   jqXwFbYS+s2Ehn5tM9UclHMWZyyyVDZZRUh/u6vSQ+Ud9mdZcd61ss76f
   /0sRsEFeNsEp9OWxZ/N0/n8P9JKB4pBAm9vVhTHdnyrk4H5aHIoDvAfxb
   ANOxk7GDVOe/UyuWmznyoCI0s4BSPql0EywNwRtkAFTYLJT80+qIks8Hr
   QNVu8x1C3DrsVaABKGXOvAYT/gUm0SaUm7r35gT0hu1NayGrf9PzLUNmJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313400519"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="313400519"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 05:35:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727953161"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="727953161"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2022 05:35:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouw6P-00CdA1-0l;
        Tue, 15 Nov 2022 15:35:49 +0200
Date:   Tue, 15 Nov 2022 15:35:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Javier Arteaga <javier@emutex.com>,
        Dan O'Donovan <dan@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc128s052: add proper .data members in
 adc128_of_match table
Message-ID: <Y3OVtIiJ4jwE9h6J@smile.fi.intel.com>
References: <20221115132324.1078169-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115132324.1078169-1-linux@rasmusvillemoes.dk>
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

On Tue, Nov 15, 2022 at 02:23:23PM +0100, Rasmus Villemoes wrote:
> Prior to commit bd5d54e4d49d ("iio: adc128s052: add ACPI _HID
> AANT1280"), the driver unconditionally used spi_get_device_id() to get
> the index into the adc128_config array.
> 
> However, with that commit, OF-based boards now incorrectly treat all
> supported sensors as if they are an adc128s052, because all the .data
> members of the adc128_of_match table are implicitly 0. Our board,
> which has an adc122s021, thus exposes 8 channels whereas it really
> only has two.
> 
> Fixes: bd5d54e4d49d ("iio: adc128s052: add ACPI _HID AANT1280")
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> 
> I think the driver could be simplified somewhat by having just one
> single adc_channels[] array with the 8 entries, unconditionally use
> that as ->channels, with ->num_channels being taken from the match
> data instead of having this indirection through the auxiliary config
> array.

Hmm... I have a patch locally that changes this to take pointers instead of
numbers and using spi_get_device_match_data() (but the latter is only available
in Linux Next so far).

> But this patch is properly more suited for -stable.

LGTM for time being
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>  drivers/iio/adc/ti-adc128s052.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 622fd384983c..b3d5b9b7255b 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -181,13 +181,13 @@ static int adc128_probe(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id adc128_of_match[] = {
> -	{ .compatible = "ti,adc128s052", },
> -	{ .compatible = "ti,adc122s021", },
> -	{ .compatible = "ti,adc122s051", },
> -	{ .compatible = "ti,adc122s101", },
> -	{ .compatible = "ti,adc124s021", },
> -	{ .compatible = "ti,adc124s051", },
> -	{ .compatible = "ti,adc124s101", },
> +	{ .compatible = "ti,adc128s052", .data = (void*)0L, },
> +	{ .compatible = "ti,adc122s021", .data = (void*)1L, },
> +	{ .compatible = "ti,adc122s051", .data = (void*)1L, },
> +	{ .compatible = "ti,adc122s101", .data = (void*)1L, },
> +	{ .compatible = "ti,adc124s021", .data = (void*)2L, },
> +	{ .compatible = "ti,adc124s051", .data = (void*)2L, },
> +	{ .compatible = "ti,adc124s101", .data = (void*)2L, },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, adc128_of_match);
> -- 
> 2.37.2
> 

-- 
With Best Regards,
Andy Shevchenko


