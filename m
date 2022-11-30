Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D4D63D2A0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiK3J6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiK3J6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:58:40 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF02FA71;
        Wed, 30 Nov 2022 01:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669802318; x=1701338318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oJ6UQrtMI2/khBTWbq8LskCJDtBIT/P3kfygL3vIM0I=;
  b=Bd1rFdsgYXk92soz4e3cRiPVhdP0Gv6T6C4A49fT9nEPsZQ/JL3RluAr
   pXfLMLqN8yw2jylSMDVq/AFEr5GCNgOgU+Y9XOjW+lqeBUGWRr8J7XhyN
   AtmaQe7w2TgB5MAvsB3Vl6c3jljPeb7H+chPugEsSuMnMERjSj9o98W2y
   wmlxxLeI6bZhqjqS6iDy4hOfGT5xy3PJAETaTRnvSSvWAjU8zzP42Iaky
   HBGpcYuWmR8rE+k4aASxxv8N98CpDs8FfcdnyzDS6QAu7+f5g3B5mhod8
   dIveeRL2k592fnPNKS9UhTEUKpGBkjIM1wPJolV4DsDtfgtd7x6yT4JQa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="316507806"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="316507806"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 01:58:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="707587722"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="707587722"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.53.75])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 01:58:35 -0800
Message-ID: <63b4b1e7-47c8-5ba3-d216-275ad7b7f867@intel.com>
Date:   Wed, 30 Nov 2022 11:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix no reset data and command after
 voltage switch
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen@unisoc.com>, ulf.hansson@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        gengcixi@gmail.com
References: <20221130080224.12831-1-wenchao.chen@unisoc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221130080224.12831-1-wenchao.chen@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/22 10:02, Wenchao Chen wrote:
> After switching the voltage, no reset data and command will cause
> CMD2 timeout.
> 
> Fixes: 29ca763fc26f ("mmc: sdhci-sprd: Add pin control support for voltage switch")
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-sprd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index b92a408f138d..464508be8ec8 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -470,7 +470,7 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  	}
>  
>  	if (IS_ERR(sprd_host->pinctrl))
> -		return 0;
> +		goto reset;
>  
>  	switch (ios->signal_voltage) {
>  	case MMC_SIGNAL_VOLTAGE_180:
> @@ -496,6 +496,7 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  		break;
>  	}
>  
> +reset:
>  	/* Wait for 300 ~ 500 us for pin state stable */
>  	usleep_range(300, 500);
>  	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);

