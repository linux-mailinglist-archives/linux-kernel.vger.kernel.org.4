Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC886452D9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 05:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLGEFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 23:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGEFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 23:05:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0297054B34;
        Tue,  6 Dec 2022 20:05:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B79860A4A;
        Wed,  7 Dec 2022 04:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0141C433C1;
        Wed,  7 Dec 2022 04:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670385943;
        bh=roAixLyOzAWKUKF7fw0lR/3FLPzSc638FHOy6xTQBo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmpB13ZXcY16vYyw8MV0fkP2ghR+tSuINZ9Zc1WdF8VzY7231OYYtAgraVPvlNIeh
         /Gy0Omsc1FkBaYM+P1Q/aKY1+jtkHWJeac0vpr7SJFHy/Vikvot9u1APEQc4NgqA1T
         kxAiTVBOBeN9oZGM+ccEv9GjKZTzE6qbOnSnvMUnl3YZI+fD0ZkOdncZKX1+I3fdIS
         +AjApYG0ccdCB8iFpUzWOPgLRlDD97Bx513CUTWa6qYfAvz9uYTxwDTecaeThYoFgQ
         8iPdQBRwM3N1onB2yjFZC5WCK1Y1a6uPwgJbBcZ1dgjAo4mRAcXa1dp5nWMi5sk5Sc
         auWN9L2SLjZew==
Date:   Tue, 6 Dec 2022 22:05:40 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: char: Use preallocated SKBs.
Message-ID: <20221207040540.cv6sqqjkwuev7hgm@builder.lan>
References: <20221206093840.32181-1-piotr.wojtaszczyk@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206093840.32181-1-piotr.wojtaszczyk@timesys.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 10:38:41AM +0100, Piotr Wojtaszczyk wrote:
> On a message reception copy the message to a SKB taken from preallocated
> pool instead of allocating a new SKB each time.
> During high rpmsg traffic this reduces consumed CPU time noticeably.
> 
> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> ---
>  drivers/rpmsg/rpmsg_char.c       | 46 +++++++++++++++++++++++++++++---
>  drivers/rpmsg/rpmsg_internal.h   | 21 +++++++++++++++
>  drivers/rpmsg/virtio_rpmsg_bus.c | 21 ---------------
>  3 files changed, 64 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 3e0b8f3496ed..51b1b077687e 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -66,10 +66,37 @@ struct rpmsg_eptdev {
>  
>  	spinlock_t queue_lock;
>  	struct sk_buff_head queue;
> +	struct sk_buff_head skb_pool;
>  	wait_queue_head_t readq;
>  
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
> +	skb_queue_purge(&eptdev->queue);
> +	skb_queue_purge(&eptdev->skb_pool);
> +}
> +
>  int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
>  {
>  	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
> @@ -99,7 +126,7 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>  	struct rpmsg_eptdev *eptdev = priv;
>  	struct sk_buff *skb;
>  
> -	skb = alloc_skb(len, GFP_ATOMIC);
> +	skb = rpmsg_eptdev_get_skb(eptdev);
>  	if (!skb)
>  		return -ENOMEM;
>  
> @@ -121,6 +148,18 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  	struct rpmsg_endpoint *ept;
>  	struct rpmsg_device *rpdev = eptdev->rpdev;
>  	struct device *dev = &eptdev->dev;
> +	struct sk_buff *skb;
> +	int i;
> +
> +	/* Preallocate 8 SKBs */
> +	for (i = 0; i < 8; i++) {
> +		skb = rpmsg_eptdev_get_skb(eptdev);
> +		if (!skb) {
> +			rpmsg_eptdev_free_all_skb(eptdev);
> +			return -ENOMEM;
> +		}
> +		rpmsg_eptdev_put_skb(eptdev, skb);
> +	}
>  
>  	mutex_lock(&eptdev->ept_lock);
>  	if (eptdev->ept) {
> @@ -168,7 +207,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
>  	mutex_unlock(&eptdev->ept_lock);
>  
>  	/* Discard all SKBs */
> -	skb_queue_purge(&eptdev->queue);
> +	rpmsg_eptdev_free_all_skb(eptdev);
>  
>  	put_device(dev);
>  
> @@ -217,7 +256,7 @@ static ssize_t rpmsg_eptdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	if (copy_to_iter(skb->data, use, to) != use)
>  		use = -EFAULT;
>  
> -	kfree_skb(skb);
> +	rpmsg_eptdev_put_skb(eptdev, skb);
>  
>  	return use;
>  }
> @@ -370,6 +409,7 @@ static struct rpmsg_eptdev *rpmsg_chrdev_eptdev_alloc(struct rpmsg_device *rpdev
>  	mutex_init(&eptdev->ept_lock);
>  	spin_lock_init(&eptdev->queue_lock);
>  	skb_queue_head_init(&eptdev->queue);
> +	skb_queue_head_init(&eptdev->skb_pool);
>  	init_waitqueue_head(&eptdev->readq);
>  
>  	device_initialize(dev);
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index 39b646d0d40d..b30bfe01db69 100644
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

This is a limitation of the virtio rpmsg implementation, there has
been efforts to make this dynamic and/or configurable. So I don't think
it's suitable to lift this limitation out of the virtio rpmsg
implementation.

Regards,
Bjorn

> +
>  #define to_rpmsg_device(d) container_of(d, struct rpmsg_device, dev)
>  #define to_rpmsg_driver(d) container_of(d, struct rpmsg_driver, drv)
>  
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 905ac7910c98..5369669d3327 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -109,27 +109,6 @@ struct virtio_rpmsg_channel {
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
> -- 
> 2.38.1
> 
