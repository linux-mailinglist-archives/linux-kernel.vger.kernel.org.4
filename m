Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E7C5B8289
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiINH7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiINH6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:58:37 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFE174E3B;
        Wed, 14 Sep 2022 00:57:49 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E4sgwN002109;
        Wed, 14 Sep 2022 09:57:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Xlzg64QRBaiX7YQJMdWekhVdnuffDMFxutuEyxGiUOE=;
 b=KlyXtALnOjF4lB+D2sBzHEIaeHxVRgatiNGi8/PryhjGY6LPvY4fcyzwLrC1VEhDqY9b
 zQwOnTE0KrDaJ4kRi1dGJPh3vjDfxl0cNj4/8ZaKVGlNBe8yxNzrhCuAUqWO47rZFucH
 wz70D9VFK42D/PzlhOchLyIIIab+O9ZgOoydKfwcz1L5rfMNfqMPFDpyMeM/37dpS5ZA
 ZjmwFz+YiLTT1E5Qf19tmu+5I7tu93SLs30JV9eMYTyfbsqVfDyZ1ioH4tAWP7t/4krA
 7le3cHmIic9Z2ZkmsT7J3uSqJgcbcEYYV9HFHzeaaQJQVnP66Blvi/dqVvOWtUcLOo2D 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jjxxxkdev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:57:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E1932100038;
        Wed, 14 Sep 2022 09:57:30 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DCDEC214D1F;
        Wed, 14 Sep 2022 09:57:30 +0200 (CEST)
Received: from [10.201.22.245] (10.75.127.122) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 09:57:30 +0200
Message-ID: <37d5a6e0-4b98-55c0-8209-98c032eaf646@foss.st.com>
Date:   Wed, 14 Sep 2022 09:57:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 2/2] rpmsg: glink: Add lock to rpmsg_ctrldev_remove
Content-Language: en-US
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
References: <1663002336-11809-1-git-send-email-quic_deesin@quicinc.com>
 <1663002336-11809-3-git-send-email-quic_deesin@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <1663002336-11809-3-git-send-email-quic_deesin@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.122]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To EQNDAG1NODE5.st.com
 (10.75.129.134)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-13_01,2022-06-22_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace "glink" by "ctrl" in subject

On 9/12/22 19:05, Deepak Kumar Singh wrote:
> Call to rpmsg_ctrldev_ioctl() and rpmsg_ctrldev_remove() must be synchronized.
> In present code rpmsg_ctrldev_remove() is not protected with lock, therefore
> new char device creation can succeed through rpmsg_ctrldev_ioctl() call. At the
> same time call to rpmsg_ctrldev_remove() funtion for ctrl device removal will
> free associated rpdev device. As char device creation already succeeded, user
> space is free to issue open() call which maps to rpmsg_create_ept() in kernel.
> rpmsg_create_ept() function tries to reference rpdev which has already been
> freed through rpmsg_ctrldev_remove(). Issue is predominantly seen in aggressive
> reboot tests where rpmsg_ctrldev_ioctl() and rpmsg_ctrldev_remove() can race with
> each other.
> 
> Adding lock in rpmsg_ctrldev_remove() avoids any new char device creation
> throught rpmsg_ctrldev_ioctl() while remove call is already in progress.
> 
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_ctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
> index 107da70..4332538 100644
> --- a/drivers/rpmsg/rpmsg_ctrl.c
> +++ b/drivers/rpmsg/rpmsg_ctrl.c
> @@ -194,10 +194,12 @@ static void rpmsg_ctrldev_remove(struct rpmsg_device *rpdev)
>  	struct rpmsg_ctrldev *ctrldev = dev_get_drvdata(&rpdev->dev);
>  	int ret;
>  
> +	mutex_lock(&ctrldev->ctrl_lock);
>  	/* Destroy all endpoints */
>  	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
>  	if (ret)
>  		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
> +	mutex_unlock(&ctrldev->ctrl_lock);
>  
>  	cdev_device_del(&ctrldev->cdev, &ctrldev->dev);
>  	put_device(&ctrldev->dev);
