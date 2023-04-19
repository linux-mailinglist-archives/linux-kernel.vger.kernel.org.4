Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347726E76E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjDSJ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjDSJ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:56:00 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786155248;
        Wed, 19 Apr 2023 02:55:58 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33J9pPYi021370;
        Wed, 19 Apr 2023 11:55:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=zuPRjgXHQRcNa4T1aVSLxSto975fvvj+3BuI9lCCOJo=;
 b=iph058O4NApSbJ+Uyz+xx1p4NeZPdGHk9TBCju3jitq38va2P5Tmwi9Bz4ilOt5iM30c
 R/r4M4gOvWsd9NcfEfhT5jS/l7b4j6HXH8oW6d2s9mHP7NaXcS4n50MxHFVoyj8D8976
 uKr0IkRVIkcRYFsHVEC3/2coj/4zm7czdppFSC+dgUq4BgaJo75HyhDW+YG2ll11Q1g/
 AOQVtMXZF98HYZnBpCUzmC+rbeEjjJF8avgGsPXWYhgkN+ptsIWuWQoWlgS4Y45uhOTa
 Fp4Jsau4B7EMUdnczSVz9E9+4iZlUiD/+BlecSUbm0aM1eBcUVh+BDKa54gC108us4zS jQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3q2dye81vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 11:55:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4FEB810002A;
        Wed, 19 Apr 2023 11:55:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 47FDD214D29;
        Wed, 19 Apr 2023 11:55:44 +0200 (CEST)
Received: from [10.201.21.178] (10.201.21.178) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 19 Apr
 2023 11:55:43 +0200
Message-ID: <fe8c74d9-aa8a-d569-a372-7bb6d0b1963a@foss.st.com>
Date:   Wed, 19 Apr 2023 11:55:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V5 3/3] rpmsg: char: Add RPMSG GET/SET SIGNAL IOCTL
 support
Content-Language: en-US
To:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <1681807721-32343-1-git-send-email-quic_sarannya@quicinc.com>
 <1681807721-32343-4-git-send-email-quic_sarannya@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <1681807721-32343-4-git-send-email-quic_sarannya@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_06,2023-04-18_01,2023-02-09_01
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/23 10:48, Sarannya S wrote:
> From: Chris Lew <quic_clew@quicinc.com>
> 
> Add RPMSG_GET_SIGNAL_IOCTL and RPMSG_SET_SIGNAL_IOCTL ioctl support for
> rpmsg char device nodes to get/set the low level transport signals.


Quite difficult to follow this series as there are two V5...

If I am not mistaken the comment from Bjorn in the first V5[1] has not been
addressed

[1] https://www.spinics.net/lists/linux-arm-msm/msg145036.html

Regards
Arnaud

> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 58 ++++++++++++++++++++++++++++++++++++++++------
>  include/linux/rpmsg.h      | 15 ++++++++++++
>  include/uapi/linux/rpmsg.h | 12 +++++++++-
>  3 files changed, 77 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index a271fce..efe14f8 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -23,6 +23,7 @@
>  #include <linux/rpmsg.h>
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
> +#include <linux/termios.h>
>  #include <linux/uaccess.h>
>  #include <uapi/linux/rpmsg.h>
>  
> @@ -68,6 +69,8 @@ struct rpmsg_eptdev {
>  	struct sk_buff_head queue;
>  	wait_queue_head_t readq;
>  
> +	u32 remote_signals;
> +	bool flow_control;
>  };
>  
>  int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
> @@ -110,7 +113,22 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>  	skb_queue_tail(&eptdev->queue, skb);
>  	spin_unlock(&eptdev->queue_lock);
>  
> -	/* wake up any blocking processes, waiting for new data */
> +	wake_up_interruptible(&eptdev->readq);
> +
> +	return 0;
> +}
> +
> +static int rpmsg_ept_flow_cb(struct rpmsg_device *rpdev, void *priv, bool enable)
> +{
> +	struct rpmsg_eptdev *eptdev = priv;
> +
> +	if (enable)
> +		eptdev->remote_signals = RPMSG_FLOW_CONTROL_ON;
> +	else
> +		eptdev->remote_signals = 0;
> +
> +	eptdev->flow_control = true;
> +
>  	wake_up_interruptible(&eptdev->readq);
>  
>  	return 0;
> @@ -152,6 +170,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  		return -EINVAL;
>  	}
>  
> +	ept->flow_cb = rpmsg_ept_flow_cb;
>  	eptdev->ept = ept;
>  	filp->private_data = eptdev;
>  	mutex_unlock(&eptdev->ept_lock);
> @@ -172,6 +191,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
>  		eptdev->ept = NULL;
>  	}
>  	mutex_unlock(&eptdev->ept_lock);
> +	eptdev->flow_control = false;
>  
>  	/* Discard all SKBs */
>  	skb_queue_purge(&eptdev->queue);
> @@ -285,6 +305,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
>  	if (!skb_queue_empty(&eptdev->queue))
>  		mask |= EPOLLIN | EPOLLRDNORM;
>  
> +	if (eptdev->flow_control)
> +		mask |= EPOLLPRI;
> +
>  	mutex_lock(&eptdev->ept_lock);
>  	mask |= rpmsg_poll(eptdev->ept, filp, wait);
>  	mutex_unlock(&eptdev->ept_lock);
> @@ -297,14 +320,35 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
>  {
>  	struct rpmsg_eptdev *eptdev = fp->private_data;
>  
> -	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
> -		return -EINVAL;
> +	bool set;
> +	u32 val;
> +	int ret;
>  
> -	/* Don't allow to destroy a default endpoint. */
> -	if (eptdev->default_ept)
> -		return -EINVAL;
> +	switch (cmd) {
> +	case RPMSG_GET_SIGNAL_IOCTL:
> +		eptdev->flow_control = false;
> +		ret = put_user(eptdev->remote_signals, (int __user *)arg);
> +		break;
> +	case RPMSG_SET_SIGNAL_IOCTL:
> +		ret = get_user(val, (int __user *)arg);
> +		if (ret)
> +			break;
> +		set = (val & RPMSG_FLOW_CONTROL_ON) ? true : false;
> +		ret = rpmsg_set_flow_control(eptdev->ept, set);
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
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 523c98b..cc7a917 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -64,12 +64,14 @@ struct rpmsg_device {
>  };
>  
>  typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
> +typedef int (*rpmsg_flowcontrol_cb_t)(struct rpmsg_device *, void *, bool);
>  
>  /**
>   * struct rpmsg_endpoint - binds a local rpmsg address to its user
>   * @rpdev: rpmsg channel device
>   * @refcount: when this drops to zero, the ept is deallocated
>   * @cb: rx callback handler
> + * @flow_cb: remote flow control callback handler
>   * @cb_lock: must be taken before accessing/changing @cb
>   * @addr: local rpmsg address
>   * @priv: private data for the driver's use
> @@ -92,6 +94,7 @@ struct rpmsg_endpoint {
>  	struct rpmsg_device *rpdev;
>  	struct kref refcount;
>  	rpmsg_rx_cb_t cb;
> +	rpmsg_flowcontrol_cb_t flow_cb;
>  	struct mutex cb_lock;
>  	u32 addr;
>  	void *priv;
> @@ -106,6 +109,7 @@ struct rpmsg_endpoint {
>   * @probe: invoked when a matching rpmsg channel (i.e. device) is found
>   * @remove: invoked when the rpmsg channel is removed
>   * @callback: invoked when an inbound message is received on the channel
> + * @flowcontrol: invoked when remote side flow control status is received
>   */
>  struct rpmsg_driver {
>  	struct device_driver drv;
> @@ -113,6 +117,7 @@ struct rpmsg_driver {
>  	int (*probe)(struct rpmsg_device *dev);
>  	void (*remove)(struct rpmsg_device *dev);
>  	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
> +	int (*flowcontrol)(struct rpmsg_device *, void *, bool);
>  };
>  
>  static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, __rpmsg16 val)
> @@ -192,6 +197,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>  
>  ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>  
> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
> +
>  #else
>  
>  static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
> @@ -316,6 +323,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>  	return -ENXIO;
>  }
>  
> +static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return -ENXIO;
> +}
> +
>  #endif /* IS_ENABLED(CONFIG_RPMSG) */
>  
>  /* use a macro to avoid include chaining to get THIS_MODULE */
> diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
> index 1637e68..c549649 100644
> --- a/include/uapi/linux/rpmsg.h
> +++ b/include/uapi/linux/rpmsg.h
> @@ -10,7 +10,7 @@
>  #include <linux/types.h>
>  
>  #define RPMSG_ADDR_ANY		0xFFFFFFFF
> -
> +#define RPMSG_FLOW_CONTROL_ON	0x001
>  /**
>   * struct rpmsg_endpoint_info - endpoint info representation
>   * @name: name of service
> @@ -43,4 +43,14 @@ struct rpmsg_endpoint_info {
>   */
>  #define RPMSG_RELEASE_DEV_IOCTL	_IOW(0xb5, 0x4, struct rpmsg_endpoint_info)
>  
> +/**
> + * Get the remote rpmsg char device's flow control signal.
> + */
> +#define RPMSG_GET_SIGNAL_IOCTL _IOW(0xb5, 0x5, struct rpmsg_endpoint_info)
> +
> +/**
> + * Set the flow control for the local rpmsg char device.
> + */
> +#define RPMSG_SET_SIGNAL_IOCTL _IOW(0xb5, 0x6, struct rpmsg_endpoint_info)
> +
>  #endif
