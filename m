Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD496BF049
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCQSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCQSAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:00:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7448F199EF;
        Fri, 17 Mar 2023 10:59:58 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H901KY016837;
        Fri, 17 Mar 2023 17:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YwsLtwX+PmDFrcgxboExawpRnQvnsGpKdOo3vK8Z9uM=;
 b=ZkCeone9LBqTGTbr4riofRU7A21+qm81MtftZsTnzgMvWzVoW+uyo22lHVDxELDB8JXk
 +P0Kxn2G2DRM18COB345Cfz01hPqlN8vfDL9+jgMN9h9qkFxXV6xsTTKAy3cSfLjEqGV
 V6NBx5K5JSinyu9s9UjnB6R0/4x3y0PVMeHomnkcLil5MJKVLKSGXitWVposlSWbZUkt
 iYq15v1j9U+CKL9eKRSS946QEjys3dqmzcViwGKYgL2L9V2LC0U1JVZKxIPWEaQl+ulI
 3I/HNX5WzoRcigeHQYDNrC7PfXb5qNSI/UE0WwNUrHV7HYaEHDrk5jUBhkhu0Cvon60v Fw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pcn6f1tsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 17:59:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32HHxsso004847
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 17:59:54 GMT
Received: from [10.110.60.126] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Mar
 2023 10:59:53 -0700
Message-ID: <0bf5bddd-515b-76b6-f22f-9da10a140d83@quicinc.com>
Date:   Fri, 17 Mar 2023 10:59:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v12 6/6] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1679009888-8239-1-git-send-email-quic_eserrao@quicinc.com>
 <1679009888-8239-7-git-send-email-quic_eserrao@quicinc.com>
 <20230317001149.nlvcj2y3fuvq32qt@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230317001149.nlvcj2y3fuvq32qt@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nxaJ8aXwu97s8UvsoqWFZi4iK2CM_4_p
X-Proofpoint-ORIG-GUID: nxaJ8aXwu97s8UvsoqWFZi4iK2CM_4_p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170121
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2023 5:11 PM, Thinh Nguyen wrote:
> On Thu, Mar 16, 2023, Elson Roy Serrao wrote:
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
>>   drivers/usb/gadget/function/f_ecm.c   | 71 +++++++++++++++++++++++++++++++++++
>>   drivers/usb/gadget/function/u_ether.c | 63 +++++++++++++++++++++++++++++++
>>   drivers/usb/gadget/function/u_ether.h |  4 ++
>>   3 files changed, 138 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
>> index a7ab30e..c43cd557 100644
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
>> @@ -885,6 +887,71 @@ static struct usb_function_instance *ecm_alloc_inst(void)
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
>> +	struct usb_configuration *c = f->config;
>> +
>> +	/* D0 and D1 bit set to 0 if device is not wakeup capable */
>> +	if (!(USB_CONFIG_ATT_WAKEUP & c->bmAttributes))
>> +		return 0;
>> +
>> +	return (f->func_wakeup_armed ? USB_INTRF_STAT_FUNC_RW : 0) |
>> +		USB_INTRF_STAT_FUNC_RW_CAP;
>> +}
> 
> Why do we need to implement ecm_get_status if it's already handled in
> composite.c now?
> 

Yes this can be removed now. Will modify accordingly.
>> +
>> +static int ecm_func_suspend(struct usb_function *f, u8 options)
>> +{
>> +	struct usb_composite_dev *cdev = f->config->cdev;
>> +
>> +	DBG(cdev, "func susp %u cmd\n", options);
>> +
>> +	if (options & (USB_INTRF_FUNC_SUSPEND_LP >> 8)) {
> 
> This feature selector doesn't indicate whether it's SetFeature or
> ClearFeature request. ecm_func_suspend is supposed to be for
> SetFeature(suspend) only. Perhaps we may have to define func_resume()
> for ClearFeature(suspend)?
> 
> Thanks,
> Thinh
> 
Host uses the same feature selector FUNCTION_SUSPEND for function 
suspend and function resume and func_suspend() callback can be used to
handle both the cases ? The distinction comes whether it is a 
SetFeature(FUNCTION_SUSPEND) or ClearFeature(FUNCTION_SUSPEND) which can 
be easily done in the func_suspend callback itself. We can add another 
callback func_resume specific to ClearFeature(FUNCTION_SUSPEND) but wont 
that be redundant and more callback handling on function 
driver/composite side as well? Please let me know your opinion.

Thanks
Elson

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
>> +}
>> +
