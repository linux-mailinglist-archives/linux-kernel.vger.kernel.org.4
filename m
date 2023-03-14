Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B3E6B9FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCNTgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCNTgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:36:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D54528D03;
        Tue, 14 Mar 2023 12:36:38 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EEaVvP026975;
        Tue, 14 Mar 2023 19:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WvBtBVUxhuWsOdkHfQK/9LMWkG6w3kLGc+fUMx20UFQ=;
 b=cjurALIcQi3M3pUzr5Y8lwC+v0NWjGXJ76sNaczsDRJXJgnt3AfqR/Owg7IqgcEWfMia
 AyOt5NnoMbsCxMgBpKCwjSnDtQmIieXQT7Itn59hnwCrgeQpXeTDdFtKCJCDDmhFWfbn
 V/jZOKNNxh1Il4C6Hh/MEDEdtQc3EGMDYYZeKVSAUDjCrW2uEjnA1LHWI/ijgU3NPLkf
 FMQe41r6MW1uS68mBfVUOgouNs4fguZvri24bPenxbtzBwLwwSUqevBK1lY93wTOmPF+
 TgCge9lrAWn/pzOSrEbNx2Q/D12peW45Sw3C9E/6UmW3ofDMEJ2RlWvgAWZ+yBZk8nqJ vw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa7w6usgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 19:36:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32EJaWoa019380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 19:36:32 GMT
Received: from [10.110.76.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 14 Mar
 2023 12:36:31 -0700
Message-ID: <7064988c-9975-64c3-25c6-e1330ed723a4@quicinc.com>
Date:   Tue, 14 Mar 2023 12:36:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1678731892-20503-1-git-send-email-quic_eserrao@quicinc.com>
 <1678731892-20503-6-git-send-email-quic_eserrao@quicinc.com>
 <20230313202655.srqfddpn5r36zt3o@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230313202655.srqfddpn5r36zt3o@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9Jg7BURgNnHKMgD48juicRE1cBG1R7qg
X-Proofpoint-GUID: 9Jg7BURgNnHKMgD48juicRE1cBG1R7qg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_12,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140160
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/2023 1:27 PM, Thinh Nguyen wrote:
> On Mon, Mar 13, 2023, Elson Roy Serrao wrote:
>> When host sends a suspend notification to the device, handle
>> the suspend callbacks in the function driver. Enhanced super
>> speed devices can support function suspend feature to put the
>> function in suspend state. Handle function suspend callback.
>>
>> Depending on the remote wakeup capability the device can either
>> trigger a remote wakeup or wait for the host initiated resume to
>> start data transfer again.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   drivers/usb/gadget/function/f_ecm.c   | 68 +++++++++++++++++++++++++++++++++++
>>   drivers/usb/gadget/function/u_ether.c | 63 ++++++++++++++++++++++++++++++++
>>   drivers/usb/gadget/function/u_ether.h |  4 +++
>>   3 files changed, 135 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
>> index a7ab30e..d50c1a4 100644
>> --- a/drivers/usb/gadget/function/f_ecm.c
>> +++ b/drivers/usb/gadget/function/f_ecm.c
>> @@ -633,6 +633,8 @@ static void ecm_disable(struct usb_function *f)
>>   
>>   	usb_ep_disable(ecm->notify);
>>   	ecm->notify->desc = NULL;
>> +	f->func_suspended = false;
>> +	f->func_wakeup_armed = false;
>>   }
>>   
>>   /*-------------------------------------------------------------------------*/
>> @@ -885,6 +887,68 @@ static struct usb_function_instance *ecm_alloc_inst(void)
>>   	return &opts->func_inst;
>>   }
>>   
>> +static void ecm_suspend(struct usb_function *f)
>> +{
>> +	struct f_ecm *ecm = func_to_ecm(f);
>> +	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
>> +
>> +	if (f->func_suspended) {
>> +		DBG(cdev, "Function already suspended\n");
>> +		return;
>> +	}
>> +
>> +	DBG(cdev, "ECM Suspend\n");
>> +
>> +	gether_suspend(&ecm->port);
>> +}
>> +
>> +static void ecm_resume(struct usb_function *f)
>> +{
>> +	struct f_ecm *ecm = func_to_ecm(f);
>> +	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
>> +
>> +	/*
>> +	 * If the function is in USB3 Function Suspend state, resume is
>> +	 * canceled. In this case resume is done by a Function Resume request.
>> +	 */
>> +	if (f->func_suspended)
>> +		return;
>> +
>> +	DBG(cdev, "ECM Resume\n");
>> +
>> +	gether_resume(&ecm->port);
>> +}
>> +
>> +static int ecm_get_status(struct usb_function *f)
>> +{
>> +	return (f->func_wakeup_armed ? USB_INTRF_STAT_FUNC_RW : 0) |
>> +		USB_INTRF_STAT_FUNC_RW_CAP;
> 
> Need to check the usb configuration is if it's wakeup_capable.
> 
>> +}
>> +
>> +static int ecm_func_suspend(struct usb_function *f, u8 options)
>> +{
>> +	struct f_ecm *ecm = func_to_ecm(f);
>> +	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
>> +
>> +	DBG(cdev, "func susp %u cmd\n", options);
>> +
>> +	f->func_wakeup_armed = !!(options & (USB_INTRF_FUNC_SUSPEND_RW >> 8));
> 
> Same here. Check config's bmAttributes if it's remote wakeup capable
> before arming for remote wakeup.
> 
Done. I will add that check for above two cases.
>> +
>> +	if (options & (USB_INTRF_FUNC_SUSPEND_LP >> 8)) {
>> +		if (!f->func_suspended) {
>> +			ecm_suspend(f);
>> +			f->func_suspended = true;
>> +		}
>> +	} else {
>> +		if (f->func_suspended) {
>> +			f->func_suspended = false;
>> +			ecm_resume(f);
>> +		}
>> +	}
>> +
>> +	return 0;
> 
> Need to return negative error if SetFeature fails. We should fix the
> composite layer to allow for protocal STALL here. Host needs to know if
> it should proceed to put the function in suspend.
> 
> Thanks,
> Thinh
> 

Could you please clarify what SetFeature fail here means? The host puts 
the function in function suspend state through this SetFeature request.
If the device is not configured for remote wakeup (bmAtrributes wakeup 
bit), like you mentioned above we should not arm the function for remote 
wakeup. But the host is free to put the function in function suspend 
state and wake it up through host initiated function resume right?

Thanks
Elson

>> +}
>> +
>>   static void ecm_free(struct usb_function *f)
>>   {
>>   	struct f_ecm *ecm;
>> @@ -952,6 +1016,10 @@ static struct usb_function *ecm_alloc(struct usb_function_instance *fi)
>>   	ecm->port.func.setup = ecm_setup;
>>   	ecm->port.func.disable = ecm_disable;
>>   	ecm->port.func.free_func = ecm_free;
>> +	ecm->port.func.suspend = ecm_suspend;
>> +	ecm->port.func.get_status = ecm_get_status;
>> +	ecm->port.func.func_suspend = ecm_func_suspend;
>> +	ecm->port.func.resume = ecm_resume;
>>   
>>   	return &ecm->port.func;
>>   }
>> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
>> index f259975..8eba018 100644
>> --- a/drivers/usb/gadget/function/u_ether.c
>> +++ b/drivers/usb/gadget/function/u_ether.c
>> @@ -437,6 +437,20 @@ static inline int is_promisc(u16 cdc_filter)
>>   	return cdc_filter & USB_CDC_PACKET_TYPE_PROMISCUOUS;
>>   }
>>   
>> +static int ether_wakeup_host(struct gether *port)
>> +{
>> +	int			ret;
>> +	struct usb_function	*func = &port->func;
>> +	struct usb_gadget	*gadget = func->config->cdev->gadget;
>> +
>> +	if (func->func_suspended)
>> +		ret = usb_func_wakeup(func);
>> +	else
>> +		ret = usb_gadget_wakeup(gadget);
>> +
>> +	return ret;
>> +}
>> +
>>   static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
>>   					struct net_device *net)
>>   {
>> @@ -456,6 +470,15 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
>>   		in = NULL;
>>   		cdc_filter = 0;
>>   	}
>> +
>> +	if (dev->port_usb->is_suspend) {
>> +		DBG(dev, "Port suspended. Triggering wakeup\n");
>> +		netif_stop_queue(net);
>> +		spin_unlock_irqrestore(&dev->lock, flags);
>> +		ether_wakeup_host(dev->port_usb);
>> +		return NETDEV_TX_BUSY;
>> +	}
>> +
>>   	spin_unlock_irqrestore(&dev->lock, flags);
>>   
>>   	if (!in) {
>> @@ -1014,6 +1037,45 @@ int gether_set_ifname(struct net_device *net, const char *name, int len)
>>   }
>>   EXPORT_SYMBOL_GPL(gether_set_ifname);
>>   
>> +void gether_suspend(struct gether *link)
>> +{
>> +	struct eth_dev *dev = link->ioport;
>> +	unsigned long flags;
>> +
>> +	if (!dev)
>> +		return;
>> +
>> +	if (atomic_read(&dev->tx_qlen)) {
>> +		/*
>> +		 * There is a transfer in progress. So we trigger a remote
>> +		 * wakeup to inform the host.
>> +		 */
>> +		ether_wakeup_host(dev->port_usb);
>> +		return;
>> +	}
>> +	spin_lock_irqsave(&dev->lock, flags);
>> +	link->is_suspend = true;
>> +	spin_unlock_irqrestore(&dev->lock, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(gether_suspend);
>> +
>> +void gether_resume(struct gether *link)
>> +{
>> +	struct eth_dev *dev = link->ioport;
>> +	unsigned long flags;
>> +
>> +	if (!dev)
>> +		return;
>> +
>> +	if (netif_queue_stopped(dev->net))
>> +		netif_start_queue(dev->net);
>> +
>> +	spin_lock_irqsave(&dev->lock, flags);
>> +	link->is_suspend = false;
>> +	spin_unlock_irqrestore(&dev->lock, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(gether_resume);
>> +
>>   /*
>>    * gether_cleanup - remove Ethernet-over-USB device
>>    * Context: may sleep
>> @@ -1176,6 +1238,7 @@ void gether_disconnect(struct gether *link)
>>   
>>   	spin_lock(&dev->lock);
>>   	dev->port_usb = NULL;
>> +	link->is_suspend = false;
>>   	spin_unlock(&dev->lock);
>>   }
>>   EXPORT_SYMBOL_GPL(gether_disconnect);
>> diff --git a/drivers/usb/gadget/function/u_ether.h b/drivers/usb/gadget/function/u_ether.h
>> index 4014454..851ee10 100644
>> --- a/drivers/usb/gadget/function/u_ether.h
>> +++ b/drivers/usb/gadget/function/u_ether.h
>> @@ -79,6 +79,7 @@ struct gether {
>>   	/* called on network open/close */
>>   	void				(*open)(struct gether *);
>>   	void				(*close)(struct gether *);
>> +	bool				is_suspend;
>>   };
>>   
>>   #define	DEFAULT_FILTER	(USB_CDC_PACKET_TYPE_BROADCAST \
>> @@ -258,6 +259,9 @@ int gether_set_ifname(struct net_device *net, const char *name, int len);
>>   
>>   void gether_cleanup(struct eth_dev *dev);
>>   
>> +void gether_suspend(struct gether *link);
>> +void gether_resume(struct gether *link);
>> +
>>   /* connect/disconnect is handled by individual functions */
>>   struct net_device *gether_connect(struct gether *);
>>   void gether_disconnect(struct gether *);
>> -- 
>> 2.7.4
