Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9E74DAA9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjGJQBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjGJQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:01:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C08183;
        Mon, 10 Jul 2023 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689004889; x=1720540889;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=BEqQpghDZjpM9YsJZUgYeAP0Afs0sOMus9i+3W7TR3U=;
  b=GtK3SJrxwLQmh8lIBjvnpqQ/1rAQfLlp/M3a7foVQvjZmP/Hsr1ZpDq4
   Wy2RNyMGOxH3/1AC9zwFLpAaJLl+HmKEJSxgBoGSXt6dHYkY2z9DhBCGZ
   PBrpHUzCd41m6J2q9tiQegtv2UN5ZvKl01p/t12lvwWTWBKSYpdhoAj4h
   VoeJjohdMs/ubh3Jl9xIJ2QOQM8mExFlFGQPFSIHM4QtxC03g+Q3s8elp
   FUFRfXXUQB5gxjep73RDScQgpttxg/li/r6kE5Jgi26EhdYqhklfdxF+F
   j0NN4qeM52QLpOJ5/vnnY1mSZ8AHYvwVaUAUkY+Xdt6y2+FqH4cpCpfZr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="364421001"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364421001"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:01:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="834319992"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="834319992"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.97])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:01:21 -0700
Message-ID: <d8d7a64b-3640-d695-8f07-a75b702e32cf@intel.com>
Date:   Mon, 10 Jul 2023 19:01:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V8 08/23] mmc: sdhci: add UHS-II module and add a kernel
 configuration
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-9-victorshihgli@gmail.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230621100151.6329-9-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/23 13:01, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> This patch adds sdhci-uhs2.c as a module for UHS-II support.
> This is a skelton for further development in this patch series.

skelton -> skeleton

> 
> This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
> in the following commits to indicate UHS-II specific code in sdhci
> controllers.
> 
> Updates in V8:
>  - Modify MODULE_LICENSE from "GPL v2" to "GPL".
> 
> Updates in V6:
>  - Merage V5 of patch[7] and patch[9] in to V6 of patch[8].
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
> index 159a3e9490ae..215f1ab011dd 100644
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
> index 000000000000..608f8ad5aaed
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
> +MODULE_LICENSE("GPL");

