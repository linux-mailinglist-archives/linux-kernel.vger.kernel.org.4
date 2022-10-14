Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8325FE86D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 07:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJNFd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 01:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJNFd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 01:33:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF5196B61;
        Thu, 13 Oct 2022 22:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665725606; x=1697261606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a0J4szhJGrj8a340To74CA+gycZKR9NLsfFvb4kqTHY=;
  b=L4cfDTkg5Zm8Kesd6CA8aZuVkzbXVI+WCoJ29PfDU8hHPV/g7+yzLlYJ
   m0iLMd5XMt6ywv6LnT3A4aO89BbiKuC14qe5u/5qjLWwrKyImmV3UdeY+
   I3owAZkiwmdwcAMehU+Rat90O7sWd0ABWtQGrGD+DfW/888QrSJPg0yn3
   d//sGwUsS7+hyeg0h6h3BBQKjdSSuujhDzyee2hBDqzzJErmbPE6hMe0Z
   8ni0DAcSKIweQceOVno631/ri3DgAUR6/CJByAzg3IPz1MdClC4XfGN1I
   QeGbE3Jcj2j5acHwpf8whsr6SLRCUi8zBS4/LpefRyRXRADpVqnxrBkOv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="285675824"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="285675824"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 22:33:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="769907714"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="769907714"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.43.79])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 22:33:09 -0700
Message-ID: <48644cea-fa02-0250-752a-788e3a2dd303@intel.com>
Date:   Fri, 14 Oct 2022 08:33:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v3] mmc: sdhci-pci-core: Disable ES for ASUS BIOS on
 Jasper Lake
To:     Patrick Thompson <ptf@google.com>,
        Linux MMC Development <linux-mmc@vger.kernel.org>
Cc:     Sangwhan Moon <sxm@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221013210017.3751025-1-ptf@google.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221013210017.3751025-1-ptf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/22 00:00, Patrick Thompson wrote:
> Enhanced Strobe (ES) does not work correctly on the ASUS 1100 series of
> devices. Jasper Lake eMMCs (pci_id 8086:4dc4) are supposed to support
> ES. There are also two system families under the series, thus this is
> being scoped to the ASUS BIOS.
> 
> The failing ES prevents the installer from writing to disk. Falling back
> to HS400 without ES fixes the issue.
> 
> Signed-off-by: Patrick Thompson <ptf@google.com>
> 
> Fixes: 315e3bd7ac19 ("mmc: sdhci-pci: Add support for Intel JSL")

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> 
> Changes in v3:
> * Remove redundant MMC_CAP2_HS400 selection
> 
> Changes in v2:
> * Only disable ES instead of CQE in its entirety.
> * Target Jasper Lake (JSL)
> * Target ASUS BIOS instead of specific system family
> 
>  drivers/mmc/host/sdhci-pci-core.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 169b84761041..34ea1acbb3cc 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -914,6 +914,12 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
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
> @@ -922,9 +928,11 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  		slot->host->mmc->caps2 |= MMC_CAP2_CQE;
>  
>  	if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
> -		slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
> -		slot->host->mmc_host_ops.hs400_enhanced_strobe =
> -						intel_hs400_enhanced_strobe;
> +		if (!jsl_broken_hs400es(slot)) {
> +			slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
> +			slot->host->mmc_host_ops.hs400_enhanced_strobe =
> +							intel_hs400_enhanced_strobe;
> +		}
>  		slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>  	}
>  

