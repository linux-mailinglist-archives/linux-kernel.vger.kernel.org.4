Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDAE5E5D56
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiIVIUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiIVIUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:20:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD527CC8FF;
        Thu, 22 Sep 2022 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663834838; x=1695370838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yld6IQ6mlYNH0Gl6RjlZ1Fs+6PQmDlHxoH3TMWnnYl8=;
  b=kXwrjCn7LhsLFBvp1BOrpsW2rkpU2Jg36AFpXB4l//jq6iJ2AjG5hmnW
   d8uIDo/PyTkTzvdQfjBo64ZQs4YMLRRLQoss17kRDHXCyCLjFnL2rQs6O
   t8hwFyD3gupeM3b4aSU/6kNKSMoJgQuWjw+kK696lTKf9HdWW34J/qzZu
   glQBg5HkrIcO/OwitXohMHYQT4GczBnVFwR/z2ldWZkhEPTJFGiCCS9z/
   aa5OC55sfjdbfspb55a7Gjs1IDxXy4oGRLeeh6oA8+CaNNyqyC6I7HadQ
   BNJU+/WP5MGWiqWnR9GKr6UJvqU/1Czhe7byzxWXKA964vNXWvcKhwhaz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="386524286"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="386524286"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 01:20:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="570875460"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 01:20:35 -0700
Message-ID: <12b21bad-4f7b-ebc9-b896-20ec8a88c105@intel.com>
Date:   Thu, 22 Sep 2022 11:20:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] mmc: sdhci-pci-core: Disable ES for ASUS BIOS on
 Jasper Lake
Content-Language: en-US
To:     Patrick Thompson <ptf@google.com>,
        Linux MMC Development <linux-mmc@vger.kernel.org>
Cc:     Sangwhan Moon <sxm@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220919204651.1517899-1-ptf@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220919204651.1517899-1-ptf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/22 23:46, Patrick Thompson wrote:
> Enhanced Strobe (ES) does not work correctly on the ASUS 1100 series of
> devices. Jasper Lake eMMCs (pci_id 8086:4dc4) are supposed to support
> ES. There are also two system families under the series, thus this is
> being scoped to the ASUS BIOS.
> 
> The failing ES prevents the installer from writing to disk. Falling back
> to HS400 without ES fixes the issue.
> 
> Signed-off-by: Patrick Thompson <ptf@google.com>

Presumably needs a fixes tag i.e.

Fixes: 315e3bd7ac19 ("mmc: sdhci-pci: Add support for Intel JSL")

> 
> ---
> 
> Changes in v2:
> V1->V2:
> * Only disable ES instead of CQE in its entirety.
> * Target Jasper Lake (JSL)
> * Target ASUS BIOS instead of specific system family
> 
>  drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 622b7de96c7f..42406f76f65c 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -893,6 +893,12 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
>  		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
>  }
>  
> +static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)
> +{
> +	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_JSL_EMMC &&
> +			dmi_match(DMI_BIOS_VENDOR, "ASUSTeK COMPUTER INC.");
> +}
> +
>  static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	int ret = byt_emmc_probe_slot(slot);
> @@ -901,9 +907,13 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  		slot->host->mmc->caps2 |= MMC_CAP2_CQE;
>  
>  	if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
> -		slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
> -		slot->host->mmc_host_ops.hs400_enhanced_strobe =
> -						intel_hs400_enhanced_strobe;
> +		if (jsl_broken_hs400es(slot)) {
> +			slot->host->mmc->caps2 |= MMC_CAP2_HS400;

HS400 capability is already selected by SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400
so this is not needed here.

> +		} else {
> +			slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
> +			slot->host->mmc_host_ops.hs400_enhanced_strobe =
> +							intel_hs400_enhanced_strobe;
> +		}
>  		slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>  	}
>  

