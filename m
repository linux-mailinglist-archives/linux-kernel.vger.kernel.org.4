Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1746E6191C5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiKDHWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiKDHWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:22:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03573DF51;
        Fri,  4 Nov 2022 00:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667546545; x=1699082545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=apiXD7hdj1Ppbt8ug3hT/IudBcz+QroU0Vmf8vx1QDI=;
  b=jFgLmMBj3Y21mBUW76/FaHcd9sIhwXCfIXZmyAUB6KJhrrcDuueqhxdT
   pQIMoGlKD09UTdyUX10wrZv/2XrmFUdL4W5JF9wJrMraO4Lshles4wGQw
   cAQCut0S+Ryo6wCUQnPEcLrezJNSf44QoTLoyy0n4lp30R63yg+nTvD+k
   +WYxN65ZbieHOdGmKGNDYBVpBgPTHKqnSNKOrNj++ULSZnIgL74GvIcHt
   JOfQNQTK5Mo/TQrscdqjOdY5bOvsDC/ppJTZypcmxm1JyjmKqW2sZxFnz
   cVcY4nuI6nfX4geACjRLFzUoPTSeHFqOmlMoXbzeLef2FzAAjmZSD2mHJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="307524492"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="307524492"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 00:22:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="698548081"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="698548081"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.118])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 00:22:22 -0700
Message-ID: <5c7218e3-6e0e-1643-23d6-170066aadb8c@intel.com>
Date:   Fri, 4 Nov 2022 09:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH V2 1/1] mmc:sdhci:Fix the SD tuning issue that the
 SDHCI_TRANSFER_MODE is cleared incorrectly
Content-Language: en-US
To:     Charl Liu <charl.liu@bayhubtech.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        thomas.hu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com
References: <20221104064221.812-1-charl.liu@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221104064221.812-1-charl.liu@bayhubtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 08:42, Charl Liu wrote:
> When cmd->opcode == MMC_SEND_TUNING_BLOCK, the SDHCI_TRANSFER_MODE
> should also be kept
> 
> Signed-off-by: Charl Liu <charl.liu@bayhubtech.com>
> ---
> change in V1:
> Keeping the SDHCI_TRANSFER_MODE when cmd->opcode == MMC_END_TUNING_BLOCK
> 
> change in V2:
> add the mmc_op_tuning interface to judge if the opcode is tuning CMD
> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  include/linux/mmc/mmc.h  | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 22152029e14c..9388628215ca 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1430,7 +1430,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  		if (host->quirks2 &
>  			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
>  			/* must not clear SDHCI_TRANSFER_MODE when tuning */
> -			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
> +			if (!mmc_op_tuning(cmd->opcode))
>  				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
>  		} else {
>  		/* clear Auto CMD settings for no data CMDs */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index d9a65c6a8816..d809bdfcc59b 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -99,6 +99,12 @@ static inline bool mmc_op_multi(u32 opcode)
>  	       opcode == MMC_READ_MULTIPLE_BLOCK;
>  }
>  
> +static inline bool mmc_op_tuning(u32 opcode)
> +{
> +	return opcode == MMC_SEND_TUNING_BLOCK ||
> +	       opcode == MMC_SEND_TUNING_BLOCK_HS200;
> +}
> +

Patches for mmc should be based on Ulf's next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/log/?h=next

which already has mmc_op_tuning()

>  /*
>   * MMC_SWITCH argument format:
>   *

