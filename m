Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F81B6BD0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCPN2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjCPN2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:28:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CF35FDE;
        Thu, 16 Mar 2023 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678973317; x=1710509317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UztYh2WnICxCRygj0nifIN2s9JGrwBz2pdL6lKlal9Q=;
  b=h5Q8As6cZZx0DNM7R9LmqCvbkv4K7mWKVCREuzPs0/ZIXV1e8uvCQPJt
   47R5gnpO1pF300nVZinGKY3dG8o1ZoyXz7jIupRiaUQAGLhKqx1dyu1zp
   o//gN8K9GeR5kplcTKMluVGlxytpZF1mrELPDHTQOgejFOR1EvSzIdZrV
   KnFHGHLuAh8FcmO/4h3N0YSwlDZqfreI85ZXTcMmB+jw/E4oyezYf3V8q
   b+wGLgCuZf+aodSLZPQGDZb1TGfWki0FNHtcgdKL7ZqsnInoqB6xlQTNV
   65qOswNvKy1gue8o67DneCRw370Jr7+woNOnj3OYvjlvyigm7fOREeJ2q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10650"; a="365676918"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="365676918"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 06:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="823247493"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="823247493"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 16 Mar 2023 06:28:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pcnek-004TNd-0H;
        Thu, 16 Mar 2023 15:28:34 +0200
Date:   Thu, 16 Mar 2023 15:28:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1 1/1] regulator: s5m8767: Replace of_gpio.h with what
 indeed is used
Message-ID: <ZBMZgSb0FXt7OIJz@smile.fi.intel.com>
References: <20230316120113.86421-1-andriy.shevchenko@linux.intel.com>
 <306b94ce-1f45-43a2-ad27-567fa5c235ce@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <306b94ce-1f45-43a2-ad27-567fa5c235ce@sirena.org.uk>
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

On Thu, Mar 16, 2023 at 01:10:46PM +0000, Mark Brown wrote:
> On Thu, Mar 16, 2023 at 02:01:13PM +0200, Andy Shevchenko wrote:
> > of_gpio.h in this driver is solely used as a proxy to other headers.
> > This is incorrect usage of the of_gpio.h. Replace it .h with what
> > indeed is used in the code.
> 
> This breaks an x86 allmodconfig build:
> 
> /build/stage/linux/drivers/regulator/s5m8767.c: In function ‘s5m8767_pmic_dt_parse_dvs_gpio’:
> /build/stage/linux/drivers/regulator/s5m8767.c:492:24: error: implicit declaration of function ‘of_get_named_gpio’ [-Werror=implicit-function-declaration]
>   492 |                 gpio = of_get_named_gpio(pmic_np,
>       |                        ^~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

Oh, sorry for that. I missed something.
Please, ignore this one, it should be different one.

-- 
With Best Regards,
Andy Shevchenko


