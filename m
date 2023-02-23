Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3698B6A03BE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjBWIXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjBWIW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:22:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698E025BA2;
        Thu, 23 Feb 2023 00:22:57 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N4Rqqe028908;
        Thu, 23 Feb 2023 08:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=irwNEIwjU/aOQgKDPC8WClp9r0SmDm+bSdGgwdt5bnI=;
 b=Sqjee2jGAKmJz87Xb2LOSlOXau7dPNTBMzC+miA/Q3MjS7scQVM+QCm6Na+QwxE4Juy0
 O9Hnrl2RxerKDJPl4djgQ3ITr5P4GiMdbmTIzR7AGiVGohy70EP785bmeozFna1beGNf
 8xkGvRbTaZfR4BUaLORdK0xJ5vue+5AT0v2xc4Uojsxsl/9AjxxHTTFudF77yefUXXxy
 OqRPDbX9347Xqlt0DgbZDC078RLm3SM2yMnW1IsSPJvICBZNS4pElsFtbiHc8WZCJJCX
 23EI743GIKUxocwB/i//jjbtGdVQyio3ugce45PtmlUvo2QSXGneQFSS4E2X2sReHvzm xw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwybm0r6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 08:22:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31N8MVYS019166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 08:22:31 GMT
Received: from [10.206.28.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 00:22:25 -0800
Message-ID: <699d0d70-4d83-7bc6-e152-0a352a016e71@quicinc.com>
Date:   Thu, 23 Feb 2023 13:52:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 2/2] usb: gadget: composite: Draw 100mA current if not
 configured
Content-Language: en-US
To:     Jack Pham <quic_jackp@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1677129510-10283-1-git-send-email-quic_prashk@quicinc.com>
 <1677129510-10283-3-git-send-email-quic_prashk@quicinc.com>
 <20230223073329.GA3727894@hu-jackp-lv.qualcomm.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20230223073329.GA3727894@hu-jackp-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LpXwxortHBBHV1yhtcGhZUhYwbdRZOlS
X-Proofpoint-GUID: LpXwxortHBBHV1yhtcGhZUhYwbdRZOlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_04,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=849
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230072
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23-02-23 01:03 pm, Jack Pham wrote:
> Hi Prashanth,
> 
> On Thu, Feb 23, 2023 at 10:48:30AM +0530, Prashanth K wrote:
>> Currently we don't change the current value if device isn't in
>> configured state. But the battery charging specification says,
>> the device can draw upto 100mA of current if its in unconfigured
> 
> Here you say spec says "up to" (BTW you have a typo) 100mA...
> 
Will fix it in v2
>> state. Hence add a Vbus_draw work in composite_resume to draw
>> 100mA if the device isn't configured.
> 
> But here and in the patch you are calling the function to draw exactly
> 100mA.  Consider the possibility that a gadget could be configured to
> draw less current than that or not anything at all, we should make sure
> to honor that as an absolute maximum.
That's right
> 
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>> ---
>>   drivers/usb/gadget/composite.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
>> index fa7dd6c..147d278 100644
>> --- a/drivers/usb/gadget/composite.c
>> +++ b/drivers/usb/gadget/composite.c
>> @@ -2531,6 +2531,8 @@ void composite_resume(struct usb_gadget *gadget)
>>   			usb_gadget_clear_selfpowered(gadget);
>>   
>>   		usb_gadget_vbus_draw(gadget, maxpower);
>> +	} else {
>> +		usb_gadget_vbus_draw(gadget, 100);
> 
> Similar to the configured case, maybe you can perform a min()
> calculation against either or both the config->MaxPower or
> CONFIG_USB_GADGET_VBUS_DRAW.
> 
Thanks for the suggestion, will update it in v2 patch
> Thanks,
> Jack
