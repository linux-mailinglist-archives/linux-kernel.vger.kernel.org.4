Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21176D78A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbjDEJmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjDEJmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:42:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5543D5272;
        Wed,  5 Apr 2023 02:42:45 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3359bdDg030345;
        Wed, 5 Apr 2023 09:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rifoQKjJ7dW24fVehVkxpHsAT1KcDWFIbp13UKPByL8=;
 b=QGC7siTwURkXN4YuMBdzjR36hsYWv9pMoDRLaRJMRSrJympGvenDwT6wiQAnZwGKH5X5
 aVFl/mBV/ZSZNNPqcVQIW0dyv0og/zzxvM2jpxVXuHQLVglsD52IR0f7XGQprhirINzX
 +01bSGIJxBEnu4GIskCchImQdeg1XbgNyNKiYfXsiXmbRSKHKmIt6wOGg/Tmq1g9+TSZ
 uWISnAWyGe+rPz4NGCoOBUm4OXxU7lgIicx4v6KNv3fTsxKTqdtKghB2jzhSP2rGDbBz
 a5A9/ts7830oVmpwm0oiJ0wYBZPoiJO6E+DQ41q/HXe7Uc9MOKqG4c35GlHJkgaGypOh KQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prpg228fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 09:42:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3359gdfr008109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 09:42:39 GMT
Received: from [10.50.42.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 5 Apr 2023
 02:42:35 -0700
Message-ID: <75ba0395-7c82-0b72-b954-41c8e4e026d2@quicinc.com>
Date:   Wed, 5 Apr 2023 15:12:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] media: venus: dec: Fix handling of the start cmd
Content-Language: en-US
To:     =?UTF-8?Q?Micha=c5=82_Krawczyk?= <mk@semihalf.com>,
        Vikash Garodia <vgarodia@qti.qualcomm.com>
CC:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>
References: <20230130105423.1338554-1-mk@semmihalf.com>
 <20230130135418.1604455-1-mk@semmihalf.com>
 <CAJMMOfNJV+eOqTgUoLLWKQe2MJ=6fXL3aaP6d=YrSBQvfhOXiA@mail.gmail.com>
 <DM8PR02MB8169B2AC8918F8E31628F61AF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <CAJMMOfN-6fgN0VohA5ViwVXmNWtA13ycfZFoO4ys9_CLes0feA@mail.gmail.com>
 <CAJMMOfM41dfqx0NoiHGE=8X5hoRHo1=qPEp4KXLP1kygestEJQ@mail.gmail.com>
 <CAJMMOfN6tUzGZOkP6ZXbKCr-vszqf3nnRM-dhXfpOUSiHr2EHA@mail.gmail.com>
 <CAJMMOfNzkp9wFfwmov3T8f3KheY4hzu+4AnwXf7iLjKRQQbDzA@mail.gmail.com>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <CAJMMOfNzkp9wFfwmov3T8f3KheY4hzu+4AnwXf7iLjKRQQbDzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oUrpwQV6wvXmIrzISV6AWiZPe9skmCcS
X-Proofpoint-ORIG-GUID: oUrpwQV6wvXmIrzISV6AWiZPe9skmCcS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_05,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=944 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050089
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/2023 2:59 PM, Michał Krawczyk wrote:
> Hi,
>
> just a kindly reminder about the patch.
>
> Thanks,
> Michał

Hi Michal,

this patch is part of latest PR 
https://patchwork.linuxtv.org/project/linux-media/patch/20230404192722.144496-1-stanimir.k.varbanov@gmail.com/ 


Thanks,

Dikshita

> pt., 10 mar 2023 o 16:05 Michał Krawczyk <mk@semihalf.com> napisał(a):
>> Hi,
>>
>> Any update on this patch? It would be great if we could make some
>> progress there (and, hopefully, finally merge it :))
>>
>> Thanks,
>> Michał
>>
>> pt., 10 lut 2023 o 16:18 Michał Krawczyk <mk@semihalf.com> napisał(a):
>>> Hi,
>>>
>>> I'm wondering if there are any more comments for this patch? I would
>>> be happy to clarify anything that's unclear or improve the code if
>>> needed.
>>>
>>> I know it's pretty late, but it would be really great if this fix
>>> could land before v6.2 is released, so I'd appreciate your help and
>>> review.
>>>
>>> Thank you,
>>> Michał
>>>
>>> wt., 7 lut 2023 o 12:15 Michał Krawczyk <mk@semihalf.com> napisał(a):
>>>> wt., 7 lut 2023 o 10:54 Vikash Garodia <vgarodia@qti.qualcomm.com> napisał(a):
>>>>> I have reviewed the patch, and the drain sequence handling looks good to me.
>>>>> Could you share some details on the test client which you are using to catch this issue ?
>>>> Hi Vikash,
>>>>
>>>> Thank you for looking at the code!
>>>>
>>>> I've been testing it using the Chromium implementation of the V4L2
>>>> codec [1]. Meanwhile, we were running a test suite which changes the
>>>> encryption method in the middle of the video decoding. This triggers
>>>> the flush behavior and the Chromium sends the stop/start cmd to the
>>>> V4L2 kernel component, and the test expects the video to continue the
>>>> playback normally. Unfortunately, it was causing a stall of the video
>>>> at the same time.
>>>>
>>>> [1] https://source.chromium.org/chromium/chromium/src/+/main:media/gpu/v4l2/
>>>>
>>>>>> Thank you,
>>>>>> Michał
>>>>> Thanks,
>>>>> Vikash
