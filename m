Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CFF5B8ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiINSVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiINSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:21:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5CB8034F;
        Wed, 14 Sep 2022 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663179675; x=1694715675;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PxGMmhd74kJ3cxcKvpu6UJtjQtuixYNhwOFyvgZmibM=;
  b=XTuN4aPnWbcnzlKXMNssn2YQxyH6TNkRAoDBv0oYc7mVC1vS8aOG7mQ1
   kvqueF4VFkXBiNsjxqvUQlTDJX/k/fOiCOamrNvhfrq1XxH5MfhujQt79
   A2+4NWh3ZVaWJGHdBW/X/xpZ1cDD2m0cbbnhQQFTG+iGI3ywDEAxu06Xi
   DM0C4OlY+tV/nE6F+h+y/SmuinkFLjsvx/F/fjXdpzobyGJOqxuQCFJFG
   SXz6K3AzzRKhGaxp34vewBggNgj63v8PyNY28bdt0Pq+tQrT706d4mEtv
   cXAOBnI03c71tnXUfaVLsmKHmkv2juhN1Rj9XzJNFGGv2LRYgynONnkLF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278235051"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278235051"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 11:21:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="679169061"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 11:21:12 -0700
Message-ID: <05686061-e17e-fcd6-e570-a9ae159cb51c@intel.com>
Date:   Wed, 14 Sep 2022 21:21:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] mmc: sdhci-tegra: Issue CMD and DAT resets
 together
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Prathamesh Shete <pshete@nvidia.com>
Cc:     ulf.hansson@linaro.org, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
References: <20220914095628.26093-1-pshete@nvidia.com>
 <20220914095628.26093-3-pshete@nvidia.com> <YyHHIPbXnLiPe/vn@orome>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YyHHIPbXnLiPe/vn@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/22 15:20, Thierry Reding wrote:
> On Wed, Sep 14, 2022 at 03:26:27PM +0530, Prathamesh Shete wrote:
>> In case of error condition to avoid system crash
>> Tegra SDMMC controller requires CMD and DAT resets
>> issued together.
> 
> It might be worth specifying exactly what "system crash" means. Does
> this always happen (i.e. do we have a problem right now?) or are there
> specific circumstances that cause the crash.
> 
>> This is applicable to Tegra186 and later chips.
>>
>> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
>> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
>> ---
>>  drivers/mmc/host/sdhci-tegra.c |  3 ++-
>>  drivers/mmc/host/sdhci.c       | 11 ++++++++---
>>  drivers/mmc/host/sdhci.h       |  2 ++
>>  3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>> index b66b0cc51497..7d16dc41fe91 100644
>> --- a/drivers/mmc/host/sdhci-tegra.c
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -1530,7 +1530,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>> +		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
>>  	.ops  = &tegra186_sdhci_ops,
>>  };
>>  
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 7689ffec5ad1..289fa8ae4866 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3063,9 +3063,14 @@ static bool sdhci_request_done(struct sdhci_host *host)
>>  		 * Spec says we should do both at the same time, but Ricoh
>>  		 * controllers do not like that.
>>  		 */
> 
> The comment above seems to indicate that the current behavior (i.e.
> splitting the CMD and DATA resets) is actually the quirk, so I wonder if
> this perhaps should be reversed? I suppose it could be difficult to
> track down the exact controllers that need the separate resets, but this
> might be worth doing. It's possible that other controllers might run
> into the same issue that we are if they work strictly to the spec.
> 
> Adrian, any ideas on how much of this is just cargo-culted? Do we play
> it safe and do the "double workaround" or do we want to attempt to
> rectify this by adding a Ricoh-specific quirk?

It is a good question, but it has been that way for a very long time,
and the spec tends to document them separately anyway, so it doesn't
seem there is much reason to change.

> 
> Thierry
> 
>> -		sdhci_do_reset(host, SDHCI_RESET_CMD);
>> -		sdhci_do_reset(host, SDHCI_RESET_DATA);
>> -
>> +		if (host->quirks2 &
>> +			SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER) {
>> +			sdhci_do_reset(host, SDHCI_RESET_CMD |
>> +					SDHCI_RESET_DATA);
>> +		} else {
>> +			sdhci_do_reset(host, SDHCI_RESET_CMD);
>> +			sdhci_do_reset(host, SDHCI_RESET_DATA);
>> +		}
>>  		host->pending_reset = false;
>>  	}
>>  
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 95a08f09df30..8045308f7859 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -480,6 +480,8 @@ struct sdhci_host {
>>   * block count.
>>   */
>>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
>> +/* Issue CMD and DATA reset together */
>> +#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER      (1<<19)
>>  
>>  	int irq;		/* Device IRQ */
>>  	void __iomem *ioaddr;	/* Mapped address */
>> -- 
>> 2.17.1
>>

