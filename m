Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB26F704357
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjEPCVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEPCVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:21:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9162D4C31;
        Mon, 15 May 2023 19:21:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G20Z3T003134;
        Tue, 16 May 2023 02:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LiMbVFgnG1PzMz6t/NP0aA0ihJ+GRrYRu08HhKni1nM=;
 b=H/Ojax+A2FC/br0M3kQnFdV9mhPQztpIQfYrmA29e+XvCKb8NGyrsrZZcy8mngZF0hyN
 bIf5hq3/rH+qqpc/kHiNXJmDuLoHK+tY9mxpoaz86kLPVcE7Xbn5rFXrI9v6DqDnzuXN
 Gg1SPFVrry37ZsRkG/0Fo36tAU2QrZvYOz+v24+VZCE0hVj3klbRudP6+MLDU1vNETqQ
 T+YqVS2+ZalziZIcQJdVKjLHtZLGgBipRgh6Ii40GbiJoyYeDz9lWPVnL1XGkT83URor
 zoepB8lCf9qbe2g7cqeRVm0ngrpTeDNRkY6jzEouJfmq+tt7ePPEnjiZDv5dXbjqSWkf DA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkkde1xeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 02:19:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34G2JS61012632
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 02:19:28 GMT
Received: from [10.216.35.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 19:19:19 -0700
Message-ID: <bc347624-4539-4a3a-9399-9b4e272cdb32@quicinc.com>
Date:   Tue, 16 May 2023 07:49:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
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
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230515222730.7snn2i33gkg6ctd2@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B6f2WW032P7KSqQfW5i-uJ1ZII0SbsV2
X-Proofpoint-ORIG-GUID: B6f2WW032P7KSqQfW5i-uJ1ZII0SbsV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160018
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2023 3:57 AM, Bjorn Andersson wrote:
> On Sun, May 14, 2023 at 11:19:14AM +0530, Krishna Kurapati wrote:
>> QCOM SoC SA8295P's tertiary quad port controller supports 2 HS+SS
>> ports and 2 HS only ports. Add support for configuring PWR_EVENT_IRQ's
>> for all the ports during suspend/resume.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 28 ++++++++++++++++++++++------
>>   1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index 959fc925ca7c..7a9bce66295d 100644
>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -37,7 +37,10 @@
>>   #define PIPE3_PHYSTATUS_SW			BIT(3)
>>   #define PIPE_UTMI_CLK_DIS			BIT(8)
>>   
>> -#define PWR_EVNT_IRQ_STAT_REG			0x58
>> +#define PWR_EVNT_IRQ1_STAT_REG			0x58
>> +#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
>> +#define PWR_EVNT_IRQ3_STAT_REG			0x228
>> +#define PWR_EVNT_IRQ4_STAT_REG			0x238
>>   #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
>>   #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
>>   
>> @@ -93,6 +96,13 @@ struct dwc3_qcom {
>>   	struct icc_path		*icc_path_apps;
>>   };
>>   
>> +static u32 pwr_evnt_irq_stat_reg_offset[4] = {
>> +			PWR_EVNT_IRQ1_STAT_REG,
>> +			PWR_EVNT_IRQ2_STAT_REG,
>> +			PWR_EVNT_IRQ3_STAT_REG,
>> +			PWR_EVNT_IRQ4_STAT_REG,
> 
> Seems to be excessive indentation of these...
> 
> Can you also please confirm that these should be counted starting at 1 -
> given that you otherwise talk about port0..N-1?
> 
Hi Bjorn,

   I am fine with either way. Since this just denoted 4 different ports, 
I named them starting with 1. Either ways, we will run through array 
from (0-3), so we must be fine.

>> +};
>> +
>>   static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>>   {
>>   	u32 reg;
>> @@ -413,13 +423,16 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>>   {
>>   	u32 val;
>>   	int i, ret;
>> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
>>   
>>   	if (qcom->is_suspended)
>>   		return 0;
>>   
>> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
>> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> 
> In the event that the dwc3 core fails to acquire or enable e.g. clocks
> its drvdata will be NULL. If you then hit a runtime pm transition in the
> dwc3-qcom glue you will dereference NULL here. (You can force this issue
> by e.g. returning -EINVAL from dwc3_clk_enable()).
> 
> So if you're peaking into qcom->dwc3 you need to handle the fact that
> dwc might be NULL, here and in resume below.
> 
Thanks for catching this. You are right, there were instances where the 
we saw probe for dwc3 being deferred while the probe for dwc3-qcom was 
still successful [1]. In this case, if the dwc3 probe never happened and 
system tries to enter suspend, we might hit a NULL pointer dereference.

I will fix this in v9.

[1]: 
https://patchwork.kernel.org/project/linux-usb/patch/1657809067-25815-1-git-send-email-quic_kriskura@quicinc.com/

Regards,
Krishna,
