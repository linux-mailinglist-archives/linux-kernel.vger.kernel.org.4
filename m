Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AEF6A51C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 04:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjB1DXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 22:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1DXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 22:23:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE669769;
        Mon, 27 Feb 2023 19:22:59 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S2CaPB015036;
        Tue, 28 Feb 2023 03:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4B4SfVxiyuSGes3GE50QsPKUfzWZP3X4dBtjjxuzVzk=;
 b=LLVKQa33hUJOs8epOjcbap6GHSqsQnmF2qd5Nm5p8juC67ZHqHhJYlNwlCKAQdJg76sC
 dRUb8jJUKx3u2a0Ki+97+5DCUU4VTQo+5hUQwLd8KRdBGFBSKsdGjVoiv/k1Gryv0FC0
 BSinDzM2aFbtx1QISxci1je+Fthk2e5LtTCsM6+UXsZPmtcK1k/OS0wlGREjLgdTM0qY
 I9bBeC5iz0FTbPeh7t5lCw4Y1f6XKCdz//EOq48sV76jyzWb+yw5pImVkNfEApSobWCk
 MqgsoL3w1pCWjHIuOxP6XtTUhpCXR9GyiCXTalrrVNO9IwH5xSNqR0eJFcra9JuQVMe1 5g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p15560jys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 03:22:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31S3MtRB007570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 03:22:55 GMT
Received: from [10.110.31.193] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Feb
 2023 19:22:55 -0800
Message-ID: <24af4a1b-0cc5-e65b-ac66-f767f891520e@quicinc.com>
Date:   Mon, 27 Feb 2023 19:22:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: dwc3: gadget: Add 100uS delay after end transfer
 command without IOC
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20230227232035.13759-1-quic_wcheng@quicinc.com>
 <20230228021925.j5bquwnwuvog3hx6@synopsys.com>
 <20230228031027.ghrfnda5lkt7qfmt@synopsys.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230228031027.ghrfnda5lkt7qfmt@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LNumwefrTEpKRWRSs0cU7a8oRBBmNM3D
X-Proofpoint-GUID: LNumwefrTEpKRWRSs0cU7a8oRBBmNM3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_19,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=946
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280021
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 2/27/2023 7:10 PM, Thinh Nguyen wrote:
> On Tue, Feb 28, 2023, Thinh Nguyen wrote:
>> On Mon, Feb 27, 2023, Wesley Cheng wrote:
>>> Previously, there was a 100uS delay inserted after issuing an end transfer
>>> command for specific controller revisions.  This was due to the fact that
>>> there was a GUCTL2 bit field which enabled synchronous completion of the
>>> end transfer command once the CMDACT bit was cleared in the DEPCMD
>>> register.  Since this bit does not exist for all controller revisions, add
>>> the delay back in.
>>>
>>> An issue was seen where the USB request buffer was unmapped while the DWC3
>>> controller was still accessing the TRB.  However, it was confirmed that the
>>> end transfer command was successfully submitted. (no end transfer timeout)
>>
>> Currently we only check for command active, not completion on teardown.
>>
>>> In situations, such as dwc3_gadget_soft_disconnect() and
>>> __dwc3_gadget_ep_disable(), the dwc3_remove_request() is utilized, which
>>> will issue the end transfer command, and follow up with
>>> dwc3_gadget_giveback().  At least for the USB ep disable path, it is
>>> required for any pending and started requests to be completed and returned
>>> to the function driver in the same context of the disable call.  Without
>>> the GUCTL2 bit, it is not ensured that the end transfer is completed before
>>> the buffers are unmapped.
>>>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>
>> This is expected. We're supposed to make sure the End Transfer command
>> complete before accessing the request. Usually on device/endpoint
>> teardown, the gadget drivers don't access the stale/incomplete requests
>> with -ESHUTDOWN status. There will be problems if we do, and we haven't
>> fixed that.
>>
>> Adding 100uS may not apply for every device, and we don't need to do
>> that for every End Transfer command. Can you try this untested diff
>> instead:
>>

Thanks for the code suggestion.

>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 30408bafe64e..5ae5ff4c8858 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1962,6 +1962,34 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
>>   	return DWC3_DSTS_SOFFN(reg);
>>   }
>>   
>> +static int dwc3_poll_ep_completion(struct dwc3_ep *dep)
>> +{
>> +	if (!list_empty(&dep->started_list)) {
>> +		struct dwc3_request *req;
>> +		int timeout = 500;
>> +
>> +		req = next_request(&dep->started_list);
>> +		while(--timeout) {
>> +			/*
>> +			 * Note: don't check the last enqueued TRB in case
>> +			 * of short transfer. Check first TRB of a started
>> +			 * request instead.
>> +			 */
>> +			if (!(req->trb->ctrl & DWC3_TRB_CTRL_HWO))
>> +				break;
>> +
>> +			udelay(2);
>> +		}
>> +		if (!timeout) {
>> +			dev_warn(dep->dwc->dev,
>> +				 "%s is still in-progress\n", dep->name);
>> +			return -ETIMEDOUT;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * __dwc3_stop_active_transfer - stop the current active transfer
>>    * @dep: isoc endpoint
>> @@ -2003,10 +2031,12 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
>>   	WARN_ON_ONCE(ret);
>>   	dep->resource_index = 0;
>>   
>> -	if (!interrupt)
>> +	if (!interrupt) {
>> +		ret = dwc3_poll_ep_completion(dep);
> 
> Actually, the TRB status may not get updated, so this may not work,
> instead of polling, may need to add the delay here instead.
> 

Yeah, I just gave it a try, and I get the ETIMEDOUT error all the time. 
  Don't think we can utilize the HWO bit here.

Thanks
Wesley Cheng
