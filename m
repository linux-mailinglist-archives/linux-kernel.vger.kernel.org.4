Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED7F6ECEA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjDXNeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjDXNdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:33:45 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72767AA4;
        Mon, 24 Apr 2023 06:33:32 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OAJVb4015326;
        Mon, 24 Apr 2023 15:33:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=1giUplEk1eT/+095n6zriovkO8cGlmRt49A2uW4fmAw=;
 b=eJPEQ0RzyrgRxn2ZBncnRfubGwcB2goOIOda0mE6NkImh89PSZyDSbqJCy7aZ3X8jEvF
 gncSfFQ816WApi+0vUyJiSY+3rOuNuRkCNVQOgT5A8lc9vNsUksvXEOKbIEol+AYD6jI
 AXKtLhFxxJs0oRUFkR/2XjmK5/zR3mi5JSvX1rg3PGnpD/IBqmkGiDjHDu2c2j+O4Jtm
 E4+wSPfhVzj4Jw9KuBO156lgklsulA9NsBRwlGtbWMB8mBHvpdj2wort4TyrW2CvdAGK
 Y40pM66qWS5kSD+Kdz87hmx9gNr+yr1lNxPeSXab6i5XQ0WMnYorZJhQyEM41CLaMSdf wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3q48evkpkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 15:33:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 597AA10002A;
        Mon, 24 Apr 2023 15:33:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5019022FA5E;
        Mon, 24 Apr 2023 15:33:19 +0200 (CEST)
Received: from [10.252.21.25] (10.252.21.25) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 24 Apr
 2023 15:33:18 +0200
Message-ID: <2fe5b739-b700-0fa7-78df-fde9358c794e@foss.st.com>
Date:   Mon, 24 Apr 2023 15:33:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V7 3/3] rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL
 support
Content-Language: en-US
To:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <1682160127-18103-1-git-send-email-quic_sarannya@quicinc.com>
 <1682160127-18103-4-git-send-email-quic_sarannya@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <1682160127-18103-4-git-send-email-quic_sarannya@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.21.25]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_07,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/23 12:42, Sarannya S wrote:
> From: Chris Lew <quic_clew@quicinc.com>
> 
> Add RPMSG_GET_OUTGOING_FLOWCONTROL and RPMSG_SET_INCOMING_FLOWCONTROL
> IOCTL support for rpmsg char device nodes to get/set the low level
> transport signals.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 49 ++++++++++++++++++++++++++++++++++++++++------
>  include/uapi/linux/rpmsg.h | 11 ++++++++++-
>  2 files changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index a271fce..d50908f 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -23,6 +23,7 @@
>  #include <linux/rpmsg.h>
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
> +#include <linux/termios.h>

Seems useless now

>  #include <linux/uaccess.h>
>  #include <uapi/linux/rpmsg.h>
>  
> @@ -68,6 +69,8 @@ struct rpmsg_eptdev {
>  	struct sk_buff_head queue;
>  	wait_queue_head_t readq;
>  
> +	bool remote_flow;
> +	bool remote_flow_updated;
>  };
>  
>  int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
> @@ -116,6 +119,18 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>  	return 0;
>  }
>  
> +static int rpmsg_ept_flow_cb(struct rpmsg_device *rpdev, void *priv, bool enable)
> +{
> +	struct rpmsg_eptdev *eptdev = priv;
> +
> +	eptdev->remote_flow = enable;
> +	eptdev->remote_flow_updated = true;
> +
> +	wake_up_interruptible(&eptdev->readq);
> +
> +	return 0;
> +}
> +
>  static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  {
>  	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
> @@ -152,6 +167,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  		return -EINVAL;
>  	}
>  
> +	ept->flow_cb = rpmsg_ept_flow_cb;
>  	eptdev->ept = ept;
>  	filp->private_data = eptdev;
>  	mutex_unlock(&eptdev->ept_lock);
> @@ -172,6 +188,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
>  		eptdev->ept = NULL;
>  	}
>  	mutex_unlock(&eptdev->ept_lock);
> +	eptdev->remote_flow_updated = false;
>  
>  	/* Discard all SKBs */
>  	skb_queue_purge(&eptdev->queue);
> @@ -285,6 +302,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
>  	if (!skb_queue_empty(&eptdev->queue))
>  		mask |= EPOLLIN | EPOLLRDNORM;
>  
> +	if (eptdev->remote_flow_updated)
> +		mask |= EPOLLPRI;
> +
>  	mutex_lock(&eptdev->ept_lock);
>  	mask |= rpmsg_poll(eptdev->ept, filp, wait);
>  	mutex_unlock(&eptdev->ept_lock);
> @@ -297,14 +317,31 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
>  {
>  	struct rpmsg_eptdev *eptdev = fp->private_data;
>  
> -	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
> -		return -EINVAL;
> +	bool set;
> +	int ret;
>  
> -	/* Don't allow to destroy a default endpoint. */
> -	if (eptdev->default_ept)
> -		return -EINVAL;
> +	switch (cmd) {
> +	case RPMSG_GET_OUTGOING_FLOWCONTROL:
> +		eptdev->remote_flow_updated = false;
> +		ret = put_user(eptdev->remote_flow, (int __user *)arg);

If the rpmsg_set_flow_control is not implemented on remote side or in the
backend then we should return true by default.
Else the communication should not be possible if eptdev->remote_flow is not
initialized.

Perhaps adding a "flow_ctrl" boolean in the rpmsg_device (similar to the
"announce") would give the information if the flow control is supported or not.
This "flow_ctrl" boolean would be initialized by the backend.

Regards
Arnaud


> +		break;
> +	case RPMSG_SET_INCOMING_FLOWCONTROL:
> +		set = !!arg;
> +		ret = rpmsg_set_flow_control(eptdev->ept, set, eptdev->chinfo.dst);
> +		break;
> +	case RPMSG_DESTROY_EPT_IOCTL:
> +		/* Don't allow to destroy a default endpoint. */
> +		if (eptdev->default_ept) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		ret = rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
>  
> -	return rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
> +	return ret;
>  }
>  
>  static const struct file_operations rpmsg_eptdev_fops = {
> diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
> index 1637e68..c955e27 100644
> --- a/include/uapi/linux/rpmsg.h
> +++ b/include/uapi/linux/rpmsg.h
> @@ -10,7 +10,6 @@
>  #include <linux/types.h>
>  
>  #define RPMSG_ADDR_ANY		0xFFFFFFFF
> -
>  /**
>   * struct rpmsg_endpoint_info - endpoint info representation
>   * @name: name of service
> @@ -43,4 +42,14 @@ struct rpmsg_endpoint_info {
>   */
>  #define RPMSG_RELEASE_DEV_IOCTL	_IOW(0xb5, 0x4, struct rpmsg_endpoint_info)
>  
> +/**
> + * Set the flow control for the remote rpmsg char device.
> + */
> +#define RPMSG_GET_OUTGOING_FLOWCONTROL _IOW(0xb5, 0x5, struct rpmsg_endpoint_info)
> +
> +/**
> + * Set the flow control for the local rpmsg char device.
> + */
> +#define RPMSG_SET_INCOMING_FLOWCONTROL _IOW(0xb5, 0x6, struct rpmsg_endpoint_info)
> +
>  #endif
