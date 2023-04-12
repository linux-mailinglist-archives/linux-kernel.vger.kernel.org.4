Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541836DFA10
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDLP3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjDLP3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:29:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3927EFF;
        Wed, 12 Apr 2023 08:29:19 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CFKPcT014612;
        Wed, 12 Apr 2023 15:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CNQmE7gblG6nw+VNHV/YD0dBKmW/jOvX4hy6Np6iGFU=;
 b=JgZjsTCpURKtDjs5C8ClNOE6i4HlVwi57hk/Zg+G82Dmi2MRaeZbsZgDqSHx7RVQgLWS
 8AfLc+CmvreSXmHr84IWVJ2svfAxDuLxVNqlTQ30QOtYMGLtP9A7ehY24IhqOQA+1Pf5
 Uk/3XTLMb65jPoE7VnSupKs1VcS5H2GgYErQUNeEENafAGANflzg2IUw41ZPQIzRpVXa
 NL+4WefRSDD5eqJr9EZkqLx1lVdKN8Ae4OYPBCqzq1MYRmdaI2IdMb+rE9pA1fCH55Yv
 IxrlKIDz6RGPEJ180vpnIuUOWYz7j73VWeSMNAf5uIFKmjAltUuD5DCWFnHSfd+BVHUb Og== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwy6fr0n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 15:29:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CFTEWi025845
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 15:29:14 GMT
Received: from [10.216.35.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 08:29:09 -0700
Message-ID: <92f61ba4-a847-1ce3-f0c8-e9c0f0fafa0b@quicinc.com>
Date:   Wed, 12 Apr 2023 20:59:06 +0530
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
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <92690348-21c3-45de-bdb1-d0977b859702@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1zMC2ldMxcj95SZBy7ZKoXTYfmz_teT5
X-Proofpoint-GUID: 1zMC2ldMxcj95SZBy7ZKoXTYfmz_teT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_06,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=966 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120134
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the responses...


On 4/6/2023 8:58 PM, Mark Brown wrote:
> On Thu, Apr 06, 2023 at 08:23:21PM +0530, Vijaya Krishna Nivarthi wrote:
>> On 4/4/2023 11:47 PM, Mark Brown wrote:
>>> On Tue, Apr 04, 2023 at 11:33:20PM +0530, Vijaya Krishna Nivarthi wrote:
>>>> +	uint32_t reserved2:7;
>>>> +	uint32_t length:16;
>>>> +	//------------------------//
>>> What does this mean?
>> That separates the part of cmd_desc that is visible to the HW and the part
>> that is required by the SW after xfer is complete.
>> I can add a comment in v2?
> Yes, please.


Added comments

>
>>>> +	for (ii = 0; ii < sgt->nents; ii++)
>>>> +		sg_total_len += sg_dma_len(sgt->sgl + ii);
>>> Why are we calling the iterator ii here?
>> Calling it ii helps in finding iterator more easily in code.
>> should I stick to i in v2?
> Given that multiple people queried this...


Renamed.

>
>>>> +	if (ctrl->xfer.dir == QSPI_READ)
>>>> +		byte_ptr = (uint8_t *)xfer->rx_buf;
>>>> +	else
>>>> +		byte_ptr = (uint8_t *)xfer->tx_buf;
>>> If we need to cast to or from void * there's some sort of problem.
>> the tx_buf is a const void*
>> in v2 I will cast for tx_buf only?
> Or just keep byte_ptr as const - we're not modifying it are we?


We are modifying it, hence did cast for tx_buf only

>
>>>> +#if NO_TX_DATA_DELAY_FOR_DMA
>>>> +		mstr_cfg &= ~(TX_DATA_OE_DELAY_MSK | TX_DATA_DELAY_MSK);
>>>> +#endif
>>> Why would we add extra delays if we don't need them, might someone set
>>> this and if so when?
>> I believe its used when some slave devices need a delay between clock and
>> data.
>> Its configured as 1 for PIO_MODE(FIFO) right now.
>> For DMA_MODE we are not using same, both seem to work for DMA.
> If some devices need this to be configured it needs to be configured
> either from the driver for that device or via DT depending on the exact
> requirements.


Retained same MSTR_CONFIG as PIO mode, hence not touching any of the DELAYs

