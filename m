Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA61A65F5B9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjAEV0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbjAEV0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:26:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE65D631BD;
        Thu,  5 Jan 2023 13:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672954006; x=1704490006;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=CmBCipq+mfB+nIioFXy+Hpn00ygvgV2X/YLpmtXYmoA=;
  b=T2+jtiLWiu3hFdExlI0EjvflveneqFvFYvmnyuYnvXVGSLBoFGtfRvII
   daPcjbLBIa8A7zdmQNhrEncaTKEL2xLa+1wTyTTMBQiz/NZ5KegRaD9g2
   Zu6+rZYmUUGEaeXNjj4eggNgA/y56EC+wYZo2XYnLsKv6liqcEOSlTHUu
   0Rfkad4hB0M5Spz1JO52ONf3Vvbpp/tVvrAimAWoJB65o5GrSyxU2njNP
   FALrV+9k3gnvZx2Ys59PyUO8hy5rWeBLydiLK/fsK1/A72Ol5eeuY/Za6
   0v4EdAEo8Ho8fjrs3TQhboYxnUww6vH4lnwf+Dt9TsT4EGE2EHrJn56QV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="320034917"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="320034917"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:26:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="657673322"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="657673322"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.42.126])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:26:42 -0800
Message-ID: <25ad3862-0390-73e7-7abf-03298fb70a73@intel.com>
Date:   Thu, 5 Jan 2023 23:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 09/24] mmc: sdhci-uhs2: dump UHS-II registers
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-10-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221213090047.3805-10-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/22 11:00, Victor Shih wrote:
> Dump UHS-II specific registers, if available, in sdhci_dumpregs()
> for informative/debugging use.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  4 ++++
>  drivers/mmc/host/sdhci.c      |  3 +++
>  drivers/mmc/host/sdhci.h      |  1 +
>  4 files changed, 38 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 8e15bd0dadee..7ea15f06fa99 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -18,6 +18,36 @@
>  #define DRIVER_NAME "sdhci_uhs2"
>  #define DBG(f, x...) \
>  	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
> +#define SDHCI_UHS2_DUMP(f, x...) \
> +	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
> +
> +void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> +{
> +	if (!(host->mmc->flags & MMC_UHS2_SUPPORT))

Could make use of sdhci_uhs2_mode()

> +		return;
> +
> +	SDHCI_UHS2_DUMP("==================== UHS2 ==================\n");
> +	SDHCI_UHS2_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
> +			sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
> +			sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
> +	SDHCI_UHS2_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
> +			sdhci_readw(host, SDHCI_UHS2_CMD),
> +			sdhci_readw(host, SDHCI_UHS2_TRANS_MODE));
> +	SDHCI_UHS2_DUMP("Int Stat:  0x%08x | Dev Sel : 0x%08x\n",
> +			sdhci_readw(host, SDHCI_UHS2_DEV_INT_STATUS),
> +			sdhci_readb(host, SDHCI_UHS2_DEV_SELECT));
> +	SDHCI_UHS2_DUMP("Dev Int Code:  0x%08x\n",
> +			sdhci_readb(host, SDHCI_UHS2_DEV_INT_CODE));
> +	SDHCI_UHS2_DUMP("Reset:     0x%08x | Timer:    0x%08x\n",
> +			sdhci_readw(host, SDHCI_UHS2_SW_RESET),
> +			sdhci_readw(host, SDHCI_UHS2_TIMER_CTRL));
> +	SDHCI_UHS2_DUMP("ErrInt:    0x%08x | ErrIntEn: 0x%08x\n",
> +			sdhci_readl(host, SDHCI_UHS2_INT_STATUS),
> +			sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE));
> +	SDHCI_UHS2_DUMP("ErrSigEn:  0x%08x\n",
> +			sdhci_readl(host, SDHCI_UHS2_INT_SIGNAL_ENABLE));
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>  
>  /*****************************************************************************\
>   *                                                                           *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 29cd91f12b9e..a1fcd7899829 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -172,4 +172,8 @@
>  #define SDHCI_UHS2_EMBED_CTRL_PTR 0xE6
>  #define SDHCI_UHS2_VENDOR_PTR     0xE8
>  
> +struct sdhci_host;
> +
> +void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> +
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f3af1bd0f7b9..9b66b9a32c72 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -110,6 +110,9 @@ void sdhci_dumpregs(struct sdhci_host *host)
>  		}
>  	}
>  
> +	if (host->ops->dump_uhs2_regs)
> +		host->ops->dump_uhs2_regs(host);
> +
>  	if (host->ops->dump_vendor_regs)
>  		host->ops->dump_vendor_regs(host);
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 40125ecd4e3f..f41c19c76994 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -723,6 +723,7 @@ struct sdhci_ops {
>  	void	(*request_done)(struct sdhci_host *host,
>  				struct mmc_request *mrq);
>  	void    (*dump_vendor_regs)(struct sdhci_host *host);
> +	void	(*dump_uhs2_regs)(struct sdhci_host *host);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS

