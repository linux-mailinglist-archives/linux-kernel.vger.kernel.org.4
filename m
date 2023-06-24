Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94EA73C756
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 09:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjFXHUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 03:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjFXHUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 03:20:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8CC2729;
        Sat, 24 Jun 2023 00:20:39 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35O7CO9N015475;
        Sat, 24 Jun 2023 07:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fBvo2ccUrGR3qAgIdPxY/V+yLAyvLv/NxPqfmD9xYn4=;
 b=VUdomRtjHo76mY3e8W5FJpc3YRiVYQYtOK/LiDkZZFl6qwtfu1OmL89NGRXdhDHiFsEP
 GZK02Ask8zSDU4M7AgT1nfnKD1gcCOCtFsN7THyE/UpETr87dgzjXdgXupSDGxT+Y2BA
 kbPGmWqqgmVH64/ALGwu/HGWhgsOUDRjPgtzx8qR32ye+76ShV4LobREq1f531SB2qf7
 7PjLceTXnGh9LNO0hLHO8fo/u6CqJ4EBNnYbvrlK++4nAFMo6kXHb/VArH/pSpH4W/ee
 cB0ArEMnhNFWs5W9RTyKJAUX/K/liR09RCAKAVfrq1kqxAPY4OkbpC9c6DO+EIhg50t4 qg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdssdg4pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Jun 2023 07:20:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35O7KNPr001607
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Jun 2023 07:20:23 GMT
Received: from [10.216.12.107] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 24 Jun
 2023 00:20:16 -0700
Message-ID: <19932a93-4fc8-f177-8cd6-b6ecd5e163c2@quicinc.com>
Date:   Sat, 24 Jun 2023 12:50:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 04/10] usb: dwc3: core: Skip setting event buffers for
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
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230623222754.auuce7y6c2e7ymvw@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Fqh_jYxzg15j_BQXRX4k7doVGqAVys-x
X-Proofpoint-ORIG-GUID: Fqh_jYxzg15j_BQXRX4k7doVGqAVys-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-24_04,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306240067
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2023 3:57 AM, Thinh Nguyen wrote:
> On Wed, Jun 21, 2023, Krishna Kurapati wrote:
>> On some SoC's like SA8295P where the tertiary controller is host-only
>> capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
>> Trying to access them leads to a crash.
>>
>> For DRD/Peripheral supported controllers, event buffer setup is done
>> again in gadget_pullup. Skip setup or cleanup of event buffers if
>> controller is host-only capable.
>>
>> Suggested-by: Johan Hovold <johan@kernel.org>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 32ec05fc242b..e1ebae54454f 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -486,6 +486,11 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
>>   static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
>>   {
>>   	struct dwc3_event_buffer *evt;
>> +	unsigned int hw_mode;
>> +
>> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST)
>> +		return 0;
> 
> This is a little awkward. Returning 0 here indicates that this function
> was successful, and the event buffers were allocated based on the
> function name. Do this check outside of dwc3_alloc_one_event_buffer()
> and specifically set dwc->ev_buf = NULL if that's the case.
> 
Hi Thinh,

   Apologies, I didn't understand the comment properly.

   I thought we were supposed to return 0 here if we fulfill the goal of 
this function (allocate if we are drd/gadget and don't allocate if we 
are host mode only).

   If we return a non zero error here, probe would fail as this call 
will be done only for host only controllers during probe and nowhere else.

   Are you suggesting we move this check to dwc3_alloc_one_event_buffer 
call ?

Regards,
Krishna,

>>   
>>   	evt = dwc3_alloc_one_event_buffer(dwc, length);
>>   	if (IS_ERR(evt)) {
>> @@ -507,6 +512,9 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>   {
>>   	struct dwc3_event_buffer	*evt;
>>   
>> +	if (!dwc->ev_buf)
>> +		return 0;
>> +
>>   	evt = dwc->ev_buf;
>>   	evt->lpos = 0;
>>   	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
>> @@ -524,6 +532,9 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
>>   {
>>   	struct dwc3_event_buffer	*evt;
>>   
>> +	if (!dwc->ev_buf)
>> +		return;
>> +
>>   	evt = dwc->ev_buf;
>>   
>>   	evt->lpos = 0;
>> -- 
>> 2.40.0
