Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D839A60CD14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiJYNLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiJYNKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:10:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E8926AC9;
        Tue, 25 Oct 2022 06:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666703437; x=1698239437;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IrpzDl6B3inCI4opbm0aajB2ZUkQjMkiT3FQzvFiIjk=;
  b=fE8cw9oIofeKJARelaV42ipMQKphDW6iXUS+08FIZdHl6K2Im+9VF1xJ
   paHtnnK5kjvxoYiALCGw2D/8Vb+yhFKzpfmULesVL5hGSRjNyh2CZ41Zz
   uYd3VvQA69iwnxEnwWAGtFp3A9zP1krbA6L+MiupSNnRDlENU7qRR3Zrv
   EYPwRN1sbdgHnsIdbroxcB4ZLmqoLUnD/Q5XNxAGdKEHDA16BFkYxxs7x
   iZGeTK9aoWS8vTflYVc0O1YO0kQEjM76000p+Tmy+IMeN6qA6BYBwCQ3f
   g1SM3vWuBBjujRd0isnKYlz1sAJx9knd9uNBdngdIhBjfTD2X8H6/bGic
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="305280693"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="305280693"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:10:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609564812"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="609564812"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.236])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:10:30 -0700
Message-ID: <dc787f32-a59c-db5e-37da-3659ae265380@intel.com>
Date:   Tue, 25 Oct 2022 16:10:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v3 5/7] mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
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
 <20221024105229.v3.5.I418c9eaaf754880fcd2698113e8c3ef821a944d7@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221024105229.v3.5.I418c9eaaf754880fcd2698113e8c3ef821a944d7@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
> Fixes: 3c4019f97978 ("mmc: tegra: HW Command Queue Support for Tegra SDMMC")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

This patch is dependent on "mmc: cqhci: Provide
helper for resetting both SDHCI and CQHCI".  Best point that out
in this commit message as well.

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes in v3:
>  - Use new SDHCI+CQHCI helper
> 
> Changes in v2:
>  - Drop unnecessary 'enable_hwcq' check
> 
>  drivers/mmc/host/sdhci-tegra.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 413925bce0ca..c71000a07656 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -28,6 +28,7 @@
>  
>  #include <soc/tegra/common.h>
>  
> +#include "sdhci-cqhci.h"
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
>  
> @@ -367,7 +368,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
>  	u32 misc_ctrl, clk_ctrl, pad_ctrl;
>  
> -	sdhci_reset(host, mask);
> +	sdhci_and_cqhci_reset(host, mask);
>  
>  	if (!(mask & SDHCI_RESET_ALL))
>  		return;

