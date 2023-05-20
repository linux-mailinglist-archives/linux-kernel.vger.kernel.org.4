Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F5570A98C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 19:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjETRtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 13:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETRtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 13:49:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E41FE;
        Sat, 20 May 2023 10:49:20 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34KHZaF1022141;
        Sat, 20 May 2023 17:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wdCQtM23kxcqy0mJxEhLVyw5NatUGRuk6iC7VRXMSSE=;
 b=i0T2lmo/+iuDUMC2SMkcy4Ye1FQTzCmNpTvBgJ666SA0mCZLp3fZ5hm9rsu24jmZ48g+
 /7xUo37e87T4dl0RYEWYYcNkm0FfPQCGA93HVn4e0fHxDvLxs4bbA59+QwZlhoZ66NCZ
 bnmcwBG6wbs5y9ZPa3pYBXyiYj/d2qmPWMp/NR2dvIMzTnUyohW3VECnJjtFoApzEW2g
 6U1p9i6nFU8ZUSYOPILhN2KyrXMGVh6pKF09XuufcPlwUEnGuLMLITbjlIEVqGWDM2ZB
 8CaN3ZQpil9VlZ0RM05xsFsUEurTWe1zLMkWZFVtQitUzgRMtr3zMYehhDTr5jv6nt+u Bw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpnhrrtck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 May 2023 17:49:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34KHn2AE022885
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 May 2023 17:49:02 GMT
Received: from [10.216.53.219] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 20 May
 2023 10:48:56 -0700
Message-ID: <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
Date:   Sat, 20 May 2023 23:18:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
To:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <20230515222730.7snn2i33gkg6ctd2@ripper>
 <bc347624-4539-4a3a-9399-9b4e272cdb32@quicinc.com>
 <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MvrQRWEnatqphUhg7q78TW1y2sULij7o
X-Proofpoint-GUID: MvrQRWEnatqphUhg7q78TW1y2sULij7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-20_10,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305200156
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2023 10:07 PM, Johan Hovold wrote:
> On Tue, May 16, 2023 at 07:49:14AM +0530, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 5/16/2023 3:57 AM, Bjorn Andersson wrote:
>>> On Sun, May 14, 2023 at 11:19:14AM +0530, Krishna Kurapati wrote:
> 
>>>> -#define PWR_EVNT_IRQ_STAT_REG			0x58
>>>> +#define PWR_EVNT_IRQ1_STAT_REG			0x58
>>>> +#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
>>>> +#define PWR_EVNT_IRQ3_STAT_REG			0x228
>>>> +#define PWR_EVNT_IRQ4_STAT_REG			0x238
>>>>    #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
>>>>    #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
>>>>    
>>>> @@ -93,6 +96,13 @@ struct dwc3_qcom {
>>>>    	struct icc_path		*icc_path_apps;
>>>>    };
>>>>    
>>>> +static u32 pwr_evnt_irq_stat_reg_offset[4] = {
>>>> +			PWR_EVNT_IRQ1_STAT_REG,
>>>> +			PWR_EVNT_IRQ2_STAT_REG,
>>>> +			PWR_EVNT_IRQ3_STAT_REG,
>>>> +			PWR_EVNT_IRQ4_STAT_REG,
>>>
>>> Seems to be excessive indentation of these...
>>>
>>> Can you also please confirm that these should be counted starting at 1 -
>>> given that you otherwise talk about port0..N-1?
> 
>>     I am fine with either way. Since this just denoted 4 different ports,
>> I named them starting with 1. Either ways, we will run through array
>> from (0-3), so we must be fine.
> 
> Actually, the USB ports are indexed from 1, so the above naming may or
> may not be correct depending on how they are defined.
> 
Ok, will rename them as PWR_EVNT_IRQx_STAT_REG  (x = 0,1,2,3)

>>>> +};
>>>> +
>>>>    static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>>>>    {
>>>>    	u32 reg;
>>>> @@ -413,13 +423,16 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>>>>    {
>>>>    	u32 val;
>>>>    	int i, ret;
>>>> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
>>>>    
>>>>    	if (qcom->is_suspended)
>>>>    		return 0;
>>>>    
>>>> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
>>>> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>>>> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
>>>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>>>
>>> In the event that the dwc3 core fails to acquire or enable e.g. clocks
>>> its drvdata will be NULL. If you then hit a runtime pm transition in the
>>> dwc3-qcom glue you will dereference NULL here. (You can force this issue
>>> by e.g. returning -EINVAL from dwc3_clk_enable()).
>>>
>>> So if you're peaking into qcom->dwc3 you need to handle the fact that
>>> dwc might be NULL, here and in resume below.
>>>
>> Thanks for catching this. You are right, there were instances where the
>> we saw probe for dwc3 being deferred while the probe for dwc3-qcom was
>> still successful [1]. In this case, if the dwc3 probe never happened and
>> system tries to enter suspend, we might hit a NULL pointer dereference.
> 
> I don't think we should be adding more of these layering violations. A
> parent device driver has no business messing with the driver data for a
> child device which may or may not even have probed yet.
> 
> I added a FIXME elsewhere in the driver about fixing up the current
> instances that have already snuck in (which in some sense is even worse
> by accessing driver data of a grandchild device).
> 
> We really need to try sort this mess out and how to properly handle the
> interactions between these layers (e.g. glue, dwc3 core and xhci). This
> will likely involve adding callbacks from the child to the parent, for
> example, when the child is suspending.
> 

Hi Johan,

  I agree with you, but in this case I believe there is no other way we 
can find the number of ports present. Unless its a dt property which 
parent driver can access the child's of node and get the details. Like 
done in v4 [1]. But it would be adding redundant data into DT as pointed 
out by Rob and Krzysztof and so we removed these properties.

Also, since this is a read only operation being done and no 
modifications are being done to driver data of child, is it still not 
acceptable as both dwc3-qcom and core are tightly coupled entities.

[1]: 
https://lore.kernel.org/all/20230115114146.12628-2-quic_kriskura@quicinc.com/

Regards,
Krishna,
