Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B4460CD18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiJYNLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJYNK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:10:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B731149;
        Tue, 25 Oct 2022 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666703456; x=1698239456;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VVlujB/cz9ZUCXNMtrIi2HKxeUPoRwEaigfOkFKHfpY=;
  b=L8HnEc68KPuXRL9LnWGO8J7v5235rj3rroHVyWV/7BR5ymwZacgri/zj
   d6FUJYpgSEehcFgsNVjv5b1ZsdOBQijd8rfsddiVbFly8J31OTS2JrWvC
   ykSb3/J0O59a2zK/SdpiW6cGDzqXZUCzdMVAABJac5aoPoOaiSfPK++/r
   Vll5Q9JdzX+iCZUEf7orHu6qlhu3fAcOaEZhVWgNuXtLfEdX89DMmSxzl
   OD8B1XTwV+TxT3J03ywXM4u2wz/yYPIzjWP4bOMHj4aPONrsb+rx/gUCj
   fN1tuAMJm9hVqyUKHO78tn9219EMa22vUVFQ2esX6ubMEarfiYwkAXome
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="334265217"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="334265217"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:10:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609564862"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="609564862"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.236])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:10:48 -0700
Message-ID: <5b91c0eb-52aa-8431-c286-81b7feae84ce@intel.com>
Date:   Tue, 25 Oct 2022 16:10:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v3 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
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
 <20221024105229.v3.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221024105229.v3.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/22 20:55, Brian Norris wrote:
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
> Fixes: f545702b74f9 ("mmc: sdhci_am654: Add Support for Command Queuing Engine to J721E")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> Changes in v3:
>  - Use new SDHCI+CQHCI helper
> 
>  drivers/mmc/host/sdhci_am654.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 8f1023480e12..6a282c7a221e 100644
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

What about sdhci_reset in sdhci_am654_ops ?

