Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2410A60F1AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiJ0H65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJ0H6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:58:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB96C625D5;
        Thu, 27 Oct 2022 00:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666857533; x=1698393533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MAhoxDpWOZ3W1/ZytWkfCJ/aC+ldNer6TRDQPscOqWw=;
  b=G00vNwuJnAYX0pBtH12aIW970n0Og3xLen2TDWurkevsWDEWV3rsizey
   M15GMpLLPPEedRJ+gmN3FpG0OpcPEuXNBW9GYYfJqsLs/2Teh6piOn1dq
   1VUqdREs9kL/mNgoAtz4Mi6fiE+dtzu2IKDQF6I7ncyfimN8+yi53L7Y5
   Lokh8eekMkp8UGPZqBXSsBQe0YRzoJdTRnaLWrB24Zrxj/zV01Jfp6lHi
   pfGXemkP6l0A4UkzqzLN/+tF3ECRhhaLu/NTOvAuwVD4zhE7FlhtS9BEr
   5iqP+S7uX8Ym++9o4uETjh/VETbIa0Qts1GNCtJlEydylBj27cjPxBV4E
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="370225130"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="370225130"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 00:58:53 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="583465107"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="583465107"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.150])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 00:58:47 -0700
Message-ID: <ae846c69-095f-1ad9-af4b-bd8d636e78e4@intel.com>
Date:   Thu, 27 Oct 2022 10:58:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v4 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-mmc@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Al Cooper <alcooperx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
References: <20221026194209.3758834-1-briannorris@chromium.org>
 <20221026124150.v4.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221026124150.v4.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/22 22:42, Brian Norris wrote:
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
> This patch depends on (and should not compile without) the patch
> entitled "mmc: cqhci: Provide helper for resetting both SDHCI and
> CQHCI".
> 
> Fixes: f545702b74f9 ("mmc: sdhci_am654: Add Support for Command Queuing Engine to J721E")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes in v4:
>  - Also fix sdhci_am654_ops, sdhci_j721e_8bit_ops
>  - Add dependency notes
>  - Drop bouncing Faiz Abbas <faiz_abbas@ti.com> address
> 
> Changes in v3:
>  - Use new SDHCI+CQHCI helper
> 
>  drivers/mmc/host/sdhci_am654.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 8f1023480e12..c2333c7acac9 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -15,6 +15,7 @@
>  #include <linux/sys_soc.h>
>  
>  #include "cqhci.h"
> +#include "sdhci-cqhci.h"
>  #include "sdhci-pltfm.h"
>  
>  /* CTL_CFG Registers */
> @@ -378,7 +379,7 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>  
> -	sdhci_reset(host, mask);
> +	sdhci_and_cqhci_reset(host, mask);
>  
>  	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
>  		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> @@ -464,7 +465,7 @@ static struct sdhci_ops sdhci_am654_ops = {
>  	.set_clock = sdhci_am654_set_clock,
>  	.write_b = sdhci_am654_write_b,
>  	.irq = sdhci_am654_cqhci_irq,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_and_cqhci_reset,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_am654_pdata = {
> @@ -494,7 +495,7 @@ static struct sdhci_ops sdhci_j721e_8bit_ops = {
>  	.set_clock = sdhci_am654_set_clock,
>  	.write_b = sdhci_am654_write_b,
>  	.irq = sdhci_am654_cqhci_irq,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_and_cqhci_reset,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {

