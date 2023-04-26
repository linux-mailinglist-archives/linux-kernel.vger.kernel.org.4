Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E336EEBD7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbjDZBRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjDZBRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:17:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6152703;
        Tue, 25 Apr 2023 18:17:35 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33Q1CkOH017309;
        Wed, 26 Apr 2023 01:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=at4bqF9DgVDcLP0tRwj2xxUb+qw/8ejaLGWivzRhGDI=;
 b=BLIeccEV8p83nfyyXC7VBQaUNB0BjcsABOwerbynCJT4/X/zBeY14g11NExoGabF92cR
 NZ8e1Py0ehTFjkexzSKOJMqhF10MxM4ROT/uz0UYP7a16GeKYxWcmmG7EDCNOdNF7n9P
 hSlW59SqnEv7l9heCiFAQh5dR03SS4nLxtv/2hFOOZqa2d2M+Ncf2nZ7jDQTEyBCtQ02
 GMA1yeX+3wH3J/3ByDre0CNyrvAeBTfGHpUCbdgBs1OADIAwytHZClDMxaHDaevLTUOz
 AzTSTpgatD5KKl14X+4I5W03+oBLAT5BIqNdrpHmsrv6iQv9Z5LCIecGACviL+HYCYoi jA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q6fs2sh22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 01:17:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33Q1HMon031285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 01:17:22 GMT
Received: from [10.216.20.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 25 Apr
 2023 18:17:18 -0700
Message-ID: <dde01219-57f7-3cc2-c4fb-5b6a38bd7a9c@quicinc.com>
Date:   Wed, 26 Apr 2023 06:47:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] usb: gadget: udc: Handle gadget_connect failure
 during bind operation
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-3-quic_kriskura@quicinc.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230328160756.30520-3-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4Xpbz-xUdXLWo7PIvMr1zHfEbL38e08Y
X-Proofpoint-ORIG-GUID: 4Xpbz-xUdXLWo7PIvMr1zHfEbL38e08Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_11,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260009
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, Geert,

  Can you help review and provide comments/approval on the following patch.

Regards,
Krishna,

On 3/28/2023 9:37 PM, Krishna Kurapati wrote:
> In the event, gadget_connect call (which invokes pullup) fails,
> propagate the error to udc bind operation which inturn sends the
> error to configfs. The userspace can then retry enumeartion if
> it chooses to.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>   drivers/usb/gadget/udc/core.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 23b0629a8774..975205a1853f 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1051,12 +1051,16 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
>   
>   /* ------------------------------------------------------------------------- */
>   
> -static void usb_udc_connect_control(struct usb_udc *udc)
> +static int usb_udc_connect_control(struct usb_udc *udc)
>   {
> +	int ret;
> +
>   	if (udc->vbus)
> -		usb_gadget_connect(udc->gadget);
> +		ret = usb_gadget_connect(udc->gadget);
>   	else
> -		usb_gadget_disconnect(udc->gadget);
> +		ret = usb_gadget_disconnect(udc->gadget);
> +
> +	return ret;
>   }
>   
>   /**
> @@ -1500,11 +1504,19 @@ static int gadget_bind_driver(struct device *dev)
>   	if (ret)
>   		goto err_start;
>   	usb_gadget_enable_async_callbacks(udc);
> -	usb_udc_connect_control(udc);
> +	ret = usb_udc_connect_control(udc);
> +	if (ret)
> +		goto err_connect_control;
>   
>   	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>   	return 0;
>   
> + err_connect_control:
> +	usb_gadget_disable_async_callbacks(udc);
> +	if (gadget->irq)
> +		synchronize_irq(gadget->irq);
> +	usb_gadget_udc_stop(udc);
> +
>    err_start:
>   	driver->unbind(udc->gadget);
>   
