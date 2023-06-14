Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230E47303FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244314AbjFNPiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjFNPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F123A123;
        Wed, 14 Jun 2023 08:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85D9B643DA;
        Wed, 14 Jun 2023 15:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD32C433C8;
        Wed, 14 Jun 2023 15:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686757097;
        bh=xPsZfZMXejY7kb0kn7Ws5xGYfQGwc+dwRrlGM9Khnfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YccOMKqouS1zlk/hKjfl6CkEmKWbWGOTqiEYcijXCM5QzpGjxk971Lrv47HQnUXQ8
         4fQtS3iJ/gL9acmbIDF/LWD1ebHDF/Sr7zDXkcIWtkh4tIUrZFbI2XWgJdQrbHtsHY
         huN/R4w6XQmiN+pzmSEI4TVMyuVCXnwZQcvBM1HEW7xisH8ewgZ4VvaLTMGYr1RuLF
         NmfG7mmyLcoZX5zeubDq2/MMUq61u3JXbXaW7J2b65dnAUJCGuuvWArfVSgxyxzkP0
         oJ7buPnAn1vyO0/8Ikmcw2of2RcfAlYVGTeS9Qv6RqEMcH+m/wmgzHrro4pTQYmZX1
         c8SNQX4GlupSA==
Date:   Wed, 14 Jun 2023 08:41:40 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sarannya S <quic_sarannya@quicinc.com>
Cc:     quic_bjorande@quicinc.com, arnaud.pouliquen@foss.st.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: Re: [PATCH V7 3/3] rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL
 support
Message-ID: <20230614154140.4ebqtkaccha2rmqp@ripper>
References: <1682160127-18103-1-git-send-email-quic_sarannya@quicinc.com>
 <1682160127-18103-4-git-send-email-quic_sarannya@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682160127-18103-4-git-send-email-quic_sarannya@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 04:12:07PM +0530, Sarannya S wrote:
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
>  #include <linux/uaccess.h>
>  #include <uapi/linux/rpmsg.h>
>  
> @@ -68,6 +69,8 @@ struct rpmsg_eptdev {
>  	struct sk_buff_head queue;
>  	wait_queue_head_t readq;
>  
> +	bool remote_flow;

I was about to agree with Arnaud, that this needs to be defaulted to
true. But the flag means "has the remote asked for flow to be limited".

As such, the name of this variable is misleading. Please rename it
"remote_flow_restricted" or something like that.

And please update the kerneldoc for this struct.

Regards,
Bjorn

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
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
