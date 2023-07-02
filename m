Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267D8745031
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGBTGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGBTGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:06:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6C5C3;
        Sun,  2 Jul 2023 12:06:09 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 362IwqKo015994;
        Sun, 2 Jul 2023 19:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0oDgH5WYwZFsjzVdjS/xQcqQZu98vFXtz1e2rIXEPpU=;
 b=Zc5xFQn1VKw6ssNahBR3bjeU6zcIXO9yA0Z2uiYNlUlbqMeknAvR5hjO9EBCd/HbkdEl
 Hv34jbmeAJKXghifW6yZKkYgXpVcTevrq+JbpSOyOUa/1j+gW1/0grulZGc1mGXzHGg0
 yjXJLML+1PrcR/Un4veUMO9sXUvalg/Tht79YMXpa8N9OpJs5f/AjhfSKZW3dkCykJqR
 nyoh7g5Vxpw09GRvbZdq6RBiPn72b5Pz5wYRkJYn/9gdXLi6/kIKfjXMyb6KVpkwEFfo
 YCLo7aBvgbaprwYTxfYx/VKDEs0scNiqeVOCE9yu9K2AuFXAyJ7XoVgaUV2byKEGi6gZ Mg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjdedtb7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Jul 2023 19:05:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 362J5vwh026076
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 2 Jul 2023 19:05:57 GMT
Received: from [10.216.46.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Sun, 2 Jul 2023
 12:05:51 -0700
Message-ID: <26ae15d1-4e13-3ab7-6844-3a7d3ed03af4@quicinc.com>
Date:   Mon, 3 Jul 2023 00:35:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <ZIB1JEmLCw41v_4e@hovoldconsulting.com>
 <ZJsDpqttBYtbQ0yg@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZJsDpqttBYtbQ0yg@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bmQMhqCz952k0LEaCQKtBBoNL7hBFCd5
X-Proofpoint-ORIG-GUID: bmQMhqCz952k0LEaCQKtBBoNL7hBFCd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-02_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 mlxlogscore=802 impostorscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307020182
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2023 9:13 PM, Johan Hovold wrote:
> Hi Krishna,
> 
> On Wed, Jun 07, 2023 at 02:16:37PM +0200, Johan Hovold wrote:
>> On Sun, May 14, 2023 at 11:19:14AM +0530, Krishna Kurapati wrote:
> 
>>>   static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>>>   {
>>>   	u32 reg;
>>> @@ -413,13 +423,16 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>>>   {
>>>   	u32 val;
>>>   	int i, ret;
>>> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
>>>   
>>>   	if (qcom->is_suspended)
>>>   		return 0;
>>>   
>>> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
>>> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>>> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
>>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>>> +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
>>> +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>>> +			dev_err(qcom->dev, "HS-PHY%d not in L2\n", i);
>>> +	}
> 
>> When testing this on the X13s I get:
>>
>> 	dwc3-qcom a4f8800.usb: HS-PHY2 not in L2
>>
>> for the third port, whose status registers always seems to return zero
>> (e.g. as if we're checking the wrong register?):
>>
>> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 0, pwr_event_stat = 38103c
>> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 1, pwr_event_stat = 38103c
>> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 2, pwr_event_stat = 00
>> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 3, pwr_event_stat = 140030
>>
>> I verified that everything appears to work as expected on sa8295p-adp.
>>
>> Do you have any idea of what may be causing this?
> 
> You never replied to this; do you have any idea why the status register
> for the second port seemingly always read back as 0 on the X13s?
> 
> Johan

Hi Johan,

  Missed this mail. This never popped up on my system. So no idea what 
is different in Lenovo X13s. Might need to check with team internally.

Regards,
Krishna,
