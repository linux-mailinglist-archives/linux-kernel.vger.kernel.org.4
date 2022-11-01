Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8814B61504C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiKAROu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKAROO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:14:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7D16329;
        Tue,  1 Nov 2022 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322831; x=1698858831;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=KTvWMa0hQMXT7OsBaw/UoYuLMTgDttKWDdCMw+Ct78c=;
  b=mX/7zsYQBbjEfyUNJAH/LKUVXdv0C8gsN0SCxnP5RppBKIMSelx9RPiC
   pZE9pwdpw3YaJxk5xxyi0riFjmcRbXwJJJZngQhZ8TD3HD4y50ihVbVY9
   W/DLHG81Pd4zVcGNcuXkj+/lHAz+67HlGH3sTbOgFirFDmGtng57R91GS
   aMCJhmiXJOT721klAnVYjAWBG1dEjYUX4gXyQOhV6KM554WxMu+97ERNr
   qrEDmTqt6gS31X+4BUiKfhOFeDqM5cwzzEfsYk09Am+eGcv4UgdggwPtI
   V6UhQ/Kj3HEgzc9aqXQQ4YDY4n8rdsAilqralkIRKwDYA8fs1NDsrGjo9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310288060"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="310288060"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:13:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="723228787"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="723228787"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:13:04 -0700
Message-ID: <3b36c596-3353-bb2c-b92f-fb475934503a@intel.com>
Date:   Tue, 1 Nov 2022 19:13:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 10/26] mmc: sdhci-uhs2: dump UHS-II registers
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-11-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-11-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 14:06, Victor Shih wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> Dump UHS-II specific registers, if available, in sdhci_dumpregs()
> for informative/debugging use.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  4 ++++
>  drivers/mmc/host/sdhci.c      |  3 +++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index f29d3a4ed43c..08905ed081fb 100644
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
> +	if (!host->mmc || !(host->mmc->flags & MMC_UHS2_SUPPORT))

!host->mmc is not possible

> +		return;
> +
> +	SDHCI_UHS2_DUMP("==================== UHS2 ==================\n");
> +	SDHCI_UHS2_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
> +			sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
> +			sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
> +	SDHCI_UHS2_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
> +			sdhci_readw(host, SDHCI_UHS2_COMMAND),
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
> +			sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS),
> +			sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN));
> +	SDHCI_UHS2_DUMP("ErrSigEn:  0x%08x\n",
> +			sdhci_readl(host, SDHCI_UHS2_ERR_INT_SIG_EN));
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>  
>  /*****************************************************************************\
>   *                                                                           *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 5610affebdf3..afdb05d6056b 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -207,4 +207,8 @@
>  #define SDHCI_UHS2_EMBED_CTRL	0xE6
>  #define SDHCI_UHS2_VENDOR	0xE8
>  
> +struct sdhci_host;
> +
> +void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> +
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fef03de85b99..2cdd183c8ada 100644
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

