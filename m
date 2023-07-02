Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6706744FDA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGBSqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGBSqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:46:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DDEC1;
        Sun,  2 Jul 2023 11:46:12 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 362ISs3H008903;
        Sun, 2 Jul 2023 18:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CSwey4wSSrn3wF/KbXkh6mCc5rlJElWsVNXOn3mtjyk=;
 b=Sj+Z4YQkSyJnEnzSeERKcgzsDzyaGg8DznL8QdXACOh2FFSIj2jBLXN1OHcVILLOFhjq
 csQgK5BQ3PvSbkbfwKOxgZrfbdfErS93rDp4E8BSa76wI1pztz6+6tGKXbojgG2pmMcK
 tbpW0Ra5KLg/AROzl432DJP4UiN6effWXzbHoSQlPh502yzIhkNYJQpC3tzHNA007J1y
 Vhbwyc7WFDyvNP/F/3eAmQma9pQ1NVxzUP3xJ/I/aE0C0KkpegFx4NqAPNTdvmvMeO27
 Jgr/zVQE6dxBgxny1UsE102OiQQCf7qaQ34z2uHP9vpwGP37/98LjLBL8nMw8+7t6Mem og== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjcwnj9qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Jul 2023 18:45:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 362IjlIb025101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 2 Jul 2023 18:45:47 GMT
Received: from [10.216.46.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Sun, 2 Jul 2023
 11:45:41 -0700
Message-ID: <9e4ad4b4-60a5-77ec-02ed-183079696e0c@quicinc.com>
Date:   Mon, 3 Jul 2023 00:15:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 04/10] usb: dwc3: core: Skip setting event buffers for
 host only controllers
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-5-quic_kriskura@quicinc.com>
 <20230623222754.auuce7y6c2e7ymvw@synopsys.com>
 <19932a93-4fc8-f177-8cd6-b6ecd5e163c2@quicinc.com>
 <20230626233424.2flncnsvfzb2ccbt@synopsys.com>
 <20230626234626.aqhaluh6wnat6gxx@synopsys.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230626234626.aqhaluh6wnat6gxx@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gSL9FsWvpihQuWTisiVBKrZL1edSkVeh
X-Proofpoint-ORIG-GUID: gSL9FsWvpihQuWTisiVBKrZL1edSkVeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-02_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307020179
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2023 5:16 AM, Thinh Nguyen wrote:
> On Mon, Jun 26, 2023, Thinh Nguyen wrote:
>> On Sat, Jun 24, 2023, Krishna Kurapati PSSNV wrote:
>>>
>>>
>>> On 6/24/2023 3:57 AM, Thinh Nguyen wrote:
>>>> On Wed, Jun 21, 2023, Krishna Kurapati wrote:
>>>>> On some SoC's like SA8295P where the tertiary controller is host-only
>>>>> capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
>>>>> Trying to access them leads to a crash.
>>>>>
>>>>> For DRD/Peripheral supported controllers, event buffer setup is done
>>>>> again in gadget_pullup. Skip setup or cleanup of event buffers if
>>>>> controller is host-only capable.
>>>>>
>>>>> Suggested-by: Johan Hovold <johan@kernel.org>
>>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>>> ---
>>>>>    drivers/usb/dwc3/core.c | 11 +++++++++++
>>>>>    1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>>> index 32ec05fc242b..e1ebae54454f 100644
>>>>> --- a/drivers/usb/dwc3/core.c
>>>>> +++ b/drivers/usb/dwc3/core.c
>>>>> @@ -486,6 +486,11 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
>>>>>    static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
>>>>>    {
>>>>>    	struct dwc3_event_buffer *evt;
>>>>> +	unsigned int hw_mode;
>>>>> +
>>>>> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>>>>> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST)
>>>>> +		return 0;
>>>>
>>>> This is a little awkward. Returning 0 here indicates that this function
>>>> was successful, and the event buffers were allocated based on the
>>>> function name. Do this check outside of dwc3_alloc_one_event_buffer()
>>>> and specifically set dwc->ev_buf = NULL if that's the case.
>>>>
>>> Hi Thinh,
>>>
>>>    Apologies, I didn't understand the comment properly.
>>>
>>>    I thought we were supposed to return 0 here if we fulfill the goal of this
>>> function (allocate if we are drd/gadget and don't allocate if we are host
>>> mode only).
>>
>> The name of the function implies that it returns 0 if it allocated the
>> event buffer. If there are multiple conditions to the function returning
>> 0 here, then we should document it.
>>
>>>
>>>    If we return a non zero error here, probe would fail as this call will be
>>> done only for host only controllers during probe and nowhere else.
>>>
>>>    Are you suggesting we move this check to dwc3_alloc_one_event_buffer call
>>> ?
>>>
>>> Regards,
>>> Krishna,
>>>
>>
>> I'm suggesting to move the check to the caller of
>> dwc3_alloc_one_event_buffer(). Something like this so that it's
>> self-documented:
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 0beaab932e7d..bba82792bf6f 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1773,6 +1773,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>   	struct resource		*res, dwc_res;
>>   	void __iomem		*regs;
>>   	struct dwc3		*dwc;
>> +	unsigned int		hw_mode;
>>   	int			ret;
>>   
>>   	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
>> @@ -1854,11 +1855,16 @@ static int dwc3_probe(struct platform_device *pdev)
>>   
>>   	pm_runtime_forbid(dev);
>>   
>> -	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
>> -	if (ret) {
>> -		dev_err(dwc->dev, "failed to allocate event buffers\n");
>> -		ret = -ENOMEM;
>> -		goto err_allow_rpm;
>> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
>> +		dwc->ev_buf = NULL;
>> +	} else {
>> +		ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
>> +		if (ret) {
>> +			dev_err(dwc->dev, "failed to allocate event buffers\n");
>> +			ret = -ENOMEM;
>> +			goto err_allow_rpm;
>> +		}
>>   	}
>>   
>>   	dwc->edev = dwc3_get_extcon(dwc);
>>
> 
> Actually, please ignore. there's already a document there, I missed that
> for some reason. What you did is fine. Though, I don't see the condition
> for ev_buf = NULL anywhere. Can you add that for clarity?
> 
> Thanks,
> Thinh

Hi Thinh,

  Did you mean adding "dwc->ev_buf = NULL" specifically ?

Regards,
Krishna,
