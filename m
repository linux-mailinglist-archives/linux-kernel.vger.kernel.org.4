Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960B3702744
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjEOIc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjEOIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:32:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9839E12D;
        Mon, 15 May 2023 01:32:26 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F32J4l027752;
        Mon, 15 May 2023 08:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=31qlG62B100FzHux/VseUvydofig2BmNp+uWcXuYTqM=;
 b=a95lVBH7ybKpyiU4WzCAzXw2SKK9Wb+FarIBfHMFQnPI0sZAlccLFlNS8qhlGWg3V26L
 TbM9eM3MbScCo46PSSiOJlPsOH/5P2jGnrFJ57XN2mkeITEVXECQOVcLPYAdJ/O3avdt
 MtDFnpPPePnAAW46z5sWhnaq34EwqtH3aoqXmffwKJT5408rGRcLE8DHmsOaQUe9tGYB
 IMETdQnw7GkB1m7R4iBXRhy+czPrpvmItOwx6oBDbWmWTi9hXI9ReX5NDM5HksvfzETG
 ILky171WpqXBsYj3EClIY2izC+YAL8iTFnee64QDyY76zUSlODkCN61ZjiMdHewk5Rv+ /w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj257u3sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 08:32:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34F8WKMo005515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 08:32:21 GMT
Received: from [10.214.230.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 01:32:16 -0700
Message-ID: <257e11b5-29b5-78c6-882b-ec3bb64ee28b@quicinc.com>
Date:   Mon, 15 May 2023 14:02:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 04/10] nvmem: qfprom: Add support for secure reading on
 QDU1000/QRU1000
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-5-quic_kbajaj@quicinc.com>
 <68f9bee2-5a5b-2962-6c3d-e73ade371545@linaro.org>
 <CAA8EJppObh3h8sxB_f9SQy7EQ1Gfhe9EbzV=wsUbVNj9PtX=GA@mail.gmail.com>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <CAA8EJppObh3h8sxB_f9SQy7EQ1Gfhe9EbzV=wsUbVNj9PtX=GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e2FyqXZKg770d_sX7Q6RbS-823qodcBo
X-Proofpoint-GUID: e2FyqXZKg770d_sX7Q6RbS-823qodcBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_05,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 spamscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150073
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/2023 11:01 PM, Dmitry Baryshkov wrote:
> On Fri, 12 May 2023 at 20:01, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 12/05/2023 14:21, Komal Bajaj wrote:
>>> Add qfprom driver support for QDU1000/QRU1000 SOCs.
>>>
>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>> ---
>>>   drivers/nvmem/qfprom.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
>>> index 20662e2d3732..12a7981a8a71 100644
>>> --- a/drivers/nvmem/qfprom.c
>>> +++ b/drivers/nvmem/qfprom.c
>>> @@ -109,6 +109,10 @@ struct qfprom_soc_compatible_data {
>>>        bool secure;
>>>   };
>>>
>>> +static const struct qfprom_soc_compatible_data qdu1000_qfprom = {
>>> +     .secure = true
>>> +};
>>> +
>>>   static const struct nvmem_keepout sc7180_qfprom_keepout[] = {
>>>        {.start = 0x128, .end = 0x148},
>>>        {.start = 0x220, .end = 0x228}
>>> @@ -490,6 +494,7 @@ static int qfprom_probe(struct platform_device *pdev)
>>>
>>>   static const struct of_device_id qfprom_of_match[] = {
>>>        { .compatible = "qcom,qfprom",},
>>> +     { .compatible = "qcom,qdu1000-qfprom", .data = &qdu1000_qfprom},
>>>        { .compatible = "qcom,sc7180-qfprom", .data = &sc7180_qfprom},
>> I have doubts that this is still compatible with qcom,qfprom. It uses
>> entirely different read method. That's why generic fallbacks are bad,
>> one more case to my growing list of awesome examples. :)
Okay, will do that.
> Yes, it looks like it should be 'qcom,qdu1000-qfprom",
> "qcom,scm-qfprom". And possibly a separate driver for scm-qfprom.
The only difference here is in read method, which can be controlled by a 
single property,
do we really need to write a separate driver for just reading secure 
feature register.

Thanks,
Komal
>
>

