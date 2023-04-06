Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D226D9B4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbjDFOyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbjDFOyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:54:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4C5AD0F;
        Thu,  6 Apr 2023 07:53:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336BRajb021527;
        Thu, 6 Apr 2023 14:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=144/9a5w4d6LMS2VG/A2VeehwMyub5orrM6ryH5vSzA=;
 b=J+K+Ze8PA5u+MJC7HXuh+dxN1IhnHTo9csUarNPAgwgxcG4NRbUaSsT8c6WCw1KgLKI0
 4leEgn9e9jsEwcVdCPWmCabfHk6Gi6apAPxTXrGIPKGzglD5xltTjOgww10iUsIzPTUB
 QPWbYMXgvLaAHr33EJwj16fVlJ4k9RlEv49bYTPFFCl/6lPjC6f8HHs2QY3/lh73pBhF
 TedWSBwfVVE5WD8okBHYI87MofwROQcuGn6shIbRAXhLPcTkSCMjpYdN1UZmXSOhz/Y7
 HIfljQQlvMobJ5/5WVYbeoLWNnOyQeEPQCeIFQmXj6orvabXQ/PbeUCzxaasioVtzAR5 vA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psnp99f19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 14:53:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 336ErTmH006376
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 14:53:29 GMT
Received: from [10.242.7.141] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 6 Apr 2023
 07:53:24 -0700
Message-ID: <0b182a36-0254-6720-4a35-f9e617c12797@quicinc.com>
Date:   Thu, 6 Apr 2023 20:23:21 +0530
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
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <d784dab7-a1a6-4db7-aa13-e39e9904f342@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FTB515xfMnRXxct9cx3YcW6-tO07eMVz
X-Proofpoint-GUID: FTB515xfMnRXxct9cx3YcW6-tO07eMVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_08,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=909
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060132
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All reviewers,

Thank you very much for your time and review...

While I am addressing other comments, below are some responses...


On 4/4/2023 11:47 PM, Mark Brown wrote:
> On Tue, Apr 04, 2023 at 11:33:20PM +0530, Vijaya Krishna Nivarthi wrote:
>
> A few quick review comments, mostly coding style though.
>
>> +struct qspi_cmd_desc {
>> +	uint32_t data_address;
>> +	uint32_t next_descriptor;
>> +	uint32_t direction:1;
>> +	uint32_t multi_io_mode:3;
>> +	uint32_t reserved1:4;
>> +	uint32_t fragment:1;
>> +	uint32_t reserved2:7;
>> +	uint32_t length:16;
>> +	//------------------------//
> What does this mean?

That separates the part of cmd_desc that is visible to the HW and the 
part that is required by the SW after xfer is complete.
I can add a comment in v2?


>
>> +	uint8_t *bounce_src;
>> +	uint8_t *bounce_dst;
>> +	uint32_t bounce_length;
>> +};
>> +
>> +#define QSPI_MAX_NUM_DESC 5
>>   struct qspi_xfer {
> Missing blank line after the define...


Will address in v2

>
>> +	for (ii = 0; ii < sgt->nents; ii++)
>> +		sg_total_len += sg_dma_len(sgt->sgl + ii);
> Why are we calling the iterator ii here?


Calling it ii helps in finding iterator more easily in code.

should I stick to i in v2?

>
>> +	if (ctrl->xfer.dir == QSPI_READ)
>> +		byte_ptr = (uint8_t *)xfer->rx_buf;
>> +	else
>> +		byte_ptr = (uint8_t *)xfer->tx_buf;
> If we need to cast to or from void * there's some sort of problem.


the tx_buf is a const void*

in v2 I will cast for tx_buf only?

>
>> +/* Switch to DMA if transfer length exceeds this */
>> +#define QSPI_MAX_BYTES_FIFO 64
>> +#define NO_TX_DATA_DELAY_FOR_DMA 1
>> +#define DMA_CONDITIONAL (xfer->len > QSPI_MAX_BYTES_FIFO)
>> +
> DMA_CONDITIONAL absolutely should not be a define, this just makes
> things harder to read.  Just have everything call can_dma() when needed.


Will address in v2

>
>> +#if NO_TX_DATA_DELAY_FOR_DMA
>> +		mstr_cfg &= ~(TX_DATA_OE_DELAY_MSK | TX_DATA_DELAY_MSK);
>> +#endif
> Why would we add extra delays if we don't need them, might someone set
> this and if so when?


I believe its used when some slave devices need a delay between clock 
and data.

Its configured as 1 for PIO_MODE(FIFO) right now.

For DMA_MODE we are not using same, both seem to work for DMA.

>
>> +	if (ctrl->xfer_mode == QSPI_FIFO) {
>> +	} else if (ctrl->xfer_mode == QSPI_DMA) {
>>   	}
> This should be a switch statement.


Will address in v2

