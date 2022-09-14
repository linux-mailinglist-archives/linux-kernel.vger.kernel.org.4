Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3904E5B8286
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiINH5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiINH5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:57:07 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5866C74DDE;
        Wed, 14 Sep 2022 00:56:04 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E4wmj9011529;
        Wed, 14 Sep 2022 09:55:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=TaMxnr1hW83w8IirdV0xmuuDYtv5ukIfg/IXCa7trMY=;
 b=al78NWzHlanWshtZUb+YQ7PcUPqNYYEoqWrUK1o/JDJ4LS0ObXpgGOazeCrzzIDZhG4V
 OMlxM+RaSoZvfNXgkUZRLiZe9Rt+8LlvxA8/YeGB6grNWRHtv2z4cmS/iq3pQ83DOCrb
 RhbOVlruzgdKqm9NnxsiqJCUjjCk2h5+USAAd8xetgYouBhlZXLg1+cBTOx348BQJLUU
 a8mqH9jMWqNbZ+nlI9C0eJ6KthmAvtrhzlJeM8ZS2WLDiOTM79WEENl1ggsrAnopFtfa
 09SD85B4aJPVnphMBlyOObeuoCaa+ho6Dta+SulNQQaUTppNKVwB2qokoOZgSOaBrcdR yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jjy07bcc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:55:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 204B410002A;
        Wed, 14 Sep 2022 09:55:37 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1A7732132C9;
        Wed, 14 Sep 2022 09:55:37 +0200 (CEST)
Received: from [10.201.22.245] (10.75.127.49) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 09:55:36 +0200
Message-ID: <33471742-634b-8fcb-dd56-e396c4e788f5@foss.st.com>
Date:   Wed, 14 Sep 2022 09:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 1/2] rpmsg: glink: Add lock to avoid race when rpmsg
 device is released
Content-Language: en-US
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
References: <1663002336-11809-1-git-send-email-quic_deesin@quicinc.com>
 <1663002336-11809-2-git-send-email-quic_deesin@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <1663002336-11809-2-git-send-email-quic_deesin@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To EQNDAG1NODE5.st.com
 (10.75.129.134)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_02,2022-09-13_01,2022-06-22_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit subject should start with  "rpmsg: char:"
no glink driver update...

Regards,
Arnaud

On 9/12/22 19:05, Deepak Kumar Singh wrote:
> When remote host goes down glink char device channel is freed and
> associated rpdev is destroyed through rpmsg_chrdev_eptdev_destroy(),
> At the same time user space apps can still try to open/poll rpmsg
> char device which will result in calling rpmsg_create_ept()/rpmsg_poll().
> These functions will try to reference rpdev which has already been freed
> through rpmsg_chrdev_eptdev_destroy().
> 
> File operation functions and device removal function must be protected
> with lock. This patch adds existing ept lock in remove function as well.
> 
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 4f21891..5500dc0 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -75,6 +75,7 @@ int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
>  	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
>  
>  	mutex_lock(&eptdev->ept_lock);
> +	eptdev->rpdev = NULL;
>  	if (eptdev->ept) {
>  		rpmsg_destroy_ept(eptdev->ept);
>  		eptdev->ept = NULL;
> @@ -126,6 +127,11 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  		return -EBUSY;
>  	}
>  
> +	if (!eptdev->rpdev) {
> +		mutex_unlock(&eptdev->ept_lock);
> +		return -ENETRESET;
> +	}
> +
>  	get_device(dev);
>  
>  	/*
> @@ -277,7 +283,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
>  	if (!skb_queue_empty(&eptdev->queue))
>  		mask |= EPOLLIN | EPOLLRDNORM;
>  
> +	mutex_lock(&eptdev->ept_lock);
>  	mask |= rpmsg_poll(eptdev->ept, filp, wait);
> +	mutex_unlock(&eptdev->ept_lock);
>  
>  	return mask;
>  }
