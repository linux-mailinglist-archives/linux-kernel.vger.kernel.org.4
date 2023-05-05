Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01296F85AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjEEP3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjEEP3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:29:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A4DA5F4;
        Fri,  5 May 2023 08:29:27 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345DnXX8017298;
        Fri, 5 May 2023 15:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BieRpCSj/d7y3We7CfAN6ykwkElaxu/ernWEbwjTbM8=;
 b=VTAhHKH0vmsea2ASR/SsCJF0NJhrhau2x1iKieQyGZ/+Pnpw7y/bHlL/v7iL2TYYXUzk
 yIStJvmhnKSfFdq4OPJOSQjzLhpHTaPWKjKWUOIVqmzN+3UFBfQO3jxT9wV34puOgpEQ
 2I724ndp1mgoZqz3AiAwF1p6IY+UkExxFIRWt0UAfrFMXXj24BeXL4CO68FWM0+b/yYE
 kKaWEIdy5ZZjxYo1FjRH3MQr/qU6x3hzG5mnGIGtj7rQd7fpon20iSLt46F+drlNWv4V
 jARcop1uTsqvhJ18EfHpK99jjIUEpCFz6rzNXfsn3Nd00dLp06FLjGi0I8zsOj4+CUXV XA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcmm39x3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 15:28:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 345FSq7g007681
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 15:28:52 GMT
Received: from [10.216.37.178] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 5 May 2023
 08:28:47 -0700
Message-ID: <7b3ba193-c705-e8e2-f3b5-87e9c3cd5650@quicinc.com>
Date:   Fri, 5 May 2023 20:58:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 09/18] media: venus: hfi_venus: Fix version checks in
 venus_halt_axi()
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <20230228-topic-venus-v2-9-d95d14949c79@linaro.org>
 <4a95547d-916a-3875-7752-f815429182e5@quicinc.com>
 <CAA8EJpqBn9odiEfUak0OQUkMU2aSKc6rf07joYOKML0EhM-JKA@mail.gmail.com>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <CAA8EJpqBn9odiEfUak0OQUkMU2aSKc6rf07joYOKML0EhM-JKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fXEheDa0LuvaCr4E2zuPOCuTpXNik7SO
X-Proofpoint-GUID: fXEheDa0LuvaCr4E2zuPOCuTpXNik7SO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_22,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=704 mlxscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1011 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050129
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/2023 8:13 PM, Dmitry Baryshkov wrote:
> On Fri, 5 May 2023 at 16:22, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
>>
>> On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
>>> Only IRIS2(_1) should enter the until-now-IS_V6() path and the
>>> condition for skipping part of it should be IS_IRIS2_1 and not the
>>> number of VPP pipes. Fix that.
>> Do not see any issue with existing code. IRIS2 with single pipe is
>> IRIS2_1. This does not
>>
>> quality as a fix to earlier implementation. Since this series introduces
>> VPU versions,
>>
>> IRIS2 with 1 pipe is being replaced with IRIS2_1.
> Could you please fix the line wrapping of your emails. It becomes hard
> to read them otherwise.

My apologies for the inconvenience. Tried to set the email wrap config, but it 
does not take

an effect on my email client. Will try playing around a bit with it and fix it.

Meanwhile go through the comments and if you can align them with minimal effort, we

can continue to discuss on the same.

-Vikash

>
>
