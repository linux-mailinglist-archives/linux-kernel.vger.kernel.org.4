Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF55FD7DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 12:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJMKic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 06:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJMKi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 06:38:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E88B4896;
        Thu, 13 Oct 2022 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665657507; x=1697193507;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=IzNnOVImM+1fHY13HeqIWVw+VzRpQTJn1OFafJ899zM=;
  b=LIubZcBqCqlR6jzWcHvrJwgja+310C5IWwjvQeQxluaHuSITFDx56mYL
   VferrgZ2k4zq/6Fu5ncYD4sy+4yxBlaO14XgrwLJkQUN9mpQmHCMpfj4K
   CO9v6e2Q+nSIFIgjvQMzfUJnXgfV0cg3Vin+nbS/IOWTWj5g3vkYOH2DO
   rCdDxxIBLIGYFvoprupcO9TUg5nP1JYXNMAZlvQRXMns7LA4UyCDFuYpo
   37vdL1LB8TMDRv8HuTTWg5a/AZNbFV5T4JCw0xFsjJlM6Cd+g0SBnvUDU
   thA764+xqW/pav+nBxenkAurubsB5Y0iaddRrnuC2qfR7DGxyxi4tP7Gm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="369211924"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="369211924"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 03:38:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="578181130"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="578181130"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.151])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 03:37:59 -0700
Message-ID: <95b225c0-13a0-46dc-281f-1ff8493cc116@intel.com>
Date:   Thu, 13 Oct 2022 13:37:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCHv4 1/2] mmc: block: Remove error check of hw_reset on reset
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f7757a12fb204b8584dacc04e67fdd1c@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <f7757a12fb204b8584dacc04e67fdd1c@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/22 21:37, Christian Löhle wrote:
> Before switching back to the right partition in mmc_blk_reset there used
> to be a check if hw_reset was even supported. This return value
> was removed, so there is no reason to check. Furthermore ensure
> part_curr is not falsely set to a valid value on reset or
> partition switch error.
> 
> As part of this change the code paths of mmc_blk_reset calls were checked
> to ensure no commands are issued after a failed mmc_blk_reset directly
> without going through the block layer.
> 
> Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in mmc_hw|sw_reset()")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

One minor comment, otherwise:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> -v4: Only partition switch if necessary and fix one mmc_blk_reset call
> -v3: Ensure invalid part_curr on error
> -v2: Do not attempt to switch partitions if reset failed
> 
>  drivers/mmc/core/block.c | 42 ++++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce89611a136e..2619cc47b97c 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -134,6 +134,7 @@ struct mmc_blk_data {
>  	 * track of the current selected device partition.
>  	 */
>  	unsigned int	part_curr;
> +#define MMC_BLK_PART_INVALID	UINT_MAX	/* Unknown partition active */
>  	int	area_type;
>  
>  	/* debugfs files (only in main mmc_blk_data) */
> @@ -987,33 +988,39 @@ static unsigned int mmc_blk_data_timeout_ms(struct mmc_host *host,
>  	return ms;
>  }
>  
> +/*
> + * Attempts to reset the card and get back to the requested partition.
> + * Therefore any error here must result in cancelling the block layer
> + * request, it must not be reattempted without going through the mmc_blk
> + * partition sanity checks.
> + */
>  static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
>  			 int type)
>  {
>  	int err;
> +	struct mmc_blk_data *main_md = dev_get_drvdata(&host->card->dev);
>  
>  	if (md->reset_done & type)
>  		return -EEXIST;
>  
>  	md->reset_done |= type;
>  	err = mmc_hw_reset(host->card);
> +	/*
> +	 * A successful reset will leave the card in the main partition, but
> +	 * upon failure it might not be, so set it to MMC_BLK_PART_INVALID
> +	 * in that case.
> +	 */
> +	main_md->part_curr = err ? MMC_BLK_PART_INVALID : main_md->part_type;
> +	if (err)
> +		return err;
>  	/* Ensure we switch back to the correct partition */
> -	if (err) {
> -		struct mmc_blk_data *main_md =
> -			dev_get_drvdata(&host->card->dev);
> -		int part_err;
> -
> -		main_md->part_curr = main_md->part_type;
> -		part_err = mmc_blk_part_switch(host->card, md->part_type);
> -		if (part_err) {
> -			/*
> -			 * We have failed to get back into the correct
> -			 * partition, so we need to abort the whole request.
> -			 */
> -			return -ENODEV;
> -		}
> -	}
> -	return err;
> +	if (mmc_blk_part_switch(host->card, md->part_type))
> +		/*
> +		 * We have failed to get back into the correct
> +		 * partition, so we need to abort the whole request.
> +		 */
> +		return -ENODEV;
> +	return 0;
>  }
>  
>  static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
> @@ -1868,7 +1875,8 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
>  
>  	/* Reset before last retry */
>  	if (mqrq->retries + 1 == MMC_MAX_RETRIES)
> -		mmc_blk_reset(md, card->host, type);
> +		if (mmc_blk_reset(md, card->host, type))

Kernel style is to avoid nested "if" statements, so it should be like this:

  	if (mqrq->retries + 1 == MMC_MAX_RETRIES &&
	    mmc_blk_reset(md, card->host, type)
		return;

> +			return;
>  
>  	/* Command errors fail fast, so use all MMC_MAX_RETRIES */
>  	if (brq->sbc.error || brq->cmd.error)

