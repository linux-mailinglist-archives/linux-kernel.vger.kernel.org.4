Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E406AC335
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCFO1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCFO1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:27:19 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C5434C08;
        Mon,  6 Mar 2023 06:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678112801; x=1709648801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CjdLj/FL7OoxvEoICtOu9RnLJghHsRisMxfikCu3WNw=;
  b=kpS++xnc7srrVTlzJJ5eiSnJyriDwQVTQYJBQNG9tbCz/TjdmhtEKUoO
   MfoWdqz4hSfDviHCJzKWvfaY5I8Fe/+etqOk5yQsriC4xKDa6F9RIF1T7
   nUGnRm2vcoCQzZ1QIgdLRJqmclO0dPceRSzhgmQmFr/s7vbNtX6Fhgwzi
   KieU9DAaDN0W9ljfQbyyYt4Xq5kDDKzxMCpdAvVvBZ21vTVDThF6gZa5N
   1wZzjEztWwW8GrX5VIbe7GKUhJcdCyPpOOk/yER1WM+tzSUCrdjduebSv
   cmrboASSCpd/jljo0V1w0gxm/7X0u4PhCzsy7n5PGzew620Vz4K341e74
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="319394146"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="319394146"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 06:25:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="678492972"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="678492972"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 06 Mar 2023 06:25:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZBmN-00GTT1-37;
        Mon, 06 Mar 2023 16:25:31 +0200
Date:   Mon, 6 Mar 2023 16:25:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, techsupport@winsystems.com,
        pdemetrotion@winsystems.com, quarium@gmail.com,
        jhentges@accesio.com, jay.dolan@accesio.com
Subject: Re: [PATCH v4 0/3] Migrate the PCIe-IDIO-24 and WS16C48 GPIO drivers
 to the regmap API
Message-ID: <ZAX3243e4mejPEsS@smile.fi.intel.com>
References: <cover.1678106722.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678106722.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 07:59:50AM -0500, William Breathitt Gray wrote:
> Changes in v4:
>  - Allocate idio24gpio before using it in idio_24_probe()
> Changes in v3:
>  - Drop map from set_type_config() parameter list; regmap can be passed
>    by irq_drv_data instead
>  - Adjust idio_24_set_type_config() for parameter list
>  - Add mutex to prevent clobbering the COS_ENABLE register when masking
>    IRQ and setting their type configuration
> Changes in v2:
>  - Simplify PCIe-IDIO-24 register offset defines to remove superfluous
>    arithmetic
>  - Check for NULL pointer after chip->irq_drv_data allocation
>  - Set gpio_regmap drvdata and use gpio_regmap_get_drvdata() to get the
>    regmap in idio_24_reg_map_xlate()
> 
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> A patch to pass irq_drv_data as a parameter for struct regmap_irq_chip
> set_type_config() is included. This is needed by the
> idio_24_set_type_config() and ws16c48_set_type_config() callbacks in
> order to update the type configuration on their respective devices.
> 
> A patch to migrate the WS16C48 GPIO driver to the regmap API is included
> in this series due to its dependence on the struct regmap_irq_chip
> set_type_config() change.

I have found nothing WRT lock type changes.
Can you shed a light on what's going on here?

-- 
With Best Regards,
Andy Shevchenko


