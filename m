Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4890A5B67F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiIMGef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiIMGec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:34:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8058D59;
        Mon, 12 Sep 2022 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663050870; x=1694586870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QYfnTDZixDt2VYVpTtju9Z1vn0nYiKFeDuEb4i2ER9c=;
  b=PRltevjz3e9o/AR9/CP8zzVYi/eNTe3uy7nYK906S9GFKx7RRdAqcZZF
   3TpsSLBcrssUGIePx7Icw72NZUyNSHbzzZh2dkOHQc6JvSuWRoRs+17qW
   VW3EgKA8qdStFZf5HGjQKHECnaufRhHHMhKEEFUSPxRxfPQen6lup8H3d
   mj6TovuCcX3lb9SpKgG2Efmmly6us6wZccRzvHgPPIzI8SjBPbh6XDRV/
   C4bICTgjZ1zRLlLhvqB3sV6+/JHNsQ4OHXB6wso5FHNFggzW75i+KrQmI
   4e3V7Z0x/jowlQNZ5iH5aleHV2tUTLR1rBrUYVRB/9hFAM2L8vnXeLpZF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="384348528"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="384348528"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 23:34:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="678426598"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.98])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 23:34:28 -0700
Message-ID: <925b6e37-051f-927c-350a-cd767d88d72b@intel.com>
Date:   Tue, 13 Sep 2022 09:34:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] mmc: sdhci-pci-core: Disable cqe for ASUS 1100FK family
 devices
Content-Language: en-US
To:     Patrick Thompson <ptf@google.com>,
        Linux MMC development <linux-mmc@vger.kernel.org>
Cc:     Sangwhan Moon <sxm@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220912212847.1337868-1-ptf@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220912212847.1337868-1-ptf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/22 00:28, Patrick Thompson wrote:
> From: ptf <ptf@google.com>
> 
> The CQE implementation for the eMMC in the ASUS 1100FK family of devices
> is broken. This causes installations to fail and thus we are disabling
> CQE for this family of devices.
> 
> Signed-off-by: Patrick Thompson <ptf@google.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Hello,
> 
> I was hoping to get some advice on adapting this patch to target the
> eMMC directly instead of a family of laptops. One idea is to use the
> PCI-id of the controller (in this case [8086:4dc4]). Would that make
> sense? Is there someone with more knowledge on the subject that could
> confirm that the [8086:4dc4] device doesn't have a working CQE?

In these cases the issue is suspected to be BIOS. Best solution is to
disable CQE.

> 
> Thank you,
> Patrick
> 
> 
>  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 622b7de96c7f..3ba0250559e7 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -890,7 +890,8 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
>  {
>  	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
>  	       (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
> -		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
> +		dmi_match(DMI_SYS_VENDOR, "IRBIS") ||
> +		dmi_match(DMI_PRODUCT_FAMILY, "ASUS BR1100FKA"));
>  }
>  
>  static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)

