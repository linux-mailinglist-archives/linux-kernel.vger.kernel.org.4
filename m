Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CDF6762D0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 03:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjAUCFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 21:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjAUCFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 21:05:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAEF577CB;
        Fri, 20 Jan 2023 18:05:06 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30L24nXc020795;
        Sat, 21 Jan 2023 02:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=voRVYU954ppdQH2UbcgXO2RFr+Bpv5PYOKV2ddK1g8o=;
 b=Wdu7RTqToBvWFcjxJAGpz8k2/pi8mxH0io7QYiM4C09DSxkhWh0T9yGgFYd/UCY5I/cE
 CHqqADL/wDje3RtUSFouRbOXCDQtTgiEBlOxLWC1mzIg322BDtxl7AEvsMKmmgFJWTdO
 SNAy/fPrv3F48gd3ba8u+ITt7TRfbAgbODT9jQRBU6Ej/csUitzEKxv4Vnp9HoHu+wpX
 dwr8Y3WQDu3h6qflxcs5Zt1MxNevUEPyCJ68fLauR+EjhUaGXH4x84w7+L5NdYKgPei8
 DNpzaFNAWfTAlE5qoFk4Oy2MTMGt/sb8qSK4CWcLQBVg+cm+cmQFQaI/eN9G0+JeaFjz DA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n85dvr3cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 02:04:49 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30L24l2R008263
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 02:04:47 GMT
Received: from [10.110.21.68] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 20 Jan
 2023 18:04:46 -0800
Message-ID: <9879f1eb-e83a-406f-e9b3-517ad3ce6bf4@quicinc.com>
Date:   Fri, 20 Jan 2023 18:04:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v17 0/9] Coresight: Add support for TPDM and TPDA
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
 <70d32270-cd55-0c7e-2a3f-394b452ce532@arm.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <70d32270-cd55-0c7e-2a3f-394b452ce532@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 15MDj7G0UiomXe8smMYt_hI43ybMW--5
X-Proofpoint-ORIG-GUID: 15MDj7G0UiomXe8smMYt_hI43ybMW--5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_13,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=712
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301210017
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/2023 3:46 AM, Suzuki K Poulose wrote:
> On 17/01/2023 14:56, Mao Jinlong wrote:
>> This series adds support for the trace performance monitoring and
>> diagnostics hardware (TPDM and TPDA). It is composed of two major
>> elements.
>> a) Changes for original coresight framework to support for TPDM and TPDA.
>> b) Add driver code for TPDM and TPDA.
>>
> 
> 
> https://lore.kernel.org/r/20230120095301.30792-2-quic_jinlmao@quicinc.com
> 
>>    dt-bindings: arm: Adds CoreSight TPDA hardware definitions
>>    Documentation: trace: Add documentation for TPDM and TPDA
> 
> I have queued patches 1-8, to the coresight next branch.
> 
> https://git.kernel.org/coresight/c/758d638667d4
> 
>>    arm64: dts: qcom: sm8250: Add tpdm mm/prng
> 
> I assume this ^ would go in via soc tree.
> 

Bjorn, can you pick this patch in your tree?

---Trilok Soni
