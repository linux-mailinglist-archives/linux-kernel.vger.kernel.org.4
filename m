Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B1663CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjAJJbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjAJJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:31:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE54B6471
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:30:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4C452F4;
        Tue, 10 Jan 2023 01:31:40 -0800 (PST)
Received: from [10.57.37.155] (unknown [10.57.37.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A66583F587;
        Tue, 10 Jan 2023 01:30:57 -0800 (PST)
Message-ID: <a7edcb0a-5f12-f6ab-8897-479fefe54c2f@arm.com>
Date:   Tue, 10 Jan 2023 09:30:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] coresight: tmc-etr: Don't enable ETR when it's not ready
Content-Language: en-US
To:     Yabin Cui <yabinc@google.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
References: <20230109234312.2870846-1-yabinc@google.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230109234312.2870846-1-yabinc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/01/2023 23:43, Yabin Cui wrote:
> Otherwise, it may cause error in AXI bus and result in a kernel panic.

Hi Yabin,

Thanks for the fix. Do you have a reproducer for this or some more info?
For example is it a regression or has it always been there? And on which
platform.

Thanks
James

> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>  .../hwtracing/coresight/coresight-tmc-core.c   |  4 +++-
>  .../hwtracing/coresight/coresight-tmc-etr.c    | 18 +++++++++++++++---
>  drivers/hwtracing/coresight/coresight-tmc.h    |  2 +-
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 07abf28ad725..c106d142e632 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -31,7 +31,7 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
>  DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
>  DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
>  
> -void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
> +int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>  {
>  	struct coresight_device *csdev = drvdata->csdev;
>  	struct csdev_access *csa = &csdev->access;
> @@ -40,7 +40,9 @@ void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>  	if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
>  		dev_err(&csdev->dev,
>  			"timeout while waiting for TMC to be Ready\n");
> +		return -EBUSY;
>  	}
> +	return 0;
>  }
>  
>  void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 867ad8bb9b0c..2da99dd41ed6 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -983,15 +983,21 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
>  	etr_buf->ops->sync(etr_buf, rrp, rwp);
>  }
>  
> -static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
> +static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  {
>  	u32 axictl, sts;
>  	struct etr_buf *etr_buf = drvdata->etr_buf;
> +	int rc = 0;
>  
>  	CS_UNLOCK(drvdata->base);
>  
>  	/* Wait for TMCSReady bit to be set */
> -	tmc_wait_for_tmcready(drvdata);
> +	rc = tmc_wait_for_tmcready(drvdata);
> +	if (rc) {
> +		dev_err(&drvdata->csdev->dev, "not ready ETR isn't enabled\n");
> +		CS_LOCK(drvdata->base);
> +		return rc;
> +	}
>  
>  	writel_relaxed(etr_buf->size / 4, drvdata->base + TMC_RSZ);
>  	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
> @@ -1032,6 +1038,7 @@ static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  	tmc_enable_hw(drvdata);
>  
>  	CS_LOCK(drvdata->base);
> +	return rc;
>  }
>  
>  static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
> @@ -1060,7 +1067,12 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
>  	rc = coresight_claim_device(drvdata->csdev);
>  	if (!rc) {
>  		drvdata->etr_buf = etr_buf;
> -		__tmc_etr_enable_hw(drvdata);
> +		rc = __tmc_etr_enable_hw(drvdata);
> +		if (rc) {
> +			drvdata->etr_buf = NULL;
> +			coresight_disclaim_device(drvdata->csdev);
> +			tmc_etr_disable_catu(drvdata);
> +		}
>  	}
>  
>  	return rc;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 66959557cf39..01c0382a29c0 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -255,7 +255,7 @@ struct tmc_sg_table {
>  };
>  
>  /* Generic functions */
> -void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
> +int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
>  void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
>  void tmc_enable_hw(struct tmc_drvdata *drvdata);
>  void tmc_disable_hw(struct tmc_drvdata *drvdata);
