Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4666533D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiLUQMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUQMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:12:49 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0C7220CE;
        Wed, 21 Dec 2022 08:12:47 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLDfa2x026028;
        Wed, 21 Dec 2022 17:12:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=2A2tAKvy9GQzqXbZsSHur6UK/zxVtWe4DXFResJLMYk=;
 b=GRQS9PaT3+2E9Wb8iorc8gCzaElYyJ2JBOk2ChRo7hNfR73pIlNZMQaVuaJrPuatPdcC
 eDFky9ABYCCLuZTiy96V55sWnp9ZEv2fJPEc7nqJCZXU7daLJy+ucgBqF+PYSylx7KO4
 RnwZPFo6dcLvljDc7XhfnuQC9VOMAmpMsEnkf/gIt+B/SCdeNSWhHwhue84SyqBS1HT0
 icdRbKUuIhNv50L3Dg4vnHJkEoNBQNzOZbxDHTwdyPP+45Sr2IqZxE8IZ8RnttaHXyyB
 HG+UeLxr/cDO06sC8JcO+t+V4xuD0+XZU+WGyXLZvoblyzET08NbBJpmdmmvigfw7LCh eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mh605qrnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 17:12:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 045AA10002A;
        Wed, 21 Dec 2022 17:12:25 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F1EE32291B5;
        Wed, 21 Dec 2022 17:12:24 +0100 (CET)
Received: from [10.201.20.73] (10.201.20.73) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 21 Dec
 2022 17:12:23 +0100
Message-ID: <6ba10328-bc48-c953-49e7-29e079fb6406@foss.st.com>
Date:   Wed, 21 Dec 2022 17:12:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V4 1/3] rpmsg: core: Add signal API support
Content-Language: en-US
To:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <1670418258-11502-1-git-send-email-quic_sarannya@quicinc.com>
 <1670418258-11502-2-git-send-email-quic_sarannya@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <1670418258-11502-2-git-send-email-quic_sarannya@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.73]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_08,2022-12-21_01,2022-06-22_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 12/7/22 14:04, Sarannya S wrote:
> Some transports like Glink support the state notifications between
> clients using flow control signals similar to serial protocol signals.
> Local glink client drivers can send and receive flow control status
> to glink clients running on remote processors.
> 
> Add APIs to support sending and receiving of flow control status by
> rpmsg clients.
> 
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h |  2 ++
>  include/linux/rpmsg.h          | 15 +++++++++++++++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index d6dde00e..77aeba0 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -331,6 +331,25 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>  
>  /**
> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
> + * @ept:	the rpmsg endpoint
> + * @enable:	enable or disable serial flow control

What does it mean "enable and disable serial flow control"?
Do you speak about the flow control feature or the data flow itself?

I guess it is the activation/deactivation of the data stream
regarding Bjorn's comment in V1:

"I therefore asked Deepak to change it so the rpmsg api would contain a
single "pause incoming data"/"resume incoming data" - given that this is
a wish that we've seen in a number of discussions."

For me this is the software flow control:
https://en.wikipedia.org/wiki/Software_flow_control

I would suggest not limiting the control only to activation/deactivation but to
offer more flexibility in terms of services. replace the boolean by a bitmap
would allow to extend it later.

For instance by introducing 2 definitions:

/* RPMSG pause transmission request:
 * sent to the remote endpoint to request to suspend its transmission */
 */
#define RPMSG_FC_PT_REQ  (1 << 0)

/* RPMSG resume transmission request
 * sent to the remote endpoint to allow to resume its transmission
 */
#define RPMSG_FC_RT_REQ  (1 << 1)

Then we could add (in a next step) some other flow controls such as
/* RPMSG pause transmission information
 * Sent to the remote endpoint to inform that no more data will be sent
 * until the reception of RPMSG_FC_RT_INFO
 */
#define RPMSG_FC_PT_INFO  (1 << 16)
#define RPMSG_FC_RT_INFO  (1 << 16)

> + * @dst:	destination address of the endpoint

Thanks to have integrated this in your patch!

Regards,
Arnaud

> + *
> + * Return: 0 on success and an appropriate error value on failure.
> + */
> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
> +{
> +	if (WARN_ON(!ept))
> +		return -EINVAL;
> +	if (!ept->ops->set_flow_control)
> +		return -ENXIO;
> +
> +	return ept->ops->set_flow_control(ept, enable, dst);
> +}
> +EXPORT_SYMBOL(rpmsg_set_flow_control);
> +
> +/**
>   * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
>   * @ept: the rpmsg endpoint
>   *
> @@ -539,6 +558,8 @@ static int rpmsg_dev_probe(struct device *dev)
>  
>  		rpdev->ept = ept;
>  		rpdev->src = ept->addr;
> +
> +		ept->flow_cb = rpdrv->flowcontrol;
>  	}
>  
>  	err = rpdrv->probe(rpdev);
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index 39b646d..b6efd3e 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -55,6 +55,7 @@ struct rpmsg_device_ops {
>   * @trysendto:		see @rpmsg_trysendto(), optional
>   * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
>   * @poll:		see @rpmsg_poll(), optional
> + * @set_flow_control:	see @rpmsg_set_flow_control(), optional
>   * @get_mtu:		see @rpmsg_get_mtu(), optional
>   *
>   * Indirection table for the operations that a rpmsg backend should implement.
> @@ -75,6 +76,7 @@ struct rpmsg_endpoint_ops {
>  			     void *data, int len);
>  	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>  			     poll_table *wait);
> +	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable, u32 dst);
>  	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
>  };
>  
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 523c98b..a0e9d38 100644
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
> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst);
> +
>  #else
>  
>  static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
> @@ -316,6 +323,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>  	return -ENXIO;
>  }
>  
> +static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
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
