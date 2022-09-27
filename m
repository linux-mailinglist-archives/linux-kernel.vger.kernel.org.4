Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72FD5EC345
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiI0MtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiI0MtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:49:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8549F161CD0;
        Tue, 27 Sep 2022 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664282953; x=1695818953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=twC8J74oF5U4VjbrKchulu7kV1CD0jt7Ue2RhLxOFbM=;
  b=Yp6MfISXoztMGe/zd6lxfp+QrzUH7hIpWsjUeu0VQV4Wf+zrNPy37I3d
   y5ggwXh6QzSfBcWUSp/NxkKze/XF4SMhohDroO86M/z9+KnLNJG98L1L5
   YHA3RfvcN76sQLhMmGT4lqDeqPTuwLVGEhXtfCQJKTorLFJHJcvnOJu8c
   t6YHIFzWAivQxKq3vEHXmizdhmRL5ij5kmGD07ynZFI//Ldm9Z+LTxw2Z
   uWgb7cSJ/X2WES8qOS01H5sWAsvW5FQ2NuJ1y8i1BOS04uZK8M+uehDpl
   egqWFWbl3mQFePmo+eaadJvHidOKrHPgNuEuysxwHcVNnhXkGeFhVb+CB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="300026346"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="300026346"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:49:13 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="683976885"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="683976885"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.200])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:49:06 -0700
Message-ID: <b0343411-4514-37a2-3417-ecdd383046ce@intel.com>
Date:   Tue, 27 Sep 2022 15:49:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 3/3] mmc: sdhci-tegra: Issue CMD and DAT resets
 together
Content-Language: en-US
To:     Prathamesh Shete <pshete@nvidia.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
References: <df68846a-2a09-ef98-6823-d536d99ccb61@intel.com>
 <20220927111314.32229-1-pshete@nvidia.com>
 <20220927111314.32229-3-pshete@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220927111314.32229-3-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/22 14:13, Prathamesh Shete wrote:
> In case of error condition to avoid system crash
> Tegra SDMMC controller requires CMD and DAT resets
> issued together. SDHCI controller FSM goes into
> bad state due to rapid SD card hot-plug event.
> Issuing reset on the CMD FSM before DATA FSM results
> in kernel panic, hence add support to issue CMD and
> DAT resets together.
> This is applicable to Tegra186 and later chips.
> 
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 3 ++-
>  drivers/mmc/host/sdhci.c       | 5 +++++
>  drivers/mmc/host/sdhci.h       | 2 ++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 46f37cc26dbb..61dc5ee0726d 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1536,7 +1536,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
>  	.ops  = &tegra186_sdhci_ops,
>  };
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2b5dda521b0e..8512a69f1aae 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -270,6 +270,11 @@ enum sdhci_reset_reason {
>  
>  static void sdhci_reset_for_reason(struct sdhci_host *host, enum sdhci_reset_reason reason)
>  {
> +	if (host->quirks2 &
> +		SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER) {
> +		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +		return;
> +	}
>  	switch (reason) {
>  	case SDHCI_RESET_FOR_INIT:
>  		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d750c464bd1e..6a5766774b05 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -478,6 +478,8 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> +/* Issue CMD and DATA reset together */
> +#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */

