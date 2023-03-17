Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2B06BE788
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCQLEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCQLEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:04:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 263C9591E1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:04:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22B5B1480;
        Fri, 17 Mar 2023 04:05:34 -0700 (PDT)
Received: from [10.57.53.217] (unknown [10.57.53.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 184953F885;
        Fri, 17 Mar 2023 04:04:48 -0700 (PDT)
Message-ID: <ca4dba90-8739-ad73-d3d7-681cf2326643@arm.com>
Date:   Fri, 17 Mar 2023 11:04:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 8/9] coresight: Enable and disable helper devices
 adjacent to the path
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310160610.742382-1-james.clark@arm.com>
 <20230310160610.742382-9-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230310160610.742382-9-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 16:06, James Clark wrote:
> Currently CATU is the only helper device, and its enable and disable
> calls are hard coded. To allow more helper devices to be added in a
> generic way, remove these hard coded calls and just enable and disable
> all helper devices.
> 
> This has to apply to helpers adjacent to the path, because they will
> never be in the path. CATU was already discovered in this way, so
> there is no change there.
> 
> One change that is needed is for CATU to call back into ETR to allocate
> the buffer. Because the enable call was previously hard coded, it was
> done at a point where the buffer was already allocated, but this is no
> longer the case.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-catu.c  | 34 ++++++++--
>   drivers/hwtracing/coresight/coresight-core.c  | 68 ++++++++++++++++++-
>   .../hwtracing/coresight/coresight-tmc-etr.c   | 28 --------
>   include/linux/coresight.h                     |  3 +-
>   4 files changed, 99 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index bc90a03f478f..24a08a2b96b1 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -395,13 +395,32 @@ static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
>   	return coresight_timeout(csa, CATU_STATUS, CATU_STATUS_READY, 1);
>   }
>   
> -static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
> +static struct coresight_device *
> +catu_get_etr_device(struct coresight_device *csdev)
> +{
> +	int i;
> +	struct coresight_device *tmp;
> +
> +	for (i = 0; i < csdev->pdata->nr_inconns; i++) {
> +		tmp = csdev->pdata->in_conns[i].remote_dev;
> +		if (tmp && tmp->type == CORESIGHT_DEV_TYPE_SINK &&
> +		    tmp->subtype.sink_subtype ==
> +			    CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM)
> +			return tmp;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
> +			  void *data)
>   {
>   	int rc;
>   	u32 control, mode;
> -	struct etr_buf *etr_buf = data;
> +	struct etr_buf *etr_buf = NULL;
>   	struct device *dev = &drvdata->csdev->dev;
>   	struct coresight_device *csdev = drvdata->csdev;
> +	struct coresight_device *etrdev;
>   
>   	if (catu_wait_for_ready(drvdata))
>   		dev_warn(dev, "Timeout while waiting for READY\n");
> @@ -416,6 +435,12 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
>   	if (rc)
>   		return rc;
>   
> +	etrdev = catu_get_etr_device(csdev);
> +	if (etrdev) {
> +		etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, data);
> +		if (IS_ERR(etr_buf))
> +			return PTR_ERR(etr_buf);
> +	}

WARN_ON(!etrdev) ? We are not supposed to reach in the first place and 
return.


>   	control |= BIT(CATU_CONTROL_ENABLE);
>   
>   	if (etr_buf && etr_buf->mode == ETR_MODE_CATU) {
> @@ -441,13 +466,14 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
>   	return 0;
>   }
>   
> -static int catu_enable(struct coresight_device *csdev, void *data)
> +static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
> +		       void *data)
>   {
>   	int rc;
>   	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
>   
>   	CS_UNLOCK(catu_drvdata->base);
> -	rc = catu_enable_hw(catu_drvdata, data);
> +	rc = catu_enable_hw(catu_drvdata, mode, data);
>   	CS_LOCK(catu_drvdata->base);
>   	return rc;
>   }
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index a8ba7493c09a..3e6ccd9e8d4e 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -441,6 +441,34 @@ static int coresight_enable_source(struct coresight_device *csdev,
>   	return 0;
>   }
>   
> +static int coresight_enable_helper(struct coresight_device *csdev,
> +				   enum cs_mode mode, void *sink_data)

minor nit: s/sink_data/data/ ? Though it is always either sink_data
(perf mode) or NULL (sysfs mode), for the core code it is simply an
opaque data.

Rest looks fine to me.

Suzuki


