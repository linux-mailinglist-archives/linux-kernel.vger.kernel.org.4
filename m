Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D117312F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbjFOJCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244919AbjFOJCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:02:24 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8BC1FE8;
        Thu, 15 Jun 2023 02:01:57 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8g2YS015951;
        Thu, 15 Jun 2023 11:01:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=pqiCXSLZ1RL5vatrFS4Cqc83+XPXM5U7w5lYt7qY428=;
 b=A4GVvmoNKOHapztWkvf9S9U4K7iP78geyDBA+yZTKNiEGDSIDUuWI30Qnd+RJiRDPd+g
 q+Wkcg2kpEU+vnI1d+wGnJUuwdqRT/e67jEMWoMmv2yEjiBzQrCdlba3BuONvGqb1XTj
 XNKm836e1uG0x3XagMnRsVJkZfMTrUDcQfD4k+LnUIvok322+U4o1VSuC2/6P2znRBLB
 dBCdYh9d2WMw7kEkT/PGFT7sUFgZKp4WIsilAB0zYnpayX9nBwEkx7r6Y84vt5U5IRIW
 zNIfhBgPdwBE+xub2X1EkestfkON2L/onk6kv/YsDJeZyFnkYIV7IgLnpBea0LoaQwwq Sg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7wgx19mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:01:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7556E100062;
        Thu, 15 Jun 2023 11:01:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6CF7D2194D3;
        Thu, 15 Jun 2023 11:01:16 +0200 (CEST)
Received: from [10.201.21.9] (10.201.21.9) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 11:01:15 +0200
Message-ID: <6e51d6d8-cd3a-b0f2-c044-6282749aae89@foss.st.com>
Date:   Thu, 15 Jun 2023 11:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V7 1/3] rpmsg: core: Add signal API support
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Sarannya S <quic_sarannya@quicinc.com>
CC:     <quic_bjorande@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
References: <1682160127-18103-1-git-send-email-quic_sarannya@quicinc.com>
 <1682160127-18103-2-git-send-email-quic_sarannya@quicinc.com>
 <20230614155453.dywcrntfjddxojfv@ripper>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20230614155453.dywcrntfjddxojfv@ripper>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.9]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_05,2023-06-14_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/23 17:54, Bjorn Andersson wrote:
> On Sat, Apr 22, 2023 at 04:12:05PM +0530, Sarannya S wrote:
>> From: Deepak Kumar Singh <quic_deesin@quicinc.com>
>>
>> Some transports like Glink support the state notifications between
>> clients using flow control signals similar to serial protocol signals.
>> Local glink client drivers can send and receive flow control status
>> to glink clients running on remote processors.
>>
>> Add APIs to support sending and receiving of flow control status by
>> rpmsg clients.
>>
>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
>> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
>> ---
>>  drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
>>  drivers/rpmsg/rpmsg_internal.h |  2 ++
>>  include/linux/rpmsg.h          | 15 +++++++++++++++
>>  3 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>> index a2207c0..e8bbe05 100644
>> --- a/drivers/rpmsg/rpmsg_core.c
>> +++ b/drivers/rpmsg/rpmsg_core.c
>> @@ -331,6 +331,25 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>>  
>>  /**
>> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
>> + * @ept:	the rpmsg endpoint
>> + * @enable:	pause/resume incoming data flow	
> 
> As shown in the discussion, it's still not clear what true/false means.
> Also, let's try to clarify that it's a request for the other side to do
> something:
> 
> * rpmsg_set_flow_control() - request remote to pause/resume transmission
> * ...
> * @enable: flow restricted
> * ...
> 
> 
> PS. There's a stray space at the end of the line.

The notion of flow restricted seems to me also ambiguous. It does
not specify if the stream is limited in term of bandwidth or stopped.

What about using XON/XOFF as specified in software flow control[1]

XOFF	Pause transmission
XON	Resume transmission

or simply pause/resume definitions

[1]https://en.wikipedia.org/wiki/Software_flow_control

Regards,
Arnaud

> 
>> + * @dst:	destination address of the endpoint
>> + *
>> + * Return: 0 on success and an appropriate error value on failure.
>> + */
>> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
>> +{
>> +	if (WARN_ON(!ept))
>> +		return -EINVAL;
>> +	if (!ept->ops->set_flow_control)
>> +		return -ENXIO;
>> +
>> +	return ept->ops->set_flow_control(ept, enable, dst);
>> +}
>> +EXPORT_SYMBOL_GPL(rpmsg_set_flow_control);
>> +
>> +/**
>>   * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
>>   * @ept: the rpmsg endpoint
>>   *
>> @@ -539,6 +558,8 @@ static int rpmsg_dev_probe(struct device *dev)
>>  
>>  		rpdev->ept = ept;
>>  		rpdev->src = ept->addr;
>> +
>> +		ept->flow_cb = rpdrv->flowcontrol;
>>  	}
>>  
>>  	err = rpdrv->probe(rpdev);
>> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
>> index 39b646d..b6efd3e 100644
>> --- a/drivers/rpmsg/rpmsg_internal.h
>> +++ b/drivers/rpmsg/rpmsg_internal.h
>> @@ -55,6 +55,7 @@ struct rpmsg_device_ops {
>>   * @trysendto:		see @rpmsg_trysendto(), optional
>>   * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
>>   * @poll:		see @rpmsg_poll(), optional
>> + * @set_flow_control:	see @rpmsg_set_flow_control(), optional
>>   * @get_mtu:		see @rpmsg_get_mtu(), optional
>>   *
>>   * Indirection table for the operations that a rpmsg backend should implement.
>> @@ -75,6 +76,7 @@ struct rpmsg_endpoint_ops {
>>  			     void *data, int len);
>>  	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>>  			     poll_table *wait);
>> +	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable, u32 dst);
>>  	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
>>  };
>>  
>> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
>> index 523c98b..a0e9d38 100644
>> --- a/include/linux/rpmsg.h
>> +++ b/include/linux/rpmsg.h
>> @@ -64,12 +64,14 @@ struct rpmsg_device {
>>  };
>>  
>>  typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
>> +typedef int (*rpmsg_flowcontrol_cb_t)(struct rpmsg_device *, void *, bool);
>>  
>>  /**
>>   * struct rpmsg_endpoint - binds a local rpmsg address to its user
>>   * @rpdev: rpmsg channel device
>>   * @refcount: when this drops to zero, the ept is deallocated
>>   * @cb: rx callback handler
>> + * @flow_cb: remote flow control callback handler
>>   * @cb_lock: must be taken before accessing/changing @cb
>>   * @addr: local rpmsg address
>>   * @priv: private data for the driver's use
>> @@ -92,6 +94,7 @@ struct rpmsg_endpoint {
>>  	struct rpmsg_device *rpdev;
>>  	struct kref refcount;
>>  	rpmsg_rx_cb_t cb;
>> +	rpmsg_flowcontrol_cb_t flow_cb;
>>  	struct mutex cb_lock;
>>  	u32 addr;
>>  	void *priv;
>> @@ -106,6 +109,7 @@ struct rpmsg_endpoint {
>>   * @probe: invoked when a matching rpmsg channel (i.e. device) is found
>>   * @remove: invoked when the rpmsg channel is removed
>>   * @callback: invoked when an inbound message is received on the channel
>> + * @flowcontrol: invoked when remote side flow control status is received
> 
> s/status/request/
> 
> Regards,
> Bjorn
> 
>>   */
>>  struct rpmsg_driver {
>>  	struct device_driver drv;
>> @@ -113,6 +117,7 @@ struct rpmsg_driver {
>>  	int (*probe)(struct rpmsg_device *dev);
>>  	void (*remove)(struct rpmsg_device *dev);
>>  	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
>> +	int (*flowcontrol)(struct rpmsg_device *, void *, bool);
>>  };
>>  
>>  static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, __rpmsg16 val)
>> @@ -192,6 +197,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>>  
>>  ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>>  
>> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst);
>> +
>>  #else
>>  
>>  static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
>> @@ -316,6 +323,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>>  	return -ENXIO;
>>  }
>>  
>> +static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return -ENXIO;
>> +}
>> +
>>  #endif /* IS_ENABLED(CONFIG_RPMSG) */
>>  
>>  /* use a macro to avoid include chaining to get THIS_MODULE */
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
