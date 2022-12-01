Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3E63EF74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiLAL2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLAL2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:28:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF813532F8;
        Thu,  1 Dec 2022 03:28:18 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1ANZSa002159;
        Thu, 1 Dec 2022 11:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2CnO3my2jsliBL/zpCzbrJyQXgnY4E5Ue+OPAnIWaF8=;
 b=JEWBhQcoezhstL6Qaw54/+49lSBduohLbiErUIyqc51w/jFC7JNyj6rgj3JuKUKlLxOB
 a5GFCsv9WfMIxczskkwB6Kw5ip8MtC0zih12e6WsVqdTkxjK3e2iv1XmfgYuoPL0kvjz
 B+yeyQ2WxG0eIkryg+ZzNXVocPn0en+vQEuVUAoJkq5gdW469v5BFImUvh8TB+fB8PZQ
 TSrUrCwRT8h2ZhinNHyujJqtVubhA71dGbGIHYMRu1LN2TFsaCwGTkYXpc8UlwJQ2q52
 d6ZKTWUChje5SzvYjqaII3n+HMjRxCt/+RVcO1go9OAMjJKkd5+mJud4gVpc+xC+GXTY CA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6k2c18xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 11:27:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B1BRG8p016152
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 11:27:16 GMT
Received: from [10.252.217.45] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 1 Dec 2022
 03:27:13 -0800
Message-ID: <17c9dab2-c636-84a4-2b56-e83e3ea9fcc6@quicinc.com>
Date:   Thu, 1 Dec 2022 16:57:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V4 1/3] rpmsg: core: Add signal API support
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
CC:     <quic_bjorande@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        "Deepak Kumar Singh" <quic_deesin@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <1669658575-21993-1-git-send-email-quic_sarannya@quicinc.com>
 <1669658575-21993-2-git-send-email-quic_sarannya@quicinc.com>
 <71e3425b-e598-a2ff-b684-dbf2f43bfa60@foss.st.com>
 <CANLsYkwX03vUpBN2MKOdtTHZbgV=7j1XSDv-e1hN8R_f=Ac0=w@mail.gmail.com>
From:   Sarannya S <quic_sarannya@quicinc.com>
In-Reply-To: <CANLsYkwX03vUpBN2MKOdtTHZbgV=7j1XSDv-e1hN8R_f=Ac0=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ptzl2TSPqxQfVB_Df8fOKKthtDo8P7Rr
X-Proofpoint-GUID: Ptzl2TSPqxQfVB_Df8fOKKthtDo8P7Rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010082
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2022 11:53 PM, Mathieu Poirier wrote:
> On Tue, 29 Nov 2022 at 02:29, Arnaud POULIQUEN
> <arnaud.pouliquen@foss.st.com> wrote:
>>
>> Hi Sarannya,
>>
>> On 11/28/22 19:02, Sarannya S wrote:
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
>>>   drivers/rpmsg/rpmsg_core.c     | 20 ++++++++++++++++++++
>>>   drivers/rpmsg/rpmsg_internal.h |  2 ++
>>>   include/linux/rpmsg.h          | 15 +++++++++++++++
>>>   3 files changed, 37 insertions(+)
>>>
>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>> index d6dde00e..0c5bf67 100644
>>> --- a/drivers/rpmsg/rpmsg_core.c
>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>> @@ -331,6 +331,24 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>>>   EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>>>
>>>   /**
>>> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
>>> + * @ept:     the rpmsg endpoint
>>> + * @enable:  enable or disable serial flow control
>>> + *
>>> + * Return: 0 on success and an appropriate error value on failure.
>>> + */
>>> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
>>
>> Seems that you did not take into account comment in your V3 asking you to
>> add the destination address of the endpoint as parameter
> 
> I will not review this patchset until Arnaud's comment is addressed or
> a reason for the omission is provided.
> 
Arnaud, Mathieu,
Sorry, I did not find this comment in V3 patch.
I will update the patch by adding destination address as parameter.

Regards,
Sarannya
>>
>> Regards,
>> Arnaud
>>
>>> +{
>>> +     if (WARN_ON(!ept))
>>> +             return -EINVAL;
>>> +     if (!ept->ops->set_flow_control)
>>> +             return -ENXIO;
>>> +
>>> +     return ept->ops->set_flow_control(ept, enable);
>>> +}
>>> +EXPORT_SYMBOL(rpmsg_set_flow_control);
>>> +
>>> +/**
>>>    * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
>>>    * @ept: the rpmsg endpoint
>>>    *
>>> @@ -539,6 +557,8 @@ static int rpmsg_dev_probe(struct device *dev)
>>>
>>>                rpdev->ept = ept;
>>>                rpdev->src = ept->addr;
>>> +
>>> +             ept->flow_cb = rpdrv->flowcontrol;
>>>        }
>>>
>>>        err = rpdrv->probe(rpdev);
>>> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
>>> index 39b646d..4fea45a 100644
>>> --- a/drivers/rpmsg/rpmsg_internal.h
>>> +++ b/drivers/rpmsg/rpmsg_internal.h
>>> @@ -55,6 +55,7 @@ struct rpmsg_device_ops {
>>>    * @trysendto:               see @rpmsg_trysendto(), optional
>>>    * @trysend_offchannel:      see @rpmsg_trysend_offchannel(), optional
>>>    * @poll:            see @rpmsg_poll(), optional
>>> + * @set_flow_control:        see @rpmsg_set_flow_control(), optional
>>>    * @get_mtu:         see @rpmsg_get_mtu(), optional
>>>    *
>>>    * Indirection table for the operations that a rpmsg backend should implement.
>>> @@ -75,6 +76,7 @@ struct rpmsg_endpoint_ops {
>>>                             void *data, int len);
>>>        __poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>>>                             poll_table *wait);
>>> +     int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
>>>        ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
>>>   };
>>>
>>> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
>>> index 523c98b..cc7a917 100644
>>> --- a/include/linux/rpmsg.h
>>> +++ b/include/linux/rpmsg.h
>>> @@ -64,12 +64,14 @@ struct rpmsg_device {
>>>   };
>>>
>>>   typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
>>> +typedef int (*rpmsg_flowcontrol_cb_t)(struct rpmsg_device *, void *, bool);
>>>
>>>   /**
>>>    * struct rpmsg_endpoint - binds a local rpmsg address to its user
>>>    * @rpdev: rpmsg channel device
>>>    * @refcount: when this drops to zero, the ept is deallocated
>>>    * @cb: rx callback handler
>>> + * @flow_cb: remote flow control callback handler
>>>    * @cb_lock: must be taken before accessing/changing @cb
>>>    * @addr: local rpmsg address
>>>    * @priv: private data for the driver's use
>>> @@ -92,6 +94,7 @@ struct rpmsg_endpoint {
>>>        struct rpmsg_device *rpdev;
>>>        struct kref refcount;
>>>        rpmsg_rx_cb_t cb;
>>> +     rpmsg_flowcontrol_cb_t flow_cb;
>>>        struct mutex cb_lock;
>>>        u32 addr;
>>>        void *priv;
>>> @@ -106,6 +109,7 @@ struct rpmsg_endpoint {
>>>    * @probe: invoked when a matching rpmsg channel (i.e. device) is found
>>>    * @remove: invoked when the rpmsg channel is removed
>>>    * @callback: invoked when an inbound message is received on the channel
>>> + * @flowcontrol: invoked when remote side flow control status is received
>>>    */
>>>   struct rpmsg_driver {
>>>        struct device_driver drv;
>>> @@ -113,6 +117,7 @@ struct rpmsg_driver {
>>>        int (*probe)(struct rpmsg_device *dev);
>>>        void (*remove)(struct rpmsg_device *dev);
>>>        int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
>>> +     int (*flowcontrol)(struct rpmsg_device *, void *, bool);
>>>   };
>>>
>>>   static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, __rpmsg16 val)
>>> @@ -192,6 +197,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>>>
>>>   ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>>>
>>> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
>>> +
>>>   #else
>>>
>>>   static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
>>> @@ -316,6 +323,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>>>        return -ENXIO;
>>>   }
>>>
>>> +static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
>>> +{
>>> +     /* This shouldn't be possible */
>>> +     WARN_ON(1);
>>> +
>>> +     return -ENXIO;
>>> +}
>>> +
>>>   #endif /* IS_ENABLED(CONFIG_RPMSG) */
>>>
>>>   /* use a macro to avoid include chaining to get THIS_MODULE */
