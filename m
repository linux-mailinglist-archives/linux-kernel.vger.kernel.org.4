Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE29709819
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjESNTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjESNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:19:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914BFF5;
        Fri, 19 May 2023 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684502377; x=1716038377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eEhAEFLIKOmDZvy6O3OlkuPuCxuqqdM7KsLCVfR9U2A=;
  b=HG701rwws+scry9uiiy5bfpLhSyS1OEAKBaTyM6SJ2IjIG1QuKQHreuS
   9Aux3wP52HKILhyfmCNptUyGS/LY6U6vHUeYh+wKiLmXtGHa0r8fVazQ+
   WYdBN3bybjLq3axh3QyzwU5JRBeasJk4T9UEFBnpaURvHpbieRZg2K9eO
   lmPQTOAk3KjZXPmTmAHZhNzcKpbkc774rmMvFMq8G84B91cwne3gyevXq
   2YPGqyUcT2fOLhJ5qpS3ZYP/wc0Jz/OICxwF+rz+xj4Fu/gVPuweNn7ne
   OLZtbVeoMD/PKIAHcGqVE2Y4OPDp5+aOtF/IlQyUJqosAAi79PwI+dbAc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="354722547"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="354722547"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 06:19:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="733293981"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="733293981"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.109])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 06:19:34 -0700
Message-ID: <9094e3c9-77fd-081f-244a-9454b81bd3b6@intel.com>
Date:   Fri, 19 May 2023 16:19:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v4] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Content-Language: en-US
To:     Liming Sun <limings@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230512181527.189345-1-limings@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230512181527.189345-1-limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/23 21:15, Liming Sun wrote:
> This commit implements the runtime PM operations to disable eMMC
> card clock when idle.
> 
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
> v3->v4:
>     - Fix compiling reported by 'kernel test robot';
> v2->v3:
>     - Revise the commit message;
> v1->v2:
>     Updates for comments from Ulf:
>     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
> v1: Initial version.
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 54 ++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e68cd87998c8..2d780a5bc8fb 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>  
> @@ -546,6 +547,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  		sdhci_enable_v4_mode(host);
>  #endif
>  
> +	pm_runtime_enable(dev);

Is there a reason to call it this early?  That raises questions
about runtime PM racing with the rest of the host initialization.
Perhaps below instead (note also using devm):

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 2d780a5bc8fb..5cee42d72257 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -547,8 +547,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		sdhci_enable_v4_mode(host);
 #endif
 
-	pm_runtime_enable(dev);
-
 	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 
 	err = sdhci_setup_host(host);
@@ -562,6 +560,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	if (err)
 		goto err_setup_host;
 
+	devm_pm_runtime_enable(dev);
+
 	return 0;
 
 err_setup_host:


> +
>  	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>  
>  	err = sdhci_setup_host(host);
> @@ -646,7 +649,56 @@ static int dwcmshc_resume(struct device *dev)
>  }
>  #endif
>  
> -static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
> +#ifdef CONFIG_PM
> +
> +static void dwcmshc_enable_card_clk(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	ctrl |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +}
> +
> +static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	ctrl &= ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +}
> +
> +static int dwcmshc_runtime_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	ret = sdhci_runtime_suspend_host(host);
> +	if (!ret)
> +		dwcmshc_disable_card_clk(host);
> +
> +	return ret;
> +}
> +
> +static int dwcmshc_runtime_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	dwcmshc_enable_card_clk(host);
> +	ret = sdhci_runtime_resume_host(host, 0);
> +
> +	return ret;
> +}
> +
> +#endif
> +
> +static const struct dev_pm_ops dwcmshc_pmops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend, dwcmshc_resume)
> +	SET_RUNTIME_PM_OPS(dwcmshc_runtime_suspend,
> +			   dwcmshc_runtime_resume, NULL)
> +};
>  
>  static struct platform_driver sdhci_dwcmshc_driver = {
>  	.driver	= {

