Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1CD64438A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiLFMzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiLFMzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:55:21 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7D3F6D;
        Tue,  6 Dec 2022 04:54:50 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B69PLiM017745;
        Tue, 6 Dec 2022 13:54:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=SSjFlK5razRb2lBjqnnM6nfRi1NV7iEx3MQtdTgKL58=;
 b=wf8hGy++so1Bb90jBgFa/v9Dphtyx01wODOQacT0+8Z+vzw6ZBgrNO5M9Jdg0IO2UD5A
 7z6zKjm1Dsv/j8aKwBqx95aSxTbuLRd3qdmv5ch/LG8l2rUOAHQRnf0Bju6laEQ+nlk7
 4BQMvievWm9JujUYr3ddyHMBhflF7zhGkDCx5AnE12NMt+ob6pAfah3YC2WNYfRh+Bs1
 nBMHSW/ODn8EqS6bqE1vjQoYGTINPKJmG+853xWd5zORHIk3+4JK+uT4WCPZNpt9MX9P
 fz7ecw2Y1slfA+dt9lQrevF+kKww19SM4BWOY6Dbxs6DXldNOs+oxmUh2SegKP+aL0GE nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3m7xp70ufr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 13:54:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 920DE100034;
        Tue,  6 Dec 2022 13:54:42 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 78277222C97;
        Tue,  6 Dec 2022 13:54:42 +0100 (CET)
Received: from [10.252.150.170] (10.252.150.170) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 6 Dec
 2022 13:54:40 +0100
Message-ID: <0987cae3-0edc-918b-5b23-22f238f22aa2@foss.st.com>
Date:   Tue, 6 Dec 2022 13:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] rpmsg: char: Use preallocated SKBs.
Content-Language: en-US
To:     Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221206085008.25388-1-piotr.wojtaszczyk@timesys.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20221206085008.25388-1-piotr.wojtaszczyk@timesys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.150.170]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_09,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Piotr

On 12/6/22 09:50, Piotr Wojtaszczyk wrote:
> On a message reception copy the message to a SKB taken from preallocated
> pool instead of allocating a new SKB each time.
> During high rpmsg traffic this reduces consumed CPU time noticeably.

Do you have any metrics to share?

> 
> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> ---
>  drivers/rpmsg/rpmsg_char.c       | 58 ++++++++++++++++++++++++++++----
>  drivers/rpmsg/rpmsg_internal.h   | 21 ++++++++++++
>  drivers/rpmsg/virtio_rpmsg_bus.c | 21 ------------
>  3 files changed, 72 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index ac50ed757765..76546ba72cdc 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -75,9 +75,44 @@ struct rpmsg_eptdev {
>  
>  	spinlock_t queue_lock;
>  	struct sk_buff_head queue;
> +	struct sk_buff_head skb_pool;
>  	wait_queue_head_t readq;
>  };
>  
> +static inline
> +struct sk_buff *rpmsg_eptdev_get_skb(struct rpmsg_eptdev *eptdev)
> +{
> +	struct sk_buff *skb;
> +
> +	skb = skb_dequeue(&eptdev->skb_pool);
> +	if (!skb)
> +		skb = alloc_skb(MAX_RPMSG_BUF_SIZE, GFP_ATOMIC);

The "get_mtu" endpoint ops should be used here.
But in any case this works for the virtio backend which defines get_mtu ops
(asit define the MAX_RPMSG_BUF_SIZE), but not for other backend such as glink.
Your proposal needs to be compatible with the legacy.

Here is a proposal:

static struct
sk_buff *rpmsg_eptdev_get_skb(struct rpmsg_eptdev *eptdev, int len)
{
	struct sk_buff *skb;

	if (eptdev->ept->ops->get_mtu) {
		skb = skb_dequeue(&eptdev->skb_pool);
		if (!skb)
			skb = alloc_skb(eptdev->ept->ops->get_mtu(eptdev->ept),
					GFP_ATOMIC);
	} else {
		alloc_skb (len);
	}
}

> +	return skb;
> +}
> +
> +static inline
> +void rpmsg_eptdev_put_skb(struct rpmsg_eptdev *eptdev, struct sk_buff *skb)
> +{
> +	/* Recycle the skb */
> +	skb->tail = 0;
> +	skb->len = 0;
> +	skb_queue_head(&eptdev->skb_pool, skb);
> +}
> +
> +static void rpmsg_eptdev_free_all_skb(struct rpmsg_eptdev *eptdev)
> +{
> +	struct sk_buff *skb;
> +
> +	while (!skb_queue_empty(&eptdev->queue)) {
> +		skb = skb_dequeue(&eptdev->queue);
> +		kfree_skb(skb);
> +	}
> +	while (!skb_queue_empty(&eptdev->skb_pool)) {
> +		skb = skb_dequeue(&eptdev->skb_pool);
> +		kfree_skb(skb);
> +	}
> +}
> +
>  static int rpmsg_eptdev_destroy(struct device *dev, void *data)
>  {
>  	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
> @@ -104,7 +139,7 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>  	struct rpmsg_eptdev *eptdev = priv;
>  	struct sk_buff *skb;
>  
> -	skb = alloc_skb(len, GFP_ATOMIC);
> +	skb = rpmsg_eptdev_get_skb(eptdev);
>  	if (!skb)
>  		return -ENOMEM;
>  
> @@ -126,6 +161,18 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  	struct rpmsg_endpoint *ept;
>  	struct rpmsg_device *rpdev = eptdev->rpdev;
>  	struct device *dev = &eptdev->dev;
> +	struct sk_buff *skb;
> +	int i;
> +
> +	/* Preallocate 8 SKBs */
> +	for (i = 0; i < 8; i++) {

Do you need to preallocate them?
during runtime, it will try to reuse SKBs of the skb_pool and if no more
available it will create a new one.
This would also help to solve the issue of using MAX_RPMSG_BUF_SIZE

Regards,
Arnaud
> +		skb = rpmsg_eptdev_get_skb(eptdev);
> +		if (!skb) {
> +			rpmsg_eptdev_free_all_skb(eptdev);
> +			return -ENOMEM;
> +		}
> +		rpmsg_eptdev_put_skb(eptdev, skb);
> +	}
>  
>  	get_device(dev);
>  
> @@ -146,7 +193,6 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
>  {
>  	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
>  	struct device *dev = &eptdev->dev;
> -	struct sk_buff *skb;
>  
>  	/* Close the endpoint, if it's not already destroyed by the parent */
>  	mutex_lock(&eptdev->ept_lock);
> @@ -157,10 +203,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
>  	mutex_unlock(&eptdev->ept_lock);
>  
>  	/* Discard all SKBs */
> -	while (!skb_queue_empty(&eptdev->queue)) {
> -		skb = skb_dequeue(&eptdev->queue);
> -		kfree_skb(skb);
> -	}
> +	rpmsg_eptdev_free_all_skb(eptdev);
>  
>  	put_device(dev);
>  
> @@ -209,7 +252,7 @@ static ssize_t rpmsg_eptdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	if (copy_to_iter(skb->data, use, to) != use)
>  		use = -EFAULT;
>  
> -	kfree_skb(skb);
> +	rpmsg_eptdev_put_skb(eptdev, skb);
>  
>  	return use;
>  }
> @@ -358,6 +401,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
>  	mutex_init(&eptdev->ept_lock);
>  	spin_lock_init(&eptdev->queue_lock);
>  	skb_queue_head_init(&eptdev->queue);
> +	skb_queue_head_init(&eptdev->skb_pool);
>  	init_waitqueue_head(&eptdev->readq);
>  
>  	device_initialize(dev);
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index 3fc83cd50e98..5acaa54a277a 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -15,6 +15,27 @@
>  #include <linux/rpmsg.h>
>  #include <linux/poll.h>
>  
> +/*
> + * We're allocating buffers of 512 bytes each for communications. The
> + * number of buffers will be computed from the number of buffers supported
> + * by the vring, upto a maximum of 512 buffers (256 in each direction).
> + *
> + * Each buffer will have 16 bytes for the msg header and 496 bytes for
> + * the payload.
> + *
> + * This will utilize a maximum total space of 256KB for the buffers.
> + *
> + * We might also want to add support for user-provided buffers in time.
> + * This will allow bigger buffer size flexibility, and can also be used
> + * to achieve zero-copy messaging.
> + *
> + * Note that these numbers are purely a decision of this driver - we
> + * can change this without changing anything in the firmware of the remote
> + * processor.
> + */
> +#define MAX_RPMSG_NUM_BUFS	(512)
> +#define MAX_RPMSG_BUF_SIZE	(512)
> +
>  #define to_rpmsg_device(d) container_of(d, struct rpmsg_device, dev)
>  #define to_rpmsg_driver(d) container_of(d, struct rpmsg_driver, drv)
>  
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 3d9e442883e1..6552928a440d 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -133,27 +133,6 @@ struct virtio_rpmsg_channel {
>  #define to_virtio_rpmsg_channel(_rpdev) \
>  	container_of(_rpdev, struct virtio_rpmsg_channel, rpdev)
>  
> -/*
> - * We're allocating buffers of 512 bytes each for communications. The
> - * number of buffers will be computed from the number of buffers supported
> - * by the vring, upto a maximum of 512 buffers (256 in each direction).
> - *
> - * Each buffer will have 16 bytes for the msg header and 496 bytes for
> - * the payload.
> - *
> - * This will utilize a maximum total space of 256KB for the buffers.
> - *
> - * We might also want to add support for user-provided buffers in time.
> - * This will allow bigger buffer size flexibility, and can also be used
> - * to achieve zero-copy messaging.
> - *
> - * Note that these numbers are purely a decision of this driver - we
> - * can change this without changing anything in the firmware of the remote
> - * processor.
> - */
> -#define MAX_RPMSG_NUM_BUFS	(512)
> -#define MAX_RPMSG_BUF_SIZE	(512)
> -
>  /*
>   * Local addresses are dynamically allocated on-demand.
>   * We do not dynamically assign addresses from the low 1024 range,
