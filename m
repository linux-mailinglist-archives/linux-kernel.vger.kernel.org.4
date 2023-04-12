Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6316DFCB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjDLR2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjDLR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:28:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8DC30EE;
        Wed, 12 Apr 2023 10:28:00 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CGj4x7029053;
        Wed, 12 Apr 2023 17:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wGPH4wkOFbxr/rHutk4WUEXFrqfABAb1H+DTcel3+KM=;
 b=dKqxx6ahDP+Bjrg3nvC6lLcepPM4MeawEpr8y9UB9C2eishk1YFSAoY/W5nDapSN1OKH
 uQpMxRONkmrjUEG9MtdFdbS6FxSDr2lqXhtqDPJ4dDeoVxMGxTV8sU2hX2lRwAM7NUAi
 n1k/AZWw61MvtEdTnxs1Efp0sh8iKlAhIsWiGYdmP14P5jBvaoQLatWuWONfqahNW4NI
 E74T+22WdfymNR4F92o/UTlQrD55fiuPbc6wC3I6uNO+h6HVDO+ZNdd0WNfuFcPmPFb9
 zOr0n02X+Kgq4dgdSFMfqAGseohAGNwACo53HInZchttUOYinwzhWFr96THPa4Q8OJfg hQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwqenseer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 17:27:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CHRvp6014816
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 17:27:57 GMT
Received: from [10.216.35.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 10:27:52 -0700
Message-ID: <0eb8dbab-c76b-771f-5a99-3e548ec55731@quicinc.com>
Date:   Wed, 12 Apr 2023 22:57:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] spi: spi-qcom-qspi: Add DMA mode support
Content-Language: en-CA
To:     Mark Brown <broonie@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <dianders@chromium.org>,
        <mka@chromium.org>, <swboyd@chromium.org>,
        <quic_vtanuku@quicinc.com>
References: <1680631400-28865-1-git-send-email-quic_vnivarth@quicinc.com>
 <1680631400-28865-3-git-send-email-quic_vnivarth@quicinc.com>
 <d784dab7-a1a6-4db7-aa13-e39e9904f342@sirena.org.uk>
 <0b182a36-0254-6720-4a35-f9e617c12797@quicinc.com>
 <92690348-21c3-45de-bdb1-d0977b859702@sirena.org.uk>
 <92f61ba4-a847-1ce3-f0c8-e9c0f0fafa0b@quicinc.com>
 <af2db163-9ab2-4efc-af55-933d2cc4c747@sirena.org.uk>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <af2db163-9ab2-4efc-af55-933d2cc4c747@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z5EfOODdVR1csUCQPV7k1vnp2OcQaS6Q
X-Proofpoint-ORIG-GUID: Z5EfOODdVR1csUCQPV7k1vnp2OcQaS6Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120150
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/2023 9:42 PM, Mark Brown wrote:
> On Wed, Apr 12, 2023 at 08:59:06PM +0530, Vijaya Krishna Nivarthi wrote:
>> On 4/6/2023 8:58 PM, Mark Brown wrote:
>>>>>> +	if (ctrl->xfer.dir == QSPI_READ)
>>>>>> +		byte_ptr = (uint8_t *)xfer->rx_buf;
>>>>>> +	else
>>>>>> +		byte_ptr = (uint8_t *)xfer->tx_buf;
>>>>> If we need to cast to or from void * there's some sort of problem.
>>>> the tx_buf is a const void*
>>>> in v2 I will cast for tx_buf only?
>>> Or just keep byte_ptr as const - we're not modifying it are we?
>> We are modifying it, hence did cast for tx_buf only
> If it's being modified won't that upset the callers that thought it was
> const and didn't expect the data to change?

I believe callers wouldn't be upset.

The byte_ptr is being modified (incremented)

It is initialised to tx_buf (a const*) and keeps getting incremented to 
parse data.

No data change.

That should be ok?

