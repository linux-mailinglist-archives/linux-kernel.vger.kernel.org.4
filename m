Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4531874502C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGBTDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGBTDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:03:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAF2B2;
        Sun,  2 Jul 2023 12:03:02 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 362J0CIf018874;
        Sun, 2 Jul 2023 19:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aDk0CbPYqdwXw3LHu+4P0ayN1L7g9XLPON4I+mSJOeA=;
 b=o+9+oPCYrg9Y0LuoqoWYhlMbPPb/8N45VNHR7Tl+Y2LHbCEgDuSsNvx+kllfre0PSN0D
 7KIAEDfOgO1Jo0cg/U/CzWz9Q4qs2GXqrDY8qmBOh1yp2ev9fieZAwBLXHLJ1JCuSUhO
 KRGZGOC8B0hq2pHX4cNun7RWi7aXvqOQooNK4iO2Lm733/BF0nEHTGBd9pHq8mDxHunE
 mAx25fQsfAKDykFHtlzqPqOszZtQEBiZhnUZjk5iEP36j+TTvNr5zdZ+ZSmpyxPz7Lpq
 D6xzSaoM6Y2Tte4mkpvrQfDlEi79ksjOP/yHTh+Xq0A7vKFnHyHJ25ivARfbAJKraazX AQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjb3vtg1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Jul 2023 19:02:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 362J2mIk012336
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 2 Jul 2023 19:02:48 GMT
Received: from [10.216.46.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Sun, 2 Jul 2023
 12:02:41 -0700
Message-ID: <495c01bd-0085-b6af-743c-4f3b6c596deb@quicinc.com>
Date:   Mon, 3 Jul 2023 00:32:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 07/10] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-8-quic_kriskura@quicinc.com>
 <ZJr6r-cdDCFDc89R@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZJr6r-cdDCFDc89R@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8kNowcqDevf8dlv7ATQYZYeIF3JRWXzH
X-Proofpoint-GUID: 8kNowcqDevf8dlv7ATQYZYeIF3JRWXzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-02_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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



On 6/27/2023 8:35 PM, Johan Hovold wrote:
> On Wed, Jun 21, 2023 at 10:06:25AM +0530, Krishna Kurapati wrote:
>> QCOM SoC SA8295P's tertiary quad port controller supports 2 HS+SS
>> ports and 2 HS only ports. Add support for configuring PWR_EVENT_IRQ's
>> for all the ports during suspend/resume.
> 
> Please be more specific here. You don't seem to be configuring anything.
> 
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 48 +++++++++++++++++++++++++++++++-----
>>   1 file changed, 42 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index 3ab48a6925fe..699485a85233 100644
>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -37,7 +37,11 @@
>>   #define PIPE3_PHYSTATUS_SW			BIT(3)
>>   #define PIPE_UTMI_CLK_DIS			BIT(8)
>>   
>> -#define PWR_EVNT_IRQ_STAT_REG			0x58
>> +#define PWR_EVNT_IRQ1_STAT_REG			0x58
>> +#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
>> +#define PWR_EVNT_IRQ3_STAT_REG			0x228
>> +#define PWR_EVNT_IRQ4_STAT_REG			0x238
>> +
>>   #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
>>   #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
>>   
>> @@ -93,6 +97,13 @@ struct dwc3_qcom {
>>   	struct icc_path		*icc_path_apps;
>>   };
>>   
>> +static u32 pwr_evnt_irq_stat_reg_offset[4] = {
>> +	PWR_EVNT_IRQ1_STAT_REG,
>> +	PWR_EVNT_IRQ2_STAT_REG,
>> +	PWR_EVNT_IRQ3_STAT_REG,
>> +	PWR_EVNT_IRQ4_STAT_REG,
>> +};
>> +
>>   static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>>   {
>>   	u32 reg;
>> @@ -417,17 +428,37 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
>>   	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq[0], 0);
>>   }
>>   
>> +static u8 dwc3_qcom_get_port_info(struct dwc3_qcom *qcom)
> 
> "port_info" is not very specific, call it get_num_ports() or similar.
> 
>> +{
>> +	struct dwc3 __maybe_unused *dwc = platform_get_drvdata(qcom->dwc3);
> 
> __maybe unused makes no sense here.
> 
>> +
>> +	if (dwc3_qcom_is_host(qcom))
>> +		return dwc->num_usb2_ports;
> 
> Here you're accessing the core driver data again, which we want to
> avoid going forward so this at least warrants a FIXME to rework this as
> well.
> 
Ok, will add a FIXME here.

Thanks,
Krishna,
>> +
>> +	/*
>> +	 * If not in host mode, either dwc was not probed
>> +	 * or we are in device mode, either case checking for
>> +	 * only first pwr event irq would suffice.
> 
> Rewrap comment at 80 columns.
> 
>> +	 */
>> +
>> +	return 1;
>> +}
>> +
>>   static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>>   {
>>   	u32 val;
>>   	int i, ret;
>> +	u8 num_ports;
> 
> Move first.
> 
>>   	if (qcom->is_suspended)
>>   		return 0;
>>   
>> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
>> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>> +	num_ports = dwc3_qcom_get_port_info(qcom);
>> +	for (i = 0; i < num_ports; i++) {
>> +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
>> +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>>   		dev_err(qcom->dev, "HS-PHY not in L2\n");
> 
> This line is not indented properly.
> 
> Make sure to run checkpatch before submitting so that I don't have to
> point out things like this again.
> 
>> +	}
>>   
>>   	for (i = qcom->num_clocks - 1; i >= 0; i--)
>>   		clk_disable_unprepare(qcom->clks[i]);
>> @@ -452,12 +483,14 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>>   
>>   static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
>>   {
>> +	int num_ports;
>>   	int ret;
>>   	int i;
>>   
>>   	if (!qcom->is_suspended)
>>   		return 0;
>>   
>> +	num_ports = dwc3_qcom_get_port_info(qcom);
> 
> Move below to where you use num_ports.
> 
>>   	if (dwc3_qcom_is_host(qcom) && wakeup)
>>   		dwc3_qcom_disable_interrupts(qcom);
>>   
>> @@ -474,9 +507,12 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
>>   	if (ret)
>>   		dev_warn(qcom->dev, "failed to enable interconnect: %d\n", ret);
>>   
>> -	/* Clear existing events from PHY related to L2 in/out */
> 
> No need to move the comment.
> 
>> -	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
>> -			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
>> +	for (i = 0; i < num_ports; i++) {
>> +		/* Clear existing events from PHY related to L2 in/out */
>> +		dwc3_qcom_setbits(qcom->qscratch_base,
>> +			pwr_evnt_irq_stat_reg_offset[i],
>> +			PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
> 
> Indent continuation lines at least two tabs further than the previous
> line.
> 
>> +	}
>>   
>>   	qcom->is_suspended = false;
> 
> Johan
