Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B092615A72
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiKBDbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiKBDau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCFF26123;
        Tue,  1 Nov 2022 20:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AACD61729;
        Wed,  2 Nov 2022 03:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1ECC433D6;
        Wed,  2 Nov 2022 03:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667359847;
        bh=wry1LO7EncSvzT2po4Kz5Wxy+/zg1TudxF1J/nm2d6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbcIKR2/8scZmlVdjFaDkU+UKhS1FT5Ic7H87S236JLzuiR97+tHbGEdVYOvA4AkM
         /fRtRyHmt+87IZQ3H+KzaA2bbIJHeisUA2fKUEh6ZLAO+0WCs7t+JpTojrXQ69JCHG
         PJaUdOZqamGBMkjWVPX4fGELd4aOj71dUzdsJuOonSQrE4Nyk/+zhSB0ZpvotowZ+q
         TLFLDabVRI99h9EuCD7s6Tr4Ttrvu7HU4RXxQnt5UDYqSyc0TMTpeoH+WwF1qlqeTQ
         YO6ZnHesnt2M598su5kt86FAfWCW/zzuc8rHhJWliYDyQm+YU1pXQPYXKTEn2zVAUZ
         w7jMuT0/eR46g==
Date:   Tue, 1 Nov 2022 22:30:45 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>
Cc:     bjorn.andersson@linaro.org, arnaud.pouliquen@foss.st.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH V3 3/3] rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
Message-ID: <20221102033045.awxn5zlafdkatmta@builder.lan>
References: <1663133102-10671-1-git-send-email-quic_deesin@quicinc.com>
 <1663133102-10671-4-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663133102-10671-4-git-send-email-quic_deesin@quicinc.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 10:55:02AM +0530, Deepak Kumar Singh wrote:
> Add TICOMGET and TIOCMSET ioctl support for rpmsg char device nodes
> to get/set the low level transport signals.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 60 +++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 4f21891..1eb6e9d 100644
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
> +	u32 rsigs;

Please spell out remote_signals, or something like that.

> +	bool sig_pending;

signals_pending


And please update the kernel-doc.

>  };
>  
>  int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
> @@ -107,7 +110,22 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>  	skb_queue_tail(&eptdev->queue, skb);
>  	spin_unlock(&eptdev->queue_lock);
>  
> -	/* wake up any blocking processes, waiting for new data */
> +	wake_up_interruptible(&eptdev->readq);
> +
> +	return 0;
> +}
> +
> +static int rpmsg_flow_cb(struct rpmsg_device *rpdev, void *priv, bool enable)

Please add "ept" to the function name.

Regards,
Bjorn

> +{
> +	struct rpmsg_eptdev *eptdev = priv;
> +
> +	if (enable)
> +		eptdev->rsigs = TIOCM_DSR | TIOCM_CTS;
> +	else
> +		eptdev->rsigs = 0;
> +	
> +	eptdev->sig_pending = true;
> +
>  	wake_up_interruptible(&eptdev->readq);
>  
>  	return 0;
> @@ -144,6 +162,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  		return -EINVAL;
>  	}
>  
> +	ept->flow_cb = rpmsg_flow_cb;
>  	eptdev->ept = ept;
>  	filp->private_data = eptdev;
>  	mutex_unlock(&eptdev->ept_lock);
> @@ -164,6 +183,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
>  		eptdev->ept = NULL;
>  	}
>  	mutex_unlock(&eptdev->ept_lock);
> +	eptdev->sig_pending = false;
>  
>  	/* Discard all SKBs */
>  	skb_queue_purge(&eptdev->queue);
> @@ -277,6 +297,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
>  	if (!skb_queue_empty(&eptdev->queue))
>  		mask |= EPOLLIN | EPOLLRDNORM;
>  
> +	if (eptdev->sig_pending)
> +		mask |= EPOLLPRI;
> +
>  	mask |= rpmsg_poll(eptdev->ept, filp, wait);
>  
>  	return mask;
> @@ -287,14 +310,35 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
>  {
>  	struct rpmsg_eptdev *eptdev = fp->private_data;
>  
> -	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
> -		return -EINVAL;
> -
> -	/* Don't allow to destroy a default endpoint. */
> -	if (eptdev->default_ept)
> -		return -EINVAL;
> +	bool set;
> +	u32 val;
> +	int ret;
> +	
> +	switch (cmd) {
> +	case TIOCMGET:
> +		eptdev->sig_pending = false;
> +		ret = put_user(eptdev->rsigs, (int __user *)arg);
> +		break;
> +	case TIOCMSET:
> +		ret = get_user(val, (int __user *)arg);
> +		if (ret)
> +			break;
> +		set = (val & (TIOCM_DTR | TIOCM_RTS)) ? true : false;
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
> -- 
> 2.7.4
> 
