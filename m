Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1C63BCF6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiK2JaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiK2JaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:30:04 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D315BD4A;
        Tue, 29 Nov 2022 01:30:00 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AT93kEA005080;
        Tue, 29 Nov 2022 10:29:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=juUZLexoBXbEVBXJSYevO1llAOBIzz2drV3/l3RAQsA=;
 b=b2FxWmzkNvI9ck4Zl2JpZZKkQ+Z1xPv44658SVldi285o3EkdE+/GwwzaSgJct017meO
 9p/WJD3XuaFLnLX2GoD9CAKSA2il1qyk6r/wgKJ8vecW8Ijgdz9NYYCFJW3SNpx09dVx
 0Op4zbXKYs0Ag0kTxj9EaT+ootLTFQ/aYaz5HBEoEMAr7DpBKcOkvA0IeJkFL/ndjBGo
 sb8zbPTnR7aNah+r9i9cbzfBoVl7ySXvoDzAA/pJbv6R14/0T7SASoyp46In/P/BrJLv
 PGAQaOP4yuz9DJARbnUDZjrCaAmI9eZPMcMFj5k+SIJhGne9/JM+vDF6z76i38d+h786 /g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3m3b16rnkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 10:29:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7A81310002A;
        Tue, 29 Nov 2022 10:29:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 50FED216ECA;
        Tue, 29 Nov 2022 10:29:38 +0100 (CET)
Received: from [10.211.0.250] (10.211.0.250) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 29 Nov
 2022 10:29:37 +0100
Message-ID: <71e3425b-e598-a2ff-b684-dbf2f43bfa60@foss.st.com>
Date:   Tue, 29 Nov 2022 10:29:37 +0100
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
References: <1669658575-21993-1-git-send-email-quic_sarannya@quicinc.com>
 <1669658575-21993-2-git-send-email-quic_sarannya@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <1669658575-21993-2-git-send-email-quic_sarannya@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.211.0.250]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_06,2022-11-28_02,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sarannya,

On 11/28/22 19:02, Sarannya S wrote:
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
>  drivers/rpmsg/rpmsg_core.c     | 20 ++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h |  2 ++
>  include/linux/rpmsg.h          | 15 +++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index d6dde00e..0c5bf67 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -331,6 +331,24 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>  
>  /**
> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
> + * @ept:	the rpmsg endpoint
> + * @enable:	enable or disable serial flow control
> + *
> + * Return: 0 on success and an appropriate error value on failure.
> + */
> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)

Seems that you did not take into account comment in your V3 asking you to
add the destination address of the endpoint as parameter

Regards,
Arnaud

> +{
> +	if (WARN_ON(!ept))
> +		return -EINVAL;
> +	if (!ept->ops->set_flow_control)
> +		return -ENXIO;
> +
> +	return ept->ops->set_flow_control(ept, enable);
> +}
> +EXPORT_SYMBOL(rpmsg_set_flow_control);
> +
> +/**
>   * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
>   * @ept: the rpmsg endpoint
>   *
> @@ -539,6 +557,8 @@ static int rpmsg_dev_probe(struct device *dev)
>  
>  		rpdev->ept = ept;
>  		rpdev->src = ept->addr;
> +
> +		ept->flow_cb = rpdrv->flowcontrol;
>  	}
>  
>  	err = rpdrv->probe(rpdev);
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index 39b646d..4fea45a 100644
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
> +	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
>  	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
>  };
>  
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
