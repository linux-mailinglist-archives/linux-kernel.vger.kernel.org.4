Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2501C6F2F42
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjEAIGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEAIGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:06:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9FB1B5;
        Mon,  1 May 2023 01:06:11 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3417hKhE011405;
        Mon, 1 May 2023 08:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Rle8bKJBv7BeolK2uUwXVWTmk4t6mgx/fZQsE5q0Ipk=;
 b=mtby8MWzi9KmOcMgxM8H56vyVYtvKJ9W5tpLT+nRA1HrzMYYUnnFCvjCicY03yFbQrzg
 CxVhE3Xovp9yJi0TPBrLjAWBmLsaSYmlmPblKwJyU4N1wizBAGePcjRI1ALEmj3rNcqx
 aqsUBvNQ1OF3QhVIBspG7pKFJmCVOSgLK2CD/hCq1XmuB6opTPNCvLnOa5AuB2Cp32rh
 yDTM2tYr5uei/zvVnTyPeOjNaAj8iPSeku0VIF9nY/bh/rqrp/NY0bR3GDHh8HyiEiSH
 IEkLI0O9MWVZ9WYYkqfb24UcdZ7r3hPqaiqpqjfZRtW4dgvgMZj7OXxhbjnxcwOqKF0M DQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8t71u674-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 08:06:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 341861Xl014893
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 May 2023 08:06:01 GMT
Received: from [10.218.15.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 1 May 2023
 01:05:57 -0700
Message-ID: <1b1b095e-8fcb-37d5-7542-48a6b55f35a1@quicinc.com>
Date:   Mon, 1 May 2023 13:35:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] spi: spi-geni-qcom: Correct CS_TOGGLE bit in
 SPI_TRANS_CFG
Content-Language: en-CA
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <dianders@chromium.org>,
        <mka@chromium.org>, <swboyd@chromium.org>,
        <quic_vtanuku@quicinc.com>
References: <1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com>
 <9f28dbff-ca3a-8523-5bfc-37b38bc846c3@linaro.org>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <9f28dbff-ca3a-8523-5bfc-37b38bc846c3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oMGc0nYAz4LBa4rQNQfqvemHGOeJrTfq
X-Proofpoint-ORIG-GUID: oMGc0nYAz4LBa4rQNQfqvemHGOeJrTfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_02,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 phishscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010063
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/2023 7:15 PM, Konrad Dybcio wrote:
>
> On 4/25/23 09:42, Vijaya Krishna Nivarthi wrote:
>> The CS_TOGGLE bit when set is supposed to instruct FW to
>> toggle CS line between words. The driver with intent of
>> disabling this behaviour has been unsetting BIT(0). This has
>> not caused any trouble so far because the original BIT(1)
>> is untouched and BIT(0) likely wasn't being used.
>>
>> Correct this to prevent a potential future bug.
>>
>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>> ---
>
> Has this always been the case, or did the switch to BIT(1)
> only occur on some recent platforms?


Thank you very much for the review..

This has always been the case.

With intent of disabling CS_TOGGLE, currently, the driver is unsetting 
BIT(0), though it should have been BIT(1).

Yet no problem was encountered because

a) BIT(0) seems to be an unused bit

b) BIT(1) is probably already unset because its untouched

Further more, as Doug pointed we are mostly using GPIO for CS.


Testing with the change has not caused any regressions.


Thank you,

Vijay/



>
> Konrad
>
>>   drivers/spi/spi-geni-qcom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index ba7be50..8a7d1c2 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -35,7 +35,7 @@
>>   #define CS_DEMUX_OUTPUT_SEL    GENMASK(3, 0)
>>     #define SE_SPI_TRANS_CFG    0x25c
>> -#define CS_TOGGLE        BIT(0)
>> +#define CS_TOGGLE        BIT(1)
>>     #define SE_SPI_WORD_LEN        0x268
>>   #define WORD_LEN_MSK        GENMASK(9, 0)
