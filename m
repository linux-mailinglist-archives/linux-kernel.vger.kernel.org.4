Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF1A6912E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBIWAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIV76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:59:58 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D7C65686;
        Thu,  9 Feb 2023 13:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675979998; x=1707515998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/k0M+qJgBKHvFKI5TOmiZn2Yf3hcbjt7xbw8P5ZDUE8=;
  b=iN957IQlR4J5lK4YnDkJfUPEZpZ5dfIYc7gwR+BGZLHtru0NfVpie5kf
   dlApywzU369vbG/QUmE0chzfW59SszWyDahuA7QFxcEckL6zRHQaAE2CU
   FqsvvW48yr30oK2rDBCLnz13Hl4n/tGQeOYmVDG/yJ6ffHlQ7MptwSnGw
   udUzYEv4ULjALW3+YO9EPK4q5ZvU4ijycmnDCjX3qrVWIR9pBUAMLq6pT
   it8oSEL4LiCD8vHAXBiSCHma2cGPFd4Gm3IcBjM4BptgL+LA261ozpYaV
   KfZVp2fnVuuJzpLi1mxYcYX8tsjSAOr7i6RHjeOF3DOl4xL9n9WKA3mRA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="310620283"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="310620283"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 13:59:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="661176621"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="661176621"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 09 Feb 2023 13:59:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pQExN-004nEd-2b;
        Thu, 09 Feb 2023 23:59:53 +0200
Date:   Thu, 9 Feb 2023 23:59:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     David Thompson <davthompson@nvidia.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        limings@nvidia.com
Subject: Re: [PATCH v1 v/1] gpio: mlxbf: enable GPIO interface and ACPI event
 for host-gpio[7]
Message-ID: <Y+Vs2WxqXVQmh4+z@smile.fi.intel.com>
References: <20230203184907.18786-1-davthompson@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203184907.18786-1-davthompson@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 01:49:07PM -0500, David Thompson wrote:
> This commit adds ACPI handling for host-gpio[7] to trigger
> the power-button event.

This has something to discuss...

...

>  /* Pad Electrical Controls. */
> -#define MLXBF_GPIO_PAD_CONTROL_FIRST_WORD 0x0700
> -#define MLXBF_GPIO_PAD_CONTROL_1_FIRST_WORD 0x0708
> -#define MLXBF_GPIO_PAD_CONTROL_2_FIRST_WORD 0x0710
> -#define MLXBF_GPIO_PAD_CONTROL_3_FIRST_WORD 0x0718
> +#define MLXBF_GPIO_PAD_CONTROL_FIRST_WORD	0x0700
> +#define MLXBF_GPIO_PAD_CONTROL_1_FIRST_WORD	0x0708
> +#define MLXBF_GPIO_PAD_CONTROL_2_FIRST_WORD	0x0710
> +#define MLXBF_GPIO_PAD_CONTROL_3_FIRST_WORD	0x0718

Unrelated change.

> +#define MLXBF_GPIO_PIN_DIR_I                    0x1040
> +#define MLXBF_GPIO_PIN_DIR_O                    0x1048
> +#define MLXBF_GPIO_PIN_STATE                    0x1000
> +#define MLXBF_GPIO_SCRATCHPAD                   0x20

Ditto. You already have it defined, why to change?

> -#define MLXBF_GPIO_PIN_DIR_I 0x1040
> -#define MLXBF_GPIO_PIN_DIR_O 0x1048
> -#define MLXBF_GPIO_PIN_STATE 0x1000
> -#define MLXBF_GPIO_SCRATCHPAD 0x20

...

> +	gs->hwirq = irq;
> +	gc->to_irq = mlxbf_gpio_to_irq;

This sounds incorrect. Seems like for _any_ interrupt you will give the same
result. Moreover, you should not use to_irq(). Try to model proper IRQ chip.

...

>  	platform_set_drvdata(pdev, gs);
> +	acpi_gpiochip_request_interrupts(gc);

This is done by GPIO library, no?

...

>  	dev_info(&pdev->dev, "registered Mellanox BlueField GPIO");
> +
>  	return 0;

Stray change.

-- 
With Best Regards,
Andy Shevchenko


