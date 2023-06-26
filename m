Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2133B73D90F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFZICb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFZICa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:02:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D530B83;
        Mon, 26 Jun 2023 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687766549; x=1719302549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=33R3Tx+sLALtrskmrs2zu7v/fiTCIeLJSoVnhjKIrwU=;
  b=ZhCbPCt/g1IF00B4Fq+MdF75MwxRtMqiGl/YHRZBmpQPPd0CP0M3V7KO
   FOhs4h+f8kTylaBv06YPh1hjJ5ete37V/1j1SkSdnL6NTb6P8fpjX9FYh
   Qdn+p1m6+vs5MX3+RNKnCjEoQclnn51LWW+vs5h7VB1XJZIiEjGT9a7qP
   CC5yQ/nlooPlxmJD1CKiGVuPKALxrRFPshoQkqEONfHUK24wMLtfkpPIV
   fgLBhS3hNsBTI03WPQOO6MhwQi5NiEcfwKtURLHG6gVZFtsJ8T5guN8Kj
   4z2helMGMd9aLIBl3RCKFicMN8HHQDxew9dffgtyEReSGOahrfFtAmw6D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="447587397"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="447587397"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 01:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="860594379"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="860594379"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Jun 2023 01:02:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Jun 2023 11:02:26 +0300
Date:   Mon, 26 Jun 2023 11:02:26 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: nb7vpq904m: fix CONFIG_DRM dependency
Message-ID: <ZJlGEiE64A2qQHD7@kuha.fi.intel.com>
References: <20230622-topic-sm8x50-upstream-redriver-config-fix-v1-1-005ab6f4d1f5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622-topic-sm8x50-upstream-redriver-config-fix-v1-1-005ab6f4d1f5@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 06:16:26PM +0200, Neil Armstrong wrote:
> With the following config set:
> CONFIG_DRM=m
> CONFIG_DRM_PANEL=y
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> CONFIG_TYPEC_MUX_NB7VPQ904M=y
> 
> vmlinux fails on the following symbols:
>   ld.lld: error: undefined symbol: devm_drm_bridge_add
>   ld.lld: error: undefined symbol: devm_drm_of_get_bridge
> 
> Add dependendy on DRM || DRM=no since CONFIG_DRM dependency is optional
> and guarded by:
> IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
> in the drive.
> 
> Also add "select DRM_PANEL_BRIDGE if DRM" to clarify DRM_PANEL_BRIDGE
> is required if CONFIG_DRM is enabled.
> 
> Fixes: 88d8f3ac9c67 ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> This is re-spin of [1]
> 
> [1] https://lore.kernel.org/all/20230622101813.3453772-1-arnd@kernel.org/
> ---
>  drivers/usb/typec/mux/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
> index 8c4d6b8fb75c..784b9d8107e9 100644
> --- a/drivers/usb/typec/mux/Kconfig
> +++ b/drivers/usb/typec/mux/Kconfig
> @@ -38,6 +38,8 @@ config TYPEC_MUX_INTEL_PMC
>  config TYPEC_MUX_NB7VPQ904M
>  	tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
>  	depends on I2C
> +	depends on DRM || DRM=n
> +	select DRM_PANEL_BRIDGE if DRM
>  	select REGMAP_I2C
>  	help
>  	  Say Y or M if your system has a On Semiconductor NB7VPQ904M Type-C
> 
> ---
> base-commit: c87d46a9e8ebd2f2c3960927b1d21687096d1109
> change-id: 20230622-topic-sm8x50-upstream-redriver-config-fix-8f0aef3e2129
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>

-- 
heikki
