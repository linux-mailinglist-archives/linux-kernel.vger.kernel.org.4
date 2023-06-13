Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA48E72E3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbjFMNQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbjFMNQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:16:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAFF196;
        Tue, 13 Jun 2023 06:16:52 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DAbVHs016390;
        Tue, 13 Jun 2023 13:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UhBYNPuW8adCTT9Igi1jCTMV9lLl1u6981Zie5OLaOI=;
 b=J2nX+Lo1BgT9z0OCqNCrbCoGaYJJjGStqn5/M5aJpPairm3BdCcGyEMeCW/+HHkIfZls
 s7OBMMlN9YEWtfulcg4TcX/xOKCreD51N0xydR2LmL6OAHFzpADpA83IO1Qkh2/MUOXF
 i6RVzBu5pWUJF72noLCr7+UvuhNtoBjzSvC7sfLASvDfRqK5D6ePMAWQQvVebPA46Vr9
 ItTlv7LXotFoSw/LGYq9c6lhU/4uGAkFn1JWwEtP/YLMr1Nrw1KTgNxR0gnAT+XZL5QS
 Xwcr4u+njWnnFHXZJ010SUrV1TiyA5P/wzQuR31fi267g1xJDT+m6DKAi+rQ0Yjv1sN9 1w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6n0cgjs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 13:16:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DDGRua031912
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 13:16:27 GMT
Received: from [10.201.3.182] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 06:16:22 -0700
Message-ID: <410b0991-30b6-c87d-9b25-5f51f6c08671@quicinc.com>
Date:   Tue, 13 Jun 2023 18:46:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 2/8] clk: qcom: Add Global Clock controller (GCC)
 driver for IPQ5018
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230510134121.1232286-1-quic_srichara@quicinc.com>
 <20230510134121.1232286-3-quic_srichara@quicinc.com>
 <21a5642c-e6e5-9323-7db1-383a18616ac0@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <21a5642c-e6e5-9323-7db1-383a18616ac0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: foWbv2MnEtUydER2G_D9pmII8xoZErGo
X-Proofpoint-ORIG-GUID: foWbv2MnEtUydER2G_D9pmII8xoZErGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=962 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130116
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On 5/27/2023 12:47 AM, Konrad Dybcio wrote:
> 
> 
> On 10.05.2023 15:41, Sricharan Ramabadhran wrote:
>> Add support for the global clock controller found on IPQ5018
>> based devices.
>>
>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Co-developed-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
>> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   [v4] Fixed to use ARRAY_SIZE() wherever parent_data was used
>>        Changed GPL v2 to GPL as per comments
>>
>>   drivers/clk/qcom/Kconfig       |   10 +-
>>   drivers/clk/qcom/Makefile      |    1 +
>>   drivers/clk/qcom/gcc-ipq5018.c | 3731 ++++++++++++++++++++++++++++++++
>>   3 files changed, 3740 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/clk/qcom/gcc-ipq5018.c
>>
> [...]
> 
>> +struct clk_rcg2 lpass_axim_clk_src = {
>> +	.cmd_rcgr = 0x2E028,
> Please use lowercase hex for non-macro-defines, all throughout the file.
> 

  ok. Will fix this in V10.

> [...]
> 
>> +static struct clk_rcg2 system_noc_bfdcd_clk_src = {
> Drop clocks that are managed in RPM, they will conflict.
> 

   IPQ5018 does not have RPM.

Regards,
  Sricharan
