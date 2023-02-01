Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C193C6865B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjBAMFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjBAMFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:05:43 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D263D38B78;
        Wed,  1 Feb 2023 04:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675253142; x=1706789142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IUmTbh4hUQOuFl5FodoOUryg4j8Mjb0onvpio+YorNs=;
  b=EPOSPfW6OF0iyuJmRLWYsV3KmbQSEv82AGLxeFdsZjybiWRhu6OumrZM
   J7eEcNX3j2NV6y+AZh74cbajXYgISYPkP/9ZEylgJrsmifryhMdndeHTp
   C/G6I/uI8/D6ktWpmpqfGaeL1SDEmHfjsE8aECjM37dX324oHdwsKNn85
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Feb 2023 04:05:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 04:05:41 -0800
Received: from [10.216.32.242] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 04:05:38 -0800
Message-ID: <22bcf613-5c0f-3043-f8ad-41bf45c5dc07@quicinc.com>
Date:   Wed, 1 Feb 2023 17:35:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] remoteproc: sysfs/debugfs: fix race while updating
 recovery flag
Content-Language: en-US
To:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230201054609.14575-1-quic_satyap@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230201054609.14575-1-quic_satyap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/2023 11:16 AM, Satya Durga Srinivasu Prabhala wrote:
> When multiple clients try to update the recovery flag, it is
> possible that, race condition would lead to undesired results
> as updates to recovery flag isn't protected by any mechanism
> today. To avoid such issues, take remoteproc mutex lock before
> updating recovery flag and release the lock once done.
> 
> Signed-off-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>

LGTM.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> ---
> v1 -> v2:
> - addressed comments from Mukesh Ojha
>    1. take & release lock only while updating recovery flag
>    2. update debugfs
> 
>   drivers/remoteproc/remoteproc_debugfs.c | 4 ++++
>   drivers/remoteproc/remoteproc_sysfs.c   | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index b86c1d09c70c..2c44d375024e 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -226,10 +226,14 @@ rproc_recovery_write(struct file *filp, const char __user *user_buf,
>   
>   	if (!strncmp(buf, "enabled", count)) {
>   		/* change the flag and begin the recovery process if needed */
> +		mutex_lock(&rproc->lock);
>   		rproc->recovery_disabled = false;
> +		mutex_unlock(&rproc->lock);
>   		rproc_trigger_recovery(rproc);
>   	} else if (!strncmp(buf, "disabled", count)) {
> +		mutex_lock(&rproc->lock);
>   		rproc->recovery_disabled = true;
> +		mutex_unlock(&rproc->lock);
>   	} else if (!strncmp(buf, "recover", count)) {
>   		/* begin the recovery process without changing the flag */
>   		rproc_trigger_recovery(rproc);
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 8c7ea8922638..628e0de9a132 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -50,10 +50,14 @@ static ssize_t recovery_store(struct device *dev,
>   
>   	if (sysfs_streq(buf, "enabled")) {
>   		/* change the flag and begin the recovery process if needed */
> +		mutex_lock(&rproc->lock);
>   		rproc->recovery_disabled = false;
> +		mutex_unlock(&rproc->lock);
>   		rproc_trigger_recovery(rproc);
>   	} else if (sysfs_streq(buf, "disabled")) {
> +		mutex_lock(&rproc->lock);
>   		rproc->recovery_disabled = true;
> +		mutex_unlock(&rproc->lock);
>   	} else if (sysfs_streq(buf, "recover")) {
>   		/* begin the recovery process without changing the flag */
>   		rproc_trigger_recovery(rproc);
