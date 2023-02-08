Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0898868E59A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBHBwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBHBwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:52:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1FD18172;
        Tue,  7 Feb 2023 17:52:06 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3180aul2009117;
        Wed, 8 Feb 2023 01:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oLJevkFLlFiKjSnd7LJea1UbLqOs8bKlvbOj+LlwniI=;
 b=diIcpXkUewVbFxPU9MlrQAgB7E0vgW67AOiBcOJFPbYa/5qO8KYXend8pxYlyYPjwrRR
 PceiAgbpA3nYiT5HUIRQwhcQVwCSvqvkYVDgQn3j3tLGedhFgR/fq6xFuADkUn49OjV8
 C0+qlI4ROJIwHK06fyFeptDTfg6C4VMQnKHUGBAI7cEb0FI5dR4uuZwqVqyS0otsR+AG
 LP3/8knyok+4vZNn3XtG14aImFXAUwMV96o+/Dhxwyj9fePMDyRqQGFEZLtMvyNpmway
 BZYK0xu7dniIBPgJdi7DqGKt+9dN63uqQMWw6TSELcwnh7d1ORYmhugThze0QG5uJ3T6 hw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkgafjsq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 01:52:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3181q1Q3004827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 01:52:01 GMT
Received: from [10.110.65.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 17:52:00 -0800
Message-ID: <cd143a99-f781-fd32-cad2-3df8f8c0d617@quicinc.com>
Date:   Tue, 7 Feb 2023 17:51:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/5] usb: dwc3: Add remote wakeup handling
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-3-git-send-email-quic_eserrao@quicinc.com>
 <20230207004833.tuy52evcgk7sfa4q@synopsys.com>
 <9bcf323a-5660-da47-dd6c-b218f7f26a45@quicinc.com>
 <20230208011017.47o7m3xt63lbih3m@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230208011017.47o7m3xt63lbih3m@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SBi7jOO64VulsuHw8ueQHsCqTeel9ldu
X-Proofpoint-ORIG-GUID: SBi7jOO64VulsuHw8ueQHsCqTeel9ldu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_15,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302080016
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/2023 5:10 PM, Thinh Nguyen wrote:
> On Tue, Feb 07, 2023, Elson Serrao wrote:
>> On 2/6/2023 4:48 PM, Thinh Nguyen wrote:
>>>> +static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
>>>>    {
>>>>    	int			retries;
>>>> @@ -2296,9 +2309,14 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
>>>>    	link_state = DWC3_DSTS_USBLNKST(reg);
>>>>    	switch (link_state) {
>>>> +	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
>>>
>>> It's also possible to do remote wakeup in L1 for highspeed.
>>>
>>
>> The rw_configured flag here is in context of triggering remote wakeup from
>> bus suspend only.
>>
>> The remote wakeup setting for l1 in HighSpeed is controlled through LPM
>> token and overrides/ignores the config desc bmAttributes wakeup bit.
>>
>> Section 4.1 of USB2_LinkPowerMangement_ECN[final] spec "The host system sets the Remote Wake Flag parameter in this request to
>> enable or disable the addressed device
>> for remote wake from L1. The value of this flag will temporarily (while in
>> L1) override the current setting of the
>> Remote Wake feature settable by the standard Set/ClearFeature() commands
>> defined in Universal Serial Bus Specification, revision 2.0, Chapter 9."
>>
>> Please let me know if I am missing something.
>>
> 
> It overrides the setting of the SetFeature request, not the device
> configuration.
> 
> The rw_configured reflects the user configuration. Whether the host
> tries to enable the remote wakeup through SetFeature request or LPM
> token, the device should operate within the user configuration
> limitation.
> 
> If the configuration indicates that it doesn't support remote wakeup, we
> should prevent unexpected behavior from the device. For simplicity, we
> can just return failure to wakeup for all states.
> 
> Thanks,
> Thinh

L1 entry/exit is HW controlled and the remote wakeup is 
conditional.(Section 7.1/Table7.2 of dwc3 data book). Even though we 
block it from
SW the l1 exit will still happen from HW point of view.

To correlate the user configuration with LPM token, I experimented by 
disabling the wakeup bit in the bmAtrributes, but I still see remote 
wakeup bit being set in the LPM token. From the observation it seems 
like there is no correlation between the wakeup bit in the bmAtrributes 
and the wakeup bit in the LPM token.

Regards
Elson

