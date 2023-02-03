Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E62688D04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 03:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjBCCTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 21:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBCCTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:19:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8543C6B03A;
        Thu,  2 Feb 2023 18:19:09 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3131nnQ6019722;
        Fri, 3 Feb 2023 02:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3+2q7J7ZvpaiX4JNzYcJe2YteisoZ+lBYkt0CBWZbQQ=;
 b=Yonu8krH3hBGn5Dakz0A1iZtk6QWq83DNd0ga7pbojiyRUUpLM6ZprR3f+k/fP/tXB7C
 p/TaYJ5UhBZu+jNp+73YweXo3glaYhKE9KNIifLniyRBpjUCvmhLjt49iuyYAxPGbMlk
 W03+O8ZZWEiuQkXcfcZQJJNr7DTsRqhpbT9atp57dLDoiPkkfe8Q2YXV/LsV8uTF1myd
 vnk8AqyNWtNQkavLqUOMwJm2+5y2rEDkAj2IdRACXN4GEpHDPNH8OKJhhdYXHPP/ebEr
 A4xkXwipIODGuq2CiA/F1FKvcD0JE7tw7yIKj1QDSWM3D+484YxctRFXx1XUz6N5B+RO vQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ngns30c6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 02:19:03 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3132J21J005947
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 02:19:02 GMT
Received: from [10.239.154.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 18:19:00 -0800
Message-ID: <1ffed097-af47-a179-3854-f7b238d8b6de@quicinc.com>
Date:   Fri, 3 Feb 2023 10:18:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        =?UTF-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>
CC:     'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>
References: <20230110025310.nowjnrmo3oag76xd@synopsys.com>
 <4ced9c3e-c7b5-e0a0-88ec-1ac383d893a2@quicinc.com>
 <bfcfac21-3df7-7f47-576b-0717f2bab393@quicinc.com>
 <f35f0636-5b3f-9002-77f3-a3c2c53be973@quicinc.com>
 <20230111000021.r2bd5gnfwlbxzxd3@synopsys.com>
 <826538ae-d27a-fc03-c8dc-94b53c8a44cf@quicinc.com>
 <20230111022720.mcrhdrthgwlwszcv@synopsys.com>
 <c76d426c-c65b-1334-627a-1a6c615ddd93@quicinc.com>
 <20230201185742.lc26zheeuhvfuxet@synopsys.com>
 <4723be6d-a9c5-17f4-f8d4-6ab0e81d866e@quicinc.com>
 <20230202200650.cqntlk7m2krsafgd@synopsys.com>
Content-Language: en-US
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20230202200650.cqntlk7m2krsafgd@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yGu7zhB39Zi1-6wzNWluPcOPN2Q7dUiN
X-Proofpoint-GUID: yGu7zhB39Zi1-6wzNWluPcOPN2Q7dUiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_16,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=396 adultscore=0 phishscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030019
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/3/2023 4:06 AM, Thinh Nguyen wrote:
> On Thu, Feb 02, 2023, Linyu Yuan wrote:
>> On 2/2/2023 2:57 AM, Thinh Nguyen wrote:
>>> On Tue, Jan 31, 2023, Linyu Yuan wrote:
>>>> hi Thinh,
>>>>
>>>>
>>>> regarding your suggestion, assume it is not PCIe type,  still have one
>>>> question,
>>>>
>>>>
>>>> -       if (evt->flags & DWC3_EVENT_PENDING)
>>>> +       if (evt->flags & DWC3_EVENT_PENDING) {
>>>> +               if (!evt->count) {
>>>> +                       u32 reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
>>>> +
>>>> +                       if (!(reg & DWC3_GEVNTSIZ_INTMASK))
>>>> +                               evt->flags &= ~DWC3_EVENT_PENDING;
>>>>
>>>> do we need to return IRQ_WAKE_THREAD  ?
>>> No, if evt->count is 0, but GEVNTCOUNT is > 0, the controller will
>>> generate interrupt. The evt->count will be updated and the events will
>>> be handled on the next interrupt.
>>
>> when will next interrupt happen ?
> Immediately after. You can test this by just return IRQ_HANDLED and not
> clear the GEVNTCOUNT to see its behavior.


if it immediately, it will be good.


정재훈  could you update a new patch which Thinh suggest.

maybe we didn't find the root cause of irq strom, but the change have no side effect.


>
>> as when enter here, i guess GEVENTCOUNT is already > 0, but we didn't read
>> it.
> GEVNTCOUNT is always updating as new events are generated. We only clear
> however many events we process, but that doesn't stop it from
> incrementing.


just consider if there is a case that next GEVNETCOUNT increase which 
happen long time later,

maybe think too much.


>
> BR,
> Thinh
>
>>
>>>> +               }
>>>>                   return IRQ_HANDLED;
>>>>
>>>> as here return IRQ HANDLED, how can we make sure a new IRQ will be handled
>>>> after previous IRQ thread clean PENDING flag ?
>>> If evt->count > 0, that means the bottom half is still running. So,
>>> leave it be. If evt->count == 0, then the cached events are processed,
>>> we're safe to clear the PENDING flag. New interrupt will be generated if
>>> GEVNTCOUNT is > 0.
>>>
>>>> +       }
>>>>
>>>>
>>>> also for non-PCIe controller, consider IRQ mask register working correctly,
>>>>
>>>> consider a case IRQ happen before IRQ thread exit,  here just return
>>>> IRQ_HANDLED.
>>>>
>>>> once IRQ thread exit, it will clean PENDING flag, so next IRQ event will run
>>>> normally.
>>>>
>>>> if 정재훈 saw PENDING flag is not cleared, does it mean IRQ thread have no
>>>> chance to exit ?
>>> The PENDING flag should be cleared eventually when the bottom half
>>> completes. I don't expect the interrupt storm to block the IRQ thread
>>> forever, but I can't guarantee the device behavor. 정재훈 can confirm.
>>> This change should resolve the interrupt storm.
>>>
>>> BR,
>>> Thinh
