Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676D562F3CC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbiKRLdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241062AbiKRLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:32:44 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB98B136;
        Fri, 18 Nov 2022 03:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668771163; x=1700307163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IduNIG6FBcGoOurwx1vmJhKaICAPzHKI1m96vf7r6KM=;
  b=NwhBZBK5S1aAFy4KDLlahYh76vCnRRpzITOaokAlimtTIxH30dE60DAO
   Jx1qb1S6uSHHsSd3aVPpxRGKVOGTze3PH1p8oxq91ew8WgrP/F9gbgsss
   q9ieNZzHhAgje9mgAYk439nHXyIJimcuJ3awLwvfl1m06vHwpB00KViY+
   NCuOyq8i6EXNxvOwBlgv6GF3VmjoU6HZ69XJMZEpYqJ3779frX6zggZIR
   ZBGTENE87yDsIx3lVW7VqcjlBXFoOXHPh0srIcI/pdG5XCyswxRwRBYbP
   Rht4nN9tWJD9GvfySjOPXWzebHZSCusn40g8+iG/TSoYbLTASAggthACi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="313129155"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="313129155"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 03:32:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="782619092"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="782619092"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.138])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 03:32:39 -0800
Message-ID: <7f887630-cdfe-dda9-c907-278a96b0650c@intel.com>
Date:   Fri, 18 Nov 2022 13:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 2/3] mmc: block: Limit queue size for consecutive requeues
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
References: <3dd3f33e5cc44657bcc2ebedc6d9dd2f@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <3dd3f33e5cc44657bcc2ebedc6d9dd2f@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/22 10:30, Christian Löhle wrote:
> In case mmcblk relies on requeueing to fulfill block layer requests due to
> hardware or driver restricting the max_blk_count to 1 also limit the
> hardware queue size to 1 to get consecutive accesses instead of a
> round-robin on all queued reads.
> 
> See SDHCI_QUIRK_NO_MULTIBLOCK for such a restriction.
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/queue.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index fefaa901b50f..3a20f3933502 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -425,6 +425,8 @@ struct gendisk *mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
>  	if (host->cqe_enabled && !host->hsq_enabled)
>  		mq->tag_set.queue_depth =
>  			min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
> +	else if (host->max_blk_count == 1)

I suggest adding a big comment here about why this is needed.
Perhaps like the information in your cover letter email.

> +		mq->tag_set.queue_depth = 1;
>  	else
>  		mq->tag_set.queue_depth = MMC_QUEUE_DEPTH;
>  	mq->tag_set.numa_node = NUMA_NO_NODE;

