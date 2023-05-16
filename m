Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814F47050BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjEPO2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjEPO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:28:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A861BC6;
        Tue, 16 May 2023 07:28:34 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GCAecw004449;
        Tue, 16 May 2023 14:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RMFXA7ZudVjHyZ4kH0k4IsYmxdb+amxND9ev4TL+PJg=;
 b=i/5efG5oQ5S2n9dcGNFeOm50w+dd95BVSdWs0r2Rtt0DZE1wBsIXyA3+CBQQLoEa/2/S
 Vw0TlhR4RHyjdzJ3HIK/5SIWg0+NyXvG9CjoCpE8sqvjKK9A8BwNIRe04llJ4P0+/uea
 2Hdql0k7wyPUwOVqSCrLHoIJwSdAdnX3hv6vdWUtUa3bWd7YhKXuwmLKqzm/MxU5wkuy
 lMsyXvkUlaHdnHmMXoLiuw4iPqd2j2JORBwsLa5rSBvwkcVRio51LQdCXtvy2i/UB+e3
 w7VV4qY4c1t22DOv0szZ6PfHXTXqIFqrcFml2evPj8cF8NqLSSUcygoCHRoby15jLm8K dw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qm1x096x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 14:28:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34GESL02026238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 14:28:22 GMT
Received: from [10.216.35.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 07:28:14 -0700
Message-ID: <52b5c1ac-ac69-2ca7-1bf4-01b1f53b1634@quicinc.com>
Date:   Tue, 16 May 2023 19:58:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 4/9] usb: dwc3: core: Skip setting event buffers for
 host only controllers
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
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-5-quic_kriskura@quicinc.com>
 <ZGN0W0YbIjzmQnH1@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZGN0W0YbIjzmQnH1@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: THSS0IZNn5baN6Z7Bij_d4pFBAaLOwkV
X-Proofpoint-GUID: THSS0IZNn5baN6Z7Bij_d4pFBAaLOwkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_07,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160121
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2023 5:47 PM, Johan Hovold wrote:
> On Sun, May 14, 2023 at 11:19:12AM +0530, Krishna Kurapati wrote:
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
>>   drivers/usb/dwc3/core.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index e983aef1fb93..46192d08d1b6 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -505,6 +505,11 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
>>   int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>   {
>>   	struct dwc3_event_buffer	*evt;
>> +	unsigned int			hw_mode;
>> +
>> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST)
>> +		return 0;
>>   
>>   	evt = dwc->ev_buf;
> 
> How about adding this check to dwc3_alloc_event_buffers() instead as
> there should be no need to allocate buffer that you never use?
> 
> Then you can just check dwc->ev_buf here and elsewhere.
> 

Thanks for this idea. We can save 4096 bytes from being allocated this 
way. Will get this in next version.

Regards,
Krishna,
