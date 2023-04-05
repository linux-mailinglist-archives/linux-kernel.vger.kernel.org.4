Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7797D6D8345
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDEQNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjDEQM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:12:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D83F7AB2;
        Wed,  5 Apr 2023 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680711148; x=1712247148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kY6FYRMMLrAPbGBkMo9Na+eZcMkaq3QXvRDWH/QYHCg=;
  b=aVlxFBkdAORWAaS0M/Y1B0D5Bolmh7oIwo6aYZHn5PxeC3ZyVU32ru1P
   taVAKbugtxg+00dBpAQhATOv0vMxLIjRb3Ej+tokRgh4tjh9dq+Htb6W9
   LdUvrlEpI89Q5Qr3NleDBCr18rrcfGGDJ5qIAdN8Gt8vfr52WESv1V6AC
   f3h3j1jaUySffKnv/VkJWUomYHc2BbhnmDeuuwv+IX4gxZHt2KFdjwWLE
   9m/0lR31cr1PX2Bs4pXpmAMnWvN/dFBAttxme487FzwwcB9MPerF2lvzj
   elk8gT3TXtWmOPorNsY+6QengeuN3mOXyqV0UmWxjjZ1ANk2bbDLd6ixd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="331100655"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="331100655"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 09:11:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="1016526158"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="1016526158"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 05 Apr 2023 09:11:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pk5jA-00CuLV-2x;
        Wed, 05 Apr 2023 19:11:16 +0300
Date:   Wed, 5 Apr 2023 19:11:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, techsupport@winsystems.com,
        pdemetrotion@winsystems.com, quarium@gmail.com,
        jhentges@accesio.com, jay.dolan@accesio.com
Subject: Re: [PATCH v6 0/3] Migrate the PCIe-IDIO-24 and WS16C48 GPIO drivers
 to the regmap API
Message-ID: <ZC2dpCtxa/dlIcov@smile.fi.intel.com>
References: <cover.1680708357.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680708357.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 11:45:41AM -0400, William Breathitt Gray wrote:
> Changes in v6:
>  - Wrap lines to 80 characters rather than 100 for set_type_config()
>  - Remove regmap_config max_register lines as superfluous
>  - Enable use_raw_spinlock to prevent deadlocks when running -rt kernels
>  - Check regmap_update_bit() ret value before goto exit_unlock
>  - Rename exit_early label to the more descriptive exit_unlock
>  - Add sparse annotations for lock acquire/release in
>    ws16c48_handle_pre_irq() and ws16c48_handle_post_irq()
>  - Explicitly add 0 to WS16C48_ENAB in ws16c48_irq_init_hw() for sake of
>    symmetry to match the other WS16C48_ENAB operations 
> Changes in v5:
>  - Refactor for map parameter removal from handle_mask_sync()
>  - Cleanups and line wrappings to 100 characters rather than 80
>  - Adjust to change mutex/spinlock_t type locks to raw_spin_lock_t type
>  - Remove pex8311_intcsr table configurations as superfluous
>  - Adjust to set pex8311_intcsr_regmap_config reg_base to
>    PLX_PEX8311_PCI_LCS_INTCSR
>  - Rename PAGE_FIELD_PAGE_* defines to POL_PAGE, ENAB_PAGE, and
>    INT_ID_PAGE
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
> This patchset depends on the "Drop map from handle_mask_sync()
> parameters" patchset [0].
> 
> [0] https://lore.kernel.org/all/cover.1679323449.git.william.gray@linaro.org/

Looks good to me now.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It might be that regmap locks are unnecessary, but as far as I understood
dropping them would require more intrusion into the regmap APIs along with
GPIO regmap implementation.

> William Breathitt Gray (3):
>   regmap: Pass irq_drv_data as a parameter for set_type_config()
>   gpio: pcie-idio-24: Migrate to the regmap API
>   gpio: ws16c48: Migrate to the regmap API
> 
>  drivers/base/regmap/regmap-irq.c |   8 +-
>  drivers/gpio/Kconfig             |   6 +
>  drivers/gpio/gpio-pcie-idio-24.c | 677 +++++++++++--------------------
>  drivers/gpio/gpio-ws16c48.c      | 552 +++++++++----------------
>  include/linux/regmap.h           |   6 +-
>  5 files changed, 447 insertions(+), 802 deletions(-)
> 
> 
> base-commit: 7b59bdbc3965ca8add53e084af394c13a2be22a8
> prerequisite-patch-id: cd19046150b7cff1be4ac7152198777aa960a3df
> prerequisite-patch-id: bd3e3830d9ce4f3876a77483364d7190b7fdffa7
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


