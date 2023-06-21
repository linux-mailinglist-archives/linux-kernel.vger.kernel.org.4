Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835B973817E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjFUKLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjFUKKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:10:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEAF268F;
        Wed, 21 Jun 2023 03:09:44 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L99aq5018921;
        Wed, 21 Jun 2023 10:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JVJCzTJvDrTDDo6dE0NIvHx6CGGXcb1P1eluTzChahs=;
 b=AGgv5AptzHssLGj/2CPM5Ud17DP8bCeZ1/sMtwpMWRbahlPqQ+ojFsatbAX0fFJVcCa7
 a2j181kP+5LChvpU0bhFV/VWW6tO+XYIDxjsQB2gGxhlhdiIlSIYsGkoi+hDB1JOHYAw
 IwtpZWiZ3oHJpXtBpkQ/SvBsyG8dbJ/pOvFQkXUxsk5WiyutMqFHDzrfjKZ8dZ6GEhz7
 ahoz8IffYNF705Sz4zt7cd6nG/5fmSheI0YxikzvOgAiSX9nD4EX7BvpcUc+zvnUlYS2
 OwnGbzcFV+53OWQGvXWQyUPrJ/XKriPa9Rf+nSUvsZ0Ph27uCAIH5YWTOoIy9wV2jdDN Ww== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbqkh0v1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 10:09:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35LA8trj013751
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 10:08:55 GMT
Received: from [10.217.219.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 21 Jun
 2023 03:08:48 -0700
Message-ID: <525c3f83-86b4-bd42-4088-25e81b53a6bf@quicinc.com>
Date:   Wed, 21 Jun 2023 15:38:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
 <03371bd0-12a5-3109-ebf7-33feeef31bac@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <03371bd0-12a5-3109-ebf7-33feeef31bac@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sfPS3VtHDHIDldpL9vwnOQfS_n1AKuOn
X-Proofpoint-GUID: sfPS3VtHDHIDldpL9vwnOQfS_n1AKuOn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=622
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210086
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/2023 3:35 PM, Konrad Dybcio wrote:
> On 21.06.2023 06:36, Krishna Kurapati wrote:
>> Add support to read Multiport IRQ's related to quad port controller
>> of SA8295 Device.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 108 +++++++++++++++++++++++++++++------
>>   1 file changed, 91 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index 3de43df6bbe8..3ab48a6925fe 100644
>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -74,9 +74,9 @@ struct dwc3_qcom {
>>   	struct reset_control	*resets;
>>   
>>   	int			hs_phy_irq;
>> -	int			dp_hs_phy_irq;
>> -	int			dm_hs_phy_irq;
>> -	int			ss_phy_irq;
>> +	int			dp_hs_phy_irq[4];
>> +	int			dm_hs_phy_irq[4];
>> +	int			ss_phy_irq[2];
> Not sure if that's been raised previously, but having raw numbers here
> is not very descriptive.. MAX_NUM_MP_HSPHY or something would be helpful
> for readability..
> 
> Konrad

Hi Konrad,

   This has been implented in v9. Wasn't there till v8.
Yes, will replace numbers with Macros.

Regards,
Krishna,

>>   	enum usb_device_speed	usb2_speed;
>>   
>>   	struct extcon_dev	*edev;
>> @@ -375,16 +375,16 @@ static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
>>   	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
>>   
>>   	if (qcom->usb2_speed == USB_SPEED_LOW) {
>> -		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
>> +		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq[0]);
>>   	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
>>   			(qcom->usb2_speed == USB_SPEED_FULL)) {
>> -		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
>> +		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq[0]);
>>   	} else {
>> -		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
>> -		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
>> +		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq[0]);
>> +		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq[0]);
>>   	}
>>   
>> -	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
>> +	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq[0]);
>>   }
>>   
>>   static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
>> @@ -401,20 +401,20 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
>>   	 */
>>   
>>   	if (qcom->usb2_speed == USB_SPEED_LOW) {
>> -		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
>> +		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq[0],
>>   						IRQ_TYPE_EDGE_FALLING);
>>   	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
>>   			(qcom->usb2_speed == USB_SPEED_FULL)) {
>> -		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
>> +		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq[0],
>>   						IRQ_TYPE_EDGE_FALLING);
>>   	} else {
>> -		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
>> +		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq[0],
>>   						IRQ_TYPE_EDGE_RISING);
>> -		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
>> +		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq[0],
>>   						IRQ_TYPE_EDGE_RISING);
>>   	}
>>   
>> -	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq, 0);
>> +	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq[0], 0);
>>   }
>>   
>>   static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>> @@ -535,6 +535,80 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
>>   	return ret;
>>   }
>>   
>> +static int dwc3_qcom_setup_mp_irq(struct platform_device *pdev)
>> +{
>> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>> +	char irq_name[15];
>> +	int irq;
>> +	int ret;
>> +	int i;
>> +
>> +	for (i = 0; i < 4; i++) {
>> +		if (qcom->dp_hs_phy_irq[i])
>> +			continue;
>> +
>> +		sprintf(irq_name, "dp%d_hs_phy_irq", i+1);
>> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
>> +		if (irq > 0) {
>> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>> +					qcom_dwc3_resume_irq,
>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> +					irq_name, qcom);
>> +			if (ret) {
>> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
>> +				return ret;
>> +			}
>> +		}
>> +
>> +		qcom->dp_hs_phy_irq[i] = irq;
>> +	}
>> +
>> +	for (i = 0; i < 4; i++) {
>> +		if (qcom->dm_hs_phy_irq[i])
>> +			continue;
>> +
>> +		sprintf(irq_name, "dm%d_hs_phy_irq", i+1);
>> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
>> +		if (irq > 0) {
>> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>> +					qcom_dwc3_resume_irq,
>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> +					irq_name, qcom);
>> +			if (ret) {
>> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
>> +				return ret;
>> +			}
>> +		}
>> +
>> +		qcom->dm_hs_phy_irq[i] = irq;
>> +	}
>> +
>> +	for (i = 0; i < 2; i++) {
>> +		if (qcom->ss_phy_irq[i])
>> +			continue;
>> +
>> +		sprintf(irq_name, "ss%d_phy_irq", i+1);
>> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
>> +		if (irq > 0) {
>> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>> +					qcom_dwc3_resume_irq,
>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> +					irq_name, qcom);
>> +			if (ret) {
>> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
>> +				return ret;
>> +			}
>> +		}
>> +
>> +		qcom->ss_phy_irq[i] = irq;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>>   {
>>   	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>> @@ -570,7 +644,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>>   			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
>>   			return ret;
>>   		}
>> -		qcom->dp_hs_phy_irq = irq;
>> +		qcom->dp_hs_phy_irq[0] = irq;
>>   	}
>>   
>>   	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
>> @@ -585,7 +659,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>>   			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
>>   			return ret;
>>   		}
>> -		qcom->dm_hs_phy_irq = irq;
>> +		qcom->dm_hs_phy_irq[0] = irq;
>>   	}
>>   
>>   	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
>> @@ -600,10 +674,10 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>>   			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
>>   			return ret;
>>   		}
>> -		qcom->ss_phy_irq = irq;
>> +		qcom->ss_phy_irq[0] = irq;
>>   	}
>>   
>> -	return 0;
>> +	return dwc3_qcom_setup_mp_irq(pdev);;
>>   }
>>   
>>   static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
