Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362CB6A80BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCBLJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjCBLJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:09:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F03125B1;
        Thu,  2 Mar 2023 03:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677755389; x=1709291389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ARbYTiI686AIOV0PhH0M827jzSEzKv2rCVlEwrQ+LeI=;
  b=g42Wr+z2oK60izEip/g8hBTz93h247iwuJfgmPWQqZDiQAQxQB+zs2lF
   zH8+ENP19VbRMgX+KGPvsrF5QAcsnfyWYW/yc8ZjYYCWMnFluy2sflKnw
   qVu0nfv+yp819JC1GWklv95AG5LWEPwkvR5NWyj9fPCTK8JNS2PHy8JGR
   nMGj3MnitKOSOTvQxFsnznuuGNwWgxMLx/wWQe5sOmzV0yFq+bSa/hIHD
   B4sPHWfcW5BXEmlMpfeSyDba74aI2lA7jme/qWVErkt10dKT9VEQ07u25
   T4/VNfSc/VuDciLY/PrVZtMU/Frl3LW/uihuRHNCyP0l9VcC+gIpyK4Yc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="315112614"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="315112614"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 03:09:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="624902798"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="624902798"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.217.72])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 03:09:45 -0800
Message-ID: <a5b66147-260e-29ae-d0a9-21cb6c905237@intel.com>
Date:   Thu, 2 Mar 2023 13:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add support to request the "gate"
 clock
Content-Language: en-US
To:     Swati Agarwal <swati.agarwal@amd.com>, michal.simek@xilinx.com,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@amd.com
References: <20230223141402.23979-1-swati.agarwal@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230223141402.23979-1-swati.agarwal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/23 16:14, Swati Agarwal wrote:
> Add support to read the optional "gate" clock property and request the
> clock which will be used to ungate the DLL clock.
> 
> For Xilinx platforms which has DLL module, dll clock must be
> ungated/enabled when SD controller operates at higher frequencies like 50
> MHz, 100 MHz and 200 MHz. This will be done by explicitly requesting gate
> clock from the driver.
> 
> Signed-off-by: Swati Agarwal <swati.agarwal@amd.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 4eebbf801b41..1fd7528c14fc 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1870,6 +1870,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	int ret;
>  	struct device_node *node;
>  	struct clk *clk_xin;
> +	struct clk *clk_dll;
>  	struct sdhci_host *host;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct device *dev = &pdev->dev;
> @@ -1943,6 +1944,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		goto clk_dis_ahb;
>  	}
>  
> +	clk_dll = devm_clk_get_optional_enabled(dev, "gate");
> +	if (IS_ERR(clk_dll)) {
> +		ret = dev_err_probe(dev, PTR_ERR(clk_dll), "failed to get dll clk\n");
> +		goto clk_disable_all;
> +	}
> +
>  	if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
>  		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
>  

