Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555E774E781
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjGKGmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjGKGmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:42:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146A7E0;
        Mon, 10 Jul 2023 23:42:40 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6VsM1014739;
        Tue, 11 Jul 2023 06:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/m8hNfoOHNCYJcdmr72Ic4+ZF5ExGYUC0fUWjBbYOiQ=;
 b=c8YsUD1OQ0gLkAUmgiMA+PYnsOf6mXp0nU2jMnaoT03y2aO2QUagjlPGd8GPyfzslsZY
 RCMgYEFTD4hABJm1GsjUNqWLyg5IxK85h0SxSFDq6eLp8/sxgULul+BUueqAKEJNjede
 BAntgmpxrDy784WGHnB1sQp9XgSY74GE3KLm/YC/rE0Kv0NIl0CCG7Gq6yb8rDBswW0W
 8GprQbM7H1fE9vW7taffg+5vOXAOwy/v5R8RL6zsSuu7PlN0G0s6Wa0owzdcsw6oEA/S
 SaDx8X3bAI0/g8tlcYlRBpb/7U2yJVDuq/N0ZHgU0ty4ESVlltAPgUOdV+8q1h8AtyOZ ow== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs1mnr1q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 06:42:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B6gSAi003793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 06:42:28 GMT
Received: from [10.216.34.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 23:42:20 -0700
Message-ID: <bf62bdf4-cc9e-ba7b-2078-cfd60f5dd237@quicinc.com>
Date:   Tue, 11 Jul 2023 12:12:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
To:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
 <ZJryrhuUrL5APh4o@hovoldconsulting.com>
 <7e32cf95-1565-5736-cc3e-c70e8d8f3ca7@quicinc.com>
Content-Language: en-US
In-Reply-To: <7e32cf95-1565-5736-cc3e-c70e8d8f3ca7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HQ_QtZSsxbaRIAmmppMw52EEi8a1Xoyg
X-Proofpoint-GUID: HQ_QtZSsxbaRIAmmppMw52EEi8a1Xoyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_03,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110057
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/2023 12:29 AM, Krishna Kurapati PSSNV wrote:
> 
> 
> On 6/27/2023 8:01 PM, Johan Hovold wrote:
>> On Wed, Jun 21, 2023 at 10:06:24AM +0530, Krishna Kurapati wrote:
>>> Add support to read Multiport IRQ's related to quad port controller
>>> of SA8295 Device.
>>
>> Please use a more descriptive summary and commit message; "read" is to
>> vague. You're looking up interrupts from the devicetree. Also this
>> should not just be about SA8295.
>>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>>>   drivers/usb/dwc3/dwc3-qcom.c | 108 +++++++++++++++++++++++++++++------
>>>   1 file changed, 91 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>>> index 3de43df6bbe8..3ab48a6925fe 100644
>>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>>> @@ -74,9 +74,9 @@ struct dwc3_qcom {
>>>       struct reset_control    *resets;
>>>       int            hs_phy_irq;
>>> -    int            dp_hs_phy_irq;
>>> -    int            dm_hs_phy_irq;
>>> -    int            ss_phy_irq;
>>> +    int            dp_hs_phy_irq[4];
>>> +    int            dm_hs_phy_irq[4];
>>> +    int            ss_phy_irq[2];
>>
>> As has already been pointed out, you should use a define for these. And
>> you already have DWC3_MAX_PORTS.
>>
>> The driver should not be hardcoding the fact that there are only two SS
>> ports on this particular SoC that you're interested in.
>>
>>>       enum usb_device_speed    usb2_speed;
>>>       struct extcon_dev    *edev;
>>
>>> @@ -535,6 +535,80 @@ static int dwc3_qcom_get_irq(struct 
>>> platform_device *pdev,
>>>       return ret;
>>>   }
>>> +static int dwc3_qcom_setup_mp_irq(struct platform_device *pdev)
>>> +{
>>> +    struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>>> +    char irq_name[15];
>>> +    int irq;
>>> +    int ret;
>>> +    int i;
>>> +
>>> +    for (i = 0; i < 4; i++) {
>>
>> DWC3_MAX_PORTS here too and similar below.
>>
>>> +        if (qcom->dp_hs_phy_irq[i])
>>> +            continue;
>>
>> This is not very nice. You should try to integrate the current lookup
>> code as I told you to do with the PHY lookups. That is, use a single
>> loop for all HS/SS IRQs, and pick the legacy name if the number of ports
>> is 1.
>>
>> Of course, you added the xhci capability parsing to the core driver so
>> that information is not yet available, but you need it in the glue
>> driver also...
>>
>> As I mentioned earlier, you can infer the number of ports from the
>> interrupt names. Alternatively, you can infer it from the compatible
>> string. In any case, you should not need to ways to determine the same
>> information in the glue driver, then in the core part, and then yet
>> again in the xhci driver...
>>
> Hi Johan,
> 
>   The reason why I didn't integrate this with the original function was 
> the ACPI stuff. The MP devices have no ACPI variant. And I think for 
> clarity sake its best to keep these two functions separated.
> 
> Regards,
> Krishna,
> 
>>> +
>>> +        sprintf(irq_name, "dp%d_hs_phy_irq", i+1);
>>
>> Spaces around binary operators. Does not checkpatch warn about that?
>>
>>> +        irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
>>> +        if (irq > 0) {
>>> +            irq_set_status_flags(irq, IRQ_NOAUTOEN);
>>> +            ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>>> +                    qcom_dwc3_resume_irq,
>>> +                    IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>>> +                    irq_name, qcom);
>>> +            if (ret) {
>>> +                dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
>>> +                return ret;
>>> +            }
>>> +        }
>>> +
>>> +        qcom->dp_hs_phy_irq[i] = irq;
>>> +    }
>>> +
>>> +    for (i = 0; i < 4; i++) {
>>> +        if (qcom->dm_hs_phy_irq[i])
>>> +            continue;
>>> +
>>> +        sprintf(irq_name, "dm%d_hs_phy_irq", i+1);
>>> +        irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
>>> +        if (irq > 0) {
>>> +            irq_set_status_flags(irq, IRQ_NOAUTOEN);
>>> +            ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>>> +                    qcom_dwc3_resume_irq,
>>> +                    IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>>> +                    irq_name, qcom);
>>> +            if (ret) {
>>> +                dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
>>> +                return ret;
>>> +            }
>>> +        }
>>> +
>>> +        qcom->dm_hs_phy_irq[i] = irq;
>>> +    }
>>> +
>>> +    for (i = 0; i < 2; i++) {
>>> +        if (qcom->ss_phy_irq[i])
>>> +            continue;
>>> +
>>> +        sprintf(irq_name, "ss%d_phy_irq", i+1);
>>> +        irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
>>> +        if (irq > 0) {
>>> +            irq_set_status_flags(irq, IRQ_NOAUTOEN);
>>> +            ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>>> +                    qcom_dwc3_resume_irq,
>>> +                    IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>>> +                    irq_name, qcom);
>>> +            if (ret) {
>>> +                dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
>>> +                return ret;
>>> +            }
>>> +        }
>>> +
>>> +        qcom->ss_phy_irq[i] = irq;
>>> +    }
>>
>> So the above should all be merged in either a single helper looking up
>> all the interrupts for a port and resused for the non-MP case.
>>
> I agree, Will merge all under some common helper function.
> 

Hi Johan,

  One more thought. To make one single function read all the interrupts 
(Single port or multi port), we need to provide proper inputs to get_irq 
call (i.e., "dp_hs_phy_irq" or dp_hs_phy_irq_X" and for that we need to 
know if device is multiport capable or not.

Either of the following ways needs to be done:

1. Try getting all interrupts (MP or single port) and accordingly save 
it in qcom struct like done in this patch in which case setup_irq and 
get_mp_irq being seperated is the best option and we don't need to 
bother about whether we are MP capable or not.

2. Else, we need to find out if we are MP capable and read number of 
ports and accordingly get the IRQ's which will just complicate the code 
because of_platform_populate is done after setup_irq. Even if I move 
setup_irq to after of_platform_populate, what dwc3 probe was deferred or 
failed, we would not know what IRQ's to read.

3. If we want to know whether we are MP capable or not in dwc3-qcom even 
before of_platform_populate, we need to find out a way to get port info 
which will just be duplication of code or re-implementation of code done 
in core.c [1].

4. One more option would be to defer qcom probe if dwc3 probe is not 
done and move setup_irq to be called after of_platform_populate. This 
way we can be sure we are not dereferencing dwc3->drvdata without 
knowing if it is NULL or not. Since qcom probe happened, we are sure 
dwc3 probe too happened. We would know if we are MP capable or not while 
setting up IRQ and we can read IRQ's appropriately.

Logically, dwc3-qcom is nothing without dwc3 core getting probed and 
becoming active. So it would be better IMO to defer qcom probe if dwc3 
probe doesn't happen and that way even the layering violations too would 
go away. I hope this idea appeals to the issues we are dealing with.

[1]: 
https://lore.kernel.org/all/20230621043628.21485-4-quic_kriskura@quicinc.com/

Adding Bjorn and Konrad as well to know their thoughts on Point-4.

Regards,
Krishna,


>>> +    return 0;
>>> +}
>>> +
>>>   static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>>>   {
>>>       struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>>> @@ -570,7 +644,7 @@ static int dwc3_qcom_setup_irq(struct 
>>> platform_device *pdev)
>>>               dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
>>>               return ret;
>>>           }
>>> -        qcom->dp_hs_phy_irq = irq;
>>> +        qcom->dp_hs_phy_irq[0] = irq;
>>>       }
>>>       irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
>>> @@ -585,7 +659,7 @@ static int dwc3_qcom_setup_irq(struct 
>>> platform_device *pdev)
>>>               dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
>>>               return ret;
>>>           }
>>> -        qcom->dm_hs_phy_irq = irq;
>>> +        qcom->dm_hs_phy_irq[0] = irq;
>>>       }
>>>       irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
>>> @@ -600,10 +674,10 @@ static int dwc3_qcom_setup_irq(struct 
>>> platform_device *pdev)
>>>               dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
>>>               return ret;
>>>           }
>>> -        qcom->ss_phy_irq = irq;
>>> +        qcom->ss_phy_irq[0] = irq;
>>>       }
>>> -    return 0;
>>> +    return dwc3_qcom_setup_mp_irq(pdev);;
>>
>> Stray ;
>>
>>>   }
>>>   static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
>>
>> Johan
