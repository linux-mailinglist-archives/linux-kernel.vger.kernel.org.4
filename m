Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E3F62F3D4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbiKRLhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241560AbiKRLg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:36:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB04C976CC;
        Fri, 18 Nov 2022 03:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668771304; x=1700307304;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LweqJ1WTUgBMaklbw2ffFkJFga+y35ZB8OdwOq82kjo=;
  b=SBF0nm5g/QZ4mya0A2nR1skuwBPncD/fcLS9/oWR8jgBs2IcmtCH4gbt
   zo61J4Uvxe0TWOhpzov4pSydH6Kg9kyIKtH52tHji7CigcZoT+mw39Bki
   Yykc0HdVUGmBJooems4tIiR45N+orKWmBNrOywPkm7GJdjFN6fsDt8NiG
   q/ELbWihz4QBc2nNxa6XAOg0wmO90iwqEH5BuACu+i8ewuF4IoNJ08x2V
   9yn7BURaE3tU8/EDfJmfbNim703NP3SlhNXE8pYzhHT8hQFGiE4lWwly9
   duur29QmcEGJAfdytO93hlhcJGV+HDxvtqsb5lcXX3JrEj63sJo7cl/0n
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="292817952"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="292817952"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 03:34:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="782619333"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="782619333"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.138])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 03:34:29 -0800
Message-ID: <cebfe83b-138a-4bca-c37a-bcb5b25f580d@intel.com>
Date:   Fri, 18 Nov 2022 13:34:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 3/3] mmc: block: Requeue on block size restrictions
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
References: <f3b05a9103ba4c46ae78a96f8cdc700d@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <f3b05a9103ba4c46ae78a96f8cdc700d@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/22 10:30, Christian Löhle wrote:
> The block layer does not conform to all our sector count restrictions, so
> requeue in case we had to modify the number of blocks sent instead of
> going through the normal completion.
> 
> Note that the normal completion used before does not lead to a bug,
> this change is just the nicer thing to do.

Can you elaborate on why it is "nicer"?

> An example of such a restriction is max_blk_count = 1 and 512 blksz,
> but the block layer continues to use requests of size PAGE_SIZE.
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 54cd009aee50..c434d3964880 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1519,8 +1519,10 @@ static void mmc_blk_cqe_req_done(struct mmc_request *mrq)
>  	/*
>  	 * Block layer timeouts race with completions which means the normal
>  	 * completion path cannot be used during recovery.
> +	 * Also do not use it if we had to modify the block count to satisfy
> +	 * host controller needs.
>  	 */
> -	if (mq->in_recovery)
> +	if (mq->in_recovery || mrq->data->blocks != blk_rq_sectors(req))
>  		mmc_blk_cqe_complete_rq(mq, req);
>  	else if (likely(!blk_should_fake_timeout(req->q)))
>  		blk_mq_complete_request(req);
> @@ -2051,8 +2053,10 @@ static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
>  	/*
>  	 * Block layer timeouts race with completions which means the normal
>  	 * completion path cannot be used during recovery.
> +	 * Also do not use it if we had to modify the block count to satisfy
> +	 * host controller needs.
>  	 */
> -	if (mq->in_recovery)
> +	if (mq->in_recovery || mrq->data->blocks != blk_rq_sectors(req))
>  		mmc_blk_cqe_complete_rq(mq, req);
>  	else if (likely(!blk_should_fake_timeout(req->q)))
>  		blk_mq_complete_request(req);
> @@ -2115,8 +2119,10 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
>  	/*
>  	 * Block layer timeouts race with completions which means the normal
>  	 * completion path cannot be used during recovery.
> +	 * Also do not use it if we had to modify the block count to satisfy
> +	 * host controller needs.
>  	 */
> -	if (mq->in_recovery) {
> +	if (mq->in_recovery || mrq->data->blocks != blk_rq_sectors(req)) {
>  		mmc_blk_mq_complete_rq(mq, req);
>  	} else if (likely(!blk_should_fake_timeout(req->q))) {
>  		if (can_sleep)

