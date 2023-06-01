Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7D171A02E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjFAOe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjFAOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:34:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B4F132;
        Thu,  1 Jun 2023 07:34:32 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351CcZTj017700;
        Thu, 1 Jun 2023 14:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Dj3Ia9nAboIB5WA/ndmHZF68f9djFRBZWCefDAbPmUc=;
 b=FUZAkV+Cr+HjsWRbCrK9JHFx4BmSkKgx6Ozpoi6DISgg+gNy3bUcpDDLR0IK8+VSSnIF
 g0JvIKNHdN57tem7nj3YkV/eFO7YongEqrLT0Uc1mDNh9fg2ARFj2sYlu1fuJHKwahEj
 nuiv37+KPCVnUUMlgU2ZsWef904s/DGgJNDoNB/r70/eOYTy1JoIcl1YgsjfnYTNpoHH
 IWuOdiwnd95Yml3Zw5gEnbPMp890u46N56v6JUkIsv2sbs9aea1QppeluCTISMmpy2CJ
 Ijus+V2ZrAnVdmePeeCm316wDopc8OcTNBi4rLjBfa5x63+o/0Yd5MLp0lQnnX1sWss5 Rg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugr89j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 14:34:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351EYL5H001212
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 14:34:21 GMT
Received: from [10.217.216.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 07:34:15 -0700
Message-ID: <45b9d22e-8c7e-53ac-5f99-3ee190a3a2e3@quicinc.com>
Date:   Thu, 1 Jun 2023 20:04:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V2 4/6] clk: qcom: camcc-sm8550: Add camera clock
 controller driver for SM8550
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230525172142.9039-1-quic_jkona@quicinc.com>
 <20230525172142.9039-5-quic_jkona@quicinc.com>
 <0ad16ac8-deac-41d3-9c36-885eb8be3fee@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <0ad16ac8-deac-41d3-9c36-885eb8be3fee@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j6sCAQFe2AkgMvU1wmRVDfnPgsWV0SLl
X-Proofpoint-ORIG-GUID: j6sCAQFe2AkgMvU1wmRVDfnPgsWV0SLl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 clxscore=1015 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=613 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010129
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On 5/27/2023 1:24 AM, Konrad Dybcio wrote:
> 
> 
> On 25.05.2023 19:21, Jagadeesh Kona wrote:
>> Add support for the camera clock controller for camera clients to be
>> able to request for camcc clocks on SM8550 platform.
>>
>> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
>> Changes since V1:
>>   - Sorted the PLL names in proper order
>>   - Updated all PLL configurations to lower case hex
>>   - Reused evo ops instead of adding new ops for ole pll
>>   - Moved few clocks to separate patch to fix patch too long error
> The patches end up in the maintainers' inboxes, so it's fine to send
> it as one.
> 
> Konrad
Okay, thanks for the info. This patch didn't make it to the patch list 
in V1, since the length is too long. So we split this into 2 patches
considering Dmitry's comments. Since we already split this patch, we 
would like to keep it this way, since it is coming properly in the patch 
list now.

>>
>>   drivers/clk/qcom/Kconfig        |    7 +
>>   drivers/clk/qcom/Makefile       |    1 +
>>   drivers/clk/qcom/camcc-sm8550.c | 3405 +++++++++++++++++++++++++++++++
>>   3 files changed, 3413 insertions(+)
>>   create mode 100644 drivers/clk/qcom/camcc-sm8550.c
>>

Thanks & Regards,
Jagadeesh
