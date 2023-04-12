Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016146DFA03
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjDLP2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjDLP2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:28:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5497ED7;
        Wed, 12 Apr 2023 08:28:45 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CA9nNi010892;
        Wed, 12 Apr 2023 15:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+CKzftLH9AiqsVfSbZiEhyikaE6TktvLi9DPv++7q/c=;
 b=S/4B/WwBIAyBQyVP/Yiz4CCjnJbglwKS5B30dLzOBMyjs3VAO2HcokIzGG7bw/tsLoSq
 Cj9KICvQiIzNbNuunK1riZRxkwMqmtn0gxHXAIRkRrKIjj/4AIQ03gtizjiFGzy79FtM
 XySoJ9XV7BqNiwnBGYxFRtU6mbhg0nElrUR6JcwC7BZuoJwP+n/x0hurvhXvLjkGA7U1
 mphfoBf7Gxo/MO5SjoYm/J9BqeWSef6AQMJBx0hUk0sjjXi4bB23bvDRvgXEb8sLvbcN
 iq5EmWf6AKeYAWUIvVvoFHElNSOpEaekYkpDg+R77eqeVr7eQq/iH1bx7JGp9WJ/vPVv Vg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwhht9uhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 15:28:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CFSfjH021725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 15:28:41 GMT
Received: from [10.216.35.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 08:28:36 -0700
Message-ID: <c2c802e0-73fb-a362-7e46-f6a7ec40d6b1@quicinc.com>
Date:   Wed, 12 Apr 2023 20:58:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] spi: Add DMA mode support to spi-qcom-qspi
Content-Language: en-CA
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <robh+dt@kernel.org>,
        <vkoul@kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <dianders@chromium.org>,
        <mka@chromium.org>, <quic_vtanuku@quicinc.com>
References: <1680631400-28865-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAE-0n52U7yG=5DzYiHCH=JR4LvdczvhpuaU3RXqX6K9VwfvEgw@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAE-0n52U7yG=5DzYiHCH=JR4LvdczvhpuaU3RXqX6K9VwfvEgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UaSWJMz3SaB9ecd3jaXvpnGVTacM6Bb8
X-Proofpoint-ORIG-GUID: UaSWJMz3SaB9ecd3jaXvpnGVTacM6Bb8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_06,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=721
 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120134
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the review...


On 4/5/2023 2:00 AM, Stephen Boyd wrote:
> Quoting Vijaya Krishna Nivarthi (2023-04-04 11:03:18)
>> There are large number of QSPI irqs that fire during boot/init and later
>> on every suspend/resume.
>> This could be made faster by doing DMA instead of PIO.
>> Below is comparison for number of interrupts raised in 2 acenarios...
>> Boot up and stabilise
>> Suspend/Resume
>>
>> Sequence   PIO    DMA
>> =======================
>> Boot-up    69088  19284
>> S/R        5066   3430
>>
> The interrupts are less, yes, but does it save time or power?

We have not made measurements but the change is expected to improve 
performance.

Testing revealed no regressions.

