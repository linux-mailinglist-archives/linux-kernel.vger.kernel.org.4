Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10E68C7A7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBFUaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjBFUaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:30:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC72C2A142;
        Mon,  6 Feb 2023 12:30:22 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316JkveZ009586;
        Mon, 6 Feb 2023 20:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VUVE+4OB/gY7oqLRljgHDTCtDScJU9v4s1MnY6To8/Y=;
 b=p0DoSDsVgGZemAM1ND80q98+0Y34mMqZDm9ozKGa7xxLFF+gnqnchvHlx/DwM1I/OTPB
 7ZT/UtkHuuIwRKhk12k8YR7/j+ytBd2yaJgFtAj5MijQXK+b9Qtdtftd/RYMPN6s9n98
 bvoYAdSIADLQAT6m89qhnQIMH/6PVdJMfE9c2Eg15R09HZ954Qp/e9aHC0UZwa/y9Ufa
 CbR1lpBC8SPxkVp8P7j7vIXOKBiQOl+G4LbAeiw0zGpd6m5d+0n+H7xhbi+dtZSBDl2Y
 GEvwFm9CukRhGzo1tMZq46i07+/b+uu+s2Fcn2Dk0qrspfnEbbjb9nDx6q7Zi2WZQkP4 Sg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhd2qcrmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 20:30:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316KUGq6020525
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 20:30:16 GMT
Received: from [10.110.22.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 12:30:15 -0800
Message-ID: <2cd37948-8927-3a30-eb40-846d7ac8f0fd@quicinc.com>
Date:   Mon, 6 Feb 2023 12:30:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/5] usb: gadget: Properly configure the device for
 remote wakeup
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <balbi@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-2-git-send-email-quic_eserrao@quicinc.com>
 <Y+Fft/vGfHxGrvC0@rowland.harvard.edu>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <Y+Fft/vGfHxGrvC0@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _SNwgRh8E5MZQRZ3fbOkpnI2KF26Gg8t
X-Proofpoint-GUID: _SNwgRh8E5MZQRZ3fbOkpnI2KF26Gg8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 mlxlogscore=567 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060177
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2023 12:14 PM, Alan Stern wrote:
> On Mon, Feb 06, 2023 at 11:13:22AM -0800, Elson Roy Serrao wrote:
>> The wakeup bit in the bmAttributes field indicates whether the device
>> is configured for remote wakeup. But this field should be allowed to
>> set only if the UDC supports such wakeup mechanism. So configure this
>> field based on UDC capability. Also inform the UDC whether the device
>> is configured for remote wakeup by implementing a gadget op.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   drivers/usb/gadget/composite.c | 24 +++++++++++++++++++++++-
>>   drivers/usb/gadget/udc/core.c  | 27 +++++++++++++++++++++++++++
>>   drivers/usb/gadget/udc/trace.h |  5 +++++
>>   include/linux/usb/gadget.h     |  8 ++++++++
>>   4 files changed, 63 insertions(+), 1 deletion(-)
> 
>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> index dc3092c..05d1449 100644
>> --- a/include/linux/usb/gadget.h
>> +++ b/include/linux/usb/gadget.h
>> @@ -309,6 +309,7 @@ struct usb_udc;
>>   struct usb_gadget_ops {
>>   	int	(*get_frame)(struct usb_gadget *);
>>   	int	(*wakeup)(struct usb_gadget *);
>> +	int	(*set_remotewakeup)(struct usb_gadget *, int set);
>>   	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
>>   	int	(*vbus_session) (struct usb_gadget *, int is_active);
>>   	int	(*vbus_draw) (struct usb_gadget *, unsigned mA);
>> @@ -383,6 +384,8 @@ struct usb_gadget_ops {
>>    * @connected: True if gadget is connected.
>>    * @lpm_capable: If the gadget max_speed is FULL or HIGH, this flag
>>    *	indicates that it supports LPM as per the LPM ECN & errata.
>> + * @rw_capable: True if gadget is capable of sending remote wakeup.
>> + * @rw_armed: True if gadget is armed by the host for remote wakeup.
> 
> Minor stylistic request: Could you choose something other than "rw" to
> start these field names?  For too many people, that abbreviation is
> firmly associated with "read/write".  Maybe just "wakeup"?
> 
> Alan Stern

Sure. Agree that "rw" is firmly associated with "read/write". Will just 
rename it to "wakeup"

Thanks
Elson
