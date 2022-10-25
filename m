Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8A460CD0C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiJYNKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiJYNKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:10:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32441E3EF;
        Tue, 25 Oct 2022 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666703403; x=1698239403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+iUxHvpoh1YwJJhtsPMR7liDir2BZE7kksi0cOLN2kw=;
  b=WcBTncx/btrr6ZxF0solgbFU4QNm2QfWFJHULrD3aG0/cibiQNC0IPsR
   gA4ROlB/7ooGD0Vr5q7smmg9WBZwuqM28a39kPO2S6XaNhFPVWKmTkuuI
   g2TDEG2X7HTwB3aMWUoL0STM5aINYXM/jEZdL+mlinSgKwIt+ytDtu1m7
   PF+HqwzLMjgv6435pTowdua4QlSkj9e10d/xZ4ZX4sebn7Ffi4mC+X/3a
   On1pNoXsPRE9ZRe1vEbvgost+PDGA2FcDsdxyWLxl1IQcaFtvOzJrU5MJ
   0HeX5tJCV6ZelCKDfR9YYxGufgn2I7YVleyNfCbd7EMSV4bjuSLV+FlUG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="307662705"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="307662705"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:10:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626415160"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="626415160"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:09:55 -0700
Message-ID: <ea8f1e80-7071-c5e5-1de7-50823b279c7b@intel.com>
Date:   Tue, 25 Oct 2022 16:09:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v3 3/7] mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
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
 <20221024105229.v3.3.I6a715feab6d01f760455865e968ecf0d85036018@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221024105229.v3.3.I6a715feab6d01f760455865e968ecf0d85036018@changeid>
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
> Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
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
>  - Rely on cqhci_deactivate() to handle NULL cqe_private, instead of
>    moving around CQE capability flags
> 
>  drivers/mmc/host/sdhci-brcmstb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index aff36a933ebe..55d8bd232695 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -12,6 +12,7 @@
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  
> +#include "sdhci-cqhci.h"
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
>  
> @@ -55,7 +56,7 @@ static void brcmstb_reset(struct sdhci_host *host, u8 mask)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
>  
> -	sdhci_reset(host, mask);
> +	sdhci_and_cqhci_reset(host, mask);
>  
>  	/* Reset will clear this, so re-enable it */
>  	if (priv->flags & BRCMSTB_PRIV_FLAGS_GATE_CLOCK)

