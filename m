Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665A770D07C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjEWBZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjEWBZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:25:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1525EA1;
        Mon, 22 May 2023 18:25:43 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N1F6l1018876;
        Tue, 23 May 2023 01:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EdqM0dtaRztc5M568A/0EhtBZnbRMupo6KYD4joIcus=;
 b=DTAUdfRNF/dgQfjc/jVINQml3h6mG7rRwGlpFXsYPIhxqmqswiMAmUp49Dkdst64ngTw
 JXHJ9/15xgCgfc0aIEqqPxNcIeeGw4YsapBFsoOPTIIFZACFPBjUoevv6Wn5fn70WJqb
 15JkPsJxZuI+JKsteM/DluBTDWiDyxHUNCYHnz4F5IR8wxkQOLhXiAh9qB6eig3Wt5pk
 VryPYXdsjF3KJ1j5mn+jipIbT378DYHT4SRgvk+KqaHmiOa+dGiV4G0tGK3rIIPuIF9l
 krQg/4HmMSzVFlqIrFgkQJwZ3pzJrA8KMW3N3g4w0ickCquF4Irz/u0syCnvNgWeX7LO fA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qracsh423-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 01:25:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N1Pc4c015860
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 01:25:38 GMT
Received: from [10.216.55.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 22 May
 2023 18:25:36 -0700
Message-ID: <e0f0275a-9418-5aa7-58c6-4ac9ae03e0ae@quicinc.com>
Date:   Tue, 23 May 2023 06:55:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC] usb: dwc3: gadget: Fix amount of data copied from event buf
 to cache
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
References: <20230521100330.22478-1-quic_kriskura@quicinc.com>
 <20230522211651.rr2r3caz6ni7m6xr@synopsys.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230522211651.rr2r3caz6ni7m6xr@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cp7uHJfRYJrwn6FGO_SI9-XReDFgBVZP
X-Proofpoint-ORIG-GUID: cp7uHJfRYJrwn6FGO_SI9-XReDFgBVZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_18,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=654 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230009
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/2023 2:47 AM, Thinh Nguyen wrote:
> On Sun, May 21, 2023, Krishna Kurapati wrote:
>> In the current implementation, the check_event_buf call reads the
>> GEVNTCOUNT register to determine the amount of event data generated
>> and copies it from ev->buf to ev->cache after masking interrupt.
>>
>> During copy if the amount of data to be copied is more than
>> (length - lpos), we fill the ev->cache till the end of 4096 byte
>> buffer allocated and then start filling from the top (lpos = 0).
>>
>> In one instance of SMMU crash it is observed that GEVNTCOUNT register
>> reads more than 4096 bytes:
>>
>> dwc3_readl   base=0xffffffc0091dc000  offset=50188  value=63488
>>
>> (offset = 50188 -> 0xC40C)  -> reads 63488 bytes
>>
>> As per crash dump:
>> dwc->lpos = 2056
>>
>> and evt->buf is at 0xFFFFFFC009185000 and the crash is at
>> 0xFFFFFFC009186000. The diff which is exactly 0x1000 bytes.
>>
>> We first memcpy 2040 bytes from (buf + lpos) to (buf + 0x1000).
>>
>> And then we copy the rest of the data (64388 - 2040) from beginning
>> of dwc->ev_buf. While doing so we go beyond bounds as we are trying
>> to memcpy 62348 bytes into a 4K buffer resulting in crash.
>>
>> Fix this by limiting the total data being copied to ev->length to
>> avoid copying data beyond bounds. Moreover this is logical because if
>> the controller generated events more than the size of ring buffer,
>> some of them might have been overwritten by the controller.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>> Only one instance of this crash was observed so far. As per the
>> databook:
>>
>> "The controller always leaves one entry free in each Event Buffer.
>> When the Event Buffer is almost full, hardware writes the Event
>> Buffer Overflow event and the USB eventually gets stalled when
>> endpoints start responding NRDY or the link layer stops returning
>> credits (in SuperSpeed). This event is an indication to software that
>> it is not processing events quickly enough. During this time, events
>> are queued up internally. When software frees up Event Buffer space,
>> the queued up events are written out and the USB returns to normal
>> operation"
>>
>> I didn't see any overflow event in the event buffer after parsing
>> crash dump. Although this could be some HW issue, I thought we can
>> include this fix in software as well to avoid such scenario.
>>
> 
> What's the GEVNTSIZ at the point of the crash? That's where the driver
> tells the controller how much it allocated for the event buffer.
> 
> Check to make sure that it wasn't reset during operation (not cleanup).


Hi Thinh,

  The last 3 RW traces were as follows:

<idle>-0    [001]   5834.471640:  dwc3_writel   base=0xffffffc0091dc000  
offset=50184  value=4096
<idle>-0    [001]   5834.471799:  dwc3_readl   base=0xffffffc0091dc000  
offset=50188  value=63488
<idle>-0    [001]   5834.471803:  dwc3_writel   base=0xffffffc0091dc000  
offset=50184  value=2147487744

The first one was at the end of previous process_event_entry call where 
we unmasked the interrupt.

The second one was the read of GEVTCOUNT.

The third one was where we wrote 31st bit of the GEVTSIZ register to 
mask interrupt along with 4096 bytes to [15:0] bits.

There is only 100-150us gap between each of these read writes and if you 
are referring to whether the GEVTSIZ got modified in between, I am not 
sure of that.

Regards,
Krishna,
