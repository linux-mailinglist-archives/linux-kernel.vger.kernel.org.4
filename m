Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B394D60CAA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiJYLIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJYLIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:08:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C645E189520;
        Tue, 25 Oct 2022 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666696123; x=1698232123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pMfcDWmEvv6uwFR85xXT/GMoLUi2ugbCSFtAe8+1dKs=;
  b=jGcmf+9BfxH58yN4P28htn587XvvFQwUvUryrT9xUd+uuSVvbEsDMxNo
   27RBw4j8eFdgjgrxP/1Wzll0ZNDx+dPDoWdPbRmQdXUQfIvanrtZCOr5R
   /0MIwgRzn2jiD/LF32vcciRHFvzdooEjnA1p9hbFMI7cXwutdeC/pBcsV
   WToBJpNMdItR2582XZyWxhAstTKIwv8pxO2rRRGN71QzXV81l2WqU1jeI
   Q0TDjn7tAE6pejtUa/puD4YAWfSO3geK72qMmzDqiaw3RNN3PMFj+XrUa
   BpgjHSGDnV0ddk62O+PReCwbGkhbc4WtL5p1GJq+XNxeFLUxVkP1gH8zF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308740065"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="308740065"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 04:08:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="664871795"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="664871795"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.236])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 04:08:40 -0700
Message-ID: <8a1549d5-7407-7e47-5fbe-bcb9ca953cda@intel.com>
Date:   Tue, 25 Oct 2022 14:08:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Allow building with COMPILE_TEST
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org
References: <20221024181759.2355583-1-briannorris@chromium.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221024181759.2355583-1-briannorris@chromium.org>
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

On 24/10/22 21:17, Brian Norris wrote:
> This driver is pretty simple, and it can be useful to build it (for
> validation purposes) without BMIPS or ARCH_BRCMSTB.
> 
> It technically depends on CONFIG_OF to do anything useful at runtime,
> but it still works out OK for compile-testing using the !OF stubs.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f324daadaf70..453fba8d2d9d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1040,10 +1040,10 @@ config MMC_SDHCI_MICROCHIP_PIC32
>  
>  config MMC_SDHCI_BRCMSTB
>  	tristate "Broadcom SDIO/SD/MMC support"
> -	depends on ARCH_BRCMSTB || BMIPS_GENERIC
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>  	depends on MMC_SDHCI_PLTFM
>  	select MMC_CQHCI
> -	default y
> +	default ARCH_BRCMSTB || BMIPS_GENERIC
>  	help
>  	  This selects support for the SDIO/SD/MMC Host Controller on
>  	  Broadcom STB SoCs.

