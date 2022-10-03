Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF82D5F2CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJCJCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiJCJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:02:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17286407;
        Mon,  3 Oct 2022 01:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664787084; x=1696323084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1kdZrMcFb7tNUx3moMQlbtwo9V8AT+4Mp3hD9yrIiBE=;
  b=XGRGPSoZgmuSHYXAuzJfyEY2+6eqal7uZXBTKwff9BWefPDLmw0ov3LE
   2IVaIfvK/InbrUZTYpSJXrOoycOCWK2c+Syuk+fD8KtPWOpnJRt9zNkVq
   g8GM/1xXatS9T5ylbILN9IhoQREKpGQa0eOq373GutEFNutS9hPy8+fqR
   dpG6XVk4F8NFZCMqvwikEpIzeX+VPtw7bonBMfLD1lASiZFKtbvHBCxLg
   MwlzRx0Fi8so8yddAyF5FUgIsr+EV+5DpSQytvymEsxUxYzXgGVI9IqE8
   gEAmiV/Co4GwPYt1LpQpUMdUKR0Jx31ibVkUEdQqGWyKovjI3gSgYMSnN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="388872870"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="388872870"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 01:51:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="765836989"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="765836989"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Oct 2022 01:51:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Oct 2022 11:51:20 +0300
Date:   Mon, 3 Oct 2022 11:51:20 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     gregkh@linuxfoundation.org, Sanket.Goswami@amd.com,
        singhanc@nvidia.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] usb: typec: ucsi_ccg: Disable UCSI ALT support on
 Tegra
Message-ID: <YzqiiG/E+Bs1pbdy@kuha.fi.intel.com>
References: <20220928150840.3804313-1-waynec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928150840.3804313-1-waynec@nvidia.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:08:40PM +0800, Wayne Chang wrote:
> From: Sing-Han Chen <singhanc@nvidia.com>
> 
> Firmware built for Tegra doesn't support UCSI ALT command and has known
> issue of reporting wrong capability info.
> 
> This commit disables UCSI ALT support when reading the capability on
> Tegra.
> 
> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> Signed-off-by: Wayne Chang <waynec@nvidia.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> V1 -> V2: updated the commit message and removed the unnecessary changes for RTX
> We are now enabling the NVIDIA Tegra products on upstream kernel.
> The change is to add the Cypress cypd 4226 support for NVIDA Tegra
> products including Xavier AGX, Xavier Orin and the upcoming products.
> The Cypress cypd4226 is not enabled in current kernel codebase.
> And thus, we shall not need it for stable kernels and backporting
> 
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index 5c0bf48be766..cbd93f893e48 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -125,6 +125,11 @@ struct version_format {
>  #define CCG_FW_BUILD_NVIDIA	(('n' << 8) | 'v')
>  #define CCG_OLD_FW_VERSION	(CCG_VERSION(0x31) | CCG_VERSION_PATCH(10))
>  
> +/* Firmware for Tegra doesn't support UCSI ALT command, built
> + * for NVIDIA has known issue of reporting wrong capability info
> + */
> +#define CCG_FW_BUILD_NVIDIA_TEGRA	(('g' << 8) | 'n')
> +
>  /* Altmode offset for NVIDIA Function Test Board (FTB) */
>  #define NVIDIA_FTB_DP_OFFSET	(2)
>  #define NVIDIA_FTB_DBG_OFFSET	(3)
> @@ -513,6 +518,7 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
>  {
>  	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
>  	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
> +	struct ucsi_capability *cap;
>  	struct ucsi_altmode *alt;
>  	int ret;
>  
> @@ -536,6 +542,12 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
>  				ucsi_ccg_nvidia_altmode(uc, alt);
>  		}
>  		break;
> +	case UCSI_GET_CAPABILITY:
> +		if (uc->fw_build == CCG_FW_BUILD_NVIDIA_TEGRA) {
> +			cap = val;
> +			cap->features &= ~UCSI_CAP_ALT_MODE_DETAILS;
> +		}
> +		break;
>  	default:
>  		break;
>  	}

thanks,

-- 
heikki
