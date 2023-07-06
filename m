Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14215749E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjGFNtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGFNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:49:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F321990;
        Thu,  6 Jul 2023 06:49:04 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366AsPaY018900;
        Thu, 6 Jul 2023 13:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7Cpj3QvckdCcnQmh8EzvGDtgP4bc9V7BUNFPKA7zVAc=;
 b=GUvdzncr+OZa9sf36nOmclVLOESNju8e7TMD9KVXXXhyFBgjVcru8xly5UtYNAWfCF58
 V4zaCXcAI9RlR+vFhBCJU5KwLW3LKyXlkwUv1JYXIfXfxzuVJ7Y1D2Yef8/abiFodj8O
 ya220LaMdiOyjqzvjNUKTaCa/+mHLUHg3RuvNPtxLAvitxtcbuK0F2aoJxJEXXVjKlJP
 c3VUJ1qvzjpxeHyjFhbjPVsWciTsVX/0M3ddCv6is7PHIeO15XAG/OwLLmYQukhC4wls
 k+iRl+JJuFoIUE7UZJuScdH80auOtTFxi310TqKZp1DDJptFtnzPmmtjWLyeHnNrRATe EQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn5ht393u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 13:49:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366Dn0GK014191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 13:49:00 GMT
Received: from [10.216.57.11] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 06:48:57 -0700
Message-ID: <fb973659-c645-a4f2-e0fe-a40536e8b9fc@quicinc.com>
Date:   Thu, 6 Jul 2023 19:18:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v2] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
References: <20230514145118.20973-1-quic_kriskura@quicinc.com>
 <20230517001105.v74dyo6asqtcrpii@synopsys.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230517001105.v74dyo6asqtcrpii@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aBITCC__nrX_cAoYpbSYUKDUwnHNMCyz
X-Proofpoint-GUID: aBITCC__nrX_cAoYpbSYUKDUwnHNMCyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060123
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2023 5:41 AM, Thinh Nguyen wrote:
> On Sun, May 14, 2023, Krishna Kurapati wrote:
>> Currently for dwc3_usb31 controller, if maximum_speed is limited to
>> super-speed in DT, then device mode is limited to SS, but host mode
>> still works in SSP.
>>
>> The documentation for max-speed property is as follows:
>>
>> "Tells USB controllers we want to work up to a certain speed.
>> Incase  this isn't passed via DT, USB controllers should default to
>> their maximum HW capability."
>>
>> It doesn't specify that the property is only for device mode.
>> There are cases where we need to limit the host's maximum speed to
>> SuperSpeed only. Use this property for host mode to contrain host's
>> speed to SuperSpeed.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>> Link to v1: https://urldefense.com/v3/__https://lore.kernel.org/all/20230512170107.18821-1-quic_kriskura@quicinc.com/__;!!A4F2R9G_pg!dCg_3WK2oNXNb6d0a_VuyjkeeZJTU1aY4dik6g35XB7mtG7EJeR1uPMfxFja49OfXp7Yhsg1yqjnylCYYEg7YCAhqfAZ0Q$
>>
>> Discussion regarding the same at:
>> https://urldefense.com/v3/__https://lore.kernel.org/all/e465c69c-3a9d-cbdb-d44e-96b99cfa1a92@quicinc.com/__;!!A4F2R9G_pg!dCg_3WK2oNXNb6d0a_VuyjkeeZJTU1aY4dik6g35XB7mtG7EJeR1uPMfxFja49OfXp7Yhsg1yqjnylCYYEg7YCDRLUrJWg$
>>
>>   drivers/usb/dwc3/core.c | 8 ++++++++
>>   drivers/usb/dwc3/core.h | 5 +++++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 278cd1c33841..33bc72595e74 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1262,6 +1262,14 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   		}
>>   	}
>>   
>> +	if ((hw_mode != DWC3_GHWPARAMS0_MODE_GADGET) &&
>> +	    (DWC3_IP_IS(DWC31)) &&
>> +	    (dwc->maximum_speed == USB_SPEED_SUPER)) {
>> +		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
>> +		reg |= DWC3_LLUCTL_FORCE_GEN1;
>> +		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
>> +	}
>> +
> 
> Perhaps this should be done for every usb3 port rather than just the
> port_0. This patch can go after your multi-port series is added to
> Greg's branch where you can check for number of usb3 ports.
> 
> Thanks,
> Thinh
> 

Hi Thinh,

   Seems like multiport would take little more time and I need this 
patch to be ported to ACK for fixing customer issue. Would it be 
possible to take this patch as is ? Once multiport is done, I will send 
another patch to include the changes for mutliport as well.

Regards,
Krishna,
