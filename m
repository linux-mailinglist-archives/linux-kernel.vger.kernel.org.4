Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583256874D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjBBFAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBBFAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:00:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0DB9777;
        Wed,  1 Feb 2023 21:00:40 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3123gu3s022309;
        Thu, 2 Feb 2023 05:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qWbOJ8VUcKB31ZLvmUsN6pg/CzBAGUNxfP2D2y4p5yI=;
 b=kXksn5zB/0oDu5mfI7CS/Aclkkb26YOzn6kfJGuutGaQAyU4ppH7+BI2vJIpgd3ylenB
 v814EmwQ4TsqnCIWQ0z0UhLj9T2OjTz/TZhAJ/H3h6NfNv/co6BBwNk6SDivMbDcPNhV
 iuSZZIF5ALBu8pDqACw2truMeGM/53sFNfmoLJA4em7w3Ogxkbj25aEFUsvV0phf2cpT
 c+5Qomi6WLoVoQKAYZLMd6g7GuhDlCjtlHc5xYL2vPadgolC59XbvPMCxNZBB5l3hZ3B
 Z9T9sI9qR/77WMlkLsJ+hVlJHpBoR3YwdKXmuZCznS8ngQI12oVICCFl2kzvcHaCw+ok Jw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfm9g2ang-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 05:00:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31250VT0006263
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 05:00:31 GMT
Received: from [10.239.154.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 21:00:29 -0800
Message-ID: <4723be6d-a9c5-17f4-f8d4-6ab0e81d866e@quicinc.com>
Date:   Thu, 2 Feb 2023 13:00:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     =?UTF-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>,
        'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>
References: <20230109182813.sle5h34wdgglnlph@synopsys.com>
 <e7217471-5b08-eee6-fba8-06e879118d77@quicinc.com>
 <20230110025310.nowjnrmo3oag76xd@synopsys.com>
 <4ced9c3e-c7b5-e0a0-88ec-1ac383d893a2@quicinc.com>
 <bfcfac21-3df7-7f47-576b-0717f2bab393@quicinc.com>
 <f35f0636-5b3f-9002-77f3-a3c2c53be973@quicinc.com>
 <20230111000021.r2bd5gnfwlbxzxd3@synopsys.com>
 <826538ae-d27a-fc03-c8dc-94b53c8a44cf@quicinc.com>
 <20230111022720.mcrhdrthgwlwszcv@synopsys.com>
 <c76d426c-c65b-1334-627a-1a6c615ddd93@quicinc.com>
 <20230201185742.lc26zheeuhvfuxet@synopsys.com>
Content-Language: en-US
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20230201185742.lc26zheeuhvfuxet@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 09eN_czkXPqUCITJ11YV7theHsfiZhEO
X-Proofpoint-GUID: 09eN_czkXPqUCITJ11YV7theHsfiZhEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_15,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=453 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020045
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/2/2023 2:57 AM, Thinh Nguyen wrote:
> On Tue, Jan 31, 2023, Linyu Yuan wrote:
>> hi Thinh,
>>
>>
>> regarding your suggestion, assume it is not PCIe type,  still have one
>> question,
>>
>>
>> -       if (evt->flags & DWC3_EVENT_PENDING)
>> +       if (evt->flags & DWC3_EVENT_PENDING) {
>> +               if (!evt->count) {
>> +                       u32 reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
>> +
>> +                       if (!(reg & DWC3_GEVNTSIZ_INTMASK))
>> +                               evt->flags &= ~DWC3_EVENT_PENDING;
>>
>> do we need to return IRQ_WAKE_THREAD  ?
> No, if evt->count is 0, but GEVNTCOUNT is > 0, the controller will
> generate interrupt. The evt->count will be updated and the events will
> be handled on the next interrupt.


when will next interrupt happen ?

as when enter here, i guess GEVENTCOUNT is already > 0, but we didn't 
read it.


>
>> +               }
>>                  return IRQ_HANDLED;
>>
>> as here return IRQ HANDLED, how can we make sure a new IRQ will be handled
>> after previous IRQ thread clean PENDING flag ?
> If evt->count > 0, that means the bottom half is still running. So,
> leave it be. If evt->count == 0, then the cached events are processed,
> we're safe to clear the PENDING flag. New interrupt will be generated if
> GEVNTCOUNT is > 0.
>
>> +       }
>>
>>
>> also for non-PCIe controller, consider IRQ mask register working correctly,
>>
>> consider a case IRQ happen before IRQ thread exit,  here just return
>> IRQ_HANDLED.
>>
>> once IRQ thread exit, it will clean PENDING flag, so next IRQ event will run
>> normally.
>>
>> if 정재훈 saw PENDING flag is not cleared, does it mean IRQ thread have no
>> chance to exit ?
> The PENDING flag should be cleared eventually when the bottom half
> completes. I don't expect the interrupt storm to block the IRQ thread
> forever, but I can't guarantee the device behavor. 정재훈 can confirm.
> This change should resolve the interrupt storm.
>
> BR,
> Thinh
