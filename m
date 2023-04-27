Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862A96F0055
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 07:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbjD0FMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 01:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjD0FMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 01:12:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A64E54;
        Wed, 26 Apr 2023 22:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682572337; x=1714108337;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ex0HqhZvpBa057L+EHY16NvNFOJF0IoHQ781QEDv8VM=;
  b=VE5IP07VXGabcKPMl7Aw7f1vSQaXZIN+eLXSLHI8GcOfgz2cQ6iM1eJK
   7QDGTu817Bl9TX6/mRS0KLJZtpNfOG0Gvu7KHmyOyV+SfeVlOjRqqApIR
   Yox40fq/D8nsBkThcMzDi8/d9EFcMecw/EIgbV1wuUHpgoIGqbwf234i9
   EKvlSwUDE/UOc8NwpoiN5whX2FKACI2FoOjlM2F0h4iDqs34bIIB4Qe9s
   AcJWHxxYGpy3EHIHaVXvKN1EaazQJKvw/A4v9neCn7jlLoXgwJa3LS70n
   xS5bXyTYKNbg+ClmXdI80qgh/P1wyo7OZ5pd+sUOKEauKMx4LhyXd4gaY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="327648348"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="327648348"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 22:12:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="726881959"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="726881959"
Received: from pboudier-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 22:12:14 -0700
Message-ID: <b5ff9e24-af87-b7a6-fb14-d6fbb950e8ea@intel.com>
Date:   Thu, 27 Apr 2023 08:12:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCHv2] mmc: block: ensure error propagation for non-blk
To:     Christian Loehle <CLoehle@hyperstone.com>,
        ulf hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Avri Altman <avri.altman@wdc.com>
References: <59c17ada35664b818b7bd83752119b2d@hyperstone.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <59c17ada35664b818b7bd83752119b2d@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/23 19:59, Christian Loehle wrote:
> Requests to the mmc layer usually come through a block device IO.
> The exceptions are the ioctl interface, RPMB chardev ioctl
> and debugfs, which issue their own blk_mq requests through
> blk_execute_rq and do not query the BLK_STS error but the
> mmcblk-internal drv_op_result. This patch ensures that drv_op_result
> defaults to an error and has to be overwritten by the operation
> to be considered successful.
> 
> The behavior leads to a bug where the request never propagates
> the error, e.g. by directly erroring out at mmc_blk_mq_issue_rq if
> mmc_blk_part_switch fails. The ioctl caller of the rpmb chardev then
> can never see an error (BLK_STS_IOERR, but drv_op_result is unchanged)
> and thus may assume that their call executed successfully when it did not.
> 
> While always checking the blk_execute_rq return value would be
> advised, let's eliminate the error by always setting
> drv_op_result as -EIO to be overwritten on success (or other error)
> 
> Fixes: 614f0388f580 ("mmc: block: move single ioctl() commands to block requests")
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2: Adopted Adrians suggestions to set the error before calling
> 	and rewrote commit message
>  drivers/mmc/core/block.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 672ab90c4b2d..0ff294f07465 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -266,6 +266,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
>  		goto out_put;
>  	}
>  	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
> +	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>  	blk_execute_rq(req, false);
>  	ret = req_to_mmc_queue_req(req)->drv_op_result;
>  	blk_mq_free_request(req);
> @@ -653,6 +654,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
>  	idatas[0] = idata;
>  	req_to_mmc_queue_req(req)->drv_op =
>  		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
> +	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>  	req_to_mmc_queue_req(req)->drv_op_data = idatas;
>  	req_to_mmc_queue_req(req)->ioc_count = 1;
>  	blk_execute_rq(req, false);
> @@ -724,6 +726,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
>  	}
>  	req_to_mmc_queue_req(req)->drv_op =
>  		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
> +	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>  	req_to_mmc_queue_req(req)->drv_op_data = idata;
>  	req_to_mmc_queue_req(req)->ioc_count = n;
>  	blk_execute_rq(req, false);
> @@ -2808,6 +2811,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
> +	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>  	blk_execute_rq(req, false);
>  	ret = req_to_mmc_queue_req(req)->drv_op_result;
>  	if (ret >= 0) {
> @@ -2846,6 +2850,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
>  		goto out_free;
>  	}
>  	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
> +	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>  	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
>  	blk_execute_rq(req, false);
>  	err = req_to_mmc_queue_req(req)->drv_op_result;

