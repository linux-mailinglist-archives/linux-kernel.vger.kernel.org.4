Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A1D6E2301
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjDNMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjDNMTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B6B742;
        Fri, 14 Apr 2023 05:19:07 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EBqBpu020374;
        Fri, 14 Apr 2023 12:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0Z5TFjJbwYe7B5sjyIj8FGt4HdXqg1HWXeLZ6d93/fM=;
 b=eAHnGwiMJXI3RXTjeRJVaiXGVXOvguxX1+IbxP8n8y+qwBUX4xY1+5crd5cZrdS2DTfD
 vtf2DP9BwF/0csqI6yl49qHt5xDNa+a4W3l4K9gKKYzrtD5+lzFdrnKapx+Gb3Xz60M5
 rB2nAgYduwIuBdxoAzFlBllAti5j8fOJuRWsXHaJVXYs51lpd/T1bw1tvCFtxmlT1im7
 6+1w9ej3ytnA7QkBxmcAStrXy7bPSa+1G8CE/DRC0A14tu+1psEUIOqWy3DUBujBXGGh
 d9SAn2m8NkSrSV/NA4NqfOLe2gX/mhsoox9vinpmbSmKp7/6eVS8OXCM5NiArPIK65kw qA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxqf99sye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 12:18:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ECIrB4006099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 12:18:53 GMT
Received: from [10.216.25.10] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 05:18:46 -0700
Message-ID: <1c9110d4-ce71-c163-0301-3e309a0bb36e@quicinc.com>
Date:   Fri, 14 Apr 2023 17:48:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V3 2/9] clk: qcom: Add Global Clock controller (GCC)
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
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-3-git-send-email-quic_srichara@quicinc.com>
 <af41069c-add8-f0bf-1180-3e5c4da9d9dd@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <af41069c-add8-f0bf-1180-3e5c4da9d9dd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8GSGOLDRNwhPP_KJ98yfwIqdxAdYuuKy
X-Proofpoint-ORIG-GUID: 8GSGOLDRNwhPP_KJ98yfwIqdxAdYuuKy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_06,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 mlxlogscore=731 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140111
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 4:59 PM, Konrad Dybcio wrote:
> 
> 
> On 14.04.2023 12:29, Sricharan Ramabadhran wrote:
>> Add support for the global clock controller found on IPQ5018
>> based devices.
>>
>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Co-developed-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
>> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
> [...]
> 
>> +		.name = "adss_pwm_clk_src",
>> +		.parent_data = gcc_xo_gpll0,
>> +		.num_parents = 2,
> ARRAY_SIZE(), everywhere where you reference parent_data
> 
   ok.

> [...]
> 
>> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. GCC IPQ5018 Driver");
>> +MODULE_LICENSE("GPL v2");
> "GPL"

   ok, will fix.

Regards,
  Sricharan
