Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABB37083D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjEROSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjEROSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED305C1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8067361450
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B62C433EF;
        Thu, 18 May 2023 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684419514;
        bh=iWDdKnmjocdvHCNiTsa1fW7ngWcP357j0OZ2zcoz0pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SK0i2xBIUnt3AMnH7oo3goI1inz5U6aC3oRDchzPWX5OFyVMop8fxMc1wLmRLa1F5
         43/DtDzuHgeEFi9WxJPn/4TxauZVwQDXOrdVHSneVfoPD8QfdLi7N5UWUOC5es+W16
         MZ5cjH9ICj6yjihrMOVcQ/bNcfKx5SPviWbkOB5bH38e925Ti0dPVzQFu9xuf/AUKB
         Khb/EGOnWQAPODxoYQoMQSjFVOuUrL1YrUHcLSiDpWobnPVIWND1f1nY/2XCgzjq1c
         LlhOl+1iff3ukd1hrXWDf8z62CQCjv2gD1yF7BfNRadS0Go3NLoJQHTBFMzhAzLi07
         5bryCoGBt4kVw==
Date:   Thu, 18 May 2023 16:18:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [RFC PATCH 5/8] vhost: Add callback that stops new work and
 waits on running ones
Message-ID: <20230518-lokomotive-aufziehen-dbc432136b76@brauner>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-6-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518000920.191583-6-michael.christie@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 07:09:17PM -0500, Mike Christie wrote:
> When the vhost_task gets a SIGKILL we want to stop new work from being
> queued and also wait for and handle completions for running work. For the
> latter, we still need to use the vhost_task to handle the completing work
> so we can't just exit right away. But, this has us kick off the stopping
> and flushing/stopping of the device/vhost_task/worker to the system work
> queue while the vhost_task handles completions. When all completions are
> done we will then do vhost_task_stop and we will exit.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/net.c   |  2 +-
>  drivers/vhost/scsi.c  |  4 ++--
>  drivers/vhost/test.c  |  3 ++-
>  drivers/vhost/vdpa.c  |  2 +-
>  drivers/vhost/vhost.c | 48 ++++++++++++++++++++++++++++++++++++-------
>  drivers/vhost/vhost.h | 10 ++++++++-
>  drivers/vhost/vsock.c |  4 ++--
>  7 files changed, 58 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 8557072ff05e..90c25127b3f8 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1409,7 +1409,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>  	vhost_dev_init(dev, vqs, VHOST_NET_VQ_MAX,
>  		       UIO_MAXIOV + VHOST_NET_BATCH,
>  		       VHOST_NET_PKT_WEIGHT, VHOST_NET_WEIGHT, true,
> -		       NULL);
> +		       NULL, NULL);
>  
>  	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev);
>  	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev);
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index bb10fa4bb4f6..40f9135e1a62 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -1820,8 +1820,8 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>  		vqs[i] = &vs->vqs[i].vq;
>  		vs->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
>  	}
> -	vhost_dev_init(&vs->dev, vqs, nvqs, UIO_MAXIOV,
> -		       VHOST_SCSI_WEIGHT, 0, true, NULL);
> +	vhost_dev_init(&vs->dev, vqs, nvqs, UIO_MAXIOV, VHOST_SCSI_WEIGHT, 0,
> +		       true, NULL, NULL);
>  
>  	vhost_scsi_init_inflight(vs, NULL);
>  
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index 42c955a5b211..11a2823d7532 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -120,7 +120,8 @@ static int vhost_test_open(struct inode *inode, struct file *f)
>  	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
>  	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
>  	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
> -		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, true, NULL);
> +		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, true, NULL,
> +		       NULL);
>  
>  	f->private_data = n;
>  
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 8c1aefc865f0..de9a83ecb70d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1279,7 +1279,7 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>  		vqs[i]->handle_kick = handle_vq_kick;
>  	}
>  	vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
> -		       vhost_vdpa_process_iotlb_msg);
> +		       vhost_vdpa_process_iotlb_msg, NULL);
>  
>  	r = vhost_vdpa_alloc_domain(v);
>  	if (r)
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 1ba9e068b2ab..4163c86db50c 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -336,6 +336,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>  static int vhost_worker(void *data)
>  {
>  	struct vhost_worker *worker = data;
> +	struct vhost_dev *dev = worker->dev;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
>  
> @@ -352,12 +353,13 @@ static int vhost_worker(void *data)
>  		if (!node) {
>  			schedule();
>  			/*
> -			 * When we get a SIGKILL our release function will
> -			 * be called. That will stop new IOs from being queued
> -			 * and check for outstanding cmd responses. It will then
> -			 * call vhost_task_stop to exit us.
> +			 * When we get a SIGKILL we kick off a work to
> +			 * run the driver's helper to stop new work and
> +			 * handle completions. When they are done they will
> +			 * call vhost_task_stop to tell us to exit.
>  			 */
> -			vhost_task_get_signal();
> +			if (vhost_task_get_signal())
> +				schedule_work(&dev->destroy_worker);
>  		}

I'm pretty sure you still need to actually call exit here. Basically
mirror what's done in io_worker_exit() minus the io specific bits.
