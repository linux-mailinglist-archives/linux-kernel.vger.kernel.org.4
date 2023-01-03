Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A32A65C12D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbjACNvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237773AbjACNuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:50:51 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55381181F;
        Tue,  3 Jan 2023 05:50:36 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303AqhYL009376;
        Tue, 3 Jan 2023 14:50:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=pGT9+waS5UFAF4HoI9ksovFP3BcAx2wPj5gKc3fQsUY=;
 b=Oy18l7DhsW51SzcMCVlzJrdOsmP4LU2fgfAu3tsAmTJLx/xdWcyR2fUBcPvTTEseDhOd
 ZHOr/tRvEXJvp67LhU1PKJOx+T87dyKCFvT03VY9EUMePfvbwa5AUn0IVNBHeFLE2xlz
 KujwAk48tJ3P5Zs1fwn31NxHyXSqxCtzV147YniQ0TjUVkDhggvJNK/gflUWNN/PWesc
 p/V3TqbUqwZkW573qt2urmEeI424Q8Do1g1m3Vf/IH93Y57BKplV29z1tR6d5aUieHZ0
 Ehe7Ti5w4gNmmBGS6C7bQNTzEjc4ufj5mGwS6QxXMsFZd21BhcEZZ/ZDDjUe3h+o9aaa DQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mtcupne53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 14:50:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5D75610002A;
        Tue,  3 Jan 2023 14:50:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 550C7222CB9;
        Tue,  3 Jan 2023 14:50:14 +0100 (CET)
Received: from [10.252.14.6] (10.252.14.6) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 3 Jan
 2023 14:50:13 +0100
Message-ID: <1cbcd57c-ba6d-390f-a28c-fa651d1d7262@foss.st.com>
Date:   Tue, 3 Jan 2023 14:50:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V4 1/3] rpmsg: core: Add signal API support
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
References: <1670418258-11502-1-git-send-email-quic_sarannya@quicinc.com>
 <1670418258-11502-2-git-send-email-quic_sarannya@quicinc.com>
 <6ba10328-bc48-c953-49e7-29e079fb6406@foss.st.com>
 <20221227153252.ufenietw5wgsk7kj@builder.lan>
Content-Language: en-US
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20221227153252.ufenietw5wgsk7kj@builder.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.14.6]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_04,2023-01-03_02,2022-06-22_01
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 12/27/22 16:32, Bjorn Andersson wrote:
> On Wed, Dec 21, 2022 at 05:12:22PM +0100, Arnaud POULIQUEN wrote:
>> Hello,
>>
>> On 12/7/22 14:04, Sarannya S wrote:
>>> Some transports like Glink support the state notifications between
>>> clients using flow control signals similar to serial protocol signals.
>>> Local glink client drivers can send and receive flow control status
>>> to glink clients running on remote processors.
>>>
>>> Add APIs to support sending and receiving of flow control status by
>>> rpmsg clients.
>>>
>>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
>>> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
>>> ---
>>>  drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
>>>  drivers/rpmsg/rpmsg_internal.h |  2 ++
>>>  include/linux/rpmsg.h          | 15 +++++++++++++++
>>>  3 files changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>> index d6dde00e..77aeba0 100644
>>> --- a/drivers/rpmsg/rpmsg_core.c
>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>> @@ -331,6 +331,25 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>>>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>>>  
>>>  /**
>>> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
>>> + * @ept:	the rpmsg endpoint
>>> + * @enable:	enable or disable serial flow control
>>
>> What does it mean "enable and disable serial flow control"?
>> Do you speak about the flow control feature or the data flow itself?
>>
> 
> Good point, the purpose of the boolean is to "request throttling of the
> incoming data flow".
> 
>> I guess it is the activation/deactivation of the data stream
>> regarding Bjorn's comment in V1:
>>
>> "I therefore asked Deepak to change it so the rpmsg api would contain a
>> single "pause incoming data"/"resume incoming data" - given that this is
>> a wish that we've seen in a number of discussions."
>>
>> For me this is the software flow control:
>> https://en.wikipedia.org/wiki/Software_flow_control
>>
>> I would suggest not limiting the control only to activation/deactivation but to
>> offer more flexibility in terms of services. replace the boolean by a bitmap
>> would allow to extend it later.
>>
>> For instance by introducing 2 definitions:
>>
>> /* RPMSG pause transmission request:
>>  * sent to the remote endpoint to request to suspend its transmission */
>>  */
>> #define RPMSG_FC_PT_REQ  (1 << 0)
> 
> enable = true
> 
>>
>> /* RPMSG resume transmission request
>>  * sent to the remote endpoint to allow to resume its transmission
>>  */
>> #define RPMSG_FC_RT_REQ  (1 << 1)
>>
> 
> enable = false

Do you mean that it should be only one definition? If yes you are right
only one definition is sufficient for the pause/resume

> 
>> Then we could add (in a next step) some other flow controls such as
>> /* RPMSG pause transmission information
>>  * Sent to the remote endpoint to inform that no more data will be sent
>>  * until the reception of RPMSG_FC_RT_INFO
>>  */
>> #define RPMSG_FC_PT_INFO  (1 << 16)
>> #define RPMSG_FC_RT_INFO  (1 << 16)
>>
> 
> I presume you're looking for a usage pattern where the client would send
> this to the remote and then the flow control mechanism would be used for
> the remote end to request more data.
> 
> I find Deepak's (adjusted) proposal to be generic and to the point, and
> your proposal builds unnecessary "flexibility" into this same mechanism.
> 
> If you have a rpmsg protocol where the client is expected to sit
> waiting, and upon a request from the remote side send another piece of
> data, why don't you just build this into the application protocol?  That
> way your application would work over both transports with and without
> flow control...
> 
> 
> Perhaps I'm misunderstanding what you're asking for?

With the RPMSG_FC_PT_INFO example I had in mind the possibility to implement PM
runtime.

But my main point here is to allow to extend the flow control in future.
or instance an comment in OpenAMP PR part [1] was:

"ON/OFF info isn't enough in the advanced flow control since the additional info
is required(e.g. the slide window, round trip delay, congestion etc..)."

[1]https://github.com/OpenAMP/open-amp/pull/394#discussion_r878363627

Using a @enable boolean would imply to create new ops if someone want to extend
the flow control (to keep legacy compatibility). Using a bit map for the
parameter could ease a future extension.

Regards,
Arnaud

> 
> Regards,
> Bjorn
> 
>>> + * @dst:	destination address of the endpoint
>>
>> Thanks to have integrated this in your patch!
>>
>> Regards,
>> Arnaud
>>
>>> + *
>>> + * Return: 0 on success and an appropriate error value on failure.
>>> + */
>>> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
>>> +{
>>> +	if (WARN_ON(!ept))
>>> +		return -EINVAL;
>>> +	if (!ept->ops->set_flow_control)
>>> +		return -ENXIO;
>>> +
>>> +	return ept->ops->set_flow_control(ept, enable, dst);
>>> +}
>>> +EXPORT_SYMBOL(rpmsg_set_flow_control);
>>> +
>>> +/**
>>>   * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
>>>   * @ept: the rpmsg endpoint
>>>   *
>>> @@ -539,6 +558,8 @@ static int rpmsg_dev_probe(struct device *dev)
>>>  
>>>  		rpdev->ept = ept;
>>>  		rpdev->src = ept->addr;
>>> +
>>> +		ept->flow_cb = rpdrv->flowcontrol;
>>>  	}
>>>  
>>>  	err = rpdrv->probe(rpdev);
>>> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
>>> index 39b646d..b6efd3e 100644
>>> --- a/drivers/rpmsg/rpmsg_internal.h
>>> +++ b/drivers/rpmsg/rpmsg_internal.h
>>> @@ -55,6 +55,7 @@ struct rpmsg_device_ops {
>>>   * @trysendto:		see @rpmsg_trysendto(), optional
>>>   * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
>>>   * @poll:		see @rpmsg_poll(), optional
>>> + * @set_flow_control:	see @rpmsg_set_flow_control(), optional
>>>   * @get_mtu:		see @rpmsg_get_mtu(), optional
>>>   *
>>>   * Indirection table for the operations that a rpmsg backend should implement.
>>> @@ -75,6 +76,7 @@ struct rpmsg_endpoint_ops {
>>>  			     void *data, int len);
>>>  	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>>>  			     poll_table *wait);
>>> +	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable, u32 dst);
>>>  	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
>>>  };
>>>  
>>> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
>>> index 523c98b..a0e9d38 100644
>>> --- a/include/linux/rpmsg.h
>>> +++ b/include/linux/rpmsg.h
>>> @@ -64,12 +64,14 @@ struct rpmsg_device {
>>>  };
>>>  
>>>  typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
>>> +typedef int (*rpmsg_flowcontrol_cb_t)(struct rpmsg_device *, void *, bool);
>>>  
>>>  /**
>>>   * struct rpmsg_endpoint - binds a local rpmsg address to its user
>>>   * @rpdev: rpmsg channel device
>>>   * @refcount: when this drops to zero, the ept is deallocated
>>>   * @cb: rx callback handler
>>> + * @flow_cb: remote flow control callback handler
>>>   * @cb_lock: must be taken before accessing/changing @cb
>>>   * @addr: local rpmsg address
>>>   * @priv: private data for the driver's use
>>> @@ -92,6 +94,7 @@ struct rpmsg_endpoint {
>>>  	struct rpmsg_device *rpdev;
>>>  	struct kref refcount;
>>>  	rpmsg_rx_cb_t cb;
>>> +	rpmsg_flowcontrol_cb_t flow_cb;
>>>  	struct mutex cb_lock;
>>>  	u32 addr;
>>>  	void *priv;
>>> @@ -106,6 +109,7 @@ struct rpmsg_endpoint {
>>>   * @probe: invoked when a matching rpmsg channel (i.e. device) is found
>>>   * @remove: invoked when the rpmsg channel is removed
>>>   * @callback: invoked when an inbound message is received on the channel
>>> + * @flowcontrol: invoked when remote side flow control status is received
>>>   */
>>>  struct rpmsg_driver {
>>>  	struct device_driver drv;
>>> @@ -113,6 +117,7 @@ struct rpmsg_driver {
>>>  	int (*probe)(struct rpmsg_device *dev);
>>>  	void (*remove)(struct rpmsg_device *dev);
>>>  	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
>>> +	int (*flowcontrol)(struct rpmsg_device *, void *, bool);
>>>  };
>>>  
>>>  static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, __rpmsg16 val)
>>> @@ -192,6 +197,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>>>  
>>>  ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>>>  
>>> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst);
>>> +
>>>  #else
>>>  
>>>  static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
>>> @@ -316,6 +323,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>>>  	return -ENXIO;
>>>  }
>>>  
>>> +static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
>>> +{
>>> +	/* This shouldn't be possible */
>>> +	WARN_ON(1);
>>> +
>>> +	return -ENXIO;
>>> +}
>>> +
>>>  #endif /* IS_ENABLED(CONFIG_RPMSG) */
>>>  
>>>  /* use a macro to avoid include chaining to get THIS_MODULE */
