Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F866DF68C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjDLNKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjDLNK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:10:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E891729E;
        Wed, 12 Apr 2023 06:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305006; x=1712841006;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=cclt4b8S3abTAM5Ww3+bh9AkLLXUDdZKcs3BgQspMi8=;
  b=PwdlGSZ9rS4oGjl5XPQGi5c7p9JpOnfcziaH21kwTE1gggcwyBkBuiXA
   oRDklD7leU3YVc2rdaiJP4449J2Mn7tDfb684Nr7KHe+2DIUwdzFsXE3O
   EgimfrYSC3B6QaG5LKx8rmt69YaGB4n/WOSTbm9WFbCkOygxSnI1x43B/
   RC4fMGvC3Z5U3F90lPPIyvrZuQc9BwMGw/vlCTWXUH8YHVyywhp9ZZqBa
   XmVjsFmIwzvKRbvrNyqKjxyEkOXzLU5s51b6t3DudSOF4sD45AKmDC3OE
   BD+GR3lQQPO2WBW8zcQ5PesHj+Qow7z84824Oq3k7v7iYJw4znz7DDuME
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="343894757"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="343894757"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="758223696"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="758223696"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:09:57 -0700
Message-ID: <1730bd81-c101-c426-bffb-900b5bbe2d78@intel.com>
Date:   Wed, 12 Apr 2023 16:09:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 08/23] mmc: sdhci: add UHS-II module and add a kernel
 configuration
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-9-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230331105546.13607-9-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/23 13:55, Victor Shih wrote:
> This patch adds sdhci-uhs2.c as a module for UHS-II support.
> This is a skelton for further development in this patch series.
> 
> This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
> in the following commits to indicate UHS-II specific code in sdhci
> controllers.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/Kconfig      |  9 +++++++
>  drivers/mmc/host/Makefile     |  1 +
>  drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 4745fe217ade..06ab111eba3b 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -98,6 +98,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
>  
>  	  This is the case for the Nintendo Wii SDHCI.
>  
> +config MMC_SDHCI_UHS2
> +	tristate "UHS2 support on SDHCI controller"
> +	depends on MMC_SDHCI
> +	help
> +	  This option is selected by SDHCI controller drivers that want to
> +	  support UHS2-capable devices.
> +
> +	  If you have a controller with this feature, say Y or M here.
> +
>  config MMC_SDHCI_PCI
>  	tristate "SDHCI support on PCI bus"
>  	depends on MMC_SDHCI && PCI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index a693fa3d3f1c..799f21d1f81f 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)		+= pxamci.o
>  obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
>  obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
> +obj-$(CONFIG_MMC_SDHCI_UHS2)	+= sdhci-uhs2.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
>  sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
>  				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> new file mode 100644
> index 000000000000..8e15bd0dadee
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controller
> + *  Interface driver
> + *
> + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + *  Copyright (C) 2020 Genesys Logic, Inc.
> + *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> + *  Copyright (C) 2020 Linaro Limited
> + *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + */
> +
> +#include <linux/module.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-uhs2.h"
> +
> +#define DRIVER_NAME "sdhci_uhs2"
> +#define DBG(f, x...) \
> +	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
> +
> +/*****************************************************************************\
> + *                                                                           *
> + * Driver init/exit                                                          *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> +{
> +	return 0;
> +}
> +
> +static int __init sdhci_uhs2_mod_init(void)
> +{
> +	return 0;
> +}
> +module_init(sdhci_uhs2_mod_init);
> +
> +static void __exit sdhci_uhs2_mod_exit(void)
> +{
> +}
> +module_exit(sdhci_uhs2_mod_exit);
> +
> +MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
> +MODULE_DESCRIPTION("MMC UHS-II Support");
> +MODULE_LICENSE("GPL v2");

Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")


