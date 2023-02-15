Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2860F697433
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjBOCLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBOCLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:11:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386B220D1D;
        Tue, 14 Feb 2023 18:10:59 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F0G81F000750;
        Wed, 15 Feb 2023 02:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=H4wOwi/z9PrRBi8vNh5gtDQuFX0Hc3WMw6SlXNL5GA0=;
 b=BJ6Yi3zJyW01FGf6jfzl9Mef0H4bBB31ZEe/n8gi0bQFDU86V1+5nHAnQv6VSkQ1th/S
 D9cmWdH50KFeNZp59lOKu2JTNbJg71T+Gjgwy3VB1NB4nrnsTcZGb1LNFuNFVRv5+BJ/
 jk9zw7LnAqyCBNOsVzw1yWIEaYxR5m0j4OBQfe5d1fWlYf0iBblsxSw6aGJwxmIE+p+G
 ubqbY0HR51l32mJwV3xvT8xcocCGI/2JEphk8SXt17VVUAeiLkvOiaMbnjXLRWr6oQo+
 MywWhxa34vyXQNVhktWP2twhpyl+B1JaGWg/09k+de5CznTM81FUYz6wyJvklIqvVsga zA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqts7v2nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 02:10:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F2AqT4006961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 02:10:52 GMT
Received: from [10.110.33.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 18:10:51 -0800
Message-ID: <e8eb677c-406f-d5a0-3ed5-0a789632a0b4@quicinc.com>
Date:   Tue, 14 Feb 2023 18:10:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/5] usb: gadget: Add function wakeup support
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1676316676-28377-1-git-send-email-quic_eserrao@quicinc.com>
 <1676316676-28377-4-git-send-email-quic_eserrao@quicinc.com>
 <20230215005520.7pw7xmlyi7oqgl4p@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230215005520.7pw7xmlyi7oqgl4p@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: chlvaB7W8RdAVZ2OjrjPdOFE0TNsgJ2Y
X-Proofpoint-ORIG-GUID: chlvaB7W8RdAVZ2OjrjPdOFE0TNsgJ2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_17,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=880 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150018
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 4:55 PM, Thinh Nguyen wrote:
> On Mon, Feb 13, 2023, Elson Roy Serrao wrote:
>> A function which is in function suspend state has to send a
>> function wake notification to the host in case it needs to
>> exit from this state and resume data transfer. Add support to
>> handle such requests by exposing a new gadget op.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   drivers/usb/gadget/composite.c | 24 ++++++++++++++++++++++++
>>   drivers/usb/gadget/udc/core.c  | 21 +++++++++++++++++++++
>>   include/linux/usb/composite.h  |  6 ++++++
>>   include/linux/usb/gadget.h     |  4 ++++
>>   4 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
>> index a37a8f4..51d6ee9 100644
>> --- a/drivers/usb/gadget/composite.c
>> +++ b/drivers/usb/gadget/composite.c
>> @@ -492,6 +492,30 @@ int usb_interface_id(struct usb_configuration *config,
>>   }
>>   EXPORT_SYMBOL_GPL(usb_interface_id);
>>   
>> +int usb_func_wakeup(struct usb_function *func)
>> +{
>> +	int ret, id;
>> +
>> +	if (!func->func_wakeup_armed) {
>> +		ERROR(func->config->cdev, "not armed for func remote wakeup\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (id = 0; id < MAX_CONFIG_INTERFACES; id++)
>> +		if (func->config->interface[id] == func)
>> +			break;
>> +
>> +	if (id == MAX_CONFIG_INTERFACES) {
>> +		ERROR(func->config->cdev, "Invalid function id:%d\n", id);
> 
> The print of id here is always MAX_CONFIG_INTERFACES right?
> 
> Thanks,
> Thinh
> 
Thanks for catching this. Will rectify this in v5

>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = usb_gadget_func_wakeup(func->config->cdev->gadget, id);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_func_wakeup);
>> +
