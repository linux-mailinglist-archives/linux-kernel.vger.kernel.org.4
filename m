Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB2A6806D1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbjA3ID5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjA3IDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:03:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE2312F3B;
        Mon, 30 Jan 2023 00:03:54 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U7CEnm019701;
        Mon, 30 Jan 2023 08:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wUEmNGtY5YBXH0Iwf0vKCRpxgYtWM4Y6TFuANozd8as=;
 b=CvG7swZbFO20g1stkWC7haQXLYZKqLNbC+RhEPkm6LaeeB3GCkj7a1YlFM6a+4celj+m
 FvEvkHHwlSiUMoJ30v5hirICE0I0/h5xVb3WI32rOdYCpxNWC2wauruWzDUqyBYhkpM4
 HWT0fg4MtIdM/kP0dTFgZMeg8AiXZIVJMfjOssbkO2sIkd8nEn5TxOW3p+7s0Zf9Lulu
 kFqyCIjBHu2a0WHR1dggpsDup0Lg2A8nt1+CCAgUHmF+/3nDaKEbuTAoctiiSSH2m1u9
 /jdCUikGxlFeK/2X/yJ8s/XUcxTBU4Ivb4HkzF3ZUxMKowXr7SdZklx64mKH0dvxUaLO lA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvfpax72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 08:03:49 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U83mjQ018349
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 08:03:48 GMT
Received: from [10.216.24.235] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 00:03:45 -0800
Message-ID: <d9708f4b-e533-e400-acbf-3d8e816f242e@quicinc.com>
Date:   Mon, 30 Jan 2023 13:33:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] remoteproc: sysfs: fix race while updating recovery flag
Content-Language: en-US
To:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230129225106.10606-1-quic_satyap@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230129225106.10606-1-quic_satyap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PFfgtZ5PI_aMMULWC5h9AeWpLcjoPgCJ
X-Proofpoint-ORIG-GUID: PFfgtZ5PI_aMMULWC5h9AeWpLcjoPgCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=921 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300075
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/30/2023 4:21 AM, Satya Durga Srinivasu Prabhala wrote:
> When multiple clients try to update the recovery flag, it is

Multiple user-space clients ?

> possible that, race condition would lead to undesired results
> as updates to recovery flag isn't protected by any mechanism
> today. To avoid such issues, take remoteproc mutex lock before
> updating recovery flag and release the lock once done.

But your patch also adds locks for the case which does not update 
recovery flag..

> 
> Signed-off-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
> ---
>   drivers/remoteproc/remoteproc_sysfs.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 8c7ea8922638..ec37176e1589 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -48,16 +48,21 @@ static ssize_t recovery_store(struct device *dev,
>   {
>   	struct rproc *rproc = to_rproc(dev);
>   
> +	mutex_lock(&rproc->lock);
>   	if (sysfs_streq(buf, "enabled")) {
>   		/* change the flag and begin the recovery process if needed */
>   		rproc->recovery_disabled = false;
> +		mutex_unlock(&rproc->lock);
>   		rproc_trigger_recovery(rproc);
>   	} else if (sysfs_streq(buf, "disabled")) {
>   		rproc->recovery_disabled = true;
> +		mutex_unlock(&rproc->lock);
>   	} else if (sysfs_streq(buf, "recover")) {
>   		/* begin the recovery process without changing the flag */
> +		mutex_unlock(&rproc->lock);

is it really needed for this case?

>   		rproc_trigger_recovery(rproc);
>   	} else {
> +		mutex_unlock(&rproc->lock);

same here..

>   		return -EINVAL;
>   	}
>   

Do you also need to add lock for rproc_recovery_write in 
drivers/remoteproc/remoteproc_debugfs.c ?

-Mukesh
