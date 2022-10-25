Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C8160CD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiJYNLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiJYNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:11:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665204D15F;
        Tue, 25 Oct 2022 06:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666703468; x=1698239468;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a/qqwi8m/snqSKRNwfW4yQIJyJ9DkUuatXc42ShFjNo=;
  b=A07LLRK43gQA5KuOU72nAZ43ZNd7gwhggFSTbsdBhdgOFr02ULzMWcl7
   iUDid+zDtduP3p8rZ2JmGJtEwC/I5H8zB9xo58oebZtXfnCJwWpBtu4hi
   Dq9x2WlD/6TjlmjRNL2vzHEFzRugsj9hN7JPoyCAWlces5Pil2TLw6H9j
   ryIBbjnJLNVWqH0FdU6wVWn0FNVTpkEuBAoAN9J5LooaXm5XuSck1e3HU
   uup4gqx9Nq2oPxpETaQ4y8YM1SLAdc/VcTzmk/7xh9SMqV2AL6g7dCYeC
   +dqYf+n9BHIn4UV06HRbHxuaQkuvDW8Y1RR+fLLwsyGno5JHtVxjYnAV9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="288064935"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="288064935"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:11:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609564925"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="609564925"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.236])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:11:00 -0700
Message-ID: <85ed639e-4f87-d57e-ceca-60b8eca4f8b3@intel.com>
Date:   Tue, 25 Oct 2022 16:10:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v3 7/7] mmc: sdhci-*: Convert drivers to new
 sdhci_and_cqhci_reset()
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
 <20221024105229.v3.7.Ia91f031f5f770af7bd2ff3e28b398f277606d970@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221024105229.v3.7.Ia91f031f5f770af7bd2ff3e28b398f277606d970@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/22 20:55, Brian Norris wrote:
> An earlier patch ("mmc: cqhci: Provide helper for resetting both SDHCI
> and CQHCI") does these operations for us.
> 
> I keep these as a separate patch, since the earlier patch is a
> prerequisite to some important bugfixes that need to be backported via
> linux-stable.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
> 
> Changes in v3:
>  - Rewrite to new helper, patch sdhci-msm too
> 
> Changes in v2:
>  - Factor out ->cqe_private helpers
> 
>  drivers/mmc/host/sdhci-msm.c      | 10 ++--------
>  drivers/mmc/host/sdhci-pci-core.c | 11 ++---------
>  drivers/mmc/host/sdhci-pci-gli.c  | 11 ++---------
>  3 files changed, 6 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3a091a387ecb..03f76384ab3f 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -19,6 +19,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/reset.h>
>  
> +#include "sdhci-cqhci.h"
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
>  
> @@ -2304,13 +2305,6 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>  	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
>  }
>  
> -static void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
> -{
> -	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
> -		cqhci_deactivate(host->mmc);
> -	sdhci_reset(host, mask);
> -}
> -
>  static int sdhci_msm_register_vreg(struct sdhci_msm_host *msm_host)
>  {
>  	int ret;
> @@ -2450,7 +2444,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
>  MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
>  
>  static const struct sdhci_ops sdhci_msm_ops = {
> -	.reset = sdhci_msm_reset,
> +	.reset = sdhci_and_cqhci_reset,
>  	.set_clock = sdhci_msm_set_clock,
>  	.get_min_clock = sdhci_msm_get_min_clock,
>  	.get_max_clock = sdhci_msm_get_max_clock,
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 169b84761041..cc039155b5c7 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -38,6 +38,7 @@
>  #include "cqhci.h"
>  
>  #include "sdhci.h"
> +#include "sdhci-cqhci.h"
>  #include "sdhci-pci.h"
>  
>  static void sdhci_pci_hw_reset(struct sdhci_host *host);
> @@ -234,14 +235,6 @@ static void sdhci_pci_dumpregs(struct mmc_host *mmc)
>  	sdhci_dumpregs(mmc_priv(mmc));
>  }
>  
> -static void sdhci_cqhci_reset(struct sdhci_host *host, u8 mask)
> -{
> -	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
> -	    host->mmc->cqe_private)
> -		cqhci_deactivate(host->mmc);
> -	sdhci_reset(host, mask);
> -}
> -
>  /*****************************************************************************\
>   *                                                                           *
>   * Hardware specific quirk handling                                          *
> @@ -703,7 +696,7 @@ static const struct sdhci_ops sdhci_intel_glk_ops = {
>  	.set_power		= sdhci_intel_set_power,
>  	.enable_dma		= sdhci_pci_enable_dma,
>  	.set_bus_width		= sdhci_set_bus_width,
> -	.reset			= sdhci_cqhci_reset,
> +	.reset			= sdhci_and_cqhci_reset,
>  	.set_uhs_signaling	= sdhci_intel_set_uhs_signaling,
>  	.hw_reset		= sdhci_pci_hw_reset,
>  	.irq			= sdhci_cqhci_irq,
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 4d509f656188..633a8ee8f8c5 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/iopoll.h>
>  #include "sdhci.h"
> +#include "sdhci-cqhci.h"
>  #include "sdhci-pci.h"
>  #include "cqhci.h"
>  
> @@ -922,14 +923,6 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
>  	return ret;
>  }
>  
> -static void sdhci_gl9763e_reset(struct sdhci_host *host, u8 mask)
> -{
> -	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
> -	    host->mmc->cqe_private)
> -		cqhci_deactivate(host->mmc);
> -	sdhci_reset(host, mask);
> -}
> -
>  static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>  {
>  	struct pci_dev *pdev = slot->chip->pdev;
> @@ -1136,7 +1129,7 @@ static const struct sdhci_ops sdhci_gl9763e_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.enable_dma		= sdhci_pci_enable_dma,
>  	.set_bus_width		= sdhci_set_bus_width,
> -	.reset			= sdhci_gl9763e_reset,
> +	.reset			= sdhci_and_cqhci_reset,
>  	.set_uhs_signaling	= sdhci_set_gl9763e_signaling,
>  	.voltage_switch		= sdhci_gli_voltage_switch,
>  	.irq                    = sdhci_gl9763e_cqhci_irq,

