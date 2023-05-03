Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6154B6F4F46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjECDtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjECDtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:49:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED430FD;
        Tue,  2 May 2023 20:49:33 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3433jeTA013662;
        Wed, 3 May 2023 03:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9a0PygH4KMTy2kAkM+eQoTz+dwgMqcMezYOrO1mLYFw=;
 b=GeTDBU6p6HqmOlNczLpeDikBipYWpK3W+RigB1tWhNwcwvmp94nLVViP3MmFgQ28m3H4
 qt3rZTe1UN2LdJ4AEG7yX0c3l6wmADRst2nY5lLOvoUDWM2g2xCXXEKRlZ/+CsZuPLq6
 8taDsRgJIx2If1uxIo9Eq5R+JnsTMWatIwTScYuMCUzLlIPOAtXb62XPpzNXSA9+nVXG
 ypW/ba1YXROtHL6+S/x1w6z2uj/YRZNFwsIPUWE9V5yqRzsQg2Dpddyd0QH7Y/StlgGE
 2Azqh+swyMBtdognQk5UyHYa9Sn58gzKK8JYIgZAHh+iwxlybanMWFWQFzhb0CA8WdTq mQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qawak2g5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 03:49:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3433nM0A009643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 03:49:22 GMT
Received: from [10.217.216.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 2 May 2023
 20:49:16 -0700
Message-ID: <3492e396-e693-83eb-2d85-bb29fc014caf@quicinc.com>
Date:   Wed, 3 May 2023 09:19:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 4/9] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Content-Language: en-US
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
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-5-quic_kriskura@quicinc.com>
 <20230502214419.rzybyuozzvslinwe@synopsys.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230502214419.rzybyuozzvslinwe@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vE2M_2rk0GctaEiUuozexyQyu-TY2CE2
X-Proofpoint-ORIG-GUID: vE2M_2rk0GctaEiUuozexyQyu-TY2CE2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_14,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030030
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/2023 3:14 AM, Thinh Nguyen wrote:
> On Mon, May 01, 2023, Krishna Kurapati wrote:
>> On some SoC's like SA8295P where the tertiary controller is host-only
>> capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
>> Trying to setup them up during core_init leads to a crash.
>>
>> For DRD/Peripheral supported controllers, event buffer setup is done
>> again in gadget_pullup. Skip setup or cleanup of event buffers if
>> controller is host-only capable.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c | 22 ++++++++++++++++------
>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index b8ac7bcee391..8625fc5c7ab4 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -835,7 +835,12 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
>>   
>>   static void dwc3_core_exit(struct dwc3 *dwc)
>>   {
>> -	dwc3_event_buffers_cleanup(dwc);
>> +	unsigned int	hw_mode;
>> +
>> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>> +	if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST)
>> +		dwc3_event_buffers_cleanup(dwc);
> 
> I think it's cleaner to do these checks in dwc3_event_buffers_cleanup
> and dwc3_event_buffers_setup.
> 
> Thanks,
> Thinh
> 

Hi Thinh,

  Good point. Will move these checks to respective functions in next 
version. Thanks for pointing it out.

Regards,
Krishna,
>> +
>>   	dwc3_phy_power_off(dwc);
>>   	dwc3_phy_exit(dwc);
>>   	dwc3_clk_disable(dwc);
>> @@ -1141,10 +1146,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   	if (ret)
>>   		goto err_exit_phy;
>>   
>> -	ret = dwc3_event_buffers_setup(dwc);
>> -	if (ret) {
>> -		dev_err(dwc->dev, "failed to setup event buffers\n");
>> -		goto err_power_off_phy;
>> +	if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST) {
>> +		ret = dwc3_event_buffers_setup(dwc);
>> +		if (ret) {
>> +			dev_err(dwc->dev, "failed to setup event buffers\n");
>> +			goto err_power_off_phy;
>> +		}
>>   	}
>>   
>>   	/*
>> @@ -1958,7 +1965,10 @@ static int dwc3_probe(struct platform_device *pdev)
>>   
>>   err_exit_debugfs:
>>   	dwc3_debugfs_exit(dwc);
>> -	dwc3_event_buffers_cleanup(dwc);
>> +
>> +	if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST)
>> +		dwc3_event_buffers_cleanup(dwc);
>> +
>>   	dwc3_phy_power_off(dwc);
>>   	dwc3_phy_exit(dwc);
>>   	dwc3_ulpi_exit(dwc);
>> -- 
>> 2.40.0
