Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9398656CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 16:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiL0P4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 10:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiL0P4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:56:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F25FD2;
        Tue, 27 Dec 2022 07:56:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 242FE6112E;
        Tue, 27 Dec 2022 15:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AE0C433D2;
        Tue, 27 Dec 2022 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672156604;
        bh=wqjY19wRr/xNUIMp85k8D04KIz0alYuTXsWEsXk96tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJ4QYJN/OlQlIGU36gpeEXHV2TN+aGlJNrpo3JcqcfiWgc+pSS7l6GF7jE2Txc2He
         E6V822P+Ec8G2GWzPgnAdtFORv2QICedTy+d1OQng2SnHmU7xOX9wql5eH19bUH5Vm
         ZHQI0mBkNWOm/91iLHVaz+xYCzAngeb5QjYIKMVEM6gpyjxXMjd8l8hn0pX/gu31X9
         HIZNvGbjqBmmRf62bHdhkkflJh1k3cb/JkR1ZZYG3szA+DMvY6lSYBR406aTQivlbL
         ksCDp5SkumahAgVDqC6WlJlSEqJ8rXhQarAm7Cgexu3Y5RSRKLTtEW9tzbgfNqKVIP
         XqJcndiWvt4Mw==
Date:   Tue, 27 Dec 2022 09:56:41 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Sarannya S <quic_sarannya@quicinc.com>, quic_bjorande@quicinc.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: Re: [PATCH V4 3/3] rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
Message-ID: <20221227155641.xlkel7uhk7jr4qru@builder.lan>
References: <1670418258-11502-1-git-send-email-quic_sarannya@quicinc.com>
 <1670418258-11502-4-git-send-email-quic_sarannya@quicinc.com>
 <12f53ff1-a358-7129-c9ed-9b9fd7dad7e7@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12f53ff1-a358-7129-c9ed-9b9fd7dad7e7@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 05:28:16PM +0100, Arnaud POULIQUEN wrote:
> 
> 
> On 12/7/22 14:04, Sarannya S wrote:
> > Add TICOMGET and TIOCMSET ioctl support for rpmsg char device nodes
> > to get/set the low level transport signals.
> > 
> > Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> > Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> > Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
> > ---
> >  drivers/rpmsg/rpmsg_char.c | 60 +++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 52 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> > index 3e0b8f3..8109d18 100644
> > --- a/drivers/rpmsg/rpmsg_char.c
> > +++ b/drivers/rpmsg/rpmsg_char.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/rpmsg.h>
> >  #include <linux/skbuff.h>
> >  #include <linux/slab.h>
> > +#include <linux/termios.h>
> >  #include <linux/uaccess.h>
> >  #include <uapi/linux/rpmsg.h>
> >  
> > @@ -68,6 +69,8 @@ struct rpmsg_eptdev {
> >  	struct sk_buff_head queue;
> >  	wait_queue_head_t readq;
> >  
> > +	u32 remote_signals;
> > +	bool signals_pending;
> 
> Could you detail the need/use of signals_pending, in your implementation?
> This is not obvious (at least for me)...
> 

I agree. With the move to use the concept of flow control in the rpmsg
API, there's no longer any "signals" in this client driver.

> >  };
> >  
> >  int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
> > @@ -109,7 +112,22 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
> >  	skb_queue_tail(&eptdev->queue, skb);
> >  	spin_unlock(&eptdev->queue_lock);
> >  
> > -	/* wake up any blocking processes, waiting for new data */
> > +	wake_up_interruptible(&eptdev->readq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rpmsg_ept_flow_cb(struct rpmsg_device *rpdev, void *priv, bool enable)
> > +{
> > +	struct rpmsg_eptdev *eptdev = priv;
> > +
> > +	if (enable)
> > +		eptdev->remote_signals = TIOCM_DSR | TIOCM_CTS;
> > +	else
> > +		eptdev->remote_signals = 0;
> > +
> > +	eptdev->signals_pending = true;
> > +
> >  	wake_up_interruptible(&eptdev->readq);
> >  
> >  	return 0;
> > @@ -146,6 +164,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
> >  		return -EINVAL;
> >  	}
> >  
> > +	ept->flow_cb = rpmsg_ept_flow_cb;
> >  	eptdev->ept = ept;
> >  	filp->private_data = eptdev;
> >  	mutex_unlock(&eptdev->ept_lock);
> > @@ -166,6 +185,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
> >  		eptdev->ept = NULL;
> >  	}
> >  	mutex_unlock(&eptdev->ept_lock);
> > +	eptdev->signals_pending = false;
> >  
> >  	/* Discard all SKBs */
> >  	skb_queue_purge(&eptdev->queue);
> > @@ -279,6 +299,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
> >  	if (!skb_queue_empty(&eptdev->queue))
> >  		mask |= EPOLLIN | EPOLLRDNORM;
> >  
> > +	if (eptdev->signals_pending)
> > +		mask |= EPOLLPRI;
> > +
> >  	mask |= rpmsg_poll(eptdev->ept, filp, wait);
> >  
> >  	return mask;
> > @@ -289,14 +312,35 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
> >  {
> >  	struct rpmsg_eptdev *eptdev = fp->private_data;
> >  
> > -	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
> > -		return -EINVAL;
> > -
> > -	/* Don't allow to destroy a default endpoint. */
> > -	if (eptdev->default_ept)
> > -		return -EINVAL;
> > +	bool set;
> > +	u32 val;
> > +	int ret;
> > +	
> > +	switch (cmd) {
> > +	case TIOCMGET:
> > +		eptdev->signals_pending = false;
> > +		ret = put_user(eptdev->remote_signals, (int __user *)arg);
> > +		break;
> > +	case TIOCMSET:
> > +		ret = get_user(val, (int __user *)arg);
> > +		if (ret)
> > +			break;
> > +		set = (val & (TIOCM_DTR | TIOCM_RTS)) ? true : false;
> > +		ret = rpmsg_set_flow_control(eptdev->ept, set, 0);
> > +		break;
> 
> I still wonder if it makes sense to implement serial IOCTRL in rpmsg_char.

I've thinking about this since v1 as well...

> I think it is quite dangerous to have such kind of mixed interface.
> User application would want to use the serial interface should use the tty
> interface.
> 

Can you please elaborate on this statement, because I have a hard time
to state why the user space application must use the tty interface
instead of rpmsg_char.

And in particular, I don't think this is a question for the "user
application", but rather for the system configuration.

In order to move an application that works with rpmsg_char to the tty
driver ("because it's the right thing to do..."?) means that the system
needs to be reconfigured, such that the given rpmsg channel is exposed
through the tty driver instead.

This in turn either implies that the firmware needs to be changed to
expose these channels with the name "rpmsg-tty" - and the application
taught how to figure out which ttyRPMSGn to open - or the rpmsg_ctrl
interface needs to be extended to allow the Linux side to request a
particular channel to be exposed as rpmsg_char vs rpmsg-tty...

> For the rpmsg char, I would be in favor of creating a specific RPMSG IOCTRLs
> to avoid confusion.
> 
> For instance:
> 
>  - RPMSG_GET_SIGN_IOCTRL
>  - RPMSG_SET_SIGN_IOCTRL
> 

Again, we're talking "flow control" at this level. So either we follow
the standard IOCTL and make it easy for existing applications to use
rpmsg_char, or we provide a _good_ explanation why they must use the
tty interface instead (and if so solve above mentioned problems).

Regards,
Bjorn

> With associated parameter corresponding to the bitmap proposed in my comment of
> your patch 1/4.
> 
> Of course, this is only a suggestion, I let Bjorn and Mathieu comment.
> 
> Regards,
> Arnaud
> 
> 
> > +	case RPMSG_DESTROY_EPT_IOCTL:
> > +		/* Don't allow to destroy a default endpoint. */
> > +		if (eptdev->default_ept) {
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		ret = rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> >  
> > -	return rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
> > +	return ret;
> >  }
> >  
> >  static const struct file_operations rpmsg_eptdev_fops = {
