Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EB660CD11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJYNKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiJYNKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:10:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F13B948;
        Tue, 25 Oct 2022 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666703418; x=1698239418;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NuDZQcUV4SojqIqkjTfI5hZYdLjn5tWqxMSX/pgURoY=;
  b=Kx16FdV7PAH7fEcYldedpHL/vVhFl45wLB2s6mycbtXPovOkqca1rxP/
   3yn/6hRw6EjebftbKVuGkiXILfr353zNnBgCEbuWjHhdLTUbJJMRRBXsp
   T4420ngBY2AJc/8FqEw067dEAEDI0u7geZ+Nf2aNTuGn1GQ1DhywOoLl8
   Jcfo/YYQWGsDsuzGo6oSGJq7FDIpLyPbUde9EiqEtvwlheHCAu25nZJ0J
   28eQIDm/5jF6DH3g4AffNdAu7RBCDNd8xFVzTjRIcitnmXrlZf62ei/Kc
   trea1Hka5zLSuvQHJLho72SxAdS9bb9W03ssHTBN2xCtekFQuDFrH5MF3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="295071032"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="295071032"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:10:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626415253"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="626415253"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:10:12 -0700
Message-ID: <4ddc5ec2-0a76-5017-3d46-8864a7818342@intel.com>
Date:   Tue, 25 Oct 2022 16:10:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v3 4/7] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for
 CQHCI
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Faiz Abbas <faiz_abbas@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20221024175501.2265400-1-briannorris@chromium.org>
 <20221024105229.v3.4.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221024105229.v3.4.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/22 20:54, Brian Norris wrote:
>  [[ NOTE: this is completely untested by the author, but included solely
>     because, as noted in commit df57d73276b8 ("mmc: sdhci-pci: Fix
>     SDHCI_RESET_ALL for CQHCI for Intel GLK-based controllers"), "other
>     drivers using CQHCI might benefit from a similar change, if they
>     also have CQHCI reset by SDHCI_RESET_ALL." We've now seen the same
>     bug on at least MSM, Arasan, and Intel hardware. ]]
> 
> SDHCI_RESET_ALL resets will reset the hardware CQE state, but we aren't
> tracking that properly in software. When out of sync, we may trigger
> various timeouts.
> 
> It's not typical to perform resets while CQE is enabled, but this may
> occur in some suspend or error recovery scenarios.
> 
> Include this fix by way of the new sdhci_and_cqhci_reset() helper.
> 
> Fixes: bb6e358169bf ("mmc: sdhci-esdhc-imx: add CMDQ support")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

This patch is dependent on "mmc: cqhci: Provide
helper for resetting both SDHCI and CQHCI".  Best point that out
in this commit message as well.

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes in v3:
>  - Use new SDHCI+CQHCI helper
>  - Add Reviewed-by
> 
> Changes in v2:
>  - Drop unnecessary ESDHC_FLAG_CQHCI check
> 
>  drivers/mmc/host/sdhci-esdhc-imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 55981b0f0b10..b297c3c360eb 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -25,6 +25,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pm_runtime.h>
> +#include "sdhci-cqhci.h"
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
>  #include "cqhci.h"
> @@ -1288,7 +1289,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  
>  static void esdhc_reset(struct sdhci_host *host, u8 mask)
>  {
> -	sdhci_reset(host, mask);
> +	sdhci_and_cqhci_reset(host, mask);
>  
>  	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);

