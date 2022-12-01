Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C822563E6DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLABES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiLABEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:04:15 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD7A8EE6B;
        Wed, 30 Nov 2022 17:04:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VW50kJS_1669856649;
Received: from 30.97.48.64(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VW50kJS_1669856649)
          by smtp.aliyun-inc.com;
          Thu, 01 Dec 2022 09:04:10 +0800
Message-ID: <43ced087-850d-8449-dd78-6628c887f8e6@linux.alibaba.com>
Date:   Thu, 1 Dec 2022 09:04:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V2] mmc: sdhci-sprd: Fix no reset data and command after
 voltage switch
To:     Wenchao Chen <wenchao.chen@unisoc.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        gengcixi@gmail.com
References: <20221130121328.25553-1-wenchao.chen@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221130121328.25553-1-wenchao.chen@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2022 8:13 PM, Wenchao Chen wrote:
> After switching the voltage, no reset data and command will cause
> CMD2 timeout.
> 
> Fixes: 29ca763fc26f ("mmc: sdhci-sprd: Add pin control support for voltage switch")
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> Changelog:
> 
> v1 -> v2:
> There is no need to wait for the state of the pin to stabilize.
> ---
>   drivers/mmc/host/sdhci-sprd.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index b92a408f138d..bec3f9e3cd3f 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -470,7 +470,7 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>   	}
>   
>   	if (IS_ERR(sprd_host->pinctrl))
> -		return 0;
> +		goto reset;
>   
>   	switch (ios->signal_voltage) {
>   	case MMC_SIGNAL_VOLTAGE_180:
> @@ -498,6 +498,8 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>   
>   	/* Wait for 300 ~ 500 us for pin state stable */
>   	usleep_range(300, 500);
> +
> +reset:
>   	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>   
>   	return 0;
