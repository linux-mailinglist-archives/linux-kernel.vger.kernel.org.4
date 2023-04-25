Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1B6EE38B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjDYOBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjDYOB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:01:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D87212C88;
        Tue, 25 Apr 2023 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682431286; x=1713967286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N3z8FGrgtImvZfi1kiCTSF7mBfn712lLb68G3NVBLEw=;
  b=knqX3fxKdxqz2Ljxwb/ndM5yPzTE4Yv7d4hMndTZQuzokkiv1DSfHeoG
   +J6JjkhfGaQV93niLVQ1H/ssr6SX0uteHGu/h+8KQFmPCMDkR5aO6PzmL
   +mfu4nYigKT4/ZOKlWEdAW6saThcONPAAoC1lIxzWQYUaLNUqIE43+8bf
   eJDUNDDYHzI5Y0fsbP8Re9o39cvghJ+XeNeM5w3u5F9rMfiQU0MYFLkge
   FTNXmeFpyDo9cH91wGTU2LegBg3mfYr6oUhlEGCcBCdEjOJYT/QUgsF6m
   xLEAw7S1D/ZhVeefWMTLxFP5TxynK4ZnUKZbkHRgP0KN5BdPSlXxznusP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="433035253"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="433035253"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 07:01:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="762869936"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="762869936"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.232])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 07:01:20 -0700
Message-ID: <ca1277a2-f5f7-f3fd-0a9f-57cdf5ea3464@intel.com>
Date:   Tue, 25 Apr 2023 17:01:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] mmc: queue: ensure error propagation for non-blk
Content-Language: en-US
To:     Christian Loehle <CLoehle@hyperstone.com>,
        ulf hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Avri Altman <avri.altman@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1d8ce997934c4395bb5dd235525bf7a2@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1d8ce997934c4395bb5dd235525bf7a2@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/23 19:22, Christian Loehle wrote:
> Requests to the mmc layer usually come through a block device.
> The exceptions are the RPMB chardev and debugfs, which issue their
> own blk_mq requests through blk_execute_rq and do not query
> the BLK_STS error but the mmc-internal drv_op_result.
> This patch ensures that drv_op_result is set as error whenever
> a BLK_STS error is set.
> 
> The behavior leads to a bug where the request never sees the error,
> e.g. by directly erroring out at mmc_blk_mq_issue_rq if
> mmc_blk_part_switch fails. The ioctl caller of the rpmb chardev then
> can never see the error and thus may assume that their call executed
> successfully when it did not.
> 
> While always checking the blk_execute_rq return value would be
> advised, let's eliminate the error completely by always setting
> drv_op_result in case of a BLK_STS error.
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Fixes tag?

> ---
>  drivers/mmc/core/queue.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index b396e3900717..8240962e28f3 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -334,6 +334,9 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		WRITE_ONCE(mq->busy, false);
>  	}
>  
> +	/* Ensure request error propagates to non-blk callers, too. */
> +	if (!req_to_mmc_queue_req(req)->drv_op_result && ret)
> +		req_to_mmc_queue_req(req)->drv_op_result = ret;

That is not the only path out.

It might be better to initialize drv_op_result to an
error code to start with e.g.

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 00c33edb9fb9..d920c4178389 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -264,6 +264,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 		goto out_put;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	blk_execute_rq(req, false);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	blk_mq_free_request(req);
@@ -651,6 +652,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 	idatas[0] = idata;
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
 	blk_execute_rq(req, false);
@@ -722,6 +724,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 	}
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = idata;
 	req_to_mmc_queue_req(req)->ioc_count = n;
 	blk_execute_rq(req, false);
@@ -2806,6 +2809,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	blk_execute_rq(req, false);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	if (ret >= 0) {
@@ -2844,6 +2848,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 		goto out_free;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
 	blk_execute_rq(req, false);
 	err = req_to_mmc_queue_req(req)->drv_op_result;


>  	return ret;
>  }
>  

