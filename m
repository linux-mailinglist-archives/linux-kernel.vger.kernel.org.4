Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC6D6C1AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjCTQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjCTQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:04:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2153D092;
        Mon, 20 Mar 2023 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679327654; x=1710863654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HPFt5wbvwAzTASQxl4om3089Cr96nMrFu47+XtnfK5s=;
  b=C5svXfCizWhZkNfhyLQt6Lx9p6vWDg+ls+NXaOb8hJ0nhTkbm1LjVJH3
   Dwjs8FcpnvZrD4Sonwvq0PZ1Y9tx4lFAzzOrqHD1bXExJtQtnHsjj1YIC
   WclJSVbV7k/XL9lOJdB6yvoSlBy6WPjDsYxs9I6LSyVN7yJihN7yKU0Md
   fv2ymmBAURp10CZC8PRUxuwdU5jzbFi6q1SzcDJDfyExzeT9nz98Y4ZYI
   7KIdHQ/Xhrfnr+WSxmQ1fmztvvLrAnyd5TYnlZ3fE7Woudadaf87DK5VC
   4gNxbIkdD3sbpx4UVUbnCI7sev3PHUAnI5D6ND2rKRYOjCRyhZ4s9K4mo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="336204541"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="336204541"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 08:51:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="1010523400"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="1010523400"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 20 Mar 2023 08:51:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1peHnI-006Ktu-1N;
        Mon, 20 Mar 2023 17:51:32 +0200
Date:   Mon, 20 Mar 2023 17:51:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: addac: stx104: Migrate to the regmap API
Message-ID: <ZBiBBJOmjOAHGUn0@smile.fi.intel.com>
References: <20230319202256.352939-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319202256.352939-1-william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 04:22:56PM -0400, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.

...

> -/**
> - * struct stx104_iio - IIO device private data structure

I believe this...

> - * @chan_out_states:	channels' output states
> - * @reg:		I/O address offset for the device registers
> - */

> -struct stx104_iio {

...and this can be left here. With that the diff won't be too disrupted.

(You are using only pointers to the generic data types in the struct
 definition, that's why its location can be almost anywhere before the
 first its real user.)

> -	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
> -	struct stx104_reg __iomem *reg;

...

> +struct stx104_iio {
> +	struct regmap *aio_data_map;
> +	struct regmap *aio_ctl_map;
>  };

-- 
With Best Regards,
Andy Shevchenko


