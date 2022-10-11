Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D195FB03E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJKKP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJKKPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:15:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B49A3EA54;
        Tue, 11 Oct 2022 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665483320; x=1697019320;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=scpMZ8OoUYg6AwNLLdYw0RPM+zhh4mPXBovWavPlwA4=;
  b=YHFSVCDwNbObbdjj3l2iUSiikbfAkXGUD6IbyRZ63xDB0hdlLzALvPus
   me05tYwr+T6xfIR1+O//2l8ZPtiisyrTmp5bMZ/ItHRi7Bqt2qKElxV8y
   mqNSvy8rZCPc5RyDbclNMBeBSLaHHU6ShC+PMvpM1FXPfl7gn+YLylePZ
   +O5n4aLkzUrdM3+KCBPvwU8ECdiGBE0e/oMqonK5MBf4QP0MgHaHjYmdQ
   ab+/R/taR/aXCCpot0FJVwSNIQdHJrQQrh3OpWW02nHsfuDmIGPSoBP7q
   yjACs9my5Qsy4ardW34rF2+9C1SpzAHOXzYyYtBCoa22aUhL26vulf0qj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="390772786"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="390772786"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 03:15:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="659486227"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="659486227"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.62.214])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 03:15:18 -0700
Message-ID: <65d813c6-65c0-fb5b-2709-8068e1dc89c1@intel.com>
Date:   Tue, 11 Oct 2022 13:15:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCHv3 1/2] mmc: block: Remove error check of hw_reset on reset
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0d0ef6651ed44fc780e95c8797294708@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <0d0ef6651ed44fc780e95c8797294708@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 17:03, Christian Löhle wrote:
> Before switching back to the right partition in mmc_blk_reset
> there used to be a check if hw_reset was even supported.
> This return value was removed, so there is no reason to check.
> Furthermore ensure part_curr is not falsely set to a valid value
> on reset or partition switch error.
> 
> Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in mmc_hw|sw_reset()")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
> -v3: Ensure invalid part_curr on error
> -v2: Do not attempt to switch partitions if reset failed
> 
>  drivers/mmc/core/block.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce89611a136e..45a44edcc31a 100644
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
> @@ -991,29 +992,27 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
>  			 int type)
>  {
>  	int err;
> +	struct mmc_blk_data *main_md = dev_get_drvdata(&host->card->dev);
> +	int part_err;
>  
>  	if (md->reset_done & type)
>  		return -EEXIST;
>  
>  	md->reset_done |= type;
> +	main_md->part_curr = MMC_BLK_PART_INVALID;

This forces a partition switch even if it is not necessary.

>  	err = mmc_hw_reset(host->card);

This would be better:

	/*
	 * A successful reset will leave the card in the main partition, but
	 * upon failure it might not be, so set it to MMC_BLK_PART_INVALID
	 * in that case.
	 */
	main_md->part_curr = err ? MMC_BLK_PART_INVALID : main_md->part_type;

> +	if (err)
> +		return err;

There was a time when mmc requests would be retried directly without
going back through the block layer.  I don't think that can happen
anymore after a failed reset.  However, if you are going to skip the
partition switch, the commit message needs to explain that you have
checked the code paths and we never retry a request directly after a
failed reset.  Also a comment is needed to say the same.

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
> +	part_err = mmc_blk_part_switch(host->card, md->part_type);
> +	if (part_err) {

Don't really need part_err. i.e. could be 

	if (mmc_blk_part_switch(host->card, md->part_type) {

> +		/*
> +		 * We have failed to get back into the correct
> +		 * partition, so we need to abort the whole request.
> +		 */
> +		return -ENODEV;
>  	}
> -	return err;
> +	return 0;
>  }
>  
>  static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)

