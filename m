Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152F573B34A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjFWJLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFWJLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:11:21 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDE5AC;
        Fri, 23 Jun 2023 02:11:19 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N8w2oS024484;
        Fri, 23 Jun 2023 11:11:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=omZ0zQt1pwfFhIi98bamv9Vd4R9xMlAoJM5+IlZeCM8=;
 b=GGogktkeQ+MBzfvQNS8MR/4cUuG/NNQ/GCInUAheJnNHnkUoY/W/0Sj7QeGTqfy54Vng
 5Hvwm/lOfQUbUs6gbLp9Us8UZ6yqlOx0SEsisolOefIdf29xp9SxmG4cyjk8810XPScL
 qm3c2GVdyqnUSEOkrYlaxwXct7K8RaRHMaRVMLSQAOCYuCWVBYr+3qwXKawtGiPBWOqd
 HzsoVtsbh3RoUyigR+sLGBS+UIfSjeoZrp6IHDgdVuxoSDGXZKmmLDohcDqGM60mTOju
 xva3XFsHbP9uWTbdpGBuborOK5Oy8WzHP0OmMNcnsLzOzDq8n8W5MFS9gkwoQO6lObpG +Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rd8bp02y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 11:11:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7448B100073;
        Fri, 23 Jun 2023 11:11:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C9B4218613;
        Fri, 23 Jun 2023 11:11:06 +0200 (CEST)
Received: from [10.201.21.9] (10.201.21.9) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 23 Jun
 2023 11:11:04 +0200
Message-ID: <d0e5a6bf-e89f-bcf0-7009-94edfbcf2a83@foss.st.com>
Date:   Fri, 23 Jun 2023 11:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V8 3/3] rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL
 support
Content-Language: en-US
To:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <1687361648-27688-1-git-send-email-quic_sarannya@quicinc.com>
 <1687361648-27688-4-git-send-email-quic_sarannya@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <1687361648-27688-4-git-send-email-quic_sarannya@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.9]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_04,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 17:34, Sarannya S wrote:
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
>  drivers/rpmsg/rpmsg_char.c | 50 ++++++++++++++++++++++++++++++++++++++++------
>  include/uapi/linux/rpmsg.h | 10 ++++++++++
>  2 files changed, 54 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index a271fce..2cdd31e 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -52,6 +52,8 @@ static DEFINE_IDA(rpmsg_minor_ida);
>   * @readq:	wait object for incoming queue
>   * @default_ept: set to channel default endpoint if the default endpoint should be re-used
>   *              on device open to prevent endpoint address update.
> + * remote_flow_restricted: to indicate if the remote has requested for flow to be limited
> + * remote_flow_updated:	to indicate if the flow control has been requested

replace tab by space after ':'

>   */
>  struct rpmsg_eptdev {
>  	struct device dev;
> @@ -68,6 +70,8 @@ struct rpmsg_eptdev {
>  	struct sk_buff_head queue;
>  	wait_queue_head_t readq;
>  
> +	bool remote_flow_restricted;
> +	bool remote_flow_updated;
>  };
>  
>  int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
> @@ -116,6 +120,18 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>  	return 0;
>  }
>  
> +static int rpmsg_ept_flow_cb(struct rpmsg_device *rpdev, void *priv, bool enable)
> +{
> +	struct rpmsg_eptdev *eptdev = priv;
> +
> +	eptdev->remote_flow_restricted = enable;
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
> @@ -152,6 +168,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  		return -EINVAL;
>  	}
>  
> +	ept->flow_cb = rpmsg_ept_flow_cb;
>  	eptdev->ept = ept;
>  	filp->private_data = eptdev;
>  	mutex_unlock(&eptdev->ept_lock);
> @@ -172,6 +189,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
>  		eptdev->ept = NULL;
>  	}
>  	mutex_unlock(&eptdev->ept_lock);
> +	eptdev->remote_flow_updated = false;
>  
>  	/* Discard all SKBs */
>  	skb_queue_purge(&eptdev->queue);
> @@ -285,6 +303,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
>  	if (!skb_queue_empty(&eptdev->queue))
>  		mask |= EPOLLIN | EPOLLRDNORM;
>  
> +	if (eptdev->remote_flow_updated)
> +		mask |= EPOLLPRI;
> +
>  	mutex_lock(&eptdev->ept_lock);
>  	mask |= rpmsg_poll(eptdev->ept, filp, wait);
>  	mutex_unlock(&eptdev->ept_lock);
> @@ -297,14 +318,31 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
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
> +		ret = put_user(eptdev->remote_flow_restricted, (int __user *)arg);
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
> index 1637e68..b0a6c17 100644
> --- a/include/uapi/linux/rpmsg.h
> +++ b/include/uapi/linux/rpmsg.h
> @@ -43,4 +43,14 @@ struct rpmsg_endpoint_info {
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


Perhaps I missed something, but you use "rpmsg_endpoint_info" as argument.
In rpmsg_eptdev_ioctl the argument is treated as a boolean.
Seems to me that something is wrong here.

regards,
Arnaud

> +
>  #endif
