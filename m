Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D006192AF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiKDIZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiKDIZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:25:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDFE27167
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667550328; x=1699086328;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aWWF2zRYiG0U4XioHxSi1CuKcHaHWIjRI5Wu5vQoJW0=;
  b=QxYL7LRG2bKRTzUhlGojK/EiodByRvyX4cNKQ8hFjwQxcqYussrqhMDS
   q6vQARg/9H1lJIen8BvBMNPTkNhlzeYHY255pSceWXf50RtlIAjIxUgAT
   LPPVIg2z/L3clKEBw8CrbRKFAmWHU1pECnHMD2ueDbX5cVyJygwDaEhSH
   Np22ui/x+bcQ8wixe71SC8WtbY2+wRcgnMnNdmn90V0rra/1oDxdmaHL8
   ljL+IQnaMFzl2teCdpu63PT7lI8QleAm+L38yh0uRiQJMR79yLK0kPE5S
   qmL4wzNQQCOpvI3L0jfYJeNMLtf23R0LP8GjksS15GRW2TYkTWUPWvMZn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="309903833"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="309903833"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 01:25:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="635011083"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="635011083"
Received: from mlmesa-mobl2.ger.corp.intel.com (HELO [10.213.192.110]) ([10.213.192.110])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 01:25:24 -0700
Message-ID: <27f9ac82-dba9-0122-707b-c21d4c606580@linux.intel.com>
Date:   Fri, 4 Nov 2022 08:25:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] mei: add timeout to send
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221103155534.1966589-1-alexander.usyskin@intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20221103155534.1966589-1-alexander.usyskin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Not really driver I looked at before but since you copied me some 
comments below.

On 03/11/2022 15:55, Alexander Usyskin wrote:
> When driver wakes up the firmware from the low power stand,
> it is sending a memory ready message.
> The send is done via synchronous/blocking function to ensure
> that firmware is in ready state. However firmware might be
> in unstable state and send might be block forever.
> To address this issue a timeout is added to blocking write command on
> the internal bus.

It would be preferrable to consistently wrap at 75 as per kernel coding 
style so it looks tidy.

> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>   drivers/misc/mei/bus-fixup.c | 19 +++++++++++--------
>   drivers/misc/mei/bus.c       |  9 +++++----
>   drivers/misc/mei/client.c    | 21 +++++++++++++++++----
>   drivers/misc/mei/client.h    |  2 +-
>   drivers/misc/mei/main.c      |  2 +-
>   drivers/misc/mei/mei_dev.h   |  2 +-
>   6 files changed, 36 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
> index 71fbf0bc8453..3174cad8a5cc 100644
> --- a/drivers/misc/mei/bus-fixup.c
> +++ b/drivers/misc/mei/bus-fixup.c
> @@ -128,7 +128,7 @@ static int mei_osver(struct mei_cl_device *cldev)
>   	os_ver = (struct mei_os_ver *)fwcaps->data;
>   	os_ver->os_type = OSTYPE_LINUX;
>   
> -	return __mei_cl_send(cldev->cl, buf, size, 0, mode);
> +	return __mei_cl_send(cldev->cl, buf, size, 0, mode, 0);
>   }
>   
>   #define MKHI_FWVER_BUF_LEN (sizeof(struct mkhi_msg_hdr) + \
> @@ -149,7 +149,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
>   	req.hdr.command = MKHI_GEN_GET_FW_VERSION_CMD;
>   
>   	ret = __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0,
> -			    MEI_CL_IO_TX_BLOCKING);
> +			    MEI_CL_IO_TX_BLOCKING, 0);
>   	if (ret < 0) {
>   		dev_err(&cldev->dev, "Could not send ReqFWVersion cmd\n");
>   		return ret;
> @@ -188,17 +188,19 @@ static int mei_fwver(struct mei_cl_device *cldev)
>   	return ret;
>   }
>   
> +#define GFX_MEMORY_READY_TIMEOUT 200
> +
>   static int mei_gfx_memory_ready(struct mei_cl_device *cldev)
>   {
>   	struct mkhi_gfx_mem_ready req = {0};
> -	unsigned int mode = MEI_CL_IO_TX_INTERNAL;
> +	unsigned int mode = MEI_CL_IO_TX_INTERNAL | MEI_CL_IO_TX_BLOCKING;
>   
>   	req.hdr.group_id = MKHI_GROUP_ID_GFX;
>   	req.hdr.command = MKHI_GFX_MEMORY_READY_CMD_REQ;
>   	req.flags = MKHI_GFX_MEM_READY_PXP_ALLOWED;
>   
>   	dev_dbg(&cldev->dev, "Sending memory ready command\n");
> -	return __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0, mode);
> +	return __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0, mode, GFX_MEMORY_READY_TIMEOUT);
>   }
>   
>   static void mei_mkhi_fix(struct mei_cl_device *cldev)
> @@ -263,12 +265,13 @@ static void mei_gsc_mkhi_fix_ver(struct mei_cl_device *cldev)
>   
>   	if (cldev->bus->pxp_mode == MEI_DEV_PXP_INIT) {
>   		ret = mei_gfx_memory_ready(cldev);
> -		if (ret < 0)
> +		if (ret < 0) {
>   			dev_err(&cldev->dev, "memory ready command failed %d\n", ret);
> -		else
> +		} else {
>   			dev_dbg(&cldev->dev, "memory ready command sent\n");
> +			cldev->bus->pxp_mode = MEI_DEV_PXP_SETUP;
> +		}
>   		/* we go to reset after that */
> -		cldev->bus->pxp_mode = MEI_DEV_PXP_SETUP;
>   		goto out;
>   	}
>   
> @@ -374,7 +377,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
>   	WARN_ON(mutex_is_locked(&bus->device_lock));
>   
>   	ret = __mei_cl_send(cl, (u8 *)&cmd, sizeof(cmd), 0,
> -			    MEI_CL_IO_TX_BLOCKING);
> +			    MEI_CL_IO_TX_BLOCKING, 0);
>   	if (ret < 0) {
>   		dev_err(bus->dev, "Could not send IF version cmd\n");
>   		return ret;
> diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
> index 1fbe127ff633..136b45192904 100644
> --- a/drivers/misc/mei/bus.c
> +++ b/drivers/misc/mei/bus.c
> @@ -29,11 +29,12 @@
>    * @length: buffer length
>    * @vtag: virtual tag
>    * @mode: sending mode
> + * @timeout: send timeout for blocking writes, 0 for infinite timeout
>    *
>    * Return: written size bytes or < 0 on error
>    */
>   ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
> -		      unsigned int mode)
> +		      unsigned int mode, unsigned long timeout)
>   {
>   	struct mei_device *bus;
>   	struct mei_cl_cb *cb;
> @@ -108,7 +109,7 @@ ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
>   		cb->buf.size = 0;
>   	}
>   
> -	rets = mei_cl_write(cl, cb);
> +	rets = mei_cl_write(cl, cb, timeout);
>   
>   	if (mode & MEI_CL_IO_SGL && rets == 0)
>   		rets = length;
> @@ -254,7 +255,7 @@ ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, const u8 *buf,
>   {
>   	struct mei_cl *cl = cldev->cl;
>   
> -	return __mei_cl_send(cl, buf, length, vtag, MEI_CL_IO_TX_BLOCKING);
> +	return __mei_cl_send(cl, buf, length, vtag, MEI_CL_IO_TX_BLOCKING, 0);
>   }
>   EXPORT_SYMBOL_GPL(mei_cldev_send_vtag);
>   
> @@ -924,7 +925,7 @@ ssize_t mei_cldev_send_gsc_command(struct mei_cl_device *cldev,
>   	}
>   
>   	/* send the message to GSC */
> -	ret = __mei_cl_send(cl, (u8 *)ext_hdr, buf_sz, 0, MEI_CL_IO_SGL);
> +	ret = __mei_cl_send(cl, (u8 *)ext_hdr, buf_sz, 0, MEI_CL_IO_SGL, 0);
>   	if (ret < 0) {
>   		dev_err(bus->dev, "__mei_cl_send failed, returned %zd\n", ret);
>   		goto end;
> diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
> index 6c8b71ae32c8..68f2e23b8ae5 100644
> --- a/drivers/misc/mei/client.c
> +++ b/drivers/misc/mei/client.c
> @@ -1954,10 +1954,11 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
>    *
>    * @cl: host client
>    * @cb: write callback with filled data
> + * @timeout: send timeout for blocking writes, 0 for infinite timeout
>    *
>    * Return: number of bytes sent on success, <0 on failure.
>    */
> -ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
> +ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long timeout)
>   {
>   	struct mei_device *dev;
>   	struct mei_msg_data *buf;
> @@ -2081,9 +2082,21 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
>   	if (blocking && cl->writing_state != MEI_WRITE_COMPLETE) {
>   
>   		mutex_unlock(&dev->device_lock);
> -		rets = wait_event_interruptible(cl->tx_wait,
> -				cl->writing_state == MEI_WRITE_COMPLETE ||
> -				(!mei_cl_is_connected(cl)));
> +		if (timeout) {
> +			rets = wait_event_interruptible_timeout(cl->tx_wait,
> +					cl->writing_state == MEI_WRITE_COMPLETE ||
> +					(!mei_cl_is_connected(cl)),
> +					msecs_to_jiffies(timeout));
> +			if (rets == 0)
> +				rets = -ETIME;
> +			if (rets > 0)
> +				rets = 0;
> +		} else {
> +			rets = wait_event_interruptible(cl->tx_wait,
> +					cl->writing_state == MEI_WRITE_COMPLETE ||
> +					(!mei_cl_is_connected(cl)));
> +		}

Usual pattern to avoid the need to duplicate the branches is to either 
replace 0 with MAX_SCHEDULE_TIMEOUT in this function, or make callers 
pass that value explicitly in, and so only have the 
wait_event_interruptible_timeout branch.

Or if you would like to make the patch even smaller (avoid function 
signature churn) maybe you could even add a new flag to the 'mode' 
parameter to signify a chosen timeout, in one way or another.

Regards,

Tvrtko

> +
>   		mutex_lock(&dev->device_lock);
>   		/* wait_event_interruptible returns -ERESTARTSYS */
>   		if (rets) {
> diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
> index 418056fb1489..9052860bcfe0 100644
> --- a/drivers/misc/mei/client.h
> +++ b/drivers/misc/mei/client.h
> @@ -246,7 +246,7 @@ int mei_cl_connect(struct mei_cl *cl, struct mei_me_client *me_cl,
>   int mei_cl_irq_connect(struct mei_cl *cl, struct mei_cl_cb *cb,
>   		       struct list_head *cmpl_list);
>   int mei_cl_read_start(struct mei_cl *cl, size_t length, const struct file *fp);
> -ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb);
> +ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long timeout);
>   int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
>   		     struct list_head *cmpl_list);
>   
> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
> index 930887e7e38d..311c6a34aeb8 100644
> --- a/drivers/misc/mei/main.c
> +++ b/drivers/misc/mei/main.c
> @@ -383,7 +383,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
>   		goto out;
>   	}
>   
> -	rets = mei_cl_write(cl, cb);
> +	rets = mei_cl_write(cl, cb, 0);
>   out:
>   	mutex_unlock(&dev->device_lock);
>   	return rets;
> diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
> index 8d8018428d9d..799ea95e2bb8 100644
> --- a/drivers/misc/mei/mei_dev.h
> +++ b/drivers/misc/mei/mei_dev.h
> @@ -378,7 +378,7 @@ struct mei_hw_ops {
>   void mei_cl_bus_rescan_work(struct work_struct *work);
>   void mei_cl_bus_dev_fixup(struct mei_cl_device *dev);
>   ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
> -		      unsigned int mode);
> +		      unsigned int mode, unsigned long timeout);
>   ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length, u8 *vtag,
>   		      unsigned int mode, unsigned long timeout);
>   bool mei_cl_bus_rx_event(struct mei_cl *cl);
