Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA820657003
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiL0VgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiL0VgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:36:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDDEE02;
        Tue, 27 Dec 2022 13:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672176977; x=1703712977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=imOmzEkUNHKYrCfC/7lqeotv82pgHCjFJwRPkSJr+0I=;
  b=Bb6g0Lx6RVN6t+sWwFI15Hiy1cFsdoVS8BZa0xCjmpZdK2Kk4Ttp0FsE
   mEgEvHxePeNO4J17j0v48WRYN4aWFm1zygmOj3mlkTrOM8Rfing749MV2
   wVcd5XqaVs+eC+BaYdgJWWpAeB3z1c8xIugmmbhlKr521o1h34/pjFlmz
   tFMIE9y7AMggYjA3jyF5Q/JH9oFIKr5lCekd/6zkvHxxHsu+NNWWvM8wL
   Yx1dPSQ/Dmhh4c+AYj/b6GeHcZoDZ0XQsFsUMbilKFOfNMcSxHUEeWozx
   KkfNWNaDWmvhAxY2KfLEHKbKTdZhw9SGtaCULOWpiAGqFFDBx0T6p0C38
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="383063081"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="383063081"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 13:36:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="716441008"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="716441008"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 27 Dec 2022 13:36:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAHcJ-000Gcx-2h;
        Tue, 27 Dec 2022 23:36:11 +0200
Date:   Tue, 27 Dec 2022 23:36:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: pressure: bmp280: Add enumeration to handle
 chip variants
Message-ID: <Y6tlS5lLkNO5PxhH@smile.fi.intel.com>
References: <cover.1671986815.git.ang.iglesiasg@gmail.com>
 <f0368a3f460707417110dffdb0166824da20af15.1671986815.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0368a3f460707417110dffdb0166824da20af15.1671986815.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2022 at 05:56:07PM +0100, Angel Iglesias wrote:
> Adds enumeration to improve handling the different supported sensors
> on driver initialization. This avoid collisions if different variants
> share the same device idetifier on ID register.

...

>  static const struct of_device_id bmp280_of_i2c_match[] = {
> -	{ .compatible = "bosch,bmp085", .data = (void *)BMP180_CHIP_ID },
> -	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
> -	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
> -	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
> -	{ .compatible = "bosch,bmp380", .data = (void *)BMP380_CHIP_ID },
> +	{ .compatible = "bosch,bmp085", .data = (void *)BMP180 },
> +	{ .compatible = "bosch,bmp180", .data = (void *)BMP180 },
> +	{ .compatible = "bosch,bmp280", .data = (void *)BMP280 },
> +	{ .compatible = "bosch,bme280", .data = (void *)BME280 },
> +	{ .compatible = "bosch,bmp380", .data = (void *)BMP380 },

Seems an unneeded churn. If we want to have chip info, then provide a pointer
here. And in case it's done later, squash into this patch.

-- 
With Best Regards,
Andy Shevchenko


