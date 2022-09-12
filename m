Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2063C5B6447
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiILXnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiILXnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:43:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9608550070;
        Mon, 12 Sep 2022 16:43:09 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CMZZAQ026715;
        Mon, 12 Sep 2022 23:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MrdPCVKJW19ifdLWsUR1qiE5pu616/8/sWAfZWiWc8E=;
 b=mmwoAt8rS+Kgx0FvSWUvy6a6LQ+dQKKOB5/U7ZAsFTK0J+EiORRsb2cFqDKNIRoqypa6
 Tf+qMRxtl2HMJCbapi8x9+/M02FBTwHj7VAifC76BQBY1KSpfV3+0QUz6hhxAW3msAux
 XK32daV8s0WzCQ55nbLyjWfgt3OvO62uZQKE6v8PP/e/IGdDbLKt1xH9gYrv/mlcpoZD
 SyYt802uADQdpuHWUKjbY/nN+5KQ6cwFC/crGAM58qt99t+BiTn/6fQ+0Bnqi06qIChP
 OOQD+0+XGUye/yzSAKdnFN354ZXjli6PpAd89xVdcgoRedZPTWf31jtdmg8J8tLgNuJ7 FQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk0denwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 23:42:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CNgvl1008893
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 23:42:57 GMT
Received: from [10.111.167.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 16:42:55 -0700
Message-ID: <94e0ae94-c8f8-8aa5-606d-68e3abca5a9e@quicinc.com>
Date:   Mon, 12 Sep 2022 16:42:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/mdp5: fix kernel panic during shutdown
Content-Language: en-US
To:     Fabien Parent <fabien.parent@linaro.org>, <robdclark@gmail.com>,
        <dmitry.baryshkov@linaro.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <dianders@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20220909152856.149291-1-fabien.parent@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220909152856.149291-1-fabien.parent@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9JoVC6nU3aG-uDALZdha683VO2jdYV2f
X-Proofpoint-ORIG-GUID: 9JoVC6nU3aG-uDALZdha683VO2jdYV2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_14,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120083
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien

Thanks for the patch.

I believe this issue should get resolved with 
https://patchwork.freedesktop.org/patch/490326/ as this avoids the override.

I have acked that change and will pick it up for the next fixes.

Thanks

Abhinav


On 9/9/2022 8:28 AM, Fabien Parent wrote:
> The kernel is panicking when rebooting on MSM8939:
> 
> 	# reboot -f
> 	[   87.280853] Unable to handle kernel write to read-only memory at virtual address ffff800008ed5810
> 	...
> 	snip
> 	...
> 	[   87.445142] Call trace:
> 	[   87.452253]  mutex_lock+0x1c/0x50
> 	[   87.454511]  msm_drv_shutdown+0x28/0x40
> 	[   87.457984]  platform_shutdown+0x28/0x40
> 	[   87.461629]  device_shutdown+0x14c/0x240
> 	[   87.465796]  __do_sys_reboot+0x180/0x274
> 	[   87.469703]  __arm64_sys_reboot+0x28/0x3c
> 	[   87.473608]  invoke_syscall+0x54/0x124
> 	[   87.477515]  el0_svc_common.constprop.0+0x44/0xec
> 	[   87.481163]  do_el0_svc+0x90/0xe0
> 	[   87.485934]  el0_svc+0x50/0xa4
> 	[   87.489232]  el0t_64_sync_handler+0x11c/0x150
> 	[   87.492185]  el0t_64_sync+0x190/0x194
> 	[   87.496618] Code: f9800011 c85ffc03 ca010064 b5000064 (c8047c02)
> 	[   87.500264] ---[ end trace 0000000000000000 ]---
> 	Segmentation fault
> 
> The issue comes from the fact that mdp5_init() is calling
> platform_set_drvdata() and consequently overwriting the driver data
> previously set by msm_drv_probe.
> msm_drv_shutdown was casting the driver data as "struct msm_drm_private"
> while it was actually a "struct mdp5_kms".
> 
> This commit fixes the issue by having mdp5_init() not override the
> platform driver data, and instead use a series of
> to_mdp5_kms(to_mdp_kms(priv->kms)) to retrieve the mdp5_kms from the
> pdata.
> 
> Fixes: 54199009958f ("drm/msm: Fix shutdown")
> Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
> ---
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index d2a48caf9d27..17aeabeedfeb 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -634,7 +634,8 @@ static int mdp5_kms_init(struct drm_device *dev)
>   
>   static void mdp5_destroy(struct platform_device *pdev)
>   {
> -	struct mdp5_kms *mdp5_kms = platform_get_drvdata(pdev);
> +	struct msm_drm_private *priv = platform_get_drvdata(pdev);
> +	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
>   	int i;
>   
>   	if (mdp5_kms->ctlm)
> @@ -797,7 +798,8 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
>   		goto fail;
>   	}
>   
> -	platform_set_drvdata(pdev, mdp5_kms);
> +	/* set uninit-ed kms */
> +	priv->kms = &mdp5_kms->base.base;
>   
>   	spin_lock_init(&mdp5_kms->resource_lock);
>   
> @@ -890,13 +892,13 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
>   	if (ret)
>   		goto fail;
>   
> -	/* set uninit-ed kms */
> -	priv->kms = &mdp5_kms->base.base;
> -
>   	return 0;
>   fail:
>   	if (mdp5_kms)
>   		mdp5_destroy(pdev);
> +
> +	priv->kms = NULL;
> +
>   	return ret;
>   }
>   
> @@ -956,7 +958,8 @@ static int mdp5_dev_remove(struct platform_device *pdev)
>   static __maybe_unused int mdp5_runtime_suspend(struct device *dev)
>   {
>   	struct platform_device *pdev = to_platform_device(dev);
> -	struct mdp5_kms *mdp5_kms = platform_get_drvdata(pdev);
> +	struct msm_drm_private *priv = platform_get_drvdata(pdev);
> +	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
>   
>   	DBG("");
>   
> @@ -966,7 +969,8 @@ static __maybe_unused int mdp5_runtime_suspend(struct device *dev)
>   static __maybe_unused int mdp5_runtime_resume(struct device *dev)
>   {
>   	struct platform_device *pdev = to_platform_device(dev);
> -	struct mdp5_kms *mdp5_kms = platform_get_drvdata(pdev);
> +	struct msm_drm_private *priv = platform_get_drvdata(pdev);
> +	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
>   
>   	DBG("");
>   
